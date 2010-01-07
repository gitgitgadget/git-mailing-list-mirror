From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/5] MSVC: Windows-native implementation for subset of Pthreads API
Date: Thu,  7 Jan 2010 22:54:57 +0100
Message-ID: <44c7183e43089c64fb65bd248f7fa5b9731067ea.1262895936.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, "Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0La-000271-7V
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 22:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab0AGV4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 16:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844Ab0AGV4h
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 16:56:37 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50833 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754151Ab0AGV4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 16:56:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AC53C1001B;
	Thu,  7 Jan 2010 22:56:33 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1E3E919F610;
	Thu,  7 Jan 2010 22:55:46 +0100 (CET)
X-Mailer: git-send-email 1.6.6.115.gd1ab3
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136390>

From: Andrzej K. Haczewski <ahaczewski@gmail.com>

This patch implements native to Windows subset of pthreads API used by Git.
It allows to remove Pthreads for Win32 dependency for MSVC, msysgit and
Cygwin.

The patch modifies Makefile only for MSVC (that's the environment I'm
capable of testing on), so it requires further corrections to compile
with MinGW or Cygwin.

Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
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
index 4a1e5bc..ed547d9 100644
--- a/Makefile
+++ b/Makefile
@@ -451,6 +451,7 @@ LIB_H += commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
+LIB_H += compat/win32/pthread.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -967,15 +968,15 @@ ifeq ($(uname_S),Windows)
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
index 4429d53..2fdabaa 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1256,15 +1256,15 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 
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
 
@@ -1591,7 +1591,26 @@ struct thread_params {
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
@@ -1630,10 +1649,13 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	struct thread_params *p;
 	int i, ret, active_threads = 0;
 
+	init_threaded_search();
+
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
 	if (delta_search_threads <= 1) {
 		find_deltas(list, &list_size, window, depth, processed);
+		cleanup_threaded_search();
 		return;
 	}
 	if (progress > pack_to_stdout)
@@ -1748,6 +1770,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			active_threads--;
 		}
 	}
+	cleanup_threaded_search();
 	free(p);
 }
 
diff --git a/compat/mingw.c b/compat/mingw.c
index 0d73f15..bc3dc74 100644
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
index b3d299f..e681135 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -307,3 +307,8 @@ struct mingw_dirent
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
index 0000000..47888e4
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
1.6.6.115.gd1ab3
