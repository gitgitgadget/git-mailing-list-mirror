From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Wed, 5 Mar 2008 22:21:12 +0100
Message-ID: <200803052221.12495.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX14E-0000xS-ID
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761718AbYCEVVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 16:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761689AbYCEVVT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:21:19 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:55397 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279AbYCEVVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 16:21:16 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id B682333E82;
	Wed,  5 Mar 2008 22:21:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 74C8B609F5;
	Wed,  5 Mar 2008 22:21:13 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802281159550.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76268>

On Thursday 28 February 2008 13:05, Johannes Schindelin wrote:
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -357,6 +359,10 @@ static inline FILE *xfdopen(int fd, const char
> > *mode) return stream;
> >  }
> >
> > +#ifdef __MINGW32__
> > +int mkstemp(char *template);
> > +#endif
> > +
> >  static inline int xmkstemp(char *template)
> >  {
> >  	int fd;
>
> Could we have this...
>
> > @@ -437,4 +443,140 @@ void git_qsort(void *base, size_t nmemb, size_t
> > size, #define qsort git_qsort
> >  #endif
> >
> > +#ifdef __MINGW32__
> > +
> > +#include <winsock2.h>
> > +
> > +/*
> > + * things that are not available in header files
> > + */
> > +
> > [...]
>
> ... and this in compat/mingw.h?  And then, we'd only have
>
> #ifdef __MINGW32__
> #include "mingw.h"
> #endif
>
> in git-compat-util.h?

I've now created compat/mingw.h. Below is the interdiff. Of course, it mostly 
only moves code around. But you might want to look at at mkstemp, PATH_SEP, 
PRIuMAX, and has_dos_drive_prefix. Notice also that I include compat/mingw.h 
early in git-compat-util.h instead of late.

STRIP_EXTENSION could also be moved into compat/mingw.h, but I decided not to 
do so because I think that macros that code outside of git-compat-util.h 
checks for using #ifdef should be found in Makefile.

-- Hannes

diff --git a/Makefile b/Makefile
index 88a52bf..af74566 100644
--- a/Makefile
+++ b/Makefile
@@ -548,9 +548,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PERL_MAKEMAKER = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
-	COMPAT_CFLAGS += -DPATH_SEP="';'"
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_CFLAGS += -DPRIuMAX=\"I64u\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
 	EXTLIBS += -lws2_32
 	X = .exe
diff --git a/compat/mingw.h b/compat/mingw.h
new file mode 100644
index 0000000..d92c631
--- /dev/null
+++ b/compat/mingw.h
@@ -0,0 +1,210 @@
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
+static inline int mingw_unlink(const char *pathname)
+{
+	/* read-only files cannot be removed */
+	chmod(pathname, 0666);
+	return unlink(pathname);
+}
+#define unlink mingw_unlink
+
+static inline int waitpid(pid_t pid, unsigned *status, unsigned options)
+{
+	if (options == 0)
+		return _cwait(status, pid, 0);
+	errno = EINVAL;
+	return -1;
+}
+
+/*
+ * implementations of missing functions
+ */
+
+int pipe(int filedes[2]);
+unsigned int sleep (unsigned int seconds);
+int mkstemp(char *template);
+int gettimeofday(struct timeval *tv, void *tz);
+int poll(struct pollfd *ufds, unsigned int nfds, int timeout);
+struct tm *gmtime_r(const time_t *timep, struct tm *result);
+struct tm *localtime_r(const time_t *timep, struct tm *result);
+int getpagesize(void);	/* defined in MinGW's libgcc.a */
+struct passwd *getpwuid(int uid);
+int setitimer(int type, struct itimerval *in, struct itimerval *out);
+int sigaction(int sig, struct sigaction *in, struct sigaction *out);
+
+/*
+ * replacements of existing functions
+ */
+
+int mingw_open (const char *filename, int oflags, ...);
+#define open mingw_open
+
+char *mingw_getcwd(char *pointer, int len);
+#define getcwd mingw_getcwd
+
+struct hostent *mingw_gethostbyname(const char *host);
+#define gethostbyname mingw_gethostbyname
+
+int mingw_socket(int domain, int type, int protocol);
+#define socket mingw_socket
+
+int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
+#define connect mingw_connect
+
+int mingw_rename(const char*, const char*);
+#define rename mingw_rename
+
+/* Use mingw_lstat() instead of lstat()/stat() and
+ * mingw_fstat() instead of fstat() on Windows.
+ * struct stat is redefined because it lacks the st_blocks member.
+ */
+struct mingw_stat {
+	unsigned st_mode;
+	time_t st_mtime, st_atime, st_ctime;
+	unsigned st_dev, st_ino, st_uid, st_gid;
+	size_t st_size;
+	size_t st_blocks;
+};
+int mingw_lstat(const char *file_name, struct mingw_stat *buf);
+int mingw_fstat(int fd, struct mingw_stat *buf);
+#define fstat mingw_fstat
+#define lstat mingw_lstat
+#define stat mingw_stat
+static inline int mingw_stat(const char *file_name, struct mingw_stat *buf)
+{ return mingw_lstat(file_name, buf); }
+
+int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
+#define vsnprintf mingw_vsnprintf
+
+pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
+void mingw_execvp(const char *cmd, char *const *argv);
+#define execvp mingw_execvp
+
+static inline unsigned int git_ntohl(unsigned int x)
+{ return (unsigned int)ntohl(x); }
+#define ntohl git_ntohl
+
+sig_handler_t mingw_signal(int sig, sig_handler_t handler);
+#define signal mingw_signal
+
+/*
+ * git specific compatibility
+ */
+
+static inline int has_dos_drive_prefix(const char *path)
+{
+	return isalpha(*path) && path[1] == ':';
+}
+#define has_dos_drive_prefix has_dos_drive_prefix
+
+#define PATH_SEP ';'
+#define PRIuMAX "I64u"
+
+/*
+ * helpers
+ */
+
+char **copy_environ(void);
+void free_environ(char **env);
+char **env_setenv(char **env, const char *name);
diff --git a/git-compat-util.h b/git-compat-util.h
index 3ea0d91..1ee7357 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -89,7 +89,10 @@
 #include <grp.h>
 #define _ALL_SOURCE 1
 #endif
-#endif	/* !__MINGW32__ */
+#else 	/* __MINGW32__ */
+/* pull in Windows compatibility stuff */
+#include "compat/mingw.h"
+#endif	/* __MINGW32__ */
 
 #ifndef NO_ICONV
 #include <iconv.h>
@@ -110,6 +113,10 @@
 #define PATH_SEP ':'
 #endif
 
+#ifndef has_dos_drive_prefix
+#define has_dos_drive_prefix(path) 0
+#endif
+
 #ifdef __GNUC__
 #define NORETURN __attribute__((__noreturn__))
 #else
@@ -369,10 +376,6 @@ static inline FILE *xfdopen(int fd, const char *mode)
 	return stream;
 }
 
-#ifdef __MINGW32__
-int mkstemp(char *template);
-#endif
-
 static inline int xmkstemp(char *template)
 {
 	int fd;
@@ -453,217 +456,4 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define qsort git_qsort
 #endif
 
-#ifdef __MINGW32__
-
-#include <winsock2.h>
-
-/*
- * things that are not available in header files
- */
-
-typedef int pid_t;
-#define hstrerror strerror
-
-#define S_IFLNK    0120000 /* Symbolic link */
-#define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
-#define S_ISSOCK(x) 0
-#define S_IRGRP 0
-#define S_IWGRP 0
-#define S_IXGRP 0
-#define S_ISGID 0
-#define S_IROTH 0
-#define S_IXOTH 0
-
-#define WIFEXITED(x) ((unsigned)(x) < 259)	/* STILL_ACTIVE */
-#define WEXITSTATUS(x) ((x) & 0xff)
-#define WIFSIGNALED(x) ((unsigned)(x) > 259)
-
-#define SIGKILL 0
-#define SIGCHLD 0
-#define SIGPIPE 0
-#define SIGALRM 100
-
-#define F_GETFD 1
-#define F_SETFD 2
-#define FD_CLOEXEC 0x1
-
-struct passwd {
-	char *pw_name;
-	char *pw_gecos;
-	char *pw_dir;
-};
-
-struct pollfd {
-	int fd;           /* file descriptor */
-	short events;     /* requested events */
-	short revents;    /* returned events */
-};
-#define POLLIN 1
-#define POLLHUP 2
-
-typedef void (__cdecl *sig_handler_t)(int);
-struct sigaction {
-	sig_handler_t sa_handler;
-	unsigned sa_flags;
-};
-#define sigemptyset(x) (void)0
-#define SA_RESTART 0
-
-struct itimerval {
-	struct timeval it_value, it_interval;
-};
-#define ITIMER_REAL 0
-
-/*
- * trivial stubs
- */
-
-static inline int readlink(const char *path, char *buf, size_t bufsiz)
-{ errno = ENOSYS; return -1; }
-static inline int symlink(const char *oldpath, const char *newpath)
-{ errno = ENOSYS; return -1; }
-static inline int link(const char *oldpath, const char *newpath)
-{ errno = ENOSYS; return -1; }
-static inline int fchmod(int fildes, mode_t mode)
-{ errno = ENOSYS; return -1; }
-static inline int fork(void)
-{ errno = ENOSYS; return -1; }
-static inline unsigned int alarm(unsigned int seconds)
-{ return 0; }
-static inline int fsync(int fd)
-{ return 0; }
-static inline int getppid(void)
-{ return 1; }
-static inline void sync(void)
-{}
-static inline int getuid()
-{ return 1; }
-static inline struct passwd *getpwnam(const char *name)
-{ return NULL; }
-static inline int fcntl(int fd, int cmd, long arg)
-{
-	if (cmd == F_GETFD || cmd == F_SETFD)
-		return 0;
-	errno = EINVAL;
-	return -1;
-}
-
-/*
- * simple adaptors
- */
-
-static inline int mingw_mkdir(const char *path, int mode)
-{
-	return mkdir(path);
-}
-#define mkdir mingw_mkdir
-
-static inline int mingw_unlink(const char *pathname)
-{
-	/* read-only files cannot be removed */
-	chmod(pathname, 0666);
-	return unlink(pathname);
-}
-#define unlink mingw_unlink
-
-static inline int waitpid(pid_t pid, unsigned *status, unsigned options)
-{
-	if (options == 0)
-		return _cwait(status, pid, 0);
-	errno = EINVAL;
-	return -1;
-}
-
-/*
- * implementations of missing functions
- */
-
-int pipe(int filedes[2]);
-unsigned int sleep (unsigned int seconds);
-int gettimeofday(struct timeval *tv, void *tz);
-int poll(struct pollfd *ufds, unsigned int nfds, int timeout);
-struct tm *gmtime_r(const time_t *timep, struct tm *result);
-struct tm *localtime_r(const time_t *timep, struct tm *result);
-int getpagesize(void);	/* defined in MinGW's libgcc.a */
-struct passwd *getpwuid(int uid);
-int setitimer(int type, struct itimerval *in, struct itimerval *out);
-int sigaction(int sig, struct sigaction *in, struct sigaction *out);
-
-/*
- * replacements of existing functions
- */
-
-int mingw_open (const char *filename, int oflags, ...);
-#define open mingw_open
-
-char *mingw_getcwd(char *pointer, int len);
-#define getcwd mingw_getcwd
-
-struct hostent *mingw_gethostbyname(const char *host);
-#define gethostbyname mingw_gethostbyname
-
-int mingw_socket(int domain, int type, int protocol);
-#define socket mingw_socket
-
-int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz);
-#define connect mingw_connect
-
-int mingw_rename(const char*, const char*);
-#define rename mingw_rename
-
-/* Use mingw_lstat() instead of lstat()/stat() and
- * mingw_fstat() instead of fstat() on Windows.
- * struct stat is redefined because it lacks the st_blocks member.
- */
-struct mingw_stat {
-	unsigned st_mode;
-	time_t st_mtime, st_atime, st_ctime;
-	unsigned st_dev, st_ino, st_uid, st_gid;
-	size_t st_size;
-	size_t st_blocks;
-};
-int mingw_lstat(const char *file_name, struct mingw_stat *buf);
-int mingw_fstat(int fd, struct mingw_stat *buf);
-#define fstat mingw_fstat
-#define lstat mingw_lstat
-#define stat mingw_stat
-static inline int mingw_stat(const char *file_name, struct mingw_stat *buf)
-{ return mingw_lstat(file_name, buf); }
-
-int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
-#define vsnprintf mingw_vsnprintf
-
-pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
-void mingw_execvp(const char *cmd, char *const *argv);
-#define execvp mingw_execvp
-
-static inline unsigned int git_ntohl(unsigned int x)
-{ return (unsigned int)ntohl(x); }
-#define ntohl git_ntohl
-
-sig_handler_t mingw_signal(int sig, sig_handler_t handler);
-#define signal mingw_signal
-
-/*
- * helpers
- */
-
-char **copy_environ(void);
-void free_environ(char **env);
-char **env_setenv(char **env, const char *name);
-
-static inline int has_dos_drive_prefix(const char *path)
-{
-	return isalpha(*path) && path[1] == ':';
-}
-
-#else /* __MINGW32__ */
-
-static inline int has_dos_drive_prefix(const char *path)
-{
-	return 0;
-}
-
-#endif /* __MINGW32__ */
