From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/2] mingw: rename WIN32 cpp macro to GIT_NATIVE_WINDOWS
Date: Sat, 27 Apr 2013 20:40:46 +0100
Message-ID: <517C29BE.6050002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB5o-0000tv-NJ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab3D0Tr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:28 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33185 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754750Ab3D0Tr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:27 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id EA1AE384081;
	Sat, 27 Apr 2013 20:47:26 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 81AC438407C;
	Sat, 27 Apr 2013 20:47:25 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:47:24 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222678>

From: Jonathan Nieder <jrnieder@gmail.com>

Throughout git, it is assumed that the WIN32 preprocessor symbol is
defined on native Windows setups (mingw and msvc) and not on Cygwin.
On Cygwin, most of the time git can pretend this is just another Unix
machine, and Windows-specific magic is generally counterproductive.

Unfortunately Cygwin *does* define the WIN32 symbol in some headers.
Best to rely on a new git-specific symbol GIT_NATIVE_WINDOWS instead,
defined as follows:

	#if defined(WIN32) && !defined(__CYGWIN__)
	# define GIT_NATIVE_WINDOWS
	#endif

After this change, it should be possible to drop the
CYGWIN_V15_WIN32API setting without any negative effect.

[rj: %s/NATIVE_WINDOWS/GIT_NATIVE_WINDOWS/g ]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 abspath.c         |  2 +-
 compat/terminal.c |  4 ++--
 compat/win32.h    |  2 +-
 diff-no-index.c   |  2 +-
 git-compat-util.h |  3 ++-
 help.c            |  2 +-
 run-command.c     | 10 +++++-----
 test-chmtime.c    |  2 +-
 thread-utils.c    |  2 +-
 9 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/abspath.c b/abspath.c
index 40cdc46..64adbe2 100644
--- a/abspath.c
+++ b/abspath.c
@@ -216,7 +216,7 @@ const char *absolute_path(const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
-#ifndef WIN32
+#ifndef GIT_WINDOWS_NATIVE
 	if (!pfx_len || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
diff --git a/compat/terminal.c b/compat/terminal.c
index 9b5e3d1..313897d 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -3,7 +3,7 @@
 #include "sigchain.h"
 #include "strbuf.h"
 
-#if defined(HAVE_DEV_TTY) || defined(WIN32)
+#if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
 
 static void restore_term(void);
 
@@ -53,7 +53,7 @@ error:
 	return -1;
 }
 
-#elif defined(WIN32)
+#elif defined(GIT_WINDOWS_NATIVE)
 
 #define INPUT_PATH "CONIN$"
 #define OUTPUT_PATH "CONOUT$"
diff --git a/compat/win32.h b/compat/win32.h
index 8ce9104..a97e880 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -2,7 +2,7 @@
 #define WIN32_H
 
 /* common Win32 functions for MinGW and Cygwin */
-#ifndef WIN32         /* Not defined by Cygwin */
+#ifndef GIT_WINDOWS_NATIVE	/* Not defined for Cygwin */
 #include <windows.h>
 #endif
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 74da659..e66fdf3 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -45,7 +45,7 @@ static int get_mode(const char *path, int *mode)
 
 	if (!path || !strcmp(path, "/dev/null"))
 		*mode = 0;
-#ifdef _WIN32
+#ifdef GIT_WINDOWS_NATIVE
 	else if (!strcasecmp(path, "nul"))
 		*mode = 0;
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index e955bb5..eeed506 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,13 +85,14 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
-#ifdef WIN32 /* Both MinGW and MSVC */
+#if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 # if defined (_MSC_VER)
 #  define _WIN32_WINNT 0x0502
 # endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
+#define GIT_WINDOWS_NATIVE
 #endif
 
 #include <unistd.h>
diff --git a/help.c b/help.c
index 02ba043..3d70d7a 100644
--- a/help.c
+++ b/help.c
@@ -106,7 +106,7 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#if defined(WIN32) || defined(__CYGWIN__)
+#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
 #if defined(__CYGWIN__)
 if ((st.st_mode & S_IXUSR) == 0)
 #endif
diff --git a/run-command.c b/run-command.c
index 1b32a12..aece872 100644
--- a/run-command.c
+++ b/run-command.c
@@ -72,7 +72,7 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
-#ifndef WIN32
+#ifndef GIT_WINDOWS_NATIVE
 static inline void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
@@ -159,7 +159,7 @@ static const char **prepare_shell_cmd(const char **argv)
 		die("BUG: shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
-#ifndef WIN32
+#ifndef GIT_WINDOWS_NATIVE
 		nargv[nargc++] = SHELL_PATH;
 #else
 		nargv[nargc++] = "sh";
@@ -182,7 +182,7 @@ static const char **prepare_shell_cmd(const char **argv)
 	return nargv;
 }
 
-#ifndef WIN32
+#ifndef GIT_WINDOWS_NATIVE
 static int execv_shell_cmd(const char **argv)
 {
 	const char **nargv = prepare_shell_cmd(argv);
@@ -193,7 +193,7 @@ static int execv_shell_cmd(const char **argv)
 }
 #endif
 
-#ifndef WIN32
+#ifndef GIT_WINDOWS_NATIVE
 static int child_err = 2;
 static int child_notifier = -1;
 
@@ -334,7 +334,7 @@ fail_pipe:
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 	fflush(NULL);
 
-#ifndef WIN32
+#ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
 	if (pipe(notify_pipe))
diff --git a/test-chmtime.c b/test-chmtime.c
index 02b42ba..1cffa12 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -87,7 +87,7 @@ int main(int argc, const char *argv[])
 			return -1;
 		}
 
-#ifdef WIN32
+#ifdef GIT_WINDOWS_NATIVE
 		if (!(sb.st_mode & S_IWUSR) &&
 				chmod(argv[i], sb.st_mode | S_IWUSR)) {
 			fprintf(stderr, "Could not make user-writable %s: %s",
diff --git a/thread-utils.c b/thread-utils.c
index 7f4b76a..97396a7 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -24,7 +24,7 @@ int online_cpus(void)
 	long ncpus;
 #endif
 
-#ifdef _WIN32
+#ifdef GIT_WINDOWS_NATIVE
 	SYSTEM_INFO info;
 	GetSystemInfo(&info);
 
-- 
1.8.2
