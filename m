From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 7/9] autoconf: Check for struct itimerspec
Date: Fri, 29 Aug 2014 09:42:39 -0700
Message-ID: <1409330561-11806-7-git-send-email-jacob.e.keller@intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 18:43:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPH4-0007qr-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbaH2QnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:43:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:57264 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919AbaH2QnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:43:23 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 29 Aug 2014 09:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="378757894"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2014 09:38:37 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256162>

From: Jonas 'Sortie' Termansen <sortie@maxsi.org>

This type will be used in a following commit.

This type was not previously used by git. This can cause trouble for
people on systems without struct itimerspec if they only rely on
config.mak.uname. They will need to set NO_STRUCT_ITIMERSPEC manually.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Makefile          | 5 +++++
 config.mak.uname  | 3 +++
 configure.ac      | 7 +++++++
 git-compat-util.h | 7 +++++++
 4 files changed, 22 insertions(+)

diff --git a/Makefile b/Makefile
index b76dc4385952..66329e4b372b 100644
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
index 892afc573c28..f0d93ef868a7 100644
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
index 103b40704b6f..954f9ddb03c2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -769,6 +769,13 @@ AC_CHECK_TYPES([struct timespec],
 [#include <sys/time.h>])
 GIT_CONF_SUBST([NO_STRUCT_TIMESPEC])
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
index 195eda6f1575..4ef17df86b0e 100644
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
2.0.1.475.g9b8d714
