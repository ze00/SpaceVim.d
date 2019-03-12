" dark_powered.vim --- Dark powered mode of SpaceVim
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

" User Defined: {{{
let s:username = "ze00"
let s:email = "zerozakiGeek@gmail.com"
silent let s:env = trim(system("which env"))
silent let s:python = s:env . " " . "python3"
silent let s:bash = s:env . " " . "bash"
function! AddshTitle()
  call setline(line("$"),"#!" . s:bash)
  call appendbufline(bufname(""), line("$"), "#File   : " . expand("%"))
  call appendbufline(bufname(""), line("$"), "#Project: ")
  call appendbufline(bufname(""), line("$"), "#Author : " . s:username)
  call appendbufline(bufname(""), line("$"), "#Email  : " . s:email)
  call appendbufline(bufname(""), line("$"), "#Date   : " . strftime("%Y-%m-%d"))
endf
function! AddCTitle()
  call setline(line("$"), " /*")
  call appendbufline(bufname(""), line("$"), "  * File    : " . expand("%"))
  call appendbufline(bufname(""), line("$"), "  * Project :")
  call appendbufline(bufname(""), line("$"), "  * Author  : " . s:username)
  call appendbufline(bufname(""), line("$"), "  * Email   : " . s:email)
  call appendbufline(bufname(""), line("$"), "  * Date    : " . strftime("%Y-%m-%d"))
  call appendbufline(bufname(""), line("$"), "  * Module  : ")
  call appendbufline(bufname(""), line("$"), "  * License : MIT")
  call appendbufline(bufname(""), line("$"), "  */")
endf
function! AddMkTitle()
  call setline(line("$"), "#File   : " . expand("%"))
  call appendbufline(bufname(""), line("$"), "#Project:")
  call appendbufline(bufname(""), line("$"), "#Author : " . s:username)
  call appendbufline(bufname(""), line("$"), "#Email  : " . s:email)
  call appendbufline(bufname(""), line("$"), "#Date   : " . strftime("%Y-%m-%d"))
endf

function! AddPyTitle()
  call setline(line("$"), "#!" . s:python)
  call appendbufline(bufname(""), line("$"), "#-*- coding: utf-8 -*-")
  call appendbufline(bufname(""), line("$"), "\"\"\"")
  call appendbufline(bufname(""), line("$"), "File    : " . expand("%"))
  call appendbufline(bufname(""), line("$"), "Project :")
  call appendbufline(bufname(""), line("$"), "Author  : " . s:username)
  call appendbufline(bufname(""), line("$"), "Email   : " . s:email)
  call appendbufline(bufname(""), line("$"), "Date    : " . strftime("%Y-%m-%d"))
  call appendbufline(bufname(""), line("$"), "\"\"\"")
endf
function! AddCHeadersTitle()
  call AddCTitle()
  let macroName=toupper(tr(expand("%"), "./", "__"))
  call appendbufline(bufname(""), line("$"), "#ifndef ".macroName)
  call appendbufline(bufname(""), line("$"), "#define ".macroName)
  call appendbufline(bufname(""), line("$"), "")
  call appendbufline(bufname(""), line("$"), "#endif // ".macroName)
endf
func! myspacevim#before() abort

  autocmd BufNewFile *.py exec ":call AddPyTitle()"
  autocmd BufNewFile *.h,*.hpp exec ":call AddCHeadersTitle()"
  autocmd BufNewFile *.sh exec ":call AddshTitle()"
  autocmd BufNewFile *.c,*.cc,*.cpp exec ":call AddCTitle()"
  autocmd BufNewFile *.mk,[Mm]akefile exec ":call AddMkTitle()"
  au BufWritePost * if getline(1) =~ "^#!" | silent !chmod a+x <afile>
endf
func! myspacevim#after() abort
  set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
  set helplang=cn
  set encoding=utf8 
  set langmenu=zh_CN.UTF-8
  set wrap
  set mouse=ivn
  set selection=exclusive
  set selectmode=mouse,key
  set nolinebreak
endf
" }}}
