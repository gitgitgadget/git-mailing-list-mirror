From: "Peter Baumann" <peter.baumann@gmail.com>
Subject: Re: [PATCH] nice ftplugin for vim, that shows the commited diff in a split'ed buffer.
Date: Tue, 17 Oct 2006 10:22:47 +0200
Message-ID: <802d21790610170122j6191ba51l2c39d3bc6a3475b@mail.gmail.com>
References: <11610450702261-git-send-email-madcoder@debian.org>
	 <11610450701082-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 17 10:23:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZkDt-0003P8-OW
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 10:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423154AbWJQIWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 04:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423156AbWJQIWu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 04:22:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:55276 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423154AbWJQIWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 04:22:49 -0400
Received: by nf-out-0910.google.com with SMTP id c2so215155nfe
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 01:22:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IG6rvjsFdRB34vD+IpAXdVzwKZXz9uajKL6fMCc1cxQpY6HYwQe4AX+HqN0cE6BIe5Kxw8jUSMRjqkpEgAilcpc13KqCK90gYupvn8EhC6wuNgHbZ78DoO6d+FAv2LoDoLvcPCEGntQmGiL0HcJB4+2AielscKJ1FTwGdmdn5Ng=
Received: by 10.78.94.37 with SMTP id r37mr9040547hub;
        Tue, 17 Oct 2006 01:22:47 -0700 (PDT)
Received: by 10.78.203.14 with HTTP; Tue, 17 Oct 2006 01:22:47 -0700 (PDT)
To: "Pierre Habouzit" <madcoder@debian.org>
In-Reply-To: <11610450701082-git-send-email-madcoder@debian.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29033>

2006/10/17, Pierre Habouzit <madcoder@debian.org>:
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  contrib/vim/README                 |    6 ++++
>  contrib/vim/ftplugin/gitcommit.vim |   61 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/vim/README b/contrib/vim/README
> index 9e7881f..26c1682 100644
> --- a/contrib/vim/README
> +++ b/contrib/vim/README
> @@ -6,3 +6,9 @@ To syntax highlight git's commit message
>       $ cat >>$HOME/.vimrc <<'EOF'
>       autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
>       EOF
> +
> +To use the fancy split-view with the currently commited diff, you need to:
> +  1. Copy ftplugin/gitcommit.vim to vim's ftplugin directory:
> +     $ mkdir -p $HOME/.vim/ftplugin
> +     $ cp ftplugin/gitcommit.vim $HOME/.vim/ftplugin
> +  2. Auto-detect the editing of git commit files (see above).
> diff --git a/contrib/vim/ftplugin/gitcommit.vim b/contrib/vim/ftplugin/gitcommit.vim
> new file mode 100644
> index 0000000..f9efd59
> --- /dev/null
> +++ b/contrib/vim/ftplugin/gitcommit.vim
> @@ -0,0 +1,61 @@
> +if exists("b:did_ftplugin")
> +  finish
> +endif
> +
> +let b:did_ftplugin = 1
> +
> +setlocal tw=74
> +setlocal nowarn nowb
> +
> +"{{{ function Git_diff_windows
> +
> +function! Git_diff_windows()
> +    let i = 0
> +    let list_of_files = ''
> +
> +    " drop everything until '#  (will commit)' and the next empty line
> +    while i <= line('$')
> +        let line = getline(i)
> +        if line =~ '^#\s*(will commit)$'
> +            let i = i + 2
> +            break
> +        endif
> +
> +        let i = i + 1
> +    endwhile
> +
> +    " read file names until we have EOF or an empty line
> +    while i <= line('$')
> +        let line = getline(i)
> +        if line =~ '^#\s*[a-z ]*:.*->.*$'
> +            let file = substitute(line, '\v^#[^:]*:.*->\s*(.*)\s*$', '\1', '')
> +            let list_of_files = list_of_files . ' '.file
> +            let file = substitute(line, '\v^#[^:]*:\s*(.*)\s*->.*$', '\1', '')
> +            let list_of_files = list_of_files . ' '.file
> +        elseif line =~ '^#\s*[a-z ]*:'
> +            let file = substitute(line, '\v^#[^:]*:\s*(.*)\s*$', '\1', '')
> +            let list_of_files = list_of_files . ' '.file
> +        elseif line =~ '^#\s*$'
> +            break
> +        endif
> +
> +        let i = i + 1
> +    endwhile
> +
> +    if list_of_files == ""
> +        return
> +    endif
> +
> +    rightbelow vnew

I find it confusing that you split vertically, especially if I work in
 small terminals.
I would prefere a horizontal split, thats why I changed it to the way
to the way it is
handled in the svn.vim commit case:

below new

> +    silent! setlocal ft=diff previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
> +    exe 'normal :r!LANG=C cd ..; git diff HEAD -- ' . list_of_files . "\n1Gdd"
> +    exe 'normal :r!LANG=C cd ..; git diff HEAD -- ' . list_of_files . " \| git apply --stat\no\<esc>1GddO\<esc>"

Why changing directory? I had to remove the cd .. to make it work. Otherwise
git diff couldn't find the repository.

Greetings,
  Peter
