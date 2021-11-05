Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F9C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5B26125F
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhKEJEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:04:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:53728 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhKEJEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 05:04:11 -0400
Received: (qmail 11210 invoked by uid 109); 5 Nov 2021 09:01:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 09:01:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15929 invoked by uid 111); 5 Nov 2021 09:01:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 05:01:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 05:01:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] test_bitmap_hashes(): handle repository without bitmaps
Message-ID: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If prepare_bitmap_git() returns NULL (one easy-to-trigger cause being
that the repository does not have bitmaps at all), then we'll segfault
accessing bitmap_git->hashes:

  $ t/helper/test-tool bitmap dump-hashes
  Segmentation fault

We should treat this the same as a repository with bitmaps but no
name-hashes, and quietly produce an empty output. The later call to
free_bitmap_index() in the cleanup label is OK, as it treats a NULL
pointer as a noop.

This isn't a big deal in practice, as this function is intended for and
used only by test-tool. It's probably worth fixing to avoid confusion,
but not worth adding coverage for this to the test suite.

Signed-off-by: Jeff King <peff@peff.net>
---
This is new in the v2.34.0 cycle, but it's so low impact it doesn't
matter much if we ship with the bug. OTOH, it's pretty low-risk since it
is only run by the test suite.

 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index a56ceb9441..f772d3cb7f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1759,7 +1759,7 @@ int test_bitmap_hashes(struct repository *r)
 	struct object_id oid;
 	uint32_t i, index_pos;
 
-	if (!bitmap_git->hashes)
+	if (!bitmap_git || !bitmap_git->hashes)
 		goto cleanup;
 
 	for (i = 0; i < bitmap_num_objects(bitmap_git); i++) {
-- 
2.34.0.rc1.634.g85d556ea55
