Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF96C1FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 03:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759305AbcHaDnM (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 23:43:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:35706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1759276AbcHaDnM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 23:43:12 -0400
Received: (qmail 32264 invoked by uid 109); 31 Aug 2016 03:43:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 03:43:12 +0000
Received: (qmail 2730 invoked by uid 111); 31 Aug 2016 03:43:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 23:43:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2016 23:43:07 -0400
Date:   Tue, 30 Aug 2016 23:43:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] color_parse_mem: initialize "struct color" temporary
Message-ID: <20160831034307.vfrxdhbos26cqxka@sigill.intra.peff.net>
References: <20160831033934.m2at7ci5f6lty5nb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160831033934.m2at7ci5f6lty5nb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compiling color.c with gcc 6.2.0 using -O3 produces some
-Wmaybe-uninitialized false positives:

    color.c: In function ‘color_parse_mem’:
    color.c:189:10: warning: ‘bg.blue’ may be used uninitialized in this function [-Wmaybe-uninitialized]
       out += xsnprintf(out, len, "%c8;2;%d;%d;%d", type,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          c->red, c->green, c->blue);
          ~~~~~~~~~~~~~~~~~~~~~~~~~~
    color.c:208:15: note: ‘bg.blue’ was declared here
      struct color bg = { COLOR_UNSPECIFIED };
                   ^~
    [ditto for bg.green, bg.red, fg.blue, etc]

This is doubly confusing, because the declaration shows it
being initialized! Even though we do not explicitly
initialize the color components, an incomplete initializer
sets the unmentioned members to zero.

What the warning doesn't show is that we later do this:

  struct color c;
  if (!parse_color(&c, ...)) {
          if (fg.type == COLOR_UNSPECIFIED)
                fg = c;
          ...
  }

gcc is clever enough to realize that a struct assignment
from an uninitialized variable taints the destination. But
unfortunately it's _not_ clever enough to realize that we
only look at those members when type is set to COLOR_RGB, in
which case they are always initialized.

With -O2, gcc does not look into parse_color() and must
assume that "c" emerges fully initialized. With -O3, it
inlines parse_color(), and learns just enough to get
confused.

We can silence the false positive by initializing the
temporary "c". This also future-proofs us against
violating the type assumptions (the result would probably
still be buggy, but in a deterministic way).

Signed-off-by: Jeff King <peff@peff.net>
---
Of course it's possible that I am wrong and gcc is right, but I just
don't see it (and that was the real reason I dug; I don't care _that_
much about -O3 warnings, but I wanted to see if gcc had found a real
bug).

 color.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/color.c b/color.c
index 81c2676..1b95e6b 100644
--- a/color.c
+++ b/color.c
@@ -215,7 +215,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	/* [fg [bg]] [attr]... */
 	while (len > 0) {
 		const char *word = ptr;
-		struct color c;
+		struct color c = { COLOR_UNSPECIFIED };
 		int val, wordlen = 0;
 
 		while (len > 0 && !isspace(word[wordlen])) {
-- 
2.10.0.rc2.125.gcfb3d08
