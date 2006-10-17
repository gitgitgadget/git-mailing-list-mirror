From: "Peter Baumann" <peter.baumann@gmail.com>
Subject: Re: [PATCH] nice ftplugin for vim, that shows the commited diff in a split'ed buffer.
Date: Tue, 17 Oct 2006 12:59:53 +0200
Message-ID: <802d21790610170359v3f17438dn8009ae9a55b2405c@mail.gmail.com>
References: <11610450702261-git-send-email-madcoder@debian.org>
	 <11610450701082-git-send-email-madcoder@debian.org>
	 <802d21790610170122j6191ba51l2c39d3bc6a3475b@mail.gmail.com>
	 <200610171238.04372.madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 17 13:00:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZmfv-0004Am-Ku
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 13:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423038AbWJQK74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 06:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423041AbWJQK74
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:59:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:3825 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423038AbWJQK7z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 06:59:55 -0400
Received: by nf-out-0910.google.com with SMTP id c2so258975nfe
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 03:59:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c2RlE0Q6OCRcD6rrEML5OQ2Gi/S/kDoCw/Hfb6sNasKB2Te9+H2HWTSow7z1duQ8ffpJhcedkQhx2HWzFrm5mLvcnJCQSZ/MhHFEin+VUNYBZ4QJ4cckYdbSX15poBDE1dARogdLfjMDhAbvMsGbczAdI8B1YTr2I9Bwmel4ztw=
Received: by 10.78.201.10 with SMTP id y10mr9156606huf;
        Tue, 17 Oct 2006 03:59:53 -0700 (PDT)
Received: by 10.78.203.14 with HTTP; Tue, 17 Oct 2006 03:59:53 -0700 (PDT)
To: "Pierre Habouzit" <madcoder@debian.org>
In-Reply-To: <200610171238.04372.madcoder@debian.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29056>

2006/10/17, Pierre Habouzit <madcoder@debian.org>:
> Le mar 17 octobre 2006 10:22, Peter Baumann a =E9crit :
> > 2006/10/17, Pierre Habouzit <madcoder@debian.org>:
> > > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > > ---
> > >  contrib/vim/README                 |    6 ++++
> > >  contrib/vim/ftplugin/gitcommit.vim |   61
> > > ++++++++++++++++++++++++++++++++++++ 2 files changed, 67
> > > insertions(+), 0 deletions(-)
> > >
> > > diff --git a/contrib/vim/README b/contrib/vim/README
> > > index 9e7881f..26c1682 100644
> > > --- a/contrib/vim/README
> > > +++ b/contrib/vim/README
> > > @@ -6,3 +6,9 @@ To syntax highlight git's commit message
> > >       $ cat >>$HOME/.vimrc <<'EOF'
> > >       autocmd BufNewFile,BufRead COMMIT_EDITMSG set
> > > filetype=3Dgitcommit EOF
> > > +
> > > +To use the fancy split-view with the currently commited diff, yo=
u
> > > need to: +  1. Copy ftplugin/gitcommit.vim to vim's ftplugin
> > > directory: +     $ mkdir -p $HOME/.vim/ftplugin
> > > +     $ cp ftplugin/gitcommit.vim $HOME/.vim/ftplugin
> > > +  2. Auto-detect the editing of git commit files (see above).
> > > diff --git a/contrib/vim/ftplugin/gitcommit.vim
> > > b/contrib/vim/ftplugin/gitcommit.vim new file mode 100644
> > > index 0000000..f9efd59
> > > --- /dev/null
> > > +++ b/contrib/vim/ftplugin/gitcommit.vim
> > > @@ -0,0 +1,61 @@
> > > +if exists("b:did_ftplugin")
> > > +  finish
> > > +endif
> > > +
> > > +let b:did_ftplugin =3D 1
> > > +
> > > +setlocal tw=3D74
> > > +setlocal nowarn nowb
> > > +
> > > +"{{{ function Git_diff_windows
> > > +
> > > +function! Git_diff_windows()
> > > +    let i =3D 0
> > > +    let list_of_files =3D ''
> > > +
> > > +    " drop everything until '#  (will commit)' and the next empt=
y
> > > line +    while i <=3D line('$')
> > > +        let line =3D getline(i)
> > > +        if line =3D~ '^#\s*(will commit)$'
> > > +            let i =3D i + 2
> > > +            break
> > > +        endif
> > > +
> > > +        let i =3D i + 1
> > > +    endwhile
> > > +
> > > +    " read file names until we have EOF or an empty line
> > > +    while i <=3D line('$')
> > > +        let line =3D getline(i)
> > > +        if line =3D~ '^#\s*[a-z ]*:.*->.*$'
> > > +            let file =3D substitute(line,
> > > '\v^#[^:]*:.*->\s*(.*)\s*$', '\1', '') +            let
> > > list_of_files =3D list_of_files . ' '.file
> > > +            let file =3D substitute(line,
> > > '\v^#[^:]*:\s*(.*)\s*->.*$', '\1', '') +            let
> > > list_of_files =3D list_of_files . ' '.file
> > > +        elseif line =3D~ '^#\s*[a-z ]*:'
> > > +            let file =3D substitute(line, '\v^#[^:]*:\s*(.*)\s*$=
',
> > > '\1', '') +            let list_of_files =3D list_of_files . ' '.=
file
> > > +        elseif line =3D~ '^#\s*$'
> > > +            break
> > > +        endif
> > > +
> > > +        let i =3D i + 1
> > > +    endwhile
> > > +
> > > +    if list_of_files =3D=3D ""
> > > +        return
> > > +    endif
> > > +
> > > +    rightbelow vnew
> >
> > I find it confusing that you split vertically, especially if I work
> > in small terminals.
> > I would prefere a horizontal split, thats why I changed it to the w=
ay
> > to the way it is
> > handled in the svn.vim commit case:
> >
> > below new
> >
> > > +    silent! setlocal ft=3Ddiff previewwindow bufhidden=3Ddelete
> > > nobackup noswf nobuflisted nowrap buftype=3Dnofile +    exe 'norm=
al
> > > :r!LANG=3DC cd ..; git diff HEAD -- ' . list_of_files . "\n1Gdd" =
+
> > > exe 'normal :r!LANG=3DC cd ..; git diff HEAD -- ' . list_of_files=
 . "
> > > \| git apply --stat\no\<esc>1GddO\<esc>"
> >
> > Why changing directory? I had to remove the cd .. to make it work.
> > Otherwise git diff couldn't find the repository.
>
> because for me, wherever I'm from, the cwd is .git/ but it's maybe du=
e
> to the fact that I use autochdir, I don't know.
>

Wouldn't it make sense to use something like 'git-rev-parse --git-dir' =
or
'git-rev-parse --show-cdup' to get to the root of the repository?

Greetings,
  Peter
