From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed,  4 Nov 2009 11:37:39 +0100
Message-ID: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 11:38:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5dFX-00070k-O1
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 11:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbZKDKhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 05:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754996AbZKDKhs
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 05:37:48 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53402 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbZKDKhq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 05:37:46 -0500
Received: by bwz27 with SMTP id 27so8676849bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=uaP+DfE/uOvpLWx//L4pzXTrtaZcSktSVFfqYgdAIyU=;
        b=uB9hMfO6G/a2RBFrJn8Cf9p/BZlkiXPXp/LHRGynkzlXdRdiaDtoKlI+AXS909MwNU
         PLtD/na8iAPuR6JYsd62ike3M/JLwOHV9La+B4zyPol45J3YIIEnoVwlgrfMjlYuUUoX
         AgAJ8JzXwBwnQaY8Ojpp0nV35fxR5ACXnxTXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HneZvxazrytYV7BJZyQero9fOZHAf7vR1yEnLC9qwOyPJwpOu2uRVo+wMK/R2d1ELt
         4i1i6W5MkvJq/7FA//8uzYqQBFC1wGeGQJzzQV4RFo5ZI13D68oSGt7SUflQG473i6FQ
         hzHhSdOkhHN2NpwaDwpXBUc6wUJt3guErHz20=
Received: by 10.204.157.21 with SMTP id z21mr1223670bkw.160.1257331069166;
        Wed, 04 Nov 2009 02:37:49 -0800 (PST)
Received: from endru-ubuntu ([85.232.239.146])
        by mx.google.com with ESMTPS id 13sm324683bwz.6.2009.11.04.02.37.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 02:37:48 -0800 (PST)
Received: by endru-ubuntu (Postfix, from userid 1000)
	id B757B1E78F2; Wed,  4 Nov 2009 11:37:50 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132069>

Here is slightly modified patch with more comments where explanations were
requested (ie. non atomic release mutex and wait).

The implementation of conditional variable is based on ACE.

The patch needs testing from someone capable of compiling Git on Windows
and running it with msysgit environment. I can confirm that it compiles
cleanly on both Linux and Windows. I modified Makefile only for MSVC
part, so if you'd like to compile it with mingw or cygwin, proper
corrections have to be made. I aim for native MSVC compilation, that's
why I did it like that. That's also the reason I don't like
having Pthreads for Win32 dependency - it's faster to use native
calls than depend on 3rd party wrapper library to do it for you
(ie. pthreads for win32 does allocations to implement POSIX
standard, and full-conformance isn't required by Git, since Git uses
only small subset of pthreads).

One more motivation I had for the patch: as I was reading through
archives I had a feeling that Git aims to be as lightweight
as possible, hence removing additional dependencies (even for
Windows platform) seems sensible to me.

Signed-off-by: Andrzej K. Haczewski <ahaczewski@gmail.com>
---
 Makefile               |    4 +-
 builtin-pack-objects.c |   29 +++++++++-
 compat/mingw.c         |    2 +-
 compat/win32/pthread.h |  143 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h      |   13 ++++
 preload-index.c        |    4 +-
 6 files changed, 187 insertions(+), 8 deletions(-)
 create mode 100644 compat/win32/pthread.h

diff --git a/Makefile b/Makefile
index 521e8a5..450d8fe 100644
--- a/Makefile
+++ b/Makefile
@@ -939,7 +939,7 @@ ifdef MSVC
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
-	NO_PTHREADS = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 	BLK_SHA1 = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
@@ -947,7 +947,7 @@ ifdef MSVC
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	lib =
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..c96d293 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1592,7 +1592,7 @@ struct thread_params {
 
 static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
 
-static void *threaded_find_deltas(void *arg)
+static THREAD_FUNC(threaded_find_deltas, arg)
 {
 	struct thread_params *me = arg;
 
@@ -1620,7 +1620,7 @@ static void *threaded_find_deltas(void *arg)
 		pthread_mutex_unlock(&me->mutex);
 	}
 	/* leave ->working 1 so that this doesn't get more work assigned */
-	return NULL;
+	THREAD_RETURN(NULL);
 }
 
 static void ll_find_deltas(struct object_entry **list, unsigned list_size,
@@ -2327,6 +2327,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 #ifdef THREADED_DELTA_SEARCH
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
+
+#ifdef _WIN32
+	/*
+	 * Windows requires initialization of mutex (CRITICAL_SECTION)
+	 * and conditional variable.
+	 */
+	pthread_mutex_init(&read_mutex);
+	pthread_mutex_init(&cache_mutex);
+	pthread_mutex_init(&progress_mutex);
+	pthread_cond_init(&progress_cond, NULL);
+#endif
+
 #endif
 
 	prepare_packed_git();
@@ -2345,7 +2357,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	stop_progress(&progress_state);
 
 	if (non_empty && !nr_result)
-		return 0;
+		goto cleanup;
 	if (nr_result)
 		prepare_pack(window, depth);
 	write_pack_file();
@@ -2353,5 +2365,16 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
 			" reused %"PRIu32" (delta %"PRIu32")\n",
 			written, written_delta, reused, reused_delta);
+
+cleanup:
+#if defined(THREADED_DELTA_SEARCH) && defined(_WIN32)
+	/* cleanup Windows threads thingies */
+	pthread_cond_destroy(&progress_cond);
+	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&cache_mutex);
+	pthread_mutex_destroy(&progress_mutex);
+#endif
+
 	return 0;
 }
+
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
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
new file mode 100644
index 0000000..8f82d3c
--- /dev/null
+++ b/compat/win32/pthread.h
@@ -0,0 +1,143 @@
+/*
+ * Header used to "adapt" pthread-based POSIX code to Windows API threads.
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
+ * don't include mingw.h for err_win_to_posix function - mingw.h doesn't 
+ * have include-guards
+ */
+extern int err_win_to_posix(DWORD winerr);
+
+/* Implement simple condition variable for Windows threads, based on ACE implementation */
+typedef struct {
+	LONG waiters;
+	CRITICAL_SECTION waiters_lock;
+	HANDLE sema;
+} pthread_cond_t;
+
+#define PTHREAD_COND_INITIALIZER { 0, { 0 }, NULL }
+
+static __inline int pthread_cond_init(pthread_cond_t *cond, const void *unused)
+{
+	cond->waiters = 0;
+
+	InitializeCriticalSection(&cond->waiters_lock);
+
+	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
+	if (NULL == cond->sema) 
+		return -1;
+	return 0;
+}
+
+static __inline int pthread_cond_destroy(pthread_cond_t *cond)
+{
+	CloseHandle(cond->sema);
+	cond->sema = NULL;
+
+	DeleteCriticalSection(&cond->waiters_lock);
+
+	return 0;
+}
+
+static __inline int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
+{
+	int ret = 0;
+
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
+	if (0 != WaitForSingleObject(cond->sema, INFINITE))
+		ret = -1;
+
+	/* we're done waiting, so make sure we decrease waiters count */
+	EnterCriticalSection(&cond->waiters_lock);
+	--cond->waiters;
+	LeaveCriticalSection(&cond->waiters_lock);
+
+	/* lock external mutex again */
+	EnterCriticalSection(mutex);
+
+	return ret;
+}
+
+static __inline int pthread_cond_signal(pthread_cond_t *cond)
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
+		return ReleaseSemaphore(cond->sema, 1, NULL) ? 0 : -1;
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
+static __inline int pthread_create(pthread_t *t, const void *unused, DWORD (__stdcall *start_routine)(LPVOID), void *arg)
+{
+	*t = CreateThread(NULL, 0, start_routine, arg, 0, NULL);
+
+	if (NULL == *t) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	} else {
+		errno = 0;
+		return 0;
+	}
+}
+
+static __inline int pthread_join(pthread_t t, void **unused)
+{
+	DWORD result = WaitForSingleObject(t, INFINITE);
+	switch (result) {
+		case WAIT_OBJECT_0:
+			errno = 0;
+			return 0;
+		case WAIT_ABANDONED:
+			errno = EINVAL;
+			return -1;
+		default:
+			errno = err_win_to_posix(GetLastError());
+			return -1;
+	}
+}
+
+#endif /* PTHREAD_H */
+
diff --git a/git-compat-util.h b/git-compat-util.h
index ef60803..202b90e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -464,4 +464,17 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  */
 int unlink_or_warn(const char *path);
 
+/*
+ * Properly defines thread routine for Windows and POSIX
+ */
+#ifndef NO_PTHREADS
+# ifndef _WIN32
+#  define THREAD_FUNC(f, a) void *f(void *a)
+#  define THREAD_RETURN(x) return (x)
+# else
+#  define THREAD_FUNC(f, a) DWORD __stdcall f(LPVOID a)
+#  define THREAD_RETURN(x) return (DWORD)(x);
+# endif
+#endif
+
 #endif
diff --git a/preload-index.c b/preload-index.c
index 9289933..ace10fe 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -28,7 +28,7 @@ struct thread_data {
 	int offset, nr;
 };
 
-static void *preload_thread(void *_data)
+static THREAD_FUNC(preload_thread, _data)
 {
 	int nr;
 	struct thread_data *p = _data;
@@ -59,7 +59,7 @@ static void *preload_thread(void *_data)
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
-	return NULL;
+	THREAD_RETURN(NULL);
 }
 
 static void preload_index(struct index_state *index, const char **pathspec)
-- 
1.6.5.2
