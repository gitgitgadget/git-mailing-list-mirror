From: Pierre Habouzit <madcoder@debian.org>
Subject: [(not so) random thoughts] using git as its own caching tool
Date: Wed, 12 Dec 2007 01:38:13 +0100
Message-ID: <20071212003813.GG29110@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="GUPx2O/K0ibUojHx";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:38:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2FcV-0003jX-1Y
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 01:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbXLLAiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 19:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbXLLAiR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 19:38:17 -0500
Received: from pan.madism.org ([88.191.52.104]:48366 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597AbXLLAiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 19:38:16 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CD2B82F78D
	for <git@vger.kernel.org>; Wed, 12 Dec 2007 01:38:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 92B4EAF2; Wed, 12 Dec 2007 01:38:13 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67976>


--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  That's an idea I have for quite some time, and I wonder why it's not
used in git tools as a general rule.

  This idea is simple, git objects database has two (for this
discussion) very interesting features: its delta compressed cached that
is _very_ efficient, and the reflog.

  I wonder if that would be possible to write some git porcelains (and
builtin API too) that would be more "map" oriented. I mean, we could use
a reference as a pointer to a given tree that would be the map (where
keys have a path form, which is nice). When I say that, I'm thinking
about git-svn, that even with the recent improvements of its .rev_db's
still eats a lot of space with the unhandled.log _and_ the indexes it
stores for _each_ svn branch/tag. This way, instead of many:
    foo/index
    foo/.rev_map.6ef976f9-4de5-0310-a40d-91cae572ec18
    foo/unhandled.log
we would just have a special refs/db/git-svn/foo reference that would be
a tree with three blobs in it: index, rev_map.xxxx, unhandled.log.  (or
probably index would even be a tree but that's another matter). This
way, all the unhandled.log that share a lot of common content would be
nicely compressed by the delta-compression algorithms, with a negligible
overhead (git-svn is _very_ slow because of svn anyways, we don't really
care if it needs to get a blob contents instead opening a flat file).


  Another nifty usage we could have is memoization databases that don't
require a specific tool to expire them, but use the reflog expiration
for that. I remember that we discussed quite some time ago, the idea of
annotating objects. We could use such annotations to link some objects
to memoized datas under different namespaces for each caching scheme
involved, and with one reference per namespace that will have in its
reflog each of the linked objects created over time for caching. Good
candidates to use that are the rr-cache, or git-annotate/blame caching.
Of course that would need to write a tool that removes weak annotations
that point to objects that don't exist anymore. We could also cache the
rename/copies/=E2=80=A6 detection results, and make those really really che=
ap to
use[0].


  I know that some will say something about hammers, problems and nails,
though it would allow to develop quite efficient tools with a generic
and easy to use API, that could directly benefit from already existing
infrastructure in git. I mean it's silly to write yet-another cache
expirer when you have the reflog. Or to speak about git-svn again, it
could even version its state per branch the way I propose, it'll end up
using less disk that what it does now, with the immediate gain that it
would be fully clone-able[1] (which would be a _really_ nice feature).


  So am I having crazy thoughts and should I throw my crack-pipe away ?
Or does parts of this mumbling makes any sense to someone ?



PS: It's late, and I'm tired, hence my english is probably very clumsy,
    and I hope I'm understandable enough. I'd be glad to rephrase parts
    that needs it.

  [0] and if the copy/rename/=E2=80=A6 detection algorithm gets smarter, we=
 just
      need to change its memoization namespace to throw the old cache
      away at once.

  [1] and the really nice part here is that even if you don't create one
      new step per svn revision you import but do macro-steps with
      hundreds of svn revisions at a time, the merge of two differnt
      git-svn states of two clones of the _same_ svn repository will
      have a trivial exact merge: the one that knows the biggest svn
      revision is the new state to use.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXy11vGr7W6HudhwRAtBPAJ9lFc77yT1Yd2bXnO+gH+Vg1dVL6wCgm8pW
Fh8A78RbLoCasu8faUlZ5CM=
=w5OK
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--
