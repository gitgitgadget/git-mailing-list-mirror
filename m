From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/10] wildmatch: make dowild() take arbitrary flags
Date: Tue,  1 Jan 2013 09:44:06 +0700
Message-ID: <1357008251-10014-6-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:45:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tprqe-0000D0-9m
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab3AACom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:44:42 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:46470 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab3AACol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:44:41 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so5971651dae.17
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2MDjqZ0tZtzRjhEZofmAzaGshaHPxIvZm1qQdY9iKsU=;
        b=bmg5XtQi/+2DSBwDlv2rNGKI8F1RSzTwavnXZtl6b48iwCNZIR/3npt/fTojRTA5eJ
         Fe3n/54o/GrH8GvzX5DfzpJF1yXyapYiosjv15kOqtSDmalBj1SR/IVwgEbE+ePotatJ
         Y4UdKC7i7xDCirLHb2eQt7ajwAWXyd37PD+syqzZUGRbvvcIW9rczyKe2cBVmdjvsDiw
         +CXHFaT+5aXvb74zh6PRBVp3ZNT24vx9H/vd1BCECDkEpaFoYl8+H6dvatIR38dY1VL4
         pOoQBTZAqnf9KzXYy/pEn4NPBreyHCeVpsLgqlp3PQGLSCqfE464wzkZexmwFAgvpwCf
         pOsw==
X-Received: by 10.66.77.201 with SMTP id u9mr125235612paw.80.1357008280596;
        Mon, 31 Dec 2012 18:44:40 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id p10sm26650847pax.27.2012.12.31.18.44.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:44:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:44:44 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212387>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 2a655fa..1b5bbac 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -52,7 +52,7 @@ typedef unsigned char uchar;
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
 /* Match pattern "p" against "text" */
-static int dowild(const uchar *p, const uchar *text, int force_lower_c=
ase)
+static int dowild(const uchar *p, const uchar *text, unsigned int flag=
s)
 {
 	uchar p_ch;
 	const uchar *pattern =3D p;
@@ -62,9 +62,9 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 		uchar t_ch, prev_ch;
 		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
 			return WM_ABORT_ALL;
-		if (force_lower_case && ISUPPER(t_ch))
+		if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
 			t_ch =3D tolower(t_ch);
-		if (force_lower_case && ISUPPER(p_ch))
+		if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
 			p_ch =3D tolower(p_ch);
 		switch (p_ch) {
 		case '\\':
@@ -98,7 +98,7 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 					 * both foo/bar and foo/a/bar.
 					 */
 					if (p[0] =3D=3D '/' &&
-					    dowild(p + 1, text, force_lower_case) =3D=3D WM_MATCH)
+					    dowild(p + 1, text, flags) =3D=3D WM_MATCH)
 						return WM_MATCH;
 					match_slash =3D 1;
 				} else
@@ -117,7 +117,7 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
-				if ((matched =3D dowild(p, text,  force_lower_case)) !=3D WM_NOMAT=
CH) {
+				if ((matched =3D dowild(p, text, flags)) !=3D WM_NOMATCH) {
 					if (!match_slash || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!match_slash && t_ch =3D=3D '/')
@@ -228,6 +228,5 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 int wildmatch(const char *pattern, const char *text,
 	      unsigned int flags, struct wildopts *wo)
 {
-	return dowild((const uchar*)pattern, (const uchar*)text,
-		      flags & WM_CASEFOLD ? 1 :0);
+	return dowild((const uchar*)pattern, (const uchar*)text, flags);
 }
--=20
1.8.0.rc2.23.g1fb49df
