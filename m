From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 22:55:45 +0200
Message-ID: <20080728205545.GB10409@artemis.madism.org>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="0ntfKIWw70PvrIHh";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:57:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZm4-0007Zl-D7
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYG1Uzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYG1Uzu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:55:50 -0400
Received: from pan.madism.org ([88.191.52.104]:41330 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbYG1Uzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:55:48 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5B8743484F;
	Mon, 28 Jul 2008 22:55:46 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 20E77A268; Mon, 28 Jul 2008 22:55:45 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90504>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2008 at 08:23:39PM +0000, Nigel Magnay wrote:
> >
> > While trying to sum up some things I'd like submodules to do, and things
> > like that, I came to ask myself why the heck we were doing things the
> > way we currently do wrt submodules.
> >
> > This question is related to the `.git` directories of submodules. I
> > wonder why we didn't chose to use a new reference namespace
> > (refs/submodules/$path/$remote/$branch).
> >
> I'm maybe being a bit slow - what would be the contents of (say)
> refs/submodules/moduleA/remotes/origin/master ? The ref
> that's currently in moduleA/.git/refs/remotes/origin/master ?

  Yes.

> > It also has the absolutely nice property to share objects, so that
> > projects that replaced a subdirectory with a submodule don't see their
> > checkouts grow too large.
> >
>=20
> Ah.. are you meaning that the top-level repository contains all the
> commits in all the submodules?

  Yes. My suggestion is to share all the references, prefixing the
submodules ones with a distinct prefix (namely
refs/submodules/$name-of-the-submodule) to avoid any conflict, and share
the object store. You get coherent reflogs and stuff like that for free
on top.

> I was thinking a bit about submodules (because of the earlier
> discussions about submodule update only pulling from origin, and the
> associated difficulties) and started wondering if the best place for
> the git repository for (say) submoduleA was really
> <...>/submoduleA/.git/<> and not (say) something like
> ..git/submodules/submoduleA/<>. This would be nicer for people trying
> to pull revisions from you because they could easily find submodule
> repositories regardless or not of whether they currently exist in your
> WC.

  That too indeed (the "easier to clone" bit). OTOH, I don't like the
=2Egit/submodules idea a lot, if you mean to put a usual $GIT_DIR layout
inside of it. With what I propose, you find objects for all your
super/sub-modules in the usual store, which eases many things.
Especially, I believe that when you replace a subdirectory of a project
with a submodule, git-blame could benefit quite a lot from this to be
able to glue history back through the submodule limits, without having
to refactor a _lot_ of code: it would merely have to dereference so
called "gitlinks" to the commit then tree, hence twice, and just do its
usual work, with your proposal, we still rely on having to recurse in
subdirectories which requires more boilerplate code.

> I got as far as looking at discussions around .gitlink but ran out of
> avaiable time.

  I shall say I never followed them, as I was uninterested with such
subjects before, (but now is as I use them at work). But I don't recall
such an idea to have been discussed at all, so...

> > Having that, one can probably extend most of the porcelains in _very_
> > straightforward ways. For example, a local topic branch `topic` would be
> > the union of the supermodule `topic` branch, and all the
> > `refs/submodules/$names/topic` ones.
> >
> > Most importantly, it would help implementing that tries to make your
> > submodules stay _on branch_. One irritating problem with submodules, is
> > that when someone else commited, and that you git submodule update,
> > you're on a detached head. Absolutely horrible. If you see your current
> > branch (assume it's master), then when you do that, you would update
> > your `refs/submodules/$name/master` references instead and keep the
> > submodule HEADs `on branch`. Of course we can _probably_ hack something
> > together along those lines with the current setup, but it would be _so_
> > much more convenient this way...
> >
>=20
> For me, if I'm on heads/blah in the superproject, I probably want to
> be on heads/blah in *all* submodules. But that's maybe just me.

  Yes, that's what I tried to say, so if it wasn't clear, it's exactly
what I would like to do/have.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiOMlEACgkQvGr7W6HudhznWQCgqfwqs1vSmk9zGp2CCsac04HV
6HYAoImEiejswiCKVE3IJR73Pe5Ph5Ag
=4kM3
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
