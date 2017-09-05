Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6F2208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbdIENEb (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:04:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:57316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751332AbdIENEa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:04:30 -0400
Received: (qmail 2087 invoked by uid 109); 5 Sep 2017 13:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:04:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12805 invoked by uid 111); 5 Sep 2017 13:05:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:05:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:04:28 -0400
Date:   Tue, 5 Sep 2017 09:04:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/10] reset: make tree counting less confusing
Message-ID: <20170905130428.pxvhvlqcprefgzgc@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending on whether we're in --keep mode, git-reset may
feed one or two trees to unpack_trees(). We start a counter
at "1" and then increment it to "2" only for the two-tree
case. But that means we must always subtract one to find the
correct array slot to fill with each descriptor.

Instead, let's start at "0" and just increment our counter
after adding each tree. This skips the extra subtraction,
and will make things much easier when we start to actually
free our tree buffers.

While we're at it, let's make the first allocation use the
slot at "desc + nr", too, even though we know "nr" is 0 at
that point. It makes the two fill_tree_descriptor() calls
consistent (always "desc + nr", followed by always
incrementing "nr").

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/reset.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index f1af9345e4..34839db8ca 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -44,7 +44,7 @@ static inline int is_merge(void)
 
 static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 {
-	int nr = 1;
+	int nr = 0;
 	struct tree_desc desc[2];
 	struct tree *tree;
 	struct unpack_trees_options opts;
@@ -75,14 +75,16 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		struct object_id head_oid;
 		if (get_oid("HEAD", &head_oid))
 			return error(_("You do not have a valid HEAD."));
-		if (!fill_tree_descriptor(desc, &head_oid))
+		if (!fill_tree_descriptor(desc + nr, &head_oid))
 			return error(_("Failed to find tree of HEAD."));
 		nr++;
 		opts.fn = twoway_merge;
 	}
 
-	if (!fill_tree_descriptor(desc + nr - 1, oid))
+	if (!fill_tree_descriptor(desc + nr, oid))
 		return error(_("Failed to find tree of %s."), oid_to_hex(oid));
+	nr++;
+
 	if (unpack_trees(nr, desc, &opts))
 		return -1;
 
-- 
2.14.1.721.gc5bc1565f1

