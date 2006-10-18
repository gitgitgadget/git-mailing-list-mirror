From: Jeff King <peff@peff.net>
Subject: Re: Make the ftplugin right wrt gitdir
Date: Wed, 18 Oct 2006 05:46:51 -0400
Message-ID: <20061018094651.GA19907@coredump.intra.peff.net>
References: <11611319762395-git-send-email-madcoder@debian.org> <200610181010.59995.madcoder@debian.org> <20061018090231.GA18807@coredump.intra.peff.net> <200610181107.56260.madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 11:47:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga80o-0004JW-Gr
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWJRJqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 05:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWJRJqy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:46:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3243 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750990AbWJRJqy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 05:46:54 -0400
Received: (qmail 8107 invoked from network); 18 Oct 2006 05:46:51 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Oct 2006 05:46:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2006 05:46:51 -0400
To: Pierre Habouzit <madcoder@debian.org>
Content-Disposition: inline
In-Reply-To: <200610181107.56260.madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29215>

On Wed, Oct 18, 2006 at 11:07:54AM +0200, Pierre Habouzit wrote:

> well the result file is here: 
> http://madism.org/~madcoder/dotfiles/vim/ftplugin/git.vim

I was able to grab it...my comments are below.

>  if exists("b:did_ftplugin")
>    finish
>  endif
>  
>  let b:did_ftplugin = 1
>  
>  setlocal tw=74
>  setlocal nowarn nowb

Do things like tw really have anything to do with the ftplugin?
Shouldn't they instead go into the user's vimrc?

>  "{{{ function Git_diff_windows
>  
>  function! Git_diff_windows(vertsplit, auto)
>      let i = 0
>      let list_of_files = ''
>  
>      " drop everything until '#  (will commit)' and the next empty line
>      while i <= line('$')
>          let line = getline(i)
>          if line =~ '^#\s*(will commit)$'
>              let i = i + 2
>              break
>          endif
>  
>          let i = i + 1
>      endwhile
>  
>      " read file names until we have EOF or an empty line
>      while i <= line('$')
>          let line = getline(i)
>          if line =~ '^#\s*[a-z ]*:.*->.*$'
>              let file = substitute(line, '\v^#[^:]*:.*->\s*(.*)\s*$', '\1', '')
>              let list_of_files = list_of_files . ' '.file
>              let file = substitute(line, '\v^#[^:]*:\s*(.*)\s*->.*$', '\1', '')
>              let list_of_files = list_of_files . ' '.file
>          elseif line =~ '^#\s*[a-z ]*:'
>              let file = substitute(line, '\v^#[^:]*:\s*(.*)\s*$', '\1', '')
>              let list_of_files = list_of_files . ' '.file
>          elseif line =~ '^#\s*$'
>              break
>          endif
>  
>          let i = i + 1
>      endwhile
>  
>      if list_of_files == ""
>          return
>      endif
>  
>      if a:vertsplit
>          rightbelow vnew
>      else
>          rightbelow new
>      endif

This all looks OK to me, but then I don't really know vim script very
well. :)

>      silent! setlocal ft=diff previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
>      let gitDir = system('git rev-parse --git-dir 2>/dev/null')
>      let gitDir = substitute(gitDir, '.git\n', '', '')
>      let wd = getcwd()
>      if gitDir != ''
>          exe 'cd '.gitDir
>      endif
>      exe 'normal :r!LANG=C git diff HEAD -- ' . list_of_files . "\n1Gdd"
>      exe 'normal :r!LANG=C git diff HEAD -- ' . list_of_files . " \| git apply --stat\no\<esc>1GddO\<esc>"
>      exe 'cd '.wd
>      setlocal nomodifiable

This procedure seems a bit hack-ish and fragile. I think the chdir is
necessary not just to handle autochdir, but also because we want to do
any diff from the top-level instead of a subdir. Why do we
unconditionally set LANG=C? What about quoting for the file list?

In general, is this really that much nicer than simply using the '-v'
flag to git-commit?

>  if g:git_diff_spawn_mode == 1
>      call Git_diff_windows(0, 1)
>  elseif g:git_diff_spawn_mode == 2
>      call Git_diff_windows(1, 1)
>  endif

This should probably handle the case where g:git_diff_spawn_mode is not
defined (otherwise vim complains loudly):
  if exists("g:git_diff_spawn_mode")
     " do nothing
  elseif g:git_diff_spawn_mode == 1
etc.

-Peff
