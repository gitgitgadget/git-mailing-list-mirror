From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 2/4] Add a workdispatcher to get work done in parallel
Date: Thu,  6 Aug 2015 10:35:22 -0700
Message-ID: <1438882524-21215-3-git-send-email-sbeller@google.com>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, hvoigt@hvoigt.net, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 19:35:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNP56-0001qc-Ms
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 19:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599AbbHFRfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 13:35:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33707 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538AbbHFRfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 13:35:36 -0400
Received: by pabyb7 with SMTP id yb7so35378295pab.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=icGX8UjAuRslrxgau0PdrMI0LndrBvsyCaFga7dx3SE=;
        b=BuI81znpvHhw4dwC2XXhHCcSJho/kSX2cCXvgM8L1l4n6QYvs9uZBlTAIECUm27DN+
         mahIqZsSpCKZR94tv+wAqWSmwJPA07J3HpfDyrzkDzNpCMNwIOxrtlmovw/xp3534dDO
         /gAXpjswqFAFowQZ1s16gTK93MykeyR0Izh9vyz4tzM7vzmmYnHCBctuVZAPEJe1F38f
         dCdJpXCpFLGdxMRcW81OmC987K7EKGaztt7wsswemyvO5QA8OoIqCXdYoeD+q7friuUK
         eMWRqPDJUukm49whLDbmRBlDIWqq51ZFFK8fmRxV8UlWKVEMKV7KzyDHq8G+RGVrizpV
         dclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=icGX8UjAuRslrxgau0PdrMI0LndrBvsyCaFga7dx3SE=;
        b=XtA6pw/G6vvO1pki7mTjb8XefX7lSgvolNeGlgQmrs0snySrafGxaiYhYVq0uXw3ee
         tkiQb9zrfOKxxX2E8VIu4Yc92Iu5Q61HzQfxvjVjm25OSNEm0EFzR0tpco1UWksabana
         KDng7RbUFauT/1vtraaa+hBOVdrRNJ3wjre8o7WO9FudIO7vE+NH7/GbyPKOrdrX7qMQ
         JHAEf3kPzTxTLtoZu50bVBDmxZCofXNSxbXThP3i0RwWG98K4M2UxyQN0Yjgir7iNteB
         Ujc5333Cq0uCyOe0MGRdFPThsur7CCnv5AQumBL+r8vfN7rXGSoWDfBESNByTJgh5rsG
         9Q1A==
X-Gm-Message-State: ALoCoQlw9F2Uw0/w7jKyUSZMfbQeNVBA3JcoIfiyDp/yMi5mIwN9us6W+tPZSDhXJLrpNokyvVjZ
X-Received: by 10.69.0.166 with SMTP id az6mr5465727pbd.168.1438882535496;
        Thu, 06 Aug 2015 10:35:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8060:d893:ee2c:36a5])
        by smtp.gmail.com with ESMTPSA id hg3sm7203930pbb.52.2015.08.06.10.35.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 10:35:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.239.g9728e1d.dirty
In-Reply-To: <1438882524-21215-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275426>

This adds infrastructure code to work a set of tasks from a thread pool.

The whole life cycle of such a thread pool would look like

    struct workdispatcher *wd;
    struct return_values *rv;
    
    wd = create_workdispatcher(&command_for_task, max_parallel_jobs);
    for (...) {
        prepare(pointer_to_task);
        add_task(wd, pointer_to_task);
    }
    rv = wait_workdispatcher(wd);

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile         |   1 +
 workdispatcher.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 workdispatcher.h |  29 +++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 workdispatcher.c
 create mode 100644 workdispatcher.h

diff --git a/Makefile b/Makefile
index 6fb7484..2d8803c 100644
--- a/Makefile
+++ b/Makefile
@@ -805,6 +805,7 @@ LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
+LIB_OBJS += workdispatcher.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
diff --git a/workdispatcher.c b/workdispatcher.c
new file mode 100644
index 0000000..adfedd9
--- /dev/null
+++ b/workdispatcher.c
@@ -0,0 +1,184 @@
+#include "cache.h"
+#include "workdispatcher.h"
+
+#ifndef NO_PTHREADS
+#include <pthread.h>
+#include <semaphore.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "git-compat-util.h"
+struct job_list {
+	void *item;
+	struct job_list *next;
+};
+#endif
+
+struct workdispatcher {
+#ifndef NO_PTHREADS
+	/*
+	 * To avoid deadlocks always aquire the semaphores with lowest priority
+	 * first, priorites are in descending order as listed.
+	 *
+	 * The `mutex` is a general purpose lock for modifying data in the work
+	 * dispatcher, such as adding a new task or adding a return value from
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
+	void *(*function)(void*);
+	struct return_values *ret;
+};
+
+#ifndef NO_PTHREADS
+static unsigned number_cores(void)
+{
+	int count = sysconf(_SC_NPROCESSORS_ONLN);
+	if (count < 1) {
+		fprintf(stderr, "Number of CPUs online reported %d. "
+			"Using one core.\n", count);
+		count = 1;
+	}
+	return count;
+}
+
+void *get_task(struct workdispatcher *wd)
+{
+	void *ret;
+	struct job_list *job;
+
+	sem_wait(&wd->workingcount);
+	sem_wait(&wd->mutex);
+
+	if (!wd->first)
+		die("BUG: internal error with dequeuing jobs for threads");
+	job = wd->first;
+	ret = job->item;
+	wd->first = job->next;
+	if (!wd->first)
+		wd->last = NULL;
+
+	sem_post(&wd->freecount);
+	sem_post(&wd->mutex);
+
+	free(job);
+	return ret;
+}
+
+void* dispatcher(void *args)
+{
+	struct workdispatcher *wd = args;
+	void *job = get_task(wd);
+	while (job) {
+		void *retvalue = wd->function(job);
+
+		sem_wait(&wd->mutex);
+		struct return_values *rv = wd->ret;
+		ALLOC_GROW(rv->ret, rv->count + 1, rv->alloc);
+		wd->ret->ret[rv->count++] = retvalue;
+		sem_post(&wd->mutex);
+
+		job = get_task(wd);
+	}
+
+	pthread_exit(0);
+}
+#endif
+
+struct workdispatcher *create_workdispatcher(void *function(void*),
+					     unsigned max_threads)
+{
+	struct workdispatcher *wd = xmalloc(sizeof(*wd));
+
+#ifndef NO_PTHREADS
+	int i;
+	if (!max_threads)
+		wd->max_threads = number_cores();
+	else
+		wd->max_threads = max_threads;
+
+	sem_init(&wd->mutex, 0, 1);
+	sem_init(&wd->workingcount, 0, 0);
+	sem_init(&wd->freecount, 0, wd->max_threads);
+	wd->threads = xmalloc(wd->max_threads * sizeof(pthread_t));
+
+	for (i = 0; i < wd->max_threads; i++)
+		pthread_create(&wd->threads[i], 0, &dispatcher, wd);
+
+	wd->first = NULL;
+	wd->last = NULL;
+#endif
+	wd->function = function;
+	wd->ret = xmalloc(sizeof(*wd->ret));
+	wd->ret->ret = NULL;
+	wd->ret->count = 0;
+	wd->ret->alloc = 0;
+
+	return wd;
+}
+
+void add_task(struct workdispatcher *wd, void *job)
+{
+#ifndef NO_PTHREADS
+	struct job_list *job_list;
+
+	job_list = xmalloc(sizeof(*job_list));
+	job_list->item = job;
+	job_list->next = NULL;
+
+	sem_wait(&wd->freecount);
+	sem_wait(&wd->mutex);
+
+	if (!wd->last) {
+		wd->last = job_list;
+		wd->first = wd->last;
+	} else {
+		wd->last->next = job_list;
+		wd->last = wd->last->next;
+	}
+
+	sem_post(&wd->workingcount);
+	sem_post(&wd->mutex);
+#else
+	ALLOC_GROW(wd->ret->ret, wd->ret->count + 1, wd->ret->alloc);
+	wd->ret->ret[wd->ret->count++] = wd->function(job);
+#endif
+}
+
+struct return_values *wait_workdispatcher(struct workdispatcher *wd)
+{
+	struct return_values *ret;
+#ifndef NO_PTHREADS
+	int i;
+	for (i = 0; i < wd->max_threads; i++)
+		add_task(wd, NULL);
+
+	for (i = 0; i < wd->max_threads; i++)
+		pthread_join(wd->threads[i], 0);
+
+	sem_destroy(&wd->mutex);
+	sem_destroy(&wd->workingcount);
+	sem_destroy(&wd->freecount);
+
+	if (wd->first)
+		die("BUG: internal error with queuing jobs for threads");
+
+	free(wd->threads);
+#endif
+	ret = wd->ret;
+
+	free(wd);
+	return ret;
+}
diff --git a/workdispatcher.h b/workdispatcher.h
new file mode 100644
index 0000000..9f78124
--- /dev/null
+++ b/workdispatcher.h
@@ -0,0 +1,29 @@
+#ifndef WORKDISPATCHER
+#define WORKDISPATCHER
+
+struct return_values {
+	void **ret;
+	int count, alloc;
+};
+
+/*
+ * Creates a struct workdispatcher, which holds a job list and assigns the
+ * jobs to be processed to a number of threads `maxthreads`.
+ * Within the threads the function `fct` is called with the pointer as
+ * given in add_task.
+ *
+ * If `maxthreads` is zero the number of cores available will be used.
+ *
+ * Currently this only works in environments with pthreads, in other
+ * environments, the task will be processed directly in `add_task`.
+ */
+struct workdispatcher *create_workdispatcher(void *fct(void*),
+					     unsigned maxthreads);
+
+/* Waits for all tasks to be done and frees the object. */
+struct return_values *wait_workdispatcher(struct workdispatcher *wd);
+
+/* `task` must not be NULL, as that's used internally to signal shutdown. */
+void add_task(struct workdispatcher *wd, void *task);
+
+#endif
-- 
2.5.0.239.g9728e1d.dirty
