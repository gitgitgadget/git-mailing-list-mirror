Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8E61F859
	for <e@80x24.org>; Wed,  7 Sep 2016 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbcIGWEo (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:04:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:39706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752563AbcIGWEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 18:04:43 -0400
Received: (qmail 29638 invoked by uid 109); 7 Sep 2016 22:04:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 22:04:43 +0000
Received: (qmail 8529 invoked by uid 111); 7 Sep 2016 22:04:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 18:04:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:04:40 -0400
Date:   Wed, 7 Sep 2016 18:04:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 3/3] patch-ids: use commit sha1 as patch-id for merge commits
Message-ID: <20160907220439.ukbqnj5biaro2lxv@sigill.intra.peff.net>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
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
that does the same thing.  But it also promotes a false
equivalence between distinct merges; for example, every
"merge -s ours" would look like an empty commit (which is
true in a sense, but presumably there was a value in merging
in the discarded history). Since patch-ids are meant for
throwing away duplicates, we should err on the side of _not_
matching such merges.

Moreover, we may spend a lot of extra time computing these
merge diffs. In the case that inspired this patch, a "git
format-patch --cherry-pick" dropped from over 3 minutes to
less than 4 seconds.

This seems pretty drastic, but is easily explained. The
command was invoked by a "git rebase" of an older topic
branch; there had been tens of thousands of commits on the
upstream branch in the meantime. In addition, this project
used a topic-branch workflow with occasional "back-merges"
from "master" to each topic (to resolve conflicts on the
topics rather than in the merge commits). So there were not
only extra merges, but the diffs for these back-merges were
generally quite large (because they represented _everything_
that had been merged to master since the topic branched).

This patch defines the patch-id of a merge commit as
essentially "null"; it has no patch-id. As a result,
merges cannot match patch-ids via "--cherry-pick", and
"format-patch --base" will not list merges in its list of
prerequisite patch ids.

We can signal the null patch-id by returning "-1" from
commit_patch_id(), as it no longer returns any meaningful
errors (and as a result, its callers are updated to handle
"-1" differently).

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c |  2 +-
 patch-ids.c   | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 92dc34d..e660034 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1344,7 +1344,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		if (commit->util)
 			continue;
 		if (commit_patch_id(commit, &diffopt, sha1, 0))
-			die(_("cannot get patch id"));
+			continue;
 		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
 		patch_id = bases->patch_id + bases->nr_patch_id;
 		hashcpy(patch_id->hash, sha1);
diff --git a/patch-ids.c b/patch-ids.c
index 0e95220..197c70b 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -7,10 +7,12 @@
 int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1, int diff_header_only)
 {
-	if (commit->parents)
+	if (commit->parents) {
+		if (commit->parents->next)
+			return -1;
 		diff_tree_sha1(commit->parents->item->object.oid.hash,
 			       commit->object.oid.hash, "", options);
-	else
+	} else
 		diff_root_tree_sha1(commit->object.oid.hash, "", options);
 	diffcore_std(options);
 	diff_flush_patch_id(options, sha1, diff_header_only);
@@ -19,7 +21,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 
 /*
  * When we cannot load the full patch-id for both commits for whatever
- * reason, the function returns -1 (i.e. return error(...)). Despite
+ * reason, the function returns -1. Despite
  * the "cmp" in the name of this function, the caller only cares about
  * the return value being zero (a and b are equivalent) or non-zero (a
  * and b are different), and returning non-zero would keep both in the
@@ -33,12 +35,10 @@ static int patch_id_cmp(struct patch_id *a,
 {
 	if (is_null_sha1(a->patch_id) &&
 	    commit_patch_id(a->commit, opt, a->patch_id, 0))
-		return error("Could not get patch ID for %s",
-			oid_to_hex(&a->commit->object.oid));
+		return -1;
 	if (is_null_sha1(b->patch_id) &&
 	    commit_patch_id(b->commit, opt, b->patch_id, 0))
-		return error("Could not get patch ID for %s",
-			oid_to_hex(&b->commit->object.oid));
+		return -1;
 	return hashcmp(a->patch_id, b->patch_id);
 }
 
-- 
2.10.0.rc2.154.gb4a4b8b
