From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 6/9] autoconf: Check for struct sigevent
Date: Fri, 29 Aug 2014 09:42:38 -0700
Message-ID: <1409330561-11806-6-git-send-email-jacob.e.keller@intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 18:43:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPH3-0007qr-Q6
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbaH2QnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:43:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:57264 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbaH2QnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:43:23 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 29 Aug 2014 09:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="378757891"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2014 09:38:37 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256159>

From: Jonas 'Sortie' Termansen <sortie@maxsi.org>

This type will be used in a following commit.

This type was not previously used by git. This can cause trouble for
people on systems without struct sigevent if they only rely on
config.mak.uname. They will need to set NO_STRUCT_SIGEVENT manually.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 Makefile          |  5 +++++
 config.mak.uname  |  2 ++
 configure.ac      |  7 +++++++
 git-compat-util.h | 12 ++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/Makefile b/Makefile
index 0dd3e35327c9..b76dc4385952 100644
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
index 812179159be2..892afc573c28 100644
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
index bed8fe9c9590..103b40704b6f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -776,6 +776,13 @@ AC_CHECK_MEMBER(struct dirent.d_ino,
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
index e9e7e5451a99..195eda6f1575 100644
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
2.0.1.475.g9b8d714
