From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] wildmatch: do not require "text" to be NUL-terminated
Date: Mon, 25 Mar 2013 13:05:07 +0700
Message-ID: <1364191510-8900-2-git-send-email-pclouds@gmail.com>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, avila.jn@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 07:06:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK0Xh-0001y6-EA
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 07:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab3CYGFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 02:05:34 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:50358 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab3CYGFd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 02:05:33 -0400
Received: by mail-pa0-f53.google.com with SMTP id bh4so619985pad.26
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=cJlHaP24vbflpJNoHFN7Jw43OeQMQlPvwLbh/K8G6eY=;
        b=Y8Iyg9xFT6TwVoRVuYH3dmmCBuOD0y3sRxmPcj9WXRkL7OhpPSkCov7w6ZMX4AXNRK
         QyOAK32yKuIqapTkTzYb7WHBP72HLwfa1MRlimvUCMqVbpnTExRfoxdPWLVlKReXqYXq
         s44dIfTdfLDqUkFwAW1JSiChWbggPDJHbV+0+pMeXlAPGRwXc7vk2Wz6bR2xtHrMj3kk
         E6IHyj4XtKGGXyhyR26dc2A45G2p9IBQUjnUpPeiwMhBKC/8Yrw154ommduBGrQF8pCf
         Dk8Y0fJgrY1tO2Wx3LK3CvF5QSrVhTdsYNP7YHvWmn61Fbj4Lk408iT9ueSThEf9JcLh
         hDHQ==
X-Received: by 10.66.253.232 with SMTP id ad8mr16561607pad.119.1364191532795;
        Sun, 24 Mar 2013 23:05:32 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id gf1sm750675pbb.33.2013.03.24.23.05.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 23:05:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 25 Mar 2013 13:05:24 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219007>

This may be helpful when we just want to match a part of "text".
nwildmatch can be used for this purpose.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 43 +++++++++++++++++++++++++------------------
 wildmatch.h | 11 +++++++++--
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 7192bdc..939bac8 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -52,7 +52,8 @@ typedef unsigned char uchar;
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
 /* Match pattern "p" against "text" */
-static int dowild(const uchar *p, const uchar *text, unsigned int flag=
s)
+static int dowild(const uchar *p, const uchar *text,
+		  const uchar *textend, unsigned int flags)
 {
 	uchar p_ch;
 	const uchar *pattern =3D p;
@@ -60,8 +61,13 @@ static int dowild(const uchar *p, const uchar *text,=
 unsigned int flags)
 	for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
 		int matched, match_slash, negated;
 		uchar t_ch, prev_ch;
-		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
-			return WM_ABORT_ALL;
+		if (text >=3D textend) {
+			if (p_ch !=3D '*')
+				return WM_ABORT_ALL;
+			else
+				t_ch =3D '\0';
+		} else
+			t_ch =3D *text;
 		if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
 			t_ch =3D tolower(t_ch);
 		if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
@@ -101,7 +107,7 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 					 * both foo/bar and foo/a/bar.
 					 */
 					if (p[0] =3D=3D '/' &&
-					    dowild(p + 1, text, flags) =3D=3D WM_MATCH)
+					    dowild(p + 1, text, textend, flags) =3D=3D WM_MATCH)
 						return WM_MATCH;
 					match_slash =3D 1;
 				} else
@@ -113,8 +119,9 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 				/* Trailing "**" matches everything.  Trailing "*" matches
 				 * only if there are no more slash characters. */
 				if (!match_slash) {
-					if (strchr((char*)text, '/') !=3D NULL)
-						return WM_NOMATCH;
+					for (;text < textend; text++)
+						if (*text =3D=3D '/')
+							return WM_NOMATCH;
 				}
 				return WM_MATCH;
 			} else if (!match_slash && *p =3D=3D '/') {
@@ -123,16 +130,15 @@ static int dowild(const uchar *p, const uchar *te=
xt, unsigned int flags)
 				 * with WM_PATHNAME matches the next
 				 * directory
 				 */
-				const char *slash =3D strchr((char*)text, '/');
-				if (!slash)
+				for (;text < textend; text++)
+					if (*text =3D=3D '/')
+						break;
+				if (text =3D=3D textend)
 					return WM_NOMATCH;
-				text =3D (const uchar*)slash;
 				/* the slash is consumed by the top-level for loop */
 				break;
 			}
-			while (1) {
-				if (t_ch =3D=3D '\0')
-					break;
+			while (text < textend) {
 				/*
 				 * Try to advance faster when an asterisk is
 				 * followed by a literal. We know in this case
@@ -145,18 +151,18 @@ static int dowild(const uchar *p, const uchar *te=
xt, unsigned int flags)
 					p_ch =3D *p;
 					if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
 						p_ch =3D tolower(p_ch);
-					while ((t_ch =3D *text) !=3D '\0' &&
+					while (text < textend &&
 					       (match_slash || t_ch !=3D '/')) {
 						if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
 							t_ch =3D tolower(t_ch);
 						if (t_ch =3D=3D p_ch)
 							break;
-						text++;
+						t_ch =3D ++text < textend ? *text : '\0';
 					}
 					if (t_ch !=3D p_ch)
 						return WM_NOMATCH;
 				}
-				if ((matched =3D dowild(p, text, flags)) !=3D WM_NOMATCH) {
+				if ((matched =3D dowild(p, text, textend, flags)) !=3D WM_NOMATCH)=
 {
 					if (!match_slash || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!match_slash && t_ch =3D=3D '/')
@@ -261,12 +267,13 @@ static int dowild(const uchar *p, const uchar *te=
xt, unsigned int flags)
 		}
 	}
=20
-	return *text ? WM_NOMATCH : WM_MATCH;
+	return text < textend ? WM_NOMATCH : WM_MATCH;
 }
=20
 /* Match the "pattern" against the "text" string. */
-int wildmatch(const char *pattern, const char *text,
+int nwildmatch(const char *pattern, const char *text, int textlen,
 	      unsigned int flags, struct wildopts *wo)
 {
-	return dowild((const uchar*)pattern, (const uchar*)text, flags);
+	return dowild((const uchar*)pattern, (const uchar*)text,
+		      (const uchar*)text + textlen, flags);
 }
diff --git a/wildmatch.h b/wildmatch.h
index 4090c8f..cdd7544 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -12,7 +12,14 @@
=20
 struct wildopts;
=20
-int wildmatch(const char *pattern, const char *text,
-	      unsigned int flags,
+int nwildmatch(const char *pattern, const char *text,
+	      int len, unsigned int flags,
 	      struct wildopts *wo);
+
+/* Match the "pattern" against the "text" string. */
+static inline int wildmatch(const char *pattern, const char *text,
+	      unsigned int flags, struct wildopts *wo)
+{
+	return nwildmatch(pattern, text, strlen(text), flags, wo);
+}
 #endif
--=20
1.8.2.82.gc24b958
