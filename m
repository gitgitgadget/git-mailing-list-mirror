From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 4/9] autoconf: Check for struct sigevent
Date: Thu, 28 Aug 2014 03:04:17 +0200
Message-ID: <1409187862-21257-5-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:11:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoFQ-0001tm-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbaH1BL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:11:26 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59557 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbaH1BLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:11:25 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Aug 2014 21:11:25 EDT
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id 0AAD640001D68;
	Thu, 28 Aug 2014 01:06:14 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256059>

This type will be used in a following commit.

This type was not previously used by git. This can cause trouble for
people on systems without struct sigevent if they only rely on
config.mak.uname. They will need to set NO_STRUCT_SIGEVENT manually.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>

---

This patch can be improved by finding out which systems doesn't have
struct sigevent and adding entries for them to config.mak.uname.

 Makefile          |  5 +++++
 config.mak.uname  |  2 ++
 configure.ac      |  7 +++++++
 git-compat-util.h | 12 ++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/Makefile b/Makefile
index 0dd3e35..b76dc43 100644
--- a/Makefile
+++ b/Makefile
@@ -186,6 +186,8 @@ all::
 #
 # Define NO_STRUCT_TIMESPEC if you don't have struct timespec
 #
+# Define NO_STRUCT_SIGEVENT if you don't have struct sigevent
+#
 # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
 # This also implies NO_SETITIMER
 #
@@ -1348,6 +1350,9 @@ endif
 ifdef NO_STRUCT_TIMESPEC
 	COMPAT_CFLAGS += -DNO_STRUCT_TIMESPEC
 endif
+ifdef NO_STRUCT_SIGEVENT
+	COMPAT_CFLAGS += -DNO_STRUCT_SIGEVENT
+endif
 ifdef NO_STRUCT_ITIMERVAL
 	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
 	NO_SETITIMER = YesPlease
diff --git a/config.mak.uname b/config.mak.uname
index 8121791..892afc5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -357,6 +357,7 @@ ifeq ($(uname_S),Windows)
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_TIMER_T = UnfortunatelyYes
 	NO_STRUCT_TIMESPEC = UnfortunatelyYes
+	NO_STRUCT_SIGEVENT = UnfortunatelyYes
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -508,6 +509,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_TIMER_T = UnfortunatelyYes
 	NO_STRUCT_TIMESPEC = UnfortunatelyYes
+	NO_STRUCT_SIGEVENT = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
diff --git a/configure.ac b/configure.ac
index 5a5b167..31b3218 100644
--- a/configure.ac
+++ b/configure.ac
@@ -768,6 +768,13 @@ AC_CHECK_MEMBER(struct dirent.d_ino,
 [#include <dirent.h>])
 GIT_CONF_SUBST([NO_D_INO_IN_DIRENT])
 #
+# Define NO_STRUCT_SIGEVENT if you don't have struct sigevent.
+AC_CHECK_TYPES([struct sigevent],
+[NO_STRUCT_SIGEVENT=],
+[NO_STRUCT_SIGEVENT=UnfortunatelyYes],
+[#include <signal.h>])
+GIT_CONF_SUBST([NO_STRUCT_SIGEVENT])
+#
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
 AC_CHECK_MEMBER(struct dirent.d_type,
diff --git a/git-compat-util.h b/git-compat-util.h
index e9e7e54..195eda6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -198,6 +198,18 @@ struct timespec {
 };
 #endif
 
+#ifndef SIGEV_SIGNAL
+#define SIGEV_SIGNAL 1 /* dummy */
+#endif
+
+#ifdef NO_STRUCT_SIGEVENT
+struct sigevent /* dummy */
+{
+	int sigev_notify;
+	int sigev_signo;
+};
+#endif
+
 #ifdef NO_STRUCT_ITIMERVAL
 struct itimerval {
 	struct timeval it_interval;
-- 
2.1.0
