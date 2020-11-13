Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7FBC388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5520B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKMFHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 00:07:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:56918 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKMFHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 00:07:15 -0500
Received: (qmail 23770 invoked by uid 109); 13 Nov 2020 05:07:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 05:07:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6208 invoked by uid 111); 13 Nov 2020 05:07:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 00:07:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 00:07:14 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] fsck: correctly compute checksums on idx files larger
 than 4GB
Message-ID: <20201113050714.GC744691@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113050631.GA744608@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checking the trailing checksum hash of a .idx file, we pass the
whole buffer (minus the trailing hash) into a single call to
the_hash_algo->update_fn(). But we cast it to an "unsigned int". This
comes from c4001d92be (Use off_t when we really mean a file offset.,
2007-03-06). That commit started storing the index_size variable as an
off_t, but our mozilla-sha1 implementation from the time was limited to
a smaller size. Presumably the cast was a way of annotating that we
expected .idx files to be small, and so we didn't need to loop (as we do
for arbitrarily-large .pack files). Though as an aside it was still
wrong, because the mozilla function actually took a signed int.

These days our hash-update functions are defined to take a size_t, so we
can pass the whole buffer in directly. The cast is actually causing a
buggy truncation!

While we're here, though, let's drop the confusing off_t variable in the
first place. We're getting the size not from the filesystem anyway, but
from p->index_size, which is a size_t. In fact, we can make the code a
bit more readable by dropping our local variable duplicating
p->index_size, and instead have one that stores the size of the actual
index data, minus the trailing hash.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index db3adf8781..4b089fe8ec 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -164,22 +164,22 @@ static int verify_packfile(struct repository *r,
 
 int verify_pack_index(struct packed_git *p)
 {
-	off_t index_size;
+	size_t len;
 	const unsigned char *index_base;
 	git_hash_ctx ctx;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	int err = 0;
 
 	if (open_pack_index(p))
 		return error("packfile %s index not opened", p->pack_name);
-	index_size = p->index_size;
 	index_base = p->index_data;
+	len = p->index_size - the_hash_algo->rawsz;
 
 	/* Verify SHA1 sum of the index file */
 	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, index_base, (unsigned int)(index_size - the_hash_algo->rawsz));
+	the_hash_algo->update_fn(&ctx, index_base, len);
 	the_hash_algo->final_fn(hash, &ctx);
-	if (!hasheq(hash, index_base + index_size - the_hash_algo->rawsz))
+	if (!hasheq(hash, index_base + len))
 		err = error("Packfile index for %s hash mismatch",
 			    p->pack_name);
 	return err;
-- 
2.29.2.705.g306f91dc4e

