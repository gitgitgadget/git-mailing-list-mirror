From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] gettext.c: only work around the vsnprintf bug on glibc < 2.17
Date: Sat, 30 Nov 2013 19:01:24 +0700
Message-ID: <1385812884-23776-1-git-send-email-pclouds@gmail.com>
References: <1385776291-21006-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>, vnwildman@gmail.com,
	schwab@linux-m68k.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 30 12:57:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmjAv-0004su-Jp
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 12:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab3K3L5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 06:57:08 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43999 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3K3L5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 06:57:05 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so15162556pdj.11
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 03:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0kwWrv+7E7LwoeKsZkxA3D2/jvKQJoh20BWugeCqs8o=;
        b=k/tljfw2kSkFrBANm0OaYiDrYIeW+7u7sSh6bvqpoB9RuKr+uS8501taUg3iYdVEPH
         +vMQLlMW5PzxLHb5zzlEyEm7N2Vv8PW3mUyDCTug5ZsGE29xVcIhOpEapjI7UlqR82so
         uWlkDxnoPYQTwPxnFbgMxp270Eb+hGvZyhYOCX3bd1D7nFUAFUzMSx9OhLHiaWEjOYQM
         hJk4bvnLsTyovDpWLSkieLyZ2MOQeHn8leBsMw7y59xjxrMvLt4IHgqa//5326PgQ+f8
         rojOXWqNBuZo8aiW5lTIFtGDDyXaYoMmafkOuMk8GEtVB9IUxWC8NHwL5SRwfp+Zelx5
         Zy+Q==
X-Received: by 10.66.163.2 with SMTP id ye2mr1047413pab.170.1385812624975;
        Sat, 30 Nov 2013 03:57:04 -0800 (PST)
Received: from lanh ([115.73.206.217])
        by mx.google.com with ESMTPSA id vk17sm123045797pab.5.2013.11.30.03.57.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Nov 2013 03:57:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Nov 2013 19:01:43 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385776291-21006-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238556>

Bug 6530 [1] causes "git show v0.99.6~1" to fail with error "your
vsnprintf is broken". The workaround avoids that, but it corrupts
system error messages in non-C locales.

The bug has been fixed since 2.17. If git is built with glibc, it can
know running libc version with gnu_get_libc_version() and avoid the
workaround on fixed versions. The workaround is also dropped for all
non-glibc systems.

Tested on Gentoo Linux, glibc 2.17, amd64.

[1] http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2 removes USE_GLIBC and lets git-compat-util.h do the detection

 gettext.c         | 24 ++++++++++++++++--------
 git-compat-util.h | 11 +++++++++++
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/gettext.c b/gettext.c
index 71e9545..772ab92 100644
--- a/gettext.c
+++ b/gettext.c
@@ -30,7 +30,7 @@ int use_gettext_poison(void)
=20
 #ifndef NO_GETTEXT
 static const char *charset;
-static void init_gettext_charset(const char *domain)
+static void init_gettext_charset(const char *domain, int vsnprintf_bro=
ken)
 {
 	/*
 	   This trick arranges for messages to be emitted in the user's
@@ -99,9 +99,7 @@ static void init_gettext_charset(const char *domain)
 	   $ LANGUAGE=3D LANG=3Dde_DE.utf8 ./test
 	   test: Kein passendes Ger?t gefunden
=20
-	   In the long term we should probably see about getting that
-	   vsnprintf bug in glibc fixed, and audit our code so it won't
-	   fall apart under a non-C locale.
+	   The vsnprintf bug has been fixed since 2.17.
=20
 	   Then we could simply set LC_CTYPE from the environment, which woul=
d
 	   make things like the external perror(3) messages work.
@@ -112,21 +110,31 @@ static void init_gettext_charset(const char *doma=
in)
 	   1. http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530
 	   2. E.g. "Content-Type: text/plain; charset=3DUTF-8\n" in po/is.po
 	*/
-	setlocale(LC_CTYPE, "");
+	if (vsnprintf_broken)
+		setlocale(LC_CTYPE, "");
 	charset =3D locale_charset();
 	bind_textdomain_codeset(domain, charset);
-	setlocale(LC_CTYPE, "C");
+	if (vsnprintf_broken)
+		setlocale(LC_CTYPE, "C");
 }
=20
 void git_setup_gettext(void)
 {
 	const char *podir =3D getenv("GIT_TEXTDOMAINDIR");
+	const char *version =3D glibc_version();
+	int major, minor, vsnprintf_broken;
+
+	if (version && sscanf(version, "%d.%d", &major, &minor) =3D=3D 2 &&
+	    (major > 2 || (major =3D=3D 2 && minor >=3D 17)))
+		vsnprintf_broken =3D 0;
+	else
+		vsnprintf_broken =3D 1;
=20
 	if (!podir)
 		podir =3D GIT_LOCALE_PATH;
 	bindtextdomain("git", podir);
-	setlocale(LC_MESSAGES, "");
-	init_gettext_charset("git");
+	setlocale(vsnprintf_broken ? LC_MESSAGES : LC_ALL, "");
+	init_gettext_charset("git", vsnprintf_broken);
 	textdomain("git");
 }
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index 7776f12..967f452 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -488,11 +488,22 @@ extern int git_vsnprintf(char *str, size_t maxsiz=
e,
=20
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
+#include <gnu/libc-version.h>
+#define glibc_version() gnu_get_libc_version()
 #define HAVE_STRCHRNUL
 #define HAVE_MEMPCPY
 #endif
 #endif
=20
+#ifndef glibc_version
+#ifdef __GNU_LIBRARY__
+#define glibc_version() NULL
+#else
+/* non-glibc platforms, see git_setup_gettext() for "2.17" */
+#define glibc_version() "2.17"
+#endif
+#endif
+
 #ifndef HAVE_STRCHRNUL
 #define strchrnul gitstrchrnul
 static inline char *gitstrchrnul(const char *s, int c)
--=20
1.8.2.83.gc99314b
