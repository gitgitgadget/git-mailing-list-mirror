From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/9] thread-utils: add a threaded task queue
Date: Thu, 27 Aug 2015 18:14:50 -0700
Message-ID: <1440724495-708-5-git-send-email-sbeller@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 03:15:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV8Gf-00012l-Hp
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 03:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbbH1BPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 21:15:38 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35022 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbH1BPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 21:15:04 -0400
Received: by pacdd16 with SMTP id dd16so43388118pac.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 18:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcPH+eDPNFtcOH5FYkyZNkXJPcVmqM8tK3EwG2r+SVE=;
        b=ZcoBZqAnakAhN3Ak4i/nhFoi18w7y9M7mXq8C1DscAUyuXdVuqoeoYvh2csCTMw6H9
         I+b5OKTERKnVY7upBpV0MjalLv64+QrXpxtJvhgkEAyi/pemLH/X8iS/0LZhapy4hMKs
         6xfIZzTttTbh51NoecvdkLsQeEDZdLkIxER+J+Atz0oqh8FI6WTM0K9DGPHc+GZ2bCkC
         h7SR+0/VKRUtozHrZQwl+CV4c5O+NpUpRB87CdIb9mLiVYiHEHIW0ncv97FdALrT1Wzc
         quWyYSj6MQXJGa4NCHyOMPgQcruBX44teelT930NKBZ/4rE7+II9F8jAB0LF4VKe2iHk
         fo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcPH+eDPNFtcOH5FYkyZNkXJPcVmqM8tK3EwG2r+SVE=;
        b=M1k8Tc5FPE3PyfYipMaHmcVADM83A9SPu4Qkv6f+kpK1aOykp0xlPJaERi6FI1eg/9
         YkipswsBNFiqNXTZTPFrFjPOojq0zX5PRtv5tfXI4YF0hw5fZD9JpMzd6Z/shvGTq8yZ
         BKZXgzTTBTsCOFuHtvkH9asg5aZhiV3WQJqMwNvyub/rgnhvB6g6l17V4hukE3ZX4faW
         xjKiGm6K16Gpp9OdMiPePOGEp2x59yczCxmAL0te9GwjeQsJpfu6d9hOs05mCwCqtbkJ
         vy+/w6tCh7FdCE2DJ8nd9xpMqZRpWubHdZHIcVCZuYUQwDEp+Unj7d+hmcLDiylmKkjT
         pfwg==
X-Gm-Message-State: ALoCoQmowxS0KDKnCrSqokYujtzqxnCOhBcwhfQ92+qQEfGYgHHUIfI7KmZclAQZkYzntuwf6BeR
X-Received: by 10.68.234.167 with SMTP id uf7mr10821920pbc.51.1440724504411;
        Thu, 27 Aug 2015 18:15:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bce4:8b21:c71b:de7e])
        by smtp.gmail.com with ESMTPSA id os7sm3740657pbb.23.2015.08.27.18.15.03
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 27 Aug 2015 18:15:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g5e52b0d
In-Reply-To: <1440724495-708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276691>

This adds functionality to do work in a parallel threaded
fashion while the boiler plate code for setting up threads
and tearing them down as well as queuing up tasks is hidden
behind the new API.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c  |  39 +++++++-----
 run-command.h  |   3 +
 thread-utils.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 thread-utils.h |  35 +++++++++++
 4 files changed, 253 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index 28e1d55..3d37f8c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -610,10 +610,12 @@ static NORETURN void die_async(const char *err, va_list params)
 
 	if (!pthread_equal(main_thread, pthread_self())) {
 		struct async *async = pthread_getspecific(async_key);
-		if (async->proc_in >= 0)
-			close(async->proc_in);
-		if (async->proc_out >= 0)
-			close(async->proc_out);
+		if (async) {
+			if (async->proc_in >= 0)
+				close(async->proc_in);
+			if (async->proc_out >= 0)
+				close(async->proc_out);
+		}
 		pthread_exit((void *)128);
 	}
 
@@ -668,6 +670,22 @@ int git_atexit(void (*handler)(void))
 
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
@@ -740,18 +758,7 @@ int start_async(struct async *async)
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
diff --git a/run-command.h b/run-command.h
index 5b4425a..176a5b2 100644
--- a/run-command.h
+++ b/run-command.h
@@ -119,4 +119,7 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+/* die gracefully from within threads */
+void setup_main_thread(void);
+
 #endif
diff --git a/thread-utils.c b/thread-utils.c
index a2135e0..30ccd79 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 #include "thread-utils.h"
+#include "run-command.h"
+#include "git-compat-util.h"
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
@@ -75,3 +77,193 @@ int init_recursive_mutex(pthread_mutex_t *m)
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
2.5.0.264.g5e52b0d
