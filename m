From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 00:47:15 +0100
Message-ID: <4AF21283.3080407@gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home> <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 00:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5pZW-0004j7-3x
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206AbZKDXrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 18:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758018AbZKDXrO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:47:14 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60956 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbZKDXrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 18:47:13 -0500
Received: by bwz27 with SMTP id 27so9501350bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 15:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=M2ouJraFyvt6Ws10bN91uZwPUD4n24lFm5E4a68KkVQ=;
        b=YWuqUCpTOX6X81mM3ng9mg/hIKW4MkcrTvAWsFi4KPNsHIrc1EfDEfl399RwVG8SeZ
         Mnbl+us88o5nPzCKQuCj0ysG9zwOXeocFRrATXXpfSlOuInlo3mPcDZy3INOUsvwDel8
         DRsojcmNG7W7exSj3WKWkbUvwuCtSdO0sUigg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=FT8uyzUtecUmmIPkrmxkoRC0LihBLs+jYAtmMOdSAiXvJRXL6VPpKrSsBOVPQv1Uq3
         J8BEwv8YRvK/J5mQaKf3cvopAuxpNmlM5VbZQbJDf8y6/E4ooV/1YPl72RMl4tfbjO+6
         +/3k/0Uku58jgWVp4d1/z8YmmKnz3vrgROgfw=
Received: by 10.204.148.85 with SMTP id o21mr2084254bkv.134.1257378436983;
        Wed, 04 Nov 2009 15:47:16 -0800 (PST)
Received: from macendru.local (14-mi2-10.acn.waw.pl [85.222.57.14])
        by mx.google.com with ESMTPS id 15sm509474fxm.2.2009.11.04.15.47.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 15:47:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132172>

This patch implements native to Windows subset of pthreads API used by Git.
It allows to remove Pthreads for Win32 dependency for msysgit and cygwin.

The patch modifies Makefile only for MSVC (that's the environment I'm
capable of testing on), so it requires further corrections to compile
with MinGW or Cygwin.

Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>
---
 Makefile               |    4 +-
 builtin-pack-objects.c |   34 ++++++++++--
 compat/mingw.c         |    2 +-
 compat/mingw.h         |    5 ++
 compat/win32/pthread.h |  132 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h      |   10 ++++
 preload-index.c        |    4 +-
 7 files changed, 180 insertions(+), 11 deletions(-)
 create mode 100644 compat/win32/pthread.h

diff --git a/Makefile b/Makefile
index 94d44b0..0146ac7 100644
--- a/Makefile
+++ b/Makefile
@@ -975,7 +975,7 @@ ifdef MSVC
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
-	NO_PTHREADS = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 	BLK_SHA1 = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
@@ -983,7 +983,7 @@ ifdef MSVC
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	lib =
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..e897b16 100644
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
 
@@ -1590,9 +1590,28 @@ struct thread_params {
 	unsigned *processed;
 };
 
-static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
+static pthread_cond_t progress_cond;
 
-static void *threaded_find_deltas(void *arg)
+/*
+ * Mutex and conditional variable can't be statically-initialized on Windows.
+ */
+static void init_threaded_search()
+{
+	pthread_mutex_init(&read_mutex);
+	pthread_mutex_init(&cache_mutex);
+	pthread_mutex_init(&progress_mutex);
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
+
+static THREAD_RET_TYPE threaded_find_deltas(void *arg)
 {
 	struct thread_params *me = arg;
 
@@ -1620,7 +1639,7 @@ static void *threaded_find_deltas(void *arg)
 		pthread_mutex_unlock(&me->mutex);
 	}
 	/* leave ->working 1 so that this doesn't get more work assigned */
-	return NULL;
+	return 0;
 }
 
 static void ll_find_deltas(struct object_entry **list, unsigned list_size,
@@ -1638,6 +1657,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 				delta_search_threads);
 	p = xcalloc(delta_search_threads, sizeof(*p));
 
+	init_threaded_search();
+
 	/* Partition the work amongst work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
 		unsigned sub_size = list_size / (delta_search_threads - i);
@@ -1745,6 +1766,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
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
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
new file mode 100644
index 0000000..0e43714
--- /dev/null
+++ b/compat/win32/pthread.h
@@ -0,0 +1,132 @@
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
+		return 0; /* POSIX do not allow pthread_cond_init to fail */
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
+#define pthread_t HANDLE
+#define pthread_mutex_t CRITICAL_SECTION
+
+#define pthread_mutex_init(a,b) InitializeCriticalSection((a))
+#define pthread_mutex_destroy(a) DeleteCriticalSection((a))
+#define pthread_mutex_lock EnterCriticalSection
+#define pthread_mutex_unlock LeaveCriticalSection
+
+static inline int pthread_create(pthread_t *thread, const void *unused,
+		DWORD (__stdcall *start_routine)(LPVOID), void *arg)
+{
+	*thread = CreateThread(NULL, 0, start_routine, arg, 0, NULL);
+
+	if (!*thread)
+		return err_win_to_posix(GetLastError());
+	else
+		return 0;
+}
+
+static inline int pthread_join(pthread_t thread, void **unused)
+{
+	DWORD result = WaitForSingleObject(t, INFINITE);
+	switch (result) {
+		case WAIT_OBJECT_0:
+			return 0;
+		case WAIT_ABANDONED:
+			return EINVAL;
+		default:
+			return err_win_to_posix(GetLastError());
+	}
+}
+
+#endif /* PTHREAD_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index ef60803..4311117 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -464,4 +464,14 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  */
 int unlink_or_warn(const char *path);
 
+/*
+ * Define type of thread function return type to distinguish
+ * Windows and POSIX.
+ */
+#ifndef _WIN32
+# define THREAD_RET_TYPE void *
+#else
+# define THREAD_RET_TYPE DWORD __stdcall
+#endif
+
 #endif
diff --git a/preload-index.c b/preload-index.c
index 9289933..41b11a3 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -28,7 +28,7 @@ struct thread_data {
 	int offset, nr;
 };
 
-static void *preload_thread(void *_data)
+static THREAD_RET_TYPE preload_thread(void* _data)
 {
 	int nr;
 	struct thread_data *p = _data;
@@ -59,7 +59,7 @@ static void *preload_thread(void *_data)
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
-	return NULL;
+	return 0;
 }
 
 static void preload_index(struct index_state *index, const char **pathspec)
-- 
1.6.5.2
