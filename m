From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] fetch submodules in parallel
Date: Mon, 14 Sep 2015 14:50:50 -0700
Message-ID: <1442267451-2527-1-git-send-email-sbeller@google.com>
References: <20150914180759.GA11920@sigill.intra.peff.net>
Cc: peff@peff.net, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 14 23:51:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbbeT-00061w-Pu
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 23:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbbINVu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 17:50:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32939 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbbINVu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 17:50:57 -0400
Received: by pacex6 with SMTP id ex6so155076884pac.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 14:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oHKki1KnWdX7qL+SIyGA5pXM698uNxU8m1Z1pWTpx+c=;
        b=DGiPjBb3eQ38crGJAKaUUBxjdn/Yx2yfkFEMGJpPIbk43qfjA/BL9m05Gqcarc8m1Q
         c/7+YxpvZCODc6s77aWr5/STRZ1MNVwuLYH15UhZE2RfBNWpI0Rm/25CvxKBbNePXPc8
         JrvPgDPgvykY31hDocgb0qRzBb74DAIu3pkuTKh6Z3UtTpuT/sLtYOsEKNqbZYu2mzrI
         UDsOlX6vKwEfIsbyH0fvt74Ms+nnF+9+ozotG/YaMcCvd7iXVzGMTbD80MfJ7PccxxYs
         Da/R7FPsMLPcbd9S//iIG0ZiMH+LlLIl5eCfEqaCLb7+3IFHBBqb13mTpNJHczG8NNAo
         x4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oHKki1KnWdX7qL+SIyGA5pXM698uNxU8m1Z1pWTpx+c=;
        b=mfKVtUrbX5/E/y3saY8Qnve3HbcYEzG+xMrFcGeB7fMsUtcBTk4IurVjcTP47U0Lwi
         JLAclk7buDOZbxQyhaNckB8hdFgESzUe93kFu/TwZjW9L7nok0gPMUmNBcMTcnv/3evz
         t69seawwRyzeABL3wJQI6u2aQEdtmzOktXIg9GWox2boMDPQ6Hc8V4e3mCDdsXMHSZ7h
         3vuTdU3MkNwWmRkjmVGRs7tpaHJYoOwxXQ+q5usZoxmq6M0HylcumXi65jN39TJBh4sf
         M4MlpiW3WX9LKwboIrS6v2nnC9MKZzISZnFs+2OUk+/JCEDX8RGGydoEvSacUyA5RULP
         n2kg==
X-Gm-Message-State: ALoCoQnBTdPiI/X83KoWgDvtVMJV5/1Usv3rKpK1Ab2eJgQSr5ihhmUj2QynXuXZwt/1qs6nOQ2N
X-Received: by 10.66.157.137 with SMTP id wm9mr40064891pab.30.1442267456379;
        Mon, 14 Sep 2015 14:50:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6c13:6ad3:5771:36ec])
        by smtp.gmail.com with ESMTPSA id fu4sm17991556pbb.59.2015.09.14.14.50.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 14:50:55 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <20150914180759.GA11920@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277867>

This replaces the last patch of the "Parallel git submodule fetching"
series. Changes:

* have correct return code in submodule fetching when one submodule fails
* use poll instead of select now
* broke down into more smaller functions instead of one giant.
  (I think it is an improvement, but I wouldn't be surprised if someone objects)
* closed memory leaks
* document the need for stdout_to_stderr

I don't deem it RFC-ish any more but good to go.

Any feedback welcome!
Thanks,
Stefan


Stefan Beller (1):
  fetch: fetch submodules in parallel

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

Interdiff to RFCv1:

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index d432f98..6b109f6 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -105,7 +105,7 @@ ifndef::git-pull[]
 	Number of parallel children to be used for fetching submodules.
 	Each will fetch from different submodules, such that fetching many
 	submodules will be faster. By default submodules will be fetched
-	one at a time
+	one at a time.
 
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a1520bb..f28eac6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -101,7 +101,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
 	OPT_INTEGER('j', "jobs", &max_children,
-		    N_("number of threads used for fetching")),
+		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
diff --git a/builtin/pull.c b/builtin/pull.c
index bc117e9..f0af196 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -179,7 +179,7 @@ static struct option pull_options[] = {
 		N_("control recursive fetching of submodules"),
 		PARSE_OPT_OPTARG),
 	OPT_PASSTHRU('j', "jobs", &max_children, N_("n"),
-		N_("number of threads used for fetching submodules"),
+		N_("number of submodules pulled in parallel"),
 		PARSE_OPT_OPTARG),
 	OPT_BOOL(0, "dry-run", &opt_dry_run,
 		N_("dry run")),
diff --git a/run-command.c b/run-command.c
index b8ff67b..6f6f9fb 100644
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
@@ -853,146 +863,226 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	return finish_command(cmd);
 }
 
-int run_processes_async(int n, get_next_task fn, void *data)
+static void unblock_fd(int fd)
 {
-	int i, wait_status;
-	pid_t pid;
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
 
-	/* no more tasks. Also set when aborting early. */
-	int all_tasks_started = 0;
-	int nr_processes = 0;
-	int child_in_foreground = 0;
-	struct timeval timeout;
-	struct child_process *children = xcalloc(n, sizeof(*children));
-	char *slots = xcalloc(n, sizeof(*slots));
-	struct strbuf *err = xcalloc(n, sizeof(*err));
-	fd_set fdset;
-	int maxfd;
-	struct strbuf finished_children = STRBUF_INIT;
-	int flags;
-	for (i = 0; i < n; i++)
-		strbuf_init(&err[i], 0);
-
-	while (!all_tasks_started || nr_processes > 0) {
-		/* Start new processes. */
-		while (!all_tasks_started && nr_processes < n) {
-			for (i = 0; i < n; i++)
-				if (!slots[i])
-					break; /* found an empty slot */
-			if (i == n)
-				die("BUG: bookkeeping is hard");
-
-			if (fn(data, &children[i], &err[i])) {
-				all_tasks_started = 1;
-				break;
-			}
-			if (start_command(&children[i]))
-				die(_("Could not start child process"));
-			flags = fcntl(children[i].err, F_GETFL);
-			fcntl(children[i].err, F_SETFL, flags | O_NONBLOCK);
-			nr_processes++;
-			slots[i] = 1;
-		}
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
 
-		/* prepare data for select call */
-		FD_ZERO(&fdset);
-		maxfd = 0;
-		for (i = 0; i < n; i++) {
-			if (!slots[i])
-				continue;
-			FD_SET(children[i].err, &fdset);
-			if (children[i].err > maxfd)
-				maxfd = children[i].err;
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
 		}
-		timeout.tv_sec = 0;
-		timeout.tv_usec = 500000;
+		if (start_command(&pp->children[i]))
+			pp->fn_err(pp->data, &pp->children[i], &pp->err[i]);
 
-		i = select(maxfd + 1, &fdset, NULL, NULL, &timeout);
-		if (i < 0) {
-			if (errno == EINTR)
-				/* A signal was caught; try again */
-				continue;
-			else if (errno == ENOMEM)
-				die_errno("BUG: keeping track of fds is hard");
-			else if (errno == EINVAL)
-				die_errno("BUG: invalid arguments to select");
-			else if (errno == EBADF)
-				die_errno("BUG: keeping track of fds is hard");
-			else
-				die_errno("Unknown error with select");
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
 		}
+	}
 
-		/* Buffer output from all pipes. */
-		for (i = 0; i < n; i++) {
-			if (!slots[i])
-				continue;
-			if (FD_ISSET(children[i].err, &fdset))
-				strbuf_read_noblock(&err[i], children[i].err, 0);
-			if (child_in_foreground == i) {
-				fputs(err[i].buf, stderr);
-				strbuf_reset(&err[i]);
-				fflush(stderr);
-			}
+	/* Buffer output from all pipes. */
+	for (i = 0; i < pp->max_number_processes; i++) {
+		if (!pp->slots[i])
+			continue;
+		if (pp->pfd[i].revents & POLLIN)
+			strbuf_read_noblock(&pp->err[i], pp->children[i].err, 0);
+		if (pp->foreground_child == i) {
+			fputs(pp->err[i].buf, stderr);
+			strbuf_reset(&pp->err[i]);
 		}
+	}
+	return 0;
+}
 
-		/* Collect finished child processes. */
-		while (nr_processes > 0) {
-			pid = waitpid(-1, &wait_status, WNOHANG);
-			if (pid == 0)
-				/* no child finished */
-				break;
-
-			if (pid < 0) {
-				if (errno == EINTR)
-					break; /* just try again  next time */
-				if (errno == EINVAL || errno == ECHILD)
-					die_errno("wait");
-			} else {
-				/* Find the finished child. */
-				for (i = 0; i < n; i++)
-					if (slots[i] && pid == children[i].pid)
-						break;
-				if (i == n)
-					/* waitpid returned another process id which
-					 * we are not waiting on, so ignore it*/
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
 					break;
-			}
+			if (i == pp->max_number_processes)
+				/*
+				 * waitpid returned another process id
+				 * which we are not waiting for.
+				 */
+				return;
+		}
+		strbuf_read_noblock(&pp->err[i], pp->children[i].err, 0);
 
-			strbuf_read_noblock(&err[i], children[i].err, 0);
-			argv_array_clear(&children[i].args);
-			argv_array_clear(&children[i].env_array);
+		if (determine_return_value(wait_status, &code, &errno,
+					   pp->children[i].argv[0]) < 0)
+			error("waitpid is confused (%s)",
+			      pp->children[i].argv[0]);
 
-			slots[i] = 0;
-			nr_processes--;
+		pp->fn_exit(pp->data, &pp->children[i], code);
 
-			if (i != child_in_foreground) {
-				strbuf_addbuf(&finished_children, &err[i]);
-				strbuf_reset(&err[i]);
-			} else {
-				fputs(err[i].buf, stderr);
-				strbuf_reset(&err[i]);
+		argv_array_clear(&pp->children[i].args);
+		argv_array_clear(&pp->children[i].env_array);
 
-				/* Output all other finished child processes */
-				fputs(finished_children.buf, stderr);
-				strbuf_reset(&finished_children);
+		pp->nr_processes--;
+		pp->slots[i] = 0;
+		pp->pfd[i].fd = -1;
 
-				/*
-				 * Pick next process to output live.
-				 * There can be no active process if n==1
-				 * NEEDSWORK:
-				 * For now we pick it randomly by doing a round
-				 * robin. Later we may want to pick the one with
-				 * the most output or the longest or shortest
-				 * running process time.
-				 */
-				for (i = 0; i < n; i++)
-					if (slots[(child_in_foreground + i) % n])
-						break;
-				child_in_foreground = (child_in_foreground + i) % n;
-				fputs(err[child_in_foreground].buf, stderr);
-				strbuf_reset(&err[child_in_foreground]);
-			}
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
 		}
 	}
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
 	return 0;
 }
diff --git a/run-command.h b/run-command.h
index 8f53ad6..0487f71 100644
--- a/run-command.h
+++ b/run-command.h
@@ -120,32 +120,39 @@ int start_async(struct async *async);
 int finish_async(struct async *async);
 
 /**
- * Return 0 if the next child is ready to run.
- * This callback takes care to initialize the child process and preload the
- * out and error channel. The preloading of these outpout channels is useful
- * if you want to have a message printed directly before the output of the
- * child process.
+ * This callback should initialize the child process and preload the
+ * error channel. The preloading of is useful if you want to have a message
+ * printed directly before the output of the child process.
+ * You MUST set stdout_to_stderr.
  *
+ * Return 0 if the next child is ready to run.
  * Return != 0 if there are no more tasks to be processed.
  */
 typedef int (*get_next_task)(void *data,
 			     struct child_process *cp,
 			     struct strbuf *err);
 
+typedef void (*handle_child_starting_failure)(void *data,
+					      struct child_process *cp,
+					      struct strbuf *err);
+
+typedef void (*handle_child_return_value)(void *data,
+					  struct child_process *cp,
+					  int result);
+
 /**
- * Runs up to n processes at the same time. Whenever a process can
- * be started, the callback `get_next_task` is called to obtain the
- * data fed to the child process.
+ * Runs up to n processes at the same time. Whenever a process can be
+ * started, the callback `get_next_task` is called to obtain the data
+ * fed to the child process.
  *
  * The children started via this function run in parallel and their output
- * to both stdout and stderr is buffered, while one of the children will
- * directly output to stdout/stderr.
- *
- * This leads to a problem with output from processes which put out to
- * stdout/err alternatingly as the buffering will not be able to replay
- * the
+ * to stderr is buffered, while one of the children will directly output
+ * to stderr.
  */
 
-int run_processes_async(int n, get_next_task fn, void *data);
+int run_processes_parallel(int n, void *data,
+			   get_next_task fn,
+			   handle_child_starting_failure,
+			   handle_child_return_value);
 
 #endif
diff --git a/submodule.c b/submodule.c
index 6d757c6..a0e06e8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -623,17 +623,32 @@ struct submodule_parallel_fetch {
 	const char *prefix;
 	int command_line_option;
 	int quiet;
+	int result;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL}
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
 
 int get_next_submodule(void *data, struct child_process *cp,
 		       struct strbuf *err);
 
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
 			       int quiet, int max_parallel_jobs)
 {
-	int i, result = 0;
+	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
 	spf.work_tree = get_git_work_tree();
 	spf.command_line_option = command_line_option;
@@ -652,12 +667,15 @@ int fetch_populated_submodules(const struct argv_array *options,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths();
-	run_processes_async(max_parallel_jobs, get_next_submodule, &spf);
+	run_processes_parallel(max_parallel_jobs, &spf,
+			       get_next_submodule,
+			       handle_submodule_fetch_start_err,
+			       handle_submodule_fetch_finish);
 
 	argv_array_clear(&spf.args);
 out:
 	string_list_clear(&changed_submodule_paths, 1);
-	return result;
+	return spf.result;
 }
 
 int get_next_submodule(void *data, struct child_process *cp,
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 0970fb0..37c89b9 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -48,18 +48,22 @@ test_expect_success POSIXPERM,SANITY 'unreadable directory in PATH' '
 '
 
 cat >expect <<-EOF
-Now running instance 0
-Hello World
-Now running instance 1
-Hello World
-Now running instance 2
-Hello World
-Now running instance 3
-Hello World
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
 EOF
 
 test_expect_success 'run_command runs in parallel' '
-	test-run-command run-command-async sh -c "echo Hello World >&2;" 2>actual &&
+	test-run-command run-command-async sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
diff --git a/test-run-command.c b/test-run-command.c
index 4817f6e..71fd3ca 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -16,9 +16,9 @@
 #include <errno.h>
 
 static int number_callbacks;
-int run_processes_async_next(void *data,
-			     struct child_process *cp,
-			     struct strbuf *err)
+int parallel_next(void *data,
+		  struct child_process *cp,
+		  struct strbuf *err)
 {
 	struct child_process *d = data;
 	if (number_callbacks >= 4)
@@ -28,7 +28,7 @@ int run_processes_async_next(void *data,
 	cp->stdout_to_stderr = 1;
 	cp->no_stdin = 1;
 	cp->err = -1;
-	strbuf_addf(err, "Now running instance %d\n", number_callbacks);
+	strbuf_addf(err, "preloaded output of a child\n");
 	number_callbacks++;
 	return 0;
 }
@@ -51,7 +51,8 @@ int main(int argc, char **argv)
 		exit(run_command(&proc));
 
 	if (!strcmp(argv[1], "run-command-async"))
-		exit(run_processes_async(4, run_processes_async_next, &proc));
+		exit(run_processes_parallel(4, &proc, parallel_next,
+					 NULL, NULL));
 
 	fprintf(stderr, "check usage\n");
 	return 1;

-- 
2.6.0.rc0.131.gf624c3d
