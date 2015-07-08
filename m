From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/9] gettext: add is_utf8_locale()
Date: Wed,  8 Jul 2015 17:38:36 +0700
Message-ID: <1436351919-2520-7-git-send-email-pclouds@gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 12:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmkY-0006rY-J5
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbbGHKil convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 06:38:41 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35344 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933815AbbGHKij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:38:39 -0400
Received: by pactm7 with SMTP id tm7so129735345pac.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jefxznRP16rbQQCjBpgQG3Tp5yOlMO14e23hlXqyUjI=;
        b=S1RuB2nz9HgIvOTQsKhb+1BSDcz9QP55LKm7IPvxRK2YG9Sg4yYgUNNqwVRyuz3qXB
         dCFryA+36B90rWhQcPjN/M5UWGa7TFbMtaEmqG0sVexUDPw+aSkDK/QVL1d33k1yBC2m
         /DOLOReFHhxD2HwVRJyMdi3rSx85hAmizEpTfrjbtdJTNc5wlB4PAcioIfLRQwqTJvOn
         igbm6RdM/CkT47BcEmS44OEQBn9z066BikByXsXUaORW3BJ9/+vRqdDGGr8xQjFqhpEF
         Xv+MYBSnU5Lg+tnuHNJpFKZwpOImzwi3meeD38qUhRZBnGLoeDqCOP8kmrQ5Bm1zOmv4
         LkWQ==
X-Received: by 10.66.62.163 with SMTP id z3mr19022950par.12.1436351918838;
        Wed, 08 Jul 2015 03:38:38 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id sh2sm2038462pbc.62.2015.07.08.03.38.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 03:38:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 17:39:24 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273663>

This function returns true if git is running under an UTF-8
locale. pcre in the next patch will need this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 gettext.c | 7 ++++++-
 gettext.h | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/gettext.c b/gettext.c
index 7378ba2..601bc80 100644
--- a/gettext.c
+++ b/gettext.c
@@ -166,12 +166,17 @@ void git_setup_gettext(void)
 	textdomain("git");
 }
=20
+int is_utf8_locale(void)
+{
+	return !strcmp(charset, "UTF-8");
+}
+
 /* return the number of columns of string 's' in current locale */
 int gettext_width(const char *s)
 {
 	static int is_utf8 =3D -1;
 	if (is_utf8 =3D=3D -1)
-		is_utf8 =3D !strcmp(charset, "UTF-8");
+		is_utf8 =3D is_utf8_locale();
=20
 	return is_utf8 ? utf8_strwidth(s) : strlen(s);
 }
diff --git a/gettext.h b/gettext.h
index 33696a4..5e733d4 100644
--- a/gettext.h
+++ b/gettext.h
@@ -31,6 +31,7 @@
 #ifndef NO_GETTEXT
 extern void git_setup_gettext(void);
 extern int gettext_width(const char *s);
+extern int is_utf8_locale(void);
 #else
 static inline void git_setup_gettext(void)
 {
@@ -39,6 +40,10 @@ static inline int gettext_width(const char *s)
 {
 	return strlen(s);
 }
+static inline int is_utf8_locale(void)
+{
+	return 0;
+}
 #endif
=20
 #ifdef GETTEXT_POISON
--=20
2.3.0.rc1.137.g477eb31
