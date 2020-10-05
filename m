Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F32C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 06:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848A320639
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 06:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgJEGRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 02:17:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:49178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEGRd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 02:17:33 -0400
Received: (qmail 29822 invoked by uid 109); 5 Oct 2020 06:17:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 06:17:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16054 invoked by uid 111); 5 Oct 2020 06:17:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 02:17:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 02:17:32 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, chriscool@tuxfamily.org,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH] parallel-checkout: drop unused checkout state parameter
Message-ID: <20201005061732.GA2288306@coredump.intra.peff.net>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <af0d790973b1e52da0fc9c4bed95e93d995d68da.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af0d790973b1e52da0fc9c4bed95e93d995d68da.1600814153.git.matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 22, 2020 at 07:49:24PM -0300, Matheus Tavares wrote:

> +static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
> +			       const char *path, struct checkout *state)

The "state" parameter is unused here. Maybe this on top of
mt/parallel-checkout-part-1?

-- >8 --
Subject: parallel-checkout: drop unused checkout state parameter

The write_pc_item_to_fd() function takes a "struct checkout *state"
parameter, but never uses it. This was true in its introduction in
fa33dd99f0 (unpack-trees: add basic support for parallel checkout,
2020-09-22). Its caller, write_pc_item(), has already pulled the useful
bits from the state struct into the "path" variable. Let's drop the
useless parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 parallel-checkout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parallel-checkout.c b/parallel-checkout.c
index 94b44d2a48..d077618719 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -233,7 +233,7 @@ static int reset_fd(int fd, const char *path)
 }
 
 static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
-			       const char *path, struct checkout *state)
+			       const char *path)
 {
 	int ret;
 	struct stream_filter *filter;
@@ -347,7 +347,7 @@ void write_pc_item(struct parallel_checkout_item *pc_item,
 		goto out;
 	}
 
-	if (write_pc_item_to_fd(pc_item, fd, path.buf, state)) {
+	if (write_pc_item_to_fd(pc_item, fd, path.buf)) {
 		/* Error was already reported. */
 		pc_item->status = PC_ITEM_FAILED;
 		goto out;
-- 
2.28.0.1295.g4824feede7

