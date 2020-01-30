Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED7C35240
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29E32083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 09:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgA3Jxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:53:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:48330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726873AbgA3Jxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 04:53:39 -0500
Received: (qmail 26202 invoked by uid 109); 30 Jan 2020 09:53:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 09:53:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22642 invoked by uid 111); 30 Jan 2020 10:01:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 05:01:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 04:53:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] traverse_trees(): use stack array for name entries
Message-ID: <20200130095338.GC840531@coredump.intra.peff.net>
References: <20200130095155.GA839988@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130095155.GA839988@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We heap-allocate our arrays of name_entry structs, etc, with one entry
per tree we're asked to traverse. The code does a raw multiplication in
the xmalloc() call, which I find when auditing for integer overflows
during allocation.

We could "fix" this by using ALLOC_ARRAY() instead. But as it turns out,
the maximum size of these arrays is limited at compile time:

  - merge_trees() always passes in 3 trees

  - unpack_trees() and its brethren never pass in more than
    MAX_UNPACK_TREES

So we can simplify even further by just using a stack array and bounding
it with MAX_UNPACK_TREES. There should be no concern with overflowing
the stack, since MAX_UNPACK_TREES is only 8 and the structs themselves
are small.

Note that since we're replacing xcalloc(), we have to move one of the
NULL initializations into a loop.

Signed-off-by: Jeff King <peff@peff.net>
---

This does increase the coupling between tree-walk and unpack-trees a
bit. I'd be OK just switching to ALLOC_ARRAY(), too. I doubt the
performance improvement is measurable, and the cleanup free() calls are
already there.

 tree-walk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index d5a8e096a6..3093cf7098 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -410,15 +410,20 @@ int traverse_trees(struct index_state *istate,
 		   struct traverse_info *info)
 {
 	int error = 0;
-	struct name_entry *entry = xmalloc(n*sizeof(*entry));
+	struct name_entry entry[MAX_UNPACK_TREES];
 	int i;
-	struct tree_desc_x *tx = xcalloc(n, sizeof(*tx));
+	struct tree_desc_x tx[ARRAY_SIZE(entry)];
 	struct strbuf base = STRBUF_INIT;
 	int interesting = 1;
 	char *traverse_path;
 
-	for (i = 0; i < n; i++)
+	if (n >= ARRAY_SIZE(entry))
+		BUG("traverse_trees() called with too many trees (%d)", n);
+
+	for (i = 0; i < n; i++) {
 		tx[i].d = t[i];
+		tx[i].skip = NULL;
+	}
 
 	if (info->prev) {
 		strbuf_make_traverse_path(&base, info->prev,
@@ -506,10 +511,8 @@ int traverse_trees(struct index_state *istate,
 			if (mask & (1ul << i))
 				update_extended_entry(tx + i, entry + i);
 	}
-	free(entry);
 	for (i = 0; i < n; i++)
 		free_extended_entry(tx + i);
-	free(tx);
 	free(traverse_path);
 	info->traverse_path = NULL;
 	strbuf_release(&base);
-- 
2.25.0.515.gaba5347bc6
