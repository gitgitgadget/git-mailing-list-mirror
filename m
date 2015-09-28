From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/8] fetch submodules in parallel
Date: Mon, 28 Sep 2015 16:13:58 -0700
Message-ID: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zghcr-00075C-C0
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbbI1XOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:23 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33722 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbbI1XOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:22 -0400
Received: by pacex6 with SMTP id ex6so186728495pac.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3YXN+tZUWU2vpFDMabnQVV1FelXp3CX2B5kfoK3eFFg=;
        b=lSmcl+3dSYjzxfgAk0vmHvi1amSBvUF8TdgInAE2m9quwXJ77Cnbfv5j1OxU1UyppX
         mBodHpQj6mFE9yQlnIK907HxsvWkLdpCfwhFW4HgbTo4LeY0gWYc82AKQZh9VZSSfv/+
         ur5Vth5L30EmD0Amk1l3oM+fxVjQeMJYcLMVuf8d4AOhpZI8X//8oGKfMQ/u780yJMAs
         XhGCJkHF72bE6b0DtJF0SvtgFnFtC9lye0w0glAM0xRuRc8YUWEQCwYBzBL82/lX8LeZ
         uHp/AN/w0iuZ17H2kpmjXB69mldcki0RSKKN5LBVp1rCvciucUZWYX+vldnjX+z8T5fi
         5ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3YXN+tZUWU2vpFDMabnQVV1FelXp3CX2B5kfoK3eFFg=;
        b=Zenpo3lB+xXAkzaaKMLOr03ZXT2/uINNJ/HMzEyxyGpJn1VXOwO5w2PmYERNA5HFpu
         0ZCZBVd5AzMyuV7klF7Ybddt/DWHh4FQEBTIQ5JtiWo6Zm7ViR6g+3oEyHe30hlonQAQ
         +JFdy4wsXbSrE3A5RFwEVt7GPA0sosKSDdSY2x3mL67i+60YUfN8gD2RkXCRXDnm/uTI
         +J9mdr6pfxz0dYJSq44rv8xvFN805T9zwk4sbYleS3JdJ9UeXVE+tc83Uj1jMwD9ISxW
         0Q2EiUiwgiVJ9VjqTuWUZiSAjvzdcwSoRgNSkcD7NwHHfqH2ieXZOd5WbWQPRgmSTdsy
         p+eQ==
X-Gm-Message-State: ALoCoQnAjaxWdolPbWmjhzF8kBdZfoYBzFu1Ti0iMdq6Zm70jqFr0ZhpDDnPZ+0xdaEi2bzjwZ9C
X-Received: by 10.66.222.70 with SMTP id qk6mr157947pac.68.1443482061357;
        Mon, 28 Sep 2015 16:14:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id bs3sm21445825pbd.89.2015.09.28.16.14.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278802>

Changes to v4: (diff below)
* Some functions wanted to be static (Thanks Ramsay!)
* The patch to factor out return code handling has been dropped as
  the return code handling is slightly different in finish_command and
  the parallel case.
* We can handle signals a bit more gracefully now.
* More documentation in run-command.h 
* I thought it is a good idea to introduce `sigchain_pop_common`.

Jonathan Nieder (1):
  submodule.c: write "Fetching submodule <foo>" to stderr

Stefan Beller (7):
  xread: poll on non blocking fds
  xread_nonblock: add functionality to read from fds without blocking
  strbuf: add strbuf_read_once to read without blocking
  sigchain: add command to pop all common signals
  run-command: add an asynchronous parallel child processor
  fetch_populated_submodules: use new parallel job processing
  submodules: allow parallel fetching, add tests and documentation

 Documentation/fetch-options.txt |   7 +
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 +
 git-compat-util.h               |   1 +
 run-command.c                   | 348 ++++++++++++++++++++++++++++++++++++++++
 run-command.h                   |  63 ++++++++
 sigchain.c                      |   9 ++
 sigchain.h                      |   1 +
 strbuf.c                        |  11 ++
 strbuf.h                        |   9 ++
 submodule.c                     | 127 +++++++++++----
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  20 +++
 t/t5526-fetch-submodules.sh     |  70 +++++---
 test-run-command.c              |  24 +++
 wrapper.c                       |  35 +++-
 16 files changed, 675 insertions(+), 64 deletions(-)

diff --git a/run-command.c b/run-command.c
index 494e1f8..df84985 100644
--- a/run-command.c
+++ b/run-command.c
@@ -234,35 +234,6 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
-static int determine_return_value(int wait_status,
-				  int *result,
-				  int *error_code,
-				  const char *argv0)
-{
-	if (WIFSIGNALED(wait_status)) {
-		*result = WTERMSIG(wait_status);
-		if (*result != SIGINT && *result != SIGQUIT)
-			error("%s died of signal %d", argv0, *result);
-		/*
-		 * This return value is chosen so that code & 0xff
-		 * mimics the exit code that a POSIX shell would report for
-		 * a program that died from this signal.
-		 */
-		*result += 128;
-	} else if (WIFEXITED(wait_status)) {
-		*result = WEXITSTATUS(wait_status);
-		/*
-		 * Convert special exit code when execvp failed.
-		 */
-		if (*result == 127) {
-			*result = -1;
-			*error_code = ENOENT;
-		}
-	} else
-		return -1;
-	return 0;
-}
-
 static int wait_or_whine(pid_t pid, const char *argv0)
 {
 	int status, code = -1;
@@ -275,12 +246,29 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 	if (waiting < 0) {
 		failed_errno = errno;
 		error("waitpid for %s failed: %s", argv0, strerror(errno));
+	} else if (waiting != pid) {
+		error("waitpid is confused (%s)", argv0);
+	} else if (WIFSIGNALED(status)) {
+		code = WTERMSIG(status);
+		if (code != SIGINT && code != SIGQUIT)
+			error("%s died of signal %d", argv0, code);
+		/*
+		 * This return value is chosen so that code & 0xff
+		 * mimics the exit code that a POSIX shell would report for
+		 * a program that died from this signal.
+		 */
+		code += 128;
+	} else if (WIFEXITED(status)) {
+		code = WEXITSTATUS(status);
+		/*
+		 * Convert special exit code when execvp failed.
+		 */
+		if (code == 127) {
+			code = -1;
+			failed_errno = ENOENT;
+		}
 	} else {
-		if (waiting != pid || (determine_return_value(status,
-							      &code,
-							      &failed_errno,
-							      argv0) < 0))
-			error("waitpid is confused (%s)", argv0);
+		error("waitpid is confused (%s)", argv0);
 	}
 
 	clear_child_for_cleanup(pid);
@@ -888,46 +876,67 @@ struct parallel_processes {
 	 */
 	struct pollfd *pfd;
 
+	unsigned shutdown : 1;
+
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
-};
+} parallel_processes_struct;
 
-void default_start_failure(void *data,
-			   struct child_process *cp,
-			   struct strbuf *err)
+static int default_start_failure(void *data,
+				 struct child_process *cp,
+				 struct strbuf *err)
 {
 	int i;
-	struct strbuf sb = STRBUF_INIT;
 
+	strbuf_addstr(err, "Starting a child failed:");
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(&sb, " %s", cp->argv[i]);
+		strbuf_addf(err, " %s", cp->argv[i]);
 
-	die_errno("Starting a child failed:%s", sb.buf);
+	return 0;
 }
 
-void default_return_value(void *data,
-			  struct child_process *cp,
-			  int result)
+static int default_return_value(void *data,
+				struct child_process *cp,
+				struct strbuf *err,
+				int result)
 {
 	int i;
-	struct strbuf sb = STRBUF_INIT;
 
 	if (!result)
-		return;
+		return 0;
 
+	strbuf_addf(err, "A child failed with return code %d:", result);
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(&sb, " %s", cp->argv[i]);
+		strbuf_addf(err, " %s", cp->argv[i]);
 
-	die_errno("A child failed with return code %d:%s", result, sb.buf);
+	return 0;
 }
 
-static void pp_init(struct parallel_processes *pp,
-					int n, void *data,
-					get_next_task_fn get_next_task,
-					start_failure_fn start_failure,
-					return_value_fn return_value)
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
 {
 	int i;
+	struct parallel_processes *pp = &parallel_processes_struct;
 
 	if (n < 1)
 		n = online_cpus();
@@ -952,6 +961,8 @@ static void pp_init(struct parallel_processes *pp,
 		pp->pfd[i].events = POLLIN;
 		pp->pfd[i].fd = -1;
 	}
+	sigchain_push_common(handle_children_on_signal);
+	return pp;
 }
 
 static void pp_cleanup(struct parallel_processes *pp)
@@ -964,6 +975,8 @@ static void pp_cleanup(struct parallel_processes *pp)
 	free(pp->children);
 	free(pp->pfd);
 	strbuf_release(&pp->buffered_output);
+
+	sigchain_pop_common();
 }
 
 static void set_nonblocking(int fd)
@@ -977,7 +990,12 @@ static void set_nonblocking(int fd)
 			"output will be degraded");
 }
 
-/* returns 1 if a process was started, 0 otherwise */
+/* returns
+ *  0 if a new task was started.
+ *  1 if no new jobs was started (get_next_task ran out of work, non critical
+ *    problem with starting a new command)
+ * -1 no new job was started, user wishes to shutdown early.
+ */
 static int pp_start_one(struct parallel_processes *pp)
 {
 	int i;
@@ -993,10 +1011,14 @@ static int pp_start_one(struct parallel_processes *pp)
 			       &pp->children[i].err))
 		return 1;
 
-	if (start_command(&pp->children[i].process))
-		pp->start_failure(pp->data,
-				  &pp->children[i].process,
-				  &pp->children[i].err);
+	if (start_command(&pp->children[i].process)) {
+		int code = pp->start_failure(pp->data,
+					     &pp->children[i].process,
+					     &pp->children[i].err);
+		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+		strbuf_reset(&pp->children[i].err);
+		return code ? -1 : 1;
+	}
 
 	set_nonblocking(pp->children[i].process.err);
 
@@ -1006,11 +1028,11 @@ static int pp_start_one(struct parallel_processes *pp)
 	return 0;
 }
 
-static void pp_buffer_stderr(struct parallel_processes *pp)
+static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 {
 	int i;
 
-	while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
+	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp);
@@ -1038,17 +1060,18 @@ static void pp_output(struct parallel_processes *pp)
 	}
 }
 
-static void pp_collect_finished(struct parallel_processes *pp)
+static int pp_collect_finished(struct parallel_processes *pp)
 {
 	int i = 0;
 	pid_t pid;
 	int wait_status, code;
 	int n = pp->max_processes;
+	int result = 0;
 
 	while (pp->nr_processes > 0) {
 		pid = waitpid(-1, &wait_status, WNOHANG);
 		if (pid == 0)
-			return;
+			return 0;
 
 		if (pid < 0)
 			die_errno("wait");
@@ -1064,12 +1087,38 @@ static void pp_collect_finished(struct parallel_processes *pp)
 				pp->children[i].process.err, 0) < 0)
 			die_errno("strbuf_read");
 
-		if (determine_return_value(wait_status, &code, &errno,
-					   pp->children[i].process.argv[0]) < 0)
-			error("waitpid is confused (%s)",
-			      pp->children[i].process.argv[0]);
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
 
-		pp->return_value(pp->data, &pp->children[i].process, code);
+		if (pp->return_value(pp->data, &pp->children[i].process,
+				     &pp->children[i].err, code))
+			result = 1;
 
 		argv_array_clear(&pp->children[i].process.args);
 		argv_array_clear(&pp->children[i].process.env_array);
@@ -1103,6 +1152,7 @@ static void pp_collect_finished(struct parallel_processes *pp)
 			pp->output_owner = (pp->output_owner + i) % n;
 		}
 	}
+	return result;
 }
 
 int run_processes_parallel(int n, void *data,
@@ -1110,21 +1160,43 @@ int run_processes_parallel(int n, void *data,
 			   start_failure_fn start_failure,
 			   return_value_fn return_value)
 {
-	struct parallel_processes pp;
-	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
+	int no_more_task = 0;
+	struct parallel_processes *pp;
 
+	pp = pp_init(n, data, get_next_task, start_failure, return_value);
 	while (1) {
-		while (pp.nr_processes < pp.max_processes &&
-		       !pp_start_one(&pp))
-			; /* nothing */
-		if (!pp.nr_processes)
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
 			break;
-		pp_buffer_stderr(&pp);
-		pp_output(&pp);
-		pp_collect_finished(&pp);
+		pp_buffer_stderr(pp, output_timeout);
+		pp_output(pp);
+		if (pp_collect_finished(pp)) {
+			kill_children(pp, SIGTERM);
+			pp->shutdown = 1;
+			no_more_task = 1;
+		}
 	}
 
-	pp_cleanup(&pp);
-
+	pp_cleanup(pp);
 	return 0;
 }
diff --git a/run-command.h b/run-command.h
index 3807fd1..1179cb0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -132,13 +132,36 @@ typedef int (*get_next_task_fn)(void *data,
 				struct child_process *cp,
 				struct strbuf *err);
 
-typedef void (*start_failure_fn)(void *data,
-				 struct child_process *cp,
-				 struct strbuf *err);
-
-typedef void (*return_value_fn)(void *data,
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
 				struct child_process *cp,
-				int result);
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
 
 /**
  * Runs up to n processes at the same time. Whenever a process can be
@@ -148,6 +171,10 @@ typedef void (*return_value_fn)(void *data,
  * The children started via this function run in parallel and their output
  * to stderr is buffered, while one of the children will directly output
  * to stderr.
+ *
+ * If start_failure_fn and return_value_fn are NULL, default handlers
+ * will be used. The default handlers will print an error message on
+ * error without issuing an emergency stop.
  */
 
 int run_processes_parallel(int n, void *data,
diff --git a/sigchain.c b/sigchain.c
index faa375d..9262307 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -50,3 +50,12 @@ void sigchain_push_common(sigchain_fun f)
 	sigchain_push(SIGQUIT, f);
 	sigchain_push(SIGPIPE, f);
 }
+
+void sigchain_pop_common(void)
+{
+	sigchain_pop(SIGINT);
+	sigchain_pop(SIGHUP);
+	sigchain_pop(SIGTERM);
+	sigchain_pop(SIGQUIT);
+	sigchain_pop(SIGPIPE);
+}
diff --git a/sigchain.h b/sigchain.h
index 618083b..138b20f 100644
--- a/sigchain.h
+++ b/sigchain.h
@@ -7,5 +7,6 @@ int sigchain_push(int sig, sigchain_fun f);
 int sigchain_pop(int sig);
 
 void sigchain_push_common(sigchain_fun f);
+void sigchain_pop_common(void);
 
 #endif /* SIGCHAIN_H */
diff --git a/submodule.c b/submodule.c
index fdaf3e4..7ab89f4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -630,18 +630,25 @@ struct submodule_parallel_fetch {
 int get_next_submodule(void *data, struct child_process *cp,
 		       struct strbuf *err);
 
-void handle_submodule_fetch_start_err(void *data, struct child_process *cp, struct strbuf *err)
+static int fetch_start_failure(void *data, struct child_process *cp,
+			       struct strbuf *err)
 {
 	struct submodule_parallel_fetch *spf = data;
+
 	spf->result = 1;
+
+	return 0;
 }
 
-void handle_submodule_fetch_finish( void *data, struct child_process *cp, int retvalue)
+static int fetch_finish(void *data, struct child_process *cp,
+			struct strbuf *err, int retvalue)
 {
 	struct submodule_parallel_fetch *spf = data;
 
 	if (retvalue)
 		spf->result = 1;
+
+	return 0;
 }
 
 int fetch_populated_submodules(const struct argv_array *options,
@@ -671,8 +678,8 @@ int fetch_populated_submodules(const struct argv_array *options,
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs, &spf,
 			       get_next_submodule,
-			       handle_submodule_fetch_start_err,
-			       handle_submodule_fetch_finish);
+			       fetch_start_failure,
+			       fetch_finish);
 
 	argv_array_clear(&spf.args);
 out:
diff --git a/test-run-command.c b/test-run-command.c
index 94c6eee..2555791 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -16,9 +16,9 @@
 #include <errno.h>
 
 static int number_callbacks;
-int parallel_next(void *data,
-		  struct child_process *cp,
-		  struct strbuf *err)
+static int parallel_next(void *data,
+			 struct child_process *cp,
+			 struct strbuf *err)
 {
 	struct child_process *d = data;
 	if (number_callbacks >= 4)


-- 
2.5.0.273.g6fa2560.dirty
