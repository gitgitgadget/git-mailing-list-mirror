Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B0EC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE00222314
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390600AbgBNSWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:43696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2394912AbgBNSWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:17 -0500
Received: (qmail 22949 invoked by uid 109); 14 Feb 2020 18:22:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23653 invoked by uid 111); 14 Feb 2020 18:31:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:16 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/15] pack-bitmap: refuse to do a bitmap traversal with
 pathspecs
Message-ID: <20200214182216.GD150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rev-list has refused to use bitmaps with pathspec limiting since
c8a70d3509 (rev-list: disable --use-bitmap-index when pruning commits,
2015-07-01). But this is true not just for rev-list, but for anyone who
calls prepare_bitmap_walk(); the code isn't equipped to handle this
case.  We never noticed because the only other callers would never pass
a pathspec limiter.

But let's push the check down into prepare_bitmap_walk() anyway. That's
a more logical place for it to live, as callers shouldn't need to know
the details (and must be prepared to fall back to a regular traversal
anyway, since there might not be bitmaps in the repository).

It would also prepare us for a day where this case _is_ handled, but
that's pretty unlikely. E.g., we could use bitmaps to generate the set
of commits, and then diff each commit to see if it matches the pathspec.
That would be slightly faster than a naive traversal that actually walks
the commits. But you'd probably do better still to make use of the newer
commit-graph feature to make walking the commits very cheap.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c |  2 +-
 pack-bitmap.c      | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bce406bd1e..4cb5a52dee 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -533,7 +533,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_delayed_progress(show_progress, 0);
 
-	if (use_bitmap_index && !revs.prune) {
+	if (use_bitmap_index) {
 		if (revs.count && !revs.left_right && !revs.cherry_mark) {
 			uint32_t commit_count;
 			int max_count = revs.max_count;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6c06099dc7..a97b717e55 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -715,9 +715,19 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	struct bitmap *wants_bitmap = NULL;
 	struct bitmap *haves_bitmap = NULL;
 
-	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
+	struct bitmap_index *bitmap_git;
+
+	/*
+	 * We can't do pathspec limiting with bitmaps, because we don't know
+	 * which commits are associated with which object changes (let alone
+	 * even which objects are associated with which paths).
+	 */
+	if (revs->prune)
+		return NULL;
+
 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
+	bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
-- 
2.25.0.796.gcc29325708

