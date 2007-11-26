From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] best way to show diff of commit
Date: Mon, 26 Nov 2007 09:42:39 +0100
Message-ID: <20071126084239.GA23373@artemis.corp>
References: <20071125211831.GA21121@artemis.corp> <20071126002519.GA11133@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LQksG6bCIzRHxTLp";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 26 09:43:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZYU-0005gp-1Q
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 09:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbXKZImn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 03:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbXKZImn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 03:42:43 -0500
Received: from pan.madism.org ([88.191.52.104]:60359 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbXKZImm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 03:42:42 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C4078EE;
	Mon, 26 Nov 2007 09:42:40 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8A8822E33; Mon, 26 Nov 2007 09:42:39 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jan Hudec <bulb@ucw.cz>, Git ML <git@vger.kernel.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
Content-Disposition: inline
In-Reply-To: <20071126002519.GA11133@efreet.light.src>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66054>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 12:25:19AM +0000, Jan Hudec wrote:
> On Sun, Nov 25, 2007 at 22:18:31 +0100, Pierre Habouzit wrote:
> >   My question is: what do you think is the best way to do that, and
> > where ?
>=20
> Are you talking about the ftplugins/git.vim script from vim-scripts packa=
ge,
> right?

  Yes, its author.

> All it needs to do is call 'git diff --cached'. The below patch seems to =
work
> here (tried commit, commit -a, commit --amend, commit -a --amend and comm=
it
> from subdirectory and they seemed to all work).

  Damn if that's so simple, I really feel like a big fool now.

> >   [0] the issue with this approach is that it's completely broken in
> >       amending mode (does not shows the proper thing), and the generated
>=20
> I didn't find any issue with amending mode (showed incremental diff for me
> all right). The problem was when a file was being touched by the commit b=
ut
> work tree had unstaged changes. Such changes were shown when they shouldn=
't.

  Yep, that's the point.

> >       diffs aren't excellent, because as an editor plugin, it's hard to
> >       treat renames and copies easily, so I generate really really nasty
> >       diffs in that case too.
>=20
> With --cached, detecting copies is just a matter of adding -C. In the pat=
ch
> below I added only one -C, but it should probably be user-configurable to=
 use
> no, one or two (equivalent of --find-copies-harder).

  Sure, I'll do that obviously.

  Thanks a lot for the tip.
>=20
> --=20
> 						 Jan 'Bulb' Hudec <bulb@ucw.cz>
>=20
> ---8<---
> --- vim-scripts/ftplugin/git.vim.orig	2007-07-24 09:46:19.000000000 +0200
> +++ vim-scripts/ftplugin/git.vim	2007-11-26 01:01:59.000000000 +0100
> @@ -14,41 +14,6 @@
>  "{{{ function Git_diff_windows
> =20
>  function! Git_diff_windows(vertsplit, auto)
> -    let i =3D 0
> -    let list_of_files =3D ''
> -
> -    " drop everything until '#  (will commit)' and the next empty line
> -    while i <=3D line('$')
> -        let line =3D getline(i)
> -        if line =3D=3D '# Changes to be committed:'
> -            let i =3D i + 3
> -            break
> -        endif
> -
> -        let i =3D i + 1
> -    endwhile
> -
> -    " read file names until we have EOF or an empty line
> -    while i <=3D line('$')
> -        let line =3D getline(i)
> -        if line =3D~ '^#\s*[a-z ]*:.*->.*$'
> -            let file =3D substitute(line, '^#[^:]*:.*->\s*\(.*\)\s*$', '=
\1', '')
> -            let list_of_files =3D list_of_files . ' '.file
> -            let file =3D substitute(line, '^#[^:]*:\s*\(.*\)\s*->.*$', '=
\1', '')
> -            let list_of_files =3D list_of_files . ' '.file
> -        elseif line =3D~ '^#\s*[a-z ]*:'
> -            let file =3D substitute(line, '^#[^:]*:\s*\(.*\)\s*$', '\1',=
 '')
> -            let list_of_files =3D list_of_files . ' '.file
> -        elseif line =3D~ '^#\s*$'
> -            break
> -        endif
> -
> -        let i =3D i + 1
> -    endwhile
> -
> -    if list_of_files =3D=3D ""
> -        return
> -    endif
> =20
>      if a:vertsplit
>          rightbelow vnew
> @@ -56,15 +21,8 @@
>          rightbelow new
>      endif
>      silent! setlocal ft=3Ddiff previewwindow bufhidden=3Ddelete nobackup=
 noswf nobuflisted nowrap buftype=3Dnofile
> -    let gitDir =3D system('git rev-parse --git-dir 2>/dev/null')
> -    let gitDir =3D substitute(gitDir, '.git\n', '', '')
> -    let wd =3D getcwd()
> -    if gitDir !=3D ''
> -        exe 'cd '.gitDir
> -    endif
> -    exe 'normal :r!LANG=3DC git diff HEAD -- ' . list_of_files . "\n1Gdd"
> -    exe 'normal :r!LANG=3DC git diff --stat HEAD -- ' . list_of_files . =
"\no\<esc>1GddO\<esc>"
> -    exe 'cd '.wd
> +    exe "normal :r!LANG=3DC git diff --cached -C\n1Gdd"
> +    exe "normal :r!LANG=3DC git diff --stat --cached -C\no\<esc>1GddO\<e=
sc>"
>      setlocal nomodifiable
>      noremap <buffer> q :bw<cr>
>      if a:auto

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHSob/vGr7W6HudhwRAj5jAJ9Ww4RRCi/A/ArowUfOw3bLYPEfjwCfcusq
+kWm8vIS2ek6nkDrQhul1/w=
=o0rX
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
