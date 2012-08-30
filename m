From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Thu, 30 Aug 2012 08:54:21 -0400
Message-ID: <20120830125421.GA5687@sigill.intra.peff.net>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
 <20120829210540.GA31756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 14:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T74GX-00026d-UO
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 14:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab2H3My1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 08:54:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48117 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab2H3My1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 08:54:27 -0400
Received: (qmail 8938 invoked by uid 107); 30 Aug 2012 12:54:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Aug 2012 08:54:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2012 08:54:21 -0400
Content-Disposition: inline
In-Reply-To: <20120829210540.GA31756@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204534>

On Wed, Aug 29, 2012 at 05:05:40PM -0400, Jeff King wrote:

> You would want this on top:
> [...]
> but t6024 still fails (it clearly is finding a different merge base than
> the test expects).  I'll trace through it, but it will have to be later
> tonight.

The problem in t6024 is caused by the fact that the commit timestamps
for every commit are identical. The linear commit_list has the property
that we always insert a new commit at the end of a chain of commits with
the same timestamp. So it works as a stable priority queue in the sense
that items with the same priority are returned in insertion order.

But the heap-based priority queue does not. Nor can it do so without
extra storage requirements, as heaps are inherently unstable. The
simplest way to make it stable is to add an insertion counter to the
comparison function. The patch below does this, and it resolves the
issue. It does waste one int per queue element.

I think you could also make a priority queue based on a binary search
tree that would be stable. It's slightly less efficient to create an
initial queue (you can heapify in O(n), but building the tree takes O(n
lg n)).  But we do not care about that, as we always build the queue by
inserting elements, anyway.  The other downside of using a tree is that
you would want a self-balancing tree for good performance (especially
since we tend to insert commits in sorted order), which increases the
code complexity.

Anyway, since this isn't yielding any performance benefit, I'm not going
to go down that route. But stability of the queue is something that we
need to consider if we ever do replace commit_list with a different data
structure.

Here's the patch to make the existing priority queue stable (by wasting
space) in case we ever want to use it.

-Peff

diff --git a/commit.c b/commit.c
index 8259871..a99d909 100644
--- a/commit.c
+++ b/commit.c
@@ -593,7 +593,7 @@ static int interesting(struct queue *q)
 {
 	int i;
 	for (i = 0; i < q->nr; i++) {
-		struct commit *commit = q->items[i];
+		struct commit *commit = q->items[i].item;
 		if (commit->object.flags & STALE)
 			continue;
 		return 1;
diff --git a/queue.c b/queue.c
index 7be6b86..1bdd948 100644
--- a/queue.c
+++ b/queue.c
@@ -3,18 +3,28 @@ static void queue_heapify_up(struct queue *pq)
 
 static inline void queue_swap(struct queue *pq, unsigned i, unsigned j)
 {
-	void *tmp = pq->items[i];
+	struct queue_item tmp = pq->items[i];
 	pq->items[i] = pq->items[j];
 	pq->items[j] = tmp;
 }
 
+static inline int queue_cmp(struct queue *pq, unsigned i, unsigned j)
+{
+	int cmp = pq->cmp(pq->items[i].item, pq->items[j].item);
+	if (cmp)
+		return cmp;
+	if (pq->items[i].counter < pq->items[j].counter)
+		return 1;
+	return -1;
+}
+
 static void queue_heapify_up(struct queue *pq)
 {
 	unsigned i = pq->nr - 1;
 	while (i > 0) {
 		int parent = (i-1)/2;
 
-		if (pq->cmp(pq->items[i], pq->items[parent]) <= 0)
+		if (queue_cmp(pq, i, parent) <= 0)
 			return;
 
 		queue_swap(pq, i, parent);
@@ -25,7 +35,9 @@ void queue_insert(struct queue *pq, void *item)
 void queue_insert(struct queue *pq, void *item)
 {
 	ALLOC_GROW(pq->items, pq->nr + 1, pq->alloc);
-	pq->items[pq->nr++] = item;
+	pq->items[pq->nr].item = item;
+	pq->items[pq->nr].counter = pq->counter++;
+	pq->nr++;
 	queue_heapify_up(pq);
 }
 
@@ -35,11 +47,9 @@ static void queue_heapify_down(struct queue *pq)
 	while (1) {
 		int largest = i, left = 2*i + 1, right = 2*i + 2;
 
-		if (left < pq->nr &&
-		    pq->cmp(pq->items[left], pq->items[largest]) > 0)
+		if (left < pq->nr && queue_cmp(pq, left, largest) > 0)
 			largest = left;
-		if (right < pq->nr &&
-		    pq->cmp(pq->items[right], pq->items[largest]) > 0)
+		if (right < pq->nr && queue_cmp(pq, right, largest) > 0)
 			largest = right;
 
 		if (largest == i)
@@ -52,7 +62,7 @@ void *queue_peek(struct queue *pq)
 
 void *queue_peek(struct queue *pq)
 {
-	return pq->nr ? pq->items[0] : NULL;
+	return pq->nr ? pq->items[0].item : NULL;
 }
 
 void *queue_pop(struct queue *pq)
@@ -61,7 +71,7 @@ void *queue_pop(struct queue *pq)
 
 	if (!pq->nr)
 		return NULL;
-	ret = pq->items[0];
+	ret = pq->items[0].item;
 
 	pq->items[0] = pq->items[--pq->nr];
 	queue_heapify_down(pq);
diff --git a/queue.h b/queue.h
index cc471b5..a70f7d7 100644
--- a/queue.h
+++ b/queue.h
@@ -3,11 +3,17 @@ struct queue {
 
 typedef int (*queue_comparison_func_t)(const void *, const void *);
 
+struct queue_item {
+	void *item;
+	unsigned counter;
+};
+
 struct queue {
 	queue_comparison_func_t cmp;
-	void **items;
+	struct queue_item *items;
 	unsigned nr;
 	unsigned alloc;
+	unsigned counter;
 };
 
 void queue_insert(struct queue *pq, void *item);
