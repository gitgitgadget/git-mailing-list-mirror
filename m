Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E86C35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B0920658
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgBXEdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:33:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:52330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727186AbgBXEdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:33:19 -0500
Received: (qmail 5218 invoked by uid 109); 24 Feb 2020 04:33:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:33:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6945 invoked by uid 111); 24 Feb 2020 04:42:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:42:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:33:18 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 06/10] pack-check: convert "internal error" die to a BUG()
Message-ID: <20200224043318.GF1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we fail to load the oid from the index of a packfile, we'll die()
with an "internal error". But this should never happen: we'd fail here
only if the idx needed to be lazily opened (but we've already opened it)
or if we asked for an out-of-range index (but we're iterating using the
same count that we'd check the range against). A corrupted index might
have a bogus count (e.g., too large for its size), but we'd have
complained and aborted already when opening the index initially.

While we're here, we can add a few details so that if this bug ever
_does_ trigger, we'll have a bit more information.

Signed-off-by: Jeff King <peff@peff.net>
---
Most code in this situation doesn't even bother checking the return
value. So I would also be tempted to simply drop the conditional
entirely as unreachable.

 pack-check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pack-check.c b/pack-check.c
index e4ef71c673..39196ecfbc 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -99,7 +99,8 @@ static int verify_packfile(struct repository *r,
 	for (i = 0; i < nr_objects; i++) {
 		entries[i].oid.hash = nth_packed_object_sha1(p, i);
 		if (!entries[i].oid.hash)
-			die("internal error pack-check nth-packed-object");
+			BUG("unable to get oid of object %lu from %s",
+			    (unsigned long)i, p->pack_name);
 		entries[i].offset = nth_packed_object_offset(p, i);
 		entries[i].nr = i;
 	}
-- 
2.25.1.823.g95c5488cf7

