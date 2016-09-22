Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1D01F935
	for <e@80x24.org>; Thu, 22 Sep 2016 03:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934301AbcIVDth (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 23:49:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:46458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933937AbcIVDtg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 23:49:36 -0400
Received: (qmail 7833 invoked by uid 109); 22 Sep 2016 03:49:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 03:49:08 +0000
Received: (qmail 5260 invoked by uid 111); 22 Sep 2016 03:49:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 23:49:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Sep 2016 23:49:05 -0400
Date:   Wed, 21 Sep 2016 23:49:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] verify_packfile: check pack validity before accessing data
Message-ID: <20160922034904.dm5okldfmgmin5d7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verify_packfile() does not explicitly open the packfile;
instead, it starts with a sha1 checksum over the whole pack,
and relies on use_pack() to open the packfile as a side
effect.

If the pack cannot be opened for whatever reason (either
because its header information is corrupted, or perhaps
because a simultaneous repack deleted it), then use_pack()
will die(), as it has no way to return an error. This is not
ideal, as verify_packfile() otherwise tries to gently return
an error (this lets programs like git-fsck go on to check
other packs).

Instead, let's check is_pack_valid() up front, and return an
error if it fails. This will open the pack as a side effect,
and then use_pack() will later rely on our cached
descriptor, and avoid calling die().

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-check.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index d123846..c5c7763 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -57,11 +57,8 @@ static int verify_packfile(struct packed_git *p,
 	int err = 0;
 	struct idx_entry *entries;
 
-	/* Note that the pack header checks are actually performed by
-	 * use_pack when it first opens the pack file.  If anything
-	 * goes wrong during those checks then the call will die out
-	 * immediately.
-	 */
+	if (!is_pack_valid(p))
+		return error("packfile %s cannot be accessed", p->pack_name);
 
 	git_SHA1_Init(&ctx);
 	do {
-- 
2.10.0.482.gae5a597
