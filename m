Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879761F597
	for <e@80x24.org>; Tue, 24 Jul 2018 10:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbeGXL6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:58:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:57326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388319AbeGXL6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:58:22 -0400
Received: (qmail 10973 invoked by uid 109); 24 Jul 2018 10:52:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 10:52:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26478 invoked by uid 111); 24 Jul 2018 10:52:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 06:52:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 06:52:29 -0400
Date:   Tue, 24 Jul 2018 06:52:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] strbuf_humanise: use unsigned variables
Message-ID: <20180724105229.GF17165@sigill.intra.peff.net>
References: <20180724104852.GA14638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724104852.GA14638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the numeric formatting done by this function uses
"%u", but we pass in a signed "int". The actual range
doesn't matter here, since the conditional makes sure we're
always showing reasonably small numbers. And even gcc's
format-checker does not seem to mind. But it's potentially
confusing to a reader of the code to see the mismatch.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index db9069c937..54f29bbb23 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -734,18 +734,18 @@ void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	if (bytes > 1 << 30) {
 		strbuf_addf(buf, "%u.%2.2u GiB",
-			    (int)(bytes >> 30),
-			    (int)(bytes & ((1 << 30) - 1)) / 10737419);
+			    (unsigned)(bytes >> 30),
+			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
 	} else if (bytes > 1 << 20) {
-		int x = bytes + 5243;  /* for rounding */
+		unsigned x = bytes + 5243;  /* for rounding */
 		strbuf_addf(buf, "%u.%2.2u MiB",
 			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
 	} else if (bytes > 1 << 10) {
-		int x = bytes + 5;  /* for rounding */
+		unsigned x = bytes + 5;  /* for rounding */
 		strbuf_addf(buf, "%u.%2.2u KiB",
 			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
 	} else {
-		strbuf_addf(buf, "%u bytes", (int)bytes);
+		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
 	}
 }
 
-- 
2.18.0.542.g2bf2fc4f7e
