From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 17/19] Portable alloca for Git
Date: Mon, 24 Feb 2014 20:21:49 +0400
Message-ID: <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:22:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyIc-0004bE-6T
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbaBXQWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:22:11 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34280 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbaBXQWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:22:09 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyI9-000417-Qz; Mon, 24 Feb 2014 20:22:05 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyJo-0007AH-VR; Mon, 24 Feb 2014 20:23:48 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242607>

In the next patch we'll have to use alloca() for performance reasons,
but since alloca is non-standardized and is not portable, let's have a
trick with compatibility wrappers:

1. at configure time, determine, do we have working alloca() through
   alloca.h, and define

    #define HAVE_ALLOCA_H

   if yes.

2. in code

    #ifdef HAVE_ALLOCA_H
    # include <alloca.h>
    # define xalloca(size)      (alloca(size))
    # define xalloca_free(p)    do {} while(0)
    #else
    # define xalloca(size)      (xmalloc(size))
    # define xalloca_free(p)    (free(p))
    #endif

   and use it like

   func() {
       p = xalloca(size);
       ...

       xalloca_free(p);
   }

This way, for systems, where alloca is available, we'll have optimal
on-stack allocations with fast executions. On the other hand, on
systems, where alloca is not available, this gracefully fallbacks to
xmalloc/free.

Both autoconf and config.mak.uname configurations were updated. For
autoconf, we are not bothering considering cases, when no alloca.h is
available, but alloca() works some other way - its simply alloca.h is
available and works or not, everything else is deep legacy.

For config.mak.uname, I've tried to make my almost-sure guess for where
alloca() is available, but since I only have access to Linux it is the
only change I can be sure about myself, with relevant to other changed
systems people Cc'ed.

NOTE

SunOS and Windows had explicit -DHAVE_ALLOCA_H in their configurations.
I've changed that to now-common HAVE_ALLOCA_H=YesPlease which should be
correct.

Cc: Brandon Casey <drafnel@gmail.com>
Cc: Marius Storm-Olsen <mstormo@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Gerrit Pape <pape@smarden.org>
Cc: Petr Salinger <Petr.Salinger@seznam.cz>
Cc: Jonathan Nieder <jrnieder@gmail.com>
Cc: Thomas Schwinge <tschwinge@gnu.org>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

( new patch )

 Makefile          |  6 ++++++
 config.mak.uname  | 10 ++++++++--
 configure.ac      |  8 ++++++++
 git-compat-util.h |  8 ++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index dddaf4f..0334806 100644
--- a/Makefile
+++ b/Makefile
@@ -30,6 +30,8 @@ all::
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
+#
 # Define NO_CURL if you do not have libcurl installed.  git-http-fetch and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports (neither smart nor dumb).
@@ -1099,6 +1101,10 @@ ifdef USE_LIBPCRE
 	EXTLIBS += -lpcre
 endif
 
+ifdef HAVE_ALLOCA_H
+	BASIC_CFLAGS += -DHAVE_ALLOCA_H
+endif
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 	REMOTE_CURL_PRIMARY =
diff --git a/config.mak.uname b/config.mak.uname
index 7d31fad..71602ee 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -28,6 +28,7 @@ ifeq ($(uname_S),OSF1)
 	NO_NSEC = YesPlease
 endif
 ifeq ($(uname_S),Linux)
+	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
@@ -35,6 +36,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_DEV_TTY = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
+	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
@@ -103,6 +105,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
 	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
+	HAVE_ALLOCA_H = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
@@ -146,7 +149,7 @@ ifeq ($(uname_S),SunOS)
 	endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
-	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
+	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
 endif
 ifeq ($(uname_O),Cygwin)
 	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
@@ -166,6 +169,7 @@ ifeq ($(uname_O),Cygwin)
 	else
 		NO_REGEX = UnfortunatelyYes
 	endif
+	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
@@ -239,6 +243,7 @@ ifeq ($(uname_S),AIX)
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
+	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
@@ -316,6 +321,7 @@ endif
 ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
+	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
@@ -363,7 +369,7 @@ ifeq ($(uname_S),Windows)
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	PTHREAD_LIBS =
diff --git a/configure.ac b/configure.ac
index 2f43393..0eae704 100644
--- a/configure.ac
+++ b/configure.ac
@@ -272,6 +272,14 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
 #
+# Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
+AC_FUNC_ALLOCA
+case $ac_cv_working_alloca_h in
+    yes)    HAVE_ALLOCA_H=YesPlease;;
+    *)      HAVE_ALLOCA_H='';;
+esac
+GIT_CONF_SUBST([HAVE_ALLOCA_H])
+#
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..63b2b3b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -526,6 +526,14 @@ extern void release_pack_memory(size_t);
 typedef void (*try_to_free_t)(size_t);
 extern try_to_free_t set_try_to_free_routine(try_to_free_t);
 
+#ifdef HAVE_ALLOCA_H
+# include <alloca.h>
+# define xalloca(size)      (alloca(size))
+# define xalloca_free(p)    do {} while (0)
+#else
+# define xalloca(size)      (xmalloc(size))
+# define xalloca_free(p)    (free(p))
+#endif
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
-- 
1.9.rc1.181.g641f458
