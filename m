Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E5D208E4
	for <e@80x24.org>; Tue,  5 Sep 2017 13:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdIENEx (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:04:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:57322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750959AbdIENEx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:04:53 -0400
Received: (qmail 2101 invoked by uid 109); 5 Sep 2017 13:04:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:04:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12821 invoked by uid 111); 5 Sep 2017 13:05:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:05:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:04:51 -0400
Date:   Tue, 5 Sep 2017 09:04:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/10] reset: free allocated tree buffers
Message-ID: <20170905130450.fsoglfwieei2ruir@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We read the tree objects with fill_tree_descriptor(), but
never actually free the resulting buffers, causing a memory
leak. This isn't a huge deal because we call this code at
most twice per program invocation. But it does potentially
double our heap usage if you have large root trees. Let's
free the trees before returning.


Signed-off-by: Jeff King <peff@peff.net>
---
Actually, in the two-call case we repeat one of the trees,
so we _could_ in theory stash it away. But we don't do that
currently, and it's probably not worth the effort. My main
motivation is just shutting up the leak checker so I can
find actual important leaks.

 builtin/reset.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 34839db8ca..9e22b4a1dc 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -44,10 +44,11 @@ static inline int is_merge(void)
 
 static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 {
-	int nr = 0;
+	int i, nr = 0;
 	struct tree_desc desc[2];
 	struct tree *tree;
 	struct unpack_trees_options opts;
+	int ret = -1;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
@@ -81,19 +82,26 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		opts.fn = twoway_merge;
 	}
 
-	if (!fill_tree_descriptor(desc + nr, oid))
-		return error(_("Failed to find tree of %s."), oid_to_hex(oid));
+	if (!fill_tree_descriptor(desc + nr, oid)) {
+		error(_("Failed to find tree of %s."), oid_to_hex(oid));
+		goto out;
+	}
 	nr++;
 
-	if (unpack_trees(nr, desc, &opts))
-		return -1;
+	if (unpack_trees(nr, desc, &opts)) 
+		goto out;
 
 	if (reset_type == MIXED || reset_type == HARD) {
 		tree = parse_tree_indirect(oid);
 		prime_cache_tree(&the_index, tree);
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	for (i = 0; i < nr; i++)
+		free((void *)desc[i].buffer);
+	return ret;
 }
 
 static void print_new_head_line(struct commit *commit)
-- 
2.14.1.721.gc5bc1565f1

