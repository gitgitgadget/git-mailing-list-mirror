From: Pierre Habouzit <madcoder@debian.org>
Subject: regression in  92392b4
Date: Wed, 23 Jul 2008 01:17:45 +0200
Message-ID: <20080722231745.GD11831@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="pQhZXvAqiZgbeUkD";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jul 23 01:20:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLR8K-0005hv-Bz
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbYGVXR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756026AbYGVXR4
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:17:56 -0400
Received: from pan.madism.org ([88.191.52.104]:48871 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050AbYGVXRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:17:54 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4D7C1398A7;
	Wed, 23 Jul 2008 01:17:46 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BDC34142484; Wed, 23 Jul 2008 01:17:45 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89561>


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hi, here is a manual painful down-secting (opposed to a bisect ;P) I
did, since git in next cannot fetch on a regular basis for me. The
culprit seems to be commit  92392b4:

    =E2=94=8C=E2=94=80(1:11)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4...>=E2=
=94=80=E2=94=80
    =E2=94=94[artemis] git fetch
    remote: Counting objects: 461, done.
    remote: Compressing objects: 100% (141/141), done.
    remote: Total 263 (delta 227), reused 155 (delta 121)
    Receiving objects: 100% (263/263), 95.55 KiB, done.
    fatal: Out of memory, malloc failed
    fatal: index-pack failed
    [2]    16674 abort (core dumped)  git fetch

    =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4...>=E2=
=94=80=E2=94=80
    =E2=94=94[artemis] git checkout -m HEAD~1; make git-index-pack
    Previous HEAD position was 92392b4... index-pack: Honor core.deltaBaseC=
acheLimit when resolving deltas
    HEAD is now at 03993e1... index-pack: Track the object_entry that creat=
es each base_data
    GIT_VERSION =3D 1.5.6.3.3.g03993
	CC index-pack.o
	LINK git-index-pack

    =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 03993e1...>=E2=
=94=80=E2=94=80
    =E2=94=94[artemis] git fetch
    remote: Counting objects: 461, done.
    remote: Compressing objects: 100% (141/141), done.
    remote: Total 263 (delta 227), reused 155 (delta 121)
    Receiving objects: 100% (263/263), 95.55 KiB, done.
    Resolving deltas: 100% (227/227), completed with 153 local objects.
    From git://git.kernel.org/pub/scm/git/git
       5ba2c22..0868a30  html       -> origin/html
       2857e17..abeeabe  man        -> origin/man
       93310a4..95f8ebb  master     -> origin/master
       559998f..e8bf351  next       -> origin/next

You can see the commit sha's in the prompt. 03993e1 is fine, 92392b4 is
broken, I've absolutely no clue about what happens.

All I can say is that at some point in get_data_from_pack, obj[1].idx
points to something that is *not* a sha so it's probably corrupted.
(from index-pack.c).


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGapYACgkQvGr7W6HudhzEbACfXqdBRnxlUh/jFOp3ZI66IDSW
O68AoIFF9CE/fYQ3rTBKKJnGZDayQTDm
=qp6q
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
