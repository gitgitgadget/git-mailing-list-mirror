From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: [PATCH] MSVC: Windows-native implementation for subset of Pthreads API
Date: Fri,  6 Nov 2009 09:10:59 +0100
Message-ID: <1257495059-12394-1-git-send-email-ahaczewski@gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 09:11:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Jug-0001w1-67
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 09:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbZKFILE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 03:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbZKFILE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 03:11:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:60079 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbZKFILD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 03:11:03 -0500
Received: by fg-out-1718.google.com with SMTP id e12so140711fga.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0Q3w2yuc2lFwu2ChR9DmV7B7a3qL0S8IiL5BIMjCK7c=;
        b=jHRjdkU2KUWYJeNTce3zmeDln7teML3rhReUkluidL78Yak9ZMELdGTMnDNoYtb0/k
         ygijf1ZFA1EGUlRm7a+M26Is36GAzLPcAmYz0DAdkeUo1JQ7vJmR8BWt+7dltoDdpKHK
         XH1d+Z7+5rKelgUqfNfMg0kzin/dWqbYu+wj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kpVNGzIiUodMmdK2egFR1NHQjYtsijgiOJA4MlIynGltXp9G0srjxQLm5QadB7Gs5a
         bH+3J98RR/99IGGEHNq2r9DW50S5HkhIIGCr45YquRRAqRwzv7YB0yhh/J93bHO2eXxT
         ttp2DWzq3nkl0SrXKokQDG5oGWHr+B8KlTsVM=
Received: by 10.86.235.29 with SMTP id i29mr5563420fgh.57.1257495066957;
        Fri, 06 Nov 2009 00:11:06 -0800 (PST)
Received: from endru-ubuntu ([85.232.239.146])
        by mx.google.com with ESMTPS id 3sm5611850fge.29.2009.11.06.00.11.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 00:11:06 -0800 (PST)
Received: by endru-ubuntu (Postfix, from userid 1000)
	id A5FA01E78F2; Fri,  6 Nov 2009 09:11:11 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132280>

This patch implements native to Windows subset of pthreads API used by Git.
It allows to remove Pthreads for Win32 dependency for MSVC, msysgit and
Cygwin.

The patch modifies Makefile only for MSVC (that's the environment I'm
capable of testing on), so it requires further corrections to compile
with MinGW or Cygwin.

Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>
---
One more round of that patch with Nicolas' comments considered, and
disclamer about the implementation added.

Johannes, can you replace previous commit with that patch?

 Makefile               |    7 ++-
 builtin-pack-objects.c |   31 +++++++++++--
 compat/mingw.c         |    2 +-
 compat/mingw.h         |    5 ++
 compat/win32/pthread.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/pthread.h |   68 +++++++++++++++++++++++++++
 6 files changed, 225 insertions(+), 8 deletions(-)
 create mode 100644 compat/win32/pthread.c
 create mode 100644 compat/win32/pthread.h

diff --git a/Makefile b/Makefile
index bc039ac..30089a8 100644
--- a/Makefile
+++ b/Makefile
@@ -453,6 +453,7 @@ LIB_H += commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
+LIB_H += compat/win32/pthread.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -971,15 +972,15 @@ ifdef MSVC
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
-	NO_PTHREADS = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 	BLK_SHA1 = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	lib =
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..00594fd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1255,15 +1255,15 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 
 #ifdef THREADED_DELTA_SEARCH
 
-static pthread_mutex_t read_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t read_mutex;
 #define read_lock()		pthread_mutex_lock(&read_mutex)
 #define read_unlock()		pthread_mutex_unlock(&read_mutex)
 
-static pthread_mutex_t cache_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t cache_mutex;
 #define cache_lock()		pthread_mutex_lock(&cache_mutex)
 #define cache_unlock()		pthread_mutex_unlock(&cache_mutex)
 
-static pthread_mutex_t progress_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t progress_mutex;
 #define progress_lock()		pthread_mutex_lock(&progress_mutex)
 #define progress_unlock()	pthread_mutex_unlock(&progress_mutex)
 
@@ -1590,7 +1590,26 @@ struct thread_params {
 	unsigned *processed;
 };
 
-static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
+static pthread_cond_t progress_cond;
+
+/*
+ * Mutex and conditional variable can't be statically-initialized on Windows.
+ */
+static void init_threaded_search()
+{
+	pthread_mutex_init(&read_mutex, NULL);
+	pthread_mutex_init(&cache_mutex, NULL);
+	pthread_mutex_init(&progress_mutex, NULL);
+	pthread_cond_init(&progress_cond, NULL);
+}
+
+static void cleanup_threaded_search()
+{
+	pthread_cond_destroy(&progress_cond);
+	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&cache_mutex);
+	pthread_mutex_destroy(&progress_mutex);
+}
 
 static void *threaded_find_deltas(void *arg)
 {
@@ -1629,8 +1648,11 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	struct thread_params *p;
 	int i, ret, active_threads = 0;
 
+	init_threaded_search();
+
 	if (delta_search_threads <= 1) {
 		find_deltas(list, &list_size, window, depth, processed);
+		cleanup_threaded_search();
 		return;
 	}
 	if (progress > pack_to_stdout)
@@ -1745,6 +1767,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			active_threads--;
 		}
 	}
+	cleanup_threaded_search();
 	free(p);
 }
 
diff --git a/compat/mingw.c b/compat/mingw.c
index 6b5b5b2..f2e9f02 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -5,7 +5,7 @@
 
 #include <shellapi.h>
 
-static int err_win_to_posix(DWORD winerr)
+int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
 	switch(winerr) {
diff --git a/compat/mingw.h b/compat/mingw.h
index 6907345..7e25fb5 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -294,3 +294,8 @@ struct mingw_dirent
 #define readdir(x) mingw_readdir(x)
 struct dirent *mingw_readdir(DIR *dir);
 #endif // !NO_MINGW_REPLACE_READDIR
+
+/*
+ * Used by Pthread API implementation for Windows
+ */
+extern int err_win_to_posix(DWORD winerr);
diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
new file mode 100644
index 0000000..652d7b4
--- /dev/null
+++ b/compat/win32/pthread.c
@@ -0,0 +1,120 @@
+/*
+ * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
+ *
+ * DISCLAMER: The implementation is Git-specific, it is subset of original
+ * Pthreads API, without lots of other features that Git doesn't use.
+ * Git also makes sure that the passed arguments are valid, so there's
+ * no need for double-checking.
+ */
+
+#include "../../git-compat-util.h"
+#include "pthread.h"
+
+#include <errno.h>
+#include <limits.h>
+
+static unsigned __stdcall win32_start_routine(void *arg)
+{
+	pthread_t *thread = arg;
+	thread->arg = thread->start_routine(thread->arg);
+	return 0;
+}
+
+int pthread_create(pthread_t *thread, const void *unused,
+		   void *(*start_routine)(void*), void *arg)
+{
+	thread->arg = arg;
+	thread->start_routine = start_routine;
+	thread->handle = (HANDLE)
+		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);
+
+	if (!thread->handle)
+		return errno;
+	else
+		return 0;
+}
+
+int win32_pthread_join(pthread_t *thread, void **value_ptr)
+{
+	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
+	switch (result) {
+		case WAIT_OBJECT_0:
+			if (value_ptr)
+				*value_ptr = thread->arg;
+			return 0;
+		case WAIT_ABANDONED:
+			return EINVAL;
+		default:
+			return err_win_to_posix(GetLastError());
+	}
+}
+
+int pthread_cond_init(pthread_cond_t *cond, const void *unused)
+{
+	cond->waiters = 0;
+
+	InitializeCriticalSection(&cond->waiters_lock);
+
+	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
+	if (!cond->sema)
+		die("CreateSemaphore() failed");
+	return 0;
+}
+
+int pthread_cond_destroy(pthread_cond_t *cond)
+{
+	CloseHandle(cond->sema);
+	cond->sema = NULL;
+
+	DeleteCriticalSection(&cond->waiters_lock);
+
+	return 0;
+}
+
+int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
+{
+	/* serialize access to waiters count */
+	EnterCriticalSection(&cond->waiters_lock);
+	++cond->waiters;
+	LeaveCriticalSection(&cond->waiters_lock);
+
+	/*
+	 * Unlock external mutex and wait for signal.
+	 * NOTE: we've held mutex locked long enough to increment
+	 * waiters count above, so there's no problem with
+	 * leaving mutex unlocked before we wait on semaphore.
+	 */
+	LeaveCriticalSection(mutex);
+
+	/* let's wait - ignore return value */
+	WaitForSingleObject(cond->sema, INFINITE);
+
+	/* we're done waiting, so make sure we decrease waiters count */
+	EnterCriticalSection(&cond->waiters_lock);
+	--cond->waiters;
+	LeaveCriticalSection(&cond->waiters_lock);
+
+	/* lock external mutex again */
+	EnterCriticalSection(mutex);
+
+	return 0;
+}
+
+int pthread_cond_signal(pthread_cond_t *cond)
+{
+	int have_waiters;
+
+	/* serialize access to waiters count */
+	EnterCriticalSection(&cond->waiters_lock);
+	have_waiters = cond->waiters > 0;
+	LeaveCriticalSection(&cond->waiters_lock);
+
+	/*
+	 * Signal only when there are waiters
+	 */
+	if (have_waiters)
+		return ReleaseSemaphore(cond->sema, 1, NULL) ?
+			0 : err_win_to_posix(GetLastError());
+	else
+		return 0;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
new file mode 100644
index 0000000..63293ad
--- /dev/null
+++ b/compat/win32/pthread.h
@@ -0,0 +1,68 @@
+/*
+ * Header used to adapt pthread-based POSIX code to Windows API threads.
+ *
+ * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
+ */
+
+#ifndef PTHREAD_H
+#define PTHREAD_H
+
+#ifndef WIN32_LEAN_AND_MEAN
+#define WIN32_LEAN_AND_MEAN
+#endif
+
+#include <windows.h>
+
+/*
+ * Defines that adapt Windows API threads to pthreads API
+ */
+#define pthread_mutex_t CRITICAL_SECTION
+
+#define pthread_mutex_init(a,b) InitializeCriticalSection((a))
+#define pthread_mutex_destroy(a) DeleteCriticalSection((a))
+#define pthread_mutex_lock EnterCriticalSection
+#define pthread_mutex_unlock LeaveCriticalSection
+
+/*
+ * Implement simple condition variable for Windows threads, based on ACE
+ * implementation.
+ *
+ * See original implementation: http://bit.ly/1vkDjo
+ * ACE homepage: http://www.cse.wustl.edu/~schmidt/ACE.html
+ * See also: http://www.cse.wustl.edu/~schmidt/win32-cv-1.html
+ */
+typedef struct {
+	LONG waiters;
+	CRITICAL_SECTION waiters_lock;
+	HANDLE sema;
+} pthread_cond_t;
+
+extern int pthread_cond_init(pthread_cond_t *cond, const void *unused);
+
+extern int pthread_cond_destroy(pthread_cond_t *cond);
+
+extern int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex);
+
+extern int pthread_cond_signal(pthread_cond_t *cond);
+
+/*
+ * Simple thread creation implementation using pthread API
+ */
+typedef struct {
+	HANDLE handle;
+	void *(*start_routine)(void*);
+	void *arg;
+} pthread_t;
+
+extern int pthread_create(pthread_t *thread, const void *unused,
+			  void *(*start_routine)(void*), void *arg);
+
+/*
+ * To avoid the need of copying a struct, we use small macro wrapper to pass
+ * pointer to win32_pthread_join instead.
+ */
+#define pthread_join(a, b) win32_pthread_join(&(a), (b))
+
+extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
+
+#endif /* PTHREAD_H */
-- 
1.6.5.2
