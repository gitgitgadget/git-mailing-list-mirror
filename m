Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16001F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeKTUTJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 15:19:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:45484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725890AbeKTUTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 15:19:09 -0500
Received: (qmail 21531 invoked by uid 109); 20 Nov 2018 09:50:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 09:50:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27063 invoked by uid 111); 20 Nov 2018 09:50:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 04:50:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 04:50:53 -0500
Date:   Tue, 20 Nov 2018 04:50:53 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/3] pack-objects: fix off-by-one in delta-island tree-depth
 computation
Message-ID: <20181120095053.GC22742@sigill.intra.peff.net>
References: <20181120094451.GA21725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120094451.GA21725@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When delta-islands are in use, we need to record the deepest path at
which we find each tree and blob. Our loop to do so counts slashes, so
"foo" is depth 0, "foo/bar" is depth 1, and so on.

However, this neglects root trees, which are represented by the empty
string. Those also have depth 0, but are at a layer above "foo". Thus,
"foo" should be 1, "foo/bar" at 2, and so on. We use this depth to
topo-sort the trees in resolve_tree_islands(). As a result, we may fail
to visit a root tree before the sub-trees it contains, and therefore not
correctly pass down the island marks.

That in turn could lead to missing some delta opportunities (objects are
in the same island, but we didn't realize it) or creating unwanted
cross-island deltas (one object is in an island another isn't, but we
don't realize). In practice, it seems to have only a small effect.  Some
experiments on the real-world git/git fork network at GitHub showed an
improvement of only 0.14% in the resulting clone size.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e7ea206c08..411aefd687 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2786,9 +2786,11 @@ static void show_object(struct object *obj, const char *name, void *data)
 
 	if (use_delta_islands) {
 		const char *p;
-		unsigned depth = 0;
+		unsigned depth;
 		struct object_entry *ent;
 
+		/* the empty string is a root tree, which is depth 0 */
+		depth = *name ? 1 : 0;
 		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
 			depth++;
 
-- 
2.20.0.rc0.715.gf6b01ab3e1
