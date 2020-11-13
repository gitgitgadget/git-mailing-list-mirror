Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0592C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A37620B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKMFHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 00:07:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:56922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKMFHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 00:07:20 -0500
Received: (qmail 23776 invoked by uid 109); 13 Nov 2020 05:07:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 05:07:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6214 invoked by uid 111); 13 Nov 2020 05:07:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 00:07:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 00:07:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] packfile: detect overflow in .idx file size checks
Message-ID: <20201113050719.GE744691@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113050631.GA744608@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In load_idx(), we check that the .idx file is sized appropriately for
the number of objects it claims to have. We recently fixed the case
where the number of objects caused our expected size to overflow a
32-bit unsigned int, and we switched to size_t.

On a 64-bit system, this is fine; our size_t covers any expected size.
On a 32-bit system, though, it won't. The file may claim to have 2^31
objects, which will overflow even a size_t.

This doesn't hurt us at all for a well-formed idx file. A 32-bit system
would already have failed to mmap such a file, since it would be too
big. But an .idx file which _claims_ to have 2^31 objects but is
actually much smaller would fool our check.

This is a broken file, and for the most part we don't care that much
what happens. But:

  - it's a little friendlier to notice up front "woah, this file is
    broken" than it is to get nonsense results

  - later access of the data assumes that the loading function
    sanity-checked that we have at least enough bytes for the regular
    object-id table. A malformed .idx file could lead to an
    out-of-bounds read.

So let's use our overflow-checking functions to make sure that we're not
fooled by a malformed file.

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 63fe9ee8be..9702b1218b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -148,7 +148,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		 *  - hash of the packfile
 		 *  - file checksum
 		 */
-		if (idx_size != 4 * 256 + (size_t)nr * (hashsz + 4) + hashsz + hashsz)
+		if (idx_size != st_add(4 * 256 + hashsz + hashsz, st_mult(nr, hashsz + 4)))
 			return error("wrong index v1 file size in %s", path);
 	} else if (version == 2) {
 		/*
@@ -164,10 +164,10 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		 * variable sized table containing 8-byte entries
 		 * for offsets larger than 2^31.
 		 */
-		size_t min_size = 8 + 4*256 + (size_t)nr*(hashsz + 4 + 4) + hashsz + hashsz;
+		size_t min_size = st_add(8 + 4*256 + hashsz + hashsz, st_mult(nr, hashsz + 4 + 4));
 		size_t max_size = min_size;
 		if (nr)
-			max_size += ((size_t)nr - 1)*8;
+			max_size = st_add(max_size, st_mult(nr - 1, 8));
 		if (idx_size < min_size || idx_size > max_size)
 			return error("wrong index v2 file size in %s", path);
 		if (idx_size != min_size &&
-- 
2.29.2.705.g306f91dc4e
