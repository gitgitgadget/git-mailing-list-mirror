From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 05/12] MINGW: git-compat-util.h: use inttypes.h for printf macros.
Date: Mon, 28 Apr 2014 17:51:30 +0400
Message-ID: <1398693097-24651-6-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WelyT-0003a3-01
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbaD1Nv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:51:56 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56206 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbaD1Nvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:51 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyG-0004qo-29; Mon, 28 Apr 2014 17:51:48 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247329>

Also, pass -D__USE_MINGW_ANSI_STDIO=0 to select MSVCRT-compatible
macro definitions.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/mingw.h    |  2 --
 compat/msvc.h     |  3 +++
 config.mak.uname  |  3 ++-
 git-compat-util.h | 11 ++++++-----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 262b300..c502a22 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -342,8 +342,6 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 }
 #define find_last_dir_sep mingw_find_last_dir_sep
 #define PATH_SEP ';'
-#define PRIuMAX "I64u"
-#define PRId64 "I64d"
 
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
diff --git a/compat/msvc.h b/compat/msvc.h
index 580bb55..cb41ce3 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -15,6 +15,9 @@
 #define strtoull     _strtoui64
 #define strtoll      _strtoi64
 
+#define PRIuMAX "I64u"
+#define PRId64 "I64d"
+
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
 	int size1 = strlen(s1);
diff --git a/config.mak.uname b/config.mak.uname
index 6c2e6df..e5edae6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -321,6 +321,7 @@ ifeq ($(uname_S),Windows)
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
+	NO_INTTYPES_H = UnfortunatelyYes
 	NO_POLL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
@@ -502,7 +503,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..aa57a04 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,12 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
+#ifndef NO_INTTYPES_H
+#include <inttypes.h>
+#else
+#include <stdint.h>
+#endif
+
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 # if defined (_MSC_VER) && !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0502
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
