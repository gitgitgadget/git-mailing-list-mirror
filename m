Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA51C1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeHKBtO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:49:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726774AbeHKBtN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:49:13 -0400
Received: (qmail 28278 invoked by uid 109); 10 Aug 2018 23:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 23:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24810 invoked by uid 111); 10 Aug 2018 23:17:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 19:17:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 19:17:14 -0400
Date:   Fri, 10 Aug 2018 19:17:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 6/7] cat-file: rename batch_{loose,packed}_object callbacks
Message-ID: <20180810231714.GF19875@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're not really doing the batch-show operation in these
callbacks, but just collecting the set of objects. That
distinction will become more important in a future patch, so
let's rename them now to avoid cluttering that diff.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4a44b2404f..2d34f3b867 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -420,18 +420,18 @@ static int batch_object_cb(const struct object_id *oid, void *vdata)
 	return 0;
 }
 
-static int batch_loose_object(const struct object_id *oid,
-			      const char *path,
-			      void *data)
+static int collect_loose_object(const struct object_id *oid,
+				const char *path,
+				void *data)
 {
 	oid_array_append(data, oid);
 	return 0;
 }
 
-static int batch_packed_object(const struct object_id *oid,
-			       struct packed_git *pack,
-			       uint32_t pos,
-			       void *data)
+static int collect_packed_object(const struct object_id *oid,
+				 struct packed_git *pack,
+				 uint32_t pos,
+				 void *data)
 {
 	oid_array_append(data, oid);
 	return 0;
@@ -476,8 +476,8 @@ static int batch_objects(struct batch_options *opt)
 		struct oid_array sa = OID_ARRAY_INIT;
 		struct object_cb_data cb;
 
-		for_each_loose_object(batch_loose_object, &sa, 0);
-		for_each_packed_object(batch_packed_object, &sa, 0);
+		for_each_loose_object(collect_loose_object, &sa, 0);
+		for_each_packed_object(collect_packed_object, &sa, 0);
 		if (repository_format_partial_clone)
 			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
 
-- 
2.18.0.1058.g7433f71063

