Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1746C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C829613B7
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhDMHQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:16:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:50754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhDMHQP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:16:15 -0400
Received: (qmail 28512 invoked by uid 109); 13 Apr 2021 07:15:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:15:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22992 invoked by uid 111); 13 Apr 2021 07:15:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:15:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:15:54 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] is_promisor_object(): free tree buffer after parsing
Message-ID: <YHVFKgn7WN76QnRz@coredump.intra.peff.net>
References: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To get the list of all promisor objects, we not only include all objects
in promisor packs, but also parse each of those objects to see which
objects they reference. After parsing a tree object, the tree->buffer
field will remain populated until we explicitly free it. So in a partial
clone of blob:none, for example, we are essentially reading every tree
in the repository (since they're all in the initial promisor pack), and
keeping all of their uncompressed contents in memory at once.

This patch frees the tree buffers after we've finished marking all of
their reachable objects. We shouldn't need to do this for any other
object type. While we are using some extra memory to store the structs,
no other object type stores the whole contents in its parsed form (we do
sometimes hold on to commit buffers, but less so these days due to
commit graphs, plus most commands which care about promisor objects turn
off the save_commit_buffer global).

Even for a moderate-sized repository like git.git, this patch drops the
peak heap (as measured by massif) for git-fsck from ~1.7GB to ~138MB.
Fsck is a good candidate for measuring here because it doesn't interact
with the promisor code except to call is_promisor_object(), so we can
isolate just this problem.

The added perf test shows only a tiny improvement on my machine for
git.git, since 1.7GB isn't enough to cause any real memory pressure:

  Test                                 HEAD^               HEAD
  --------------------------------------------------------------------------------
  5600.4: fsck                         21.26(20.90+0.35)   20.84(20.79+0.04) -2.0%

With linux.git the absolute change is a bit bigger, though still a small
percentage:

  Test                          HEAD^                 HEAD
  -----------------------------------------------------------------------------
  5600.4: fsck                  262.26(259.13+3.12)   254.92(254.62+0.29) -2.8%

I didn't have the patience to run it under massif with linux.git, but
it's probably on the order of about 14GB improvement, since that's the
sum of the sizes of all of the uncompressed trees (but still isn't
enough to create memory pressure on this particular machine, which has
64GB of RAM). Smaller machines would probably see a bigger effect on
runtime (and sadly our perf suite does not measure peak heap).

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c                    | 1 +
 t/perf/p5600-partial-clone.sh | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/packfile.c b/packfile.c
index 8668345d93..b79cbc8cd4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2247,6 +2247,7 @@ static int add_promisor_object(const struct object_id *oid,
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
 			oidset_insert(set, &entry.oid);
+		free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
diff --git a/t/perf/p5600-partial-clone.sh b/t/perf/p5600-partial-clone.sh
index 3e04bd2ae1..754aaec3dc 100755
--- a/t/perf/p5600-partial-clone.sh
+++ b/t/perf/p5600-partial-clone.sh
@@ -23,4 +23,8 @@ test_perf 'checkout of result' '
 	git -C worktree checkout -f
 '
 
+test_perf 'fsck' '
+	git -C bare.git fsck
+'
+
 test_done
-- 
2.31.1.659.g9b9913af63

