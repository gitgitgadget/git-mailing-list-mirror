Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8F31F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfAXNLg (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:11:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:47178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726105AbfAXNLg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:11:36 -0500
Received: (qmail 27422 invoked by uid 109); 24 Jan 2019 13:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:11:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28231 invoked by uid 111); 24 Jan 2019 13:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:11:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:11:34 -0500
Date:   Thu, 24 Jan 2019 08:11:34 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/8] match-trees: drop unused path parameter from score
 functions
Message-ID: <20190124131133.GA22398@sigill.intra.peff.net>
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The scores do not take the particular path into account at
all. It's possible they could, but these are all static file-local
functions. It won't be a big deal to re-add the parameter if they ever
need it.

Signed-off-by: Jeff King <peff@peff.net>
---
 match-trees.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 2b6d31ef9d..e65e665bf5 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -3,7 +3,7 @@
 #include "tree-walk.h"
 #include "object-store.h"
 
-static int score_missing(unsigned mode, const char *path)
+static int score_missing(unsigned mode)
 {
 	int score;
 
@@ -16,7 +16,7 @@ static int score_missing(unsigned mode, const char *path)
 	return score;
 }
 
-static int score_differs(unsigned mode1, unsigned mode2, const char *path)
+static int score_differs(unsigned mode1, unsigned mode2)
 {
 	int score;
 
@@ -29,7 +29,7 @@ static int score_differs(unsigned mode1, unsigned mode2, const char *path)
 	return score;
 }
 
-static int score_matches(unsigned mode1, unsigned mode2, const char *path)
+static int score_matches(unsigned mode1, unsigned mode2)
 {
 	int score;
 
@@ -98,24 +98,22 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
 
 		if (cmp < 0) {
 			/* path1 does not appear in two */
-			score += score_missing(one.entry.mode, one.entry.path);
+			score += score_missing(one.entry.mode);
 			update_tree_entry(&one);
 		} else if (cmp > 0) {
 			/* path2 does not appear in one */
-			score += score_missing(two.entry.mode, two.entry.path);
+			score += score_missing(two.entry.mode);
 			update_tree_entry(&two);
 		} else {
 			/* path appears in both */
 			if (!oideq(one.entry.oid, two.entry.oid)) {
 				/* they are different */
 				score += score_differs(one.entry.mode,
-						       two.entry.mode,
-						       one.entry.path);
+						       two.entry.mode);
 			} else {
 				/* same subtree or blob */
 				score += score_matches(one.entry.mode,
-						       two.entry.mode,
-						       one.entry.path);
+						       two.entry.mode);
 			}
 			update_tree_entry(&one);
 			update_tree_entry(&two);
-- 
2.20.1.842.g8986705066

