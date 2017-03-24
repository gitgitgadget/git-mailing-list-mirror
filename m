Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30291FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdCXRZ0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:25:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51108 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdCXRZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:25:25 -0400
Received: (qmail 17567 invoked by uid 109); 24 Mar 2017 17:25:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 17:25:24 +0000
Received: (qmail 27626 invoked by uid 111); 24 Mar 2017 17:25:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 13:25:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 13:25:22 -0400
Date:   Fri, 24 Mar 2017 13:25:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] fast-import: use xsnprintf for writing sha1s
Message-ID: <20170324172522.l4sawf2u42mrnswk@sigill.intra.peff.net>
References: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we have to write a sha1 with a newline, we do so by
copying both into a single buffer, so that we can issue a
single write() call.

We use snprintf but don't bother to check the output, since
we know it will fit. However, we should use xsnprintf() in
such a case so that we're notified if our assumption turns
out to be wrong (and to make it easier to audit for
unchecked snprintf calls).

Signed-off-by: Jeff King <peff@peff.net>
---
This is ready for conversion to oid_to_hex, too, but I avoided that
here. The buffer would need to be allocated with the new GIT_MAX_HEXSZ,
which is not yet available. So I figured it was better to leave it than
half-convert it and leave brian wondering whether it's really supposed
to be GIT_MAX_HEXSZ or GIT_SHA1_HEXSZ.

 fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 41a539f97..4e0f3f5dd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3003,7 +3003,7 @@ static void parse_get_mark(const char *p)
 	if (!oe)
 		die("Unknown mark: %s", command_buf.buf);
 
-	snprintf(output, sizeof(output), "%s\n", sha1_to_hex(oe->idx.sha1));
+	xsnprintf(output, sizeof(output), "%s\n", sha1_to_hex(oe->idx.sha1));
 	cat_blob_write(output, 41);
 }
 
-- 
2.12.1.843.g1937c56c2

