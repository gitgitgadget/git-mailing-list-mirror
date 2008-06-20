From: Johannes Sixt <j.sixt@viscovery.net>
Subject: MinGW port pull request
Date: Fri, 20 Jun 2008 10:06:40 +0200
Message-ID: <485B6510.3080201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 10:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ber-0003Eo-H8
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 10:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYFTIGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 04:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbYFTIGs
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 04:06:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54541 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYFTIGo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 04:06:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K9bdo-0006Mw-US; Fri, 20 Jun 2008 10:06:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B03664FB; Fri, 20 Jun 2008 10:06:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85604>

From: Johannes Sixt <johannes.sixt@telecom.at>

Junio,

please pull the MinGW (Windows) port patch series from

git://repo.or.cz/git/mingw/j6t.git for-junio

The interdiff since I submitted the patch series

 http://thread.gmane.org/gmane.comp.version-control.git/75250/focus=76276

is below.

This code base has been used in production since months, and editorial
issues have been ironed out since I submitted the series. The interdiff is
fairly small (it's mostly some new vsnprintf() fixes and a new utime()
wrapper). The interdiff does not show that we don't need to modify
git-clone.sh anymore ;) IMHO, this is material for 'next'.

At this point I would like to thank all contributors to the porting
effort. Some of your patches have been integrated in other patches in the
series, which now carry my authorship (that is, I'm the one to blame), but
I still have credited you in the commit message.


Here's the patch summary:

* Part 1: Get it going
01/38 Add compat/regex.[ch] and compat/fnmatch.[ch].
02/38 Compile some programs only conditionally.
03/38 Add target architecture MinGW.

With these patches we have a working git.exe that can successfully run
those builtins that need only read-access of the repository, like
git log, git diff, etc.

* Part 2: Working locally is possible
04/38 Windows: Use the Windows style PATH separator ';'.
05/38 Windows: Strip ".exe" from the program name.
06/38 Windows: Implement a wrapper of the open() function.
07/38 Windows: A minimal implemention of getpwuid().
08/38 Windows: always chmod(, 0666) before unlink().
09/38 Windows: Work around misbehaved rename().
10/38 setup.c: Prepare for Windows directory separators.
11/38 Windows: Treat Windows style path names.
12/38 Windows: Handle absolute paths in safe_create_leading_directories().
13/38 Windows: Implement gettimeofday().
14/38 Windows: Fix PRIuMAX definition.
15/38 Windows: Implement setitimer() and sigaction().

Now builtins that write to the repository work as long as they don't need
to spawn secondary processes.

* Part 3: Shell scripts and start_command()
16/38 Windows: Wrap execve so that shell scripts can be invoked.
17/38 Windows: A pipe() replacement whose ends are not inherited to
      children.
18/38 Windows: Implement start_command().
19/38 Windows: Change the name of hook scripts to make them not
      executable.

Now scripted tools and the builtins and standalone programs work that
depend on start_command().

* Part 4: Remote connections
20/38 Windows: A rudimentary poll() emulation.
21/38 Windows: Disambiguate DOS style paths from SSH URLs.
22/38 Windows: Implement asynchronous functions as threads.
23/38 Windows: Work around incompatible sort and find.
24/38 Windows: Implement wrappers for gethostbyname(), socket(), and
      connect().

Remote connections, both push and fetch, using local transport as well as
connections via ssh and native git protocol work.

* Part 5: Optimizations
25/38 Windows: Implement a custom spawnve().
26/38 Windows: Add a new lstat and fstat implementation based on Win32
      API.
27/38 Windows: Add a custom implementation for utime().
28/38 Windows: Use a customized struct stat that also has the st_blocks
      member.

* Part 6: Tie up loose ends
29/38 Turn builtin_exec_path into a function.
30/38 Windows: Compute the fallback for exec_path from the program
      invocation.
31/38 Windows: Use a relative default template_dir and ETC_GITCONFIG
32/38 When installing, be prepared that template_dir may be relative.
33/38 Windows: Make the pager work.
34/38 Windows: Work around an oddity when a pipe with no reader is written
      to.
35/38 Windows: Make 'git help -a' work.
36/38 Windows: TMP and TEMP environment variables specify a temporary
      directory.
37/38 Windows: Fix ntohl() related warnings about printf formatting
38/38 compat/pread.c: Add a forward declaration to fix a warning

This fixes some final remaining oddities, minor missing features, and
works around differences between POSIX and Windows.


 Documentation/git.txt |    6 +-
 Makefile              |   49 ++-
 cache.h               |    2 +-
 compat/fnmatch.c      |  488 +++++++++++++++++
 compat/fnmatch.h      |   84 +++
 compat/mingw.c        | 1008 +++++++++++++++++++++++++++++++++++
 compat/mingw.h        |  208 ++++++++
 compat/regex.c        | 4927 ++++++++++++++++++++(lots...)
 compat/regex.h        |  490 +++++++++++++++++
 compat/snprintf.c     |   19 +-
 connect.c             |    2 +-
 date.c                |    2 +-
 exec_cmd.c            |   41 ++-
 git-compat-util.h     |   31 +-
 git-sh-setup.sh       |   13 +
 git.c                 |   14 +
 help.c                |   33 +-
 pager.c               |   40 ++-
 path.c                |    7 +
 run-command.c         |  126 ++++-
 run-command.h         |    5 +
 setup.c               |   58 ++-
 sha1_file.c           |   14 +-
 templates/Makefile    |   11 +-
 transport.c           |    3 +-
 upload-pack.c         |    2 +
 write_or_die.c        |    7 +-
 27 files changed, 7617 insertions(+), 73 deletions(-)

Interdiff follows (it's line wrapped, just for exposition):

diff --git a/Makefile b/Makefile
index 4ff82c9..ad4b779 100644
--- a/Makefile
+++ b/Makefile
@@ -1301,7 +1301,7 @@ remove-dashes:
 ifeq ($(firstword $(subst /, ,$(template_dir))),..)
 template_instdir = $(gitexecdir)/$(template_dir)
 else
-template_instdir = $template_dir
+template_instdir = $(template_dir)
 endif
 export template_instdir

diff --git a/compat/mingw.c b/compat/mingw.c
index 7c8fd0e..ee26df9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -175,6 +175,33 @@ int mingw_fstat(int fd, struct mingw_stat *buf)
 	return -1;
 }

+static inline void time_t_to_filetime(time_t t, FILETIME *ft)
+{
+	long long winTime = t * 10000000LL + 116444736000000000LL;
+	ft->dwLowDateTime = winTime;
+	ft->dwHighDateTime = winTime >> 32;
+}
+
+int mingw_utime (const char *file_name, const struct utimbuf *times)
+{
+	FILETIME mft, aft;
+	int fh, rc;
+
+	/* must have write permission */
+	if ((fh = open(file_name, O_RDWR | O_BINARY)) < 0)
+		return -1;
+
+	time_t_to_filetime(times->modtime, &mft);
+	time_t_to_filetime(times->actime, &aft);
+	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
+		errno = EINVAL;
+		rc = -1;
+	} else
+		rc = 0;
+	close(fh);
+	return rc;
+}
+
 unsigned int sleep (unsigned int seconds)
 {
 	Sleep(seconds*1000);
@@ -353,7 +380,7 @@ static const char *quote_arg(const char *arg)
 	const char *p = arg;
 	if (!*p) force_quotes = 1;
 	while (*p) {
-		if (isspace(*p) || *p == '*' || *p == '?')
+		if (isspace(*p) || *p == '*' || *p == '?' || *p == '{')
 			force_quotes = 1;
 		else if (*p == '"')
 			n++;
diff --git a/compat/mingw.h b/compat/mingw.h
index c7db345..6965e3f 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -24,6 +24,8 @@ typedef int pid_t;
 #define SIGKILL 0
 #define SIGCHLD 0
 #define SIGPIPE 0
+#define SIGHUP 0
+#define SIGQUIT 0
 #define SIGALRM 100

 #define F_GETFD 1
@@ -174,6 +176,9 @@ int mingw_fstat(int fd, struct mingw_stat *buf);
 static inline int mingw_stat(const char *file_name, struct mingw_stat *buf)
 { return mingw_lstat(file_name, buf); }

+int mingw_utime(const char *file_name, const struct utimbuf *times);
+#define utime mingw_utime
+
 pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env);
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
diff --git a/compat/snprintf.c b/compat/snprintf.c
index 480b66f..580966e 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -13,9 +13,13 @@
 int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 {
 	char *s;
-	int ret;
+	int ret = -1;

-	ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+	if (maxsize > 0) {
+		ret = vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
+		/* Windows does not NUL-terminate if result fills buffer */
+		str[maxsize-1] = 0;
+	}
 	if (ret != -1)
 		return ret;

diff --git a/git-compat-util.h b/git-compat-util.h
index cdfd54d..46fc2d3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -66,12 +66,12 @@
 #include <fnmatch.h>
 #include <assert.h>
 #include <regex.h>
+#include <utime.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
-#include <utime.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
 #endif
@@ -185,7 +185,7 @@ extern ssize_t git_pread(int fd, void *buf, size_t
count, off_t offset);
  * This function is used in compat/pread.c.  But we can't include
  * cache.h there.
  */
-extern int read_in_full(int fd, void *buf, size_t count);
+extern ssize_t read_in_full(int fd, void *buf, size_t count);

 #ifdef NO_SETENV
 #define setenv gitsetenv
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 822aa6f..9cceb21 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -153,9 +153,5 @@ case $(uname -s) in
 	find () {
 		/usr/bin/find "$@"
 	}
-	# sync is missing
-	sync () {
-		:	# no implementation
-	}
 	;;
 esac
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 51d90a3..c861141 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -441,16 +441,3 @@ do
 		test_done
 	esac
 done
-
-# Fix some commands on Windows
-case $(uname -s) in
-*MINGW*)
-	# Windows has its own (incompatible) sort and find
-	sort () {
-		/usr/bin/sort "$@"
-	}
-	find () {
-		/usr/bin/find "$@"
-	}
-	;;
-esac
