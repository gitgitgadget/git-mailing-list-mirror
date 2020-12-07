Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF87DC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A736923428
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgLGTLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:11:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:55278 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgLGTLt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:11:49 -0500
Received: (qmail 9066 invoked by uid 109); 7 Dec 2020 19:11:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 19:11:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25694 invoked by uid 111); 7 Dec 2020 19:11:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 14:11:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 14:11:08 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 9/9] commit-graph: use size_t for array allocation and
 indexing
Message-ID: <X85+TEQusPhTUmSj@coredump.intra.peff.net>
References: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our packed_commit_list is an array of pointers to commit structs. We use
"int" for the allocation, which is 32-bit even on 64-bit platforms. This
isn't likely to overflow in practice (we're writing commit graphs, so
you'd need to actually have billions of unique commits in the
repository). But it's good practice to use size_t for allocations.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4a718fd6e6..06f8dc1d89 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -932,8 +932,8 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 
 struct packed_commit_list {
 	struct commit **list;
-	int nr;
-	int alloc;
+	size_t nr;
+	size_t alloc;
 };
 
 struct write_commit_graph_context {
-- 
2.29.2.980.g762a4e4ed3
