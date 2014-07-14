From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] paint_down_to_common: use prio_queue
Date: Mon, 14 Jul 2014 01:53:54 -0400
Message-ID: <20140714055354.GC4838@sigill.intra.peff.net>
References: <20140714054021.GA4422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 07:54:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ZD6-0007cS-MC
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 07:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbaGNFx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 01:53:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:33424 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752966AbaGNFx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 01:53:56 -0400
Received: (qmail 32325 invoked by uid 102); 14 Jul 2014 05:53:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jul 2014 00:53:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jul 2014 01:53:54 -0400
Content-Disposition: inline
In-Reply-To: <20140714054021.GA4422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253473>

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

While we are munging the "interesting" function, we also
take the opportunity to give it a more descriptive name, and
convert the return value to an int (we returned the first
interesting commit, but nobody ever looked at it).

Signed-off-by: Jeff King <peff@peff.net>
---
Same as what I posted a few weeks ago, but now we do not have to tweak
t6024 to account for the lack of stability.

 commit.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/commit.c b/commit.c
index acb74b5..1fc60c0 100644
--- a/commit.c
+++ b/commit.c
@@ -786,45 +786,41 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 
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
+		struct commit *commit = queue->array[i].data;
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
@@ -843,11 +839,11 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
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
 
-- 
2.0.0.566.gfe3e6b2
