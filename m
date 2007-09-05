From: Jan Hudec <bulb@ucw.cz>
Subject: Re: best practice for a 3 devs team?
Date: Wed, 5 Sep 2007 21:50:06 +0200
Message-ID: <20070905195006.GG3786@efreet.light.src>
References: <6b6419750708281520u12857b4j3e8f1ca0508f7d51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DNUSDXU7R7AVVM8C"
Cc: git@vger.kernel.org
To: Patrick Aljord <patcito@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:50:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0tb-0004kF-M6
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbXIETuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbXIETuP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:50:15 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:60369 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127AbXIETuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:50:13 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3A30657606;
	Wed,  5 Sep 2007 21:50:11 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id LwexBHKWeC0H; Wed,  5 Sep 2007 21:50:08 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id E5D2D57634;
	Wed,  5 Sep 2007 21:50:07 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IT0t4-0007pg-LS; Wed, 05 Sep 2007 21:50:06 +0200
Content-Disposition: inline
In-Reply-To: <6b6419750708281520u12857b4j3e8f1ca0508f7d51@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57755>


--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2007 at 17:20:25 -0500, Patrick Aljord wrote:
> Hey all,
> We are 3 developers working on the same project. I was thinking what
> would be the best practice for us. We have just switched from svn and
> for now we are all working on the master branch that we push to a ssh
> git repository.
> I was thinking about maybe each of us could create our own branch like
> 'git branch <dev_name>' but then how would it go? Each one of us would
> push our own branch to the remote repository and each one of us could
> cherry pick the change from the remote branch of each developer. Is
> this the best way to do it? (I guess there is no best way but still :)
>=20
> any advice welcome

I'd vote against 1-to-1 mapping between developers and branches. It's
either needlessly inflexible or needlessly complicated, depending how quick=
ly
the mainline changes and how stable it needs to be.

For project under heavy development (where occasional breakage won't hurt t=
oo
much and fast progress is desired), I'd recommend you to just keep pushing =
to
master everyone. This makes new changes immediately visible -- and tested --
by others, so you notice errors quickly. It also makes the workflow easiest,
since you only rebase on master and push it (I'd recommend rebasing work in
progress instead of merging to make the history easier to read). You can
occasionally create a feature branch in the central repository if you want
someone else to test your work in progress, but making your local
repositories readable by the others would work just as well.

On the other hand for project that is expected to provide stable releases,
especially if it's supposed to provide them often, something similar to what
Junio uses for git seems most reasonable. That is, you'd have a master (or
stable) branch for the oncoming release, one or more branches for testing a=
nd
a lot of feature branches that would come and go (yes -- in git when you
merge a feature branch for final, you can, and should, just remove it!). Ea=
ch
developer could have a prefix assigned to avoid conflicts in feature branch
names (Junio currently uses initials of author as prefix).

For every logical change you do, you'd push a feature branch to the central
repository. Than somebody else would pick it up, review it and if it seems
sane, merge it to the most experimental branch. That branch would than be
subjected to testing. Junio currently reverts changes from this most
experimental branch (called 'pu' (proposed updates)) by deleting it,
branching it from 'next' again and re-merging all the still prospective
feature branches in again. This (re-creating a branch) is called rewinding
and you must be careful not to branch of it, or if you do, use rebase rather
than merge with it, but you should not base work on this experimental branch
anyway -- it only exists for creating the test build.

Now the individual feature branches that have seen enough testing in this
experimental branch will go, depending on how careful you need to be, either
to the master, or to a branch, that will be subjected to system test and
become next master after current release (this is the 'next' branch in git).
This branch should now be available for basing further development on, so y=
ou
may no longer rewind, so any bugs found here have to be fixed or reverted by
applying reverse patch to whatever one introduced them.

As I said, I'd in any case avoid having per-developer branches and keep
strictly per-feature (per-task). In git, commits don't belong to branches.
Branch is just a pointer to it's head commit. Once further commits are made
on top of it, it does not need any name to be accessible anymore. Therefore
once your features make it into 'master' (or even just 'next'), you can
remove their names -- and reuse them. This way you don't have to think twice
about the feature names, because they are temporary (besides you can also
rename them at any time).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--DNUSDXU7R7AVVM8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3whuRel1vVwhjGURAhhcAJoDUIu3VqaHhUM3o4xYHXkXKRBu1QCgzAw0
VzTolgehM/Am+gHNftEs0J8=
=z/OO
-----END PGP SIGNATURE-----

--DNUSDXU7R7AVVM8C--
