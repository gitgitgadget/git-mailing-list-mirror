From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Thu, 20 Aug 2015 18:40:36 -0700
Message-ID: <1440121237-24576-2-git-send-email-sbeller@google.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 03:40:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSbK7-0000iC-Gb
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 03:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbbHUBkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 21:40:47 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34078 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbbHUBkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 21:40:45 -0400
Received: by pdbfa8 with SMTP id fa8so20452340pdb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i0Gq0heIVfNEP4VZBNYZIHTn+nEzGDuaEbepu93aouM=;
        b=M0j97v30HmrP/DztHTfFztfOcgT6GIHCMD2cqNhHaAhCoKHsI7diISpyaZiGw34Eq2
         wIOoA0dWQStjTuG1BBL26f0x6GJviB2aUMhBYGFBoCeaMOciknOFSnnw5lk6xYbwl4f4
         hqIWSSb1T52bbKMCkirqpqQwtVz7HmhubDeIKSxVzo3NlypxOj2N5+bFMB6vUA8VBx7U
         74On0wA0gIT09QcSWS4kjIT03UiS+EtzkEbMJN9FcdaqlsHQC3RUuaosTZFrPxsPVCLR
         ZFjdguvPhQZgPV94ShR5zfBCUkBkpujXb21VMbHRume/xcmGFEbfEYW63sBc1SGb5EFd
         9NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i0Gq0heIVfNEP4VZBNYZIHTn+nEzGDuaEbepu93aouM=;
        b=fhYXB6CYDGyjoYiAFyfEJsEUDYgPcWcvoL8hSSYTyxrl5SnOfwPt9oMKfUOg5Jdxxf
         GYLf20ut0HYCVMxWY9EHOP5c4EpssyI5oGlgezsVN3GnDr6Ch7RR5kcqcSz0vl5faQrZ
         nc3p84VnoEd5THw0Q9ZuuUiyQF/Gjixtrc2I/iewjh/bJ8KToDg4teN8SJZ51B2wOykD
         D+TPWzeHjyJcKTy06A0X8VT1gPIhvjRi8lPeINqGOz7R5qubpt1doIbqaDiTjueL4gLR
         26R6pA3FxmstremnaKefwxVHNfK9aDOHnkWfOq52UZjmCAZPCB+Q2cPh9y2jWqC2KG9Y
         0r8Q==
X-Gm-Message-State: ALoCoQlv/jMnUSfqIwan10T+Hxm0qfaSDE+gbMWHdKvSlDGRdKWSK25JULDn84cyvHU+Zl7hwEv1
X-Received: by 10.70.109.232 with SMTP id hv8mr12282493pdb.108.1440121244775;
        Thu, 20 Aug 2015 18:40:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:fdaa:d3b8:45bc:ac82])
        by smtp.gmail.com with ESMTPSA id j4sm5709078pdo.62.2015.08.20.18.40.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 18:40:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g01b5c38.dirty
In-Reply-To: <1440121237-24576-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276274>

This adds functionality to do work in parallel.

The whole life cycle of such a thread pool would look like

    struct task_queue * tq = create_task_queue(32); // no of threads
    for (...)
        add_task(tq, process_one_item_function, item); // non blocking
    ...
    int ret = finish_task_queue(tq); // blocks until all tasks are done
    if (!tq)
        die ("Not all items were be processed");

The caller must take care of handling the output.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I sent this a while ago to the list, no comments on it :(
The core functionality stayed the same, but I hope to improved naming and
location of the code.

The WIP is only for the NO_PTHREADS case.


 run-command.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 run-command.h |  30 +++++++++
 2 files changed, 230 insertions(+), 12 deletions(-)

diff --git a/run-command.c b/run-command.c
index 28e1d55..4029011 100644
--- a/run-command.c
+++ b/run-command.c
@@ -4,6 +4,21 @@
 #include "sigchain.h"
 #include "argv-array.h"
 
+#ifdef NO_PTHREADS
+
+#else
+
+#include "thread-utils.h"
+
+#include <pthread.h>
+#include <semaphore.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#endif
+
+#include "git-compat-util.h"
+
 void child_process_init(struct child_process *child)
 {
 	memset(child, 0, sizeof(*child));
@@ -668,6 +683,22 @@ int git_atexit(void (*handler)(void))
 
 #endif
 
+void setup_main_thread()
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
@@ -740,18 +771,7 @@ int start_async(struct async *async)
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
@@ -852,3 +872,171 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	close(cmd->out);
 	return finish_command(cmd);
 }
+
+#ifndef NO_PTHREADS
+struct job_list {
+	int (*fct)(struct task_queue *aq, void *task);
+	void *task;
+	struct job_list *next;
+};
+#endif
+
+struct task_queue {
+#ifndef NO_PTHREADS
+	/*
+	 * To avoid deadlocks always aquire the semaphores with lowest priority
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
+#endif
+	int early_return;
+};
+
+#ifndef NO_PTHREADS
+
+static void get_task(struct task_queue *aq,
+		     int (**fct)(struct task_queue *aq, void *task),
+		     void **task,
+		     int *early_return)
+{
+	struct job_list *job;
+
+	sem_wait(&aq->workingcount);
+	sem_wait(&aq->mutex);
+
+	if (!aq->first)
+		die("BUG: internal error with dequeuing jobs for threads");
+	job = aq->first;
+	*fct = job->fct;
+	*task = job->task;
+	aq->early_return |= *early_return;
+	*early_return = aq->early_return;
+	aq->first = job->next;
+	if (!aq->first)
+		aq->last = NULL;
+
+	sem_post(&aq->freecount);
+	sem_post(&aq->mutex);
+
+	free(job);
+}
+
+static void* dispatcher(void *args)
+{
+	void *task;
+	int (*fct)(struct task_queue *aq, void *data);
+	int early_return = 0;
+	struct task_queue *aq = args;
+
+	get_task(aq, &fct, &task, &early_return);
+	while (fct || early_return != 0) {
+		early_return = fct(aq, task);
+		get_task(aq, &fct, &task, &early_return);
+	}
+
+	pthread_exit(0);
+}
+#endif
+
+struct task_queue *create_task_queue(unsigned max_threads)
+{
+	struct task_queue *aq = xmalloc(sizeof(*aq));
+
+#ifndef NO_PTHREADS
+	int i;
+	if (!max_threads)
+		aq->max_threads = online_cpus();
+	else
+		aq->max_threads = max_threads;
+
+	sem_init(&aq->mutex, 0, 1);
+	sem_init(&aq->workingcount, 0, 0);
+	sem_init(&aq->freecount, 0, aq->max_threads);
+	aq->threads = xmalloc(aq->max_threads * sizeof(pthread_t));
+
+	for (i = 0; i < aq->max_threads; i++)
+		pthread_create(&aq->threads[i], 0, &dispatcher, aq);
+
+	aq->first = NULL;
+	aq->last = NULL;
+
+	setup_main_thread();
+#endif
+	aq->early_return = 0;
+
+	return aq;
+}
+
+void add_task(struct task_queue *aq,
+	      int (*fct)(struct task_queue *aq, void *task),
+	      void *task)
+{
+#ifndef NO_PTHREADS
+	struct job_list *job_list;
+
+	job_list = xmalloc(sizeof(*job_list));
+	job_list->task = task;
+	job_list->fct = fct;
+	job_list->next = NULL;
+
+	sem_wait(&aq->freecount);
+	sem_wait(&aq->mutex);
+
+	if (!aq->last) {
+		aq->last = job_list;
+		aq->first = aq->last;
+	} else {
+		aq->last->next = job_list;
+		aq->last = aq->last->next;
+	}
+
+	sem_post(&aq->workingcount);
+	sem_post(&aq->mutex);
+#else
+	ALLOC_GROW(aq->ret->ret, aq->ret->count + 1, aq->ret->alloc);
+	aq->ret->ret[aq->ret->count++] = aq->function(job);
+#endif
+}
+
+int finish_task_queue(struct task_queue *aq)
+{
+	int ret;
+#ifndef NO_PTHREADS
+	int i;
+	for (i = 0; i < aq->max_threads; i++)
+		add_task(aq, NULL, NULL);
+
+	for (i = 0; i < aq->max_threads; i++)
+		pthread_join(aq->threads[i], 0);
+
+	sem_destroy(&aq->mutex);
+	sem_destroy(&aq->workingcount);
+	sem_destroy(&aq->freecount);
+
+	if (aq->first)
+		die("BUG: internal error with queuing jobs for threads");
+
+	free(aq->threads);
+#endif
+	ret = aq->early_return;
+
+	free(aq);
+	return ret;
+}
+
diff --git a/run-command.h b/run-command.h
index 5b4425a..c2cfd49 100644
--- a/run-command.h
+++ b/run-command.h
@@ -119,4 +119,34 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
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
+void add_task(struct task_queue *aq,
+	      int (*fct)(struct task_queue *aq, void *task),
+	      void *task);
+
+/*
+ * Waits for all tasks to be done and frees the object. The return code
+ * is zero if all enqueued tasks were processed.
+ */
+int finish_task_queue(struct task_queue *aq);
+
 #endif
-- 
2.5.0.264.g01b5c38.dirty
