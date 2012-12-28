From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/9] wildmatch: replace variable 'special' with better named ones
Date: Fri, 28 Dec 2012 11:10:47 +0700
Message-ID: <1356667854-8686-3-git-send-email-pclouds@gmail.com>
References: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 05:11:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToRIH-0000lG-W9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 05:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab2L1ELT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Dec 2012 23:11:19 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59769 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab2L1ELS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 23:11:18 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so5808132pad.24
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 20:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=pt78xAcI/8TYzfhQJiQdnOjt9Wle3Fs5/VRuIMCFgGs=;
        b=GwRgnQnRxg36/tRdGgvnFv2XJCaROnfa0BWVj7qLb6u7qntVvV+OQIEVDPuHVmlKXn
         3H3SuxVDqVMpy/40aMmIQSi+Q/nmw18ohUEzKlXM602Y8q5JhiNL8QB0NF6WgWaXKd2f
         dozTGf7qNwkVSi955GUUbnjyx3QRAM+70x/+a4b0iAeVmEW8h24rEpCCP1c9tsjMBEyz
         qmWq3nnWIiKPG7c4zltjdcAEupUWUPW9GgZlFyZa0SS/SWfjga53gcQJ+FtLy3XrqnuN
         npp9Anco3jox6ab6Kf3Wp+9PimTT29upHrR75QhbyyZnzs20vPw6Wl0qz9r/CPWz+QDI
         PiFg==
X-Received: by 10.66.73.132 with SMTP id l4mr95485566pav.48.1356667877063;
        Thu, 27 Dec 2012 20:11:17 -0800 (PST)
Received: from lanh ([115.74.54.149])
        by mx.google.com with ESMTPS id ot3sm18923188pbb.38.2012.12.27.20.11.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 20:11:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 28 Dec 2012 11:11:16 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212225>

'special' is too generic and is used for two different purposes.
Replace it with 'match_slash' to indicate "**" pattern and 'negated'
for "[!...]" and "[^...]".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 3972e26..8a58ad4 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -60,7 +60,7 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 	uchar p_ch;
=20
 	for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
-		int matched, special;
+		int matched, match_slash, negated;
 		uchar t_ch, prev_ch;
 		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
 			return ABORT_ALL;
@@ -102,15 +102,15 @@ static int dowild(const uchar *p, const uchar *te=
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
@@ -120,9 +120,9 @@ static int dowild(const uchar *p, const uchar *text=
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
@@ -134,8 +134,8 @@ static int dowild(const uchar *p, const uchar *text=
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
@@ -217,7 +217,7 @@ static int dowild(const uchar *p, const uchar *text=
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
