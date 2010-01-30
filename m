From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Make NO_PTHREADS the sole thread configuration variable
Date: Fri, 29 Jan 2010 19:22:19 -0600
Message-ID: <1264814539-27209-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 02:29:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb29C-00074Q-GF
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 02:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab0A3B3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 20:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755925Ab0A3B3G
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 20:29:06 -0500
Received: from mail-iw0-f187.google.com ([209.85.223.187]:48478 "EHLO
	mail-iw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab0A3B3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 20:29:05 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2010 20:29:05 EST
Received: by iwn17 with SMTP id 17so2844651iwn.25
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 17:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WY6K2zdWHW1m5x+kRUHzYEVA8xYaxdyewlN2U6Z+6T0=;
        b=jbJAK8eo7U5AyHmjDLhj9BSXKDPuaSsaB91aH/00XfiWtRHmPmxD3aLCttbv3LZPHI
         N2ME+h/EEUtrWLEqH8lxiAIGJ5vDKDvurG7ON8vwoCGs++r46DDheJ3R+H+7lPEVNluu
         ji0gXlghFr644itmOPNaAztDxbrETNe+RCctI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iJxLde9M2w4N2bVMs6a2lMrxHS3CRutNZinKGC70vTiEpifDB9PSsjt8e+rE+/JC/p
         vfbsEatE+aE+0pxaZYcfGU6JQ1Qy+nVw27fvWrjjKFafv5x4KHquhHyh3y1hVbxwJDE4
         o+gHM3LhmMTAElIyOhysgWF7NI0bROyKOk78U=
Received: by 10.231.146.211 with SMTP id i19mr2604255ibv.22.1264814543295;
        Fri, 29 Jan 2010 17:22:23 -0800 (PST)
Received: from localhost (adsl-99-140-180-147.dsl.chcgil.sbcglobal.net [99.140.180.147])
        by mx.google.com with ESMTPS id 21sm2468415iwn.6.2010.01.29.17.22.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 17:22:22 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138421>

When the first piece of threaded code was introduced in commit 8ecce684, it
came with its own THREADED_DELTA_SEARCH Makefile option. Since this time,
more threaded code has come into the codebase and a NO_PTHREADS option has
also been added. Get rid of the original option as the newer, more generic
option covers everything we need.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
From looking over the way we use these two variables, it doesn't appear we
have any cases where the two of these were out of sync. If I missed
something, feel free to let me know. I did see some recent discussion
regarding msys and threaded-grep, but that didn't come into play here. It
did make me shudder seeing yet another THREADED_* option get suggested,
however.

-Dan

 Makefile               |   24 ++----------------------
 builtin-pack-objects.c |   12 ++++++------
 configure.ac           |    9 ++-------
 3 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index af08c8f..83383c3 100644
--- a/Makefile
+++ b/Makefile
@@ -180,9 +180,6 @@ all::
 # If not set it defaults to the bare 'wish'. If it is set to the empty
 # string then NO_TCLTK will be forced (this is used by configure script).
 #
-# Define THREADED_DELTA_SEARCH if you have pthreads and wish to exploit
-# parallel delta searching when packing objects.
-#
 # Define INTERNAL_QSORT to use Git's implementation of qsort(), which
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
@@ -722,12 +719,10 @@ EXTLIBS =
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
@@ -781,7 +776,6 @@ ifeq ($(uname_S),Darwin)
 		NO_STRLCPY = YesPlease
 	endif
 	NO_MEMMEM = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
@@ -794,7 +788,6 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease
@@ -850,7 +843,6 @@ ifeq ($(uname_S),FreeBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
 		PTHREAD_LIBS = -pthread
 		NO_UINTMAX_T = YesPlease
@@ -864,7 +856,6 @@ ifeq ($(uname_S),OpenBSD)
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -872,7 +863,6 @@ ifeq ($(uname_S),NetBSD)
 	endif
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
-	THREADED_DELTA_SEARCH = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	NO_MKSTEMPS = YesPlease
 endif
@@ -887,9 +877,7 @@ ifeq ($(uname_S),AIX)
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
-	ifneq ($(shell expr "$(uname_V)" : '[1234]'),1)
-		THREADED_DELTA_SEARCH = YesPlease
-	else
+	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		NO_PTHREADS = YesPlease
 	endif
 endif
@@ -915,7 +903,6 @@ ifeq ($(uname_S),IRIX)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH = /usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
 	NO_SETENV=YesPlease
@@ -934,7 +921,6 @@ ifeq ($(uname_S),IRIX64)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
 	NO_IPV6=YesPlease
@@ -984,7 +970,6 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -1036,7 +1021,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
@@ -1334,16 +1318,12 @@ ifdef RUNTIME_PREFIX
 endif
 
 ifdef NO_PTHREADS
-	THREADED_DELTA_SEARCH =
 	BASIC_CFLAGS += -DNO_PTHREADS
 else
 	EXTLIBS += $(PTHREAD_LIBS)
-endif
-
-ifdef THREADED_DELTA_SEARCH
-	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
 	LIB_OBJS += thread-utils.o
 endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b0887d7..4a41547 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -17,7 +17,7 @@
 #include "progress.h"
 #include "refs.h"
 
-#ifdef THREADED_DELTA_SEARCH
+#ifndef NO_PTHREADS
 #include "thread-utils.h"
 #include <pthread.h>
 #endif
@@ -1255,7 +1255,7 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 	return 0;
 }
 
-#ifdef THREADED_DELTA_SEARCH
+#ifndef NO_PTHREADS
 
 static pthread_mutex_t read_mutex;
 #define read_lock()		pthread_mutex_lock(&read_mutex)
@@ -1380,7 +1380,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/*
 	 * Handle memory allocation outside of the cache
 	 * accounting lock.  Compiler will optimize the strangeness
-	 * away when THREADED_DELTA_SEARCH is not defined.
+	 * away when NO_PTHREADS is defined.
 	 */
 	free(trg_entry->delta_data);
 	cache_lock();
@@ -1567,7 +1567,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 	free(array);
 }
 
-#ifdef THREADED_DELTA_SEARCH
+#ifndef NO_PTHREADS
 
 /*
  * The main thread waits on the condition that (at least) one of the workers
@@ -1899,7 +1899,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		if (delta_search_threads < 0)
 			die("invalid number of threads specified (%d)",
 			    delta_search_threads);
-#ifndef THREADED_DELTA_SEARCH
+#ifdef NO_PTHREADS
 		if (delta_search_threads != 1)
 			warning("no threads support, ignoring %s", k);
 #endif
@@ -2227,7 +2227,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			delta_search_threads = strtoul(arg+10, &end, 0);
 			if (!arg[10] || *end || delta_search_threads < 0)
 				usage(pack_usage);
-#ifndef THREADED_DELTA_SEARCH
+#ifdef NO_PTHREADS
 			if (delta_search_threads != 1)
 				warning("no threads support, "
 					"ignoring %s", arg);
diff --git a/configure.ac b/configure.ac
index 78345eb..229140e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -762,10 +762,9 @@ AC_SUBST(NO_MKSTEMPS)
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
-# Define NO_PTHREADS if we do not have pthreads
+# Define NO_PTHREADS if we do not have pthreads.
 #
-# Define PTHREAD_LIBS to the linker flag used for Pthread support and define
-# THREADED_DELTA_SEARCH if Pthreads are available.
+# Define PTHREAD_LIBS to the linker flag used for Pthread support.
 AC_DEFUN([PTHREADTEST_SRC], [
 #include <pthread.h>
 
@@ -782,7 +781,6 @@ dnl   [[pthread_mutex_t test_mutex;]]
 dnl )])
 
 NO_PTHREADS=UnfortunatelyYes
-THREADED_DELTA_SEARCH=
 PTHREAD_LIBS=
 
 if test -n "$USER_NOPTHREAD"; then
@@ -798,7 +796,6 @@ elif test -z "$PTHREAD_CFLAGS"; then
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$opt"
-		THREADED_DELTA_SEARCH=YesPlease
 		break
 	],
 	[AC_MSG_RESULT([no])])
@@ -812,7 +809,6 @@ else
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$PTHREAD_CFLAGS"
-		THREADED_DELTA_SEARCH=YesPlease
 	],
 	[AC_MSG_RESULT([no])])
 
@@ -823,7 +819,6 @@ CFLAGS="$old_CFLAGS"
 
 AC_SUBST(PTHREAD_LIBS)
 AC_SUBST(NO_PTHREADS)
-AC_SUBST(THREADED_DELTA_SEARCH)
 
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
-- 
1.6.6.1
