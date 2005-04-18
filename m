From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: [patch] fixup GECOS handling
Date: Mon, 18 Apr 2005 12:36:29 +0200
Message-ID: <1113820589.16288.5.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-V47CTBMMf6tb6ci/RnY1"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Apr 18 12:29:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNTVB-0001eW-AG
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 12:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVDRKdB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 06:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDRKdB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 06:33:01 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:24725 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261404AbVDRKcy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 06:32:54 -0400
Received: from gateway.lan (wblv-146-244-27.telkomadsl.co.za [165.146.244.27])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id E14721FB7
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 12:32:50 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 856F03A26DB
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 12:39:02 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27883-11 for <git@vger.kernel.org>; Mon, 18 Apr 2005 12:38:54 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 4E02B3A26DA
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 12:38:54 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-V47CTBMMf6tb6ci/RnY1
Content-Type: multipart/mixed; boundary="=-bvF8f4aPuP9vDLxU7mhg"


--=-bvF8f4aPuP9vDLxU7mhg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

The gecos is delimited by ',' or ';', so we should only use whatever
before the first ',' or ';' for the full name, and not just strip those.
Also, a '.' may be valid in the full name (Foo B. Zooman) or email
(foo.zooman@bar.com).

Signed-off-by: Martin Schlemmer <azarah@gentoo.org>

commit-tree.c: ec53a4565ec0033aaf6df2a48d233ccf4823e8b0
--- 1/commit-tree.c
+++ 2/commit-tree.c     2005-04-18 12:22:18.000000000 +0200
@@ -96,21 +96,6 @@
                if (!c)
                        break;
        }
-
-       /*
-        * Go back, and remove crud from the end: some people
-        * have commas etc in their gecos field
-        */
-       dst--;
-       while (--dst >=3D p) {
-               unsigned char c =3D *dst;
-               switch (c) {
-               case ',': case ';': case '.':
-                       *dst =3D 0;
-                       continue;
-               }
-               break;
-       }
 }

 static const char *month_names[] =3D {
@@ -313,6 +298,11 @@
        if (!pw)
                die("You don't exist. Go away!");
        realgecos =3D pw->pw_gecos;
+       /* The name is seperated from the room no., tel no, etc via [,;] */
+       if (strchr(realgecos, ','))
+               realgecos[strchr(realgecos, ',') - realgecos] =3D '\0';
+       else if (strchr(realgecos, ';'))
+               realgecos[strchr(realgecos, ';') - realgecos] =3D '\0';
        len =3D strlen(pw->pw_name);
        memcpy(realemail, pw->pw_name, len);
        realemail[len] =3D '@';


--=20
Martin Schlemmer


--=-bvF8f4aPuP9vDLxU7mhg
Content-Disposition: attachment; filename=git-gecos.patch
Content-Type: text/x-patch; name=git-gecos.patch; charset=UTF-8
Content-Transfer-Encoding: base64

Y29tbWl0LXRyZWUuYzogZWM1M2E0NTY1ZWMwMDMzYWFmNmRmMmE0OGQyMzNjY2Y0ODIzZThiMA0K
LS0tIDEvY29tbWl0LXRyZWUuYw0KKysrIDIvY29tbWl0LXRyZWUuYwkyMDA1LTA0LTE4IDEyOjIy
OjE4LjAwMDAwMDAwMCArMDIwMA0KQEAgLTk2LDIxICs5Niw2IEBADQogCQlpZiAoIWMpDQogCQkJ
YnJlYWs7DQogCX0NCi0NCi0JLyoNCi0JICogR28gYmFjaywgYW5kIHJlbW92ZSBjcnVkIGZyb20g
dGhlIGVuZDogc29tZSBwZW9wbGUNCi0JICogaGF2ZSBjb21tYXMgZXRjIGluIHRoZWlyIGdlY29z
IGZpZWxkDQotCSAqLw0KLQlkc3QtLTsNCi0Jd2hpbGUgKC0tZHN0ID49IHApIHsNCi0JCXVuc2ln
bmVkIGNoYXIgYyA9ICpkc3Q7DQotCQlzd2l0Y2ggKGMpIHsNCi0JCWNhc2UgJywnOiBjYXNlICc7
JzogY2FzZSAnLic6DQotCQkJKmRzdCA9IDA7DQotCQkJY29udGludWU7DQotCQl9DQotCQlicmVh
azsNCi0JfQ0KIH0NCiANCiBzdGF0aWMgY29uc3QgY2hhciAqbW9udGhfbmFtZXNbXSA9IHsNCkBA
IC0zMTMsNiArMjk4LDExIEBADQogCWlmICghcHcpDQogCQlkaWUoIllvdSBkb24ndCBleGlzdC4g
R28gYXdheSEiKTsNCiAJcmVhbGdlY29zID0gcHctPnB3X2dlY29zOw0KKwkvKiBUaGUgbmFtZSBp
cyBzZXBlcmF0ZWQgZnJvbSB0aGUgcm9vbSBuby4sIHRlbCBubywgZXRjIHZpYSAnLCcgb3IgJzsn
ICovDQorCWlmIChzdHJjaHIocmVhbGdlY29zLCAnLCcpKQ0KKwkJcmVhbGdlY29zW3N0cmNocihy
ZWFsZ2Vjb3MsICcsJykgLSByZWFsZ2Vjb3NdID0gJ1wwJzsNCisJZWxzZSBpZiAoc3RyY2hyKHJl
YWxnZWNvcywgJzsnKSkNCisJCXJlYWxnZWNvc1tzdHJjaHIocmVhbGdlY29zLCAnOycpIC0gcmVh
bGdlY29zXSA9ICdcMCc7DQogCWxlbiA9IHN0cmxlbihwdy0+cHdfbmFtZSk7DQogCW1lbWNweShy
ZWFsZW1haWwsIHB3LT5wd19uYW1lLCBsZW4pOw0KIAlyZWFsZW1haWxbbGVuXSA9ICdAJzsNCg==


--=-bvF8f4aPuP9vDLxU7mhg--

--=-V47CTBMMf6tb6ci/RnY1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCY42tqburzKaJYLYRAvBqAJ4r1SZ33JK6zaKiOlbh52P+ihMvlgCgiTbN
2DEveuKXtXixHEPGbmZlHIw=
=NTHT
-----END PGP SIGNATURE-----

--=-V47CTBMMf6tb6ci/RnY1--

