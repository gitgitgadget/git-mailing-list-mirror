From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 5/6] Reimplement async procedures using pthreads
Date: Sat,  6 Mar 2010 16:40:42 +0100
Message-ID: <771cabb3efea5ced5049bdd34c392a218d1f3c4f.1267889703.git.j6t@kdbg.org>
References: <cover.1267889703.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15v-0004YU-Hm
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab0CFPnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:43:00 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47707 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751561Ab0CFPmp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:42:45 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 99176A7F06;
	Sat,  6 Mar 2010 16:42:44 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CEAE119F703;
	Sat,  6 Mar 2010 16:41:03 +0100 (CET)
X-Mailer: git-send-email 1.7.0.rc2.65.g7b13a
In-Reply-To: <cover.1267889703.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, async procedures have always been run in threads, and the
implementation used Windows specific APIs. Rewrite the code to use pthreads.

A new configuration option is introduced so that the threaded implementation
can also be used on POSIX systems. Since this option is intended only as
playground on POSIX, but is mandatory on Windows, the option is not
documented.

One detail is that on POSIX it is necessary to set FD_CLOEXEC on the pipe
handles. On Windows, this is not needed because pipe handles are not
inherited to child processes, and the new calls to set_cloexec() are
effectively no-ops.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile      |    5 +++++
 run-command.c |   41 +++++++++++++++++++++++------------------
 run-command.h |    8 ++++++--
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index afedb54..c5f0f9b 100644
--- a/Makefile
+++ b/Makefile
@@ -949,6 +949,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	ASYNC_AS_THREAD = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -1000,6 +1001,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	ASYNC_AS_THREAD = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
@@ -1301,6 +1303,9 @@ ifdef NO_PTHREADS
 else
 	EXTLIBS += $(PTHREAD_LIBS)
 	LIB_OBJS += thread-utils.o
+ifdef ASYNC_AS_THREAD
+	BASIC_CFLAGS += -DASYNC_AS_THREAD
+endif
 endif
 
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
diff --git a/run-command.c b/run-command.c
index 0cd7f02..77aefff 100644
--- a/run-command.c
+++ b/run-command.c
@@ -82,6 +82,7 @@ static NORETURN void die_child(const char *err, va_list params)
 	write(child_err, "\n", 1);
 	exit(128);
 }
+#endif
 
 static inline void set_cloexec(int fd)
 {
@@ -89,7 +90,6 @@ static inline void set_cloexec(int fd)
 	if (flags >= 0)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
-#endif
 
 static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 {
@@ -447,11 +447,12 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
-#ifdef WIN32
-static unsigned __stdcall run_thread(void *data)
+#ifdef ASYNC_AS_THREAD
+static void *run_thread(void *data)
 {
 	struct async *async = data;
-	return async->proc(async->proc_in, async->proc_out, async->data);
+	intptr_t ret = async->proc(async->proc_in, async->proc_out, async->data);
+	return (void *)ret;
 }
 #endif
 
@@ -497,7 +498,7 @@ int start_async(struct async *async)
 	else
 		proc_out = -1;
 
-#ifndef WIN32
+#ifndef ASYNC_AS_THREAD
 	/* Flush stdio before fork() to avoid cloning buffers */
 	fflush(NULL);
 
@@ -524,12 +525,18 @@ int start_async(struct async *async)
 	else if (async->out)
 		close(async->out);
 #else
+	if (proc_in >= 0)
+		set_cloexec(proc_in);
+	if (proc_out >= 0)
+		set_cloexec(proc_out);
 	async->proc_in = proc_in;
 	async->proc_out = proc_out;
-	async->tid = (HANDLE) _beginthreadex(NULL, 0, run_thread, async, 0, NULL);
-	if (!async->tid) {
-		error("cannot create thread: %s", strerror(errno));
-		goto error;
+	{
+		int err = pthread_create(&async->tid, NULL, run_thread, async);
+		if (err) {
+			error("cannot create thread: %s", strerror(err));
+			goto error;
+		}
 	}
 #endif
 	return 0;
@@ -549,17 +556,15 @@ error:
 
 int finish_async(struct async *async)
 {
-#ifndef WIN32
-	int ret = wait_or_whine(async->pid, "child process", 0);
+#ifndef ASYNC_AS_THREAD
+	return wait_or_whine(async->pid, "child process", 0);
 #else
-	DWORD ret = 0;
-	if (WaitForSingleObject(async->tid, INFINITE) != WAIT_OBJECT_0)
-		ret = error("waiting for thread failed: %lu", GetLastError());
-	else if (!GetExitCodeThread(async->tid, &ret))
-		ret = error("cannot get thread exit code: %lu", GetLastError());
-	CloseHandle(async->tid);
+	void *ret = (void *)(intptr_t)(-1);
+
+	if (pthread_join(async->tid, &ret))
+		error("pthread_join failed");
+	return (int)(intptr_t)ret;
 #endif
-	return ret;
 }
 
 int run_hook(const char *index_file, const char *name, ...)
diff --git a/run-command.h b/run-command.h
index 94619f5..40db39c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -1,6 +1,10 @@
 #ifndef RUN_COMMAND_H
 #define RUN_COMMAND_H
 
+#ifdef ASYNC_AS_THREAD
+#include <pthread.h>
+#endif
+
 struct child_process {
 	const char **argv;
 	pid_t pid;
@@ -74,10 +78,10 @@ struct async {
 	void *data;
 	int in;		/* caller writes here and closes it */
 	int out;	/* caller reads from here and closes it */
-#ifndef WIN32
+#ifndef ASYNC_AS_THREAD
 	pid_t pid;
 #else
-	HANDLE tid;
+	pthread_t tid;
 	int proc_in;
 	int proc_out;
 #endif
-- 
1.7.0.rc2.65.g7b13a
