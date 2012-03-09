From: Martin Stenberg <martin@gnutiken.se>
Subject: [PATCH] fix incorrect line number report for bad gitconfig
Date: Fri, 9 Mar 2012 23:30:14 +0100
Message-ID: <20120309223014.GA6380@gnutiken.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Cc: Linus Torvalds <torvalds@osdl.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 23:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68U3-0006hF-MI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758382Ab2CIWkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:40:16 -0500
Received: from gnutiken.se ([109.74.202.65]:42167 "EHLO gnutiken.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755803Ab2CIWkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:40:15 -0500
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Mar 2012 17:40:15 EST
Received: from gnutiken.se (c-2ec2f5c3-74736162.cust.telenor.se [46.194.245.195])
	by gnutiken.se (Postfix) with ESMTPSA id 8F70EEA005;
	Fri,  9 Mar 2012 23:30:07 +0100 (CET)
Content-Disposition: inline
X-Disclaimer: 816148156
X-Mailer: mutt
X-Evilbit: 0
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192750>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom c88f00e06cb877f9d944fdec480f53a7a42dd990 Mon Sep 17 00:00:00 2001
=46rom: Martin Stenberg <martin@gnutiken.se>
Date: Fri, 9 Mar 2012 22:57:54 +0100
Subject: [PATCH] fix incorrect line number report for bad gitconfig

A .gitconfig section with a missing "]" reports the next line as beeing bad,
same goes to a value with a missing end quote.

This happens because the error is not detected until the end of the line, w=
hen
line number is already increased. Fix this issue by decreasing line number =
by
one for these cases.
Signed-off-by: Martin Stenberg <martin@gnutiken.se>
---
 config.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index ad03908..8d96ba1 100644
--- a/config.c
+++ b/config.c
@@ -196,8 +196,10 @@ static char *parse_value(void)
 	for (;;) {
 		int c =3D get_next_char();
 		if (c =3D=3D '\n') {
-			if (quote)
+			if (quote) {
+				cf->linenr--;
 				return NULL;
+			}
 			return cf->value.buf;
 		}
 		if (comment)
@@ -286,8 +288,10 @@ static int get_value(config_fn_t fn, void *data, char =
*name, unsigned int len)
 static int get_extended_base_var(char *name, int baselen, int c)
 {
 	do {
-		if (c =3D=3D '\n')
+		if (c =3D=3D '\n') {
+			cf->linenr--;
 			return -1;
+		}
 		c =3D get_next_char();
 	} while (isspace(c));
=20
@@ -298,14 +302,18 @@ static int get_extended_base_var(char *name, int base=
len, int c)
=20
 	for (;;) {
 		int c =3D get_next_char();
-		if (c =3D=3D '\n')
+		if (c =3D=3D '\n') {
+			cf->linenr--;
 			return -1;
+		}
 		if (c =3D=3D '"')
 			break;
 		if (c =3D=3D '\\') {
 			c =3D get_next_char();
-			if (c =3D=3D '\n')
+			if (c =3D=3D '\n') {
+				cf->linenr--;
 				return -1;
+			}
 		}
 		name[baselen++] =3D c;
 		if (baselen > MAXNAME / 2)
--=20
1.7.9.1


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPWoR2AAoJEGP7bLlG/aTxxDkP/3oAqLYZN3mWTgIMC0XNdNPk
FhL5hlIBbiDwbyD3WTnWPZIpCKMbxlIXqO5y+NLhA4tEIcvY1BKt3kr8Q3dlTl0/
S6/iNKMfdOTmcwmaI8hyRm1V+fivSWv9Qql2zYkO+QXgayYbgkoTwCbUvNi9m6im
zAfm43i9DX5AHTjFY7Pe5lcUQ5wrpBJM82Dc5+bsBlhoB57JWMtupIBKlik29vM2
g7YKvfYe7qeGc6FIKbK0W5qy8Lv2DH8ChEZ27LtpFqFX3Nsevx55lZ+f6AulqKVl
fb1J6ifMhIyX3gzprhlyj4Xx+Vxk5SU50I/JRSQYXqJoWRXINnOWqwuuWDrqK/iC
s7c8GVbtl+OTsbbRkCzHMYWV9ge/pFgbNqllM4VAD1FRTlBKYJsmFn454sk62D7x
fkcQCvhwwchLYyHRshoTYy8EYGjy2TBeA4GSCXP6A1PMCziKNHgSYanUCKsvBT9l
nMdXbbCWZrCqmKm77pW30N9jdwK2lfSr9ripPZki0R94wcmCjoNi3QFd83P4l5a3
2aJ1QIwia4Or7XikT1+vTj6QePIExNuFeSu+Pz4AFs8ckuHZAHN/45jDHgDCA6Y+
Xx9AL0JxOCY5sKWlj5jdiFbz5DtDjtIHLr2e96hNWEtZHFD8dUKRfQRefxoq52aa
ppHFp1Kz2Z/LjwALRGB0
=tsrL
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
