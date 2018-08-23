Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AA31F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeHWEZq (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:25:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:52606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726267AbeHWEZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:25:45 -0400
Received: (qmail 12252 invoked by uid 109); 23 Aug 2018 00:51:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:51:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6354 invoked by uid 111); 23 Aug 2018 00:52:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:52:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:51:57 -0400
Date:   Wed, 22 Aug 2018 20:51:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 9/9] sequencer: handle ignore_footer when parsing trailers
Message-ID: <20180823005157.GI3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The append_signoff() function takes an "ignore_footer"
argument, which specifies a number of bytes at the end of
the message buffer which should not be considered (they
cannot contain trailers, and the trailer is spliced in
before them).

But to find the existing trailers, it calls into
has_conforming_trailer(). That function takes an
ignore_footer parameter, but since 967dfd4d56 (sequencer:
use trailer's trailer layout, 2016-11-02) the parameter is
completely ignored.

The trailer interface we're using takes a single string,
with no option to tell it to use part of the string.
However, since we have a mutable strbuf, we can work around
this by simply overwriting (and later restoring) the
boundary with a NUL.

I'm not sure if this can actually trigger a bug in practice.
It's easy to get a non-zero ignore_footer by doing something
like this:

  git commit -F - --cleanup=verbatim <<-EOF
  subject

  body

  Signed-off-by: me

  # this looks like a comment, but is actually in the
  # message! That makes the earlier s-o-b fake.
  EOF

  git commit --amend -s

There git-commit calls ignore_non_trailer() to count up the
"#" cruft, which becomes the ignore_footer header. But it
works even without this patch! That's because the trailer
code _also_ calls ignore_non_trailer() and skips the cruft,
too. So it happens to work because the only callers with a
non-zero ignore_footer are using the exact same function
that the trailer parser uses internally.

And that seems true for all of the current callers, but
there's nothing guaranteeing it. We're better off only
feeding the correct buffer to the trailer code in the first
place.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this is probably worth doing, even if it's a noop. But I'm
really leaning towards the idea that the trailer code calling
ignore_non_trailer() is probably the wrong thing (in which case this
would be very important, since we'd be relying on the caller to remove
any cruft).

 sequencer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index c01ff79ab0..a1f0f17bcd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -231,11 +231,20 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	struct trailer_info info;
 	size_t i;
 	int found_sob = 0, found_sob_last = 0;
+	char saved_char;
 
 	opts.no_divider = 1;
 
+	if (ignore_footer) {
+		saved_char = sb->buf[sb->len - ignore_footer];
+		sb->buf[sb->len - ignore_footer] = '\0';
+	}
+
 	trailer_info_get(&info, sb->buf, &opts);
 
+	if (ignore_footer)
+		sb->buf[sb->len - ignore_footer] = saved_char;
+
 	if (info.trailer_start == info.trailer_end)
 		return 0;
 
-- 
2.19.0.rc0.412.g7005db4e88
