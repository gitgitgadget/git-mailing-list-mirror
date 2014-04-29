From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 06/12] MINGW: git-compat-util.h: use inttypes.h for printf macros
Date: Tue, 29 Apr 2014 13:12:00 +0400
Message-ID: <1398762726-22825-7-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf477-0006xI-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbaD2JOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:14:03 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:45046 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbaD2JMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:20 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45J-0006BN-8C; Tue, 29 Apr 2014 13:12:17 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247545>

All MinGW flavors have inttypes.h, so just include it.

However, we need to pass -D__USE_MINGW_ANSI_STDIO=0 to select
MSVCRT-compatible macro definitions on MinGW-W64:
http://sourceforge.net/apps/trac/mingw-w64/wiki/gnu%20printf

As a side-effect, Git no longer builds with MSVC < 2010 due to
its lack of stdint.h but hopefully that is not a problem.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/mingw.h    |  2 --
 compat/msvc.h     |  3 +++
 config.mak.uname  |  3 ++-
 git-compat-util.h | 11 ++++++-----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 7e3d038..2fbc8ea 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -339,8 +339,6 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 }
 #define find_last_dir_sep mingw_find_last_dir_sep
 #define PATH_SEP ';'
-#define PRIuMAX "I64u"
-#define PRId64 "I64d"
 
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
diff --git a/compat/msvc.h b/compat/msvc.h
index a63d878..84a03f9 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -17,6 +17,9 @@
 
 typedef int pid_t;
 
+#define PRIuMAX "I64u"
+#define PRId64 "I64d"
+
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
 	int size1 = strlen(s1);
diff --git a/config.mak.uname b/config.mak.uname
index a626410..50c1114 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -316,6 +316,7 @@ ifeq ($(uname_S),Windows)
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
+	NO_INTTYPES_H = UnfortunatelyYes
 	NO_POLL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
@@ -497,7 +498,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..65498a2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -95,6 +95,12 @@
 #define GIT_WINDOWS_NATIVE
 #endif
 
+#ifndef NO_INTTYPES_H
+#include <inttypes.h>
+#else
+#include <stdint.h>
+#endif
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -146,11 +152,6 @@
 #include <netdb.h>
 #include <pwd.h>
 #include <sys/un.h>
-#ifndef NO_INTTYPES_H
-#include <inttypes.h>
-#else
-#include <stdint.h>
-#endif
 #ifdef NO_INTPTR_T
 /*
  * On I16LP32, ILP32 and LP64 "long" is the save bet, however
-- 
1.9.1
