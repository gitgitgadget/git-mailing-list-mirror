From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Tue,  3 Nov 2009 22:30:02 +0100
Message-ID: <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 22:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5QxV-0001ry-2T
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 22:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbZKCVaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 16:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754399AbZKCVaQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 16:30:16 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35094 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbZKCVaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 16:30:13 -0500
Received: by bwz27 with SMTP id 27so8109510bwz.21
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 13:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0CQhXqfd0p+qVyD4vYgywu+zEFudfdZ6hUGeEj3qsKE=;
        b=vOflMWU81N3ASDWS2PywSFbrZJXMbHR905uAg9zEWZWt6YzAPx3/39o0czhfrhTAZe
         iIGVD408KnuWvm2bsZNUUYsfN0FabqBv3wzx4xx26UkF0DDqirwOEPhzz27HK9T/9iSb
         pSDgbHmxRH6TwFpw+d20e/wUStfsCrvxEolNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=d1w7sGKKTkx70tHhOgKq3uFFEdMeXKPA6Yu7fu5CCUGosGoG1JET9SnyCFYo2b2ZA9
         N/s2jXU5Eyr7UGUYQFhmEbEPnhi6oz3KIzTvAncOMWOkPJcB1mT+YWAnWJxxqTsGJxL/
         /I34vJo6Mx6u6l7fovbCRU4MFoB9Au+vRgREc=
Received: by 10.204.34.23 with SMTP id j23mr555587bkd.31.1257283816874;
        Tue, 03 Nov 2009 13:30:16 -0800 (PST)
Received: from evo.home.haczewski.net (14-mi2-10.acn.waw.pl [85.222.57.14])
        by mx.google.com with ESMTPS id p9sm1246698fkb.49.2009.11.03.13.30.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 13:30:16 -0800 (PST)
Received: by evo.home.haczewski.net (Postfix, from userid 1000)
	id 80FE6A7EADC; Tue,  3 Nov 2009 22:30:14 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131999>

---
 Makefile               |    2 +-
 builtin-pack-objects.c |   42 +++++++++-
 compat/winthread.h     |  219 ++++++++++++++++++++++++++++++++++++++++++++++++
 preload-index.c        |   12 +++
 4 files changed, 272 insertions(+), 3 deletions(-)
 create mode 100644 compat/winthread.h

diff --git a/Makefile b/Makefile
index 28d6ecf..126ab43 100644
--- a/Makefile
+++ b/Makefile
@@ -940,7 +940,7 @@ ifdef MSVC
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
-	NO_PTHREADS = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 	BLK_SHA1 = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..a8a4f59 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -18,8 +18,12 @@
 #include "refs.h"
 
 #ifdef THREADED_DELTA_SEARCH
-#include "thread-utils.h"
-#include <pthread.h>
+# include "thread-utils.h"
+# ifndef _WIN32
+#  include <pthread.h>
+# else
+#  include <winthread.h>
+# endif
 #endif
 
 static const char pack_usage[] =
@@ -1592,7 +1596,11 @@ struct thread_params {
 
 static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
 
+#ifndef _WIN32
 static void *threaded_find_deltas(void *arg)
+#else
+static DWORD WINAPI threaded_find_deltas(LPVOID arg)
+#endif
 {
 	struct thread_params *me = arg;
 
@@ -1620,7 +1628,11 @@ static void *threaded_find_deltas(void *arg)
 		pthread_mutex_unlock(&me->mutex);
 	}
 	/* leave ->working 1 so that this doesn't get more work assigned */
+#ifndef _WIN32
 	return NULL;
+#else
+	return 0;
+#endif
 }
 
 static void ll_find_deltas(struct object_entry **list, unsigned list_size,
@@ -2327,6 +2339,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 #ifdef THREADED_DELTA_SEARCH
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
+
+#ifdef _WIN32
+	/*
+	 * Windows require initialization of mutex (CRITICAL_SECTION)
+	 * and conditional variable.
+	 */
+	pthread_mutex_init(&read_mutex);
+	pthread_mutex_init(&cache_mutex);
+	pthread_mutex_init(&progress_mutex);
+	win32_cond_init(&progress_cond);
+#endif
+
 #endif
 
 	prepare_packed_git();
@@ -2345,7 +2369,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	stop_progress(&progress_state);
 
 	if (non_empty && !nr_result)
+#if defined(THREADED_DELTA_SEARCH) && defined(_WIN32)
+		goto cleanup;
+#else
 		return 0;
+#endif
 	if (nr_result)
 		prepare_pack(window, depth);
 	write_pack_file();
@@ -2353,5 +2381,15 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
 			" reused %"PRIu32" (delta %"PRIu32")\n",
 			written, written_delta, reused, reused_delta);
+
+#if defined(THREADED_DELTA_SEARCH) && defined(_WIN32)
+cleanup:
+	/* cleanup Windows threads thingies */
+	win32_cond_destroy(&progress_cond);
+	pthread_mutex_destroy(&read_mutex);
+	pthread_mutex_destroy(&cache_mutex);
+	pthread_mutex_destroy(&progress_mutex);
+#endif
+
 	return 0;
 }
diff --git a/compat/winthread.h b/compat/winthread.h
new file mode 100644
index 0000000..32c9010
--- /dev/null
+++ b/compat/winthread.h
@@ -0,0 +1,219 @@
+/*
+ * Header used to "adapt" pthread-based POSIX code to Windows API threads.
+ *
+ * Copyright (C) 2009 Andrzej K. Haczewski <ahaczewski@gmail.com>
+ */
+
+#ifndef WINTHREAD_H
+#define WINTHREAD_H
+
+#define WIN32_LEAN_AND_MEAN
+#include <windows.h>
+
+/* Implement simple condition variable for Windows threads, based on ACE implementation */
+typedef struct win32_cond {
+	LONG waiters;
+	CRITICAL_SECTION waiters_lock;
+	HANDLE sema;
+} win32_cond_t;
+
+#define PTHREAD_COND_INITIALIZER { 0, { 0 }, NULL }
+
+static __inline int win32_cond_init(win32_cond_t *cond)
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
+static __inline int win32_cond_destroy(win32_cond_t *cond)
+{
+	CloseHandle(cond->sema);
+	cond->sema = NULL;
+
+	DeleteCriticalSection(&cond->waiters_lock);
+
+	return 0;
+}
+
+static __inline int win32_cond_wait(win32_cond_t *cond, CRITICAL_SECTION *mutex)
+{
+	DWORD result;
+	int ret = 0;
+
+	/* we're waiting... */
+	EnterCriticalSection(&cond->waiters_lock);
+	++cond->waiters;
+	LeaveCriticalSection(&cond->waiters_lock);
+
+	/* unlock external mutex and wait for signal */
+	LeaveCriticalSection(mutex);
+	result = WaitForSingleObject(cond->sema, INFINITE);
+
+	if (0 != result)
+		ret = -1;
+
+	/* one waiter less */
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
+static __inline int win32_cond_signal(win32_cond_t *cond)
+{
+	int have_waiters;
+
+	EnterCriticalSection(&cond->waiters_lock);
+	have_waiters = cond->waiters > 0;
+	LeaveCriticalSection(&cond->waiters_lock);
+
+	if (have_waiters)
+		return ReleaseSemaphore(cond->sema, 1, NULL) ? 0 : -1;
+	else
+		return 0;
+}
+
+#define pthread_t HANDLE
+#define pthread_mutex_t CRITICAL_SECTION
+#define pthread_cond_t win32_cond_t
+
+#define PTHREAD_MUTEX_INITIALIZER { 0 }
+
+#define pthread_mutex_init(a,b) InitializeCriticalSection((a))
+#define pthread_mutex_destroy(a) DeleteCriticalSection((a))
+#define pthread_mutex_lock EnterCriticalSection
+#define pthread_mutex_unlock LeaveCriticalSection
+
+#define pthread_cond_init(a,b) win32_cond_init((a))
+#define pthread_cond_destroy win32_cond_destroy
+#define pthread_cond_wait(a,b) win32_cond_wait((a), (b))
+#define pthread_cond_signal win32_cond_signal
+
+#define pthread_create(a,b,c,d) ((NULL == (*(a) = CreateThread(NULL, 0, (c), (d), 0, NULL))) ? (errno = err_win_to_posix(), -1) : (errno = 0, 0))
+#define pthread_join(a,b) ((WAIT_OBJECT_0 == WaitForSingleObject((a), INFINITE)) ? 0 : -1)
+
+/* almost copy-paste code of mingw.c */
+static int err_win_to_posix()
+{
+	int error = ENOSYS;
+	switch(GetLastError()) {
+	case ERROR_ACCESS_DENIED: error = EACCES; break;
+	case ERROR_ACCOUNT_DISABLED: error = EACCES; break;
+	case ERROR_ACCOUNT_RESTRICTION: error = EACCES; break;
+	case ERROR_ALREADY_ASSIGNED: error = EBUSY; break;
+	case ERROR_ALREADY_EXISTS: error = EEXIST; break;
+	case ERROR_ARITHMETIC_OVERFLOW: error = ERANGE; break;
+	case ERROR_BAD_COMMAND: error = EIO; break;
+	case ERROR_BAD_DEVICE: error = ENODEV; break;
+	case ERROR_BAD_DRIVER_LEVEL: error = ENXIO; break;
+	case ERROR_BAD_EXE_FORMAT: error = ENOEXEC; break;
+	case ERROR_BAD_FORMAT: error = ENOEXEC; break;
+	case ERROR_BAD_LENGTH: error = EINVAL; break;
+	case ERROR_BAD_PATHNAME: error = ENOENT; break;
+	case ERROR_BAD_PIPE: error = EPIPE; break;
+	case ERROR_BAD_UNIT: error = ENODEV; break;
+	case ERROR_BAD_USERNAME: error = EINVAL; break;
+	case ERROR_BROKEN_PIPE: error = EPIPE; break;
+	case ERROR_BUFFER_OVERFLOW: error = ENAMETOOLONG; break;
+	case ERROR_BUSY: error = EBUSY; break;
+	case ERROR_BUSY_DRIVE: error = EBUSY; break;
+	case ERROR_CALL_NOT_IMPLEMENTED: error = ENOSYS; break;
+	case ERROR_CANNOT_MAKE: error = EACCES; break;
+	case ERROR_CANTOPEN: error = EIO; break;
+	case ERROR_CANTREAD: error = EIO; break;
+	case ERROR_CANTWRITE: error = EIO; break;
+	case ERROR_CRC: error = EIO; break;
+	case ERROR_CURRENT_DIRECTORY: error = EACCES; break;
+	case ERROR_DEVICE_IN_USE: error = EBUSY; break;
+	case ERROR_DEV_NOT_EXIST: error = ENODEV; break;
+	case ERROR_DIRECTORY: error = EINVAL; break;
+	case ERROR_DIR_NOT_EMPTY: error = ENOTEMPTY; break;
+	case ERROR_DISK_CHANGE: error = EIO; break;
+	case ERROR_DISK_FULL: error = ENOSPC; break;
+	case ERROR_DRIVE_LOCKED: error = EBUSY; break;
+	case ERROR_ENVVAR_NOT_FOUND: error = EINVAL; break;
+	case ERROR_EXE_MARKED_INVALID: error = ENOEXEC; break;
+	case ERROR_FILENAME_EXCED_RANGE: error = ENAMETOOLONG; break;
+	case ERROR_FILE_EXISTS: error = EEXIST; break;
+	case ERROR_FILE_INVALID: error = ENODEV; break;
+	case ERROR_FILE_NOT_FOUND: error = ENOENT; break;
+	case ERROR_GEN_FAILURE: error = EIO; break;
+	case ERROR_HANDLE_DISK_FULL: error = ENOSPC; break;
+	case ERROR_INSUFFICIENT_BUFFER: error = ENOMEM; break;
+	case ERROR_INVALID_ACCESS: error = EACCES; break;
+	case ERROR_INVALID_ADDRESS: error = EFAULT; break;
+	case ERROR_INVALID_BLOCK: error = EFAULT; break;
+	case ERROR_INVALID_DATA: error = EINVAL; break;
+	case ERROR_INVALID_DRIVE: error = ENODEV; break;
+	case ERROR_INVALID_EXE_SIGNATURE: error = ENOEXEC; break;
+	case ERROR_INVALID_FLAGS: error = EINVAL; break;
+	case ERROR_INVALID_FUNCTION: error = ENOSYS; break;
+	case ERROR_INVALID_HANDLE: error = EBADF; break;
+	case ERROR_INVALID_LOGON_HOURS: error = EACCES; break;
+	case ERROR_INVALID_NAME: error = EINVAL; break;
+	case ERROR_INVALID_OWNER: error = EINVAL; break;
+	case ERROR_INVALID_PARAMETER: error = EINVAL; break;
+	case ERROR_INVALID_PASSWORD: error = EPERM; break;
+	case ERROR_INVALID_PRIMARY_GROUP: error = EINVAL; break;
+	case ERROR_INVALID_SIGNAL_NUMBER: error = EINVAL; break;
+	case ERROR_INVALID_TARGET_HANDLE: error = EIO; break;
+	case ERROR_INVALID_WORKSTATION: error = EACCES; break;
+	case ERROR_IO_DEVICE: error = EIO; break;
+	case ERROR_IO_INCOMPLETE: error = EINTR; break;
+	case ERROR_LOCKED: error = EBUSY; break;
+	case ERROR_LOCK_VIOLATION: error = EACCES; break;
+	case ERROR_LOGON_FAILURE: error = EACCES; break;
+	case ERROR_MAPPED_ALIGNMENT: error = EINVAL; break;
+	case ERROR_META_EXPANSION_TOO_LONG: error = E2BIG; break;
+	case ERROR_MORE_DATA: error = EPIPE; break;
+	case ERROR_NEGATIVE_SEEK: error = ESPIPE; break;
+	case ERROR_NOACCESS: error = EFAULT; break;
+	case ERROR_NONE_MAPPED: error = EINVAL; break;
+	case ERROR_NOT_ENOUGH_MEMORY: error = ENOMEM; break;
+	case ERROR_NOT_READY: error = EAGAIN; break;
+	case ERROR_NOT_SAME_DEVICE: error = EXDEV; break;
+	case ERROR_NO_DATA: error = EPIPE; break;
+	case ERROR_NO_MORE_SEARCH_HANDLES: error = EIO; break;
+	case ERROR_NO_PROC_SLOTS: error = EAGAIN; break;
+	case ERROR_NO_SUCH_PRIVILEGE: error = EACCES; break;
+	case ERROR_OPEN_FAILED: error = EIO; break;
+	case ERROR_OPEN_FILES: error = EBUSY; break;
+	case ERROR_OPERATION_ABORTED: error = EINTR; break;
+	case ERROR_OUTOFMEMORY: error = ENOMEM; break;
+	case ERROR_PASSWORD_EXPIRED: error = EACCES; break;
+	case ERROR_PATH_BUSY: error = EBUSY; break;
+	case ERROR_PATH_NOT_FOUND: error = ENOENT; break;
+	case ERROR_PIPE_BUSY: error = EBUSY; break;
+	case ERROR_PIPE_CONNECTED: error = EPIPE; break;
+	case ERROR_PIPE_LISTENING: error = EPIPE; break;
+	case ERROR_PIPE_NOT_CONNECTED: error = EPIPE; break;
+	case ERROR_PRIVILEGE_NOT_HELD: error = EACCES; break;
+	case ERROR_READ_FAULT: error = EIO; break;
+	case ERROR_SEEK: error = EIO; break;
+	case ERROR_SEEK_ON_DEVICE: error = ESPIPE; break;
+	case ERROR_SHARING_BUFFER_EXCEEDED: error = ENFILE; break;
+	case ERROR_SHARING_VIOLATION: error = EACCES; break;
+	case ERROR_STACK_OVERFLOW: error = ENOMEM; break;
+	case ERROR_SWAPERROR: error = ENOENT; break;
+	case ERROR_TOO_MANY_MODULES: error = EMFILE; break;
+	case ERROR_TOO_MANY_OPEN_FILES: error = EMFILE; break;
+	case ERROR_UNRECOGNIZED_MEDIA: error = ENXIO; break;
+	case ERROR_UNRECOGNIZED_VOLUME: error = ENODEV; break;
+	case ERROR_WAIT_NO_CHILDREN: error = ECHILD; break;
+	case ERROR_WRITE_FAULT: error = EIO; break;
+	case ERROR_WRITE_PROTECT: error = EROFS; break;
+	}
+	return error;
+}
+
+#endif /* WINTHREAD_H */
diff --git a/preload-index.c b/preload-index.c
index 9289933..6d69a8d 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -10,7 +10,11 @@ static void preload_index(struct index_state *index, const char **pathspec)
 }
 #else
 
+#ifndef _WIN32
 #include <pthread.h>
+#else
+#include <winthread.h>
+#endif
 
 /*
  * Mostly randomly chosen maximum thread counts: we
@@ -28,7 +32,11 @@ struct thread_data {
 	int offset, nr;
 };
 
+#ifndef _WIN32
 static void *preload_thread(void *_data)
+#else
+static DWORD WINAPI preload_thread(LPVOID _data)
+#endif
 {
 	int nr;
 	struct thread_data *p = _data;
@@ -59,7 +67,11 @@ static void *preload_thread(void *_data)
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
+#ifndef _WIN32
 	return NULL;
+#else
+	return 0;
+#endif
 }
 
 static void preload_index(struct index_state *index, const char **pathspec)
-- 
1.6.5.2
