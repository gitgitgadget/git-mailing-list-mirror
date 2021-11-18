Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C47CC43219
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753966138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhKRQxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57644 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhKRQwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AE3921FD54
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGJ3Y0RXvgjFuBOyhXbLOG2S0U9AxTOAy6AZJjmJcuA=;
        b=R+menAgysdkF18DM+BQFJEqW2VIJbhXfgyaGugEZ17d4wCZWQ9fX7oCxX/YO/hpKgoJSeO
        z0z3XkTLmW9iP2aALdRVASYSeqbwQBEFQ9GSSewPEVxGC5YDEHz3ns0dzgLTwBeVGQwQEl
        N/cfr1Uf2MW+rL2Tv5iMPhJn4J+jiAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGJ3Y0RXvgjFuBOyhXbLOG2S0U9AxTOAy6AZJjmJcuA=;
        b=RzVuTOwKPopgNgkXfv7wl6QGjMKTtvL7uMZLkhZNn3IY8UPrYSmtKJdv6rst0SfBmBVS2T
        64fXAJRdcQWCD3DA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A05B0A3BA0;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BB4CF1F2CBC; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 21/27] bisect: Reorganize commit weight computation
Date:   Thu, 18 Nov 2021 17:49:34 +0100
Message-Id: <20211118164940.8818-22-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reorganize commit weight computation a bit so that it is easier to
generalize for stochastic bisection. There's no real need for two
special values (-1 and -2). Also we can set weight of leaf nodes while
computing weight of nodes with one parent. Overall the code becomes a
bit simpler.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 93 +++++++++++++++++++++-----------------------------------
 1 file changed, 34 insertions(+), 59 deletions(-)

diff --git a/bisect.c b/bisect.c
index 680b96654fd4..4107161c086c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -158,17 +158,14 @@ static unsigned long sw_rev_bmp_test(struct st_weight *to, int idx)
 					(1UL << (idx % BITS_PER_LONG));
 }
 
-static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
+static int count_interesting_parents(struct commit *commit)
 {
 	struct commit_list *p;
 	int count;
 
-	for (count = 0, p = commit->parents; p; p = p->next) {
+	for (count = 0, p = commit->parents; p; p = p->next)
 		if (!(p->item->object.flags & UNINTERESTING))
 			count++;
-		if (bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)
-			break;
-	}
 	return count;
 }
 
@@ -326,18 +323,14 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 	return list;
 }
 
+#define WEIGHT_UNSET -1
+
 /*
- * zero or positive weight is the number of interesting commits it can
+ * Zero or positive weight is the number of interesting commits it can
  * reach, including itself.  Especially, weight = 0 means it does not
  * reach any tree-changing commits (e.g. just above uninteresting one
- * but traversal is with pathspec).
- *
- * weight = -1 means it has one parent and its distance is yet to
- * be computed.
- *
- * weight = -2 means it has more than one parent and its distance is
- * unknown.  After running count_distance() first, they will get zero
- * or positive distance.
+ * but traversal is with pathspec). We initialize weights to a special value
+ * WEIGHT_UNSET to identify commits for which we didn't compute weight yet.
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, unsigned bisect_flags)
@@ -346,32 +339,8 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	struct commit_list *p;
 
 	counted = 0;
-
-	for (p = list; p; p = p->next) {
-		struct commit *commit = p->item;
-		unsigned commit_flags = commit->object.flags;
-
-		switch (count_interesting_parents(commit, bisect_flags)) {
-		case 0:
-			if (!(commit_flags & TREESAME)) {
-				weight_set(p, 1);
-				counted++;
-				show_list("bisection 2 count one",
-					  counted, nr, list);
-			}
-			/*
-			 * otherwise, it is known not to reach any
-			 * tree-changing commit and gets weight 0.
-			 */
-			break;
-		case 1:
-			weight_set(p, -1);
-			break;
-		default:
-			weight_set(p, -2);
-			break;
-		}
-	}
+	for (p = list; p; p = p->next)
+		weight_set(p, WEIGHT_UNSET);
 
 	show_list("bisection 2 initialize", counted, nr, list);
 
@@ -389,21 +358,21 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	 * So we will first count distance of merges the usual
 	 * way, and then fill the blanks using cheaper algorithm.
 	 */
-	for (p = list; p; p = p->next) {
-		if (p->item->object.flags & UNINTERESTING)
-			continue;
-		if (weight(p) != -2)
-			continue;
-		if (bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)
-			BUG("shouldn't be calling count-distance in fp mode");
-		weight_set(p, count_distance(p));
-		clear_counted_flag(list);
+	if (!(bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)) {
+		for (p = list; p; p = p->next) {
+			if (p->item->object.flags & UNINTERESTING)
+				continue;
+			if (count_interesting_parents(p->item) <= 1)
+				continue;
+			weight_set(p, count_distance(p));
+			clear_counted_flag(list);
 
-		/* Does it happen to be at half-way? */
-		if (!(bisect_flags & FIND_BISECTION_ALL) &&
-		      approx_halfway(p, nr))
-			return p;
-		counted++;
+			/* Does it happen to be at half-way? */
+			if (!(bisect_flags & FIND_BISECTION_ALL) &&
+			      approx_halfway(p, nr))
+				return p;
+			counted++;
+		}
 	}
 
 	show_list("bisection 2 count_distance", counted, nr, list);
@@ -412,8 +381,9 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		for (p = list; p; p = p->next) {
 			struct commit_list *q;
 			unsigned commit_flags = p->item->object.flags;
+			int parent_weight = 0;
 
-			if (0 <= weight(p))
+			if (weight(p) != WEIGHT_UNSET)
 				continue;
 
 			for (q = p->item->parents;
@@ -421,10 +391,15 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			     q = bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY ? NULL : q->next) {
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
-				if (0 <= weight(q))
+				parent_weight = weight(q);
+				if (parent_weight != WEIGHT_UNSET)
 					break;
 			}
-			if (!q)
+			/*
+			 * Only parent with unset weight? We need to compute
+			 * other weights first.
+			 */
+			if (parent_weight == WEIGHT_UNSET)
 				continue;
 
 			/*
@@ -433,13 +408,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			 * otherwise inherit it from q directly.
 			 */
 			if (!(commit_flags & TREESAME)) {
-				weight_set(p, weight(q)+1);
+				weight_set(p, parent_weight + 1);
 				counted++;
 				show_list("bisection 2 count one",
 					  counted, nr, list);
 			}
 			else
-				weight_set(p, weight(q));
+				weight_set(p, parent_weight);
 
 			/* Does it happen to be at half-way? */
 			if (!(bisect_flags & FIND_BISECTION_ALL) &&
-- 
2.26.2

