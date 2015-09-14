From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] fetch: fetch submodules in parallel
Date: Mon, 14 Sep 2015 14:50:51 -0700
Message-ID: <1442267451-2527-2-git-send-email-sbeller@google.com>
References: <20150914180759.GA11920@sigill.intra.peff.net>
 <1442267451-2527-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 14 23:51:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbbeU-00061w-UT
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 23:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbbINVvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 17:51:00 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36296 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbINVu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 17:50:58 -0400
Received: by padhk3 with SMTP id hk3so154586917pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFy3TDdOehWo2aIY0QdryJklQ4d/JLGR9QxYaSg8wJk=;
        b=heGkzcGiPSyuwBUVQWpAUcJvfLcmvB3S7HVOpm1DuOug8+2jXKUaJJjvSe7gYyL9TG
         8bARfWg4c5PyH14zvUJEtEeE3vAgfQGwxYRBG0t/ybqNA4Dd2E4POc/EcAV4QN8tX5hs
         IYklzA304lYQ+uH42TK0CjtNXUf8vrUWJOTB+UfefCz54ndjgoAACHlHTlkcSLHQXIII
         drGemrfyNrPXki1AcCQRvHpsi+CcO2Uo8OST4ut06cS7l0mFYH0qSZNi5I+t4kPKugwR
         8b++6th6nUMzzbXyu+JBI3WGfnmTI9H322EwXALxL6c5gwUKeYr4WFc+MlU80I8psta5
         ajcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFy3TDdOehWo2aIY0QdryJklQ4d/JLGR9QxYaSg8wJk=;
        b=Al8iKenXCL6PCOA4rq91VmXEnuiDErVauM04mU+Q5lzKn3d/TZ1oCXZPikfuajm1PZ
         bOyVy6ul0bOeZ+/9wNdMoif6M4Xl3odLTKnBH6EeWEMr0qzt+UdGSdkIObwJY6VIKZ43
         4fuSTMkwdn6x8y9LOEAwJzqyHSEygArRL8Cit1IkOF7CQoZqsuK8JnBm2/zjnH3BWFzs
         S+pvixTCS4fDWB8McMfGi0dlDlCuNlX9v1vM1aGR5/PClfx2tA1BHNMgNOVeGQtuzmak
         /cBqsoI8TanoTwMbk3zS9vBdmzQml3J5mpX84QVwDW3Ci38SAQA9zInwNWz9Tn/FI9af
         E1+w==
X-Gm-Message-State: ALoCoQlBsFB+4KjxRCbvgKjGYJxNlOLCLQ11fqyz/VyJ2o9i1UqAWPfuc4WYLheexKjEntyLhvbp
X-Received: by 10.66.191.232 with SMTP id hb8mr39475296pac.22.1442267457711;
        Mon, 14 Sep 2015 14:50:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6c13:6ad3:5771:36ec])
        by smtp.gmail.com with ESMTPSA id fx4sm17959962pbb.92.2015.09.14.14.50.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 14:50:57 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442267451-2527-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277866>

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
 Documentation/fetch-options.txt |   7 +
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 +
 run-command.c                   | 278 ++++++++++++++++++++++++++++++++++++----
 run-command.h                   |  36 ++++++
 strbuf.c                        |  31 +++++
 strbuf.h                        |   1 +
 submodule.c                     | 119 ++++++++++++-----
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  20 +++
 t/t5526-fetch-submodules.sh     |  19 +++
 test-run-command.c              |  24 ++++
 12 files changed, 490 insertions(+), 59 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 45583d8..6b109f6 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -100,6 +100,13 @@ ifndef::git-pull[]
 	reference to a commit that isn't already in the local submodule
 	clone.
 
+-j::
+--jobs=<n>::
+	Number of parallel children to be used for fetching submodules.
+	Each will fetch from different submodules, such that fetching many
+	submodules will be faster. By default submodules will be fetched
+	one at a time.
+
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the '--recurse-submodules=no' option).
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ee1f1a9..f28eac6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,6 +37,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
+static int max_children = 1;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
@@ -99,6 +100,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
+	OPT_INTEGER('j', "jobs", &max_children,
+		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
@@ -1217,7 +1220,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_populated_submodules(&options,
 						    submodule_prefix,
 						    recurse_submodules,
-						    verbosity < 0);
+						    verbosity < 0,
+						    max_children);
 		argv_array_clear(&options);
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 722a83c..f0af196 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -94,6 +94,7 @@ static int opt_force;
 static char *opt_tags;
 static char *opt_prune;
 static char *opt_recurse_submodules;
+static char *max_children;
 static int opt_dry_run;
 static char *opt_keep;
 static char *opt_depth;
@@ -177,6 +178,9 @@ static struct option pull_options[] = {
 		N_("on-demand"),
 		N_("control recursive fetching of submodules"),
 		PARSE_OPT_OPTARG),
+	OPT_PASSTHRU('j', "jobs", &max_children, N_("n"),
+		N_("number of submodules pulled in parallel"),
+		PARSE_OPT_OPTARG),
 	OPT_BOOL(0, "dry-run", &opt_dry_run,
 		N_("dry run")),
 	OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
@@ -524,6 +528,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, opt_prune);
 	if (opt_recurse_submodules)
 		argv_array_push(&args, opt_recurse_submodules);
+	if (max_children)
+		argv_array_push(&args, max_children);
 	if (opt_dry_run)
 		argv_array_push(&args, "--dry-run");
 	if (opt_keep)
diff --git a/run-command.c b/run-command.c
index 28e1d55..6f6f9fb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -232,6 +232,35 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
+static int determine_return_value(int wait_status,
+				  int *result,
+				  int *error_code,
+				  const char *argv0)
+{
+	if (WIFSIGNALED(wait_status)) {
+		*result = WTERMSIG(wait_status);
+		if (*result != SIGINT && *result != SIGQUIT)
+			error("%s died of signal %d", argv0, *result);
+		/*
+		 * This return value is chosen so that code & 0xff
+		 * mimics the exit code that a POSIX shell would report for
+		 * a program that died from this signal.
+		 */
+		*result += 128;
+	} else if (WIFEXITED(wait_status)) {
+		*result = WEXITSTATUS(wait_status);
+		/*
+		 * Convert special exit code when execvp failed.
+		 */
+		if (*result == 127) {
+			*result = -1;
+			*error_code = ENOENT;
+		}
+	} else
+		return 1;
+	return 0;
+}
+
 static int wait_or_whine(pid_t pid, const char *argv0)
 {
 	int status, code = -1;
@@ -244,29 +273,10 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 	if (waiting < 0) {
 		failed_errno = errno;
 		error("waitpid for %s failed: %s", argv0, strerror(errno));
-	} else if (waiting != pid) {
-		error("waitpid is confused (%s)", argv0);
-	} else if (WIFSIGNALED(status)) {
-		code = WTERMSIG(status);
-		if (code != SIGINT && code != SIGQUIT)
-			error("%s died of signal %d", argv0, code);
-		/*
-		 * This return value is chosen so that code & 0xff
-		 * mimics the exit code that a POSIX shell would report for
-		 * a program that died from this signal.
-		 */
-		code += 128;
-	} else if (WIFEXITED(status)) {
-		code = WEXITSTATUS(status);
-		/*
-		 * Convert special exit code when execvp failed.
-		 */
-		if (code == 127) {
-			code = -1;
-			failed_errno = ENOENT;
-		}
 	} else {
-		error("waitpid is confused (%s)", argv0);
+		if (waiting != pid
+		   || (determine_return_value(status, &code, &failed_errno, argv0) < 0))
+			error("waitpid is confused (%s)", argv0);
 	}
 
 	clear_child_for_cleanup(pid);
@@ -852,3 +862,227 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	close(cmd->out);
 	return finish_command(cmd);
 }
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
diff --git a/strbuf.c b/strbuf.c
index cce5eed..7f866c3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -384,6 +384,37 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	return sb->len - oldlen;
 }
 
+ssize_t strbuf_read_noblock(struct strbuf *sb, int fd, size_t hint)
+{
+	size_t oldlen = sb->len;
+	size_t oldalloc = sb->alloc;
+
+	strbuf_grow(sb, hint ? hint : 8192);
+	for (;;) {
+		ssize_t cnt;
+
+		cnt = read(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+		if (cnt < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN)
+				break;
+			if (oldalloc == 0)
+				strbuf_release(sb);
+			else
+				strbuf_setlen(sb, oldlen);
+			return -1;
+		}
+		if (!cnt)
+			break;
+		sb->len += cnt;
+		strbuf_grow(sb, 8192);
+	}
+
+	sb->buf[sb->len] = '\0';
+	return sb->len - oldlen;
+}
+
 #define STRBUF_MAXLINK (2*PATH_MAX)
 
 int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
diff --git a/strbuf.h b/strbuf.h
index aef2794..7ea462b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -365,6 +365,7 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
  * any partial read is undone.
  */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
+extern ssize_t strbuf_read_noblock(struct strbuf *, int fd, size_t hint);
 
 /**
  * Read the contents of a file, specified by its path. The third argument
diff --git a/submodule.c b/submodule.c
index 1d64e57..a0e06e8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
+#include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
@@ -615,37 +616,79 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
+struct submodule_parallel_fetch {
+	int count;
+	struct argv_array args;
+	const char *work_tree;
+	const char *prefix;
+	int command_line_option;
+	int quiet;
+	int result;
+};
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
+
+int get_next_submodule(void *data, struct child_process *cp,
+		       struct strbuf *err);
+
+void handle_submodule_fetch_start_err(void *data, struct child_process *cp, struct strbuf *err)
+{
+	struct submodule_parallel_fetch *spf = data;
+	spf->result = 1;
+}
+
+void handle_submodule_fetch_finish( void *data, struct child_process *cp, int retvalue)
+{
+	struct submodule_parallel_fetch *spf = data;
+
+	if (retvalue)
+		spf->result = 1;
+}
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet)
+			       int quiet, int max_parallel_jobs)
 {
-	int i, result = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *work_tree = get_git_work_tree();
-	if (!work_tree)
+	int i;
+	struct submodule_parallel_fetch spf = SPF_INIT;
+	spf.work_tree = get_git_work_tree();
+	spf.command_line_option = command_line_option;
+	spf.quiet = quiet;
+	spf.prefix = prefix;
+	if (!spf.work_tree)
 		goto out;
 
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	argv_array_push(&argv, "fetch");
+	argv_array_push(&spf.args, "fetch");
 	for (i = 0; i < options->argc; i++)
-		argv_array_push(&argv, options->argv[i]);
-	argv_array_push(&argv, "--recurse-submodules-default");
+		argv_array_push(&spf.args, options->argv[i]);
+	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	cp.env = local_repo_env;
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-
 	calculate_changed_submodule_paths();
+	run_processes_parallel(max_parallel_jobs, &spf,
+			       get_next_submodule,
+			       handle_submodule_fetch_start_err,
+			       handle_submodule_fetch_finish);
+
+	argv_array_clear(&spf.args);
+out:
+	string_list_clear(&changed_submodule_paths, 1);
+	return spf.result;
+}
+
+int get_next_submodule(void *data, struct child_process *cp,
+		       struct strbuf *err)
+{
+	int ret = 0;
+	struct submodule_parallel_fetch *spf = data;
 
-	for (i = 0; i < active_nr; i++) {
+	for ( ; spf->count < active_nr; spf->count++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = active_cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
 
@@ -657,7 +700,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			submodule = submodule_from_name(null_sha1, ce->name);
 
 		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
+		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			if (submodule &&
 			    submodule->fetch_recurse !=
 						RECURSE_SUBMODULES_NONE) {
@@ -680,40 +723,46 @@ int fetch_populated_submodules(const struct argv_array *options,
 					default_argv = "on-demand";
 				}
 			}
-		} else if (command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
+		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
 			if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 				continue;
 			default_argv = "on-demand";
 		}
 
-		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
+		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
-		strbuf_addf(&submodule_prefix, "%s%s/", prefix, ce->name);
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
 		git_dir = read_gitfile(submodule_git_dir.buf);
 		if (!git_dir)
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
-			if (!quiet)
-				fprintf(stderr, "Fetching submodule %s%s\n", prefix, ce->name);
-			cp.dir = submodule_path.buf;
-			argv_array_push(&argv, default_argv);
-			argv_array_push(&argv, "--submodule-prefix");
-			argv_array_push(&argv, submodule_prefix.buf);
-			cp.argv = argv.argv;
-			if (run_command(&cp))
-				result = 1;
-			argv_array_pop(&argv);
-			argv_array_pop(&argv);
-			argv_array_pop(&argv);
+			child_process_init(cp);
+			cp->dir = strbuf_detach(&submodule_path, NULL);
+			cp->git_cmd = 1;
+			cp->no_stdout = 1;
+			cp->no_stdin = 1;
+			cp->stdout_to_stderr = 1;
+			cp->err = -1;
+			cp->env = local_repo_env;
+			if (!spf->quiet)
+				strbuf_addf(err, "Fetching submodule %s%s\n",
+					    spf->prefix, ce->name);
+			argv_array_init(&cp->args);
+			argv_array_pushv(&cp->args, spf->args.argv);
+			argv_array_push(&cp->args, default_argv);
+			argv_array_push(&cp->args, "--submodule-prefix");
+			argv_array_push(&cp->args, submodule_prefix.buf);
+			ret = 1;
 		}
 		strbuf_release(&submodule_path);
 		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
+		if (ret) {
+			spf->count++;
+			return 0;
+		}
 	}
-	argv_array_clear(&argv);
-out:
-	string_list_clear(&changed_submodule_paths, 1);
-	return result;
+	return 1;
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
diff --git a/submodule.h b/submodule.h
index 5507c3d..cbc0003 100644
--- a/submodule.h
+++ b/submodule.h
@@ -31,7 +31,7 @@ void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet);
+			       int quiet, int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 9acf628..37c89b9 100755
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
+	test-run-command run-command-async sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 17759b1..1b4ce69 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -71,6 +71,16 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules -j2 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	test_i18ncmp expect.err actual.err
+'
+
 test_expect_success "fetch alone only fetches superproject" '
 	add_upstream_commit &&
 	(
@@ -140,6 +150,15 @@ test_expect_success "--quiet propagates to submodules" '
 	! test -s actual.err
 '
 
+test_expect_success "--quiet propagates to parallel submodules" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules -j 2 --quiet  >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
 test_expect_success "--dry-run propagates to submodules" '
 	add_upstream_commit &&
 	(
diff --git a/test-run-command.c b/test-run-command.c
index 89c7de2..71fd3ca 100644
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
 
+	if (!strcmp(argv[1], "run-command-async"))
+		exit(run_processes_parallel(4, &proc, parallel_next,
+					 NULL, NULL));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
-- 
2.6.0.rc0.131.gf624c3d
