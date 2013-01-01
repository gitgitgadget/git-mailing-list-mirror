From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/10] wildmatch: replace variable 'special' with better named ones
Date: Tue,  1 Jan 2013 09:44:04 +0700
Message-ID: <1357008251-10014-4-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:44:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TprqR-00005N-TU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab3AACo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:44:29 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:59020 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab3AACo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:44:28 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so7363583pad.26
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PV7qdfCOhWz/apIo23S6QmBXBlJp5YREsOMZXr94LY8=;
        b=JP9tFi0OvFBsVX6aaL7daz3AELrPe06rg9lpGgg3i2G56YNJmblpH0Fz4KRAoLC2uT
         1krNtMh+XZTKg4Ze6ulcrYrfYNXFzus455l/AV14y7JIzK2E1pH7elIf2YhNleVCz/rt
         dD7+Jp34cDNMsqygnXlFXaaAk+LvWQHPlAeI9i2R5eAr1MVfAUySOOA1DJQ7np8oJNp4
         1C0bKYd5+w/zn3feHbRjRPJIwfGBOOOs9K91ETAA+huXdIFW9ub2oYrboSKxBqegzdDs
         8cim4meApK8Lxz6TRZ/fYNgcBOnclJh7owPg9ysp1TAQ5YrckAhiVcm8W0TTj110Qfv+
         BQpA==
X-Received: by 10.68.189.65 with SMTP id gg1mr130560900pbc.57.1357008267686;
        Mon, 31 Dec 2012 18:44:27 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id oj1sm25823038pbb.19.2012.12.31.18.44.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:44:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:44:31 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212386>

'special' is too generic and is used for two different purposes.
Replace it with 'match_slash' to indicate "**" pattern and 'negated'
for "[!...]" and "[^...]".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 5f976e9..2d3ed84 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -61,7 +61,7 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 	const uchar *pattern =3D p;
=20
 	for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
-		int matched, special;
+		int matched, match_slash, negated;
 		uchar t_ch, prev_ch;
 		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
 			return ABORT_ALL;
@@ -103,15 +103,15 @@ static int dowild(const uchar *p, const uchar *te=
xt, int force_lower_case)
 					if (p[0] =3D=3D '/' &&
 					    dowild(p + 1, text, force_lower_case) =3D=3D MATCH)
 						return MATCH;
-					special =3D TRUE;
+					match_slash =3D TRUE;
 				} else
 					return ABORT_MALFORMED;
 			} else
-				special =3D FALSE;
+				match_slash =3D FALSE;
 			if (*p =3D=3D '\0') {
 				/* Trailing "**" matches everything.  Trailing "*" matches
 				 * only if there are no more slash characters. */
-				if (!special) {
+				if (!match_slash) {
 					if (strchr((char*)text, '/') !=3D NULL)
 						return NOMATCH;
 				}
@@ -121,9 +121,9 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 				if (t_ch =3D=3D '\0')
 					break;
 				if ((matched =3D dowild(p, text,  force_lower_case)) !=3D NOMATCH)=
 {
-					if (!special || matched !=3D ABORT_TO_STARSTAR)
+					if (!match_slash || matched !=3D ABORT_TO_STARSTAR)
 						return matched;
-				} else if (!special && t_ch =3D=3D '/')
+				} else if (!match_slash && t_ch =3D=3D '/')
 					return ABORT_TO_STARSTAR;
 				t_ch =3D *++text;
 			}
@@ -135,8 +135,8 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 				p_ch =3D NEGATE_CLASS;
 #endif
 			/* Assign literal TRUE/FALSE because of "matched" comparison. */
-			special =3D p_ch =3D=3D NEGATE_CLASS? TRUE : FALSE;
-			if (special) {
+			negated =3D p_ch =3D=3D NEGATE_CLASS? TRUE : FALSE;
+			if (negated) {
 				/* Inverted character class. */
 				p_ch =3D *++p;
 			}
@@ -218,7 +218,7 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 				} else if (t_ch =3D=3D p_ch)
 					matched =3D TRUE;
 			} while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
-			if (matched =3D=3D special || t_ch =3D=3D '/')
+			if (matched =3D=3D negated || t_ch =3D=3D '/')
 				return NOMATCH;
 			continue;
 		}
--=20
1.8.0.rc2.23.g1fb49df
