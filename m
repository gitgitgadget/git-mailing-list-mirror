From: Johannes Sixt <j6t@kdbg.org>
Subject: sb/submodule-parallel-fetch, was: Re: What's cooking in git.git (Dec
 2015, #03; Thu, 10)
Date: Fri, 11 Dec 2015 22:37:11 +0100
Message-ID: <566B4207.8020009@kdbg.org>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
 <xmqqvb85g8v9.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY8M-Xv1s4-s7HnjxZ_X19SR4PsWMtQ3yogqN=vjDiMwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 22:37:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7VNT-0000fK-9D
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 22:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbbLKVhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 16:37:17 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:35645 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbbLKVhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 16:37:16 -0500
X-Greylist: delayed 139739 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2015 16:37:15 EST
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pHQS84xH2z5tlK;
	Fri, 11 Dec 2015 22:37:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0C07B538D;
	Fri, 11 Dec 2015 22:37:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <CAGZ79kY8M-Xv1s4-s7HnjxZ_X19SR4PsWMtQ3yogqN=vjDiMwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282279>

Am 11.12.2015 um 00:55 schrieb Stefan Beller:
> On Thu, Dec 10, 2015 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> * sb/submodule-parallel-fetch (2015-11-24) 17 commits
>>>> ...
>>>
>>> I assume you plan on merging this after 2.7 settled and then we can
>>> also get the above sb/submodule-parallel-update going again.
>>
>> Yeah, thanks for reminding me.  I think that would be a good plan
>> that gives us an opportunity to clean up this topic, some parts of
>> which are have "an early patch that was too hastily merged to 'next'
>> had to be tweaked by an 'oops' follow-up patch in the topic"
>> pattern, e.g. "make waitpid the secondary and closed pipe the
>> primary way to monitor children".
>>
>> Thanks.
> 
> This makes it sound as if you would drop it from next once 2.7 is out,
> expecting a complete reroll, which does the right thing from the beginning?
> That was not was I was expecting, but thanks for clarifying.

Also, rebuilding the topic such that it takes the direct route to its
current state would help bisectability on Windows.

Generally, I'm already quite satisfied with the state of the
infrastructure at the tip of the branch.

Nevertheless, I have a few niggles.

The primary one is that we are using a global variable of type
struct parallel_processes to keep track of the processes. Fortunately,
most functions already take a pointer (I gather you did anticipate an
object oriented use of the functions). The only exception is pp_init():
It returns a pointer to the global object, which is then passed around
to the other functions. This does not conform to our usual style,
however, where the initializer function takes a pointer to the object,
too.

After converting pp_init, we can have a nicely object oriented
collection of functions and get rid of the global object ... almost.

We still need a global variable for the signal handler. But since
signals and their handlers are a global resource, it is not that bad to
have a global variable that is dedicated to signal handling.

Another small nit is that I found it confusing that the closure
parameters are arranged differently in the callback functions. Granted,
in get_next_task one of them is an out parameter, but that is actually
an argument to move it to the end of the parameter list, IMHO.

On top of that I found an error or two in the documentation, and I have
a few suggestions for improvements.

All this is summarized in the patch below.

diff --git a/run-command.c b/run-command.c
index db4d916..f3addb9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -864,7 +864,7 @@ enum child_state {
 	GIT_CP_WAIT_CLEANUP,
 };
 
-static struct parallel_processes {
+struct parallel_processes {
 	void *data;
 
 	int max_processes;
@@ -890,7 +890,7 @@ static struct parallel_processes {
 
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
-} parallel_processes_struct;
+};
 
 static int default_start_failure(struct child_process *cp,
 				 struct strbuf *err,
@@ -933,23 +933,23 @@ static void kill_children(struct parallel_processes *pp, int signo)
 			kill(pp->children[i].process.pid, signo);
 }
 
+static struct parallel_processes *pp_for_signal;
+
 static void handle_children_on_signal(int signo)
 {
-	struct parallel_processes *pp = &parallel_processes_struct;
-
-	kill_children(pp, signo);
+	kill_children(pp_for_signal, signo);
 	sigchain_pop(signo);
 	raise(signo);
 }
 
-static struct parallel_processes *pp_init(int n,
-					  get_next_task_fn get_next_task,
-					  start_failure_fn start_failure,
-					  task_finished_fn task_finished,
-					  void *data)
+static void pp_init(struct parallel_processes *pp,
+		    int n,
+		    get_next_task_fn get_next_task,
+		    start_failure_fn start_failure,
+		    task_finished_fn task_finished,
+		    void *data)
 {
 	int i;
-	struct parallel_processes *pp = &parallel_processes_struct;
 
 	if (n < 1)
 		n = online_cpus();
@@ -976,8 +976,9 @@ static struct parallel_processes *pp_init(int n,
 		pp->pfd[i].events = POLLIN | POLLHUP;
 		pp->pfd[i].fd = -1;
 	}
+
+	pp_for_signal = pp;
 	sigchain_push_common(handle_children_on_signal);
-	return pp;
 }
 
 static void pp_cleanup(struct parallel_processes *pp)
@@ -1019,10 +1020,10 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		die("BUG: bookkeeping is hard");
 
-	code = pp->get_next_task(&pp->children[i].data,
-				 &pp->children[i].process,
+	code = pp->get_next_task(&pp->children[i].process,
 				 &pp->children[i].err,
-				 pp->data);
+				 pp->data,
+				 &pp->children[i].data);
 	if (!code) {
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 		strbuf_reset(&pp->children[i].err);
@@ -1153,35 +1154,35 @@ int run_processes_parallel(int n,
 	int i, code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
-	struct parallel_processes *pp;
+	struct parallel_processes pp;
 
-	pp = pp_init(n, get_next_task, start_failure, task_finished, pp_cb);
+	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
 	while (1) {
 		for (i = 0;
-		    i < spawn_cap && !pp->shutdown &&
-		    pp->nr_processes < pp->max_processes;
+		    i < spawn_cap && !pp.shutdown &&
+		    pp.nr_processes < pp.max_processes;
 		    i++) {
-			code = pp_start_one(pp);
+			code = pp_start_one(&pp);
 			if (!code)
 				continue;
 			if (code < 0) {
-				pp->shutdown = 1;
-				kill_children(pp, -code);
+				pp.shutdown = 1;
+				kill_children(&pp, -code);
 			}
 			break;
 		}
-		if (!pp->nr_processes)
+		if (!pp.nr_processes)
 			break;
-		pp_buffer_stderr(pp, output_timeout);
-		pp_output(pp);
-		code = pp_collect_finished(pp);
+		pp_buffer_stderr(&pp, output_timeout);
+		pp_output(&pp);
+		code = pp_collect_finished(&pp);
 		if (code) {
-			pp->shutdown = 1;
+			pp.shutdown = 1;
 			if (code < 0)
-				kill_children(pp, -code);
+				kill_children(&pp, -code);
 		}
 	}
 
-	pp_cleanup(pp);
+	pp_cleanup(&pp);
 	return 0;
 }
diff --git a/run-command.h b/run-command.h
index 414cc81..a4745b0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -126,8 +126,6 @@ int finish_async(struct async *async);
  * pp_cb is the callback cookie as passed to run_processes_parallel.
  * You can store a child process specific callback cookie in pp_task_cb.
  *
- * You MUST set stdout_to_stderr.
- *
  * Even after returning 0 to indicate that there are no more processes,
  * this function will be called again until there are no more running
  * child processes.
@@ -135,12 +133,12 @@ int finish_async(struct async *async);
  * Return 1 if the next child is ready to run.
  * Return 0 if there are currently no more tasks to be processed.
  * To send a signal to other child processes for abortion,
- * return negative signal code.
+ * return the negative signal number.
  */
-typedef int (*get_next_task_fn)(void **pp_task_cb,
-				struct child_process *cp,
+typedef int (*get_next_task_fn)(struct child_process *cp,
 				struct strbuf *err,
-				void *pp_cb);
+				void *pp_cb,
+				void **pp_task_cb);
 
 /**
  * This callback is called whenever there are problems starting
@@ -155,7 +153,7 @@ typedef int (*get_next_task_fn)(void **pp_task_cb,
  *
  * Return 0 to continue the parallel processing. To abort return non zero.
  * To send a signal to other child processes for abortion, return
- * negative signal code.
+ * the negative signal number.
  */
 typedef int (*start_failure_fn)(struct child_process *cp,
 				struct strbuf *err,
@@ -174,7 +172,7 @@ typedef int (*start_failure_fn)(struct child_process *cp,
  *
  * Return 0 to continue the parallel processing.  To abort return non zero.
  * To send a signal to other child processes for abortion, return
- * negative signal code.
+ * the negative signal number.
  */
 typedef int (*task_finished_fn)(int result,
 				struct child_process *cp,
@@ -184,14 +182,14 @@ typedef int (*task_finished_fn)(int result,
 
 /**
  * Runs up to n processes at the same time. Whenever a process can be
- * started, the callback `get_next_task` is called to obtain the data
- * fed to the child process.
+ * started, the callback get_next_task_fn is called to obtain the data
+ * required to start another child process.
  *
- * The children started via this function run in parallel and their output
- * to stderr is buffered, while one of the children will directly output
- * to stderr.
+ * The children started via this function run in parallel. Their output
+ * (both stdout and stderr) is routed to stderr in a manner that output
+ * from different tasks does not interleave.
  *
- * If start_failure_fn and return_value_fn are NULL, default handlers
+ * If start_failure_fn or task_finished_fn are NULL, default handlers
  * will be used. The default handlers will print an error message on
  * error without issuing an emergency stop.
  */
diff --git a/submodule.c b/submodule.c
index 281bccd..00b7c4a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -627,8 +627,8 @@ struct submodule_parallel_fetch {
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
 
-static int get_next_submodule(void **task_cb, struct child_process *cp,
-			      struct strbuf *err, void *data)
+static int get_next_submodule(struct child_process *cp,
+			      struct strbuf *err, void *data, void **task_cb)
 {
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
diff --git a/test-run-command.c b/test-run-command.c
index b1f04d1..f964507 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -16,10 +16,10 @@
 #include <errno.h>
 
 static int number_callbacks;
-static int parallel_next(void** task_cb,
-			 struct child_process *cp,
+static int parallel_next(struct child_process *cp,
 			 struct strbuf *err,
-			 void *cb)
+			 void *cb,
+			 void** task_cb)
 {
 	struct child_process *d = cb;
 	if (number_callbacks >= 4)
@@ -31,10 +31,10 @@ static int parallel_next(void** task_cb,
 	return 1;
 }
 
-static int no_job(void** task_cb,
-		  struct child_process *cp,
+static int no_job(struct child_process *cp,
 		  struct strbuf *err,
-		  void *cb)
+		  void *cb,
+		  void** task_cb)
 {
 	strbuf_addf(err, "no further jobs available\n");
 	return 0;
