Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C44B1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 04:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfBNEiX (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 23:38:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:43628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388956AbfBNEiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 23:38:23 -0500
Received: (qmail 30280 invoked by uid 109); 14 Feb 2019 04:38:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 04:38:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6358 invoked by uid 111); 14 Feb 2019 04:38:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 23:38:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 23:38:21 -0500
Date:   Wed, 13 Feb 2019 23:38:21 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] prune: check SEEN flag for reachability
Message-ID: <20190214043821.GC19183@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214043127.GA19019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-prune command checks reachability by doing a traversal, and then
checking whether a given object exists in the global object hash. This
can yield false positives if any other part of the code had to create an
object struct for some reason. It's not clear whether this is even
possible, but it's more robust to rely on something a little more
concrete: the SEEN flag set by our traversal.

Note that there is a slight possibility of regression here, as we're
relying on mark_reachable_objects() to consistently set the flag.
However, it has always done so, and we're already relying on that fact
in prune_shallow(), which is called as part of git-prune. So this is
making these two parts of the prune operation more consistent.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/prune.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 04b6573945..97613eccb5 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -49,13 +49,12 @@ static void perform_reachability_traversal(struct rev_info *revs)
 static int is_object_reachable(const struct object_id *oid,
 			       struct rev_info *revs)
 {
+	struct object *obj;
+
 	perform_reachability_traversal(revs);
 
-	/*
-	 * Do we know about this object?
-	 * It must have been reachable
-	 */
-	return !!lookup_object(the_repository, oid->hash);
+	obj = lookup_object(the_repository, oid->hash);
+	return obj && (obj->flags & SEEN);
 }
 
 static int prune_object(const struct object_id *oid, const char *fullpath,
-- 
2.21.0.rc0.586.gffba1126a0
