Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06A420248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCTIP3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:15:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:57430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726049AbfCTIP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:15:29 -0400
Received: (qmail 19655 invoked by uid 109); 20 Mar 2019 08:15:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:15:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6336 invoked by uid 111); 20 Mar 2019 08:15:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:15:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:15:27 -0400
Date:   Wed, 20 Mar 2019 04:15:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/13] unpack-trees: drop unused error_type parameters
Message-ID: <20190320081527.GG10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verify_clean_subdirectory() helper takes an error_type parameter
from the caller, but doesn't actually use it. Instead, when it calls
add_rejected_path() it passes NOT_UPTODATE_DIR, its own custom error
type which is more specific than what the caller provides. Likewise for
verify_clean_submodule(), which always passes WOULD_LOSE_SUBMODULE.

Signed-off-by: Jeff King <peff@peff.net>
---
 unpack-trees.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 79551ab9cc..5f65ff5804 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1758,7 +1758,6 @@ static void invalidate_ce_path(const struct cache_entry *ce,
  */
 static int verify_clean_submodule(const char *old_sha1,
 				  const struct cache_entry *ce,
-				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
 	if (!submodule_from_ce(ce))
@@ -1769,7 +1768,6 @@ static int verify_clean_submodule(const char *old_sha1,
 }
 
 static int verify_clean_subdirectory(const struct cache_entry *ce,
-				     enum unpack_trees_error_types error_type,
 				     struct unpack_trees_options *o)
 {
 	/*
@@ -1792,7 +1790,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		if (!sub_head && oideq(&oid, &ce->oid))
 			return 0;
 		return verify_clean_submodule(sub_head ? NULL : oid_to_hex(&oid),
-					      ce, error_type, o);
+					      ce, o);
 	}
 
 	/*
@@ -1888,7 +1886,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		 * files that are in "foo/" we would lose
 		 * them.
 		 */
-		if (verify_clean_subdirectory(ce, error_type, o) < 0)
+		if (verify_clean_subdirectory(ce, o) < 0)
 			return -1;
 		return 0;
 	}
-- 
2.21.0.701.g4401309e11

