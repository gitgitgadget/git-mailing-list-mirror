From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] prio-queue: make output stable with respect to insertion
Date: Mon, 14 Jul 2014 01:51:59 -0400
Message-ID: <20140714055159.GB4838@sigill.intra.peff.net>
References: <20140714054021.GA4422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 07:52:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ZBI-00067T-0I
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 07:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbaGNFwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 01:52:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:33421 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752274AbaGNFwB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 01:52:01 -0400
Received: (qmail 32226 invoked by uid 102); 14 Jul 2014 05:52:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jul 2014 00:52:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jul 2014 01:51:59 -0400
Content-Disposition: inline
In-Reply-To: <20140714054021.GA4422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253472>

If two items are added to a prio_queue and compare equal,
they currently come out in an apparently random order (this
order is deterministic for a particular sequence of
insertions and removals, but does not necessarily match the
insertion order). This makes it unlike using a date-ordered
commit_list, which is one of the main types we would like to
replace with it (because prio_queue does not suffer from
O(n) insertions).

We can make the priority queue stable by keeping an
insertion counter for each element, and using it to break
ties. This does increase the memory usage of the structure
(one int per element), but in practice it does not seem to
affect runtime. A best-of-five "git rev-list --topo-order"
on linux.git showed less than 1% difference (well within the
run-to-run noise).

In an ideal world, we would offer both stable and unstable
priority queues (the latter to try to maximize performance).
However, given the lack of a measurable performance
difference, it is not worth the extra code.

Signed-off-by: Jeff King <peff@peff.net>
---
I actually tried implementing a stable queue on top of the existing
prio-queue. However, it was quite a mess. Because prio_queue only stores
one void pointer to a thing, the stable queue has to allocate its own its
(counter,thing) pair. Doing it in a separate array doesn't work (you do
not pop them in insertion order, so you end up with "holes"). So you end
up storing an extra pointer, _plus_ per-entry malloc overhead.

If we really want to offer a non-stable queue (and I do not think we
do), we should probably just do two totally separate queues, or
implement the whole thing with a run-time "element size" member (or even
do it in macros).

I use struct assignment in the swap() function below. Do we want to
replace that with a memcpy? Presumably decent compilers can turn that
into the same code anyway, but I find the assignment more readable, and
IIRC it has been around since C89.

 prio-queue.c | 15 ++++++++++-----
 prio-queue.h |  8 +++++++-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index 0f4fcf2..e4365b0 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -3,14 +3,16 @@
 
 static inline int compare(struct prio_queue *queue, int i, int j)
 {
-	int cmp = queue->compare(queue->array[i], queue->array[j],
+	int cmp = queue->compare(queue->array[i].data, queue->array[j].data,
 				 queue->cb_data);
+	if (!cmp)
+		cmp = queue->array[i].ctr - queue->array[j].ctr;
 	return cmp;
 }
 
 static inline void swap(struct prio_queue *queue, int i, int j)
 {
-	void *tmp = queue->array[i];
+	struct prio_queue_entry tmp = queue->array[i];
 	queue->array[i] = queue->array[j];
 	queue->array[j] = tmp;
 }
@@ -31,6 +33,7 @@ void clear_prio_queue(struct prio_queue *queue)
 	queue->nr = 0;
 	queue->alloc = 0;
 	queue->array = NULL;
+	queue->insertion_ctr = 0;
 }
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
@@ -39,7 +42,9 @@ void prio_queue_put(struct prio_queue *queue, void *thing)
 
 	/* Append at the end */
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
-	queue->array[queue->nr++] = thing;
+	queue->array[queue->nr].ctr = queue->insertion_ctr++;
+	queue->array[queue->nr].data = thing;
+	queue->nr++;
 	if (!queue->compare)
 		return; /* LIFO */
 
@@ -61,9 +66,9 @@ void *prio_queue_get(struct prio_queue *queue)
 	if (!queue->nr)
 		return NULL;
 	if (!queue->compare)
-		return queue->array[--queue->nr]; /* LIFO */
+		return queue->array[--queue->nr].data; /* LIFO */
 
-	result = queue->array[0];
+	result = queue->array[0].data;
 	if (!--queue->nr)
 		return result;
 
diff --git a/prio-queue.h b/prio-queue.h
index 9c3cd1f..d030ec9 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -21,11 +21,17 @@
  */
 typedef int (*prio_queue_compare_fn)(const void *one, const void *two, void *cb_data);
 
+struct prio_queue_entry {
+	unsigned ctr;
+	void *data;
+};
+
 struct prio_queue {
 	prio_queue_compare_fn compare;
+	unsigned insertion_ctr;
 	void *cb_data;
 	int alloc, nr;
-	void **array;
+	struct prio_queue_entry *array;
 };
 
 /*
-- 
2.0.0.566.gfe3e6b2
