From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Mon, 18 Aug 2008 02:46:19 +0200
Message-ID: <20080818004619.GD17148@artemis>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <20080728220308.GF10409@artemis.madism.org> <m3r69dtzm9.fsf@localhost.localdomain> <7vfxptpr76.fsf@gitster.siamese.dyndns.org> <20080817201336.GA17148@artemis> <7v1w0np7d4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="P+33d92oIH25kiaB";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 02:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUsu6-0002Tz-Q5
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 02:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbYHRAqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 20:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbYHRAqX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 20:46:23 -0400
Received: from pan.madism.org ([88.191.52.104]:36528 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbYHRAqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 20:46:23 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4B2BF3F808;
	Mon, 18 Aug 2008 02:46:20 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CEBDD76E2; Mon, 18 Aug 2008 02:46:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1w0np7d4.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92676>


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2008 at 11:08:39PM +0000, Junio C Hamano wrote:
> I know there are cases where sharing object store is useful.  Being able
> to share is one thing.  Always having to share, without any other option,
> is another.
>=20
> Using gitlink to keep the true repository data out of submodule checkout
> area so that branch switching can safely be done is orthogonal to the
> issue of how repositories of submodules and the superproject share their
> object store.  IOW, you would always use gitlink to solve the "branch
> switching may make the submodule checkout disappear" issue, while you
> could use alternates mechanism (or direct symlinking of $GIT_DIR/objects)
> across these repositories *if* you want to share their object store.

  Fair enough. Though I'm not only interested into the branch switching
issue. I'm seeing a bit farther, like in having many commands working as
if there is no submodule involved. And having the same object store for
all {sup,super}modules helps a lot. For example, there is probably quite
some plumbing to write if we have separate object stores if we expect
(and frankly I do) to have git-commit work across submodule boundaries
(doing what it should, IOW commit in the submodules, and then commit in
the supermodule).

  But maybe it's not as hard as it looks.

> > Though we would not like to have submodules suffer from reachability
> > issues after a prune in the supermodule. That means that all references
> > and reflogs of the submodules shall be accessible from the supermodule
> > so that everything that could mess with the object store by removing
> > objects cannot remove interesting objects (that should limit the code
> > paths to really seldom places actually).
>=20
> I do not think this issue is limited to use of submodules.  I'd imagine
> that if you build this reachability protection into the alternates
> mechanism, you would automatically solve both "multiple checkout of the
> same project, via git-new-workdir" issue as well as "submodules that share
> its objects with the superproject" issue.
>=20
> Which leads me to conclude, at least for now, that it would not be a good
> idea to make this related to gitfile in any way.  Object sharing between
> equal repositories (aka new-workdir) does not use gitfile, but it still
> needs to have the same kind of reachability protection.

  Well somehow the repository that is the alternate (or the symlink, but
the latter isn't very windows friendly, not to mention vfat) has to know
about the other repository:
  * index ;
  * references ;
  * reflogs.

  Which means that alternates users have to register into the provider,
which seems to be _usually_ brittle. I mean, for the current way of
how git-new-workdir works, if you register workdirs into the real
repository, if you just rename this workdir at some point, or move it to
some other place, you're screwed, silentely.

  If instead you force this workdir to use a gitfile, you _don't need_
to register your workdir in the "real" repository, because all the data
belongs to the "real" repository. The workdir is just a "detached"
workdir, with only the checkout stuff, no index, no references no
nothing. And if you move this workdir to a new place, it still works.
Only the central repository should not budge, which is already a
limitation of current workdirs and alternates anyways.

  Of course with submodules it's less of an issue since those arent as
loosely coupled to the supermodule as workdir are to the main
repository, and it's unlikely that a submodule will move very often ;)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkioxloACgkQvGr7W6HudhxhnwCeKGyIXOsD8nKomLqEd0S3SfKS
/G4AnRevCbrIpxaZWJQe5O9jGFWuHdli
=x7C1
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
