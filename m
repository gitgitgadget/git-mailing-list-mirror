From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch] fixup GECOS handling
Date: Mon, 18 Apr 2005 14:58:20 +0200
Message-ID: <1113829100.16288.26.camel@nosferatu.lan>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cma7g+74tyWPiX0wOR3k"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 14:54:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNVl0-0002u3-BA
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 14:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVDRM5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 08:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVDRMzk
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 08:55:40 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:57240 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S262065AbVDRMyn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 08:54:43 -0400
Received: from gateway.lan (wblv-146-244-27.telkomadsl.co.za [165.146.244.27])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 44BAC5DB6;
	Mon, 18 Apr 2005 14:54:35 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id D63173A2544;
	Mon, 18 Apr 2005 15:00:47 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21614-01; Mon, 18 Apr 2005 15:00:36 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id B11CB3A24B9;
	Mon, 18 Apr 2005 15:00:35 +0200 (SAST)
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113827713.5286.13.camel@localhost.localdomain>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-cma7g+74tyWPiX0wOR3k
Content-Type: multipart/mixed; boundary="=-QdiSK6MagzB+0cDnm7Aq"


--=-QdiSK6MagzB+0cDnm7Aq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-18 at 22:35 +1000, David Woodhouse wrote:
> On Mon, 2005-04-18 at 12:36 +0200, Martin Schlemmer wrote:
> > realgecos[strchr(realgecos, ',') - realgecos] =3D '\0';
>=20
> Er, *strchr(realgecos, ',') =3D 0; surely? Even if the compiler is clever
> enough to optimise out the gratuitous addition and subtraction, that's
> no real excuse for it.
>=20

Err, right.  Updated patch.

The gecos is delimited by ',' or ';', so we should only use whatever
before the first ',' or ';' for the full name, and not just strip those.

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
+               *strchr(realgecos, ',') =3D 0;
+       else if (strchr(realgecos, ';'))
+               *strchr(realgecos, ';') =3D 0;
        len =3D strlen(pw->pw_name);
        memcpy(realemail, pw->pw_name, len);
        realemail[len] =3D '@';


--=20
Martin Schlemmer


--=-QdiSK6MagzB+0cDnm7Aq
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
ICovDQorCWlmIChzdHJjaHIocmVhbGdlY29zLCAnLCcpKQ0KKwkJKnN0cmNocihyZWFsZ2Vjb3Ms
ICcsJykgPSAwOw0KKwllbHNlIGlmIChzdHJjaHIocmVhbGdlY29zLCAnOycpKQ0KKwkJKnN0cmNo
cihyZWFsZ2Vjb3MsICc7JykgPSAwOw0KIAlsZW4gPSBzdHJsZW4ocHctPnB3X25hbWUpOw0KIAlt
ZW1jcHkocmVhbGVtYWlsLCBwdy0+cHdfbmFtZSwgbGVuKTsNCiAJcmVhbGVtYWlsW2xlbl0gPSAn
QCc7DQo=


--=-QdiSK6MagzB+0cDnm7Aq--

--=-cma7g+74tyWPiX0wOR3k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCY67sqburzKaJYLYRAvg6AJ9aVeQTzPCNyVczEz4HY+XOI1SL4gCfQzIz
Wlntmq38c/E5y3FZrbjme70=
=Cz17
-----END PGP SIGNATURE-----

--=-cma7g+74tyWPiX0wOR3k--

