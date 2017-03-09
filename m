Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE1C202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 13:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbdCINhW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 08:37:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:41278 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdCINhV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 08:37:21 -0500
Received: (qmail 19636 invoked by uid 109); 9 Mar 2017 13:29:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 13:29:52 +0000
Received: (qmail 5602 invoked by uid 111); 9 Mar 2017 13:30:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 08:30:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 08:29:50 -0500
Date:   Thu, 9 Mar 2017 08:29:49 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 4/4] ref-filter: use separate cache for contains_tag_algo
Message-ID: <20170309132949.shyc4gmdrhazykev@sigill.intra.peff.net>
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The algorithm which powers "tag --contains" uses the
TMP_MARK and UNINTERESTING bits, but never cleans up after
itself. As a result, stale UNINTERESTING bits may impact
later traversals (like "--merged").

We could fix this by clearing the bits after we're done with
the --contains traversal. That would be enough to fix the
existing problem, but it leaves future developers in a bad
spot: they cannot add other traversals that operate
simultaneously with --contains (e.g., if you wanted to add
"--no-contains" and use both filters at the same time).

Instead, we can use a commit slab to store our cached
results, which will store the bits outside of the commit
structs entirely. This adds an extra level of indirection,
but in my tests (running "git tag --contains HEAD" on
linux.git), there was no measurable slowdown.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 55 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5cb49b7c2..7eeecc608 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "trailer.h"
 #include "wt-status.h"
+#include "commit-slab.h"
 
 static struct ref_msg {
 	const char *gone;
@@ -1470,15 +1471,22 @@ static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom
 	*v = &ref->value[atom];
 }
 
+/*
+ * Unknown has to be "0" here, because that's the default value for
+ * contains_cache slab entries that have not yet been assigned.
+ */
 enum contains_result {
-	CONTAINS_UNKNOWN = -1,
-	CONTAINS_NO = 0,
-	CONTAINS_YES = 1
+	CONTAINS_UNKNOWN = 0,
+	CONTAINS_NO,
+	CONTAINS_YES
 };
 
+define_commit_slab(contains_cache, enum contains_result);
+
 struct ref_filter_cbdata {
 	struct ref_array *array;
 	struct ref_filter *filter;
+	struct contains_cache contains_cache;
 };
 
 /*
@@ -1509,20 +1517,22 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
  * Do not recurse to find out, though, but return -1 if inconclusive.
  */
 static enum contains_result contains_test(struct commit *candidate,
-			    const struct commit_list *want)
+					  const struct commit_list *want,
+					  struct contains_cache *cache)
 {
-	/* was it previously marked as containing a want commit? */
-	if (candidate->object.flags & TMP_MARK)
-		return CONTAINS_YES;
-	/* or marked as not possibly containing a want commit? */
-	if (candidate->object.flags & UNINTERESTING)
-		return CONTAINS_NO;
+	enum contains_result *cached = contains_cache_at(cache, candidate);
+
+	/* If we already have the answer cached, return that. */
+	if (*cached)
+		return *cached;
+
 	/* or are we it? */
 	if (in_commit_list(want, candidate)) {
-		candidate->object.flags |= TMP_MARK;
+		*cached = CONTAINS_YES;
 		return CONTAINS_YES;
 	}
 
+	/* Otherwise, we don't know; prepare to recurse */
 	parse_commit_or_die(candidate);
 	return CONTAINS_UNKNOWN;
 }
@@ -1535,10 +1545,11 @@ static void push_to_contains_stack(struct commit *candidate, struct contains_sta
 }
 
 static enum contains_result contains_tag_algo(struct commit *candidate,
-		const struct commit_list *want)
+					      const struct commit_list *want,
+					      struct contains_cache *cache)
 {
 	struct contains_stack contains_stack = { 0, 0, NULL };
-	enum contains_result result = contains_test(candidate, want);
+	enum contains_result result = contains_test(candidate, want, cache);
 
 	if (result != CONTAINS_UNKNOWN)
 		return result;
@@ -1550,16 +1561,16 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		struct commit_list *parents = entry->parents;
 
 		if (!parents) {
-			commit->object.flags |= UNINTERESTING;
+			*contains_cache_at(cache, commit) = CONTAINS_NO;
 			contains_stack.nr--;
 		}
 		/*
 		 * If we just popped the stack, parents->item has been marked,
 		 * therefore contains_test will return a meaningful yes/no.
 		 */
-		else switch (contains_test(parents->item, want)) {
+		else switch (contains_test(parents->item, want, cache)) {
 		case CONTAINS_YES:
-			commit->object.flags |= TMP_MARK;
+			*contains_cache_at(cache, commit) = CONTAINS_YES;
 			contains_stack.nr--;
 			break;
 		case CONTAINS_NO:
@@ -1571,13 +1582,14 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		}
 	}
 	free(contains_stack.contains_stack);
-	return contains_test(candidate, want);
+	return contains_test(candidate, want, cache);
 }
 
-static int commit_contains(struct ref_filter *filter, struct commit *commit)
+static int commit_contains(struct ref_filter *filter, struct commit *commit,
+			   struct contains_cache *cache)
 {
 	if (filter->with_commit_tag_algo)
-		return contains_tag_algo(commit, filter->with_commit) == CONTAINS_YES;
+		return contains_tag_algo(commit, filter->with_commit, cache) == CONTAINS_YES;
 	return is_descendant_of(commit, filter->with_commit);
 }
 
@@ -1774,7 +1786,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 			return 0;
 		/* We perform the filtering for the '--contains' option */
 		if (filter->with_commit &&
-		    !commit_contains(filter, commit))
+		    !commit_contains(filter, commit, &ref_cbdata->contains_cache))
 			return 0;
 	}
 
@@ -1874,6 +1886,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		broken = 1;
 	filter->kind = type & FILTER_REFS_KIND_MASK;
 
+	init_contains_cache(&ref_cbdata.contains_cache);
+
 	/*  Simple per-ref filtering */
 	if (!filter->kind)
 		die("filter_refs: invalid type");
@@ -1896,6 +1910,7 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			head_ref(ref_filter_handler, &ref_cbdata);
 	}
 
+	clear_contains_cache(&ref_cbdata.contains_cache);
 
 	/*  Filters that need revision walking */
 	if (filter->merge_commit)
-- 
2.12.0.445.g818af77e0
