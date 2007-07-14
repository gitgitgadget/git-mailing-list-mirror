From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] fall back to mozilla's sha.h if openssl/sha.h is not
	available
Date: Sat, 14 Jul 2007 16:50:13 +0200
Message-ID: <20070714145013.GA14488@piper.oerlikon.madduck.net>
References: <11844050771857-git-send-email-madduck@madduck.net> <20070714142350.GB2544@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 16:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ix6-0000g9-Fl
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 16:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbXGNOuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 10:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbXGNOuS
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 10:50:18 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:48857 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbXGNOuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 10:50:16 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id AF586895D73
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 16:50:14 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28673-04 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 16:50:14 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 7426C895D72
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 16:50:14 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id E2B089F121
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 16:50:13 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B9CCA43FC; Sat, 14 Jul 2007 16:50:13 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070714142350.GB2544@steel.home>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52485>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Alex Riesen <raa.lkml@gmail.com> [2007.07.14.1623 +0200]:
> > This should possibly go to configure.ac, but maybe *also* to Makefile t=
o make
>=20
> Definitely. It should it least skip the test if NO_OPENSSL is already
> defined.

Reading this as a yes, here is the patch adding this. I'll wait for
a few days before submitting a squashed patch to Junio then. If you
oppose, please speak up.

My autotools knowledge is limited, but I might then look at adding
the fall back to configure.ac too.

Btw: I've done a lot of things wrong on this mailing list already,
for which I'd like to apologise. Thanks to those who told me
privately off my faux pas. I hope those won't be necessary anymore.



commit c8cbe9e5a44174baabe17152d575b3ee46b82c36
Author: martin f. krafft <madduck@madduck.net>
Date:   Sat Jul 14 16:44:46 2007 +0200

    skip the openssl/sha.h test if NO_OPENSSL is already defined

diff --git a/Makefile b/Makefile
index 1676343..b0ce7f0 100644
--- a/Makefile
+++ b/Makefile
@@ -532,10 +532,12 @@ ifndef NO_CURL
 	endif
 endif
=20
-HAS_OPENSSL :=3D $(shell echo "\#include <openssl/sha.h>" \
-			| $(CPP) -o/dev/null - 2>/dev/null || echo no)
-ifeq "$(HAS_OPENSSL)" "no"
-	NO_OPENSSL =3D "openssl_sha.h_not_found"
+ifndef NO_OPENSSL
+	HAS_OPENSSL :=3D $(shell echo "\#include <openssl/sha.h>" \
+				| $(CPP) -o/dev/null - 2>/dev/null || echo no)
+	ifeq "$(HAS_OPENSSL)" "no"
+		NO_OPENSSL =3D "openssl_sha.h_not_found"
+	endif
 endif
=20
 ifndef NO_OPENSSL

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"one should never do anything that
 one cannot talk about after dinner."
                                                        -- oscar wilde

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmOKlIgvIgzMMSnURAnSbAJ9awPL1+o5kCnLG6JaEtI3aoKMp2QCeJckr
5fdqDH8uWne5OPI1ARPm/Pg=
=LVW1
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
