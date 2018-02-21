Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130FA1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeBUX11 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:27:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:60132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750741AbeBUX10 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:27:26 -0500
Received: (qmail 21477 invoked by uid 109); 21 Feb 2018 23:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 23:27:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29156 invoked by uid 111); 21 Feb 2018 23:28:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 18:28:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 18:27:24 -0500
Date:   Wed, 21 Feb 2018 18:27:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] revision: drop --show-all option
Message-ID: <20180221232724.GD7944@sigill.intra.peff.net>
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
 <20180220225726.GA17496@sigill.intra.peff.net>
 <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
 <20180221184811.GD4333@sigill.intra.peff.net>
 <xmqqtvuax9te.fsf@gitster-ct.c.googlers.com>
 <20180221225002.GB7944@sigill.intra.peff.net>
 <xmqqinaqx7wp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinaqx7wp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 03:03:18PM -0800, Junio C Hamano wrote:

> > So what I'm wondering is whether we should consider just ripping it out
> > (but I'm OK with keeping it, as once the commit-buffer stuff is fixed,
> > it's probably not hurting anybody).
> 
> I see no problem in removing it.  With more "interesting" features
> relying on post-processing (like 'simplify-merges'), show_all whose
> primary focus was how limit_list() behaves soft of outlived its
> usefulness, I would think.

So here's a patch to do that (textually independent but conceptually on
top of the earlier one to fix the commit-buffer thing). It actually
doesn't remove that much code, so I could go either way on it.

+cc Linus in case he's secretly in love with this feature.

-- >8 --
Subject: [PATCH] revision: drop --show-all option

This was an undocumented debugging aid that does not seem to
have come in handy in the past decade, judging from its lack
of mentions on the mailing list.

Let's drop it in the name of simplicity. This is morally a
revert of 3131b71301 (Add "--show-all" revision walker flag
for debugging, 2008-02-09), but note that I did leave in the
mapping of UNINTERESTING to "^" in get_revision_mark(). I
don't think this would be possible to trigger with the
current code, but it's the only sensible marker.

We'll skip the usual deprecation period because this was
explicitly a debugging aid that was never documented.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c                           | 10 ---------
 revision.h                           |  1 -
 t/t6015-rev-list-show-all-parents.sh | 31 ----------------------------
 3 files changed, 42 deletions(-)
 delete mode 100755 t/t6015-rev-list-show-all-parents.sh

diff --git a/revision.c b/revision.c
index 5ce9b93baa..5c1cb7277c 100644
--- a/revision.c
+++ b/revision.c
@@ -1065,14 +1065,9 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (revs->show_all)
-				p = &commit_list_insert(commit, p)->next;
 			slop = still_interesting(list, date, slop, &interesting_cache);
 			if (slop)
 				continue;
-			/* If showing all, add the whole pending list to the end */
-			if (revs->show_all)
-				*p = list;
 			break;
 		}
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
@@ -1864,8 +1859,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->dense = 1;
 	} else if (!strcmp(arg, "--sparse")) {
 		revs->dense = 0;
-	} else if (!strcmp(arg, "--show-all")) {
-		revs->show_all = 1;
 	} else if (!strcmp(arg, "--in-commit-order")) {
 		revs->tree_blobs_in_commit_order = 1;
 	} else if (!strcmp(arg, "--remove-empty")) {
@@ -3094,8 +3087,6 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 		return commit_ignore;
 	if (revs->unpacked && has_sha1_pack(commit->object.oid.hash))
 		return commit_ignore;
-	if (revs->show_all)
-		return commit_show;
 	if (commit->object.flags & UNINTERESTING)
 		return commit_ignore;
 	if (revs->min_age != -1 &&
@@ -3194,7 +3185,6 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	enum commit_action action = get_commit_action(revs, commit);
 
 	if (action == commit_show &&
-	    !revs->show_all &&
 	    revs->prune && revs->dense && want_ancestry(revs)) {
 		/*
 		 * --full-diff on simplified parents is no good: it
diff --git a/revision.h b/revision.h
index 3dee97bfb9..b8c47b98e2 100644
--- a/revision.h
+++ b/revision.h
@@ -90,7 +90,6 @@ struct rev_info {
 	unsigned int	dense:1,
 			prune:1,
 			no_walk:2,
-			show_all:1,
 			remove_empty_trees:1,
 			simplify_history:1,
 			topo_order:1,
diff --git a/t/t6015-rev-list-show-all-parents.sh b/t/t6015-rev-list-show-all-parents.sh
deleted file mode 100755
index 3c73c93ba6..0000000000
--- a/t/t6015-rev-list-show-all-parents.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/sh
-
-test_description='--show-all --parents does not rewrite TREESAME commits'
-
-. ./test-lib.sh
-
-test_expect_success 'set up --show-all --parents test' '
-	test_commit one foo.txt &&
-	commit1=$(git rev-list -1 HEAD) &&
-	test_commit two bar.txt &&
-	commit2=$(git rev-list -1 HEAD) &&
-	test_commit three foo.txt &&
-	commit3=$(git rev-list -1 HEAD)
-	'
-
-test_expect_success '--parents rewrites TREESAME parents correctly' '
-	echo $commit3 $commit1 > expected &&
-	echo $commit1 >> expected &&
-	git rev-list --parents HEAD -- foo.txt > actual &&
-	test_cmp expected actual
-	'
-
-test_expect_success '--parents --show-all does not rewrites TREESAME parents' '
-	echo $commit3 $commit2 > expected &&
-	echo $commit2 $commit1 >> expected &&
-	echo $commit1 >> expected &&
-	git rev-list --parents --show-all HEAD -- foo.txt > actual &&
-	test_cmp expected actual
-	'
-
-test_done
-- 
2.16.2.555.g885a024879

