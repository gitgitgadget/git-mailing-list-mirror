From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/7] run-command: add an asynchronous parallel child processor
Date: Tue, 15 Dec 2015 16:04:10 -0800
Message-ID: <1450224252-16833-6-git-send-email-sbeller@google.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 16 01:04:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8zaA-0005zR-K5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965566AbbLPAEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:04:36 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33426 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbbLPAE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:04:27 -0500
Received: by mail-pa0-f51.google.com with SMTP id ur14so13436349pab.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pkxdbz5MtX6CvwK/IdJtzSqEA4q+OJwtzycLrqqOTrs=;
        b=lqVbXmPYFOP49fSbR0eAP3fvFRUaGt4d9ejy2FMh2RNdUCe1HepYQFTYtuimtdGuhK
         JwOC8bZOdsJ6MGDIJuuqqtFc2uUnDZCAv0SDUeuPfNbD6eoIdHtvlG9uKf3zZMbbH/LY
         ZA/JPeM7yuwGHaIfsmq7pPMh6ejYUGJnUh+SpggzHDf+eQFSgEjJt2bkfPSNLZhE4E2h
         l/6gcd8nu1m9+g5itRMWtXrK6eGx7suHV20czIxcAUNV63pjt9xZPIUNmrNGxV3I6BEC
         3YRL0hAqVPbWMs7kCFY2HoOMGKWyj59yyVotHpj2TKY1nNUYhgHMuab8IDq/Y30vGgBV
         H3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pkxdbz5MtX6CvwK/IdJtzSqEA4q+OJwtzycLrqqOTrs=;
        b=OfYKjxZrHurFHanRHkj7wdh9EjcQiMyEQ/4zwpiuWaG06iRdc9mHC2NaljvqdydrIW
         oUMtWI5Lt86uF/+sbQEYLKZiYpEa2OcVjO1V4nwZavLSR65876sujsNay63axmoRAmKY
         PjBTBvA9Se37RcI8IWr4iEu1tiNJgAP0BGwQJ/ZtsjXiBsrwZ4jHHvTPFjxs3Z0MdhSV
         wqXJTOjzpY8+NHDmTixFTAU0Udeg9kPR3rkjGWFzcSABm8V1Lex6e4CGLZVdlE27ekeP
         H2kbeR5m5LXbWJ96XBfjiTDxlgZFBwbwLAg7FKclW+9SddH4zFH3zy4sSTjzQyPC/Bxz
         hjLA==
X-Gm-Message-State: ALoCoQm0wp4MzYJbzCL1wOkSVHDEhCp6vCdc6GMak3guqhdk/cK4BcrWlf3Vnt8zXREDoxhwX1pdemKW9h7ch11vco0J6NJ/Yw==
X-Received: by 10.66.162.231 with SMTP id yd7mr3446810pab.98.1450224266477;
        Tue, 15 Dec 2015 16:04:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a171:258:4778:14b4])
        by smtp.gmail.com with ESMTPSA id d74sm398564pfj.20.2015.12.15.16.04.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 16:04:25 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450224252-16833-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282521>

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

To detect when a child has finished executing, we check interleaved
with other actions (such as checking the liveliness of children or
starting new processes) whether the stderr pipe still exists. Once a
child closed its stderr stream, we assume it is terminating very soon,
and use `finish_command()` from the single external process execution
interface to collect the exit status.

By maintaining the strong assumption of stderr being open until the
very end of a child process, we can avoid other hassle such as an
implementation using `waitpid(-1)`, which is not implemented in Windows.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c          | 335 +++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h          |  80 ++++++++++++
 t/t0061-run-command.sh |  53 ++++++++
 test-run-command.c     |  55 +++++++-
 4 files changed, 522 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 13fa452..51fd72c 100644
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
@@ -865,3 +867,336 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	close(cmd->out);
 	return finish_command(cmd);
 }
+
+enum child_state {
+	GIT_CP_FREE,
+	GIT_CP_WORKING,
+	GIT_CP_WAIT_CLEANUP,
+};
+
+struct parallel_processes {
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
+		enum child_state state;
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
+};
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
+		if (pp->children[i].state == GIT_CP_WORKING)
+			kill(pp->children[i].process.pid, signo);
+}
+
+static struct parallel_processes *pp_for_signal;
+
+static void handle_children_on_signal(int signo)
+{
+	kill_children(pp_for_signal, signo);
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+static void pp_init(struct parallel_processes *pp,
+		    int n,
+		    get_next_task_fn get_next_task,
+		    start_failure_fn start_failure,
+		    task_finished_fn task_finished,
+		    void *data)
+{
+	int i;
+
+	if (n < 1)
+		n = online_cpus();
+
+	pp->max_processes = n;
+
+	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
+
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
+	pp->shutdown = 0;
+	pp->children = xcalloc(n, sizeof(*pp->children));
+	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
+	strbuf_init(&pp->buffered_output, 0);
+
+	for (i = 0; i < n; i++) {
+		strbuf_init(&pp->children[i].err, 0);
+		child_process_init(&pp->children[i].process);
+		pp->pfd[i].events = POLLIN | POLLHUP;
+		pp->pfd[i].fd = -1;
+	}
+
+	pp_for_signal = pp;
+	sigchain_push_common(handle_children_on_signal);
+}
+
+static void pp_cleanup(struct parallel_processes *pp)
+{
+	int i;
+
+	trace_printf("run_processes_parallel: done");
+	for (i = 0; i < pp->max_processes; i++) {
+		strbuf_release(&pp->children[i].err);
+		child_process_clear(&pp->children[i].process);
+	}
+
+	free(pp->children);
+	free(pp->pfd);
+
+	/*
+	 * When get_next_task added messages to the buffer in its last
+	 * iteration, the buffered output is non empty.
+	 */
+	fputs(pp->buffered_output.buf, stderr);
+	strbuf_release(&pp->buffered_output);
+
+	sigchain_pop_common();
+}
+
+/* returns
+ *  0 if a new task was started.
+ *  1 if no new jobs was started (get_next_task ran out of work, non critical
+ *    problem with starting a new command)
+ * <0 no new job was started, user wishes to shutdown early. Use negative code
+ *    to signal the children.
+ */
+static int pp_start_one(struct parallel_processes *pp)
+{
+	int i, code;
+
+	for (i = 0; i < pp->max_processes; i++)
+		if (pp->children[i].state == GIT_CP_FREE)
+			break;
+	if (i == pp->max_processes)
+		die("BUG: bookkeeping is hard");
+
+	code = pp->get_next_task(&pp->children[i].process,
+				 &pp->children[i].err,
+				 pp->data,
+				 &pp->children[i].data);
+	if (!code) {
+		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+		strbuf_reset(&pp->children[i].err);
+		return 1;
+	}
+	pp->children[i].process.err = -1;
+	pp->children[i].process.stdout_to_stderr = 1;
+	pp->children[i].process.no_stdin = 1;
+
+	if (start_command(&pp->children[i].process)) {
+		code = pp->start_failure(&pp->children[i].process,
+					 &pp->children[i].err,
+					 pp->data,
+					 &pp->children[i].data);
+		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+		strbuf_reset(&pp->children[i].err);
+		if (code)
+			pp->shutdown = 1;
+		return code;
+	}
+
+	pp->nr_processes++;
+	pp->children[i].state = GIT_CP_WORKING;
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
+		if (pp->children[i].state == GIT_CP_WORKING &&
+		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
+			int n = strbuf_read_once(&pp->children[i].err,
+						 pp->children[i].process.err, 0);
+			if (n == 0) {
+				close(pp->children[i].process.err);
+				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
+			} else if (n < 0)
+				if (errno != EAGAIN)
+					die_errno("read");
+		}
+	}
+}
+
+static void pp_output(struct parallel_processes *pp)
+{
+	int i = pp->output_owner;
+	if (pp->children[i].state == GIT_CP_WORKING &&
+	    pp->children[i].err.len) {
+		fputs(pp->children[i].err.buf, stderr);
+		strbuf_reset(&pp->children[i].err);
+	}
+}
+
+static int pp_collect_finished(struct parallel_processes *pp)
+{
+	int i, code;
+	int n = pp->max_processes;
+	int result = 0;
+
+	while (pp->nr_processes > 0) {
+		for (i = 0; i < pp->max_processes; i++)
+			if (pp->children[i].state == GIT_CP_WAIT_CLEANUP)
+				break;
+		if (i == pp->max_processes)
+			break;
+
+		code = finish_command(&pp->children[i].process);
+
+		code = pp->task_finished(code, &pp->children[i].process,
+					 &pp->children[i].err, pp->data,
+					 &pp->children[i].data);
+
+		if (code)
+			result = code;
+		if (code < 0)
+			break;
+
+		pp->nr_processes--;
+		pp->children[i].state = GIT_CP_FREE;
+		pp->pfd[i].fd = -1;
+		child_process_init(&pp->children[i].process);
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
+				if (pp->children[(pp->output_owner + i) % n].state == GIT_CP_WORKING)
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
+	int i, code;
+	int output_timeout = 100;
+	int spawn_cap = 4;
+	struct parallel_processes pp;
+
+	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
+	while (1) {
+		for (i = 0;
+		    i < spawn_cap && !pp.shutdown &&
+		    pp.nr_processes < pp.max_processes;
+		    i++) {
+			code = pp_start_one(&pp);
+			if (!code)
+				continue;
+			if (code < 0) {
+				pp.shutdown = 1;
+				kill_children(&pp, -code);
+			}
+			break;
+		}
+		if (!pp.nr_processes)
+			break;
+		pp_buffer_stderr(&pp, output_timeout);
+		pp_output(&pp);
+		code = pp_collect_finished(&pp);
+		if (code) {
+			pp.shutdown = 1;
+			if (code < 0)
+				kill_children(&pp, -code);
+		}
+	}
+
+	pp_cleanup(&pp);
+	return 0;
+}
diff --git a/run-command.h b/run-command.h
index 12bb26c..d5a57f9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -122,4 +122,84 @@ int start_async(struct async *async);
 int finish_async(struct async *async);
 int in_async(void);
 
+/**
+ * This callback should initialize the child process and preload the
+ * error channel if desired. The preloading of is useful if you want to
+ * have a message printed directly before the output of the child process.
+ * pp_cb is the callback cookie as passed to run_processes_parallel.
+ * You can store a child process specific callback cookie in pp_task_cb.
+ *
+ * Even after returning 0 to indicate that there are no more processes,
+ * this function will be called again until there are no more running
+ * child processes.
+ *
+ * Return 1 if the next child is ready to run.
+ * Return 0 if there are currently no more tasks to be processed.
+ * To send a signal to other child processes for abortion,
+ * return the negative signal number.
+ */
+typedef int (*get_next_task_fn)(struct child_process *cp,
+				struct strbuf *err,
+				void *pp_cb,
+				void **pp_task_cb);
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
+ * Return 0 to continue the parallel processing. To abort return non zero.
+ * To send a signal to other child processes for abortion, return
+ * the negative signal number.
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
+ * Return 0 to continue the parallel processing.  To abort return non zero.
+ * To send a signal to other child processes for abortion, return
+ * the negative signal number.
+ */
+typedef int (*task_finished_fn)(int result,
+				struct child_process *cp,
+				struct strbuf *err,
+				void *pp_cb,
+				void *pp_task_cb);
+
+/**
+ * Runs up to n processes at the same time. Whenever a process can be
+ * started, the callback get_next_task_fn is called to obtain the data
+ * required to start another child process.
+ *
+ * The children started via this function run in parallel. Their output
+ * (both stdout and stderr) is routed to stderr in a manner that output
+ * from different tasks does not interleave.
+ *
+ * If start_failure_fn or task_finished_fn are NULL, default handlers
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
index 9acf628..12228b4 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -47,4 +47,57 @@ test_expect_success POSIXPERM,SANITY 'unreadable directory in PATH' '
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
+test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
+	test-run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
+	test-run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
+	test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<-EOF
+preloaded output of a child
+asking for a quick stop
+preloaded output of a child
+asking for a quick stop
+preloaded output of a child
+asking for a quick stop
+EOF
+
+test_expect_success 'run_command is asked to abort gracefully' '
+	test-run-command run-command-abort 3 false 2>actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<-EOF
+no further jobs available
+EOF
+
+test_expect_success 'run_command outputs ' '
+	test-run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-run-command.c b/test-run-command.c
index 89c7de2..f964507 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -10,16 +10,54 @@
 
 #include "git-compat-util.h"
 #include "run-command.h"
+#include "argv-array.h"
+#include "strbuf.h"
 #include <string.h>
 #include <errno.h>
 
+static int number_callbacks;
+static int parallel_next(struct child_process *cp,
+			 struct strbuf *err,
+			 void *cb,
+			 void** task_cb)
+{
+	struct child_process *d = cb;
+	if (number_callbacks >= 4)
+		return 0;
+
+	argv_array_pushv(&cp->args, d->argv);
+	strbuf_addf(err, "preloaded output of a child\n");
+	number_callbacks++;
+	return 1;
+}
+
+static int no_job(struct child_process *cp,
+		  struct strbuf *err,
+		  void *cb,
+		  void** task_cb)
+{
+	strbuf_addf(err, "no further jobs available\n");
+	return 0;
+}
+
+static int task_finished(int result,
+			 struct child_process *cp,
+			 struct strbuf *err,
+			 void *pp_cb,
+			 void *pp_task_cb)
+{
+	strbuf_addf(err, "asking for a quick stop\n");
+	return 1;
+}
+
 int main(int argc, char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
+	int jobs;
 
 	if (argc < 3)
 		return 1;
-	proc.argv = (const char **)argv+2;
+	proc.argv = (const char **)argv + 2;
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
 		if (start_command(&proc) < 0 && errno == ENOENT)
@@ -30,6 +68,21 @@ int main(int argc, char **argv)
 	if (!strcmp(argv[1], "run-command"))
 		exit(run_command(&proc));
 
+	jobs = atoi(argv[2]);
+	proc.argv = (const char **)argv + 3;
+
+	if (!strcmp(argv[1], "run-command-parallel"))
+		exit(run_processes_parallel(jobs, parallel_next,
+					    NULL, NULL, &proc));
+
+	if (!strcmp(argv[1], "run-command-abort"))
+		exit(run_processes_parallel(jobs, parallel_next,
+					    NULL, task_finished, &proc));
+
+	if (!strcmp(argv[1], "run-command-no-jobs"))
+		exit(run_processes_parallel(jobs, no_job,
+					    NULL, task_finished, &proc));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
-- 
2.6.4.443.ge094245.dirty
