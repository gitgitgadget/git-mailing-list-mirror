From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 6/8] run-command: add an asynchronous parallel child processor
Date: Mon, 12 Oct 2015 11:47:19 -0700
Message-ID: <1444675641-14866-7-git-send-email-sbeller@google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8Y-0006Ox-0z
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbbJLSrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:47:46 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33741 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbbJLSre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:34 -0400
Received: by pabrc13 with SMTP id rc13so25737249pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4qaqX5Ye/6xXy/U5jMXPxMWtr5aX+DGYIEjh0GN2Ejs=;
        b=V7AyVlyQUR4i+56+y5F/LUK69ScjKBEbwj48yHM5EmFKTEq/E+Fo4dlxycMWggXrbJ
         /Jj+725IIuzpYT++qTqXt/JfP+1fX/rbK3C+tW7aXPp1nxwdwz+Bx6+qG2priT9aFSvE
         SixK5JVDdudjOevvx8vONTybIdT9UK9RGakToUpqVQU8Le0EL8Q9dsjdxPdbEXxwEM5g
         juZdVU74VDDeYJ/3yCHI8pcDY5k68z/8PMfEJW7LYldUqR3XT+S0eAOxuJoz7D7M34au
         hwJwR07SY2w2foJnLQvlDjjiHgHU8SzeWqQgYSCCmPPp8gckOHcDiIYQ+SGq83nGzjX9
         ZnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4qaqX5Ye/6xXy/U5jMXPxMWtr5aX+DGYIEjh0GN2Ejs=;
        b=ZQwc1kl0870yQQ1ZNZ0D85Nu0UXBCg2pcUOqGF6ySFCsASfGl4LIP2x+N1azumNDOj
         Ywva2BkOMO+UGyeja0eRj09htkroO52beuC3//Rf2WgNCt+N4pUY/x2mJFBofeaXEhA+
         5izKQQvcvpl0KIGDjQvOPfMLKswi+QlmY+OzgNm4/Pis16dAmyezyqC+Wx4u0CW2rUDU
         xcipoRdbsg0q9vl/eMUH7dAcT/yWc5YunYswo3zS1zuF4UNzwRwF4FFSLil+nWF68B4I
         y5TAWpknNZKhJhZ4tN3I1NFd84UhnbDLU1usWwyR/3iq+/bQMCRbZ+Rgr6+qtqbbmpJ5
         zPqA==
X-Gm-Message-State: ALoCoQlRFUI7SGRnrY3cYkTZYOKGFJHNTayBmg3JzMnwiGb1n5p0K1tbBS4or73vtzcUhS52DA+7
X-Received: by 10.68.222.163 with SMTP id qn3mr36385468pbc.54.1444675653432;
        Mon, 12 Oct 2015 11:47:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id tz1sm19666633pbc.50.2015.10.12.11.47.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279400>

This allows to run external commands in parallel with ordered output
on stderr.

If we run external commands in parallel we cannot pipe the output directly
to the our stdout/err as it would mix up. So each process's output will
flow through a pipe, which we buffer. One subprocess can be directly
piped to out stdout/err for a low latency feedback to the user.

Example:
Let's assume we have 5 submodules A,B,C,D,E and each fetch takes a
different amount of time as the different submodules vary in size, then
the output of fetches in sequential order might look like this:

 time -->
 output: |---A---| |-B-| |-------C-------| |-D-| |-E-|

When we schedule these submodules into maximal two parallel processes,
a schedule and sample output over time may look like this:

process 1: |---A---| |-D-| |-E-|

process 2: |-B-| |-------C-------|

output:    |---A---|B|---C-------|DE

So A will be perceived as it would run normally in the single child
version. As B has finished by the time A is done, we can dump its whole
progress buffer on stderr, such that it looks like it finished in no
time. Once that is done, C is determined to be the visible child and
its progress will be reported in real time.

So this way of output is really good for human consumption, as it only
changes the timing, not the actual output.

For machine consumption the output needs to be prepared in the tasks,
by either having a prefix per line or per block to indicate whose tasks
output is displayed, because the output order may not follow the
original sequential ordering:

 |----A----| |--B--| |-C-|

will be scheduled to be all parallel:

process 1: |----A----|
process 2: |--B--|
process 3: |-C-|
output:    |----A----|CB

This happens because C finished before B did, so it will be queued for
output before B.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c          | 350 +++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h          |  78 +++++++++++
 t/t0061-run-command.sh |  20 +++
 test-run-command.c     |  25 ++++
 4 files changed, 473 insertions(+)

diff --git a/run-command.c b/run-command.c
index 28e1d55..ef3da27 100644
--- a/run-command.c
+++ b/run-command.c
@@ -3,6 +3,8 @@
 #include "exec_cmd.h"
 #include "sigchain.h"
 #include "argv-array.h"
+#include "thread-utils.h"
+#include "strbuf.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -852,3 +854,351 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	close(cmd->out);
 	return finish_command(cmd);
 }
+
+static struct parallel_processes {
+	void *data;
+
+	int max_processes;
+	int nr_processes;
+
+	get_next_task_fn get_next_task;
+	start_failure_fn start_failure;
+	task_finished_fn task_finished;
+
+	struct {
+		unsigned in_use : 1;
+		struct child_process process;
+		struct strbuf err;
+		void *data;
+	} *children;
+	/*
+	 * The struct pollfd is logically part of *children,
+	 * but the system call expects it as its own array.
+	 */
+	struct pollfd *pfd;
+
+	unsigned shutdown : 1;
+
+	int output_owner;
+	struct strbuf buffered_output; /* of finished children */
+} parallel_processes_struct;
+
+static int default_start_failure(struct child_process *cp,
+				 struct strbuf *err,
+				 void *pp_cb,
+				 void *pp_task_cb)
+{
+	int i;
+
+	strbuf_addstr(err, "Starting a child failed:");
+	for (i = 0; cp->argv[i]; i++)
+		strbuf_addf(err, " %s", cp->argv[i]);
+
+	return 0;
+}
+
+static int default_task_finished(int result,
+				 struct child_process *cp,
+				 struct strbuf *err,
+				 void *pp_cb,
+				 void *pp_task_cb)
+{
+	int i;
+
+	if (!result)
+		return 0;
+
+	strbuf_addf(err, "A child failed with return code %d:", result);
+	for (i = 0; cp->argv[i]; i++)
+		strbuf_addf(err, " %s", cp->argv[i]);
+
+	return 0;
+}
+
+static void kill_children(struct parallel_processes *pp, int signo)
+{
+	int i, n = pp->max_processes;
+
+	for (i = 0; i < n; i++)
+		if (pp->children[i].in_use)
+			kill(pp->children[i].process.pid, signo);
+}
+
+static void handle_children_on_signal(int signo)
+{
+	struct parallel_processes *pp = &parallel_processes_struct;
+
+	kill_children(pp, signo);
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+static struct parallel_processes *pp_init(int n,
+					  get_next_task_fn get_next_task,
+					  start_failure_fn start_failure,
+					  task_finished_fn task_finished,
+					  void *data)
+{
+	int i;
+	struct parallel_processes *pp = &parallel_processes_struct;
+
+	if (n < 1)
+		n = online_cpus();
+
+	pp->max_processes = n;
+	pp->data = data;
+	if (!get_next_task)
+		die("BUG: you need to specify a get_next_task function");
+	pp->get_next_task = get_next_task;
+
+	pp->start_failure = start_failure ? start_failure : default_start_failure;
+	pp->task_finished = task_finished ? task_finished : default_task_finished;
+
+	pp->nr_processes = 0;
+	pp->output_owner = 0;
+	pp->children = xcalloc(n, sizeof(*pp->children));
+	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
+	strbuf_init(&pp->buffered_output, 0);
+
+	for (i = 0; i < n; i++) {
+		strbuf_init(&pp->children[i].err, 0);
+		pp->pfd[i].events = POLLIN;
+		pp->pfd[i].fd = -1;
+	}
+	sigchain_push_common(handle_children_on_signal);
+	return pp;
+}
+
+static void pp_cleanup(struct parallel_processes *pp)
+{
+	int i;
+
+	for (i = 0; i < pp->max_processes; i++)
+		strbuf_release(&pp->children[i].err);
+
+	free(pp->children);
+	free(pp->pfd);
+	strbuf_release(&pp->buffered_output);
+
+	sigchain_pop_common();
+}
+
+static void set_nonblocking(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+	if (flags < 0)
+		warning("Could not get file status flags, "
+			"output will be degraded");
+	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
+		warning("Could not set file status flags, "
+			"output will be degraded");
+}
+
+/* returns
+ *  0 if a new task was started.
+ *  1 if no new jobs was started (get_next_task ran out of work, non critical
+ *    problem with starting a new command)
+ * -1 no new job was started, user wishes to shutdown early.
+ */
+static int pp_start_one(struct parallel_processes *pp)
+{
+	int i;
+
+	for (i = 0; i < pp->max_processes; i++)
+		if (!pp->children[i].in_use)
+			break;
+	if (i == pp->max_processes)
+		die("BUG: bookkeeping is hard");
+
+	if (!pp->get_next_task(&pp->children[i].data,
+			       &pp->children[i].process,
+			       &pp->children[i].err,
+			       pp->data))
+		return 1;
+
+	if (start_command(&pp->children[i].process)) {
+		int code = pp->start_failure(&pp->children[i].process,
+					     &pp->children[i].err,
+					     pp->data,
+					     &pp->children[i].data);
+		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+		strbuf_reset(&pp->children[i].err);
+		return code ? -1 : 1;
+	}
+
+	set_nonblocking(pp->children[i].process.err);
+
+	pp->nr_processes++;
+	pp->children[i].in_use = 1;
+	pp->pfd[i].fd = pp->children[i].process.err;
+	return 0;
+}
+
+static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
+{
+	int i;
+
+	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
+		if (errno == EINTR)
+			continue;
+		pp_cleanup(pp);
+		die_errno("poll");
+	}
+
+	/* Buffer output from all pipes. */
+	for (i = 0; i < pp->max_processes; i++) {
+		if (pp->children[i].in_use &&
+		    pp->pfd[i].revents & POLLIN)
+			if (strbuf_read_once(&pp->children[i].err,
+					     pp->children[i].process.err, 0) < 0)
+				if (errno != EAGAIN)
+					die_errno("read");
+	}
+}
+
+static void pp_output(struct parallel_processes *pp)
+{
+	int i = pp->output_owner;
+	if (pp->children[i].in_use &&
+	    pp->children[i].err.len) {
+		fputs(pp->children[i].err.buf, stderr);
+		strbuf_reset(&pp->children[i].err);
+	}
+}
+
+static int pp_collect_finished(struct parallel_processes *pp)
+{
+	int i = 0;
+	pid_t pid;
+	int wait_status, code;
+	int n = pp->max_processes;
+	int result = 0;
+
+	while (pp->nr_processes > 0) {
+		pid = waitpid(-1, &wait_status, WNOHANG);
+		if (pid == 0)
+			return 0;
+
+		if (pid < 0)
+			die_errno("wait");
+
+		for (i = 0; i < pp->max_processes; i++)
+			if (pp->children[i].in_use &&
+			    pid == pp->children[i].process.pid)
+				break;
+		if (i == pp->max_processes)
+			die("BUG: found a child process we were not aware of");
+
+		if (strbuf_read(&pp->children[i].err,
+				pp->children[i].process.err, 0) < 0)
+			die_errno("strbuf_read");
+
+		if (WIFSIGNALED(wait_status)) {
+			code = WTERMSIG(wait_status);
+			if (!pp->shutdown &&
+			    code != SIGINT && code != SIGQUIT)
+				strbuf_addf(&pp->children[i].err,
+					    "%s died of signal %d",
+					    pp->children[i].process.argv[0],
+					    code);
+			/*
+			 * This return value is chosen so that code & 0xff
+			 * mimics the exit code that a POSIX shell would report for
+			 * a program that died from this signal.
+			 */
+			code += 128;
+		} else if (WIFEXITED(wait_status)) {
+			code = WEXITSTATUS(wait_status);
+			/*
+			 * Convert special exit code when execvp failed.
+			 */
+			if (code == 127) {
+				code = -1;
+				errno = ENOENT;
+			}
+		} else {
+			strbuf_addf(&pp->children[i].err,
+				    "waitpid is confused (%s)",
+				    pp->children[i].process.argv[0]);
+			code = -1;
+		}
+
+		if (pp->task_finished(code, &pp->children[i].process,
+				      &pp->children[i].err, pp->data,
+				      &pp->children[i].data))
+			result = 1;
+
+		argv_array_clear(&pp->children[i].process.args);
+		argv_array_clear(&pp->children[i].process.env_array);
+
+		pp->nr_processes--;
+		pp->children[i].in_use = 0;
+		pp->pfd[i].fd = -1;
+
+		if (i != pp->output_owner) {
+			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+			strbuf_reset(&pp->children[i].err);
+		} else {
+			fputs(pp->children[i].err.buf, stderr);
+			strbuf_reset(&pp->children[i].err);
+
+			/* Output all other finished child processes */
+			fputs(pp->buffered_output.buf, stderr);
+			strbuf_reset(&pp->buffered_output);
+
+			/*
+			 * Pick next process to output live.
+			 * NEEDSWORK:
+			 * For now we pick it randomly by doing a round
+			 * robin. Later we may want to pick the one with
+			 * the most output or the longest or shortest
+			 * running process time.
+			 */
+			for (i = 0; i < n; i++)
+				if (pp->children[(pp->output_owner + i) % n].in_use)
+					break;
+			pp->output_owner = (pp->output_owner + i) % n;
+		}
+	}
+	return result;
+}
+
+int run_processes_parallel(int n,
+			   get_next_task_fn get_next_task,
+			   start_failure_fn start_failure,
+			   task_finished_fn task_finished,
+			   void *pp_cb)
+{
+	int i;
+	int output_timeout = 100;
+	int spawn_cap = 4;
+	struct parallel_processes *pp;
+
+	pp = pp_init(n, get_next_task, start_failure, task_finished, pp_cb);
+	while (1) {
+		for (i = 0;
+		    i < spawn_cap && !pp->shutdown &&
+		    pp->nr_processes < pp->max_processes;
+		    i++) {
+			int code = pp_start_one(pp);
+			if (!code)
+				continue;
+			if (code < 0) {
+				pp->shutdown = 1;
+				kill_children(pp, SIGTERM);
+			}
+			break;
+		}
+		if (!pp->nr_processes)
+			break;
+		pp_buffer_stderr(pp, output_timeout);
+		pp_output(pp);
+		if (pp_collect_finished(pp)) {
+			kill_children(pp, SIGTERM);
+			pp->shutdown = 1;
+		}
+	}
+
+	pp_cleanup(pp);
+	return 0;
+}
diff --git a/run-command.h b/run-command.h
index 5b4425a..c24aa54 100644
--- a/run-command.h
+++ b/run-command.h
@@ -119,4 +119,82 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+/**
+ * This callback should initialize the child process and preload the
+ * error channel if desired. The preloading of is useful if you want to
+ * have a message printed directly before the output of the child process.
+ * pp_cb is the callback cookie as passed to run_processes_parallel.
+ * You can store a child process specific callback cookie in pp_task_cb.
+ *
+ * You MUST set stdout_to_stderr.
+ *
+ * Even after returning 0 to indicate that there are no more processes,
+ * this function will be called again until there are no more running
+ * child processes.
+ *
+ * Return 1 if the next child is ready to run.
+ * Return 0 if there are currently no more tasks to be processed.
+ */
+typedef int (*get_next_task_fn)(void **pp_task_cb,
+				struct child_process *cp,
+				struct strbuf *err,
+				void *pp_cb);
+
+/**
+ * This callback is called whenever there are problems starting
+ * a new process.
+ *
+ * You must not write to stdout or stderr in this function. Add your
+ * message to the strbuf err instead, which will be printed without
+ * messing up the output of the other parallel processes.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
+ * Return 0 to continue the parallel processing. To abort gracefully,
+ * return non zero.
+ */
+typedef int (*start_failure_fn)(struct child_process *cp,
+				struct strbuf *err,
+				void *pp_cb,
+				void *pp_task_cb);
+
+/**
+ * This callback is called on every child process that finished processing.
+ *
+ * You must not write to stdout or stderr in this function. Add your
+ * message to the strbuf err instead, which will be printed without
+ * messing up the output of the other parallel processes.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
+ * Return 0 to continue the parallel processing. To abort gracefully,
+ * return non zero.
+ */
+typedef int (*task_finished_fn)(int result,
+				struct child_process *cp,
+				struct strbuf *err,
+				void *pp_cb,
+				void *pp_task_cb);
+
+/**
+ * Runs up to n processes at the same time. Whenever a process can be
+ * started, the callback `get_next_task` is called to obtain the data
+ * fed to the child process.
+ *
+ * The children started via this function run in parallel and their output
+ * to stderr is buffered, while one of the children will directly output
+ * to stderr.
+ *
+ * If start_failure_fn and return_value_fn are NULL, default handlers
+ * will be used. The default handlers will print an error message on
+ * error without issuing an emergency stop.
+ */
+int run_processes_parallel(int n,
+			   get_next_task_fn,
+			   start_failure_fn,
+			   task_finished_fn,
+			   void *pp_cb);
+
 #endif
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 9acf628..49aa3db 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -47,4 +47,24 @@ test_expect_success POSIXPERM,SANITY 'unreadable directory in PATH' '
 	test_cmp expect actual
 '
 
+cat >expect <<-EOF
+preloaded output of a child
+Hello
+World
+preloaded output of a child
+Hello
+World
+preloaded output of a child
+Hello
+World
+preloaded output of a child
+Hello
+World
+EOF
+
+test_expect_success 'run_command runs in parallel' '
+	test-run-command run-command-parallel-4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-run-command.c b/test-run-command.c
index 89c7de2..699d9e9 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -10,9 +10,30 @@
 
 #include "git-compat-util.h"
 #include "run-command.h"
+#include "argv-array.h"
+#include "strbuf.h"
 #include <string.h>
 #include <errno.h>
 
+static int number_callbacks;
+static int parallel_next(void** task_cb,
+			 struct child_process *cp,
+			 struct strbuf *err,
+			 void *cb)
+{
+	struct child_process *d = cb;
+	if (number_callbacks >= 4)
+		return 0;
+
+	argv_array_pushv(&cp->args, d->argv);
+	cp->stdout_to_stderr = 1;
+	cp->no_stdin = 1;
+	cp->err = -1;
+	strbuf_addf(err, "preloaded output of a child\n");
+	number_callbacks++;
+	return 1;
+}
+
 int main(int argc, char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
@@ -30,6 +51,10 @@ int main(int argc, char **argv)
 	if (!strcmp(argv[1], "run-command"))
 		exit(run_command(&proc));
 
+	if (!strcmp(argv[1], "run-command-parallel-4"))
+		exit(run_processes_parallel(4, parallel_next,
+					    NULL, NULL, &proc));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
-- 
2.5.0.268.g453a26a
