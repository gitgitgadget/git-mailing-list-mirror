Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC751F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeHKBlE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:41:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:50654 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727026AbeHKBlE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:41:04 -0400
Received: (qmail 27931 invoked by uid 109); 10 Aug 2018 23:09:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 23:09:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24612 invoked by uid 111); 10 Aug 2018 23:09:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 19:09:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 19:09:06 -0400
Date:   Fri, 10 Aug 2018 19:09:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/7] for_each_*_object: store flag definitions in a single
 location
Message-ID: <20180810230906.GA19875@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These flags were split between cache.h and packfile.h,
because some of the flags apply only to packs. However, they
share a single numeric namespace, since both are respected
for the packed variant. Let's make sure they're defined
together so that nobody accidentally adds a new flag in one
location that duplicates the other.

While we're here, let's also put them in an enum (which
helps debugger visibility) and use "(1<<n)" rather than
counting powers of 2 manually.

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably, all of these for_each_*_object() functions should stay
together. Even though some are related to packfiles and some to loose,
they are meant to be a unified API. So I'd be fine to do that on top,
but this at least reduces the chance of a mistake in the meantime.

 cache.h    | 13 ++++++++++++-
 packfile.h |  8 ++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 8dc7134f00..4187238ecf 100644
--- a/cache.h
+++ b/cache.h
@@ -1623,12 +1623,23 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
 				      each_loose_subdir_fn subdir_cb,
 				      void *data);
 
+/*
+ * Flags for for_each_*_object(), including for_each_loose below and
+ * for_each_packed in packfile.h.
+ */
+enum for_each_object_flags {
+	/* Iterate only over local objects, not alternates. */
+	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
+
+	/* Only iterate over packs obtained from the promisor remote. */
+	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
+};
+
 /*
  * Iterate over loose objects in both the local
  * repository and any alternates repositories (unless the
  * LOCAL_ONLY flag is set).
  */
-#define FOR_EACH_OBJECT_LOCAL_ONLY 0x1
 extern int for_each_loose_object(each_loose_object_fn, void *, unsigned flags);
 
 /*
diff --git a/packfile.h b/packfile.h
index cc7eaffe1b..6ddc6a2e91 100644
--- a/packfile.h
+++ b/packfile.h
@@ -148,15 +148,11 @@ extern int has_object_pack(const struct object_id *oid);
 
 extern int has_pack_index(const unsigned char *sha1);
 
-/*
- * Only iterate over packs obtained from the promisor remote.
- */
-#define FOR_EACH_OBJECT_PROMISOR_ONLY 2
-
 /*
  * Iterate over packed objects in both the local
  * repository and any alternates repositories (unless the
- * FOR_EACH_OBJECT_LOCAL_ONLY flag, defined in cache.h, is set).
+ * FOR_EACH_OBJECT_LOCAL_ONLY flag is set). See cache.h for the complete list
+ * of flags.
  */
 typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
-- 
2.18.0.1058.g7433f71063

