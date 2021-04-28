Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C816C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9D5608FE
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbhD1Po4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:44:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:38236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241224AbhD1Pna (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 11:43:30 -0400
Received: (qmail 8937 invoked by uid 109); 28 Apr 2021 15:42:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Apr 2021 15:42:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 708 invoked by uid 111); 28 Apr 2021 15:42:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Apr 2021 11:42:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Apr 2021 11:42:43 -0400
From:   Jeff King <peff@peff.net>
To:     David Emett <dave@sp4m.net>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 2/2] prune: save reachable-from-recent objects with bitmaps
Message-ID: <YImCcxVq6AWjtv8k@coredump.intra.peff.net>
References: <YImCNXC5DUvy5gT8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YImCNXC5DUvy5gT8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass our prune expiration to mark_reachable_objects(), which will
traverse not only the reachable objects, but consider any recent ones as
tips for reachability; see d3038d22f9 (prune: keep objects reachable
from recent objects, 2014-10-15) for details.

However, this interacts badly with the bitmap code path added in
fde67d6896 (prune: use bitmaps for reachability traversal, 2019-02-13).
If we hit the bitmap-optimized path, we return immediately to avoid the
regular traversal, accidentally skipping the "also traverse recent"
code.

Instead, we should do an if-else for the bitmap versus regular
traversal, and then follow up with the "recent" traversal in either
case. This reuses the "rev_info" for a bitmap and then a regular
traversal, but that should work OK (the bitmap code clears the pending
array in the usual way, just like a regular traversal would).

Note that I dropped the comment above the regular traversal here.  It
has little explanatory value, and makes the if-else logic much harder to
read.

Here are a few variants that I rejected:

  - it seems like both the reachability and recent traversals could be
    done in a single traversal. This was rejected by d3038d22f9 (prune:
    keep objects reachable from recent objects, 2014-10-15), though the
    balance may be different when using bitmaps. However, there's a
    subtle correctness issue, too: we use revs->ignore_missing_links for
    the recent traversal, but not the reachability one.

  - we could try using bitmaps for the recent traversal, too, which
    could possibly improve performance. But it would require some fixes
    in the bitmap code, which uses ignore_missing_links for its own
    purposes. Plus it would probably not help all that much in practice.
    We use the reachable tips to generate bitmaps, so those objects are
    likely not covered by bitmaps (unless they just became unreachable).
    And in general, we expect the set of unreachable objects to be much
    smaller anyway, so there's less to gain.

The test in t5304 detects the bug and confirms the fix.

I also beefed up the tests in t6501, which covers the mtime-checking
code more thoroughly, to handle the bitmap case (in addition to just
"loose" and "packed" cases). Interestingly, this test doesn't actually
detect the bug, because it is running "git gc", and not "prune"
directly. And "gc" will call "repack" first, which does not suffer the
same bug. So the old-but-reachable-from-recent objects get scooped up
into the new pack along with the actually-recent objects, which gives
both a recent mtime. But it seemed prudent to get more coverage of the
bitmap case for related code.

Reported-by: David Emett <dave@sp4m.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 reachable.c                | 13 ++++---------
 t/t5304-prune.sh           | 16 ++++++++++++++++
 t/t6501-freshen-objects.sh | 21 +++++++++++++++------
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/reachable.c b/reachable.c
index 77a60c70a5..a088717eb5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -227,17 +227,12 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	if (bitmap_git) {
 		traverse_bitmap_commit_list(bitmap_git, revs, mark_object_seen);
 		free_bitmap_index(bitmap_git);
-		return;
+	} else {
+		if (prepare_revision_walk(revs))
+			die("revision walk setup failed");
+		traverse_commit_list(revs, mark_commit, mark_object, &cp);
 	}
 
-	/*
-	 * Set up the revision walk - this will move all commits
-	 * from the pending list to the commit walking list.
-	 */
-	if (prepare_revision_walk(revs))
-		die("revision walk setup failed");
-	traverse_commit_list(revs, mark_commit, mark_object, &cp);
-
 	if (mark_recent) {
 		revs->ignore_missing_links = 1;
 		if (add_unseen_recent_objects_to_traversal(revs, mark_recent))
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index b447ce56a9..3475b06aeb 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -352,4 +352,20 @@ test_expect_success 'trivial prune with bitmaps enabled' '
 	test_must_fail git cat-file -e $blob
 '
 
+test_expect_success 'old reachable-from-recent retained with bitmaps' '
+	git repack -adb &&
+	to_drop=$(echo bitmap-from-recent-1 | git hash-object -w --stdin) &&
+	test-tool chmtime -86400 .git/objects/$(test_oid_to_path $to_drop) &&
+	to_save=$(echo bitmap-from-recent-2 | git hash-object -w --stdin) &&
+	test-tool chmtime -86400 .git/objects/$(test_oid_to_path $to_save) &&
+	tree=$(printf "100644 blob $to_save\tfile\n" | git mktree) &&
+	test-tool chmtime -86400 .git/objects/$(test_oid_to_path $tree) &&
+	commit=$(echo foo | git commit-tree $tree) &&
+	git prune --expire=12.hours.ago &&
+	git cat-file -e $commit &&
+	git cat-file -e $tree &&
+	git cat-file -e $to_save &&
+	test_must_fail git cat-file -e $to_drop
+'
+
 test_done
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 75210f012b..de7742cc51 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -43,15 +43,24 @@ commit () {
 }
 
 maybe_repack () {
-	if test -n "$repack"; then
+	case "$title" in
+	loose)
+		: skip repack
+		;;
+	repack)
 		git repack -ad
-	fi
+		;;
+	bitmap)
+		git repack -adb
+		;;
+	*)
+		echo >&2 "unknown test type in maybe_repack"
+		return 1
+		;;
+	esac
 }
 
-for repack in '' true; do
-	title=${repack:+repack}
-	title=${title:-loose}
-
+for title in loose repack bitmap; do
 	test_expect_success "make repo completely empty ($title)" '
 		rm -rf .git &&
 		git init
-- 
2.31.1.791.g8400859cdc
