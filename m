From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: [PATCH] MSVC: Windows-native implementation for subset of Pthreads API
Date: Thu,  5 Nov 2009 17:45:48 +0100
Message-ID: <1257439548-9258-1-git-send-email-ahaczewski@gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 17:46:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N65Tq-0004io-GM
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 17:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155AbZKEQqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 11:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756955AbZKEQqY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 11:46:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:43231 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZKEQqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 11:46:23 -0500
Received: by fg-out-1718.google.com with SMTP id 16so123547fgg.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=N8s4WzexTixVWF7CeiYFS+xaJtRIHI8DIdSjz5fAMVM=;
        b=f2oGTQvQNZCAfrwHAlUfvcrmvX+8OucTXrTw8IBdALWTozQLhkcVYtEzX1YgyINe4E
         VY0eAx0qBp4oJ/YSLNAicTBnmfPnSYfDswu92e5WT2BtrMg0LiKU+zKgpBM0T8Dh/gt1
         LvWoElBgkPmbRDc3IpN4nc82YyWlbCzSsof2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=COdjVMCQkOXfdz4qnDYfIYLBgOgykmxjKhyqFtw86zzeU2meyUDzbD1bw+jLYYaZGB
         XjJTJuToegKZAwdDBxoTHUAZoJUfSseljRLmRIqvy56FHHNvcyuYn04utVqm17ldNxTk
         RLEWs0Cq6OlU81GYSMRMLJ5npgOoengyvW5rU=
Received: by 10.86.235.29 with SMTP id i29mr5020935fgh.57.1257439587911;
        Thu, 05 Nov 2009 08:46:27 -0800 (PST)
Received: from endru-ubuntu ([85.232.239.146])
        by mx.google.com with ESMTPS id e11sm1934995fga.27.2009.11.05.08.46.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 08:46:25 -0800 (PST)
Received: by endru-ubuntu (Postfix, from userid 1000)
	id 39BEE1E78F2; Thu,  5 Nov 2009 17:46:29 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132229>

This patch implements native to Windows subset of pthreads API used by Git.
It allows to remove Pthreads for Win32 dependency for MSVC, msysgit and
Cygwin.

The patch modifies Makefile only for MSVC (that's the environment I'm
capable of testing on), so it requires further corrections to compile
with MinGW or Cygwin.

Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>
---
Here is another round of that patch with all comments considered. There is
no workaround to make static initialization of mutexes and condition
variables work for Windows, that's why there's explicit initialization
added.

I hope I added to Cc all interested in this patch. Excuse me if I omitted
someone.

 Makefile               |    7 ++-
 builtin-pack-objects.c |   31 +++++++++++--
 compat/mingw.c         |    2 +-
 compat/mingw.h         |    5 ++
 compat/win32/pthread.c |  116 ++++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/pthread.h |   69 ++++++++++++++++++++++++++++
 6 files changed, 222 insertions(+), 8 deletions(-)
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
index 0000000..e4d21bd
--- /dev/null
+++ b/compat/win32/pthread.c
@@ -0,0 +1,116 @@
+/*
+ * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
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
+	thread->value = thread->start_routine(thread->arg);
+	return 0;
+}
+
+int pthread_create(pthread_t *thread, const void *unused,
+		   void *(*start_routine)(void*), void *arg)
+{
+	thread->arg = arg;
+	thread->start_routine = start_routine;
+	thread->value = NULL;
+	thread->handle =
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
+	DWORD result = WaitForSingleObject((HANDLE)thread->handle, INFINITE);
+	switch (result) {
+		case WAIT_OBJECT_0:
+			if (value_ptr)
+				*value_ptr = thread->value;
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
index 0000000..a7594cc
--- /dev/null
+++ b/compat/win32/pthread.h
@@ -0,0 +1,69 @@
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
+	uintptr_t handle;
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
