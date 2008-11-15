From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: introduce NO_PTHREADS
Date: Sat, 15 Nov 2008 04:08:14 -0800
Message-ID: <7vtza95h01.fsf@gitster.siamese.dyndns.org>
References: <200811121029.34841.thomas@koch.ro>
 <20081112173651.GA9127@linode.davidb.org>
 <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
 <loom.20081113T174625-994@post.gmane.org>
 <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 13:09:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1JyB-0006jn-M3
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 13:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbYKOMI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 07:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754999AbYKOMI0
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 07:08:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbYKOMIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 07:08:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2030A16BDD;
	Sat, 15 Nov 2008 07:08:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CB40A16BDE; Sat, 15 Nov 2008 07:08:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 18FDEF9A-B30E-11DD-94B7-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101062>

This introduces make variable NO_PTHREADS for platforms that lack the
support for pthreads library or people who do not want to use it for
whatever reason.  When defined, it makes the multi-threaded index
preloading into a no-op, and also disables threaded delta searching by
pack-objects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I notice a handful platforms do not define THREADED_DELTA_SEARCH, and
   on them Linus's preload-index.c is the first source file that includes
   <pthreads.h>, which may result in breakages.

 Makefile        |   10 +++++++++-
 config.mak.in   |    1 +
 configure.ac    |    5 +++++
 preload-index.c |    9 +++++++++
 4 files changed, 24 insertions(+), 1 deletions(-)

diff --git c/Makefile w/Makefile
index acac0ae..ffc9531 100644
--- c/Makefile
+++ w/Makefile
@@ -90,6 +90,8 @@ all::
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define NO_PTHREADS if you do not have or do not want to use Pthreads.
+#
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin.dll before v1.5.22).
 #
@@ -1018,9 +1020,15 @@ ifdef INTERNAL_QSORT
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
diff --git c/config.mak.in w/config.mak.in
index ea7705c..14dfb21 100644
--- c/config.mak.in
+++ w/config.mak.in
@@ -51,4 +51,5 @@ OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
+NO_PTHREADS=@NO_PTHREADS@
 PTHREAD_LIBS=@PTHREAD_LIBS@
diff --git c/configure.ac w/configure.ac
index 4256742..8821b50 100644
--- c/configure.ac
+++ w/configure.ac
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
diff --git c/preload-index.c w/preload-index.c
index 6253578..3ae83dc 100644
--- c/preload-index.c
+++ w/preload-index.c
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
