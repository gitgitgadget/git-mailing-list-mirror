From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 2/9] autoconf: Check for timer_t
Date: Thu, 28 Aug 2014 03:04:15 +0200
Message-ID: <1409187862-21257-3-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:11:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoFe-00025w-1L
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbaH1BLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:11:32 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59564 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbaH1BLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:11:25 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id 839A540001D66;
	Thu, 28 Aug 2014 01:06:13 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256063>

This type will be used in a following commit.

This type was not previously used by git. This can cause trouble for
people on systems without timer_t if they only rely on config.mak.uname.
They will need to set NO_TIMER_T manually.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>

---

This patch can be improved by finding out which systems doesn't have
timer_t and adding entries for them to config.mak.uname.

 Makefile          |  5 +++++
 config.mak.uname  |  2 ++
 configure.ac      | 10 +++++++++-
 git-compat-util.h |  4 ++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9f984a9..54266fd 100644
--- a/Makefile
+++ b/Makefile
@@ -182,6 +182,8 @@ all::
 #
 # Define NO_SETITIMER if you don't have setitimer()
 #
+# Define NO_TIMER_T if you don't have timer_t.
+#
 # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
 # This also implies NO_SETITIMER
 #
@@ -1338,6 +1340,9 @@ endif
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
+ifdef NO_TIMER_T
+	COMPAT_CFLAGS += -DNO_TIMER_T
+endif
 ifdef NO_STRUCT_ITIMERVAL
 	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
 	NO_SETITIMER = YesPlease
diff --git a/config.mak.uname b/config.mak.uname
index 15ee15e..a5297a2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -355,6 +355,7 @@ ifeq ($(uname_S),Windows)
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
 	NO_D_INO_IN_DIRENT = YesPlease
+	NO_TIMER_T = UnfortunatelyYes
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -504,6 +505,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
 	NO_D_INO_IN_DIRENT = YesPlease
+	NO_TIMER_T = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
diff --git a/configure.ac b/configure.ac
index 4b1ae7c..c57fd25 100644
--- a/configure.ac
+++ b/configure.ac
@@ -745,7 +745,15 @@ case $ac_cv_type_socklen_t in
   *)  	SOCKLEN_T=$git_cv_socklen_t_equiv;;
 esac
 GIT_CONF_SUBST([SOCKLEN_T])
-
+#
+# Define NO_TIMER_T if you don't have timer_t.
+AC_CHECK_TYPES([timer_t],
+[NO_TIMER_T=],
+[NO_TIMER_T=UnfortunatelyYes],
+[#include <sys/types.h>
+ #include <time.h>])
+GIT_CONF_SUBST([NO_TIMER_T])
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
diff --git a/git-compat-util.h b/git-compat-util.h
index f7fae20..e0e7a62 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -187,6 +187,10 @@ typedef unsigned long uintptr_t;
 extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
 #endif
 
+#ifdef NO_TIMER_T
+typedef int timer_t;
+#endif
+
 #ifdef NO_STRUCT_ITIMERVAL
 struct itimerval {
 	struct timeval it_interval;
-- 
2.1.0
