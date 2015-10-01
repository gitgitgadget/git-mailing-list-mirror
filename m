From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 0/8] fetch submodules in parallel
Date: Wed, 30 Sep 2015 18:54:08 -0700
Message-ID: <1443664456-1307-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 03:55:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhT5K-00006B-70
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 03:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbbJABya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 21:54:30 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34219 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbJABy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 21:54:29 -0400
Received: by padhy16 with SMTP id hy16so57625782pad.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=COINi1oHL7NdYQNp0d17fVi2kugRfKZSUT0g1UPm6gs=;
        b=U0mtWGn6GNqyJ8eyW1LFFVaGP0fJLxcF34xIr4SVdPWH+f0EWUwsI5PUXEINtZVFVu
         MgbI9vcr8DcyQPhH2/xtsCCJ1USP5IKmjp3EGrrngkWMdSh4ilIV6oAZIb7glrtlFlYh
         5nTDA0wkdZ3Nvggl5wdnvDpNTWEs3xNXQbz15X2MhFiPOgzGBHjfelVo5lYRfUArIHx4
         qtzg8TozOoApzr2EToUvPMciEmS6NRjJykbeiheFfZTVYspzzuZnJgI5zqeCihjgb3FT
         jzeQik+3svRRamx5CyJYjXeoba+1NMBAuaNOXQeVsOxEHdjVZzwCzSRY93WCNDiHz6yQ
         EDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=COINi1oHL7NdYQNp0d17fVi2kugRfKZSUT0g1UPm6gs=;
        b=fSL3Xgocfuh4wafOG8bxxi3W0Ha/+TrN0pNBMDugTpbS+VX5CzzKvo0DIeVnR0hKeo
         MfSQlp0uPgJ5dkzr9ZHm0DWs5IQe08qDPuy9RHbauL0L+B5pw78oh3gRivcOIeWzkPAN
         G0YKovAqJb548Bl+axhIczAZzdZSUA8zdlEe38M0SmSAZHR0/3khLP2c+qo3reD98AoP
         Dzyu8+JTwGYgQ1jsi9XEl9wctmndw6SEy3GS+uWT0+cEGHx146B/t6YY69/x1O+QtaO4
         ozdY0K8X29o9ETQ8NMixCPvj9ajVIvCFV6XxarZaSoZO/2P17g18Xe/17Lz4ScL2Yeb7
         Ohag==
X-Gm-Message-State: ALoCoQlwxeBFyXt5gpEoiKmpmKu7tWzzfvNQ7RZyI1ZBXjhbd3DkUN8/AcTih9rOOxVOAGkeO9Fr
X-Received: by 10.66.251.35 with SMTP id zh3mr8718727pac.121.1443664468419;
        Wed, 30 Sep 2015 18:54:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8d91:1679:adb7:b916])
        by smtp.gmail.com with ESMTPSA id qg2sm3060454pbb.80.2015.09.30.18.54.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 18:54:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gf20166c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278873>

This replaces sb/submodule-parallel-fetch once again.
Changes are only in patch 5,6,7
(5: reverse popping, 6: see below, 7: adapt to changes of 6).

Junio wrote:
> > +             if (pp->return_value(pp->data, &pp->children[i].process,
> > +                                  &pp->children[i].err, code))
> at this point, code can be uninitialized if we took the last "is
> confused" arm of the if/elseif cascade.

It's fixed in the reroll.

sigchain_pop_common reversed the popping.

When I started an office discussion with Jonathan about how to best implement
the next step ("git submodule update" using the parallel processing machine),
I fixes some nits and also some major spots:

* The order of the arguments for the callbacks (Generally the callback cookie
  comes last and is called `cb` and not `data`)
  
* renamed return_value_fn to task_finished_fn
  
* Add another callback cookie for task specific things. This will help in the
  rewrite of `git submodule update` as there are steps to be done after the
  some processes are done using the parallel engine. So we want to be able
  to remember specific children or tag information on them instead parsing the
  cp->argv.

* the main loop of the parallel processing was first adapted to Junios suggestion,
  but Jonathan pointed out more improvements.  We can get rid of `no_more_task`
  completely as `if (!pp->nr_processes)` as the exit condition is sufficient.
  (pp->nr_processes is modified only when starting or reaping a child, so we will
  capture the whole output of each subprocess even in case of a quick shutdown)

* even more accurate documentation

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
 run-command.c                   | 350 ++++++++++++++++++++++++++++++++++++++++
 run-command.h                   |  78 +++++++++
 sigchain.c                      |   9 ++
 sigchain.h                      |   1 +
 strbuf.c                        |  11 ++
 strbuf.h                        |   9 ++
 submodule.c                     | 129 +++++++++++----
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  20 +++
 t/t5526-fetch-submodules.sh     |  70 +++++---
 test-run-command.c              |  25 +++
 wrapper.c                       |  35 +++-
 16 files changed, 695 insertions(+), 64 deletions(-)
diff --git a/run-command.c b/run-command.c
index df84985..28048a7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -863,12 +863,13 @@ struct parallel_processes {
 
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
-	return_value_fn return_value;
+	task_finished_fn task_finished;
 
 	struct {
 		unsigned in_use : 1;
 		struct child_process process;
 		struct strbuf err;
+		void *data;
 	} *children;
 	/*
 	 * The struct pollfd is logically part of *children,
@@ -882,9 +883,10 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 } parallel_processes_struct;
 
-static int default_start_failure(void *data,
-				 struct child_process *cp,
-				 struct strbuf *err)
+static int default_start_failure(struct child_process *cp,
+				 struct strbuf *err,
+				 void *pp_cb,
+				 void *pp_task_cb)
 {
 	int i;
 
@@ -895,10 +897,11 @@ static int default_start_failure(void *data,
 	return 0;
 }
 
-static int default_return_value(void *data,
-				struct child_process *cp,
-				struct strbuf *err,
-				int result)
+static int default_task_finished(int result,
+				 struct child_process *cp,
+				 struct strbuf *err,
+				 void *pp_cb,
+				 void *pp_task_cb)
 {
 	int i;
 
@@ -930,10 +933,11 @@ static void handle_children_on_signal(int signo)
 	raise(signo);
 }
 
-static struct parallel_processes *pp_init(int n, void *data,
+static struct parallel_processes *pp_init(int n,
 					  get_next_task_fn get_next_task,
 					  start_failure_fn start_failure,
-					  return_value_fn return_value)
+					  task_finished_fn task_finished,
+					  void *data)
 {
 	int i;
 	struct parallel_processes *pp = &parallel_processes_struct;
@@ -948,7 +952,7 @@ static struct parallel_processes *pp_init(int n, void *data,
 	pp->get_next_task = get_next_task;
 
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
-	pp->return_value = return_value ? return_value : default_return_value;
+	pp->task_finished = task_finished ? task_finished : default_task_finished;
 
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
@@ -1006,15 +1010,17 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		die("BUG: bookkeeping is hard");
 
-	if (!pp->get_next_task(pp->data,
+	if (!pp->get_next_task(&pp->children[i].data,
 			       &pp->children[i].process,
-			       &pp->children[i].err))
+			       &pp->children[i].err,
+			       pp->data))
 		return 1;
 
 	if (start_command(&pp->children[i].process)) {
-		int code = pp->start_failure(pp->data,
-					     &pp->children[i].process,
-					     &pp->children[i].err);
+		int code = pp->start_failure(&pp->children[i].process,
+					     &pp->children[i].err,
+					     pp->data,
+					     &pp->children[i].data);
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 		strbuf_reset(&pp->children[i].err);
 		return code ? -1 : 1;
@@ -1110,14 +1116,16 @@ static int pp_collect_finished(struct parallel_processes *pp)
 				code = -1;
 				errno = ENOENT;
 			}
-		} else
+		} else {
 			strbuf_addf(&pp->children[i].err,
 				    "waitpid is confused (%s)",
 				    pp->children[i].process.argv[0]);
+			code = -1;
+		}
 
-
-		if (pp->return_value(pp->data, &pp->children[i].process,
-				     &pp->children[i].err, code))
+		if (pp->task_finished(code, &pp->children[i].process,
+				      &pp->children[i].err, pp->data,
+				      &pp->children[i].data))
 			result = 1;
 
 		argv_array_clear(&pp->children[i].process.args);
@@ -1155,45 +1163,39 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-int run_processes_parallel(int n, void *data,
+int run_processes_parallel(int n,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
-			   return_value_fn return_value)
+			   task_finished_fn task_finished,
+			   void *pp_cb)
 {
-	int no_more_task = 0;
+	int i;
+	int output_timeout = 100;
+	int spawn_cap = 4;
 	struct parallel_processes *pp;
 
-	pp = pp_init(n, data, get_next_task, start_failure, return_value);
+	pp = pp_init(n, get_next_task, start_failure, task_finished, pp_cb);
 	while (1) {
-		int i;
-		int output_timeout = 100;
-		int spawn_cap = 4;
-
-		if (!no_more_task) {
-			for (i = 0; i < spawn_cap; i++) {
-				int code;
-				if (pp->nr_processes == pp->max_processes)
-					break;
-
-				code = pp_start_one(pp);
-				if (!code)
-					continue;
-				if (code < 0) {
-					pp->shutdown = 1;
-					kill_children(pp, SIGTERM);
-				}
-				no_more_task = 1;
-				break;
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
 			}
+			break;
 		}
-		if (no_more_task && !pp->nr_processes)
+		if (!pp->nr_processes)
 			break;
 		pp_buffer_stderr(pp, output_timeout);
 		pp_output(pp);
 		if (pp_collect_finished(pp)) {
 			kill_children(pp, SIGTERM);
 			pp->shutdown = 1;
-			no_more_task = 1;
 		}
 	}
 
diff --git a/run-command.h b/run-command.h
index 1179cb0..c24aa54 100644
--- a/run-command.h
+++ b/run-command.h
@@ -121,16 +121,24 @@ int finish_async(struct async *async);
 
 /**
  * This callback should initialize the child process and preload the
- * error channel. The preloading of is useful if you want to have a message
- * printed directly before the output of the child process.
+ * error channel if desired. The preloading of is useful if you want to
+ * have a message printed directly before the output of the child process.
+ * pp_cb is the callback cookie as passed to run_processes_parallel.
+ * You can store a child process specific callback cookie in pp_task_cb.
+ *
  * You MUST set stdout_to_stderr.
  *
+ * Even after returning 0 to indicate that there are no more processes,
+ * this function will be called again until there are no more running
+ * child processes.
+ *
  * Return 1 if the next child is ready to run.
- * Return 0 if there are no more tasks to be processed.
+ * Return 0 if there are currently no more tasks to be processed.
  */
-typedef int (*get_next_task_fn)(void *data,
+typedef int (*get_next_task_fn)(void **pp_task_cb,
 				struct child_process *cp,
-				struct strbuf *err);
+				struct strbuf *err,
+				void *pp_cb);
 
 /**
  * This callback is called whenever there are problems starting
@@ -140,28 +148,35 @@ typedef int (*get_next_task_fn)(void *data,
  * message to the strbuf err instead, which will be printed without
  * messing up the output of the other parallel processes.
  *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
  * Return 0 to continue the parallel processing. To abort gracefully,
  * return non zero.
  */
-typedef int (*start_failure_fn)(void *data,
-				struct child_process *cp,
-				struct strbuf *err);
+typedef int (*start_failure_fn)(struct child_process *cp,
+				struct strbuf *err,
+				void *pp_cb,
+				void *pp_task_cb);
 
 /**
- * This callback is called on every there are problems starting
- * a new process.
+ * This callback is called on every child process that finished processing.
  *
  * You must not write to stdout or stderr in this function. Add your
  * message to the strbuf err instead, which will be printed without
  * messing up the output of the other parallel processes.
  *
+ * pp_cb is the callback cookie as passed into run_processes_parallel,
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ *
  * Return 0 to continue the parallel processing. To abort gracefully,
  * return non zero.
  */
-typedef int (*return_value_fn)(void *data,
-			       struct child_process *cp,
-			       struct strbuf *err,
-			       int result);
+typedef int (*task_finished_fn)(int result,
+				struct child_process *cp,
+				struct strbuf *err,
+				void *pp_cb,
+				void *pp_task_cb);
 
 /**
  * Runs up to n processes at the same time. Whenever a process can be
@@ -176,10 +191,10 @@ typedef int (*return_value_fn)(void *data,
  * will be used. The default handlers will print an error message on
  * error without issuing an emergency stop.
  */
-
-int run_processes_parallel(int n, void *data,
+int run_processes_parallel(int n,
 			   get_next_task_fn,
 			   start_failure_fn,
-			   return_value_fn);
+			   task_finished_fn,
+			   void *pp_cb);
 
 #endif
diff --git a/sigchain.c b/sigchain.c
index 9262307..2ac43bb 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -53,9 +53,9 @@ void sigchain_push_common(sigchain_fun f)
 
 void sigchain_pop_common(void)
 {
-	sigchain_pop(SIGINT);
-	sigchain_pop(SIGHUP);
-	sigchain_pop(SIGTERM);
-	sigchain_pop(SIGQUIT);
 	sigchain_pop(SIGPIPE);
+	sigchain_pop(SIGQUIT);
+	sigchain_pop(SIGTERM);
+	sigchain_pop(SIGHUP);
+	sigchain_pop(SIGINT);
 }
diff --git a/submodule.c b/submodule.c
index 7ab89f4..cf8bf5d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -627,23 +627,24 @@ struct submodule_parallel_fetch {
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
 
-int get_next_submodule(void *data, struct child_process *cp,
-		       struct strbuf *err);
+static int get_next_submodule(void **task_cb, struct child_process *cp,
+			      struct strbuf *err, void *data);
 
-static int fetch_start_failure(void *data, struct child_process *cp,
-			       struct strbuf *err)
+static int fetch_start_failure(struct child_process *cp,
+			       struct strbuf *err,
+			       void *cb, void *task_cb)
 {
-	struct submodule_parallel_fetch *spf = data;
+	struct submodule_parallel_fetch *spf = cb;
 
 	spf->result = 1;
 
 	return 0;
 }
 
-static int fetch_finish(void *data, struct child_process *cp,
-			struct strbuf *err, int retvalue)
+static int fetch_finish(int retvalue, struct child_process *cp,
+			struct strbuf *err, void *cb, void *task_cb)
 {
-	struct submodule_parallel_fetch *spf = data;
+	struct submodule_parallel_fetch *spf = cb;
 
 	if (retvalue)
 		spf->result = 1;
@@ -676,10 +677,11 @@ int fetch_populated_submodules(const struct argv_array *options,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths();
-	run_processes_parallel(max_parallel_jobs, &spf,
+	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
-			       fetch_finish);
+			       fetch_finish,
+			       &spf);
 
 	argv_array_clear(&spf.args);
 out:
@@ -687,8 +689,8 @@ out:
 	return spf.result;
 }
 
-int get_next_submodule(void *data, struct child_process *cp,
-		       struct strbuf *err)
+static int get_next_submodule(void **task_cb, struct child_process *cp,
+			      struct strbuf *err, void *data)
 {
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
diff --git a/test-run-command.c b/test-run-command.c
index 2555791..699d9e9 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -16,11 +16,12 @@
 #include <errno.h>
 
 static int number_callbacks;
-static int parallel_next(void *data,
+static int parallel_next(void** task_cb,
 			 struct child_process *cp,
-			 struct strbuf *err)
+			 struct strbuf *err,
+			 void *cb)
 {
-	struct child_process *d = data;
+	struct child_process *d = cb;
 	if (number_callbacks >= 4)
 		return 0;
 
@@ -51,8 +52,8 @@ int main(int argc, char **argv)
 		exit(run_command(&proc));
 
 	if (!strcmp(argv[1], "run-command-parallel-4"))
-		exit(run_processes_parallel(4, &proc, parallel_next,
-					 NULL, NULL));
+		exit(run_processes_parallel(4, parallel_next,
+					    NULL, NULL, &proc));
 
 	fprintf(stderr, "check usage\n");
 	return 1;

-- 
2.5.0.275.gf20166c.dirty
