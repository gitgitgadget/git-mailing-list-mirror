From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 03/40] Add target architecture MinGW.
Date: Wed, 27 Feb 2008 19:54:26 +0100
Message-ID: <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:56:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURRY-0000Km-BG
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbYB0SzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbYB0SzO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:14 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40417 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbYB0SzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:06 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 7F05D974B1;
	Wed, 27 Feb 2008 19:55:04 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75249>

With this change GIT can be compiled and linked using MinGW. Builtins
that only read the repository such as the log family and grep already
work.

Simple stubs are provided for a number of functions that the Windows C
runtime does not offer. They will be completed in later patches.

Dmitry Kakurin pointed out that access(..., X_OK) would always fails on
Vista and suggested the -D__USE_MINGW_ACCESS workaround.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile          |   25 +++++++++
 compat/mingw.c    |   57 ++++++++++++++++++++
 git-compat-util.h |  148 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 227 insertions(+), 3 deletions(-)
 create mode 100644 compat/mingw.c

diff --git a/Makefile b/Makefile
index 870a862..bc8a487 100644
--- a/Makefile
+++ b/Makefile
@@ -522,6 +522,31 @@ ifeq ($(uname_S),HP-UX)
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
 endif
+ifneq (,$(findstring MINGW,$(uname_S)))
+	NO_MMAP = YesPlease
+	NO_PREAD = YesPlease
+	NO_OPENSSL = YesPlease
+	NO_CURL = YesPlease
+	NO_SYMLINK_HEAD = YesPlease
+	NO_IPV6 = YesPlease
+	NO_SETENV = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MEMMEM = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	OLD_ICONV = YesPlease
+	NO_C99_FORMAT = YesPlease
+	NO_STRTOUMAX = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_SVN_TESTS = YesPlease
+	NO_PERL_MAKEMAKER = YesPlease
+	NO_EXTRA_PROGRAMS = YesPlease
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
+	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
+	EXTLIBS += -lws2_32
+	X = .exe
+endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
diff --git a/compat/mingw.c b/compat/mingw.c
new file mode 100644
index 0000000..0c87e43
--- /dev/null
+++ b/compat/mingw.c
@@ -0,0 +1,57 @@
+#include "../git-compat-util.h"
+
+unsigned int _CRT_fmode = _O_BINARY;
+
+unsigned int sleep (unsigned int seconds)
+{
+	Sleep(seconds*1000);
+	return 0;
+}
+
+int mkstemp(char *template)
+{
+	char *filename = mktemp(template);
+	if (filename == NULL)
+		return -1;
+	return open(filename, O_RDWR | O_CREAT, 0600);
+}
+
+int gettimeofday(struct timeval *tv, void *tz)
+{
+	return 0;
+}
+
+int poll(struct pollfd *ufds, unsigned int nfds, int timeout)
+{
+	return 0;
+}
+
+struct tm *gmtime_r(const time_t *timep, struct tm *result)
+{
+	/* gmtime() in MSVCRT.DLL is thread-safe, but not reentrant */
+	memcpy(result, gmtime(timep), sizeof(struct tm));
+	return result;
+}
+
+struct tm *localtime_r(const time_t *timep, struct tm *result)
+{
+	/* localtime() in MSVCRT.DLL is thread-safe, but not reentrant */
+	memcpy(result, localtime(timep), sizeof(struct tm));
+	return result;
+}
+
+struct passwd *getpwuid(int uid)
+{
+	static struct passwd p;
+	return &p;
+}
+
+int setitimer(int type, struct itimerval *in, struct itimerval *out)
+{
+	return 0;
+}
+
+int sigaction(int sig, struct sigaction *in, struct sigaction *out)
+{
+	return 0;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 2a40703..b1f3f92 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -63,16 +63,17 @@
 #include <sys/time.h>
 #include <time.h>
 #include <signal.h>
-#include <sys/wait.h>
 #include <fnmatch.h>
+#include <assert.h>
+#include <regex.h>
+#ifndef __MINGW32__
+#include <sys/wait.h>
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
 #endif
-#include <assert.h>
-#include <regex.h>
 #include <netinet/in.h>
 #include <netinet/tcp.h>
 #include <arpa/inet.h>
@@ -88,6 +89,7 @@
 #include <grp.h>
 #define _ALL_SOURCE 1
 #endif
+#endif	/* !__MINGW32__ */
 
 #ifndef NO_ICONV
 #include <iconv.h>
@@ -357,6 +359,10 @@ static inline FILE *xfdopen(int fd, const char *mode)
 	return stream;
 }
 
+#ifdef __MINGW32__
+int mkstemp(char *template);
+#endif
+
 static inline int xmkstemp(char *template)
 {
 	int fd;
@@ -437,4 +443,140 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define qsort git_qsort
 #endif
 
+#ifdef __MINGW32__
+
+#include <winsock2.h>
+
+/*
+ * things that are not available in header files
+ */
+
+typedef int pid_t;
+#define hstrerror strerror
+
+#define S_IFLNK    0120000 /* Symbolic link */
+#define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
+#define S_ISSOCK(x) 0
+#define S_IRGRP 0
+#define S_IWGRP 0
+#define S_IXGRP 0
+#define S_ISGID 0
+#define S_IROTH 0
+#define S_IXOTH 0
+
+#define WIFEXITED(x) ((unsigned)(x) < 259)	/* STILL_ACTIVE */
+#define WEXITSTATUS(x) ((x) & 0xff)
+#define WIFSIGNALED(x) ((unsigned)(x) > 259)
+
+#define SIGKILL 0
+#define SIGCHLD 0
+#define SIGPIPE 0
+#define SIGALRM 100
+
+#define F_GETFD 1
+#define F_SETFD 2
+#define FD_CLOEXEC 0x1
+
+struct passwd {
+	char *pw_name;
+	char *pw_gecos;
+	char *pw_dir;
+};
+
+struct pollfd {
+	int fd;           /* file descriptor */
+	short events;     /* requested events */
+	short revents;    /* returned events */
+};
+#define POLLIN 1
+#define POLLHUP 2
+
+typedef void (__cdecl *sig_handler_t)(int);
+struct sigaction {
+	sig_handler_t sa_handler;
+	unsigned sa_flags;
+};
+#define sigemptyset(x) (void)0
+#define SA_RESTART 0
+
+struct itimerval {
+	struct timeval it_value, it_interval;
+};
+#define ITIMER_REAL 0
+
+#define st_blocks st_size/512	/* will be cleaned up later */
+#define lstat stat
+
+/*
+ * trivial stubs
+ */
+
+static inline int readlink(const char *path, char *buf, size_t bufsiz)
+{ errno = ENOSYS; return -1; }
+static inline int symlink(const char *oldpath, const char *newpath)
+{ errno = ENOSYS; return -1; }
+static inline int link(const char *oldpath, const char *newpath)
+{ errno = ENOSYS; return -1; }
+static inline int fchmod(int fildes, mode_t mode)
+{ errno = ENOSYS; return -1; }
+static inline int fork(void)
+{ errno = ENOSYS; return -1; }
+static inline unsigned int alarm(unsigned int seconds)
+{ return 0; }
+static inline int fsync(int fd)
+{ return 0; }
+static inline int getppid(void)
+{ return 1; }
+static inline void sync(void)
+{}
+static inline int getuid()
+{ return 1; }
+static inline struct passwd *getpwnam(const char *name)
+{ return NULL; }
+static inline int fcntl(int fd, int cmd, long arg)
+{
+	if (cmd == F_GETFD || cmd == F_SETFD)
+		return 0;
+	errno = EINVAL;
+	return -1;
+}
+
+/*
+ * simple adaptors
+ */
+
+static inline int mingw_mkdir(const char *path, int mode)
+{
+	return mkdir(path);
+}
+#define mkdir mingw_mkdir
+
+static inline int waitpid(pid_t pid, unsigned *status, unsigned options)
+{
+	if (options == 0)
+		return _cwait(status, pid, 0);
+	errno = EINVAL;
+	return -1;
+}
+
+
+static inline int pipe(int filedes[2])
+{ return _pipe(filedes, 8192, 0); }
+
+/*
+ * implementations of missing functions
+ */
+
+unsigned int sleep (unsigned int seconds);
+int gettimeofday(struct timeval *tv, void *tz);
+int poll(struct pollfd *ufds, unsigned int nfds, int timeout);
+struct tm *gmtime_r(const time_t *timep, struct tm *result);
+struct tm *localtime_r(const time_t *timep, struct tm *result);
+int getpagesize(void);	/* defined in MinGW's libgcc.a */
+struct passwd *getpwuid(int uid);
+int setitimer(int type, struct itimerval *in, struct itimerval *out);
+int sigaction(int sig, struct sigaction *in, struct sigaction *out);
+
+#endif /* __MINGW32__ */
+
 #endif
-- 
1.5.4.1.126.ge5a7d
