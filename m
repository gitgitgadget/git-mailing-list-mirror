From: Alex Chiang <achiang@hp.com>
Subject: Re: [StGit PATCH] teach --summary to stg show
Date: Fri, 10 Jul 2009 12:56:29 -0600
Message-ID: <20090710185629.GA19324@ldl.fc.hp.com>
References: <20090619050653.GD21764@ldl.fc.hp.com> <b0943d9e0907100311n26af2e86j95cae2200298ff68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kha@treskal.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 20:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPLH2-0004DT-TL
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 20:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbZGJS4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 14:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbZGJS4a
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 14:56:30 -0400
Received: from g4t0015.houston.hp.com ([15.201.24.18]:25870 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbZGJS4a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 14:56:30 -0400
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id 0719E8538;
	Fri, 10 Jul 2009 18:56:30 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g1t0038.austin.hp.com (Postfix) with ESMTP id 90F9230027;
	Fri, 10 Jul 2009 18:56:29 +0000 (UTC)
Received: by ldl.fc.hp.com (Postfix, from userid 17609)
	id 5C8223B4006; Fri, 10 Jul 2009 12:56:29 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <b0943d9e0907100311n26af2e86j95cae2200298ff68@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123076>

* Catalin Marinas <catalin.marinas@gmail.com>:
> Hi Alex,
>=20
> Sorry for the loooong delay.

No problem.

> 2009/6/19 Alex Chiang <achiang@hp.com>:
> > Add -s/--summary option to stg show, which will generate a nice
> > diffstat, similar to what you get in a cover mail if you specify
> > %(diffstat)s.
>=20
> I would use --stat for consistency with the diff command.
>=20
> > + =A0 =A0 =A0 =A0commit_str =3D gitlib.diffstat(git.diff(
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0re=
v1 =3D git_id(crt_series, '%s^' % patches[0]),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0re=
v2 =3D git_id(crt_series, '%s' % patches[-1])))
>=20
> This works only of the shown patches are consecutive. If you specify
> random patches, the diffstat isn't correct. I propose this form of th=
e
> patch:

Looks much nicer than mine, thanks.

Tested-by: Alex Chiang <achiang@hp.com>

[how about that other patch "fix stg mail %(shortlog)s order"? :) ]

/ac

> diff --git a/stgit/commands/show.py b/stgit/commands/show.py
> index b7a8aa9..45c3a56 100644
> --- a/stgit/commands/show.py
> +++ b/stgit/commands/show.py
> @@ -20,6 +20,7 @@ from pydoc import pager
>  from stgit.argparse import opt
>  from stgit.commands.common import *
>  from stgit import argparse, git
> +from stgit.lib import git as gitlib
>=20
>  help =3D 'Show the commit corresponding to a patch'
>  kind =3D 'patch'
> @@ -38,6 +39,8 @@ options =3D [
>          short =3D 'Show the applied patches'),
>      opt('-u', '--unapplied', action =3D 'store_true',
>          short =3D 'Show the unapplied patches'),
> +    opt('-s', '--stat', action =3D 'store_true',
> +        short =3D 'Show a diffstat summary of the specified patches'=
),
>      ] + argparse.diff_opts_option()
>=20
>  directory =3D DirectoryHasRepository(log =3D False)
> @@ -61,10 +64,13 @@ def func(parser, options, args):
>          # individual patches or commit ids
>          patches =3D args
>=20
> -    options.diff_flags.extend(color_diff_flags())
> +    if not options.stat:
> +        options.diff_flags.extend(color_diff_flags())
>      commit_ids =3D [git_id(crt_series, patch) for patch in patches]
>      commit_str =3D '\n'.join([git.pretty_commit(commit_id,
>                                                flags =3D options.diff=
_flags)
>                              for commit_id in commit_ids])
> +    if options.stat:
> +        commit_str =3D gitlib.diffstat(commit_str)
>      if commit_str:
>          pager(commit_str)
>=20
>=20
> --=20
> Catalin
>=20
