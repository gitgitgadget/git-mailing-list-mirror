From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] Re: git-svn: make git-svn commit-diff able to work without explicit  arguments
Date: Tue, 2 Jan 2007 19:40:07 +0100
Message-ID: <20070102184007.GB17898@hades.madism.org>
References: <459AA31E.5070705@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="H1spWtNR+x+ondvy";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 20:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1p2I-0002yk-Q3
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbXABTKz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbXABTKz
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:10:55 -0500
Received: from pan.madism.org ([88.191.16.128]:37462 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925AbXABTKy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:10:54 -0500
X-Greylist: delayed 1840 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 14:10:53 EST
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id 71879C001;
	Tue,  2 Jan 2007 19:40:07 +0100 (CET)
Received: by hades.madism.org (Postfix, from userid 1001)
	id 389CE62750; Tue,  2 Jan 2007 19:40:07 +0100 (CET)
To: Steve =?utf-8?Q?Fr=C3=A9cinaux?= <nudrema@gmail.com>
Mail-Followup-To: Steve =?utf-8?Q?Fr=C3=A9cinaux?= <nudrema@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <459AA31E.5070705@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel-git (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35797>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2007 at 07:23:26PM +0100, Steve Fr=C3=A9cinaux wrote:
> Hello,
>=20
> When using git-svn to access a SVN repo, the commit policy may vary.=20
> While git makes you commit small patches often, svn users tend to prefer=
=20
> bigger patches that implement a functionnality at once.
>=20
> So at the end you have a SVN commit which corresponds to several git=20
> ones.
>=20
> What you can do in this case is :
>=20
>   git-svn commit-diff --edit -r$REV remotes/git-svn HEAD
>=20
> Which effect is that it commits (at once) all the commits between the=20
> latest svn fetch and HEAD.
>=20
> What I'm proposing here is this:
>=20
>  - use the latest fetched rev the default for the -r argument.
>  - use remotes/git-svn and HEAD the defaults for the treeish objects.
>=20
> A smarter way to take these defaults would be to take the last revision=
=20
> in the current branch (which can be something else than git-svn if it=20
> wasn't rebased/merged recently) and the relevant commit in the current=20
> branch.
>=20
> Additionnaly, --edit could be enabled by default if -m is not set and it=
=20
> is used interactively, eventually using an option in repo-config.
>=20
> Any comment ?

  of course a git svn subcommand that in fact allow you to cherry pick
patches from `git rev-list remotes/git-svn` would be *really* good, but
here is what I do:

  1. be up2date:
    $ git svn fetch
    $ git rebase remotes/git-svn

  2. create a local branch to cherry pick the hunk you want to combine:
    $ git branch -f svn-tmp remotes/git-svn
    # cherry pick the commits you want using any method you like, eg:
    $ git cherry-pick <....>
     or
    $ git am [some previously built mailbox of changes]

    I happen to prefer the later since I do git format-patch
    remotes/git-svn from my master branch, and use my MUA as a
    poor-man's interactive way to select patches I want. Though
    sometimes you miss some dependant patches, and I suppose git
    cherry-pick would be better at that game, YMMV.

  3. git svn commit HEAD (not dcommit) to force merging of all your
     local patches in one svn changeset.

     note that you may need a step (1) update if anything changed since,
     if you don't want to see git-svn undo the commits other user may
     have done since your last (1) update, commit your change, and
     commit the previously undone commits back. I did that once when I
     was a beginner with git-svn, and it generated a huge pile of
     globally indempotend commits, and flooded the commit mail list,
     that was kind of funny ;)

  4. go back to your branch as usual, and resync to the new svn state:
     git checkout master
     git svn fetch
     git rebase remotes/git-svn # should merge things happily

     you can then go back to (2) and iterate until your
     `git rev-list remotes/git-svn` is empty.

  This is highly unpretty, and relies in the fact that nobody commited
into the svn between your set 2 and 3. I suppose you can achieve the
same by creating combined changeset from git, instead of a cherry
picking, in some kind of "combining" branch, and then just use
`git svn dcommit` from there, but I've found no convenient (I mean no
way *I* find convenient) way to do that. Maybe someone here has a better
idea :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFmqcHvGr7W6HudhwRAtX8AJ9bNstNg+HrdeNID9ObJHafk09sPACeM+8c
yTpwvQwUFkX+HWGXLtZKQoE=
=fjwe
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
