Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A402B202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbdJSUbW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:31:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:58216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752354AbdJSUbW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:31:22 -0400
Received: (qmail 3033 invoked by uid 109); 19 Oct 2017 20:31:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 20:31:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12031 invoked by uid 111); 19 Oct 2017 20:31:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:31:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 16:31:20 -0400
Date:   Thu, 19 Oct 2017 16:31:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: [PATCH 5/5] diff: handle NULs in get_string_hash()
Message-ID: <20171019203119.d2xbryov2y5t2aig@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For computing moved lines, we feed the characters of each
line into a hash. When we've been asked to ignore
whitespace, then we pick each character using next_byte(),
which returns -1 on end-of-string, which it determines using
the start/end pointers we feed it.

However our check of its return value treats "0" the same as
"-1", meaning we'd quit if the string has an embedded NUL.
This is unlikely to ever come up in practice since our line
boundaries generally come from calling strlen() in the first
place.

But it was a bit surprising to me as a reader of the
next_byte() code. And it's possible that we may one day feed
this function with more exotic input, which otherwise works
with arbitrary ptr/len pairs.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed that we make an extra copy of each line here, just to feed it
to memihash! I guess "-w" is not a critical-performance code path, but
this could be fixed if we could do memhash() incrementally (e.g., by
putting the FNV state into a struct and letting callers "add" to it
incrementally). Maybe an interesting #leftoverbits, though I'd want to
see timing tests that show it's worth doing.

 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 09081a207c..c4a669ffa8 100644
--- a/diff.c
+++ b/diff.c
@@ -782,7 +782,7 @@ static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_opti
 		strbuf_reset(&sb);
 		while (ae > ap && isspace(ae[-1]))
 			ae--;
-		while ((c = next_byte(&ap, &ae, o)) > 0)
+		while ((c = next_byte(&ap, &ae, o)) >= 0)
 			strbuf_addch(&sb, c);
 
 		return memhash(sb.buf, sb.len);
-- 
2.15.0.rc1.560.g5f0609e481
