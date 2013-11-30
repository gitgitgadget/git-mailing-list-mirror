From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gettext.c: only work around the vsnprintf bug on glibc < 2.17
Date: Sat, 30 Nov 2013 08:51:31 +0700
Message-ID: <1385776291-21006-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>, vnwildman@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 30 02:47:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmZeR-0003ja-FW
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 02:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab3K3Bq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Nov 2013 20:46:58 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:53093 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab3K3Bq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 20:46:57 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so14685408pde.14
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 17:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=lP4SBUaNerJuRrlRZ0bAGNVCnzrjY6WHbg3LDJkO3GE=;
        b=B/WWBIPkZSk2ZR0QzL2smA0L8o567yI8RzaHtWlGrep2pm2QBsL/JZKFGP0vQHZlbI
         +RnyRFlifcI+bpqFmu68J5Wd7DGhcvM5rsPOG4EubZx5yRw2BasdlbMl25C5Ti9l5R8w
         lASsB/ULznrWmf6yjers2OqQVx04NTYPrcO4ErMw5lmdWB9N0tYwT30zRQqW3KtU8XKL
         K/vIxZG811Gbu7B5Lz6FoUx1gHvCj8TFSO2jB0E/6Yn6yHjXZRaRim7B8G4U0aO+CyV8
         MwWt1cobxMfdEvcXz0QPWTa6NdfludZssl0G/7Cs8lxw4/oVkSCZvBUUXTZb4WsVwU6P
         xJIQ==
X-Received: by 10.66.150.69 with SMTP id ug5mr55830385pab.55.1385776016896;
        Fri, 29 Nov 2013 17:46:56 -0800 (PST)
Received: from lanh ([115.73.206.217])
        by mx.google.com with ESMTPSA id ae5sm113893068pac.18.2013.11.29.17.46.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Nov 2013 17:46:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Nov 2013 08:51:35 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238546>

Bug 6530 [1] causes "git show v0.99.6~1" to fail with error "your
vsnprintf is broken". The workaround avoids that, but it corrupts
system error messages in non-C locales.

The bug has been fixed since 2.17. If git is built with glibc, it can
know running libc version with gnu_get_libc_version() and avoid the
workaround on fixed versions. As a side effect, the workaround is
dropped for all non-glibc systems.

Tested on Gentoo Linux, glibc 2.17, amd64.

[1] http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 We could even dlopen and look for gnu_get_libc_version at runtime and
 drop USE_GLIBC define. But there may be other problems with dl* on
 other platforms..

 Somebody should test for the other two "USE_GLIBC =3D YesPlease" I
 added. I don't have Debian/FreeBSD nor any non-Linux GNU systems.

 Makefile         |  5 +++++
 config.mak.uname |  3 +++
 gettext.c        | 34 ++++++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index af847f8..8df6d6d 100644
--- a/Makefile
+++ b/Makefile
@@ -66,6 +66,8 @@ all::
 # Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
 # need -lintl when linking.
 #
+# Define USE_GLIBC if your libc version is glibc >=3D 2.1.
+#
 # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
 # doesn't support GNU extensions like --check and --statistics
 #
@@ -1203,6 +1205,9 @@ ifndef NO_GETTEXT
 ifndef LIBC_CONTAINS_LIBINTL
 	EXTLIBS +=3D -lintl
 endif
+ifdef USE_GLIBC
+	BASIC_CFLAGS +=3D -DUSE_GLIBC
+endif
 endif
 ifdef NEEDS_SOCKET
 	EXTLIBS +=3D -lsocket
diff --git a/config.mak.uname b/config.mak.uname
index 82d549e..ffb01e0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -33,6 +33,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_PATHS_H =3D YesPlease
 	LIBC_CONTAINS_LIBINTL =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
+	USE_GLIBC =3D YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY =3D YesPlease
@@ -40,6 +41,7 @@ ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_PATHS_H =3D YesPlease
 	DIR_HAS_BSD_GROUP_SEMANTICS =3D YesPlease
 	LIBC_CONTAINS_LIBINTL =3D YesPlease
+	USE_GLIBC =3D YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC =3D cc
@@ -236,6 +238,7 @@ ifeq ($(uname_S),GNU)
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
 	LIBC_CONTAINS_LIBINTL =3D YesPlease
+	USE_GLIBC =3D YesPlease
 endif
 ifeq ($(uname_S),IRIX)
 	NO_SETENV =3D YesPlease
diff --git a/gettext.c b/gettext.c
index 71e9545..91e679d 100644
--- a/gettext.c
+++ b/gettext.c
@@ -18,6 +18,13 @@
 #	endif
 #endif
=20
+#ifdef USE_GLIBC
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <gnu/libc-version.h>
+#endif
+
 #ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
@@ -30,6 +37,7 @@ int use_gettext_poison(void)
=20
 #ifndef NO_GETTEXT
 static const char *charset;
+static int vsnprintf_workaround;
 static void init_gettext_charset(const char *domain)
 {
 	/*
@@ -99,9 +107,7 @@ static void init_gettext_charset(const char *domain)
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
@@ -112,20 +118,36 @@ static void init_gettext_charset(const char *doma=
in)
 	   1. http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530
 	   2. E.g. "Content-Type: text/plain; charset=3DUTF-8\n" in po/is.po
 	*/
-	setlocale(LC_CTYPE, "");
+	if (vsnprintf_workaround)
+		setlocale(LC_CTYPE, "");
 	charset =3D locale_charset();
 	bind_textdomain_codeset(domain, charset);
-	setlocale(LC_CTYPE, "C");
+	if (vsnprintf_workaround)
+		setlocale(LC_CTYPE, "C");
 }
=20
 void git_setup_gettext(void)
 {
 	const char *podir =3D getenv("GIT_TEXTDOMAINDIR");
=20
+#ifdef USE_GLIBC
+	int major, minor;
+	const char *version =3D gnu_get_libc_version();
+
+	if (version && sscanf(version, "%d.%d", &major, &minor) =3D=3D 2 &&
+	    (major > 2 || (major =3D=3D 2 && minor >=3D 17)))
+		vsnprintf_workaround =3D 0;
+	else
+		vsnprintf_workaround =3D 1;
+#endif
+
 	if (!podir)
 		podir =3D GIT_LOCALE_PATH;
 	bindtextdomain("git", podir);
-	setlocale(LC_MESSAGES, "");
+	if (vsnprintf_workaround)
+		setlocale(LC_MESSAGES, "");
+	else
+		setlocale(LC_ALL, "");
 	init_gettext_charset("git");
 	textdomain("git");
 }
--=20
1.8.2.83.gc99314b
