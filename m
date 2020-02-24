Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A9CC35669
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB5E20675
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBXEbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:31:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:52312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727186AbgBXEbX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:31:23 -0500
Received: (qmail 5198 invoked by uid 109); 24 Feb 2020 04:31:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:31:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6910 invoked by uid 111); 24 Feb 2020 04:40:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:40:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:31:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 04/10] pack-objects: use object_id struct in pack-reuse code
Message-ID: <20200224043122.GD1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the pack-reuse code is dumping an OFS_DELTA entry to a client that
doesn't support it, we re-write it as a REF_DELTA. To do so, we use
nth_packed_object_sha1() to get the oid, but that function is soon going
away in favor of the more type-safe nth_packed_object_id(). Let's switch
now in preparation.

Note that this does incur an extra hash copy (from the pack idx mmap to
the object_id and then to the output, rather than straight from mmap to
the output). But this is not worth worrying about. It's probably not
measurable even when it triggers, and this is fallback code that we
expect to trigger very rarely (since everybody supports OFS_DELTA these
days anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
If you haven't read brian's series, yes, that ugly bare 20 should be
the_hash_algo->rawsz.

 builtin/pack-objects.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 44f44fcb1a..73fca2cb17 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -872,14 +872,15 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 		/* Convert to REF_DELTA if we must... */
 		if (!allow_ofs_delta) {
 			int base_pos = find_revindex_position(reuse_packfile, base_offset);
-			const unsigned char *base_sha1 =
-				nth_packed_object_sha1(reuse_packfile,
-						       reuse_packfile->revindex[base_pos].nr);
+			struct object_id base_oid;
+
+			nth_packed_object_id(&base_oid, reuse_packfile,
+					     reuse_packfile->revindex[base_pos].nr);
 
 			len = encode_in_pack_object_header(header, sizeof(header),
 							   OBJ_REF_DELTA, size);
 			hashwrite(out, header, len);
-			hashwrite(out, base_sha1, 20);
+			hashwrite(out, base_oid.hash, 20);
 			copy_pack_data(out, reuse_packfile, w_curs, cur, next - cur);
 			return;
 		}
-- 
2.25.1.823.g95c5488cf7

