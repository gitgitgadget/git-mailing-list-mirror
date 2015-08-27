From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] thread-utils: add a threaded task queue
Date: Wed, 26 Aug 2015 17:52:43 -0700
Message-ID: <1440636766-12738-3-git-send-email-sbeller@google.com>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 02:53:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUlRE-0000PV-G8
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 02:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbH0Aw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 20:52:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33474 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbH0Awz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 20:52:55 -0400
Received: by pacti10 with SMTP id ti10so5247563pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OlDhtRUkPt2hKme4tEijrQbzppcbyScRsxMRloCIHgM=;
        b=XKzafgz9MJCvGeolT93w1mskOHYXRzMdok7BGwBIk5baBZUzrcpEr+oTex77rnbNlk
         ViD9LCzDoYgOsN1wchbTbdnmKFuUuWCV0BJkzqDkQFGVOf/aKd4pDdkEuWAYdSoiFfub
         7r/7d5GzVM9a0BPOO5IlIXyUg20/Fb8Q1SqELdPaFSOXgb8LPFtbVlsWE1EfvLTYDK9c
         UqnWeBcFsL4bXwZl96Wr6o84kjAYud4YKgOyFqpLAXn1EuUXNuH5dJ7TnSzi7QIqkwBp
         TjJ7zKZby6UzWwdwLACLyGb8hUfIJ01uWT2ENZg3MVESy2oqsLWCPmRqTvrF+SJDNV43
         4Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OlDhtRUkPt2hKme4tEijrQbzppcbyScRsxMRloCIHgM=;
        b=amOx5pw+9bSlTWcJs6bSUm/yljFD2gsxx6VZ5pOmtTE1DBBTimaGaRGOtmNMiUFqJC
         Ay5sDOpX5bSloV+GlVdpfPcoC/yVzkiQsilDgaPCxYjtB1JZ1FxMwmtmgUdFx/pCw696
         mZDBwjpqTGviyCdcG5QUELVWsMvbs2+5HS40l/yy0KD7a+DynkeJsdq5oLPfZ3DB0s8b
         UAAiK+5fR1s77H5v4X2d/v4OUs9H/3CdOMfKtarVnAsaql745DxCCgcqCgMA6bQWZa7O
         URVdPkRdzjRJhRea7kO7gle6ARBzmmxd7KrbEnJStHHa2i+AbYb50m2oNja++hGMoVeR
         geFw==
X-Gm-Message-State: ALoCoQmSJhlKVw2GgF+j6Wemim99iHvUuOJuxMi8KhEwvXc3gH+PvdPwtH7rMe5FWUqbv4cIgI3J
X-Received: by 10.68.143.70 with SMTP id sc6mr2220017pbb.87.1440636774765;
        Wed, 26 Aug 2015 17:52:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:806a:7c76:ca55:3bf1])
        by smtp.gmail.com with ESMTPSA id hy5sm288734pac.22.2015.08.26.17.52.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Aug 2015 17:52:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g784836d
In-Reply-To: <1440636766-12738-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276653>

This adds functionality to do work in a parallel threaded
fashion while the boiler plate code for setting up threads
and tearing them down as well as queuing up tasks is hidden
behind the new API.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c  |  29 +++++---
 thread-utils.c | 227 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 thread-utils.h |  35 +++++++++
 3 files changed, 279 insertions(+), 12 deletions(-)

diff --git a/run-command.c b/run-command.c
index 28e1d55..cb15cd9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -668,6 +668,22 @@ int git_atexit(void (*handler)(void))
 
 #endif
 
+void setup_main_thread(void)
+{
+	if (!main_thread_set) {
+		/*
+		 * We assume that the first time that start_async is called
+		 * it is from the main thread.
+		 */
+		main_thread_set = 1;
+		main_thread = pthread_self();
+		pthread_key_create(&async_key, NULL);
+		pthread_key_create(&async_die_counter, NULL);
+		set_die_routine(die_async);
+		set_die_is_recursing_routine(async_die_is_recursing);
+	}
+}
+
 int start_async(struct async *async)
 {
 	int need_in, need_out;
@@ -740,18 +756,7 @@ int start_async(struct async *async)
 	else if (async->out)
 		close(async->out);
 #else
-	if (!main_thread_set) {
-		/*
-		 * We assume that the first time that start_async is called
-		 * it is from the main thread.
-		 */
-		main_thread_set = 1;
-		main_thread = pthread_self();
-		pthread_key_create(&async_key, NULL);
-		pthread_key_create(&async_die_counter, NULL);
-		set_die_routine(die_async);
-		set_die_is_recursing_routine(async_die_is_recursing);
-	}
+	setup_main_thread();
 
 	if (proc_in >= 0)
 		set_cloexec(proc_in);
diff --git a/thread-utils.c b/thread-utils.c
index a2135e0..b45ab92 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 #include "thread-utils.h"
+#include "run-command.h"
+#include "git-compat-util.h"
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
@@ -75,3 +77,228 @@ int init_recursive_mutex(pthread_mutex_t *m)
 	}
 	return ret;
 }
+
+#ifndef NO_PTHREADS
+struct job_list {
+	int (*fct)(struct task_queue *tq, void *task);
+	void *task;
+	struct job_list *next;
+};
+
+static pthread_t main_thread;
+static int main_thread_set;
+static pthread_key_t async_key;
+static pthread_key_t async_die_counter;
+
+static NORETURN void die_async(const char *err, va_list params)
+{
+	vreportf("fatal: ", err, params);
+
+	if (!pthread_equal(main_thread, pthread_self()))
+		pthread_exit((void *)128);
+
+	exit(128);
+}
+
+static int async_die_is_recursing(void)
+{
+	void *ret = pthread_getspecific(async_die_counter);
+	pthread_setspecific(async_die_counter, (void *)1);
+	return ret != NULL;
+}
+
+/* FIXME: deduplicate this code with run-command.c */
+static void setup_main_thread(void)
+{
+	if (!main_thread_set) {
+		main_thread_set = 1;
+		main_thread = pthread_self();
+		pthread_key_create(&async_key, NULL);
+		pthread_key_create(&async_die_counter, NULL);
+		set_die_routine(die_async);
+		set_die_is_recursing_routine(async_die_is_recursing);
+	}
+}
+
+struct task_queue {
+	pthread_mutex_t mutex;
+	pthread_cond_t cond_non_empty;
+
+	int queued_tasks;
+	struct job_list *first;
+	struct job_list *last;
+
+	pthread_t *threads;
+	unsigned max_threads;
+	unsigned max_tasks;
+
+	void (*finish_function)(struct task_queue *tq);
+	int early_return;
+};
+
+static void next_task(struct task_queue *tq,
+		      int (**fct)(struct task_queue *tq, void *task),
+		      void **task,
+		      int *early_return)
+{
+	struct job_list *job = NULL;
+
+	pthread_mutex_lock(&tq->mutex);
+	while (tq->queued_tasks == 0)
+		pthread_cond_wait(&tq->cond_non_empty, &tq->mutex);
+
+	tq->early_return |= *early_return;
+
+	if (!tq->early_return) {
+		job = tq->first;
+		tq->first = job->next;
+		if (!tq->first)
+			tq->last = NULL;
+		tq->queued_tasks--;
+	}
+
+	pthread_mutex_unlock(&tq->mutex);
+
+	if (job) {
+		*fct = job->fct;
+		*task = job->task;
+	} else {
+		*fct = NULL;
+		*task = NULL;
+	}
+
+	free(job);
+}
+
+static void *dispatcher(void *args)
+{
+	void *task;
+	int (*fct)(struct task_queue *tq, void *task);
+	int early_return = 0;
+	struct task_queue *tq = args;
+
+	next_task(tq, &fct, &task, &early_return);
+	while (fct && !early_return) {
+		early_return = fct(tq, task);
+		next_task(tq, &fct, &task, &early_return);
+	}
+
+	if (tq->finish_function)
+		tq->finish_function(tq);
+
+	pthread_exit(0);
+}
+
+struct task_queue *create_task_queue(unsigned max_threads)
+{
+	struct task_queue *tq = xmalloc(sizeof(*tq));
+
+	int i, ret;
+	if (!max_threads)
+		tq->max_threads = online_cpus();
+	else
+		tq->max_threads = max_threads;
+
+	pthread_mutex_init(&tq->mutex, NULL);
+	pthread_cond_init(&tq->cond_non_empty, NULL);
+
+	tq->threads = xmalloc(tq->max_threads * sizeof(pthread_t));
+
+	tq->queued_tasks = 0;
+	tq->first = NULL;
+	tq->last = NULL;
+
+	setup_main_thread();
+
+	for (i = 0; i < tq->max_threads; i++) {
+		ret = pthread_create(&tq->threads[i], 0, &dispatcher, tq);
+		if (ret)
+			die("unable to create thread: %s", strerror(ret));
+	}
+
+	tq->early_return = 0;
+
+	return tq;
+}
+
+void add_task(struct task_queue *tq,
+	      int (*fct)(struct task_queue *tq, void *task),
+	      void *task)
+{
+	struct job_list *job_list;
+
+	job_list = xmalloc(sizeof(*job_list));
+	job_list->task = task;
+	job_list->fct = fct;
+	job_list->next = NULL;
+
+	pthread_mutex_lock(&tq->mutex);
+
+	if (!tq->last) {
+		tq->last = job_list;
+		tq->first = tq->last;
+	} else {
+		tq->last->next = job_list;
+		tq->last = tq->last->next;
+	}
+	tq->queued_tasks++;
+
+	pthread_mutex_unlock(&tq->mutex);
+	pthread_cond_signal(&tq->cond_non_empty);
+}
+
+int finish_task_queue(struct task_queue *tq, void (*fct)(struct task_queue *tq))
+{
+	int ret;
+	int i;
+
+	tq->finish_function = fct;
+
+	for (i = 0; i < tq->max_threads; i++)
+		add_task(tq, NULL, NULL);
+
+	for (i = 0; i < tq->max_threads; i++)
+		pthread_join(tq->threads[i], 0);
+
+	pthread_mutex_destroy(&tq->mutex);
+	pthread_cond_destroy(&tq->cond_non_empty);
+
+	if (tq->first)
+		die("BUG: internal error with queuing jobs for threads");
+
+	free(tq->threads);
+	ret = tq->early_return;
+
+	free(tq);
+	return ret;
+}
+#else /* NO_PTHREADS */
+
+struct task_queue {
+	int early_return;
+};
+
+struct task_queue *create_task_queue(unsigned max_threads)
+{
+	struct task_queue *tq = xmalloc(sizeof(*tq));
+
+	tq->early_return = 0;
+}
+
+void add_task(struct task_queue *tq,
+	      int (*fct)(struct task_queue *tq, void *task),
+	      void *task)
+{
+	if (tq->early_return)
+		return;
+
+	tq->early_return |= fct(tq, task);
+}
+
+int finish_task_queue(struct task_queue *tq, void (*fct)(struct task_queue *tq))
+{
+	int ret = tq->early_return;
+	free(tq);
+	return ret;
+}
+#endif
diff --git a/thread-utils.h b/thread-utils.h
index d9a769d..f41cfb1 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -12,4 +12,39 @@ extern int init_recursive_mutex(pthread_mutex_t*);
 #define online_cpus() 1
 
 #endif
+
+/*
+ * Creates a struct `task_queue`, which holds a list of tasks. Up to
+ * `max_threads` threads are active to process the enqueued tasks
+ * processing the tasks in a first in first out order.
+ *
+ * If `max_threads` is zero the number of cores available will be used.
+ *
+ * Currently this only works in environments with pthreads, in other
+ * environments, the task will be processed sequentially in `add_task`.
+ */
+struct task_queue *create_task_queue(unsigned max_threads);
+
+/*
+ * The function and data are put into the task queue.
+ *
+ * The function `fct` must not be NULL, as that's used internally
+ * in `finish_task_queue` to signal shutdown. If the return code
+ * of `fct` is unequal to 0, the tasks will stop eventually,
+ * the current parallel tasks will be flushed out.
+ */
+void add_task(struct task_queue *tq,
+	      int (*fct)(struct task_queue *tq, void *task),
+	      void *task);
+
+/*
+ * Waits for all tasks to be done and frees the object. The return code
+ * is zero if all enqueued tasks were processed.
+ *
+ * The function `fct` is called once in each thread after the last task
+ * for that thread was processed. If no thread local cleanup needs to be
+ * performed, pass NULL.
+ */
+int finish_task_queue(struct task_queue *tq, void (*fct)(struct task_queue *tq));
+
 #endif /* THREAD_COMPAT_H */
-- 
2.5.0.264.g784836d
