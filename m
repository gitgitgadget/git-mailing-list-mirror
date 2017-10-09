Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A612520372
	for <e@80x24.org>; Mon,  9 Oct 2017 17:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbdJIRs1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 13:48:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:47258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754018AbdJIRs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 13:48:27 -0400
Received: (qmail 25480 invoked by uid 109); 9 Oct 2017 17:42:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 17:42:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18754 invoked by uid 111); 9 Oct 2017 17:48:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 13:48:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Oct 2017 13:48:24 -0400
Date:   Mon, 9 Oct 2017 13:48:24 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] write_entry: fix leak when retrying delayed filter
Message-ID: <20171009174824.tt5tpxdvcvzbyvnl@sigill.intra.peff.net>
References: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When write_entry() retries a delayed filter request, we
don't need to send the blob content to the filter again, and
set the pointer to NULL. But doing so means we leak the
contents we read earlier from read_blob_entry(). Let's make
sure to free it before dropping the pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
 entry.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/entry.c b/entry.c
index ab79f1f69c..637c5958b0 100644
--- a/entry.c
+++ b/entry.c
@@ -283,6 +283,7 @@ static int write_entry(struct cache_entry *ce,
 			if (dco && dco->state != CE_NO_DELAY) {
 				/* Do not send the blob in case of a retry. */
 				if (dco->state == CE_RETRY) {
+					free(new);
 					new = NULL;
 					size = 0;
 				}
-- 
2.15.0.rc0.421.gf5a676fd56

