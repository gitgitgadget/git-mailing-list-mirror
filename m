From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Sat, 08 Dec 2007 00:03:17 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 06:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0rqm-0006o1-Q0
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 06:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbXLHFDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 00:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXLHFDT
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 00:03:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13578 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbXLHFDS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 00:03:18 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP006UHSPHVC10@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 08 Dec 2007 00:03:17 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67513>


The current method consists of a master thread serving chunks of objects
to work threads when they're done with their previous chunk.  The issue
is to determine the best chunk size: making it too large creates poor
load balancing, while making it too small has a negative effect on pack
size because of the increased number of chunk boundaries and poor delta
window utilization.

This patch implements a completely different approach by initially
splitting the work in large chunks uniformly amongst all threads, and
whenever a thread is done then it steals half of the remaining work from
another thread with the largest amount of unprocessed objects.

This has the advantage of greatly reducing the number of chunk boundaries
with an almost perfect load balancing.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |  117 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 5002cc6..fcc1901 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1479,10 +1479,10 @@ static unsigned long free_unpacked(struct unpacked *n)
 	return freed_mem;
 }
 
-static void find_deltas(struct object_entry **list, unsigned list_size,
+static void find_deltas(struct object_entry **list, unsigned *list_size,
 			int window, int depth, unsigned *processed)
 {
-	uint32_t i = 0, idx = 0, count = 0;
+	uint32_t i, idx = 0, count = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
 	unsigned long mem_usage = 0;
@@ -1490,11 +1490,23 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 	array = xmalloc(array_size);
 	memset(array, 0, array_size);
 
-	do {
-		struct object_entry *entry = list[i++];
+	for (;;) {
+		struct object_entry *entry = *list++;
 		struct unpacked *n = array + idx;
 		int j, max_depth, best_base = -1;
 
+		progress_lock();
+		if (!*list_size) {
+			progress_unlock();
+			break;
+		}
+		(*list_size)--;
+		if (!entry->preferred_base) {
+			(*processed)++;
+			display_progress(progress_state, *processed);
+		}
+		progress_unlock();
+
 		mem_usage -= free_unpacked(n);
 		n->entry = entry;
 
@@ -1512,11 +1524,6 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 		if (entry->preferred_base)
 			goto next;
 
-		progress_lock();
-		(*processed)++;
-		display_progress(progress_state, *processed);
-		progress_unlock();
-
 		/*
 		 * If the current object is at pack edge, take the depth the
 		 * objects that depend on the current object into account
@@ -1576,7 +1583,7 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 			count++;
 		if (idx >= window)
 			idx = 0;
-	} while (i < list_size);
+	}
 
 	for (i = 0; i < window; ++i) {
 		free_delta_index(array[i].index);
@@ -1591,6 +1598,7 @@ struct thread_params {
 	pthread_t thread;
 	struct object_entry **list;
 	unsigned list_size;
+	unsigned remaining;
 	int window;
 	int depth;
 	unsigned *processed;
@@ -1612,10 +1620,10 @@ static void *threaded_find_deltas(void *arg)
 		pthread_mutex_lock(&data_ready);
 		pthread_mutex_unlock(&data_request);
 
-		if (!me->list_size)
+		if (!me->remaining)
 			return NULL;
 
-		find_deltas(me->list, me->list_size,
+		find_deltas(me->list, &me->remaining,
 			    me->window, me->depth, me->processed);
 	}
 }
@@ -1624,57 +1632,102 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			   int window, int depth, unsigned *processed)
 {
 	struct thread_params *target, p[delta_search_threads];
-	int i, ret;
-	unsigned chunk_size;
+	int i, ret, active_threads = 0;
 
 	if (delta_search_threads <= 1) {
-		find_deltas(list, list_size, window, depth, processed);
+		find_deltas(list, &list_size, window, depth, processed);
 		return;
 	}
 
 	pthread_mutex_lock(&data_provider);
 	pthread_mutex_lock(&data_ready);
 
+	/* Start work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
 		p[i].window = window;
 		p[i].depth = depth;
 		p[i].processed = processed;
+		p[i].remaining = 0;
 		ret = pthread_create(&p[i].thread, NULL,
 				     threaded_find_deltas, &p[i]);
 		if (ret)
 			die("unable to create thread: %s", strerror(ret));
+		active_threads++;
 	}
 
-	/* this should be auto-tuned somehow */
-	chunk_size = window * 1000;
+	/* Then partition the work amongst them. */
+	for (i = 0; i < delta_search_threads; i++) {
+		unsigned sub_size = list_size / (delta_search_threads - i);
 
-	do {
-		unsigned sublist_size = chunk_size;
-		if (sublist_size > list_size)
-			sublist_size = list_size;
+		pthread_mutex_lock(&data_provider);
+		target = data_requester;
+		if (!sub_size) {
+			pthread_mutex_unlock(&data_ready);
+			pthread_join(target->thread, NULL);
+			active_threads--;
+			continue;
+		}
 
 		/* try to split chunks on "path" boundaries */
-		while (sublist_size < list_size && list[sublist_size]->hash &&
-		       list[sublist_size]->hash == list[sublist_size-1]->hash)
-			sublist_size++;
+		while (sub_size < list_size && list[sub_size]->hash &&
+		       list[sub_size]->hash == list[sub_size-1]->hash)
+			sub_size++;
+
+		target->list = list;
+		target->list_size = sub_size;
+		target->remaining = sub_size;
+		pthread_mutex_unlock(&data_ready);
 
+		list += sub_size;
+		list_size -= sub_size;
+	}
+
+	/*
+	 * Now let's wait for work completion.  Each time a thread is done
+	 * with its work, we steal half of the remaining work from the
+	 * thread with the largest number of unprocessed objects and give
+	 * it to that newly idle thread.  This ensure good load balancing
+	 * until the remaining object list segments are simply too short
+	 * to be worth splitting anymore.
+	 */
+	do {
+		struct thread_params *victim = NULL;
+		unsigned sub_size = 0;
 		pthread_mutex_lock(&data_provider);
 		target = data_requester;
-		target->list = list;
-		target->list_size = sublist_size;
+
+		progress_lock();
+		for (i = 0; i < delta_search_threads; i++)
+			if (p[i].remaining > 2*window &&
+			    (!victim || victim->remaining < p[i].remaining))
+				victim = &p[i];
+		if (victim) {
+			sub_size = victim->remaining / 2;
+			list = victim->list + victim->list_size - sub_size;
+			while (sub_size && list[0]->hash &&
+			       list[0]->hash == list[-1]->hash) {
+				list++;
+				sub_size--;
+			}
+			target->list = list;
+			victim->list_size -= sub_size;
+			victim->remaining -= sub_size;
+		}
+		progress_unlock();
+
+		target->list_size = sub_size;
+		target->remaining = sub_size;
 		pthread_mutex_unlock(&data_ready);
 
-		list += sublist_size;
-		list_size -= sublist_size;
-		if (!sublist_size) {
+		if (!sub_size) {
 			pthread_join(target->thread, NULL);
-			i--;
+			active_threads--;
 		}
-	} while (i);
+	} while (active_threads);
 }
 
 #else
-#define ll_find_deltas find_deltas
+#define ll_find_deltas(l, s, w, d, p)	find_deltas(l, &s, w, d, p)
 #endif
 
 static void prepare_pack(int window, int depth)
-- 
1.5.3.7.2184.ge321d-dirty
