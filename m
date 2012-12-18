From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH v2 2/2] Port to QNX
Date: Tue, 18 Dec 2012 14:03:55 -0800
Message-ID: <1355868235-23173-3-git-send-email-kraai@ftbfs.org>
References: <1355868235-23173-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 23:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl5H4-0005ru-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 23:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab2LRWEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 17:04:13 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:59275 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab2LRWEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 17:04:12 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1Tl5Gk-00062i-PY; Tue, 18 Dec 2012 14:04:10 -0800
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1355868235-23173-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211791>

From: Matt Kraai <matt.kraai@amo.abbott.com>

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 Makefile          | 21 +++++++++++++++++++++
 git-compat-util.h |  6 +++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2c1f04f..a39dc83 100644
--- a/Makefile
+++ b/Makefile
@@ -80,6 +80,8 @@ all::
 #
 # Define NO_MEMMEM if you don't have memmem.
 #
+# Define NO_GETPAGESIZE if you don't have getpagesize.
+#
 # Define NO_STRLCPY if you don't have strlcpy.
 #
 # Define NO_STRTOUMAX if you don't have both strtoimax and strtoumax in the
@@ -1446,6 +1448,22 @@ else
 	NO_CURL = YesPlease
 endif
 endif
+ifeq ($(uname_S),QNX)
+	COMPAT_CFLAGS += -DSA_RESTART=0
+	HAVE_STRINGS_H = YesPlease
+	NEEDS_SOCKET = YesPlease
+	NO_FNMATCH_CASEFOLD = YesPlease
+	NO_GETPAGESIZE = YesPlease
+	NO_ICONV = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
+	NO_NSEC = YesPlease
+	NO_PTHREADS = YesPlease
+	NO_R_TO_GCC_LINKER = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
+endif
 
 -include config.mak.autogen
 -include config.mak
@@ -1863,6 +1881,9 @@ ifdef NO_MEMMEM
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
index a88147b..610e6b7 100644
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
@@ -413,6 +413,10 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
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
1.8.0.2.8.gc42826d.dirty
