From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/4] win32: Improve the conditional inclusion of WIN32 API
 code
Date: Tue, 27 Oct 2009 19:15:18 +0000
Message-ID: <4AE746C6.9060409@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rrS-0003wp-6v
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 20:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbZJ0Thc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 15:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756730AbZJ0Thb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 15:37:31 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:49909 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756724AbZJ0Th3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 15:37:29 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1N2rrI-0002lQ-XW; Tue, 27 Oct 2009 19:37:33 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131377>


After experimenting with several win32 compilers, it is clear
that the _WIN32 macro should be used to guard the inclusion
of the main WIN32 API header files, particularly in the main
git-compat-util.h header. In addition, the cygwin build should
restrict the use of the WIN32 API to compat/cygwin.c

In order to avoid mistakes with the use of WIN32 and _WIN32
macros, define a new WIN32_API macro, with a single point of
definition in git-compat-util.h, to isolate WIN32 specific
code.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/cygwin.c   |    1 +
 compat/snprintf.c |    2 +-
 compat/win32.h    |    3 ---
 diff-no-index.c   |    2 +-
 git-compat-util.h |    9 +++++----
 help.c            |    2 +-
 pager.c           |    4 ++--
 run-command.c     |    8 ++++----
 run-command.h     |    2 +-
 setup.c           |    2 +-
 test-chmtime.c    |    2 +-
 thread-utils.c    |    2 +-
 12 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index b4a51b9..6695515 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,5 +1,6 @@
 #define WIN32_LEAN_AND_MEAN
 #include "../git-compat-util.h"
+#include <windows.h>
 #include "win32.h"
 #include "../cache.h" /* to read configuration */
 
diff --git a/compat/snprintf.c b/compat/snprintf.c
index e1e0e75..373692a 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -9,7 +9,7 @@
  * always have room for a trailing NUL byte.
  */
 #ifndef SNPRINTF_SIZE_CORR
-#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
+#if defined(WIN32_API) && (!defined(__GNUC__) || __GNUC__ < 4)
 #define SNPRINTF_SIZE_CORR 1
 #else
 #define SNPRINTF_SIZE_CORR 0
diff --git a/compat/win32.h b/compat/win32.h
index 8ce9104..a7ed72b 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -2,9 +2,6 @@
 #define WIN32_H
 
 /* common Win32 functions for MinGW and Cygwin */
-#ifndef WIN32         /* Not defined by Cygwin */
-#include <windows.h>
-#endif
 
 static inline int file_attr_to_st_mode (DWORD attr)
 {
diff --git a/diff-no-index.c b/diff-no-index.c
index 4ebc1db..fca8d5d 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -38,7 +38,7 @@ static int get_mode(const char *path, int *mode)
 
 	if (!path || !strcmp(path, "/dev/null"))
 		*mode = 0;
-#ifdef _WIN32
+#ifdef WIN32_API
 	else if (!strcasecmp(path, "nul"))
 		*mode = 0;
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index ef60803..5792f71 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -65,10 +65,11 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
-#ifdef WIN32 /* Both MinGW and MSVC */
-#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
-#include <winsock2.h>
-#include <windows.h>
+#if defined(_WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
+# define WIN32_API
+# define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
+# include <winsock2.h>
+# include <windows.h>
 #endif
 
 #include <unistd.h>
diff --git a/help.c b/help.c
index e8db31f..9fc9e69 100644
--- a/help.c
+++ b/help.c
@@ -126,7 +126,7 @@ static int is_executable(const char *name)
 	    !S_ISREG(st.st_mode))
 		return 0;
 
-#ifdef WIN32
+#ifdef WIN32_API
 {	/* cannot trust the executable bit, peek into the file instead */
 	char buf[3] = { 0 };
 	int n;
diff --git a/pager.c b/pager.c
index 86facec..d7aed0c 100644
--- a/pager.c
+++ b/pager.c
@@ -9,7 +9,7 @@
 
 static int spawned_pager;
 
-#ifndef WIN32
+#ifndef WIN32_API
 static void pager_preexec(void)
 {
 	/*
@@ -72,7 +72,7 @@ void setup_pager(void)
 		static const char *env[] = { "LESS=FRSX", NULL };
 		pager_process.env = env;
 	}
-#ifndef WIN32
+#ifndef WIN32_API
 	pager_process.preexec_cb = pager_preexec;
 #endif
 	if (start_command(&pager_process))
diff --git a/run-command.c b/run-command.c
index cf2d8f7..7872109 100644
--- a/run-command.c
+++ b/run-command.c
@@ -75,7 +75,7 @@ fail_pipe:
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
 
-#ifndef WIN32
+#ifndef WIN32_API
 	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
@@ -315,7 +315,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
-#ifdef WIN32
+#ifdef WIN32_API
 static unsigned __stdcall run_thread(void *data)
 {
 	struct async *async = data;
@@ -331,7 +331,7 @@ int start_async(struct async *async)
 		return error("cannot create pipe: %s", strerror(errno));
 	async->out = pipe_out[0];
 
-#ifndef WIN32
+#ifndef WIN32_API
 	/* Flush stdio before fork() to avoid cloning buffers */
 	fflush(NULL);
 
@@ -360,7 +360,7 @@ int start_async(struct async *async)
 
 int finish_async(struct async *async)
 {
-#ifndef WIN32
+#ifndef WIN32_API
 	int ret = wait_or_whine(async->pid, "child process", 0);
 #else
 	DWORD ret = 0;
diff --git a/run-command.h b/run-command.h
index fb34209..508568d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -70,7 +70,7 @@ struct async {
 	int (*proc)(int fd, void *data);
 	void *data;
 	int out;	/* caller reads from here and closes it */
-#ifndef WIN32
+#ifndef WIN32_API
 	pid_t pid;
 #else
 	HANDLE tid;
diff --git a/setup.c b/setup.c
index 029371e..08f8891 100644
--- a/setup.c
+++ b/setup.c
@@ -41,7 +41,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 {
 	static char path[PATH_MAX];
-#ifndef WIN32
+#ifndef WIN32_API
 	if (!pfx || !*pfx || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
diff --git a/test-chmtime.c b/test-chmtime.c
index fe476cb..a779f7f 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -87,7 +87,7 @@ int main(int argc, const char *argv[])
 			return -1;
 		}
 
-#ifdef WIN32
+#ifdef WIN32_API
 		if (!(sb.st_mode & S_IWUSR) &&
 				chmod(argv[i], sb.st_mode | S_IWUSR)) {
 			fprintf(stderr, "Could not make user-writable %s: %s",
diff --git a/thread-utils.c b/thread-utils.c
index 4f9c829..c99273e 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -23,7 +23,7 @@ int online_cpus(void)
 	long ncpus;
 #endif
 
-#ifdef _WIN32
+#ifdef WIN32_API
 	SYSTEM_INFO info;
 	GetSystemInfo(&info);
 
-- 
1.6.5
