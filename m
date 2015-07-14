From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 6/9] gettext: add is_utf8_locale()
Date: Tue, 14 Jul 2015 20:24:37 +0700
Message-ID: <1436880280-18194-7-git-send-email-pclouds@gmail.com>
References: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
 <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 15:24:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0CT-0006WV-2x
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbbGNNYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:24:40 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36216 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbbGNNYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:24:40 -0400
Received: by pdjr16 with SMTP id r16so6048065pdj.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HNH6Os/KBbnbB4FUyRl3phsbSgEmO/hyZaw870axFqI=;
        b=i2RoI6Ieny9yZxZJcasVfWozEh1jDQVcI+r3bOmkbfRGzn0UUz8v74VzBg1/lt02kx
         S8mu8vOXHQ7rS8J0DhWf7uFIIp2DvChmTj2sohfEvZHgpJTJahKqhcVNQCOcpJXb4qY7
         T6da4qx/Kb69V6shi5m4e+oADh9WqSkxdxlSf4JpYd6ZnM0Ihv3pUtisK7LhNX5Cy2PQ
         REmzRVu5zo2EUhuSfWXLFhouH5gW86juK2leMN/kcSAZQ5A/xb1XcEXeboCVBlm4ViZO
         qO8bRMeo6IMpqdeYFYn9TkYe3i8ZzLdGMibOtIAzMa73nCQHmqCWAZ/ZJHBSpZnmNgZj
         IEPw==
X-Received: by 10.66.65.229 with SMTP id a5mr81247746pat.11.1436880279641;
        Tue, 14 Jul 2015 06:24:39 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id pa1sm1397627pdb.73.2015.07.14.06.24.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:24:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:25:29 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273958>

This function returns true if git is running under an UTF-8
locale. pcre in the next patch will need this.

is_encoding_utf8() is used instead of strcmp() to catch both "utf-8"
and "utf8" suffixes.

When built with no gettext support, we peek in several env variables
to detect UTF-8. pcre library might support utf-8 even if libc or git
is built without locale support.. The peeking code is a copy from
compat/regex/regcomp.c.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 gettext.c | 24 ++++++++++++++++++++++--
 gettext.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gettext.c b/gettext.c
index 7378ba2..aaf1688 100644
--- a/gettext.c
+++ b/gettext.c
@@ -18,6 +18,8 @@
 #	endif
 #endif
=20
+static const char *charset;
+
 /*
  * Guess the user's preferred languages from the value in LANGUAGE env=
ironment
  * variable and LC_MESSAGES locale category if NO_GETTEXT is not defin=
ed.
@@ -65,7 +67,6 @@ static int test_vsnprintf(const char *fmt, ...)
 	return ret;
 }
=20
-static const char *charset;
 static void init_gettext_charset(const char *domain)
 {
 	/*
@@ -171,8 +172,27 @@ int gettext_width(const char *s)
 {
 	static int is_utf8 =3D -1;
 	if (is_utf8 =3D=3D -1)
-		is_utf8 =3D !strcmp(charset, "UTF-8");
+		is_utf8 =3D is_utf8_locale();
=20
 	return is_utf8 ? utf8_strwidth(s) : strlen(s);
 }
 #endif
+
+int is_utf8_locale(void)
+{
+#ifdef NO_GETTEXT
+	if (!charset) {
+		const char *env =3D getenv("LC_ALL");
+		if (!env || !*env)
+			env =3D getenv("LC_CTYPE");
+		if (!env || !*env)
+			env =3D getenv("LANG");
+		if (!env)
+			env =3D "";
+		if (strchr(env, '.'))
+			env =3D strchr(env, '.') + 1;
+		charset =3D xstrdup(env);
+	}
+#endif
+	return is_encoding_utf8(charset);
+}
diff --git a/gettext.h b/gettext.h
index 33696a4..7eee64a 100644
--- a/gettext.h
+++ b/gettext.h
@@ -90,5 +90,6 @@ const char *Q_(const char *msgid, const char *plu, un=
signed long n)
 #endif
=20
 const char *get_preferred_languages(void);
+extern int is_utf8_locale(void);
=20
 #endif
--=20
2.3.0.rc1.137.g477eb31
