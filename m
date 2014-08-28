From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 8/9] autoconf: Check for timer_settime
Date: Thu, 28 Aug 2014 03:04:21 +0200
Message-ID: <1409187862-21257-9-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:16:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoKM-0005rv-4t
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbaH1BQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:16:26 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59720 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbaH1BQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:16:25 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id 16DA840001D6C;
	Thu, 28 Aug 2014 01:06:15 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256066>

This function will be used in a following commit.

The timer_settime function is provided in librt on some systems. We
already use this library sometimes to get clock_gettime, so rework the
logic so we don't link with it twice.

This function was not previously used by git. This can cause trouble for
people on systems without timer_settime if they only rely on
config.mak.uname. They will need to set NO_TIMER_SETTIME manually.

Add proper replacement function macros for setitimer and timer_settime
that evaluates the arguments and fails with ENOSYS to simulate stub
implementations. This will be useful in a following commit.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>

---

This patch can be improved by finding out which systems doesn't have
timer_settime and adding entries for them to config.mak.uname.

 Makefile          | 21 +++++++++++++++++++++
 config.mak.uname  |  3 +++
 configure.ac      |  8 ++++++++
 git-compat-util.h |  8 +++++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 66329e4..5609e44 100644
--- a/Makefile
+++ b/Makefile
@@ -182,16 +182,22 @@ all::
 #
 # Define NO_SETITIMER if you don't have setitimer()
 #
+# Define NO_TIMER_SETTIME if you don't have timer_settime()
+#
 # Define NO_TIMER_T if you don't have timer_t.
+# This also implies NO_SETITIMER
 #
 # Define NO_STRUCT_TIMESPEC if you don't have struct timespec
+# This also implies NO_SETITIMER
 #
 # Define NO_STRUCT_SIGEVENT if you don't have struct sigevent
+# This also implies NO_SETITIMER
 #
 # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
 # This also implies NO_SETITIMER
 #
 # Define NO_STRUCT_ITIMERSPEC if you don't have struct itimerspec
+# This also implies NO_TIMER_SETTIME
 #
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
@@ -1348,12 +1354,15 @@ ifdef OBJECT_CREATION_USES_RENAMES
 endif
 ifdef NO_TIMER_T
 	COMPAT_CFLAGS += -DNO_TIMER_T
+	NO_TIMER_SETTIME = YesPlease
 endif
 ifdef NO_STRUCT_TIMESPEC
 	COMPAT_CFLAGS += -DNO_STRUCT_TIMESPEC
+	NO_TIMER_SETTIME = YesPlease
 endif
 ifdef NO_STRUCT_SIGEVENT
 	COMPAT_CFLAGS += -DNO_STRUCT_SIGEVENT
+	NO_TIMER_SETTIME = YesPlease
 endif
 ifdef NO_STRUCT_ITIMERVAL
 	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
@@ -1361,10 +1370,14 @@ ifdef NO_STRUCT_ITIMERVAL
 endif
 ifdef NO_STRUCT_ITIMERSPEC
 	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERSPEC
+	NO_TIMER_SETTIME = YesPlease
 endif
 ifdef NO_SETITIMER
 	COMPAT_CFLAGS += -DNO_SETITIMER
 endif
+ifdef NO_TIMER_SETTIME
+	COMPAT_CFLAGS += -DNO_TIMER_SETTIME
+endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
@@ -1524,6 +1537,14 @@ endif
 
 ifdef HAVE_CLOCK_GETTIME
 	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
+	LINK_WITH_LIBRT = YesPlease
+endif
+
+ifndef NO_TIMER_SETTIME
+	LINK_WITH_LIBRT = YesPlease
+endif
+
+ifdef LINK_WITH_LIBRT
 	EXTLIBS += -lrt
 endif
 
diff --git a/config.mak.uname b/config.mak.uname
index f0d93ef..d04deab 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -99,6 +99,7 @@ ifeq ($(uname_S),Darwin)
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
 	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
+	NO_TIMER_SETTIME = UnfortunatelyYes
 	COMPAT_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 endif
@@ -360,6 +361,7 @@ ifeq ($(uname_S),Windows)
 	NO_STRUCT_TIMESPEC = UnfortunatelyYes
 	NO_STRUCT_SIGEVENT = UnfortunatelyYes
 	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
+	NO_TIMER_SETTIME = UnfortunatelyYes
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -513,6 +515,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_STRUCT_TIMESPEC = UnfortunatelyYes
 	NO_STRUCT_SIGEVENT = UnfortunatelyYes
 	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
+	NO_TIMER_SETTIME = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
diff --git a/configure.ac b/configure.ac
index 89eb48f..354bd38 100644
--- a/configure.ac
+++ b/configure.ac
@@ -945,6 +945,14 @@ GIT_CHECK_FUNC(setitimer,
 [NO_SETITIMER=YesPlease])
 GIT_CONF_SUBST([NO_SETITIMER])
 #
+# Define NO_TIMER_SETTIME if you don't have timer_settime
+GIT_CHECK_FUNC(timer_settime,
+[NO_TIMER_SETTIME=],
+[AC_SEARCH_LIBS(timer_settime,[rt],
+  [NO_TIMER_SETTIME=],
+  [NO_TIMER_SETTIME=YesPlease])])
+GIT_CONF_SUBST([NO_TIMER_SETTIME])
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
diff --git a/git-compat-util.h b/git-compat-util.h
index 4ef17df..91bbf6d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -225,7 +225,13 @@ struct itimerspec {
 #endif
 
 #ifdef NO_SETITIMER
-#define setitimer(which,value,ovalue)
+#define setitimer(which,value,ovalue) ((void) (which), (void) (value), (void) (ovalue), errno = ENOSYS, -1)
+#endif
+
+#ifdef NO_TIMER_SETTIMER
+#define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) (sevp), (void) (timerp), errno = ENOSYS, -1)
+#define timer_settime(timer, flags, value, ovalue) ((void) (timer), (void) (flags), (void) (value), (void) (ovalue), errno = ENOSYS, -1)
+#define timer_delete(timer) ((void) (timer), errno = ENOSYS, -1)
 #endif
 
 #ifndef NO_LIBGEN_H
-- 
2.1.0
