From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 0/7] Miscellaneous improvements on Windows
Date: Fri, 15 Jan 2010 21:12:14 +0100
Message-ID: <cover.1263584975.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:13:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsY5-0004ka-Nc
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 21:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136Ab0AOUNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 15:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757492Ab0AOUNc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 15:13:32 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:31488 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751709Ab0AOUNb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 15:13:31 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 36766CDF8A;
	Fri, 15 Jan 2010 21:13:29 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9E50319F60D;
	Fri, 15 Jan 2010 21:12:32 +0100 (CET)
X-Mailer: git-send-email 1.6.6.218.g3e6eb
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137107>

This round updates Andrzej's pthread patch to use Interlocked* functions.
I merged my follow-up that enables pthreads on MinGW into this patch.

There are three new patches:

- Erik's patch that disables Python

- Ramsay's MSVC warning fix.

- A new gettimeofday implementation that does not call out from mingw.c
  (compatibility layer) to the generic code anymore.

The interdiff to the previous round is below.


Andrzej K. Haczewski (1):
  MSVC: Windows-native implementation for subset of Pthreads API

Erik Faye-Lund (1):
  Windows: disable Python

Johannes Sixt (4):
  Windows: boost startup by avoiding a static dependency on shell32.dll
  Windows: simplify the pipe(2) implementation
  Windows: avoid the "dup dance" when spawning a child process
  Do not use date.c:tm_to_time_t() from compat/mingw.c

Ramsay Allan Jones (1):
  MSVC: Fix an "incompatible pointer types" compiler warning

 Makefile               |   15 ++++---
 builtin-pack-objects.c |   31 +++++++++++--
 compat/mingw.c         |  116 ++++++++++++++++++++++++-----------------------
 compat/mingw.h         |   12 ++++-
 compat/msvc.h          |   40 +++++++----------
 compat/win32/pthread.c |  110 +++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/pthread.h |   67 +++++++++++++++++++++++++++
 run-command.c          |   71 +++++++++++++----------------
 8 files changed, 329 insertions(+), 133 deletions(-)
 create mode 100644 compat/win32/pthread.c
 create mode 100644 compat/win32/pthread.h

Interdiff:

diff --git a/Makefile b/Makefile
index ffcac04..7f5814c 100644
--- a/Makefile
+++ b/Makefile
@@ -996,8 +996,9 @@ ifeq ($(uname_S),Windows)
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
+	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -1046,6 +1047,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
+	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
diff --git a/compat/mingw.c b/compat/mingw.c
index 74ffc18..ab65f77 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -140,12 +140,20 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }
 
-static inline time_t filetime_to_time_t(const FILETIME *ft)
+/*
+ * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
+ * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
+ */
+static inline long long filetime_to_hnsec(const FILETIME *ft)
 {
 	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
-	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
-	winTime /= 10000000;		 /* Nano to seconds resolution */
-	return (time_t)winTime;
+	/* Windows to Unix Epoch conversion */
+	return winTime - 116444736000000000LL;
+}
+
+static inline time_t filetime_to_time_t(const FILETIME *ft)
+{
+	return (time_t)(filetime_to_hnsec(ft) / 10000000);
 }
 
 /* We keep the do_lstat code in a separate function to avoid recursion.
@@ -281,19 +289,13 @@ int mkstemp(char *template)
 
 int gettimeofday(struct timeval *tv, void *tz)
 {
-	SYSTEMTIME st;
-	struct tm tm;
-	GetSystemTime(&st);
-	tm.tm_year = st.wYear-1900;
-	tm.tm_mon = st.wMonth-1;
-	tm.tm_mday = st.wDay;
-	tm.tm_hour = st.wHour;
-	tm.tm_min = st.wMinute;
-	tm.tm_sec = st.wSecond;
-	tv->tv_sec = tm_to_time_t(&tm);
-	if (tv->tv_sec < 0)
-		return -1;
-	tv->tv_usec = st.wMilliseconds*1000;
+	FILETIME ft;
+	long long hnsec;
+
+	GetSystemTimeAsFileTime(&ft);
+	hnsec = filetime_to_hnsec(&ft);
+	tv->tv_sec = hnsec / 10000000;
+	tv->tv_usec = (hnsec % 10000000) / 10;
 	return 0;
 }
 
diff --git a/compat/mingw.h b/compat/mingw.h
index 238fd70..e254fb4 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -209,13 +209,15 @@ int mingw_getpagesize(void);
  * mingw_fstat() instead of fstat() on Windows.
  */
 #define off_t off64_t
-#define stat _stati64
 #define lseek _lseeki64
+#ifndef ALREADY_DECLARED_STAT_FUNCS
+#define stat _stati64
 int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
 #define _stati64(x,y) mingw_lstat(x,y)
+#endif
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
diff --git a/compat/msvc.h b/compat/msvc.h
index 9c753a5..023aba0 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -21,30 +21,22 @@ static __inline int strcasecmp (const char *s1, const char *s2)
 }
 
 #undef ERROR
-#undef stat
-#undef _stati64
-#include "compat/mingw.h"
-#undef stat
-#define stat _stati64
+
+/* Use mingw_lstat() instead of lstat()/stat() and mingw_fstat() instead
+ * of fstat(). We add the declaration of these functions here, suppressing
+ * the corresponding declarations in mingw.h, so that we can use the
+ * appropriate structure type (and function) names from the msvc headers.
+ */
+#define stat _stat64
+int mingw_lstat(const char *file_name, struct stat *buf);
+int mingw_fstat(int fd, struct stat *buf);
+#define fstat mingw_fstat
+#define lstat mingw_lstat
 #define _stat64(x,y) mingw_lstat(x,y)
+#define ALREADY_DECLARED_STAT_FUNCS
+
+#include "compat/mingw.h"
+
+#undef ALREADY_DECLARED_STAT_FUNCS
 
-/*
-   Even though _stati64 is normally just defined at _stat64
-   on Windows, we specify it here as a proper struct to avoid
-   compiler warnings about macro redefinition due to magic in
-   mingw.h. Struct taken from ReactOS (GNU GPL license).
-*/
-struct _stati64 {
-	_dev_t  st_dev;
-	_ino_t  st_ino;
-	unsigned short st_mode;
-	short   st_nlink;
-	short   st_uid;
-	short   st_gid;
-	_dev_t  st_rdev;
-	__int64 st_size;
-	time_t  st_atime;
-	time_t  st_mtime;
-	time_t  st_ctime;
-};
 #endif
diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 652d7b4..631c0a4 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -53,8 +53,6 @@ int pthread_cond_init(pthread_cond_t *cond, const void *unused)
 {
 	cond->waiters = 0;
 
-	InitializeCriticalSection(&cond->waiters_lock);
-
 	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
 	if (!cond->sema)
 		die("CreateSemaphore() failed");
@@ -66,17 +64,12 @@ int pthread_cond_destroy(pthread_cond_t *cond)
 	CloseHandle(cond->sema);
 	cond->sema = NULL;
 
-	DeleteCriticalSection(&cond->waiters_lock);
-
 	return 0;
 }
 
 int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 {
-	/* serialize access to waiters count */
-	EnterCriticalSection(&cond->waiters_lock);
-	++cond->waiters;
-	LeaveCriticalSection(&cond->waiters_lock);
+	InterlockedIncrement(&cond->waiters);
 
 	/*
 	 * Unlock external mutex and wait for signal.
@@ -90,9 +83,7 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 	WaitForSingleObject(cond->sema, INFINITE);
 
 	/* we're done waiting, so make sure we decrease waiters count */
-	EnterCriticalSection(&cond->waiters_lock);
-	--cond->waiters;
-	LeaveCriticalSection(&cond->waiters_lock);
+	InterlockedDecrement(&cond->waiters);
 
 	/* lock external mutex again */
 	EnterCriticalSection(mutex);
@@ -102,12 +93,11 @@ int pthread_cond_wait(pthread_cond_t *cond, CRITICAL_SECTION *mutex)
 
 int pthread_cond_signal(pthread_cond_t *cond)
 {
-	int have_waiters;
-
-	/* serialize access to waiters count */
-	EnterCriticalSection(&cond->waiters_lock);
-	have_waiters = cond->waiters > 0;
-	LeaveCriticalSection(&cond->waiters_lock);
+	/*
+	 * Access to waiters count is atomic; see "Interlocked Variable Access"
+	 * http://msdn.microsoft.com/en-us/library/ms684122(VS.85).aspx
+	 */
+	int have_waiters = cond->waiters > 0;
 
 	/*
 	 * Signal only when there are waiters
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 47888e4..b8e1bcb 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -32,8 +32,7 @@
  * See also: http://www.cse.wustl.edu/~schmidt/win32-cv-1.html
  */
 typedef struct {
-	LONG waiters;
-	CRITICAL_SECTION waiters_lock;
+	volatile LONG waiters;
 	HANDLE sema;
 } pthread_cond_t;
 
