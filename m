From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 06/13] run-command: add an asynchronous parallel child processor
Date: Mon, 21 Sep 2015 15:39:12 -0700
Message-ID: <1442875159-13027-7-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kL-0006NK-2m
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbbIUWjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33036 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692AbbIUWjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:33 -0400
Received: by pacex6 with SMTP id ex6so128684997pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gXcn3jbh0cq2SJNnFjOlBxYx6fRnVxwZRt1hTgfOkuk=;
        b=D4gRfle6I1tpRGLLoOh9pj+FrUGIyrh1GlAZMD91MhjEzrlBDVnfBQ+SHFFSB0/BSC
         UcP3N79voS4ayOBysUXPFtkLJ0xvE+4RABrl18syrOiSVSNWHlS0E43cjBrmreCWDeV6
         aTggUDbrYJcGF+spR2PaAovclj9xXxAk9j2oN1oAp5PYhc4xKD+NrzsbRRO+lKttJAuc
         SJiXJpXEjPHDseoSqAlmDvwxFykwzrtOE9CNWoGiCMOGH3J5Fgq/NiDQeWt7a0U/w83Q
         pdk/DJoEc17s3AJOdEwNjE0GzS2TtTLImjpkWwWkI+MYaNRMRQWmbA7XxPU9KGy0XErM
         WeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gXcn3jbh0cq2SJNnFjOlBxYx6fRnVxwZRt1hTgfOkuk=;
        b=YXcm4GdR18li+8QnXmuAePKES4tXNyeqkK3NnLaAyfJTj2uYjDx347b1G/mztZDR5z
         cuQXN6UqAEvG2A39fQBLhNAjy1NMTPt2pks3CQBwVLZPalTAD1T5OY/SjgtsRwkoeyX8
         FckO1yjqWDesq6k/tRLFLsEoes1c8T9DOtOknpVeMzAXWbbmV95VQlL2GiB0UsYMFwEN
         hMyYUcNq34fer9AGfR+zeZ/O97SghRZawmz8KPYOYpopChCiv7LVTJa6tHV+e2YHlsIL
         zH8WRFVhXjTf2Yqz1PHY64NIUgGI/ZqtCiQd3Q6mv3gPJGiHv8VaEnzqXmCqblIQZN6K
         +LBQ==
X-Gm-Message-State: ALoCoQkDO9s9b6Jk9meqMpdGeoB/aOC+uYuWXIYe4R1Yva3MNJoLQmYcAeV9z1e4ocyN6hyB5m8B
X-Received: by 10.66.145.97 with SMTP id st1mr27474513pab.145.1442875171729;
        Mon, 21 Sep 2015 15:39:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id ey17sm26641722pac.26.2015.09.21.15.39.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278341>

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
---
 run-command.c          | 275 +++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h          |  36 +++++++
 t/t0061-run-command.sh |  20 ++++
 test-run-command.c     |  24 +++++
 4 files changed, 355 insertions(+)

diff --git a/run-command.c b/run-command.c
index 674e348..06d5a5d 100644
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
@@ -862,3 +864,276 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	close(cmd->out);
 	return finish_command(cmd);
 }
+
+struct parallel_processes {
+	void *data;
+
+	int max_processes;
+	int nr_processes;
+	unsigned all_tasks_started : 1;
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
+	int output_owner;
+	struct strbuf buffered_output; /* of finished children */
+};
+
+void default_start_failure(void *data,
+			   struct child_process *cp,
+			   struct strbuf *err)
+{
+	int i;
+	struct strbuf sb = STRBUF_INIT;
+
+	for (i = 0; cp->argv[i]; i++)
+		strbuf_addf(&sb, "%s ", cp->argv[i]);
+
+	die_errno("Starting a child failed:\n%s", sb.buf);
+}
+
+void default_return_value(void *data,
+			  struct child_process *cp,
+			  int result)
+{
+	int i;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!result)
+		return;
+
+	for (i = 0; cp->argv[i]; i++)
+		strbuf_addf(&sb, "%s ", cp->argv[i]);
+
+	die_errno("A child failed with return code:\n%s\n%d", sb.buf, result);
+}
+
+static void run_processes_parallel_init(struct parallel_processes *pp,
+					int n, void *data,
+					get_next_task_fn get_next_task,
+					start_failure_fn start_failure,
+					return_value_fn return_value)
+{
+	int i;
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
+	pp->all_tasks_started = 0;
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
+}
+
+static void run_processes_parallel_cleanup(struct parallel_processes *pp)
+{
+	int i;
+	for (i = 0; i < pp->max_processes; i++)
+		strbuf_release(&pp->children[i].err);
+
+	free(pp->children);
+	free(pp->pfd);
+	strbuf_release(&pp->buffered_output);
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
+static void run_processes_parallel_start_one(struct parallel_processes *pp)
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
+			       &pp->children[i].err)) {
+		pp->all_tasks_started = 1;
+		return;
+	}
+	if (start_command(&pp->children[i].process))
+		pp->start_failure(pp->data,
+				  &pp->children[i].process,
+				  &pp->children[i].err);
+
+	set_nonblocking(pp->children[i].process.err);
+
+	pp->nr_processes++;
+	pp->children[i].in_use = 1;
+	pp->pfd[i].fd = pp->children[i].process.err;
+}
+
+static void run_processes_parallel_start_as_needed(struct parallel_processes *pp)
+{
+	while (pp->nr_processes < pp->max_processes &&
+	       !pp->all_tasks_started)
+		run_processes_parallel_start_one(pp);
+}
+
+static void run_processes_parallel_buffer_stderr(struct parallel_processes *pp)
+{
+	int i;
+
+	while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
+		if (errno == EINTR)
+			continue;
+		run_processes_parallel_cleanup(pp);
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
+static void run_processes_parallel_output(struct parallel_processes *pp)
+{
+	int i = pp->output_owner;
+	if (pp->children[i].in_use &&
+	    pp->children[i].err.len) {
+		fputs(pp->children[i].err.buf, stderr);
+		strbuf_reset(&pp->children[i].err);
+	}
+}
+
+static void run_processes_parallel_collect_finished(struct parallel_processes *pp)
+{
+	int i = 0;
+	pid_t pid;
+	int wait_status, code;
+	int n = pp->max_processes;
+
+	while (pp->nr_processes > 0) {
+		pid = waitpid(-1, &wait_status, WNOHANG);
+		if (pid == 0)
+			return;
+
+		if (pid < 0)
+			die_errno("wait");
+
+		for (i = 0; i < pp->max_processes; i++)
+			if (pp->children[i].in_use &&
+			    pid == pp->children[i].process.pid)
+				break;
+		if (i == pp->max_processes)
+			/*
+			 * waitpid returned another process id
+			 * which we are not waiting for.
+			 */
+			return;
+
+		if (strbuf_read_once(&pp->children[i].err,
+				     pp->children[i].process.err, 0) < 0 &&
+		    errno != EAGAIN)
+			die_errno("strbuf_read_once");
+
+
+		if (determine_return_value(wait_status, &code, &errno,
+					   pp->children[i].process.argv[0]) < 0)
+			error("waitpid is confused (%s)",
+			      pp->children[i].process.argv[0]);
+
+		pp->return_value(pp->data, &pp->children[i].process, code);
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
+}
+
+int run_processes_parallel(int n, void *data,
+			   get_next_task_fn get_next_task,
+			   start_failure_fn start_failure,
+			   return_value_fn return_value)
+{
+	struct parallel_processes pp;
+	run_processes_parallel_init(&pp, n, data,
+				    get_next_task,
+				    start_failure,
+				    return_value);
+
+	while (!pp.all_tasks_started || pp.nr_processes > 0) {
+		run_processes_parallel_start_as_needed(&pp);
+		run_processes_parallel_buffer_stderr(&pp);
+		run_processes_parallel_output(&pp);
+		run_processes_parallel_collect_finished(&pp);
+	}
+	run_processes_parallel_cleanup(&pp);
+
+	return 0;
+}
diff --git a/run-command.h b/run-command.h
index 5b4425a..3807fd1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -119,4 +119,40 @@ struct async {
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
+typedef void (*start_failure_fn)(void *data,
+				 struct child_process *cp,
+				 struct strbuf *err);
+
+typedef void (*return_value_fn)(void *data,
+				struct child_process *cp,
+				int result);
+
+/**
+ * Runs up to n processes at the same time. Whenever a process can be
+ * started, the callback `get_next_task` is called to obtain the data
+ * fed to the child process.
+ *
+ * The children started via this function run in parallel and their output
+ * to stderr is buffered, while one of the children will directly output
+ * to stderr.
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
index 89c7de2..94c6eee 100644
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
+int parallel_next(void *data,
+		  struct child_process *cp,
+		  struct strbuf *err)
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
2.5.0.275.ge015d2a
