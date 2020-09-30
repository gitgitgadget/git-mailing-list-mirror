Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8299DC4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF8720789
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgI3MeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:34:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:45334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgI3MeM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:34:12 -0400
Received: (qmail 24039 invoked by uid 109); 30 Sep 2020 12:34:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:34:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28121 invoked by uid 111); 30 Sep 2020 12:34:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:34:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:34:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/10] sequencer: handle ignore_footer when parsing trailers
Message-ID: <20200930123411.GI1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
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
This was actually posted as part of an earlier series:

  https://lore.kernel.org/git/20180824072629.GA11977@sigill.intra.peff.net/

It ended as:

  I think patch 9 is not hurting anything and may later help us, but I
  could take or leave it.

and we left it. But now I have the ulterior motive of wanting to get rid
of the unused parameter warning. :) Another option would be to leave the
code as-is and just drop the ignored parameter. But I think this is
probably a safe and reasonable patch (I've been running with it in my
personal fork for 2 years, though perhaps I don't really exercise the
trailer code's corner cases myself).

 sequencer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 6e9aabaac1..e454264fbc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -249,11 +249,20 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
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
2.28.0.1173.gad90222cf0

