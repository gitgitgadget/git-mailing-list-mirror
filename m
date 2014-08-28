From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 6/9] autoconf: Check for struct itimerspec
Date: Thu, 28 Aug 2014 03:04:19 +0200
Message-ID: <1409187862-21257-7-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:16:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoKM-0005rv-QU
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbaH1BQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:16:27 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59721 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbaH1BQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:16:25 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id 8B85540001D6A;
	Thu, 28 Aug 2014 01:06:14 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256067>

This type will be used in a following commit.

This type was not previously used by git. This can cause trouble for
people on systems without struct itimerspec if they only rely on
config.mak.uname. They will need to set NO_STRUCT_ITIMERSPEC manually.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>

---

This patch can be improved by finding out which systems doesn't have
struct itimerspec and adding entries for them to config.mak.uname.

 Makefile          | 5 +++++
 config.mak.uname  | 3 +++
 configure.ac      | 7 +++++++
 git-compat-util.h | 7 +++++++
 4 files changed, 22 insertions(+)

diff --git a/Makefile b/Makefile
index b76dc43..66329e4 100644
--- a/Makefile
+++ b/Makefile
@@ -191,6 +191,8 @@ all::
 # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
 # This also implies NO_SETITIMER
 #
+# Define NO_STRUCT_ITIMERSPEC if you don't have struct itimerspec
+#
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
 #
@@ -1357,6 +1359,9 @@ ifdef NO_STRUCT_ITIMERVAL
 	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
 	NO_SETITIMER = YesPlease
 endif
+ifdef NO_STRUCT_ITIMERSPEC
+	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERSPEC
+endif
 ifdef NO_SETITIMER
 	COMPAT_CFLAGS += -DNO_SETITIMER
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 892afc5..f0d93ef 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -98,6 +98,7 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
+	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
 	COMPAT_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 endif
@@ -358,6 +359,7 @@ ifeq ($(uname_S),Windows)
 	NO_TIMER_T = UnfortunatelyYes
 	NO_STRUCT_TIMESPEC = UnfortunatelyYes
 	NO_STRUCT_SIGEVENT = UnfortunatelyYes
+	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -510,6 +512,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_TIMER_T = UnfortunatelyYes
 	NO_STRUCT_TIMESPEC = UnfortunatelyYes
 	NO_STRUCT_SIGEVENT = UnfortunatelyYes
+	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
diff --git a/configure.ac b/configure.ac
index 00842ae..3c64251 100644
--- a/configure.ac
+++ b/configure.ac
@@ -768,6 +768,13 @@ AC_CHECK_TYPES([struct itimerval],
 [#include <sys/time.h>])
 GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
 #
+# Define NO_STRUCT_ITIMERSPEC if you don't have struct itimerspec.
+AC_CHECK_TYPES([struct itimerspec],
+[NO_STRUCT_ITIMERSPEC=],
+[NO_STRUCT_ITIMERSPEC=UnfortunatelyYes],
+[#include <time.h>])
+GIT_CONF_SUBST([NO_STRUCT_ITIMERSPEC])
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
diff --git a/git-compat-util.h b/git-compat-util.h
index 195eda6..4ef17df 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -217,6 +217,13 @@ struct itimerval {
 };
 #endif
 
+#ifdef NO_STRUCT_ITIMERSPEC
+struct itimerspec {
+	struct timespec it_interval;
+	struct timespec it_value;
+};
+#endif
+
 #ifdef NO_SETITIMER
 #define setitimer(which,value,ovalue)
 #endif
-- 
2.1.0
