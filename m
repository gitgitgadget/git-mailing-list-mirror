From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Mon, 21 May 2007 18:59:38 +0200
Message-ID: <20070521165938.GA4118@efreet.light.src>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163061588-git-send-email-skimo@liacs.nl> <20070518215312.GB10475@steel.home> <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Cc: skimo@liacs.nl, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 18:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqBEh-0002nt-2w
	for gcvg-git@gmane.org; Mon, 21 May 2007 18:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144AbXEUQ7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 12:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755722AbXEUQ7q
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 12:59:46 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4045 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756144AbXEUQ7p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 12:59:45 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.477206;
	Mon, 21 May 2007 18:59:38 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HqBEQ-0001JT-51; Mon, 21 May 2007 18:59:38 +0200
Content-Disposition: inline
In-Reply-To: <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48028>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I gave the problem some more thought, and though I follow up on my previous
comment below, I can now see this:

So far it was discussed what should happen in fetch (+ checkout). But I thi=
nk
the following are the interesting cases. Please read ALL before responding,
they are in somewhat random order:

 For following, assume there is a repo of project super has two branches,
 master and next. The next branch adds subproject sublib. In that state, I =
fetch
 refs/heads/*:refs/remotes/origin/* and check out master. So I have
 a repository, that contains revision with submodule, but I did not check it
 out yet.

 - Some time later, *without* fetching again, I simply
      git checkout --submodules -b feature1 remotes/origin/next
   Obviously it needs to give me the module.

 - Should that checkout work without network access?

 - Ok, now I start hacking on feature1 and find a bug in sublib, that I need
   to fix for it to work. Therefore I change something within sublib.

   However few days later I am asked to fix a bug in stable release of supe=
r.
   Therefore I: git checkout master Now, where does sublib go? It contains
   precious data!

   For the worst case situation assume, that the master branch also has
   directory sublib, so it can't stay where it was as unversioned.

 - The fix in master is done, back to our feature1, right?  git checkout
   --submodules feature1 Obviously re-fetching from upstram won't work. The
   head feature1 now refers to a commit that I made and only exists localy.

 - Now the maintainer of super wants to test the feature1. However sublib
   upstream did not accept the bugfix yet (and is perhaps waiting for
   confirmation, that the fixed version really works well for super, so we
   have to test).

   Therefore I push feature1 to my public repo, set up a public repo with my
   fixes to sublib and configure my public super repo to know about it.

   The maintainer already has a repo of super including sublib submodule. B=
ut
   when he pulls from me, he does not have the repo with my fixes.

 - The maintainer reviewed my feature1 and now needs to work on feature2.
   That however requires new upstream version of super. Therefore he needs =
to
   pull alternatively from both upstream and my repo with super, depending =
on
   what he works on.

   For the most complex case, assume here that I add more fixes to sublib
   while author of feature2 uses more and more bleeding edge stuff, so the
   maintainer really needs futher changes in sublib from both repos.

 - Also git has to fail safe if I forget to push the sublib, so when the
   maintainer tries to pull super, the refered revision of sublib simply
   won't be found.

I am not sure how to handle these cases. But they are cases that can happen
in real life and should be handled somehow. Even if some of them just requi=
re
some manual configuration.

Here is one possible idea:

We could store the GIT_DIR of submodule within the GIT_DIR of the
superproject instead of the submodule directory itself. So instead of:
 /
 /.git
 /subdir
 /subdir/.git

There would be:
 /
 /.git
 /subdir
 /.git/submodules/submodule-name.git

This would require changes to the logic how git finds GIT_DIR (which would =
be
really deep change), but it would provide place to store the submodule data
while the submodule is not being checked out.=20

This does not address the last two cases above with mutliple sources, each
containing some revisions. There I see two options:

 - The submodules are fetched during superproject fetch (based on them being
   configured, even if they are not checked out) and the URL might depend on
   url configured for superproject. That is:
      git fetch --submodules foobar
   would do roughty:
      for GIT_DIR in $GIT_DIR/submodules/*.git; do
         git fetch foobar || git fetch
      done
   So if you configured source of the same name for the subproject, it would
   be pulled, otherwise the default one would.

   Checkout would then be local-only operation, because subprojects are
   up-to-date.

 - The superproject checkout would try fetching all sources of the
   subproject, until the requested revision is found.

   This could be extended to normal checkout doing it as well --
   "git checkout sha1" would try fetching all configured sources if the
   revision was not found.

Perhaps we could actually do both. That is, "git fetch --subprojects" to
also fetch all of "$GIT_DIR/submodules/*.git" and checkout to try fetching =
if
it can't find the desired revision.

On Sun, May 20, 2007 at 11:33:17 -0700, Junio C Hamano wrote:
> Jan Hudec <bulb@ucw.cz> writes:
> > IMHO it makes more sense to fetch during fetch of superproject:
> >
> >  - If you don't fetch the superproject, it won't start refering to
> >    unavailable commit of subproject. So should only need to fetch subpr=
oject
> >    after fetching superproject.
>=20
> Eh, I was suggesting that the subproject fetch would come after
> checkout in "fetch and then checkout" sequence of the
> superproject, and if you are arguing against it, you should
> justify why it should not happen before checkout, as we both
> agree it should come after fetch of superproject.  Your argument
> is like saying you have to git-init before doing anything so
> you should fetch when you git-init.  That's not a justification.

It definitely has to come after fetch on superproject. My original thought
was, that it would be weird if it was part of the checkout itself, meaning
even checkout that does not follow a fetch. However I thought about it some
more and that might conflict with other requirements.

> >  - If you fetch from more than one location, you want to fetch subproje=
ct
> >    from location corresponding to where you fetch superproject from.
>=20
> Not at all.  There is no reason to believe that the case that
> superproject and subproject come from related URLs is more
> common.  One of the reasons to do a separated project

I definitely don't think it's more common. But it's the harder case and it
might happen. Generally it will happen if some people work on both the
superproject and the subproject. Of course the argument is that than it
should not be separate projects, but maybe the teams just partly overlap.

Example of this situation is given above. IMHO it needs to be handled
somehow (probably git would have to check all potential sources whether they
have the revision in question).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUc/6Rel1vVwhjGURAgJdAKDIOZTLNL2NbXMUicJ5AZx+aBuoiwCdE6Ou
2VLBS9E7sotpwjFoSCh4cgQ=
=5tMs
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
