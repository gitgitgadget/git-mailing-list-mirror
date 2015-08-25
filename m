From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] thread-utils: add a threaded task queue
Date: Tue, 25 Aug 2015 10:28:23 -0700
Message-ID: <1440523706-23041-3-git-send-email-sbeller@google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Tue Aug 25 19:28:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUI1Y-0006ce-4c
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbbHYR2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 13:28:35 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32990 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbbHYR2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:28:32 -0400
Received: by pacti10 with SMTP id ti10so57370534pac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uNERrMDjwL3RfbVgERGOQtIdBWD6rzRURJ/VSkK6GcM=;
        b=GcoZMPkTXV2SC3iR4vh6MHQYX146lJ1p2s4Hidje2MVZ5AeflLroDEbIzlxR9ptQoU
         HYTQXQ31Q/hYuAqcDRnA3CULLzPGlqID/x0IJpWwy+teuZsjeTebKfd7qcEwEmOdePip
         uBuNjz9Jk4BfKR4Pw6NXLukUSDScrax0fSojNsE5eI6wBEr9t1mKg2QR4aDYyAMEwatq
         GdUUOve1oNC+jcrAxPxVEDOZ4xp52DZ8lFfDapz/1cCUB+1jMVWhy1TwQnCcEWM3xd0x
         lRAHv5EpoBOVZeQXRvm/sxk+UX8xdr7nmY/l2NOKT5mxp3ZodLm3xARUfb8bSHKgFQEz
         fvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uNERrMDjwL3RfbVgERGOQtIdBWD6rzRURJ/VSkK6GcM=;
        b=a9dDUkVxe5HlxMx8Us3I3jKKuH1uoop6uGFgbFo9k8rffYnDEJssuntO6iwHZddbC6
         JEVJhSkXjGdoYyeVPXH3RmO4sP+sc7My4Yo87TmpOB7JXJHyV8s8w9g72V2DBqy7bDh6
         f6MwRPowYL/yzXHiIv1EDX4xZ9NIyr0SxlJvxyxIf0nP6SETbfUKK9O4w34OU93/YojK
         nSyPBNAl4ld/ITkUOXkXMdEafoS9S2nsQZYdbdJBSHizTBa1fx8G6/lgicq9x2iDxmzp
         0erj+BTpmLlQRsqf2EJbjuzkpnknkbKu7utRcyFgF+5PmwA88gpLKJw36YdDYU2gfeg2
         OvNg==
X-Gm-Message-State: ALoCoQln9RiVfGyoewWVYc4pL41fB6yNXNHaKco2wi5PJd4QEHdSuuz0oEADvDUnGHIyn3pZpZYf
X-Received: by 10.66.100.193 with SMTP id fa1mr3414298pab.3.1440523712403;
        Tue, 25 Aug 2015 10:28:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:ccb:1c59:dd72:7a5c])
        by smtp.gmail.com with ESMTPSA id b4sm6568814pdn.5.2015.08.25.10.28.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Aug 2015 10:28:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.400.gff86faf
In-Reply-To: <1440523706-23041-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276541>

This adds functionality to do work in a parallel threaded
fashion while the boiler plate code for setting up threads
and tearing them down as well as queuing up tasks is hidden
behind the new API.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c  |  29 ++++---
 thread-utils.c | 237 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 thread-utils.h |  40 ++++++++++
 3 files changed, 294 insertions(+), 12 deletions(-)

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
index a2135e0..936b3672 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 #include "thread-utils.h"
+#include "run-command.h"
+#include "git-compat-util.h"
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
@@ -75,3 +77,238 @@ int init_recursive_mutex(pthread_mutex_t *m)
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
+	/*
+	 * To avoid deadlocks always acquire the semaphores with lowest priority
+	 * first, priorites are in descending order as listed.
+	 *
+	 * The `mutex` is a general purpose lock for modifying data in the async
+	 * queue, such as adding a new task or adding a return value from
+	 * an already run task.
+	 *
+	 * `workingcount` and `freecount` are opposing semaphores, the sum of
+	 * their values should equal `max_threads` at any time while the `mutex`
+	 * is available.
+	 */
+	sem_t mutex;
+	sem_t workingcount;
+	sem_t freecount;
+
+	pthread_t *threads;
+	unsigned max_threads;
+
+	struct job_list *first;
+	struct job_list *last;
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
+	sem_wait(&tq->workingcount);
+	sem_wait(&tq->mutex);
+
+	if (*early_return) {
+		tq->early_return |= *early_return;
+		*fct = NULL;
+		*task = NULL;
+	} else {
+		if (!tq->first)
+			die("BUG: internal error with dequeuing jobs for threads");
+
+		job = tq->first;
+		*fct = job->fct;
+		*task = job->task;
+
+		tq->first = job->next;
+		if (!tq->first)
+			tq->last = NULL;
+	}
+
+	sem_post(&tq->freecount);
+	sem_post(&tq->mutex);
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
+	while (fct || early_return != 0) {
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
+	sem_init(&tq->mutex, 0, 1);
+	sem_init(&tq->workingcount, 0, 0);
+	sem_init(&tq->freecount, 0, tq->max_threads);
+	tq->threads = xmalloc(tq->max_threads * sizeof(pthread_t));
+
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
+	sem_wait(&tq->freecount);
+	sem_wait(&tq->mutex);
+
+	if (!tq->last) {
+		tq->last = job_list;
+		tq->first = tq->last;
+	} else {
+		tq->last->next = job_list;
+		tq->last = tq->last->next;
+	}
+
+	sem_post(&tq->workingcount);
+	sem_post(&tq->mutex);
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
+	sem_destroy(&tq->mutex);
+	sem_destroy(&tq->workingcount);
+	sem_destroy(&tq->freecount);
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
index d9a769d..977d37b 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -7,9 +7,49 @@
 extern int online_cpus(void);
 extern int init_recursive_mutex(pthread_mutex_t*);
 
+#include <pthread.h>
+#include <semaphore.h>
+#include <stdio.h>
+#include <unistd.h>
+
 #else
 
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
2.5.0.400.gff86faf
