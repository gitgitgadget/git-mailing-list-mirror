From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/8] run-command: add an asynchronous parallel child processor
Date: Mon, 28 Sep 2015 16:14:04 -0700
Message-ID: <1443482046-25569-7-git-send-email-sbeller@google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:15:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZghdK-0007i2-CR
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbbI1XOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:49 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33887 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbbI1XO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:29 -0400
Received: by padhy16 with SMTP id hy16so186628512pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PKCzjdRMZtItECVpbri1iYAh3NaJsGG9x6EzM93Q4L0=;
        b=VO7gPnze2aqk3ZIixJZEeuC7jGj0l0Dtd4la3VXMgSTeyiWExMoMqRdAOlE+OFcYl3
         fWTV9p3JMTZkihroTAGHNUK0q1MQVuueo2I3ZHsRZnG9MRjOZADMsGG0NA088wE8xa7E
         jALg1HTy/2QbTmP5dTM07nzvl3sswXdpMa0kWOxpVI7vlMRk6+rJXrtIbyRFG5b3DsX8
         Sqvgqtk2TT86MZptE2zlyTHbr2bpliPgbXSyUbkhV3Jpkgfqi+K6wU1wbNHYof/Zb+fx
         Jt0jxwb027dfXqrBno06IA5uhoDUirLuOZpXPR5+TxaEOZhPkd9TQR0BAJcJuRW6QL+x
         2xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PKCzjdRMZtItECVpbri1iYAh3NaJsGG9x6EzM93Q4L0=;
        b=GEmk4MZMJntfAbtWsFWZaRQYqQXzfokRFAZEZZREpkxQlMTbZjbq6N7dOxr9Tvi+VN
         leztw+GEKInL2f07maY+OYMRVqZsH0FjFDTRE+nqmPvWJLsbofniJJJXtfgg5+VJcsOp
         a7PM5zA3aYAiBzCe97n604K3aMAfeJSWJLikVRU9GztBlB/didzF/thry+6vJlGJea0j
         HI+Qtek7quM1skUUFh4DQNhQjXBP+i+Q0gxc0DjnihYceJkiONYuPv4Lnywhm8lgfA4S
         WpE+J742lBOYirWJ/7ezwDMwryADfbXj3gq7C29lT7OTLjzGr0biE4lLMX08CIjIKcFG
         8qAg==
X-Gm-Message-State: ALoCoQlcJgzDTfDhzr98zIkb0Y94e4NiWvYsKMmSoDtqmm00NkCv0d4IkWQe5Tu+4mCQmOMH/6DG
X-Received: by 10.66.216.1 with SMTP id om1mr29480188pac.51.1443482068554;
        Mon, 28 Sep 2015 16:14:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id g5sm21627000pat.21.2015.09.28.16.14.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443482046-25569-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278809>

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
 run-command.c          | 348 +++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h          |  63 +++++++++
 t/t0061-run-command.sh |  20 +++
 test-run-command.c     |  24 ++++
 4 files changed, 455 insertions(+)

diff --git a/run-command.c b/run-command.c
index 28e1d55..df84985 100644
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
@@ -852,3 +854,349 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	close(cmd->out);
 	return finish_command(cmd);
 }
+
+struct parallel_processes {
+	void *data;
+
+	int max_processes;
+	int nr_processes;
+
+	get_next_task_fn get_next_task;
+	start_failure_fn start_failure;
+	return_value_fn return_value;
+
+	struct {
+		unsigned in_use : 1;
+		struct child_process process;
+		struct strbuf err;
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
+static int default_start_failure(void *data,
+				 struct child_process *cp,
+				 struct strbuf *err)
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
+static int default_return_value(void *data,
+				struct child_process *cp,
+				struct strbuf *err,
+				int result)
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
+static struct parallel_processes *pp_init(int n, void *data,
+					  get_next_task_fn get_next_task,
+					  start_failure_fn start_failure,
+					  return_value_fn return_value)
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
+	pp->return_value = return_value ? return_value : default_return_value;
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
+	if (!pp->get_next_task(pp->data,
+			       &pp->children[i].process,
+			       &pp->children[i].err))
+		return 1;
+
+	if (start_command(&pp->children[i].process)) {
+		int code = pp->start_failure(pp->data,
+					     &pp->children[i].process,
+					     &pp->children[i].err);
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
+		} else
+			strbuf_addf(&pp->children[i].err,
+				    "waitpid is confused (%s)",
+				    pp->children[i].process.argv[0]);
+
+
+		if (pp->return_value(pp->data, &pp->children[i].process,
+				     &pp->children[i].err, code))
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
+int run_processes_parallel(int n, void *data,
+			   get_next_task_fn get_next_task,
+			   start_failure_fn start_failure,
+			   return_value_fn return_value)
+{
+	int no_more_task = 0;
+	struct parallel_processes *pp;
+
+	pp = pp_init(n, data, get_next_task, start_failure, return_value);
+	while (1) {
+		int i;
+		int output_timeout = 100;
+		int spawn_cap = 4;
+
+		if (!no_more_task) {
+			for (i = 0; i < spawn_cap; i++) {
+				int code;
+				if (pp->nr_processes == pp->max_processes)
+					break;
+
+				code = pp_start_one(pp);
+				if (!code)
+					continue;
+				if (code < 0) {
+					pp->shutdown = 1;
+					kill_children(pp, SIGTERM);
+				}
+				no_more_task = 1;
+				break;
+			}
+		}
+		if (no_more_task && !pp->nr_processes)
+			break;
+		pp_buffer_stderr(pp, output_timeout);
+		pp_output(pp);
+		if (pp_collect_finished(pp)) {
+			kill_children(pp, SIGTERM);
+			pp->shutdown = 1;
+			no_more_task = 1;
+		}
+	}
+
+	pp_cleanup(pp);
+	return 0;
+}
diff --git a/run-command.h b/run-command.h
index 5b4425a..1179cb0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -119,4 +119,67 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+/**
+ * This callback should initialize the child process and preload the
+ * error channel. The preloading of is useful if you want to have a message
+ * printed directly before the output of the child process.
+ * You MUST set stdout_to_stderr.
+ *
+ * Return 1 if the next child is ready to run.
+ * Return 0 if there are no more tasks to be processed.
+ */
+typedef int (*get_next_task_fn)(void *data,
+				struct child_process *cp,
+				struct strbuf *err);
+
+/**
+ * This callback is called whenever there are problems starting
+ * a new process.
+ *
+ * You must not write to stdout or stderr in this function. Add your
+ * message to the strbuf err instead, which will be printed without
+ * messing up the output of the other parallel processes.
+ *
+ * Return 0 to continue the parallel processing. To abort gracefully,
+ * return non zero.
+ */
+typedef int (*start_failure_fn)(void *data,
+				struct child_process *cp,
+				struct strbuf *err);
+
+/**
+ * This callback is called on every there are problems starting
+ * a new process.
+ *
+ * You must not write to stdout or stderr in this function. Add your
+ * message to the strbuf err instead, which will be printed without
+ * messing up the output of the other parallel processes.
+ *
+ * Return 0 to continue the parallel processing. To abort gracefully,
+ * return non zero.
+ */
+typedef int (*return_value_fn)(void *data,
+			       struct child_process *cp,
+			       struct strbuf *err,
+			       int result);
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
+
+int run_processes_parallel(int n, void *data,
+			   get_next_task_fn,
+			   start_failure_fn,
+			   return_value_fn);
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
index 89c7de2..2555791 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -10,9 +10,29 @@
 
 #include "git-compat-util.h"
 #include "run-command.h"
+#include "argv-array.h"
+#include "strbuf.h"
 #include <string.h>
 #include <errno.h>
 
+static int number_callbacks;
+static int parallel_next(void *data,
+			 struct child_process *cp,
+			 struct strbuf *err)
+{
+	struct child_process *d = data;
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
@@ -30,6 +50,10 @@ int main(int argc, char **argv)
 	if (!strcmp(argv[1], "run-command"))
 		exit(run_command(&proc));
 
+	if (!strcmp(argv[1], "run-command-parallel-4"))
+		exit(run_processes_parallel(4, &proc, parallel_next,
+					 NULL, NULL));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
-- 
2.5.0.273.g6fa2560.dirty
