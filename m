From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 22/40] Windows: Implement asynchronous functions as threads.
Date: Wed, 27 Feb 2008 19:54:45 +0100
Message-ID: <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVV-00022R-J6
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbYB0S4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755679AbYB0S4E
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:56:04 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40429 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbYB0SzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id E6AF6976F2;
	Wed, 27 Feb 2008 19:55:07 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75272>

In upload-pack we must explicitly close the output channel of rev-list.
(On Unix, the channel is closed automatically because process that runs
rev-list terminates.)

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 run-command.c |   29 ++++++++++++++++++++++++++++-
 run-command.h |    5 +++++
 upload-pack.c |    2 ++
 3 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 873f6d0..3834f86 100644
--- a/run-command.c
+++ b/run-command.c
@@ -276,13 +276,23 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	return run_command(&cmd);
 }
 
+#ifdef __MINGW32__
+static __stdcall unsigned run_thread(void *data)
+{
+	struct async *async = data;
+	return async->proc(async->fd_for_proc, async->data);
+}
+#endif
+
 int start_async(struct async *async)
 {
 	int pipe_out[2];
 
 	if (pipe(pipe_out) < 0)
 		return error("cannot create pipe: %s", strerror(errno));
+	async->out = pipe_out[0];
 
+#ifndef __MINGW32__
 	async->pid = fork();
 	if (async->pid < 0) {
 		error("fork (async) failed: %s", strerror(errno));
@@ -293,16 +303,33 @@ int start_async(struct async *async)
 		close(pipe_out[0]);
 		exit(!!async->proc(pipe_out[1], async->data));
 	}
-	async->out = pipe_out[0];
 	close(pipe_out[1]);
+#else
+	async->fd_for_proc = pipe_out[1];
+	async->tid = (HANDLE) _beginthreadex(NULL, 0, run_thread, async, 0, NULL);
+	if (!async->tid) {
+		error("cannot create thread: %s", strerror(errno));
+		close_pair(pipe_out);
+		return -1;
+	}
+#endif
 	return 0;
 }
 
 int finish_async(struct async *async)
 {
+#ifndef __MINGW32__
 	int ret = 0;
 
 	if (wait_or_whine(async->pid))
 		ret = error("waitpid (async) failed");
+#else
+	DWORD ret = 0;
+	if (WaitForSingleObject(async->tid, INFINITE) != WAIT_OBJECT_0)
+		ret = error("waiting for thread failed: %lu", GetLastError());
+	else if (!GetExitCodeThread(async->tid, &ret))
+		ret = error("cannot get thread exit code: %lu", GetLastError());
+	CloseHandle(async->tid);
+#endif
 	return ret;
 }
diff --git a/run-command.h b/run-command.h
index 1fc781d..0bbac86 100644
--- a/run-command.h
+++ b/run-command.h
@@ -60,7 +60,12 @@ struct async {
 	int (*proc)(int fd, void *data);
 	void *data;
 	int out;	/* caller reads from here and closes it */
+#ifndef __MINGW32__
 	pid_t pid;
+#else
+	HANDLE tid;
+	int fd_for_proc;
+#endif
 };
 
 int start_async(struct async *async);
diff --git a/upload-pack.c b/upload-pack.c
index b26d053..3c99c8d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -133,6 +133,8 @@ static int do_rev_list(int fd, void *create_full_pack)
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object);
+	fflush(pack_pipe);
+	fclose(pack_pipe);
 	return 0;
 }
 
-- 
1.5.4.1.126.ge5a7d
