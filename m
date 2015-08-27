From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] pack-objects: Use new worker pool
Date: Wed, 26 Aug 2015 17:52:46 -0700
Message-ID: <1440636766-12738-6-git-send-email-sbeller@google.com>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 02:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUlRF-0000PV-3D
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 02:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbbH0AxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 20:53:05 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35432 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbH0Aw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 20:52:58 -0400
Received: by pacdd16 with SMTP id dd16so5113815pac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gf8BIxqk7UJfYZxLzwBySmcy/kd4DbF6GBachrNuFUw=;
        b=g1RxhkwUA5p0PmygqFjrVvNnHUCRn/i7pUWCiJS0iAIA8nilCZNwT4dh9bR0fZ2bpd
         5OppobB5VUgjlqmh7jkAMW1H5azErIIqFY8XerLrjy9LvWl2W9nq+/8wTb0r2tC8scRW
         DPugg/Tx9gRm9uw8ELXtSgO49mOlz1uvbL9By8mrJw5RNepoXjIIyKMgtWVJBj9YBcFf
         /cH89BrD7i0rw4CbPWfI46XuyaQ5/Uf4J8cAiM59tp+8wWBVMLEDePDKAiI0Q5x3n4EV
         nptpHcfFx25m5D2UNgYjMlTMFB6Hms0PCqly2WFbr2UjQuezYAHgdh9hdcaboN30nCS6
         qzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gf8BIxqk7UJfYZxLzwBySmcy/kd4DbF6GBachrNuFUw=;
        b=MgRMrum1/TiiwDuqhpT1RFAp6wywsmhviTWEsJOIypgpIs6kxJJRPCocMEBDAxaCQy
         9uS5o18rcZKCkxTrI9BcQsOPDfXpXVgijoAe1YOPYjaF0zQIt8px305kvjlU54njv6ja
         l8fhu8TLhRyFrpTcEijma5YM5Ot9Q/08FkY4nY5VQpTs4/OINh+IU+Lj4zfsyFjb90YC
         JDsCe8UZAKzG0SN7VFfcXp0Js3AobbMT+G9h/0liZJAkOZ5Yu4CWCsSJfaZAiBX78nBt
         0l+Jzt5MsG69wmsZxXCeE3S07ACPDHpAi1dqoeumWcEzDmZGOY1H7p2q1bQSWJTn3V2I
         Qfow==
X-Gm-Message-State: ALoCoQk9Pz6cDjJRYg213cYM3kqIX1et8DNJ2ElAVVg31KK0KlOlCdA/bhXOqVbrfn+DdBXiPQUH
X-Received: by 10.68.249.36 with SMTP id yr4mr2858140pbc.18.1440636778443;
        Wed, 26 Aug 2015 17:52:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:806a:7c76:ca55:3bf1])
        by smtp.gmail.com with ESMTPSA id kv10sm298825pbc.2.2015.08.26.17.52.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Aug 2015 17:52:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g784836d
In-Reply-To: <1440636766-12738-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276651>

Before we had <n> threads doing the delta finding work, and the main thread
was load balancing the threads, i.e. moving work from a thread with a large
amount left to an idle thread whenever such a situation arose.

This moves the load balancing to the threads themselves. As soon as one
thread is done working it will look at its peer threads and will pickup
half the work load from the thread with the largest pending load.

By having the load balancing as part of the threads, the locking and
communication model becomes easier, such that we don't need so many
mutexes any more.

It also demonstrates the usage of the new threading pool being easily
applied in different situations.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-objects.c | 175 ++++++++++++++++---------------------------------
 1 file changed, 57 insertions(+), 118 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 62cc16d..f46d2df 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -17,6 +17,7 @@
 #include "pack-objects.h"
 #include "progress.h"
 #include "refs.h"
+#include "run-command.h"
 #include "streaming.h"
 #include "thread-utils.h"
 #include "pack-bitmap.h"
@@ -1887,26 +1888,12 @@ static void try_to_free_from_threads(size_t size)
 
 static try_to_free_t old_try_to_free_routine;
 
-/*
- * The main thread waits on the condition that (at least) one of the workers
- * has stopped working (which is indicated in the .working member of
- * struct thread_params).
- * When a work thread has completed its work, it sets .working to 0 and
- * signals the main thread and waits on the condition that .data_ready
- * becomes 1.
- */
-
 struct thread_params {
-	pthread_t thread;
 	struct object_entry **list;
 	unsigned list_size;
 	unsigned remaining;
 	int window;
 	int depth;
-	int working;
-	int data_ready;
-	pthread_mutex_t mutex;
-	pthread_cond_t cond;
 	unsigned *processed;
 };
 
@@ -1933,7 +1920,52 @@ static void cleanup_threaded_search(void)
 	pthread_mutex_destroy(&progress_mutex);
 }
 
-static void *threaded_find_deltas(void *arg)
+static struct thread_params *p;
+
+static void threaded_split_largest_workload(struct thread_params *target)
+{
+	int i;
+
+	struct object_entry **list;
+	struct thread_params *victim = NULL;
+	unsigned sub_size = 0;
+
+	/* Find a victim */
+	progress_lock();
+	for (i = 0; i < delta_search_threads; i++)
+		if (p[i].remaining > 2*window &&
+		    (!victim || victim->remaining < p[i].remaining))
+			victim = &p[i];
+
+	if (victim) {
+		sub_size = victim->remaining / 2;
+		list = victim->list + victim->list_size - sub_size;
+		while (sub_size && list[0]->hash &&
+		       list[0]->hash == list[-1]->hash) {
+			list++;
+			sub_size--;
+		}
+		if (!sub_size) {
+			/*
+			 * It is possible for some "paths" to have
+			 * so many objects that no hash boundary
+			 * might be found.  Let's just steal the
+			 * exact half in that case.
+			 */
+			sub_size = victim->remaining / 2;
+			list -= sub_size;
+		}
+		victim->list_size -= sub_size;
+		victim->remaining -= sub_size;
+
+		target->list = list;
+		target->list_size = sub_size;
+		target->remaining = sub_size;
+	}
+	progress_unlock();
+}
+
+static int threaded_find_deltas(struct task_queue *tq, void *arg)
 {
 	struct thread_params *me = arg;
 
@@ -1941,34 +1973,17 @@ static void *threaded_find_deltas(void *arg)
 		find_deltas(me->list, &me->remaining,
 			    me->window, me->depth, me->processed);
 
-		progress_lock();
-		me->working = 0;
-		pthread_cond_signal(&progress_cond);
-		progress_unlock();
-
-		/*
-		 * We must not set ->data_ready before we wait on the
-		 * condition because the main thread may have set it to 1
-		 * before we get here. In order to be sure that new
-		 * work is available if we see 1 in ->data_ready, it
-		 * was initialized to 0 before this thread was spawned
-		 * and we reset it to 0 right away.
-		 */
-		pthread_mutex_lock(&me->mutex);
-		while (!me->data_ready)
-			pthread_cond_wait(&me->cond, &me->mutex);
-		me->data_ready = 0;
-		pthread_mutex_unlock(&me->mutex);
+		threaded_split_largest_workload(me);
 	}
-	/* leave ->working 1 so that this doesn't get more work assigned */
-	return NULL;
+
+	return 0;
 }
 
 static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			   int window, int depth, unsigned *processed)
 {
-	struct thread_params *p;
-	int i, ret, active_threads = 0;
+	struct task_queue *tq;
+	int i;
 
 	init_threaded_search();
 
@@ -1980,8 +1995,11 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	if (progress > pack_to_stdout)
 		fprintf(stderr, "Delta compression using up to %d threads.\n",
 				delta_search_threads);
+
 	p = xcalloc(delta_search_threads, sizeof(*p));
 
+	tq = create_task_queue(delta_search_threads);
+
 	/* Partition the work amongst work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
 		unsigned sub_size = list_size / (delta_search_threads - i);
@@ -1993,8 +2011,6 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		p[i].window = window;
 		p[i].depth = depth;
 		p[i].processed = processed;
-		p[i].working = 1;
-		p[i].data_ready = 0;
 
 		/* try to split chunks on "path" boundaries */
 		while (sub_size && sub_size < list_size &&
@@ -2008,87 +2024,10 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 
 		list += sub_size;
 		list_size -= sub_size;
+		add_task(tq, threaded_find_deltas, &p[i]);
 	}
 
-	/* Start work threads. */
-	for (i = 0; i < delta_search_threads; i++) {
-		if (!p[i].list_size)
-			continue;
-		pthread_mutex_init(&p[i].mutex, NULL);
-		pthread_cond_init(&p[i].cond, NULL);
-		ret = pthread_create(&p[i].thread, NULL,
-				     threaded_find_deltas, &p[i]);
-		if (ret)
-			die("unable to create thread: %s", strerror(ret));
-		active_threads++;
-	}
-
-	/*
-	 * Now let's wait for work completion.  Each time a thread is done
-	 * with its work, we steal half of the remaining work from the
-	 * thread with the largest number of unprocessed objects and give
-	 * it to that newly idle thread.  This ensure good load balancing
-	 * until the remaining object list segments are simply too short
-	 * to be worth splitting anymore.
-	 */
-	while (active_threads) {
-		struct thread_params *target = NULL;
-		struct thread_params *victim = NULL;
-		unsigned sub_size = 0;
-
-		progress_lock();
-		for (;;) {
-			for (i = 0; !target && i < delta_search_threads; i++)
-				if (!p[i].working)
-					target = &p[i];
-			if (target)
-				break;
-			pthread_cond_wait(&progress_cond, &progress_mutex);
-		}
-
-		for (i = 0; i < delta_search_threads; i++)
-			if (p[i].remaining > 2*window &&
-			    (!victim || victim->remaining < p[i].remaining))
-				victim = &p[i];
-		if (victim) {
-			sub_size = victim->remaining / 2;
-			list = victim->list + victim->list_size - sub_size;
-			while (sub_size && list[0]->hash &&
-			       list[0]->hash == list[-1]->hash) {
-				list++;
-				sub_size--;
-			}
-			if (!sub_size) {
-				/*
-				 * It is possible for some "paths" to have
-				 * so many objects that no hash boundary
-				 * might be found.  Let's just steal the
-				 * exact half in that case.
-				 */
-				sub_size = victim->remaining / 2;
-				list -= sub_size;
-			}
-			target->list = list;
-			victim->list_size -= sub_size;
-			victim->remaining -= sub_size;
-		}
-		target->list_size = sub_size;
-		target->remaining = sub_size;
-		target->working = 1;
-		progress_unlock();
-
-		pthread_mutex_lock(&target->mutex);
-		target->data_ready = 1;
-		pthread_cond_signal(&target->cond);
-		pthread_mutex_unlock(&target->mutex);
-
-		if (!sub_size) {
-			pthread_join(target->thread, NULL);
-			pthread_cond_destroy(&target->cond);
-			pthread_mutex_destroy(&target->mutex);
-			active_threads--;
-		}
-	}
+	finish_task_queue(tq, NULL);
 	cleanup_threaded_search();
 	free(p);
 }
-- 
2.5.0.264.g784836d
