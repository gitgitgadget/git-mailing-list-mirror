From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: [PATCH] MSVC: Windows-native implementation for subset of Pthreads API
Date: Wed,  4 Nov 2009 16:55:00 +0100
Message-ID: <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 16:55:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5iCz-0002EY-Us
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 16:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbZKDPz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 10:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756828AbZKDPz2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 10:55:28 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56224 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787AbZKDPz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 10:55:27 -0500
Received: by yxe17 with SMTP id 17so6447769yxe.33
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 07:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=PiPOykdkrOXDyrGA/AQbXlGxYYhT7S7AonH31rdwpmI=;
        b=YkVV2JRBlk0aCqKYuDR+UkVvbR+68g4LGYFoCHMZPUqwnHhUcqeuIXa/1atuVCGmTp
         XKonvZxnCpfA8E1Y0zd3na7RmRx4QWjQpIWBnOHtIsS0MySlApT4LsAZSEgB3WSzJQ1d
         msfPmBWk7YAJG0pkVKagorlWOV6y0Kv8CuhAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YbnlPXivztse5VRB7Uju+nkToA6bektsKmqnCDJVk+qhKQ10Bq3259sCOBOrqGYxWV
         fMGwpd8y08vPnhxSvDwnWevhbtp5RfyKssIeGDRSvf13nJfGCseq7x8TFPyi3MQlCmFw
         7GSmVLQ7H+7TIchkCs8jygjjF6uPFoXcdQLgI=
Received: by 10.103.67.32 with SMTP id u32mr625371muk.133.1257350132052;
        Wed, 04 Nov 2009 07:55:32 -0800 (PST)
Received: from endru-ubuntu ([85.232.239.146])
        by mx.google.com with ESMTPS id j10sm3620403mue.6.2009.11.04.07.55.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 07:55:31 -0800 (PST)
Received: by endru-ubuntu (Postfix, from userid 1000)
	id 2A8841E78F2; Wed,  4 Nov 2009 16:55:34 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132093>

This patch implements native to Windows subset of pthreads API used by Git.
It allows to remove Pthreads for Win32 dependency for msysgit and cygwin.

The patch modifies Makefile only for MSVC (that's the environment I'm capable
of testing on), so it requires further corrections to compile with MinGW
or Cygwin.

Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>
---
 Makefile               |    8 ++-
 builtin-pack-objects.c |   41 +++++++++++++-
 compat/mingw.c         |    2 +-
 compat/mingw.h         |    5 ++
 compat/win32/pthread.h |  136 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h      |   10 ++++
 preload-index.c        |    4 +-
 7 files changed, 198 insertions(+), 8 deletions(-)
 create mode 100644 compat/win32/pthread.h

diff --git a/Makefile b/Makefile
index 521e8a5..14c371c 100644
--- a/Makefile
+++ b/Makefile
@@ -939,7 +939,8 @@ ifdef MSVC
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
-	NO_PTHREADS = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
+	NO_STATIC_PTHREADS_INIT = YesPlease
 	BLK_SHA1 = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
@@ -947,7 +948,7 @@ ifdef MSVC
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	lib =
@@ -1293,6 +1294,9 @@ ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
 	LIB_OBJS += thread-utils.o
 endif
+ifdef NO_STATIC_PTHREADS_INIT
+	COMPAT_CFLAGS += -DNO_STATIC_PTHREADS_INIT
+endif
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..f297d82 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1592,7 +1592,34 @@ struct thread_params {
 
 static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
 
-static void *threaded_find_deltas(void *arg)
+/*
+ * For platforms that do support static pthreads initialization
+ * make these noops.
+ */
+#ifndef NO_STATIC_PTHREADS_INIT
+# define init_threaded_delta_search()
+# define cleanup_threaded_delta_search()
+#else
+static void init_threaded_delta_search()
+{
+	pthread_mutex_init(&read_mutex);
+	pthread_mutex_init(&cache_mutex);
+	pthread_mutex_init(&progress_mutex);
+	pthread_cond_init(&progress_cond, NULL);
+}
+
+static void cleanup_threaded_delta_search()
+{
+	/* cleanup Windows threads thingies */
+	pthread_cond_destroy(&progress_cond);
+	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&cache_mutex);
+	pthread_mutex_destroy(&progress_mutex);
+
+}
+#endif
+
+static THREAD_RET_TYPE threaded_find_deltas(void *arg)
 {
 	struct thread_params *me = arg;
 
@@ -1620,7 +1647,7 @@ static void *threaded_find_deltas(void *arg)
 		pthread_mutex_unlock(&me->mutex);
 	}
 	/* leave ->working 1 so that this doesn't get more work assigned */
-	return NULL;
+	return 0;
 }
 
 static void ll_find_deltas(struct object_entry **list, unsigned list_size,
@@ -2327,6 +2354,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 #ifdef THREADED_DELTA_SEARCH
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
+
+	init_threaded_delta_search();
 #endif
 
 	prepare_packed_git();
@@ -2345,7 +2374,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	stop_progress(&progress_state);
 
 	if (non_empty && !nr_result)
-		return 0;
+		goto cleanup;
 	if (nr_result)
 		prepare_pack(window, depth);
 	write_pack_file();
@@ -2353,5 +2382,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
 			" reused %"PRIu32" (delta %"PRIu32")\n",
 			written, written_delta, reused, reused_delta);
+
+cleanup:
+#ifdef THREADED_DELTA_SEARCH
+	cleanup_threaded_delta_search();
+#endif
+
 	return 0;
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
index 0000000..a71b90f
--- /dev/null
+++ b/compat/win32/pthread.h
@@ -0,0 +1,136 @@
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
+#define PTHREAD_COND_INITIALIZER { 0, { 0 }, NULL }
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
+#define PTHREAD_MUTEX_INITIALIZER { 0 }
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
