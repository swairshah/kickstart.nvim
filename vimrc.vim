call plug#begin()
  Plug 'ncm2/ncm2'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'ziglang/zig.vim'
  Plug 'jpalardy/vim-slime', { 'for': ['python', 'julia', 'scheme']}
  Plug 'mroavi/vim-julia-cell', { 'for': 'julia' }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ellisonleao/gruvbox.nvim',
  Plug 'rebelot/kanagawa.nvim',
  Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}
let g:slime_dont_ask_default = 1
let g:slime_paste_file = "$HOME/.slime_paste"


inoremap <Tab> <C-R>=SmartTab()<CR>

set sw=4
set tabstop=4
set softtabstop=4
set smarttab

function! SmartTab()
    let col = col('.') - 1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-P>"
    endif
endfunction


au FileType java call SetWorkspaceFolders()

function! SetWorkspaceFolders() abort
    " Only set g:WorkspaceFolders if it is not already set
    if exists("g:WorkspaceFolders") | return | endif

    if executable("findup")
        let l:ws_dir = trim(system("cd '" . expand("%:h") . "' && findup packageInfo"))
        " Bemol conveniently generates a '$WS_DIR/.bemol/ws_root_folders' file, so let's leverage it
        let l:folders_file = l:ws_dir . "/.bemol/ws_root_folders"
        if filereadable(l:folders_file)
            let l:ws_folders = readfile(l:folders_file)
            let g:WorkspaceFolders = filter(l:ws_folders, "isdirectory(v:val)")
        endif
    endif
endfunction

autocmd BufRead,BufNewFile *.jl :set filetype=julia

colorscheme kanagawa-dragon

set guifont=Hack\ Nerd\ Font\ Mono
set encoding=UTF-8
