From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon,  1 Dec 2008 16:13:25 +0000
Message-ID: <1228148005-9404-1-git-send-email-mike@abacus.co.uk>
References: <4933A058.3050101@viscovery.net>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:31:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7BgG-00025o-HJ
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 17:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbYLAQ3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbYLAQ3w
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 11:29:52 -0500
Received: from [82.109.193.99] ([82.109.193.99]:10798 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750755AbYLAQ3v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 11:29:51 -0500
X-Greylist: delayed 1792 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Dec 2008 11:29:51 EST
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id 3F17918A302; Mon,  1 Dec 2008 16:13:25 +0000 (GMT)
X-Mailer: git-send-email 1.6.0.2.229.g1293c
In-Reply-To: <4933A058.3050101@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102059>

From: Junio C Hamano <gitster@pobox.com>

 This introduces make variable NO_PTHREADS for platforms that lack the
 support for pthreads library or people who do not want to use it for
 whatever reason.  When defined, it makes the multi-threaded index
 preloading into a no-op, and also disables threaded delta searching by
 pack-objects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---

* I notice a handful platforms do not define THREADED_DELTA_SEARCH, and
 on them Linus's preload-index.c is the first source file that includes
 <pthreads.h>, which may result in breakages.

 Made the default for AIX <5 and Mingw

 With correct commit message. Sorry for the previous attempt.

 Makefile        |   17 ++++++++++++++++-
 config.mak.in   |    1 +
 configure.ac    |    5 +++++
 preload-index.c |    9 +++++++++
 4 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d1e2116..5a69a41 100644
--- a/Makefile
+++ b/Makefile
@@ -90,6 +90,8 @@ all::
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define NO_PTHREADS if you do not have or do not want to use Pthreads.
+#
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin.dll before v1.5.22).
 #
@@ -164,6 +166,7 @@ uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
 uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
+uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
@@ -722,6 +725,11 @@ ifeq ($(uname_S),AIX)
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
+	ifneq ($(shell expr "$(uname_V)" : '[1234]'),1)
+		THREADED_DELTA_SEARCH = YesPlease
+	else
+		NO_PTHREADS = YesPlease
+	endif
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
@@ -766,6 +774,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
+	NO_PTHREADS = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	OLD_ICONV = YesPlease
 	NO_C99_FORMAT = YesPlease
@@ -1017,9 +1026,15 @@ ifdef INTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
 endif
 
+ifdef NO_PTHREADS
+	THREADED_DELTA_SEARCH =
+	BASIC_CFLAGS += -DNO_PTHREADS
+else
+	EXTLIBS += $(PTHREAD_LIBS)
+endif
+
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
-	EXTLIBS += $(PTHREAD_LIBS)
 	LIB_OBJS += thread-utils.o
 endif
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
diff --git a/config.mak.in b/config.mak.in
index ea7705c..14dfb21 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -51,4 +51,5 @@ OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
+NO_PTHREADS=@NO_PTHREADS@
 PTHREAD_LIBS=@PTHREAD_LIBS@
diff --git a/configure.ac b/configure.ac
index 4256742..8821b50 100644
--- a/configure.ac
+++ b/configure.ac
@@ -490,6 +490,8 @@ AC_SUBST(NO_MKDTEMP)
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
+# Define NO_PTHREADS if we do not have pthreads
+#
 # Define PTHREAD_LIBS to the linker flag used for Pthread support.
 AC_LANG_CONFTEST([AC_LANG_PROGRAM(
   [[#include <pthread.h>]],
@@ -502,9 +504,12 @@ else
  ${CC} -lpthread conftest.c -o conftest.o > /dev/null 2>&1
  if test $? -eq 0;then
   PTHREAD_LIBS="-lpthread"
+ else
+  NO_PTHREADS=UnfortunatelyYes
  fi
 fi
 AC_SUBST(PTHREAD_LIBS)
+AC_SUBST(NO_PTHREADS)
 
 ## Site configuration (override autodetection)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
diff --git a/preload-index.c b/preload-index.c
index a685583..88edc5f 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -2,6 +2,14 @@
  * Copyright (C) 2008 Linus Torvalds
  */
 #include "cache.h"
+
+#ifdef NO_PTHREADS
+static void preload_index(struct index_state *index, const char **pathspec)
+{
+	; /* nothing */
+}
+#else
+
 #include <pthread.h>
 
 /*
@@ -81,6 +89,7 @@ static void preload_index(struct index_state *index, const char **pathspec)
 			die("unable to join threaded lstat");
 	}
 }
+#endif
 
 int read_index_preload(struct index_state *index, const char **pathspec)
 {
-- 
1.6.0.2.229.g1293c.dirty
