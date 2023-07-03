Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D15EB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGCGob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGCGoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DA51B4
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:22 -0700 (PDT)
Received: (qmail 14075 invoked by uid 109); 3 Jul 2023 06:44:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2634 invoked by uid 111); 3 Jul 2023 06:44:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/14] merge-tree: mark unused parameter in traverse callback
Message-ID: <20230703064421.GI3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our threeway_callback() does not bother to look at its "n" parameter. It
is static in this file and used only by trivial_merge_trees(), which
always passes 3 trees (hence the name "threeway"). It also does not look
at "dirmask". This is OK, as it handles directories specifically by
looking at the mode bits.

Other traverse_info callbacks need these, so we can't get drop them from
the interface. But let's annotate these ones to avoid complaints from
-Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge-tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 6f7db436d2..0de42aecf4 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -324,7 +324,9 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
  * The successful merge rules are the same as for the three-way merge
  * in git-read-tree.
  */
-static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *info)
+static int threeway_callback(int n UNUSED, unsigned long mask,
+			     unsigned long dirmask UNUSED,
+			     struct name_entry *entry, struct traverse_info *info)
 {
 	/* Same in both? */
 	if (same_entry(entry+1, entry+2) || both_empty(entry+1, entry+2)) {
-- 
2.41.0.586.g3c0cc15bc7

