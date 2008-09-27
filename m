From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v2] Add a "fast stat" mode for Cygwin
Date: Sat, 27 Sep 2008 03:02:06 -0400
Message-ID: <1222498926-30635-1-git-send-email-marcus@griep.us>
References: <20080923140144.GN21650@dpotapov.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 09:03:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjTpr-0007zc-6O
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 09:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbYI0HCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 03:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbYI0HCJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 03:02:09 -0400
Received: from boohaunt.net ([209.40.206.144]:48691 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbYI0HCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 03:02:07 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 51AF41878D06; Sat, 27 Sep 2008 03:02:06 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.405.g3cc38
In-Reply-To: <20080923140144.GN21650@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96902>

This patch introduces core.cygwinnativestat configuration flag. If this
variable is not set then Git will work as before. However, if it is set
then the Cygwin version of Git will try to use a Win32 API function if
it is possible to speed up stat/lstat.

This fast mode works only for relative paths. It is assumed that the
whole repository is located inside one directory without using Cygwin
mount to bind external paths inside of the current tree.

Symbolic links are supported by falling back on the cygwin version of
these functions.

A very superficial testing shows 'git status' in the fast mode works more
than twice faster than in the normal mode, i.e. with about the same speed
as the native MinGW version.

Also, with this patch, Cygwin and MinGW share the same code for doing
native filesystem stats.  Also incorporates Shawn Pearce's suggestion
to use a config flag rather than an environment variable to control
which method (native or cygwin) is used.

Originally-by: Dmitry Potapov <dpotapov@gmail.com>
Signed-off-by: Marcus Griep <marcus@griep.us>
---

 This is a substitute patch that takes care of many of the concerns already
 posted to this thread regarding the patch.  Sorry if it steps on your toes,
 Dmitry.  You began scratching my itch, so I wanted to jump in and scratch
 some more.

 Overall, the new patch implements many of the ideas from the thread, including
 using a configuration flag to determine which stat (cygwin or native) to use,
 and the code is refactored so that MinGW and Cygwin can both use the same
 base stat code.

 If it looks good, I'd appreciate a regression 'Tested-by' from the MinGW
 folks to make sure I didn't break their compile or such.

 Also, if you'd prefer that I submit a patch that would be applied on top
 of Dmitry's currently pending patch, I can do that as well.

 Finally, here is the output from a little benchmark I ran on my large
 repository at work:
 115769 files in 17626 directories

 Windows native stat: false
 2.17user 8.92system 0:14.40elapsed 76%CPU (0avgtext+0avgdata 22544384maxresident)k
 0inputs+0outputs (161427major+0minor)pagefaults 0swaps

 Windows native stat: true
 1.00user 2.85system 0:06.26elapsed 61%CPU (0avgtext+0avgdata 22544384maxresident)k
 0inputs+0outputs (161427major+0minor)pagefaults 0swaps

 Looks like a nice improvement to me.

 -Marcus

 Makefile          |    7 ++++
 cache.h           |    1 +
 compat/cygwin.c   |   67 ++++++++++++++++++++++++++++++++++++
 compat/cygwin.h   |    7 ++++
 compat/mingw.c    |   64 +---------------------------------
 compat/windows.c  |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/windows.h  |   12 ++++++
 environment.c     |    5 +++
 git-compat-util.h |    1 +
 9 files changed, 200 insertions(+), 62 deletions(-)
 create mode 100644 compat/cygwin.c
 create mode 100644 compat/cygwin.h
 create mode 100644 compat/windows.c
 create mode 100644 compat/windows.h

diff --git a/Makefile b/Makefile
index e0c03c3..685f038 100644
--- a/Makefile
+++ b/Makefile
@@ -346,6 +346,8 @@ LIB_H += cache.h
 LIB_H += cache-tree.h
 LIB_H += commit.h
 LIB_H += compat/mingw.h
+LIB_H += compat/cygwin.h
+LIB_H += compat/windows.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -748,6 +750,10 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
+ifneq (,$(findstring CYGWIN,$(uname_S)))
+	COMPAT_OBJS += compat/cygwin.o
+	COMPAT_OBJS += compat/windows.o
+endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MMAP = YesPlease
 	NO_PREAD = YesPlease
@@ -774,6 +780,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/regex/regex.o compat/winansi.o
+	COMPAT_OBJS += compat/windows.o
 	EXTLIBS += -lws2_32
 	X = .exe
 	gitexecdir = ../libexec/git-core
diff --git a/cache.h b/cache.h
index f4b8ddf..b42ca0f 100644
--- a/cache.h
+++ b/cache.h
@@ -321,6 +321,7 @@ extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
 extern void set_git_work_tree(const char *tree);
+extern int have_git_dir(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/compat/cygwin.c b/compat/cygwin.c
new file mode 100644
index 0000000..db44aa8
--- /dev/null
+++ b/compat/cygwin.c
@@ -0,0 +1,67 @@
+#include "windows.h"
+#include "../cache.h"
+
+#undef stat
+#undef lstat
+
+/* We provide our own lstat/stat functions, since the provided Cygwin versions
+ * of these functions are too slow. These stat functions are tailored for Git's
+ * usage, and therefore they are not meant to be complete and correct emulation
+ * of lstat/stat functionality.
+ */
+static int cygwin_lstat(const char *path, struct stat *buf)
+{
+	return win_stat(path, buf, lstat);
+}
+
+static int cygwin_stat(const char *path, struct stat *buf)
+{
+	return win_stat(path, buf, stat);
+}
+
+static int native_stat = -1;
+static stat_fn_t cygwin_stat_fn = stat;
+static stat_fn_t cygwin_lstat_fn = lstat;
+
+static int git_cygwin_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "core.cygwinnativestat"))
+		native_stat = git_config_bool(var, value);
+	return 0;
+}
+
+static void init_stat(void)
+{
+	if (native_stat < 0 && have_git_dir()) {
+		native_stat = 0;
+		git_config(git_cygwin_config, NULL);
+		cygwin_stat_fn = native_stat ? cygwin_stat : stat;
+		cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
+	}
+}
+
+/*
+ * This are startup stubs, which choose what implementation of lstat/stat
+ * should be used. If core.cygwinnativestat is not set then the standard
+ * functions included in the cygwin library are used. If it is set then our
+ * fast and dirty implementation is invoked, which should be 2-3 times
+ * faster than cygwin functions.
+ */
+int cygwin_stat_choice(const char *file_name, struct stat *buf)
+{
+	if (file_name[0] == '/')
+		return stat(file_name, buf);
+
+	init_stat();
+	return (cygwin_stat_fn ? cygwin_stat_fn : stat) (file_name, buf);
+}
+
+int cygwin_lstat_choice(const char *file_name, struct stat *buf)
+{
+	if (file_name[0] == '/')
+		return lstat(file_name, buf);
+
+	init_stat();
+	return (cygwin_lstat_fn ? cygwin_lstat_fn : lstat) (file_name, buf);
+}
+
diff --git a/compat/cygwin.h b/compat/cygwin.h
new file mode 100644
index 0000000..14775fd
--- /dev/null
+++ b/compat/cygwin.h
@@ -0,0 +1,7 @@
+#include "windows.h"
+
+int cygwin_stat_choice(const char*, struct stat*);
+int cygwin_lstat_choice(const char*, struct stat*);
+
+#define stat(path,buf) cygwin_stat_choice(path,buf)
+#define lstat cygwin_lstat_choice
diff --git a/compat/mingw.c b/compat/mingw.c
index ccfa2a0..174142c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -23,66 +23,6 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }
 
-static inline time_t filetime_to_time_t(const FILETIME *ft)
-{
-	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
-	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
-	winTime /= 10000000;		 /* Nano to seconds resolution */
-	return (time_t)winTime;
-}
-
-extern int _getdrive( void );
-/* We keep the do_lstat code in a separate function to avoid recursion.
- * When a path ends with a slash, the stat will fail with ENOENT. In
- * this case, we strip the trailing slashes and stat again.
- */
-static int do_lstat(const char *file_name, struct stat *buf)
-{
-	WIN32_FILE_ATTRIBUTE_DATA fdata;
-
-	if (GetFileAttributesExA(file_name, GetFileExInfoStandard, &fdata)) {
-		int fMode = S_IREAD;
-		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
-			fMode |= S_IFDIR;
-		else
-			fMode |= S_IFREG;
-		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
-			fMode |= S_IWRITE;
-
-		buf->st_ino = 0;
-		buf->st_gid = 0;
-		buf->st_uid = 0;
-		buf->st_nlink = 1;
-		buf->st_mode = fMode;
-		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
-		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
-		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
-		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
-		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
-		errno = 0;
-		return 0;
-	}
-
-	switch (GetLastError()) {
-	case ERROR_ACCESS_DENIED:
-	case ERROR_SHARING_VIOLATION:
-	case ERROR_LOCK_VIOLATION:
-	case ERROR_SHARING_BUFFER_EXCEEDED:
-		errno = EACCES;
-		break;
-	case ERROR_BUFFER_OVERFLOW:
-		errno = ENAMETOOLONG;
-		break;
-	case ERROR_NOT_ENOUGH_MEMORY:
-		errno = ENOMEM;
-		break;
-	default:
-		errno = ENOENT;
-		break;
-	}
-	return -1;
-}
-
 /* We provide our own lstat/fstat functions, since the provided
  * lstat/fstat functions are so slow. These stat functions are
  * tailored for Git's usage (read: fast), and are not meant to be
@@ -94,7 +34,7 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 	int namelen;
 	static char alt_name[PATH_MAX];
 
-	if (!do_lstat(file_name, buf))
+	if (!win_stat(file_name, buf, win_stat_fail))
 		return 0;
 
 	/* if file_name ended in a '/', Windows returned ENOENT;
@@ -113,7 +53,7 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 
 	memcpy(alt_name, file_name, namelen);
 	alt_name[namelen] = 0;
-	return do_lstat(alt_name, buf);
+	return win_stat(alt_name, buf, win_stat_fail);
 }
 
 #undef fstat
diff --git a/compat/windows.c b/compat/windows.c
new file mode 100644
index 0000000..8c7d976
--- /dev/null
+++ b/compat/windows.c
@@ -0,0 +1,98 @@
+#define WIN32_LEAN_AND_MEAN
+#include "../git-compat-util.h"
+#include <windows.h>
+
+static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
+{
+	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
+	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
+	ts->tv_sec = (time_t)(winTime/10000000); /* 100-nanosecond interval to seconds */
+	ts->tv_nsec = (long)(winTime - ts->tv_sec*10000000LL) * 100; /* nanoseconds */
+}
+
+#define size_to_blocks(s) (((s)+511)/512)
+
+/* do_lstat is a common implementation of a faster stat algorithm for Windows
+ *
+ * When the Windows stat fails for an unknown reason, a fallback is called to
+ * handle the error.
+ */
+int win_stat(const char *file_name, struct stat *buf, stat_fn_t fallback)
+{
+	WIN32_FILE_ATTRIBUTE_DATA fdata;
+
+	if (GetFileAttributesExA(file_name, GetFileExInfoStandard, &fdata)) {
+		int fMode = S_IREAD;
+
+#if defined(__CYGWIN__)
+		/*
+		 * If the system attribute is set and it is not a directory then
+		 * it could be a symbol link created in the nowinsymlinks mode.
+		 * Normally, Cygwin works in the winsymlinks mode, so this situation
+		 * is very unlikely. For the sake of simplicity of our code, let's
+		 * Cygwin to handle it.
+		 */
+		if ((fdata.dwFileAttributes & FILE_ATTRIBUTE_SYSTEM) &&
+		    !(fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
+			return fallback (file_name, buf);
+#endif
+
+		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+			fMode |= S_IFDIR;
+		else
+			fMode |= S_IFREG;
+		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
+			fMode |= S_IWRITE;
+
+		buf->st_ino = 0;
+		buf->st_gid = buf->st_uid = 0;
+		buf->st_nlink = 1;
+		buf->st_mode = fMode;
+#ifdef __CYGWIN_USE_BIG_TYPES__
+		buf->st_size = ((_off64_t)fdata.nFileSizeHigh << 32) +
+			fdata.nFileSizeLow;
+#else
+		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
+#endif
+		buf->st_blocks = size_to_blocks(buf->st_size);
+		/* st_dev, st_rdev are not used by Git */
+		buf->st_dev = buf->st_rdev = 0;
+		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
+		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
+		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
+		errno = 0;
+		return 0;
+	}
+
+	switch (GetLastError()) {
+	case ERROR_ACCESS_DENIED:
+	case ERROR_SHARING_VIOLATION:
+	case ERROR_LOCK_VIOLATION:
+	case ERROR_SHARING_BUFFER_EXCEEDED:
+		errno = EACCES;
+		break;
+	case ERROR_BUFFER_OVERFLOW:
+		errno = ENAMETOOLONG;
+		break;
+	case ERROR_NOT_ENOUGH_MEMORY:
+		errno = ENOMEM;
+		break;
+	default:
+		/* In the winsymlinks mode (which is the default), Cygwin
+		 * emulates symbol links using Windows shortcut files. These
+		 * files are formed by adding .lnk extension. So, if we have
+		 * not found the specified file name, it could be that it is
+		 * a symbol link. Let's the fallback deal with that.
+		 * In MinGW, this could also happen if the path ends with a
+		 * slash.
+		 */
+		return fallback (file_name, buf);
+	}
+	return -1;
+}
+
+int win_stat_fail(const char *file_name, struct stat *buf)
+{
+	errno = ENOENT;
+	return -1;
+}
diff --git a/compat/windows.h b/compat/windows.h
new file mode 100644
index 0000000..8412e42
--- /dev/null
+++ b/compat/windows.h
@@ -0,0 +1,12 @@
+#ifndef COMPAT_WINDOWS_H
+#define COMPAT_WINDOWS_H
+
+#include <sys/types.h>
+#include <sys/stat.h>
+
+typedef int (*stat_fn_t)(const char*, struct stat*);
+
+extern int win_stat(const char*, struct stat*, stat_fn_t);
+extern int win_stat_fail(const char*, struct stat *);
+
+#endif
diff --git a/environment.c b/environment.c
index 0c6d11f..cbd8074 100644
--- a/environment.c
+++ b/environment.c
@@ -151,3 +151,8 @@ int set_git_dir(const char *path)
 	setup_git_env();
 	return 0;
 }
+
+int have_git_dir(void)
+{
+	return !!git_dir;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index db2836f..cd9752c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,6 +85,7 @@
 #undef _XOPEN_SOURCE
 #include <grp.h>
 #define _XOPEN_SOURCE 600
+#include "compat/cygwin.h"
 #else
 #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
-- 
1.6.0.2.405.g3cc38
