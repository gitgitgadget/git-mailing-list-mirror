From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH 2/2] Port to QNX
Date: Fri, 14 Dec 2012 10:38:20 -0800
Message-ID: <1355510300-31541-3-git-send-email-kraai@ftbfs.org>
References: <1355510300-31541-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 19:39:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjaA6-0007gw-PY
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 19:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841Ab2LNSik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 13:38:40 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:57374 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756626Ab2LNSij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 13:38:39 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1Tja9d-0008Dh-Oe; Fri, 14 Dec 2012 10:38:37 -0800
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1355510300-31541-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211498>

From: Matt Kraai <matt.kraai@amo.abbott.com>

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 Makefile          | 19 +++++++++++++++++++
 git-compat-util.h |  8 ++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 736ecd4..ed2539d 100644
--- a/Makefile
+++ b/Makefile
@@ -78,6 +78,8 @@ all::
 #
 # Define NO_MEMMEM if you don't have memmem.
 #
+# Define NO_GETPAGESIZE if you don't have getpagesize.
+#
 # Define NO_STRLCPY if you don't have strlcpy.
 #
 # Define NO_STRTOUMAX if you don't have both strtoimax and strtoumax in the
@@ -1448,6 +1450,20 @@ else
 	NO_CURL = YesPlease
 endif
 endif
+ifeq ($(uname_S),QNX)
+	COMPAT_CFLAGS += -DSA_RESTART=0
+	NEEDS_SOCKET = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
+	NO_FNMATCH_CASEFOLD = YesPlease
+	NO_GETPAGESIZE = YesPlease
+	NO_ICONV = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_NSEC = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
+	PTHREAD_LIBS =
+endif
 
 -include config.mak.autogen
 -include config.mak
@@ -1859,6 +1875,9 @@ ifdef NO_MEMMEM
 	COMPAT_CFLAGS += -DNO_MEMMEM
 	COMPAT_OBJS += compat/memmem.o
 endif
+ifdef NO_GETPAGESIZE
+	COMPAT_CFLAGS += -DNO_GETPAGESIZE
+endif
 ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
diff --git a/git-compat-util.h b/git-compat-util.h
index 2e79b8a..6c588ca 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -75,7 +75,7 @@
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
       !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
-      !defined(__TANDEM)
+      !defined(__TANDEM) && !defined(__QNX__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
@@ -99,7 +99,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
-#ifdef __TANDEM /* or HAVE_STRINGS_H or !NO_STRINGS_H? */
+#if defined(__TANDEM) || defined(__QNX__) /* or HAVE_STRINGS_H or !NO_STRINGS_H? */
 #include <strings.h> /* for strcasecmp() */
 #endif
 #include <errno.h>
@@ -411,6 +411,10 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
                 const void *needle, size_t needlelen);
 #endif
 
+#ifdef NO_GETPAGESIZE
+#define getpagesize() sysconf(_SC_PAGESIZE)
+#endif
+
 #ifdef FREAD_READS_DIRECTORIES
 #ifdef fopen
 #undef fopen
-- 
1.8.1-rc1
