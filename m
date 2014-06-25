From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] paint_down_to_common: use prio_queue
Date: Wed, 25 Jun 2014 19:39:52 -0400
Message-ID: <20140625233952.GC23146@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:39:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzwnF-00032y-TL
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676AbaFYXjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:39:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:51218 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755212AbaFYXjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:39:53 -0400
Received: (qmail 4979 invoked by uid 102); 25 Jun 2014 23:39:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:39:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:39:52 -0400
Content-Disposition: inline
In-Reply-To: <20140625233429.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252475>

When we are traversing to find merge bases, we keep our
usual commit_list of commits to process, sorted by their
commit timestamp. As we add each parent to the list, we have
to spend "O(width of history)" to do the insertion, where
the width of history is the number of simultaneous lines of
development.

If we instead use a heap-based priority queue, we can do
these insertions in "O(log width)" time. This provides minor
speedups to merge-base calculations (timings in linux.git,
warm cache, best-of-five):

  [before]
  $ git merge-base HEAD v2.6.12
  real    0m3.251s
  user    0m3.148s
  sys     0m0.104s

  [after]
  $ git merge-base HEAD v2.6.12
  real    0m3.234s
  user    0m3.108s
  sys     0m0.128s

That's only an 0.5% speedup, but it does help protect us
against pathological cases.

The downside is that our priority queue is not stable, which
means that commits with the same timestamp may not come out
in the order we put them in. You can see this in the test
update in t6024. That test does a recursive merge across a
set of commits that all have the same timestamp. For the
virtual ancestor, the test currently ends up with blob like
this:

    <<<<<<< Temporary merge branch 1
    <<<<<<< Temporary merge branch 1
    C
    =======
    B
    >>>>>>> Temporary merge branch 2
    =======
    A
    >>>>>>> Temporary merge branch 2

but with this patch, the positions of B and A are swapped.
This is probably fine, as the order is an internal
implementation detail anyway (it would _not_ be fine if we
were using a priority queue for "git log" traversal, which
should show commits in parent order).

While we are munging the "interesting" function, we also
take the opportunity to give it a more descriptive name, and
convert the return value to an int (we returned the first
interesting commit, but nobody ever looked at it).

Signed-off-by: Jeff King <peff@peff.net>
---
This one is not strictly required for the series; it's just that I'm
adding what is essentially a clone of paint_down_to_common later in the
series. I wanted to use the priority queue there, too, so I looked into
using it here.

I'm slightly hesitant because of the stability thing mentioned above. I
_think_ it's probably fine. But we could also implement a
stable_prio_queue on top of the existing prio_queue if we're concerned
(and that may be something we want to do anyway, because "git log" would
want that if it switched to a priority queue).

I had no recollection while writing this patch, but after searching the
list for "stable priority queue", I realized that Junio and I discussed
it quite extensively a few years ago:

  http://thread.gmane.org/gmane.comp.version-control.git/204386/focus=204534

I think the conclusion there is that what this patch does is acceptable.

 commit.c                   | 42 +++++++++++++++++++-----------------------
 t/t6024-recursive-merge.sh |  2 +-
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/commit.c b/commit.c
index 881be3b..445b679 100644
--- a/commit.c
+++ b/commit.c
@@ -729,45 +729,41 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 
 static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
 
-static struct commit *interesting(struct commit_list *list)
+static int queue_has_nonstale(struct prio_queue *queue)
 {
-	while (list) {
-		struct commit *commit = list->item;
-		list = list->next;
-		if (commit->object.flags & STALE)
-			continue;
-		return commit;
+	int i;
+	for (i = 0; i < queue->nr; i++) {
+		struct commit *commit = queue->array[i];
+		if (!(commit->object.flags & STALE))
+			return 1;
 	}
-	return NULL;
+	return 0;
 }
 
 /* all input commits in one and twos[] must have been parsed! */
 static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
 {
-	struct commit_list *list = NULL;
+	struct prio_queue queue = { compare_commits_by_commit_date };
 	struct commit_list *result = NULL;
 	int i;
 
 	one->object.flags |= PARENT1;
-	commit_list_insert_by_date(one, &list);
-	if (!n)
-		return list;
+	if (!n) {
+		commit_list_append(one, &result);
+		return result;
+	}
+	prio_queue_put(&queue, one);
+
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
-		commit_list_insert_by_date(twos[i], &list);
+		prio_queue_put(&queue, twos[i]);
 	}
 
-	while (interesting(list)) {
-		struct commit *commit;
+	while (queue_has_nonstale(&queue)) {
+		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
-		struct commit_list *next;
 		int flags;
 
-		commit = list->item;
-		next = list->next;
-		free(list);
-		list = next;
-
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
@@ -786,11 +782,11 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 			if (parse_commit(p))
 				return NULL;
 			p->object.flags |= flags;
-			commit_list_insert_by_date(p, &list);
+			prio_queue_put(&queue, p);
 		}
 	}
 
-	free_commit_list(list);
+	clear_prio_queue(&queue);
 	return result;
 }
 
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 755d30c..c3c634f 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -76,7 +76,7 @@ test_expect_success "result contains a conflict" "test_cmp expect a1"
 
 git ls-files --stage > out
 cat > expect << EOF
-100644 439cc46de773d8a83c77799b7cc9191c128bfcff 1	a1
+100644 222cbac87715ba85080f8b1463833bb3cfb3b9e0 1	a1
 100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
-- 
2.0.0.566.gfe3e6b2
