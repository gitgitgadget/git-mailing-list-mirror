Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326BC20248
	for <e@80x24.org>; Thu,  4 Apr 2019 01:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDDByf (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 21:54:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:46256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726167AbfDDByf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 21:54:35 -0400
Received: (qmail 18992 invoked by uid 109); 4 Apr 2019 01:54:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 01:54:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13233 invoked by uid 111); 4 Apr 2019 01:55:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 21:55:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 21:54:33 -0400
Date:   Wed, 3 Apr 2019 21:54:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?QmrDtnJu?= Pettersson A 
        <bjorn.a.pettersson@ericsson.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] revision: use a prio_queue to hold rewritten parents
Message-ID: <20190404015432.GD4409@sigill.intra.peff.net>
References: <HE1PR0702MB3788FCDAB764252D9CBB42E5B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
 <20190402132756.GB13141@sigill.intra.peff.net>
 <20190404014108.GC4409@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404014108.GC4409@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 09:41:09PM -0400, Jeff King wrote:

> A few items to note:
> 
>   - the cache-list tweak does improve the bad case for llvm-project.git
>     that started my digging into this problem. But it performs terribly
>     on linux.git, barely helping at all.

Oops, that should be cache-last of course.  Just for completeness,
here's the patch for that (which I also showed earlier in the thread):

  diff --git a/revision.c b/revision.c
  index eb8e51bc63..492c4247c4 100644
  --- a/revision.c
  +++ b/revision.c
  @@ -921,7 +921,7 @@ static void commit_list_insert_by_date_cached(struct commit *p, struct commit_li
   	else
   		new_entry = commit_list_insert_by_date(p, head);
   
  -	if (cache && (!*cache || p->date < (*cache)->item->date))
  +	if (cache)
   		*cache = new_entry;
   }

>   - prio-queue just barely outperforms sort-after. As I said, I'm not
>     really sure why this is the case, but it is. You can see it even
>     more prominently in this real-world case on llvm-project.git:
> 
>       git rev-list --parents 07ef786652e7 -- llvm/test/CodeGen/Generic/bswap.ll
> 
>     where prio-queue routinely outperforms sort-after by about 7%. One
>     guess is that the prio-queue may just be more efficient because it
>     uses a compact array.

And much more interesting, here's the patch for sort-after. It's
possible I simply screwed something up, and that's why prio-queue is
faster.

Two things to note:

  - it sorts the new list, and then merges it in O(n) into the existing
    list. This should have identical behavior to the existing
    insert_by_date if the existing list is not sorted in the same way.
    I'm not sure if that's possible or not (e.g., due to topo order or
    similar). If it's not, then it might be slightly faster to just
    insert into the final list in the first place, and then sort the
    whole thing as one unit.

  - curiously, this seems to racily fail t6001. That script creates some
    new commits without using test_tick, so it may end up with several
    commits with the same timestamp. When this happens, it fails because
    two of the commits get reordered in the log output.

    That points to the sort not being stable. But generally mergesort
    _is_ stable (and I'm relying on the existing sort here). And I think
    my merge operation is stable, too. If anything, I'd have thought I'd
    screw something up with the prio-queue merge, but that one does
    behave reliably (heap queues are not inherently stable, but our
    prio_queue uses a counter to address that).

    So I dunno. Again, it's possible I simply screwed something up.

---
diff --git a/revision.c b/revision.c
index eb8e51bc63..a8cbe80636 100644
--- a/revision.c
+++ b/revision.c
@@ -911,26 +911,11 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		commit->object.flags |= TREESAME;
 }
 
-static void commit_list_insert_by_date_cached(struct commit *p, struct commit_list **head,
-		    struct commit_list *cached_base, struct commit_list **cache)
-{
-	struct commit_list *new_entry;
-
-	if (cached_base && p->date < cached_base->item->date)
-		new_entry = commit_list_insert_by_date(p, &cached_base->next);
-	else
-		new_entry = commit_list_insert_by_date(p, head);
-
-	if (cache && (!*cache || p->date < (*cache)->item->date))
-		*cache = new_entry;
-}
-
 static int process_parents(struct rev_info *revs, struct commit *commit,
-			   struct commit_list **list, struct commit_list **cache_ptr)
+			   struct commit_list **list, int insert_by_date)
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
-	struct commit_list *cached_base = cache_ptr ? *cache_ptr : NULL;
 
 	if (commit->object.flags & ADDED)
 		return 0;
@@ -965,8 +950,13 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
-			if (list)
-				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list) {
+				if (insert_by_date)
+					commit_list_insert_by_date(p, list);
+				else
+					commit_list_insert(p, list);
+			}
+
 		}
 		return 0;
 	}
@@ -1005,8 +995,12 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
-			if (list)
-				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list) {
+				if (insert_by_date)
+					commit_list_insert_by_date(p, list);
+				else
+					commit_list_insert(p, list);
+			}
 		}
 		if (revs->first_parent_only)
 			break;
@@ -1250,7 +1244,7 @@ static int limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (process_parents(revs, commit, &list, NULL) < 0)
+		if (process_parents(revs, commit, &list, 1) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -3117,7 +3111,7 @@ static void explore_walk_step(struct rev_info *revs)
 	if (revs->max_age != -1 && (c->date < revs->max_age))
 		c->object.flags |= UNINTERESTING;
 
-	if (process_parents(revs, c, NULL, NULL) < 0)
+	if (process_parents(revs, c, NULL, 0) < 0)
 		return;
 
 	if (c->object.flags & UNINTERESTING)
@@ -3260,7 +3254,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list *p;
 	struct topo_walk_info *info = revs->topo_walk_info;
-	if (process_parents(revs, commit, NULL, NULL) < 0) {
+	if (process_parents(revs, commit, NULL, 0) < 0) {
 		if (!revs->ignore_missing_links)
 			die("Failed to traverse parents of commit %s",
 			    oid_to_hex(&commit->object.oid));
@@ -3341,14 +3335,14 @@ int prepare_revision_walk(struct rev_info *revs)
 	return 0;
 }
 
-static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
+static enum rewrite_result rewrite_one_1(struct rev_info *revs,
+					 struct commit **pp,
+					 struct commit_list **list)
 {
-	struct commit_list *cache = NULL;
-
 	for (;;) {
 		struct commit *p = *pp;
 		if (!revs->limited)
-			if (process_parents(revs, p, &revs->commits, &cache) < 0)
+			if (process_parents(revs, p, list, 0) < 0)
 				return rewrite_one_error;
 		if (p->object.flags & UNINTERESTING)
 			return rewrite_one_ok;
@@ -3362,6 +3356,39 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	}
 }
 
+static struct commit_list *commit_list_merge_by_date(struct commit_list *a,
+						     struct commit_list *b)
+{
+	struct commit_list *ret = NULL, **tail = &ret;
+	while (a && b) {
+		if (a->item->date >= b->item->date) {
+			*tail = a;
+			tail = &a->next;
+			a = a->next;
+		} else {
+			*tail = b;
+			tail = &b->next;
+			b = b->next;
+		}
+	}
+	if (a)
+		*tail = a;
+	else
+		*tail = b;
+
+	return ret;
+}
+
+static enum rewrite_result rewrite_one(struct rev_info *revs,
+				       struct commit **pp)
+{
+	struct commit_list *list = NULL;
+	enum rewrite_result ret = rewrite_one_1(revs, pp, &list);
+	commit_list_sort_by_date(&list);
+	revs->commits = commit_list_merge_by_date(revs->commits, list);
+	return ret;
+}
+
 int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	rewrite_parent_fn_t rewrite_parent)
 {
@@ -3681,7 +3708,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 				try_to_simplify_commit(revs, commit);
 			else if (revs->topo_walk_info)
 				expand_topo_walk(revs, commit);
-			else if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
+			else if (process_parents(revs, commit, &revs->commits, 1) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
 						oid_to_hex(&commit->object.oid));
