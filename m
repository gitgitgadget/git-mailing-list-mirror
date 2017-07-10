Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0602035B
	for <e@80x24.org>; Mon, 10 Jul 2017 07:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbdGJHEF (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 03:04:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:35192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752396AbdGJHEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 03:04:04 -0400
Received: (qmail 3219 invoked by uid 109); 10 Jul 2017 07:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 07:03:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3591 invoked by uid 111); 10 Jul 2017 07:03:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 03:03:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 03:03:42 -0400
Date:   Mon, 10 Jul 2017 03:03:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 09, 2017 at 10:05:49AM -0700, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> > I wonder when we can begin to target C99 in git's source, though. :)
> 
> Let's get the ball rolling by starting to use some of the useful
> features like designated initializers, perhaps, in a small, critical
> and reasonably stable part of the system that anybody must compile,
> leave it in one full release cycle or two, and when we hear nobody
> complains, introduce it en masse for the remainder of the system?
> 
> That way, we will see if there are people who need pre-C99 soon
> enough, and we won't have to scramble reverting too many changes
> when it happens.

Neat idea. Something like this?

-- >8 --
Subject: [PATCH] strbuf: use designated initializers in STRBUF_INIT

There are certain C99 features that might be nice to use in
our code base, but we've hesitated to do so in order to
avoid breaking compatibility with older compilers. But we
don't actually know if people are even using pre-C99
compilers these days.

One way to figure that out is to introduce a very small use
of a feature, and see if anybody complains. The strbuf code
is a good place to do this for a few reasons:

  - it always gets compiled, no matter which Makefile knobs
    have been tweaked.

  - it's very stable; this definition hasn't changed in a
    long time and is not likely to (so if we have to revert,
    it's unlikely to cause headaches)

If this patch can survive a few releases without complaint,
then we can feel more confident that designated initializers
are widely supported by our user base.  It also is an
indication that other C99 features may be supported, but not
a guarantee (e.g., gcc had designated initializers before
C99 existed).

And if we do get complaints, then we'll have gained some
data and we can easily revert this patch.

Signed-off-by: Jeff King <peff@peff.net>
---
I suspected we could also do something with __STDC_VERSION__, though I
wonder what compilers set it to when not in standards-compliant mode.
gcc-6 claims C11 when no specific -std flag is given.

And obviously before releasing this or anything similar, it would be
nice to see results from people building pu. I'm especially curious
whether MSVC would work with this (or if people even still use it, since
Git for Windows is pretty mature?).

 strbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 2075384e0..e705b94db 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -68,7 +68,7 @@ struct strbuf {
 };
 
 extern char strbuf_slopbuf[];
-#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
+#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
 
 /**
  * Life Cycle Functions
-- 
2.13.2.1071.gcd8104b61

