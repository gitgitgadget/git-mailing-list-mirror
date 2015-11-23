From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] run-command: detect finished children by closed pipe rather than waitpid
Date: Mon, 23 Nov 2015 13:43:48 -0800
Message-ID: <1448315028-14711-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, j6t@kdbg.org, tboegi@web.de,
	Stefan Beller <sbeller@google.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Mon Nov 23 22:44:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0yu2-00036z-G9
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 22:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbbKWVny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 16:43:54 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35202 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbKWVnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 16:43:53 -0500
Received: by pacej9 with SMTP id ej9so203233150pac.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 13:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=igFsHoye+HIlzu5PTVylAUGkGt1L73U9poT1+DoCYoU=;
        b=YfgApp+58rVnnV9pffsbnmX6OVTISHw0UMAF/IWyyYft87nW34wPw9TKfzKmNWtKMZ
         idiFXcJmZGhyFBfuBzHlwYtpN3efd7M+M/7MCG+NhcLmn5OfBnXNoHAlXIU42bzPNRpF
         Mx3+UtkYQjzQTVMpFveo+MUC6ficp2j+QdpxOPyctaStFO2cHdrO6vUmm5R+WPhvkMTp
         lnWTPpKzrIeX14KTyXazBY6AWIDo1b6jHlJpFAzH9eLQPL1O41JDfpJFF0AMQE+ws/ER
         kgKy3vw6lXDSS4Nu7FZbvv+J9neplk8OncNLW/TFBXyhNv7amOiczFA9HDbRyLR/ksQj
         oz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=igFsHoye+HIlzu5PTVylAUGkGt1L73U9poT1+DoCYoU=;
        b=mMsdxFQrMX+Lz3Tzunhs0LSwpxnpu7+q48karQsg5xCpmPu4ooetUqu4kECsd7g9C9
         as6M8nq0WtRuJttnHI+2dkI5BTYNuk7ubm/ezBJ3Nb+AvMqf9PAdhTAGr4GUW/XAZ3Qk
         E2LkE+Yqw/MXbipwbtTxcvgIEpOXJZWTvWNhLhirhZ/xcytCOtnQjCH4vqywD/x7vogl
         uzNoaSwx9ao7jzYGByxEChWjJ5az1dY/KVHRW5HheUVgcF1WU3z2V8/216zHe7UIaEAe
         G/5xygXyiPZd6COwJMw4lq9wDl8Lp75uZTQDyvvHcvCNyBRqHguA/UJB/Ke/sKYvj2uM
         q9Lg==
X-Gm-Message-State: ALoCoQnGCN1dQTXXUpU8NVPGbShXCWw+tuWN2iJc1RBr0ZmbAvdQwgbLSxzxt7vzifWRjG88PnmM
X-Received: by 10.68.69.73 with SMTP id c9mr32090421pbu.165.1448315033011;
        Mon, 23 Nov 2015 13:43:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8860:d1df:1f08:181e])
        by smtp.gmail.com with ESMTPSA id d6sm11150148pfj.82.2015.11.23.13.43.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Nov 2015 13:43:51 -0800 (PST)
X-Mailer: git-send-email 2.6.1.258.gaca1825.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281601>

Detect if a child stopped working by checking if their stderr pipe
was closed instead of checking their state with waitpid. This resembles
the way we work with child processes in the non-parallel case.

Having a better consistency between the different methods to run
child processes, is the main advantage, though there are more:
* Previously we leaked the open read pipe of finished children.
* waitpid(-1, ...) is not implemented in Windows, this is an approach
  which allows for better cross platform operation.
* less lines of code.

The old way missed some messages on an early abort. We just killed the
children and did not bother to look what was left over. With this approach
we'd send a signal to the children and wait for them to close the pipe to
have all the messages (including possible "killed by signal 15" messages).

To have the test suite passing as before, we allow for real graceful
abortion now. In case the user wishes to abort parallel execution
the user needs to provide either the signal used to kill all children
or the children are let run until they finish normally.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 
 * applies on top of submodule-parallel-fetch
 * updated the commit message to address Jonathans concerns, using the
   words of Johannes.
 * did not rename code to anything else, as I do not see the need for it.
 
 run-command.c      | 141 +++++++++++++++++++++++------------------------------
 run-command.h      |  12 +++--
 submodule.c        |   3 --
 test-run-command.c |   3 --
 4 files changed, 69 insertions(+), 90 deletions(-)
 
 

diff --git a/run-command.c b/run-command.c
index 07424e9..db4d916 100644
--- a/run-command.c
+++ b/run-command.c
@@ -858,6 +858,12 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	return finish_command(cmd);
 }
 
+enum child_state {
+	GIT_CP_FREE,
+	GIT_CP_WORKING,
+	GIT_CP_WAIT_CLEANUP,
+};
+
 static struct parallel_processes {
 	void *data;
 
@@ -869,7 +875,7 @@ static struct parallel_processes {
 	task_finished_fn task_finished;
 
 	struct {
-		unsigned in_use : 1;
+		enum child_state state;
 		struct child_process process;
 		struct strbuf err;
 		void *data;
@@ -923,7 +929,7 @@ static void kill_children(struct parallel_processes *pp, int signo)
 	int i, n = pp->max_processes;
 
 	for (i = 0; i < n; i++)
-		if (pp->children[i].in_use)
+		if (pp->children[i].state == GIT_CP_WORKING)
 			kill(pp->children[i].process.pid, signo);
 }
 
@@ -967,7 +973,7 @@ static struct parallel_processes *pp_init(int n,
 	for (i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
 		child_process_init(&pp->children[i].process);
-		pp->pfd[i].events = POLLIN;
+		pp->pfd[i].events = POLLIN | POLLHUP;
 		pp->pfd[i].fd = -1;
 	}
 	sigchain_push_common(handle_children_on_signal);
@@ -1000,39 +1006,46 @@ static void pp_cleanup(struct parallel_processes *pp)
  *  0 if a new task was started.
  *  1 if no new jobs was started (get_next_task ran out of work, non critical
  *    problem with starting a new command)
- * -1 no new job was started, user wishes to shutdown early.
+ * <0 no new job was started, user wishes to shutdown early. Use negative code
+ *    to signal the children.
  */
 static int pp_start_one(struct parallel_processes *pp)
 {
-	int i;
+	int i, code;
 
 	for (i = 0; i < pp->max_processes; i++)
-		if (!pp->children[i].in_use)
+		if (pp->children[i].state == GIT_CP_FREE)
 			break;
 	if (i == pp->max_processes)
 		die("BUG: bookkeeping is hard");
 
-	if (!pp->get_next_task(&pp->children[i].data,
-			       &pp->children[i].process,
-			       &pp->children[i].err,
-			       pp->data)) {
+	code = pp->get_next_task(&pp->children[i].data,
+				 &pp->children[i].process,
+				 &pp->children[i].err,
+				 pp->data);
+	if (!code) {
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 		strbuf_reset(&pp->children[i].err);
 		return 1;
 	}
+	pp->children[i].process.err = -1;
+	pp->children[i].process.stdout_to_stderr = 1;
+	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
-		int code = pp->start_failure(&pp->children[i].process,
-					     &pp->children[i].err,
-					     pp->data,
-					     &pp->children[i].data);
+		code = pp->start_failure(&pp->children[i].process,
+					 &pp->children[i].err,
+					 pp->data,
+					 &pp->children[i].data);
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 		strbuf_reset(&pp->children[i].err);
-		return code ? -1 : 1;
+		if (code)
+			pp->shutdown = 1;
+		return code;
 	}
 
 	pp->nr_processes++;
-	pp->children[i].in_use = 1;
+	pp->children[i].state = GIT_CP_WORKING;
 	pp->pfd[i].fd = pp->children[i].process.err;
 	return 0;
 }
@@ -1050,19 +1063,24 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 
 	/* Buffer output from all pipes. */
 	for (i = 0; i < pp->max_processes; i++) {
-		if (pp->children[i].in_use &&
-		    pp->pfd[i].revents & POLLIN)
-			if (strbuf_read_once(&pp->children[i].err,
-					     pp->children[i].process.err, 0) < 0)
+		if (pp->children[i].state == GIT_CP_WORKING &&
+		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
+			int n = strbuf_read_once(&pp->children[i].err,
+						 pp->children[i].process.err, 0);
+			if (n == 0) {
+				close(pp->children[i].process.err);
+				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
+			} else if (n < 0)
 				if (errno != EAGAIN)
 					die_errno("read");
+		}
 	}
 }
 
 static void pp_output(struct parallel_processes *pp)
 {
 	int i = pp->output_owner;
-	if (pp->children[i].in_use &&
+	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
 		fputs(pp->children[i].err.buf, stderr);
 		strbuf_reset(&pp->children[i].err);
@@ -1071,70 +1089,31 @@ static void pp_output(struct parallel_processes *pp)
 
 static int pp_collect_finished(struct parallel_processes *pp)
 {
-	int i = 0;
-	pid_t pid;
-	int wait_status, code;
+	int i, code;
 	int n = pp->max_processes;
 	int result = 0;
 
 	while (pp->nr_processes > 0) {
-		pid = waitpid(-1, &wait_status, WNOHANG);
-		if (pid == 0)
-			break;
-
-		if (pid < 0)
-			die_errno("wait");
-
 		for (i = 0; i < pp->max_processes; i++)
-			if (pp->children[i].in_use &&
-			    pid == pp->children[i].process.pid)
+			if (pp->children[i].state == GIT_CP_WAIT_CLEANUP)
 				break;
 		if (i == pp->max_processes)
-			die("BUG: found a child process we were not aware of");
-
-		if (strbuf_read(&pp->children[i].err,
-				pp->children[i].process.err, 0) < 0)
-			die_errno("strbuf_read");
-
-		if (WIFSIGNALED(wait_status)) {
-			code = WTERMSIG(wait_status);
-			if (!pp->shutdown &&
-			    code != SIGINT && code != SIGQUIT)
-				strbuf_addf(&pp->children[i].err,
-					    "%s died of signal %d",
-					    pp->children[i].process.argv[0],
-					    code);
-			/*
-			 * This return value is chosen so that code & 0xff
-			 * mimics the exit code that a POSIX shell would report for
-			 * a program that died from this signal.
-			 */
-			code += 128;
-		} else if (WIFEXITED(wait_status)) {
-			code = WEXITSTATUS(wait_status);
-			/*
-			 * Convert special exit code when execvp failed.
-			 */
-			if (code == 127) {
-				code = -1;
-				errno = ENOENT;
-			}
-		} else {
-			strbuf_addf(&pp->children[i].err,
-				    "waitpid is confused (%s)",
-				    pp->children[i].process.argv[0]);
-			code = -1;
-		}
+			break;
+
+		code = finish_command(&pp->children[i].process);
+
+		code = pp->task_finished(code, &pp->children[i].process,
+					 &pp->children[i].err, pp->data,
+					 &pp->children[i].data);
 
-		if (pp->task_finished(code, &pp->children[i].process,
-				      &pp->children[i].err, pp->data,
-				      &pp->children[i].data))
-			result = 1;
+		if (code)
+			result = code;
+		if (code < 0)
+			break;
 
 		pp->nr_processes--;
-		pp->children[i].in_use = 0;
+		pp->children[i].state = GIT_CP_FREE;
 		pp->pfd[i].fd = -1;
-		child_process_deinit(&pp->children[i].process);
 		child_process_init(&pp->children[i].process);
 
 		if (i != pp->output_owner) {
@@ -1157,7 +1136,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 			 * running process time.
 			 */
 			for (i = 0; i < n; i++)
-				if (pp->children[(pp->output_owner + i) % n].in_use)
+				if (pp->children[(pp->output_owner + i) % n].state == GIT_CP_WORKING)
 					break;
 			pp->output_owner = (pp->output_owner + i) % n;
 		}
@@ -1171,7 +1150,7 @@ int run_processes_parallel(int n,
 			   task_finished_fn task_finished,
 			   void *pp_cb)
 {
-	int i;
+	int i, code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	struct parallel_processes *pp;
@@ -1182,12 +1161,12 @@ int run_processes_parallel(int n,
 		    i < spawn_cap && !pp->shutdown &&
 		    pp->nr_processes < pp->max_processes;
 		    i++) {
-			int code = pp_start_one(pp);
+			code = pp_start_one(pp);
 			if (!code)
 				continue;
 			if (code < 0) {
 				pp->shutdown = 1;
-				kill_children(pp, SIGTERM);
+				kill_children(pp, -code);
 			}
 			break;
 		}
@@ -1195,9 +1174,11 @@ int run_processes_parallel(int n,
 			break;
 		pp_buffer_stderr(pp, output_timeout);
 		pp_output(pp);
-		if (pp_collect_finished(pp)) {
-			kill_children(pp, SIGTERM);
+		code = pp_collect_finished(pp);
+		if (code) {
 			pp->shutdown = 1;
+			if (code < 0)
+				kill_children(pp, -code);
 		}
 	}
 
diff --git a/run-command.h b/run-command.h
index c24aa54..414cc81 100644
--- a/run-command.h
+++ b/run-command.h
@@ -134,6 +134,8 @@ int finish_async(struct async *async);
  *
  * Return 1 if the next child is ready to run.
  * Return 0 if there are currently no more tasks to be processed.
+ * To send a signal to other child processes for abortion,
+ * return negative signal code.
  */
 typedef int (*get_next_task_fn)(void **pp_task_cb,
 				struct child_process *cp,
@@ -151,8 +153,9 @@ typedef int (*get_next_task_fn)(void **pp_task_cb,
  * pp_cb is the callback cookie as passed into run_processes_parallel,
  * pp_task_cb is the callback cookie as passed into get_next_task_fn.
  *
- * Return 0 to continue the parallel processing. To abort gracefully,
- * return non zero.
+ * Return 0 to continue the parallel processing. To abort return non zero.
+ * To send a signal to other child processes for abortion, return
+ * negative signal code.
  */
 typedef int (*start_failure_fn)(struct child_process *cp,
 				struct strbuf *err,
@@ -169,8 +172,9 @@ typedef int (*start_failure_fn)(struct child_process *cp,
  * pp_cb is the callback cookie as passed into run_processes_parallel,
  * pp_task_cb is the callback cookie as passed into get_next_task_fn.
  *
- * Return 0 to continue the parallel processing. To abort gracefully,
- * return non zero.
+ * Return 0 to continue the parallel processing.  To abort return non zero.
+ * To send a signal to other child processes for abortion, return
+ * negative signal code.
  */
 typedef int (*task_finished_fn)(int result,
 				struct child_process *cp,
diff --git a/submodule.c b/submodule.c
index c21b265..281bccd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -689,9 +689,6 @@ static int get_next_submodule(void **task_cb, struct child_process *cp,
 			cp->dir = strbuf_detach(&submodule_path, NULL);
 			cp->env = local_repo_env;
 			cp->git_cmd = 1;
-			cp->no_stdin = 1;
-			cp->stdout_to_stderr = 1;
-			cp->err = -1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
 					    spf->prefix, ce->name);
diff --git a/test-run-command.c b/test-run-command.c
index 13e5d44..b1f04d1 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -26,9 +26,6 @@ static int parallel_next(void** task_cb,
 		return 0;
 
 	argv_array_pushv(&cp->args, d->argv);
-	cp->stdout_to_stderr = 1;
-	cp->no_stdin = 1;
-	cp->err = -1;
 	strbuf_addf(err, "preloaded output of a child\n");
 	number_callbacks++;
 	return 1;
-- 
2.6.1.258.gaca1825.dirty
