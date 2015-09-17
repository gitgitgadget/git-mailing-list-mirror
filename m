From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/10] run-command: add an asynchronous parallel child processor
Date: Wed, 16 Sep 2015 18:39:01 -0700
Message-ID: <1442453948-9885-4-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAn-0006Ku-1c
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbbIQBjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:25 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33300 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbbIQBjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:17 -0400
Received: by pacex6 with SMTP id ex6so4760629pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yXLfUEi9/mqNg/EVxQmy3qNydIe80eSxRjqv7EKdyL4=;
        b=LbGQ+/frW1gdo/6JNaweye0qnI5WS+zt4OMtpfUP5ns5WruuQ+5Gt/UZI3Dn3XpTqz
         nBUdAnPgzt00U4Ye9e/CIY9i6vnLkE2NomfHiNvuUN3WJRlWGDxpB1iyrHWVAGxwFGTz
         MIvk1EoD/lHbAvU2IabkMqFIpE5jzx5tRYd+Bhh2vsZzkFXepjf0c1TH1Vpx5aIuYVb9
         I0A4Y8KKFhT5F3R080IUReUCSvF6tpqFAL+DCEFATHsg6vZKoC+e1yw59dyFwlRKVKU9
         X4gJNiJW4eisxchrIfF2X9E9XTHeVs6pUsEL/ffejpC7hlSQJAemHVkUIKDKxRd8mrtk
         Gdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yXLfUEi9/mqNg/EVxQmy3qNydIe80eSxRjqv7EKdyL4=;
        b=k5YY0/7/ooKAGMQDaYE96E/TiGs+x6Xh3+ulODp781zZlWOx4ainOYp26mt4GW8vCH
         RWAlMIMrbobkaoJqg0qYeZ+p5bY6EDXRmn10P3tnbCXLfrl/9EHTNy4YU73rlNYoTGcx
         r70L25SKeiQTQfo8TCSCdHvbAP9uZGaGF1bkPYBBKXQdmIZKQZGWaALgk9N1t6PDNSWE
         b7nIWm4hSO+AHcsLNOMBgOGmN/bqXCXx9Daj+D9jxUXQC2DtWKTC8UDHkfTKpBAmtc4x
         omn2afM6IugW+fY+FwA54kRljflMpH3T946lurobTe1GVi2WHaBtYm55S/3XZQubMVCg
         jvxQ==
X-Gm-Message-State: ALoCoQlReSx9JyO4dFSaHg08p4EttbhImV8ogGSbwqXlDEUw3iB2lfpJDRspj2gHeRoeV3kNIWnP
X-Received: by 10.68.231.5 with SMTP id tc5mr66815971pbc.54.1442453956814;
        Wed, 16 Sep 2015 18:39:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id rz10sm547191pab.42.2015.09.16.18.39.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:16 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278098>

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
 output: |---A---|   |-B-|   |----C-----------|   |-D-|   |-E-|

When we schedule these submodules into maximal two parallel processes,
a schedule and sample output over time may look like this:

thread 1: |---A---|   |-D-|   |-E-|

thread 2: |-B-|   |----C-----------|

output:   |---A---|B|------C-------|DE

So A will be perceived as it would run normally in the single child
version. As B has finished by the time A is done, we can dump its whole
progress buffer on stderr, such that it looks like it finished in no time.
Once that is done, C is determined to be the visible child and its progress
will be reported in real time.

So this way of output is really good for human consumption,
as it only changes the timing, not the actual output.

For machine consumption the output needs to be prepared in
the tasks, by either having a prefix per line or per block
to indicate whose tasks output is displayed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c          | 228 +++++++++++++++++++++++++++++++++++++++++++++++++
 run-command.h          |  36 ++++++++
 t/t0061-run-command.sh |  20 +++++
 test-run-command.c     |  24 ++++++
 4 files changed, 308 insertions(+)

diff --git a/run-command.c b/run-command.c
index c892e9a..3af97ab 100644
--- a/run-command.c
+++ b/run-command.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "sigchain.h"
 #include "argv-array.h"
+#include "thread-utils.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -862,3 +863,230 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	close(cmd->out);
 	return finish_command(cmd);
 }
+
+struct parallel_processes {
+	int max_number_processes;
+	void *data;
+	get_next_task fn;
+	handle_child_starting_failure fn_err;
+	handle_child_return_value fn_exit;
+
+	int nr_processes;
+	int all_tasks_started;
+	int foreground_child;
+	char *slots;
+	struct child_process *children;
+	struct pollfd *pfd;
+	struct strbuf *err;
+	struct strbuf finished_children;
+};
+
+static void run_processes_parallel_init(struct parallel_processes *pp,
+					int n, void *data,
+					get_next_task fn,
+					handle_child_starting_failure fn_err,
+					handle_child_return_value fn_exit)
+{
+	int i;
+
+	if (n < 1)
+		n = online_cpus();
+
+	pp->max_number_processes = n;
+	pp->data = data;
+	pp->fn = fn;
+	pp->fn_err = fn_err;
+	pp->fn_exit = fn_exit;
+
+	pp->nr_processes = 0;
+	pp->all_tasks_started = 0;
+	pp->foreground_child = 0;
+	pp->slots = xcalloc(n, sizeof(*pp->slots));
+	pp->children = xcalloc(n, sizeof(*pp->children));
+	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
+	pp->err = xcalloc(n, sizeof(*pp->err));
+	strbuf_init(&pp->finished_children, 0);
+
+	for (i = 0; i < n; i++) {
+		strbuf_init(&pp->err[i], 0);
+		pp->pfd[i].events = POLLIN;
+		pp->pfd[i].fd = -1;
+	}
+}
+
+static void run_processes_parallel_cleanup(struct parallel_processes *pp)
+{
+	int i;
+	for (i = 0; i < pp->max_number_processes; i++)
+		strbuf_release(&pp->err[i]);
+
+	free(pp->children);
+	free(pp->slots);
+	free(pp->pfd);
+	free(pp->err);
+	strbuf_release(&pp->finished_children);
+}
+
+static void unblock_fd(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+	if (flags < 0) {
+		warning("Could not get file status flags, "
+			"output will be degraded");
+		return;
+	}
+	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK)) {
+			warning("Could not set file status flags, "
+			"output will be degraded");
+		return;
+	}
+}
+
+static void run_processes_parallel_start_new(struct parallel_processes *pp)
+{
+	int i;
+	/* Start new processes. */
+	while (!pp->all_tasks_started
+	       && pp->nr_processes < pp->max_number_processes) {
+		for (i = 0; i < pp->max_number_processes; i++)
+			if (!pp->slots[i])
+				break; /* found an empty slot */
+		if (i == pp->max_number_processes)
+			die("BUG: bookkeeping is hard");
+
+		if (pp->fn(pp->data, &pp->children[i], &pp->err[i])) {
+			pp->all_tasks_started = 1;
+			break;
+		}
+		if (start_command(&pp->children[i]))
+			pp->fn_err(pp->data, &pp->children[i], &pp->err[i]);
+
+		unblock_fd(pp->children[i].err);
+
+		pp->nr_processes++;
+		pp->slots[i] = 1;
+		pp->pfd[i].fd = pp->children[i].err;
+	}
+}
+
+static int run_processes_parallel_buffer_stderr(struct parallel_processes *pp)
+{
+	int i;
+	i = poll(pp->pfd, pp->max_number_processes, 100);
+	if (i < 0) {
+		if (errno == EINTR)
+			/* A signal was caught; try again */
+			return -1;
+		else {
+			run_processes_parallel_cleanup(pp);
+			die_errno("poll");
+		}
+	}
+
+	/* Buffer output from all pipes. */
+	for (i = 0; i < pp->max_number_processes; i++) {
+		if (!pp->slots[i])
+			continue;
+		if (pp->pfd[i].revents & POLLIN)
+			strbuf_read_noblock(&pp->err[i], pp->children[i].err, 0);
+		if (pp->foreground_child == i) {
+			fputs(pp->err[i].buf, stderr);
+			strbuf_reset(&pp->err[i]);
+		}
+	}
+	return 0;
+}
+
+
+static void run_processes_parallel_collect_finished(struct parallel_processes *pp)
+{
+	int i = 0;
+	pid_t pid;
+	int wait_status, code;
+	int n = pp->max_number_processes;
+	/* Collect finished child processes. */
+	while (pp->nr_processes > 0) {
+		pid = waitpid(-1, &wait_status, WNOHANG);
+		if (pid == 0)
+			return; /* no child finished */
+
+		if (pid < 0) {
+			if (errno == EINTR)
+				return; /* just try again  next time */
+			if (errno == EINVAL || errno == ECHILD)
+				die_errno("wait");
+		} else {
+			/* Find the finished child. */
+			for (i = 0; i < pp->max_number_processes; i++)
+				if (pp->slots[i] && pid == pp->children[i].pid)
+					break;
+			if (i == pp->max_number_processes)
+				/*
+				 * waitpid returned another process id
+				 * which we are not waiting for.
+				 */
+				return;
+		}
+		strbuf_read_noblock(&pp->err[i], pp->children[i].err, 0);
+
+		if (determine_return_value(wait_status, &code, &errno,
+					   pp->children[i].argv[0]) < 0)
+			error("waitpid is confused (%s)",
+			      pp->children[i].argv[0]);
+
+		pp->fn_exit(pp->data, &pp->children[i], code);
+
+		argv_array_clear(&pp->children[i].args);
+		argv_array_clear(&pp->children[i].env_array);
+
+		pp->nr_processes--;
+		pp->slots[i] = 0;
+		pp->pfd[i].fd = -1;
+
+		if (i != pp->foreground_child) {
+			strbuf_addbuf(&pp->finished_children, &pp->err[i]);
+			strbuf_reset(&pp->err[i]);
+		} else {
+			fputs(pp->err[i].buf, stderr);
+			strbuf_reset(&pp->err[i]);
+
+			/* Output all other finished child processes */
+			fputs(pp->finished_children.buf, stderr);
+			strbuf_reset(&pp->finished_children);
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
+				if (pp->slots[(pp->foreground_child + i) % n])
+					break;
+			pp->foreground_child = (pp->foreground_child + i) % n;
+			fputs(pp->err[pp->foreground_child].buf, stderr);
+			strbuf_reset(&pp->err[pp->foreground_child]);
+		}
+	}
+}
+
+int run_processes_parallel(int n, void *data,
+			   get_next_task fn,
+			   handle_child_starting_failure fn_err,
+			   handle_child_return_value fn_exit)
+{
+	struct parallel_processes pp;
+	run_processes_parallel_init(&pp, n, data, fn, fn_err, fn_exit);
+
+	while (!pp.all_tasks_started || pp.nr_processes > 0) {
+		run_processes_parallel_start_new(&pp);
+		if (run_processes_parallel_buffer_stderr(&pp))
+			continue;
+		run_processes_parallel_collect_finished(&pp);
+	}
+	run_processes_parallel_cleanup(&pp);
+
+	return 0;
+}
diff --git a/run-command.h b/run-command.h
index 5b4425a..0487f71 100644
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
+ * Return 0 if the next child is ready to run.
+ * Return != 0 if there are no more tasks to be processed.
+ */
+typedef int (*get_next_task)(void *data,
+			     struct child_process *cp,
+			     struct strbuf *err);
+
+typedef void (*handle_child_starting_failure)(void *data,
+					      struct child_process *cp,
+					      struct strbuf *err);
+
+typedef void (*handle_child_return_value)(void *data,
+					  struct child_process *cp,
+					  int result);
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
+			   get_next_task fn,
+			   handle_child_starting_failure,
+			   handle_child_return_value);
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
index 89c7de2..70b6c7a 100644
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
+		return 1;
+
+	argv_array_pushv(&cp->args, d->argv);
+	cp->stdout_to_stderr = 1;
+	cp->no_stdin = 1;
+	cp->err = -1;
+	strbuf_addf(err, "preloaded output of a child\n");
+	number_callbacks++;
+	return 0;
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
2.6.0.rc0.131.gf624c3d
