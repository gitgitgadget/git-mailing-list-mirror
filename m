Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA95D1F406
	for <e@80x24.org>; Fri, 11 May 2018 18:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeEKSA6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 14:00:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:36360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750711AbeEKSA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 14:00:57 -0400
Received: (qmail 16603 invoked by uid 109); 11 May 2018 18:00:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 18:00:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7861 invoked by uid 111); 11 May 2018 18:01:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 14:01:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 14:00:55 -0400
Date:   Fri, 11 May 2018 14:00:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] mark_tree_contents_uninteresting(): drop missing object
 check
Message-ID: <20180511180055.GA12543@sigill.intra.peff.net>
References: <20180511180029.GA11290@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511180029.GA11290@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's generally acceptable for UNINTERESTING objects in a
traversal to be unavailable (e.g., see aeeae1b771). When
marking trees UNINTERESTING, we access the object database
twice: once to check if the object is missing (and return
quietly if it is), and then again to actually parse it.

We can instead just try to parse; if that fails, we can then
return quietly. That halves the effort we spend on locating
the object.

Note that this isn't _exactly_ the same as the original
behavior, as the parse failure could be due to other
problems than a missing object: it could be corrupted, in
which case the original code would have died. But the new
behavior is arguably better, as it covers the object being
unavailable for any reason. We'll also still issue a warning
to stderr in such a case.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 1cff11833e..ef70f69f08 100644
--- a/revision.c
+++ b/revision.c
@@ -52,12 +52,9 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
-	struct object *obj = &tree->object;
 
-	if (!has_object_file(&obj->oid))
+	if (parse_tree_gently(tree, 1) < 0)
 		return;
-	if (parse_tree(tree) < 0)
-		die("bad tree %s", oid_to_hex(&obj->oid));
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
-- 
2.17.0.988.gec4b43b3e5

