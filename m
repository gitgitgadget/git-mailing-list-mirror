From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: BUG: "--work-tree blah" does not imply "--git-dir blah/.git" or
 fix misleading error message
Date: Wed, 30 Nov 2011 19:22:30 +0100
Message-ID: <20111130182230.GC12096@centaur.lab.cmartin.tk>
References: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Cc: git@vger.kernel.org
To: John Twilley <mathuin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 19:22:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVonl-0004Gj-C1
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 19:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab1K3SWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 13:22:32 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:46114 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1K3SWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 13:22:32 -0500
Received: from centaur.lab.cmartin.tk (brln-4dbc7c68.pool.mediaWays.net [77.188.124.104])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 60A5E461A5;
	Wed, 30 Nov 2011 19:21:49 +0100 (CET)
Received: (nullmailer pid 10050 invoked by uid 1000);
	Wed, 30 Nov 2011 18:22:30 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	John Twilley <mathuin@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186132>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2011 at 09:43:08AM -0800, John Twilley wrote:
> Today someone asked me if there was a way to run git against a
> directory other than the current directory.  I looked at the output of
> --help and ran this:
>=20
> $ git --work-tree blah status
>=20
> I got the following output:
>=20
> fatal: Not a git repository (or any parent up to mount parent /home)
> Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
>=20
> I mistakenly thought the error message meant that blah was not a git
> repository.  What it meant was that there was no .git in the current
> directory or any parent directory up to /home.

Yes, git looks at the current directory and .git/ to see if there's a
git repository there. This is what happens unless you tell git to look
for it somewhere else.

>=20
> This command worked as expected:
>=20
> $ git --work-tree blah --git-dir blah/.git status
>=20
> The documentation is somewhat fuzzy about what constitutes a git
> repository.  The gittutorial describes the git repository as .git when
> talking about "git init" while the Git User's Manual describes the git
> repository as the working tree and the special top-level directory
> named .git when talking about "git clone".

A git repository is what's under .git/ (or in foo.git/ for bare
repos). Non-bare repositories have a working tree associated with
them, which by default lives just above the repository, because it'd
be silly to have it somewhere else by default. Often you can think of
both as the repository, as they're both. When you tell git to look for
the worktree somewhere else, you're only overriding that particular
variable, as git expects to be run from the repository (or just above,
in the worktree).

>=20
> It's clear (to me at least) that --work-tree should be used to
> identify the root of the working tree when not inside the working
> tree.  I expected that the git directory would be automatically set to
> .git in the root of the working tree, as that would match the
> documentation.  Instead, the current directory and its parents were
> checked -- which could provide dangerously misleading information to
> the user.

What part of the documentation exactly? --work-tree tells git to look
for the working tree somewhere else. This option exists in order to
support a multiple-workdir workflow.

>=20
> I think that one of two things should be done:  either the --git-dir
> default should be changed when the --work-tree option is set, or the
> error message cited above should be changed to explicitly identify the
> directory being tested as a potential git repository.  I personally

Git does tell you explicitly, but only when you specify a gitdir (via
GIT_DIR or --git-dir), otherwise it looks at the current directory.

> believe the first option is superior because it fulfills the
> expectations of average users (folks who read git's documentation
> instead of its source code) while permitting flexibility to those who

It's not likely that it will get changed because that would break
backwards-compatability in a very big way. If your concern is for
"average user", she shouldn't be using that option, but changing to
that directory instead. If you want your working tree to be ./foo/ and
your gitdir to be ./foo/.git, why don't you just cd to ./foo/?

> wish to refer to the current directory or some other directory for
> their --git-dir value.  If the current behavior is somehow not a bug
> but instead a critical and significant feature which if changed would
> cause more harm than good, please consider the second option.

You get two different messages depending on how git is looking for the
repository. The message you mentioned gets printed when git tries to
find it automatically. A "fatal: Not a git repository: '/tmp'" gets
printed if you've told git to look for it in a specific place. The
information is already there, though I guess you do have to know about
the difference. Adding the current directory to the "default" message
probably wouldn't hurt, as it's unlikely that a script is parsing
that, and might be useful.

   cmn

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO1nRmAAoJEHKRP1jG7ZzTqLsH/1V/2CTQsdyVjue0qY+eIdlW
edisfAo62rFawByTpgJ5F8N5tPPLj1k10RCxOeiOjywIweR1C3a+uTzQIX4qSDC3
f33vu6yy+yfVoseZun8zRjTDTYQYFMkNqhPFmWMD0N2GyVCub/rOvGTj/6m4HWXP
m21FokVzdz4diHcbR7h2tYS7h3IE43DZWLvk93IXfZ/ohGbpftmynXuP7/IWYoBR
5LI+prQ9fCY6yFcbYzm/tzSdNDXE3ub1Tb7uBvvMkBiY7PC9KqANasfHopODGUwy
WtbIoG4kEsMeXcV+ihX/cGWrmFyMw+fSk+duL4vWSH6NcWpOMIdTInnPYPzhQHU=
=KQYr
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
