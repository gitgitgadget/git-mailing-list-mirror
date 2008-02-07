From: Pierre Habouzit <madcoder@debian.org>
Subject: small question about the repack algorithm
Date: Thu, 07 Feb 2008 10:03:31 +0100
Message-ID: <20080207090331.GA1958@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J2SCkAp4GZ/dPZZf";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN2fy-0008MX-I1
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbYBGJDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 04:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYBGJDg
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:03:36 -0500
Received: from pan.madism.org ([88.191.52.104]:47630 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959AbYBGJDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:03:33 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9D80132B65
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 10:03:32 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2D5064B4056; Thu,  7 Feb 2008 10:03:31 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72910>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  I've trying to see if that optimization was used but I was somehow
unable to find if it was the case, as the code is a bit tough :)

  I was wondering if the repacking window was using triangle inequality
to discard trying some costly deltas (I assume that what costs the most
in the repacking is computing the delta). I mean, if you consider the
"size" of a delta, I'm almost sure that it's very near a distance.

  So assuming that we know the delta sizes between any pair of reference
objects in the window, well, if an object we want to delta against the
window Od are near one reference O1 enough, for each Oi in the window
that holds: len(=CE=B4(O1, Oi)) > 2 * len(=CE=B4(Od, O1)), then it's not wo=
rth
investigating.

  I've seen quite many heuristics tried to avoid computing a delta at
the beginning of builtin-pack-objects.c:try_delta, but I don't seem to
find this one used, whereas it would even encompass most of the
heuristics here. I mean the object-size based heuristics are (if I'm
correct) a special case of the previous, e.g. I think one of the
heuristics is to not trying a delta if:
  | len(Oi) - len(Od) | > 2 * len(=CE=B4(Od, O1))

But it's just a subcase of the former because
  len(=CE=B4(Od, Oi)) >=3D | len(Oi) - len(Od) |


  Of course it needs us to know how objects in the same window diff
against one each other, of have a good estimation of it (having not too
bad lower estimates of the real deltas is an option here, as it just
makes the test a bit less discriminant, but can allow us to have a
trade-off between computing each crossed deltas in the window and
dropping tried deltas early). Note that we don't need to store the
actual deltas, just their length (or a more complicated score if we want
-- probably -- take the chain depth into account, we just need that
score to look like a distance enough).


  If it's already done, then don't mind me, though I'd like to be
pointed to where so that I can grok that code a bit more :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHqsljvGr7W6HudhwRAgtwAKCTVitB321fTxdm7gveVyZ7Fa703ACgm/rB
3N189Q6c4Xu3n66DnZYsTRg=
=LBiD
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
