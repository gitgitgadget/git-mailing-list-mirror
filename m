From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Extremely simple Vim interface for Git
Date: Sun, 7 Sep 2008 20:46:50 +0300
Message-ID: <20080907174650.GA3404@mithlond.arda.local>
References: <20080906193744.GA3122@mithlond.arda.local> <d2e97e800809070332t35e4ed46u7af4653ea768b39b@mail.gmail.com> <20080907131356.GC3387@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:48:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcOMh-0008V5-Jl
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbYIGRqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbYIGRqx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:46:53 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:59986 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322AbYIGRqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:46:53 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 488DC54E01E15338; Sun, 7 Sep 2008 20:46:50 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KcOLa-00016U-8h; Sun, 07 Sep 2008 20:46:50 +0300
Content-Disposition: inline
In-Reply-To: <20080907131356.GC3387@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95159>

Teemu Likonen wrote (2008-09-07 16:13 +0300):

> > Then Vim will apply diff syntax highlighting to the scratch buffer
> > when a "diff" command is executed.
> 
> Good idea. I implemented the same thing this way:
> 
>     if match(a:cmdline,'\v^(git|hg|svn|bzr) diff') >= 0
>         setlocal filetype=diff
>     endif

Or even better, detect by the content:

    if search('\m\C^--- .*\n+++ .*\n@@','n')
        setlocal filetype=diff
    endif

It works with things like "git show" and "git log -p" too. Here's 
updated version for those who are interested:

    command! -complete=file -nargs=* Git call s:RunShellCommand('git '.<q-args>)

    " To run any shell command:
    "command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

    " Additional $VCS commands:
    "command! -complete=file -nargs=* Hg call s:RunShellCommand('hg '.<q-args>)
    "command! -complete=file -nargs=* Svn call s:RunShellCommand('svn '.<q-args>)
    "command! -complete=file -nargs=* Bzr call s:RunShellCommand('bzr '.<q-args>)

    " In case a shell command wants to open $EDITOR we use something
    " that works from inside Vim.
    let $EDITOR = '/usr/bin/gvim --nofork'

    function! s:RunShellCommand(cmdline)
        botright new
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
        call setline(1,a:cmdline)
        call setline(2,substitute(a:cmdline,'.','=','g'))
        execute 'silent $read !'.escape(a:cmdline,'()%#')
        setlocal nomodifiable
        if search('\m\C^--- .*\n+++ .*\n@@','n')
            setlocal filetype=diff
        endif
        1
    endfunction
