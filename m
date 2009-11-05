From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: [PATCH] MSVC: Windows-native implementation for subset of Pthreads API
Date: Thu,  5 Nov 2009 11:18:45 +0100
Message-ID: <1257416325-5605-1-git-send-email-ahaczewski@gmail.com>
References: <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, kusmabite@gmail.com,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 11:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5zR6-00066D-Ux
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 11:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbZKEKTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 05:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZKEKTM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 05:19:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:3379 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZKEKTK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 05:19:10 -0500
Received: by fg-out-1718.google.com with SMTP id 16so742650fgg.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 02:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=KBAHJPYoT5K4BiV20ZRdYpcp67d7VPoymv7lBDpD1e8=;
        b=pvVjjxhDTo5Si76Ox5HXvwDl1H14kv8lfnQre5r4MnST8tQcXA3/7Sn2Ur8zfcPvTx
         JMymQxUSqiDGhJiT+D7VSLAfMWZlKP+d5EZ4SAMqj7oEnxFL9JDXrD4VMZi8heTzwhK2
         6k7QWE+TiIyELH1ieTeineh9w8uA81BjePs2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nUxvIsjRExDiQaYxsUswtT81Nen2iiAKEKURXLgzCz1GlOE20gZwoqTpvIE5XnUU/j
         bINbYRQzmH0Nqqrrh/WTDTTWeICGwavbgEQ6npkHmNVljwVQ1wpza22gwR3RZ8YGY8b/
         KlJkyOv8mWSAnHHq8dpkbkn1X+T5I+gpDLBhA=
Received: by 10.86.173.16 with SMTP id v16mr4741286fge.62.1257416354744;
        Thu, 05 Nov 2009 02:19:14 -0800 (PST)
Received: from endru-ubuntu ([85.232.239.146])
        by mx.google.com with ESMTPS id d4sm3635271fga.6.2009.11.05.02.19.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 02:19:14 -0800 (PST)
Received: by endru-ubuntu (Postfix, from userid 1000)
	id C59F61E78F2; Thu,  5 Nov 2009 11:19:18 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132222>

This patch implements native to Windows subset of pthreads API used by Git.
It allows to remove Pthreads for Win32 dependency for msysgit and Cygwin.

The patch modifies Makefile only for MSVC (that's the environment I'm
capable of testing on), so it requires further corrections to compile
with MinGW or Cygwin.

Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>
---
 Makefile               |    7 ++-
 builtin-pack-objects.c |   31 ++++++++++--
 compat/mingw.c         |    2 +-
 compat/mingw.h         |    5 ++
 compat/win32/pthread.c |   39 +++++++++++++++
 compat/win32/pthread.h |  125 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 201 insertions(+), 8 deletions(-)
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
index 0000000..a7ab7af
--- /dev/null
+++ b/compat/win32/pthread.c
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
+ */
+
+#include "pthread.h"
+
+static DWORD __stdcall win32_start_routine(LPVOID arg)
+{
+	pthread_t *thread = arg;
+	thread->value = thread->start_routine(thread->arg);
+	return 0;
+}
+
+int pthread_create(pthread_t *thread, const void *unused,
+		   void *(*start_routine)(void*), void *arg)
+{
+	thread->arg = arg;
+	thread->handle = CreateThread(NULL, 0, win32_start_routine, thread, 0, NULL);
+
+	if (!thread->handle)
+		return err_win_to_posix(GetLastError());
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
+				*value_ptr = thread.value;
+			return 0;
+		case WAIT_ABANDONED:
+			return EINVAL;
+		default:
+			return err_win_to_posix(GetLastError());
+	}
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
new file mode 100644
index 0000000..e50eb6b
--- /dev/null
+++ b/compat/win32/pthread.h
@@ -0,0 +1,125 @@
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
+static inline int pthread_cond_init(pthread_cond_t *cond, const void *unused)
+{
+	cond->waiters = 0;
+
+	InitializeCriticalSection(&cond->waiters_lock);
+
+	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
+	if (!cond->sema)
+		die("");
+	return 0;
+}
+
+static inline int pthread_cond_destroy(pthread_cond_t *cond)
+{
+	CloseHandle(cond->sema);
+	cond->sema = NULL;
+
+	DeleteCriticalSection(&cond->waiters_lock);
+
+	return 0;
+}
+
+static inline int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
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
+	/* let's wait */
+	WaitForSingleObject(cond->sema, INFINITE))
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
+static inline int pthread_cond_signal(pthread_cond_t *cond)
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
+			0 : err_win_to_posix(GetLastError();
+	else
+		return 0;
+}
+
+#define pthread_mutex_t CRITICAL_SECTION
+
+#define pthread_mutex_init(a,b) InitializeCriticalSection((a))
+#define pthread_mutex_destroy(a) DeleteCriticalSection((a))
+#define pthread_mutex_lock EnterCriticalSection
+#define pthread_mutex_unlock LeaveCriticalSection
+
+typedef struct {
+	HANDLE handle;
+	void *(*start_routine)(void*);
+	void *arg;
+	void *value;
+} pthread_t;
+
+extern int pthread_create(pthread_t *thread, const void *unused,
+			  void *(*start_routine)(void*), void *arg);
+
+/*
+ * To avoid the need of allocating struct, we use small macro wrapper to pass
+ * pointer to win32_pthread_join instead of using typedef struct {} *pthread_t
+ */
+#define pthread_join(a, b) win32_pthread_join(&(a), (b))
+
+extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
+
+#endif /* PTHREAD_H */
-- 
1.6.5.2
