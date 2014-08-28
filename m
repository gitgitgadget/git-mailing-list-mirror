From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 3/9] autoconf: Check for struct timespec
Date: Thu, 28 Aug 2014 03:04:16 +0200
Message-ID: <1409187862-21257-4-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoFd-00025w-1L
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbaH1BLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:11:31 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59566 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbaH1BL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:11:26 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id C1D4940001D67;
	Thu, 28 Aug 2014 01:06:13 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256061>

This type will be used in a following commit.

This type was not previously used by git. This can cause trouble for
people on systems without struct timespec if they only rely on
config.mak.uname. They will need to set NO_STRUCT_TIMESPEC manually.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>

---

This patch can be improved by finding out which systems doesn't have
struct timespec and adding entries for them to config.mak.uname.

 Makefile          | 5 +++++
 config.mak.uname  | 2 ++
 configure.ac      | 7 +++++++
 git-compat-util.h | 7 +++++++
 4 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index 54266fd..0dd3e35 100644
--- a/Makefile
+++ b/Makefile
@@ -184,6 +184,8 @@ all::
 #
 # Define NO_TIMER_T if you don't have timer_t.
 #
+# Define NO_STRUCT_TIMESPEC if you don't have struct timespec
+#
 # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
 # This also implies NO_SETITIMER
 #
@@ -1343,6 +1345,9 @@ endif
 ifdef NO_TIMER_T
 	COMPAT_CFLAGS += -DNO_TIMER_T
 endif
+ifdef NO_STRUCT_TIMESPEC
+	COMPAT_CFLAGS += -DNO_STRUCT_TIMESPEC
+endif
 ifdef NO_STRUCT_ITIMERVAL
 	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
 	NO_SETITIMER = YesPlease
diff --git a/config.mak.uname b/config.mak.uname
index a5297a2..8121791 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -356,6 +356,7 @@ ifeq ($(uname_S),Windows)
 	DEFAULT_HELP_FORMAT = html
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_TIMER_T = UnfortunatelyYes
+	NO_STRUCT_TIMESPEC = UnfortunatelyYes
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -506,6 +507,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	DEFAULT_HELP_FORMAT = html
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_TIMER_T = UnfortunatelyYes
+	NO_STRUCT_TIMESPEC = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
diff --git a/configure.ac b/configure.ac
index c57fd25..5a5b167 100644
--- a/configure.ac
+++ b/configure.ac
@@ -754,6 +754,13 @@ AC_CHECK_TYPES([timer_t],
  #include <time.h>])
 GIT_CONF_SUBST([NO_TIMER_T])
 #
+# Define NO_STRUCT_TIMESPEC if you don't have struct timespec.
+AC_CHECK_TYPES([struct timespec],
+[NO_STRUCT_TIMESPEC=],
+[NO_STRUCT_TIMESPEC=UnfortunatelyYes],
+[#include <sys/time.h>])
+GIT_CONF_SUBST([NO_STRUCT_TIMESPEC])
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
diff --git a/git-compat-util.h b/git-compat-util.h
index e0e7a62..e9e7e54 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -191,6 +191,13 @@ extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
 typedef int timer_t;
 #endif
 
+#ifdef NO_STRUCT_TIMESPEC
+struct timespec {
+	time_t tv_sec;
+	long tv_nsec;
+};
+#endif
+
 #ifdef NO_STRUCT_ITIMERVAL
 struct itimerval {
 	struct timeval it_interval;
-- 
2.1.0
