From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Zsh completion regression
Date: Sat, 14 Jan 2012 14:23:43 +0100
Message-ID: <20120114132343.GW30469@goldbirke>
References: <1kdr5xk.1sopzul1hygnbrM%lists@haller-berlin.de>
	<vpq62ghj7fn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jan 14 14:23:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm3aO-0006RH-HD
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 14:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab2ANNXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 08:23:51 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:55403 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab2ANNXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 08:23:50 -0500
Received: from localhost6.localdomain6 (p5B130AF3.dip0.t-ipconnect.de [91.19.10.243])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LZYWu-1SXGN92MMG-00lV8I; Sat, 14 Jan 2012 14:23:43 +0100
Content-Disposition: inline
In-Reply-To: <vpq62ghj7fn.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:lQYh72XxImBN3Oqmc1cqJfkPcVvW/z8VpK5+IKl/4Fg
 NzJSzipilgbuePEUDZfh9kgklDpNHoEtk2OH1bknnAvSMF/ouX
 V/lyp029GE2LlYUCcDhcpZb2V49uUA9XWDZldGVooiMw1fuNub
 /Sjn6H7O1jNqnO8NbJLHOyGjQt7XPYEq78y2Ds8FJGBmxLPjni
 QPGL+0BxJk1hWvtQKFT3nvh/0vS+6dw6QGp2lh7Q8YRN57UoW3
 TOQt6MSyjQQoOS4Cjct7VbgpqXGyKySWGgLPM3AsBQUIoND9fX
 3+WqSiEZbzL8rufEq2rrcUnFd0K1RdtoL3o54bk9KCXUDr1Jgg
 CIjAh4omNax6mGA74l1s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188567>

Hi,


On Thu, Jan 12, 2012 at 03:56:28PM +0100, Matthieu Moy wrote:
> lists@haller-berlin.de (Stefan Haller) writes:
>=20
> > I'm using zsh   4.3.11.
> >
> > When I type "git log mas<TAB>", it completes to "git log master\ " =
(a
> > backslash, a space, and then the cursor).

Stefan, thanks for reporting and bisecting.

> The following patch makes the situation better, but is not really a f=
ix:
>=20
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -525,7 +525,7 @@ __gitcomp ()
>  __gitcomp_nl ()
>  {
>         local s=3D$'\n' IFS=3D' '$'\t'$'\n'
> -       local cur_=3D"$cur" suffix=3D" "
> +       local cur_=3D"$cur" suffix=3D""
> =20
>         if [ $# -gt 2 ]; then
>                 cur_=3D"$3"
>=20
> With this, the trailing space isn't added,

Yeah, this would be a regression for Bash users, because then they
will need to manually append that space.

> but e.g. "git checkout
> master<TAB>" does not add the trailing space, at all.

I'm not sure what you mean; did you got a trailing space after
'master<TAB>' before a31e6262 (completion: optimize refs completion,
2011-10-15)?
I'm not a zsh user myself, but just tried it and found that in
a31e626^ 'git checkout master<TAB>' doesn't add the trailing space,
and neither does 'git checkout mas<TAB>', which is in sync with what
Stefan reported ("Before this commit, I get "git log master" (with no
space at the end).").

> The problem is a little bit below:
>=20
> 	IFS=3D$s
> 	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
>=20
> The -S "$suffix" adds a space to the completion, but ZSH escapes the
> space (which sounds sensible in general, but is not at all what we
> expect).

So it seems we have two issues here with zsh:

- Spaces appended with 'compgen -S " "' in __gitcomp_nl() are quoted.
  This is the regression caused by a31e6262.
- Spaces appended in __gitcomp_1() (by echo "$word ") are stripped.
  This is a long-standing issue; if those spaces weren't stripped, the
  quoting issue would have been noted earlier, I suspect.

We could fix the regression by not appending a space suffix to
completion words in __gitcomp_nl(), but only when the completion
script is running under zsh to avoid hurting bash users, like this:

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2d02a7f3..49393243 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -601,6 +601,9 @@ __gitcomp_nl ()
 			suffix=3D"$4"
 		fi
 	fi
+	if [ -n "${ZSH_VERSION-}" ] && [ "$suffix" =3D " " ]; then
+		suffix=3D""
+	fi
=20
 	IFS=3D$s
 	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))


Although it wouldn't append a space at all for zsh users, that's
nothing new, it's just restoring old behavior.  And then later someone
more knowledgable about the quirks of zsh's completion and in
particular zsh's bash completion emulation can come up with a proper
fix to the issue of quoted spaces and stripped trailing spaces.


However.

While playing around with zsh, I noticed that git completion works
without even sourcing git's bash completion script.  As it turned out,
zsh ships its own git completion script[1], and from my cursory tests
it seems to be quite capable: it supports commands, aliases, options,
refs, ref1..ref2, config variables, ...  and I also saw a __git_ps1()
equivalent for zsh.

So, is there any reason why you are still using git's bash completion
under zsh (which has some quirks and lacks some features) instead of
zsh's own?  Perhaps it would make sense to point zsh users to zsh's
git completion and drop zsh compatibility from git's bash completion.
We did similar with vim config files: git included a vim syntax
highlight config file for commit messages under contrib/vim/, but
eventually we dropped it after vim started shipping more capable
git-specific config files (for git config files, rebase instruction
sheets, etc.).


[1] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dblob;=
f=3DCompletion/Unix/Command/_git;hb=3DHEAD


Best,
G=E1bor
