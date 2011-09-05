From: Nix <nix@esperi.org.uk>
Subject: [PATCH 1/2] Add strtoimax() compatibility function.
Date: Mon,  5 Sep 2011 12:45:54 +0100
Message-ID: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
Cc: Nix <nix@esperi.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 13:47:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0XeC-0002QC-M2
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 13:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab1IELqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 07:46:32 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:49595 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab1IELqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 07:46:21 -0400
Received: from esperi.org.uk (nix@mutilate.wkstn.nix [192.168.16.20])
	by mail.esperi.org.uk (8.14.4/8.14.3) with ESMTP id p85BkEBG005658;
	Mon, 5 Sep 2011 12:46:14 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.14.4/8.12.11/Submit) id p85BjwkY004251;
	Mon, 5 Sep 2011 12:45:58 +0100
X-Mailer: git-send-email 1.7.6.1.139.gcb612
X-DCC-STAT_FI_X86_64_VIRTUAL-Metrics: spindle 1245; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180737>

Since systems that omit strtoumax() will likely omit strtomax() too,
and likewise for strtoull() and strtoll(), we also adjust the
compatibility #defines from NO_STRTOUMAX to NO_STRTOMAX and from
NO_STRTOULL to NO_STRTOLL, and have them cover both the signed and
unsigned functions.

Signed-off-by: Nick Alcock <nix@esperi.org.uk>
---
 Makefile           |   36 ++++++++++++++++++------------------
 compat/strtoimax.c |   10 ++++++++++
 compat/strtoumax.c |    2 +-
 3 files changed, 29 insertions(+), 19 deletions(-)
 create mode 100644 compat/strtoimax.c

diff --git a/Makefile b/Makefile
index 6bf7d6c..0959e07 100644
--- a/Makefile
+++ b/Makefile
@@ -57,9 +57,9 @@ all::
 #
 # Define NO_STRLCPY if you don't have strlcpy.
 #
-# Define NO_STRTOUMAX if you don't have strtoumax in the C library.
-# If your compiler also does not support long long or does not have
-# strtoull, define NO_STRTOULL.
+# Define NO_STRTOMAX if you don't have both strtoimax and strtoumax in the
+# C library.  If your compiler also does not support long long or does
+# not have strtoll or strtoull, define NO_STRTOLL.
 #
 # Define NO_SETENV if you don't have setenv in the C library.
 #
@@ -804,7 +804,7 @@ ifeq ($(uname_S),OSF1)
 	# Need this for u_short definitions et al
 	BASIC_CFLAGS += -D_OSF_SOURCE
 	SOCKLEN_T = int
-	NO_STRTOULL = YesPlease
+	NO_STRTOLL = YesPlease
 	NO_NSEC = YesPlease
 endif
 ifeq ($(uname_S),Linux)
@@ -890,7 +890,7 @@ ifeq ($(uname_S),SunOS)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_STRLCPY = YesPlease
-		NO_STRTOUMAX = YesPlease
+		NO_STRTOMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
 	ifeq ($(uname_R),5.7)
@@ -900,19 +900,19 @@ ifeq ($(uname_S),SunOS)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_STRLCPY = YesPlease
-		NO_STRTOUMAX = YesPlease
+		NO_STRTOMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
 	ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
-		NO_STRTOUMAX = YesPlease
+		NO_STRTOMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
 	ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
-		NO_STRTOUMAX = YesPlease
+		NO_STRTOMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
 	INSTALL = /usr/ucb/install
@@ -954,7 +954,7 @@ ifeq ($(uname_S),FreeBSD)
 	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
 		PTHREAD_LIBS = -pthread
 		NO_UINTMAX_T = YesPlease
-		NO_STRTOUMAX = YesPlease
+		NO_STRTOMAX = YesPlease
 	endif
 	PYTHON_PATH = /usr/local/bin/python
 	HAVE_PATHS_H = YesPlease
@@ -1092,8 +1092,8 @@ ifeq ($(uname_S),Windows)
 	NO_MEMMEM = YesPlease
 	# NEEDS_LIBICONV = YesPlease
 	NO_ICONV = YesPlease
-	NO_STRTOUMAX = YesPlease
-	NO_STRTOULL = YesPlease
+	NO_STRTOMAX = YesPlease
+	NO_STRTOLL = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
@@ -1139,7 +1139,7 @@ ifeq ($(uname_S),Interix)
 	NO_IPV6 = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_STRTOUMAX = YesPlease
+	NO_STRTOMAX = YesPlease
 	NO_NSEC = YesPlease
 	NO_MKSTEMPS = YesPlease
 	ifeq ($(uname_R),3.5)
@@ -1184,7 +1184,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MEMMEM = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	OLD_ICONV = YesPlease
-	NO_STRTOUMAX = YesPlease
+	NO_STRTOMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_SVN_TESTS = YesPlease
@@ -1440,12 +1440,12 @@ ifdef NO_STRLCPY
 	COMPAT_CFLAGS += -DNO_STRLCPY
 	COMPAT_OBJS += compat/strlcpy.o
 endif
-ifdef NO_STRTOUMAX
-	COMPAT_CFLAGS += -DNO_STRTOUMAX
-	COMPAT_OBJS += compat/strtoumax.o
+ifdef NO_STRTOMAX
+	COMPAT_CFLAGS += -DNO_STRTOMAX
+	COMPAT_OBJS += compat/strtoumax.o compat/strtoimax.o
 endif
-ifdef NO_STRTOULL
-	COMPAT_CFLAGS += -DNO_STRTOULL
+ifdef NO_STRTOLL
+	COMPAT_CFLAGS += -DNO_STRTOLL
 endif
 ifdef NO_STRTOK_R
 	COMPAT_CFLAGS += -DNO_STRTOK_R
diff --git a/compat/strtoimax.c b/compat/strtoimax.c
new file mode 100644
index 0000000..fca07a3
--- /dev/null
+++ b/compat/strtoimax.c
@@ -0,0 +1,10 @@
+#include "../git-compat-util.h"
+
+intmax_t gitstrtoimax (const char *nptr, char **endptr, int base)
+{
+#if defined(NO_STRTOLL)
+	return strtol(nptr, endptr, base);
+#else
+	return strtoll(nptr, endptr, base);
+#endif
+}
diff --git a/compat/strtoumax.c b/compat/strtoumax.c
index 5541353..7feedfd 100644
--- a/compat/strtoumax.c
+++ b/compat/strtoumax.c
@@ -2,7 +2,7 @@
 
 uintmax_t gitstrtoumax (const char *nptr, char **endptr, int base)
 {
-#if defined(NO_STRTOULL)
+#if defined(NO_STRTOLL)
 	return strtoul(nptr, endptr, base);
 #else
 	return strtoull(nptr, endptr, base);
-- 
1.7.6.1.139.gcb612
