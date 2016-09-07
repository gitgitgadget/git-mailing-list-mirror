Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C31520705
	for <e@80x24.org>; Wed,  7 Sep 2016 07:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756644AbcIGHy3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 03:54:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:39164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756482AbcIGHy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 03:54:28 -0400
Received: (qmail 8803 invoked by uid 109); 7 Sep 2016 07:54:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 07:54:27 +0000
Received: (qmail 1184 invoked by uid 111); 7 Sep 2016 07:54:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 03:54:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 03:54:25 -0400
Date:   Wed, 7 Sep 2016 03:54:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 2/2] patch-ids: skip merge commits
Message-ID: <20160907075425.6jgamuwm66xbklu3@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch-ids code which powers "log --cherry-pick" doesn't
look at whether each commit is a merge or not. It just feeds
the commit's first parent to the diff, and ignores any
additional parents.

In theory, this might be useful if you wanted to find
equivalence between, say, a merge commit and a squash-merge
that does the same thing.  But that may also be the wrong
thing; the diffs may be the same, but the meaning of the two
commits is definitely not identical. We should err on the
side of _not_ matching such commits.

Moreover, we may spend a lot of extra time computing these
merge diffs. In the case that inspired this patch, a "git
format-patch --cherry-pick" dropped from over 3 minutes to
less than 4 seconds. This seems pretty drastic, but is
easily explained. The command was invoked by a "git rebase"
of an older topic branch; there had been tens of thousands
of commits on the upstream branch in the meantime. In
addition, this project used a topic-branch workflow with
occasional "back-merges" from "master" to each topic (to
resolve conflicts on the topics rather than in the merge
commits). So there were not only extra merges, but the diffs
for these back-merges were generally quite large (because
they represented _everything_ that had been merged to master
since the topic branched).

This patch just ignores merge commits entirely when
generating patch-ids, meaning they will never be matched
(from either side of a symmetric-diff traversal).

Signed-off-by: Jeff King <peff@peff.net>
---
 patch-ids.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index 77e4663..b1f8514 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -7,10 +7,12 @@
 int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1, int diff_header_only)
 {
-	if (commit->parents)
+	if (commit->parents) {
+		if (commit->parents->next)
+			return 0;
 		diff_tree_sha1(commit->parents->item->object.oid.hash,
 			       commit->object.oid.hash, "", options);
-	else
+	} else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
 	return diff_flush_patch_id(options, sha1, diff_header_only);
-- 
2.10.0.rc2.154.gb4a4b8b
