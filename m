Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2429BC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0368D20736
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDWVDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:03:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:37848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726057AbgDWVDF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:03:05 -0400
Received: (qmail 17845 invoked by uid 109); 23 Apr 2020 21:03:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Apr 2020 21:03:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13490 invoked by uid 111); 23 Apr 2020 21:14:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Apr 2020 17:14:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Apr 2020 17:03:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] blame: drop unused parameter from maybe_changed_path
Message-ID: <20200423210303.GA1635761@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't use the "parent" parameter at all (probably because the bloom
filter for a commit is always defined against a single parent anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of ds/blame-on-bloom, which just made it to next.

I _think_ this is the right solution, but perhaps the function should be
verifying that we're looking at the right parent?

 blame.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/blame.c b/blame.c
index 9fbf79e47c..da7e28800e 100644
--- a/blame.c
+++ b/blame.c
@@ -1263,7 +1263,6 @@ struct blame_bloom_data {
 static int bloom_count_queries = 0;
 static int bloom_count_no = 0;
 static int maybe_changed_path(struct repository *r,
-			      struct commit *parent,
 			      struct blame_origin *origin,
 			      struct blame_bloom_data *bd)
 {
@@ -1355,8 +1354,7 @@ static struct blame_origin *find_origin(struct repository *r,
 		if (origin->commit->parents &&
 		    !oidcmp(&parent->object.oid,
 			    &origin->commit->parents->item->object.oid))
-			compute_diff = maybe_changed_path(r, parent,
-							  origin, bd);
+			compute_diff = maybe_changed_path(r, origin, bd);
 
 		if (compute_diff)
 			diff_tree_oid(get_commit_tree_oid(parent),
-- 
2.26.2.827.g3c1233342b
