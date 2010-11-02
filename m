From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Support pthread with no recursive mutex (SunOS 5.6)
Date: Tue, 2 Nov 2010 14:12:27 +0000
Message-ID: <20101102141227.GA3991@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 15:21:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDHkI-0002Uf-1K
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 15:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab0KBOVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 10:21:48 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:63178 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0KBOVk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 10:21:40 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Nov 2010 10:21:40 EDT
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 1DCB35C34
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 14:32:01 +0000 (UTC)
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 74D2E753;
	Tue,  2 Nov 2010 14:12:27 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 5F0D2BAB2; Tue,  2 Nov 2010 14:12:27 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160521>

Thanks for merging my last patch series into the new release.  git 1.7.3.2
now compiles correctly on all of our hosts, save Solaris 2.6 (SunOS 5.6)
which has no recursive mutex support in its pthreads.  While we could
penalize that platform by disabling threads entirely, they worked perfectly
well up until this release.

This patch adds a new configure and Makefile setting to selectively disable
just the single recursive mutex usage in favour of the older implementation
that used a simple non-recursive mutex in the same spot, but on just Solaris
2.6.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile               |    4 ++++
 builtin/pack-objects.c |    4 ++++
 config.mak.in          |    1 +
 configure.ac           |   16 ++++++++++++++++
 thread-utils.c         |    2 ++
 thread-utils.h         |    2 ++
 6 files changed, 29 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -119,6 +119,9 @@ all::
 #
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
 #
+# Define NO_RECURSIVE_MUTEX if you do have Pthreads, but with no support for
+# recursive mutexs (SunOS 5.6).
+#
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin1.dll before v1.5.22).
 #
@@ -847,6 +850,7 @@ ifeq ($(uname_S),SunOS)
 		SOCKLEN_T = int
 		NO_HSTRERROR = YesPlease
 		NO_IPV6 = YesPlease
+		NO_RECURSIVE_MUTEX = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
Index: b/builtin/pack-objects.c
===================================================================
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1561,7 +1561,11 @@ static pthread_cond_t progress_cond;
  */
 static void init_threaded_search(void)
 {
+#ifndef NO_RECURSIVE_MUTEX
 	init_recursive_mutex(&read_mutex);
+#else
+	pthread_mutex_init(&read_mutex, NULL);
+#endif
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -876,6 +876,9 @@ AC_SUBST(NO_MKSTEMPS)
 # Define NO_PTHREADS if we do not have pthreads.
 #
 # Define PTHREAD_LIBS to the linker flag used for Pthread support.
+#
+# Define NO_RECURSIVE_MUTEX if you do have Pthreads, but with no support for
+# recursive mutexes (SunOS 5.6).
 AC_DEFUN([PTHREADTEST_SRC], [
 #include <pthread.h>
 
@@ -940,9 +943,22 @@ fi
 
 CFLAGS="$old_CFLAGS"
 
+if test $threads_found = yes; then
+  AC_MSG_CHECKING([Checking for PTHREAD_MUTEX_RECURSIVE support])
+  AC_EGREP_HEADER([PTHREAD_MUTEX_RECURSIVE], [pthread.h],
+	[], [NO_RECURSIVE_MUTEX=YesPlease])
+  if test -n "$NO_RECURSIVE_MUTEX"; then
+    AC_MSG_RESULT([no])
+  else
+    AC_MSG_RESULT([yes])
+  fi
+fi
+
+
 AC_SUBST(PTHREAD_CFLAGS)
 AC_SUBST(PTHREAD_LIBS)
 AC_SUBST(NO_PTHREADS)
+AC_SUBST(NO_RECURSIVE_MUTEX)
 
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
Index: b/thread-utils.c
===================================================================
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -45,6 +45,7 @@ int online_cpus(void)
 	return 1;
 }
 
+#ifndef NO_RECURSIVE_MUTEX
 int init_recursive_mutex(pthread_mutex_t *m)
 {
 	pthread_mutexattr_t a;
@@ -59,3 +60,4 @@ int init_recursive_mutex(pthread_mutex_t
 	}
 	return ret;
 }
+#endif
Index: b/thread-utils.h
===================================================================
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -2,6 +2,8 @@
 #define THREAD_COMPAT_H
 
 extern int online_cpus(void);
+#ifndef NO_RECURSIVE_MUTEX
 extern int init_recursive_mutex(pthread_mutex_t*);
+#endif
 
 #endif /* THREAD_COMPAT_H */
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -66,5 +66,6 @@ SOCKLEN_T=@SOCKLEN_T@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
 NO_PTHREADS=@NO_PTHREADS@
+NO_RECURSIVE_MUTEX=@NO_RECURSIVE_MUTEX@
 PTHREAD_CFLAGS=@PTHREAD_CFLAGS@
 PTHREAD_LIBS=@PTHREAD_LIBS@
--
Gary V. Vaughan (gary@thewrittenword.com)
