From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 6/6] Dying in an async procedure should only exit the thread, not the process.
Date: Sat,  6 Mar 2010 16:40:43 +0100
Message-ID: <66dbacb267415a0e2d71c82467093245c06e84e5.1267889703.git.j6t@kdbg.org>
References: <cover.1267889703.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:27:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15u-0004YU-VP
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab0CFPmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:42:54 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47729 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751647Ab0CFPms (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:42:48 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0BB2610002;
	Sat,  6 Mar 2010 16:42:47 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3744E19F703;
	Sat,  6 Mar 2010 16:41:06 +0100 (CET)
X-Mailer: git-send-email 1.7.0.rc2.65.g7b13a
In-Reply-To: <cover.1267889703.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Async procedures are intended as helpers that perform a very restricted
task, and the caller usually has to manage them in a larger context.
Conceptually, the async procedure is not concerned with the "bigger
picture" in whose context it is run. When it dies, it is not supposed
to destroy this "bigger picture", but rather only its own limit view
of the world. On POSIX, the async procedure is run in its own process,
and exiting this process naturally had only these limited effects.

On Windows (or when ASYNC_AS_THREAD is set), calling die() exited the
whole process, destroying the caller (the "big picture") as well.
This fixes it to exit only the thread.

Without ASYNC_AS_THREAD, one particular effect of exiting the async
procedure process is that it automatically closes file descriptors, most
notably the writable end of the pipe that the async procedure writes to.

The async API already requires that the async procedure closes the pipe
ends when it exits normally. But for calls to die() no requirements are
imposed. In the non-threaded case the pipe ends are closed implicitly
by the exiting process, but in the threaded case, the die routine must
take care of closing them.

Now t5530-upload-pack-error.sh passes on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 run-command.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 77aefff..66cc4bf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -448,12 +448,35 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 }
 
 #ifdef ASYNC_AS_THREAD
+static pthread_t main_thread;
+static int main_thread_set;
+static pthread_key_t async_key;
+
 static void *run_thread(void *data)
 {
 	struct async *async = data;
+
+	pthread_setspecific(async_key, async);
+
 	intptr_t ret = async->proc(async->proc_in, async->proc_out, async->data);
 	return (void *)ret;
 }
+
+static NORETURN void die_async(const char *err, va_list params)
+{
+	vreportf("fatal: ", err, params);
+
+	if (!pthread_equal(main_thread, pthread_self())) {
+		struct async *async = pthread_getspecific(async_key);
+		if (async->proc_in >= 0)
+			close(async->proc_in);
+		if (async->proc_out >= 0)
+			close(async->proc_out);
+		pthread_exit((void *)128);
+	}
+
+	exit(128);
+}
 #endif
 
 int start_async(struct async *async)
@@ -525,6 +548,17 @@ int start_async(struct async *async)
 	else if (async->out)
 		close(async->out);
 #else
+	if (!main_thread_set) {
+		/*
+		 * We assume that the first time that start_async is called
+		 * it is from the main thread.
+		 */
+		main_thread_set = 1;
+		main_thread = pthread_self();
+		pthread_key_create(&async_key, NULL);
+		set_die_routine(die_async);
+	}
+
 	if (proc_in >= 0)
 		set_cloexec(proc_in);
 	if (proc_out >= 0)
-- 
1.7.0.rc2.65.g7b13a
