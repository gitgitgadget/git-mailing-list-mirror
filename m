Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D401B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeHKBnN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:43:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:50672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726774AbeHKBnM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:43:12 -0400
Received: (qmail 28021 invoked by uid 109); 10 Aug 2018 23:11:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 23:11:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24655 invoked by uid 111); 10 Aug 2018 23:11:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 19:11:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 19:11:14 -0400
Date:   Fri, 10 Aug 2018 19:11:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 3/7] for_each_*_object: give more comprehensive docstrings
Message-ID: <20180810231114.GC19875@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already mention the local/alternate behavior of these
functions, but we can help clarify a few other behaviors:

 - there's no need to mention LOCAL_ONLY specifically, since
   we already reference the flags by type (and as we add
   more flags, we don't want to have to mention each)

 - clarify that reachability doesn't matter here; this is
   all accessible objects

 - what ordering/uniqueness guarantees we give

 - how pack-specific flags are handled for the loose case

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h    |  8 +++++---
 packfile.h | 12 ++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 9e02fc494e..f438540f9b 100644
--- a/cache.h
+++ b/cache.h
@@ -1636,9 +1636,11 @@ enum for_each_object_flags {
 };
 
 /*
- * Iterate over loose objects in both the local
- * repository and any alternates repositories (unless the
- * LOCAL_ONLY flag is set).
+ * Iterate over all accessible loose objects without respect to
+ * reachability. By default, this includes both local and alternate objects.
+ * The order in which objects are visited is unspecified.
+ *
+ * Any flags specific to packs are ignored.
  */
 int for_each_loose_object(each_loose_object_fn, void *,
 			  enum for_each_object_flags flags);
diff --git a/packfile.h b/packfile.h
index 9861728514..c86a8c2716 100644
--- a/packfile.h
+++ b/packfile.h
@@ -149,10 +149,14 @@ extern int has_object_pack(const struct object_id *oid);
 extern int has_pack_index(const unsigned char *sha1);
 
 /*
- * Iterate over packed objects in both the local
- * repository and any alternates repositories (unless the
- * FOR_EACH_OBJECT_LOCAL_ONLY flag is set). See cache.h for the complete list
- * of flags.
+ * Iterate over all accessible packed objects without respect to reachability.
+ * By default, this includes both local and alternate packs.
+ *
+ * Note that some objects may appear twice if they are found in multiple packs.
+ * Each pack is visited in an unspecified order. Objects within a pack are
+ * visited in pack-idx order (i.e., sorted by oid).
+ *
+ * The list of flags can be found in cache.h.
  */
 typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
-- 
2.18.0.1058.g7433f71063

