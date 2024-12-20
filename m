Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F119ADA2
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684593; cv=none; b=GYyfea4c0cC3mN99fSaBE6BO6XB+t6ZkK3soSNG5RFxKODBJeTMA7GxkUsJUkPTolh3kR63Xz/hZAPaEU0MqcJetzzs4DRhEJKHavwOMm1W+Mb3g2pNCMDt7z2kf2XdG0/fw+ybKPGz4vgL6z71t7MiM67afhZQ4qU163wJzyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684593; c=relaxed/simple;
	bh=rcyz4oo6xi+UFsXzWjIqxjYPU231EifsntSR05356Ag=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N2lvIu/8MClRjQYk8ebYneOzWGgY7+mtnm87XgjV2+hoDsTZdtADSgkSTLjCXbg8oxflXiuYXu1kM0VjZSCT4Q6tTW102Gll7bnPCb7CXysI+yhDbYcMbTx/lWTFfjrV1DuvMMjt68RmBh74hL6uW8N7kkCdjKFbsWfx5cQUDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DiKckMch; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DiKckMch"
Received: (qmail 8313 invoked by uid 109); 20 Dec 2024 08:49:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=rcyz4oo6xi+UFsXzWjIqxjYPU231EifsntSR05356Ag=; b=DiKckMch6pZnnu3hdM59tp4VkCXG42YiGKIUZ3TasR9owIsjXkW7ljNKp8OV18GO3ZXKxJzYS+1BhWKZy4yheb0qLAYwsTXvWea/ll+ONqspZSUVp8fPF4I98sJ5sOaUhRLSxZnMOSY2eemKX8VMj+/NEEzJqtcxjZL489jWLbmhACapZ3tajk8jM+yl9wBeZ2EEroYfLNMilQLkFUV7iF+VZ51XqFsq0aIW/Ukv+9W9NLzscgL9//nci+/7PK+da7xmevP++iY/y/uVCyK/pl1Tz+IBnKQCtY/aPhD5uH6yW2ogxFtZihQ4h2C88nw4qBmqkct5BU6W1Ppl0dKDGA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 08:49:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14295 invoked by uid 111); 20 Dec 2024 08:49:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 03:49:49 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 03:49:49 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] prio-queue: use size_t rather than int for size
Message-ID: <20241220084949.GA132704@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The alloc and nr fields of a prio-queue tell us how much memory is
allocated and used in the array. So the natural type for them is size_t,
which prevents overflow on 64-bit systems where "int" is still 32 bits.

This is unlikely to happen in practice, as we typically use it for
storing commits, and having 2^31 of those is rather a lot. But it's good
to keep our generic data structures as flexible as possible. And as we
start to enforce -Wsign-compare, it means that callers need to use
"int", too, and the problem proliferates. Let's fix it at the source.

The changes here can be put into a few groups:

  1. Changing the alloc/nr fields in the struct to size_t. This requires
     swapping out int for size_t in negotiator/skipping.c, as well as
     in prio_queue_get(), because those all iterate over the array.
     Building with -Wsign-compare complains about these.

  2. Other code that assigns or passes around indexes into the array
     (e.g., the swap() and compare() functions) won't trigger
     -Wsign-compare because we are simply truncating the values. These
     are caught by -Wconversion, but I've adjusted them here to
     future-proof us.

  3. In prio_queue_reverse() we compute "queue->nr - 1" without checking
     if anything is in the queue, which underflows now that nr is
     unsigned. We can fix that by returning early when the queue is
     empty (there is nothing to reverse).

  4. The insertion_ctr variable is currently unsigned, but can likewise
     grow (it is actually worse, because adding and removing an element
     many times will keep increasing the counter, even though "nr" does
     not). I've bumped that to size_t here, as well.

     But -Wconversion notes that computing the "cmp" result by
     subtracting the counters and assigning to "int" is a potential
     problem. And that's true even before this patch, since we use an
     unsigned counter (imagine comparing "2^32-1" and "0", which should
     be a high positive value, but instead is "-1" as a signed int).

     Since we only care about the sign (and not the magnitude) of the
     result, we could fix this by swapping out the subtraction for a
     ternary comparison. Probably the performance impact would be
     negligible, since we just called into a custom compare function and
     branched on its result anyway. But it's easy enough to do a
     branchless version by subtracting the comparison results.

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed this because the -Wsign-compare topic hit next, which raised a
few warnings with my local branches (but I think prio-queue is in the
wrong here, hence this patch). It did turn out a little more involved
than I had expected, but I think the end result is more future-proof.

 negotiator/skipping.c |  5 ++---
 prio-queue.c          | 15 +++++++++------
 prio-queue.h          |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index abedb70a48..616df6bf3a 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -134,7 +134,6 @@ static int push_parent(struct data *data, struct entry *entry,
 	struct entry *parent_entry;
 
 	if (to_push->object.flags & SEEN) {
-		int i;
 		if (to_push->object.flags & POPPED)
 			/*
 			 * The entry for this commit has already been popped,
@@ -145,7 +144,7 @@ static int push_parent(struct data *data, struct entry *entry,
 		/*
 		 * Find the existing entry and use it.
 		 */
-		for (i = 0; i < data->rev_list.nr; i++) {
+		for (size_t i = 0; i < data->rev_list.nr; i++) {
 			parent_entry = data->rev_list.array[i].data;
 			if (parent_entry->commit == to_push)
 				goto parent_found;
@@ -248,7 +247,7 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 static void release(struct fetch_negotiator *n)
 {
 	struct data *data = n->data;
-	for (int i = 0; i < data->rev_list.nr; i++)
+	for (size_t i = 0; i < data->rev_list.nr; i++)
 		free(data->rev_list.array[i].data);
 	clear_prio_queue(&data->rev_list);
 	FREE_AND_NULL(data);
diff --git a/prio-queue.c b/prio-queue.c
index 450775a374..d0581dcc5c 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -1,26 +1,29 @@
 #include "git-compat-util.h"
 #include "prio-queue.h"
 
-static inline int compare(struct prio_queue *queue, int i, int j)
+static inline int compare(struct prio_queue *queue, size_t i, size_t j)
 {
 	int cmp = queue->compare(queue->array[i].data, queue->array[j].data,
 				 queue->cb_data);
 	if (!cmp)
-		cmp = queue->array[i].ctr - queue->array[j].ctr;
+		cmp = (queue->array[i].ctr > queue->array[j].ctr) -
+	              (queue->array[i].ctr < queue->array[j].ctr);
 	return cmp;
 }
 
-static inline void swap(struct prio_queue *queue, int i, int j)
+static inline void swap(struct prio_queue *queue, size_t i, size_t j)
 {
 	SWAP(queue->array[i], queue->array[j]);
 }
 
 void prio_queue_reverse(struct prio_queue *queue)
 {
-	int i, j;
+	size_t i, j;
 
 	if (queue->compare)
 		BUG("prio_queue_reverse() on non-LIFO queue");
+	if (!queue->nr)
+		return;
 	for (i = 0; i < (j = (queue->nr - 1) - i); i++)
 		swap(queue, i, j);
 }
@@ -35,7 +38,7 @@ void clear_prio_queue(struct prio_queue *queue)
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
-	int ix, parent;
+	size_t ix, parent;
 
 	/* Append at the end */
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
@@ -58,7 +61,7 @@ void prio_queue_put(struct prio_queue *queue, void *thing)
 void *prio_queue_get(struct prio_queue *queue)
 {
 	void *result;
-	int ix, child;
+	size_t ix, child;
 
 	if (!queue->nr)
 		return NULL;
diff --git a/prio-queue.h b/prio-queue.h
index 4f9a37e6be..36f370625f 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -30,7 +30,7 @@ struct prio_queue {
 	prio_queue_compare_fn compare;
 	unsigned insertion_ctr;
 	void *cb_data;
-	int alloc, nr;
+	size_t alloc, nr;
 	struct prio_queue_entry *array;
 };
 
-- 
2.48.0.rc0.406.g65874f98ea
