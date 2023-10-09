Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2CECD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378647AbjJIVGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378711AbjJIVGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:06:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ECF18A
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:06:02 -0700 (PDT)
Received: (qmail 24486 invoked by uid 109); 9 Oct 2023 21:06:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:06:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18638 invoked by uid 111); 9 Oct 2023 21:06:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:06:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:06:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 20/20] chunk-format: drop pair_chunk_unsafe()
Message-ID: <20231009210601.GT3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers left, and we don't want anybody to add new ones (they
should use the not-unsafe version instead). So let's drop the function.

Signed-off-by: Jeff King <peff@peff.net>
---
 chunk-format.c |  8 --------
 chunk-format.h | 13 -------------
 2 files changed, 21 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index 09ef86afa6..cdc7f39b70 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -184,14 +184,6 @@ int pair_chunk(struct chunkfile *cf,
 	return read_chunk(cf, chunk_id, pair_chunk_fn, &pcd);
 }
 
-int pair_chunk_unsafe(struct chunkfile *cf,
-		      uint32_t chunk_id,
-		      const unsigned char **p)
-{
-	size_t dummy;
-	return pair_chunk(cf, chunk_id, p, &dummy);
-}
-
 int read_chunk(struct chunkfile *cf,
 	       uint32_t chunk_id,
 	       chunk_read_fn fn,
diff --git a/chunk-format.h b/chunk-format.h
index d608b8135c..14b76180ef 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -54,19 +54,6 @@ int pair_chunk(struct chunkfile *cf,
 	       const unsigned char **p,
 	       size_t *size);
 
-/*
- * Unsafe version of pair_chunk; it does not return the size,
- * meaning that the caller cannot possibly be careful about
- * reading out of bounds from the mapped memory.
- *
- * No new callers should use this function, and old callers should
- * be audited and migrated over to using the regular pair_chunk()
- * function.
- */
-int pair_chunk_unsafe(struct chunkfile *cf,
-		      uint32_t chunk_id,
-		      const unsigned char **p);
-
 typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
 			     size_t chunk_size, void *data);
 /*
-- 
2.42.0.884.g35e1fe1a6a
