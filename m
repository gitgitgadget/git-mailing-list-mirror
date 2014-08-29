From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5/9] autoconf: Check for struct timespec
Date: Fri, 29 Aug 2014 09:42:37 -0700
Message-ID: <1409330561-11806-5-git-send-email-jacob.e.keller@intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 18:43:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPH6-0007qr-MM
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbaH2Qne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:43:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:14972 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbaH2QnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:43:23 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 29 Aug 2014 09:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="378757890"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2014 09:38:37 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256158>

From: Jonas 'Sortie' Termansen <sortie@maxsi.org>

This type will be used in a following commit.

This type was not previously used by git. This can cause trouble for
people on systems without struct timespec if they only rely on
config.mak.uname. They will need to set NO_STRUCT_TIMESPEC manually.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 Makefile          | 5 +++++
 config.mak.uname  | 2 ++
 configure.ac      | 7 +++++++
 git-compat-util.h | 7 +++++++
 4 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index 54266fd77eab..0dd3e35327c9 100644
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
index a5297a242561..812179159be2 100644
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
index 126af58365fb..bed8fe9c9590 100644
--- a/configure.ac
+++ b/configure.ac
@@ -762,6 +762,13 @@ AC_CHECK_TYPES([timer_t],
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
index e0e7a62b642a..e9e7e5451a99 100644
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
2.0.1.475.g9b8d714
