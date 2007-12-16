From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH v2] threaded pack-objects: Use condition variables for thread communication.
Date: Sun, 16 Dec 2007 20:45:34 +0100
Message-ID: <200712162045.34456.johannes.sixt@telecom.at>
References: <200712160018.54171.johannes.sixt@telecom.at> <200712161941.38109.johannes.sixt@telecom.at> <20071216190016.GC4999@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3zRW-0007iG-Vv
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 20:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbXLPTpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 14:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754874AbXLPTpj
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 14:45:39 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:53994 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbXLPTpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 14:45:38 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 035A013B120;
	Sun, 16 Dec 2007 20:45:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 109275A93E;
	Sun, 16 Dec 2007 20:45:35 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <20071216190016.GC4999@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68482>

In the threaded pack-objects code the main thread and the worker threads
must mutually signal that they have assigned a new pack of work or have
completed their work, respectively. Previously, the code used mutexes that
were locked in one thread and unlocked from a different thread, which is
bogus (and happens to work on Linux).

Here we rectify the implementation by using condition variables: There is
one condition variable on which the main thread waits until a thread
requests new work; and each worker thread has its own condition variable
on which it waits until it is assigned new work or signaled to terminate.

As a cleanup, the worker threads are spawned only after the initial work
packages have been assigned.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
On Sunday 16 December 2007 20:00, Peter Baumann wrote:
> On Sun, Dec 16, 2007 at 07:41:37PM +0100, Johannes Sixt wrote:
> > On Sunday 16 December 2007 13:05, Peter Baumann wrote:
> > > On Sun, Dec 16, 2007 at 12:18:53AM +0100, Johannes Sixt wrote:
> > > > +
> > > > +		progress_lock();
> > > > +		me->working = 0;
> > > > +		progress_unlock();
> > > > +		pthread_cond_signal(&progress_cond);
> > >
> > > Shouldn't the pthread_cond_signal be inside the lock?
> > > e.g. swap progress_unlock() with pthread_cond_signal(&progress_cond)
> >
> > No, that's not necessary. Both ways are correct, but if it's outside the
> > lock there is less contention on the mutex (because the waiting thread
> > must acquire the mutex lock before it can return from pthread_cond_wait).
>
> At least I was told otherwise and [1] backs my knowledge up. Are you
> really sure?
>
> -Peter
>
> http://docs.sun.com/app/docs/doc/806-5257/6je9h032r?a=view#sync-53686

Uh, yes, that's a very compelling reason. I'm wrong. Here's an updated patch.

-- Hannes

 builtin-pack-objects.c |  129 +++++++++++++++++++++++++++++------------------
 1 files changed, 79 insertions(+), 50 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7dd0d7f..4715d5f 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1594,6 +1594,15 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 
 #ifdef THREADED_DELTA_SEARCH
 
+/*
+ * The main thread waits on the condition that (at least) one of the workers
+ * has stopped working (which is indicated in the .working member of
+ * struct thread_params).
+ * When a work thread has completed its work, it sets .working to 0 and
+ * signals the main thread and waits on the condition that .data_ready
+ * becomes 1.
+ */
+
 struct thread_params {
 	pthread_t thread;
 	struct object_entry **list;
@@ -1601,37 +1610,50 @@ struct thread_params {
 	unsigned remaining;
 	int window;
 	int depth;
+	int working;
+	int data_ready;
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
 	unsigned *processed;
 };
 
-static pthread_mutex_t data_request  = PTHREAD_MUTEX_INITIALIZER;
-static pthread_mutex_t data_ready    = PTHREAD_MUTEX_INITIALIZER;
-static pthread_mutex_t data_provider = PTHREAD_MUTEX_INITIALIZER;
-static struct thread_params *data_requester;
+static pthread_cond_t progress_cond = PTHREAD_COND_INITIALIZER;
 
 static void *threaded_find_deltas(void *arg)
 {
 	struct thread_params *me = arg;
 
-	for (;;) {
-		pthread_mutex_lock(&data_request);
-		data_requester = me;
-		pthread_mutex_unlock(&data_provider);
-		pthread_mutex_lock(&data_ready);
-		pthread_mutex_unlock(&data_request);
-
-		if (!me->remaining)
-			return NULL;
-
+	while (me->remaining) {
 		find_deltas(me->list, &me->remaining,
 			    me->window, me->depth, me->processed);
+
+		progress_lock();
+		me->working = 0;
+		pthread_cond_signal(&progress_cond);
+		progress_unlock();
+
+		/*
+		 * We must not set ->data_ready before we wait on the
+		 * condition because the main thread may have set it to 1
+		 * before we get here. In order to be sure that new
+		 * work is available if we see 1 in ->data_ready, it
+		 * was initialized to 0 before this thread was spawned
+		 * and we reset it to 0 right away.
+		 */
+		pthread_mutex_lock(&me->mutex);
+		while (!me->data_ready)
+			pthread_cond_wait(&me->cond, &me->mutex);
+		me->data_ready = 0;
+		pthread_mutex_unlock(&me->mutex);
 	}
+	/* leave ->working 1 so that this doesn't get more work assigned */
+	return NULL;
 }
 
 static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			   int window, int depth, unsigned *processed)
 {
-	struct thread_params *target, p[delta_search_threads];
+	struct thread_params p[delta_search_threads];
 	int i, ret, active_threads = 0;
 
 	if (delta_search_threads <= 1) {
@@ -1639,49 +1661,42 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		return;
 	}
 
-	pthread_mutex_lock(&data_provider);
-	pthread_mutex_lock(&data_ready);
-
-	/* Start work threads. */
+	/* Partition the work amongst work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
+		unsigned sub_size = list_size / (delta_search_threads - i);
+
 		p[i].window = window;
 		p[i].depth = depth;
 		p[i].processed = processed;
-		p[i].remaining = 0;
-		ret = pthread_create(&p[i].thread, NULL,
-				     threaded_find_deltas, &p[i]);
-		if (ret)
-			die("unable to create thread: %s", strerror(ret));
-		active_threads++;
-	}
-
-	/* Then partition the work amongst them. */
-	for (i = 0; i < delta_search_threads; i++) {
-		unsigned sub_size = list_size / (delta_search_threads - i);
-
-		pthread_mutex_lock(&data_provider);
-		target = data_requester;
-		if (!sub_size) {
-			pthread_mutex_unlock(&data_ready);
-			pthread_join(target->thread, NULL);
-			active_threads--;
-			continue;
-		}
+		p[i].working = 1;
+		p[i].data_ready = 0;
+		pthread_mutex_init(&p[i].mutex, NULL);
+		pthread_cond_init(&p[i].cond, NULL);
 
 		/* try to split chunks on "path" boundaries */
 		while (sub_size < list_size && list[sub_size]->hash &&
 		       list[sub_size]->hash == list[sub_size-1]->hash)
 			sub_size++;
 
-		target->list = list;
-		target->list_size = sub_size;
-		target->remaining = sub_size;
-		pthread_mutex_unlock(&data_ready);
+		p[i].list = list;
+		p[i].list_size = sub_size;
+		p[i].remaining = sub_size;
 
 		list += sub_size;
 		list_size -= sub_size;
 	}
 
+	/* Start work threads. */
+	for (i = 0; i < delta_search_threads; i++) {
+		if (!p[i].list_size)
+			continue;
+		ret = pthread_create(&p[i].thread, NULL,
+				     threaded_find_deltas, &p[i]);
+		if (ret)
+			die("unable to create thread: %s", strerror(ret));
+		active_threads++;
+	}
+
 	/*
 	 * Now let's wait for work completion.  Each time a thread is done
 	 * with its work, we steal half of the remaining work from the
@@ -1690,13 +1705,21 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	 * until the remaining object list segments are simply too short
 	 * to be worth splitting anymore.
 	 */
-	do {
+	while (active_threads) {
+		struct thread_params *target = NULL;
 		struct thread_params *victim = NULL;
 		unsigned sub_size = 0;
-		pthread_mutex_lock(&data_provider);
-		target = data_requester;
 
 		progress_lock();
+		for (;;) {
+			for (i = 0; !target && i < delta_search_threads; i++)
+				if (!p[i].working)
+					target = &p[i];
+			if (target)
+				break;
+			pthread_cond_wait(&progress_cond, &progress_mutex);
+		};
+
 		for (i = 0; i < delta_search_threads; i++)
 			if (p[i].remaining > 2*window &&
 			    (!victim || victim->remaining < p[i].remaining))
@@ -1723,17 +1746,23 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			victim->list_size -= sub_size;
 			victim->remaining -= sub_size;
 		}
-		progress_unlock();
-
 		target->list_size = sub_size;
 		target->remaining = sub_size;
-		pthread_mutex_unlock(&data_ready);
+		target->working = 1;
+		progress_unlock();
+
+		pthread_mutex_lock(&target->mutex);
+		target->data_ready = 1;
+		pthread_cond_signal(&target->cond);
+		pthread_mutex_unlock(&target->mutex);
 
 		if (!sub_size) {
 			pthread_join(target->thread, NULL);
+			pthread_cond_destroy(&target->cond);
+			pthread_mutex_destroy(&target->mutex);
 			active_threads--;
 		}
-	} while (active_threads);
+	}
 }
 
 #else
-- 
1.5.3.6.954.g0c63
