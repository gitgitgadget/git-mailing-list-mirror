Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A4D20133
	for <e@80x24.org>; Sat,  4 Mar 2017 03:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbdCDDun (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 22:50:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:38486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbdCDDum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 22:50:42 -0500
Received: (qmail 5117 invoked by uid 109); 4 Mar 2017 03:49:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 03:49:18 +0000
Received: (qmail 3637 invoked by uid 111); 4 Mar 2017 03:49:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 22:49:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 22:49:15 -0500
Date:   Fri, 3 Mar 2017 22:49:15 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jann Horn <jannh@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH] http: inform about alternates-as-redirects behavior
Message-ID: <20170304034914.cgyvz735lxhe2cno@sigill.intra.peff.net>
References: <20170304013504.GA27183@untitled>
 <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 10:13:14PM -0500, Jeff King wrote:

> > -	if (http_follow_config != HTTP_FOLLOW_ALWAYS)
> > -		return;
> > -
> 
> I was surprised from the description to see not just the addition of a
> warning, but a movement of the enforcement code.
> 
> I think it's necessary because the original did not bother even fetching
> http-alternates if we were not going to respect it. Whereas the new code
> will fetch and parse it, and warn only if we actually found something in
> it. Which seems reasonable.

One side effect of this is that it exposes[1] the http-alternates
parsing code to the server's input, even if we aren't planning on using
the result. That code is not very well audited. Just looking at the
context from your patches, I noticed one obvious memory access problem.
The fix is below.

-Peff

[1] Obviously this same code was exposed prior to the redirect-limiting
    patches, so it's not like there aren't tons of older clients that
    exhibit the same behavior. But IMHO one of the beneficial side
    effects of the redirect-limiting was that it avoided this largely
    unused and untested code entirely.

-- >8 --
Subject: http-walker: fix buffer underflow processing remote alternates

If we parse a remote alternates (or http-alternates) file,
we expect relative lines like:

  ../../foo.git/objects

which we convert into "$URL/../foo.git/" (and then use that
as a base for fetching more objects).

But if the remote feeds us nonsense like just:

  ../

we will try to blindly strip the last 7 characters, assuming
they contain the string "objects". Since we don't _have_ 7
characters at all, this results in feeding a small negative
value to strbuf_add(), which converts it to a size_t,
resulting in a big positive value. This should consistently
fail (since we can't generally allocate the max size_t minus
7 bytes), so there shouldn't be any security implications
(and even if we did allocate, we'd just copy in gigabytes of
garbage, not overflow a buffer).

Let's fix this by using strbuf_strip_suffix() to drop the
characters we want. As a bonus this lets us handle names
that do not end in "objects" (all git repos do, but there is
nothing to say that an alternate object store needs to be a
git repo).

And while we're here, we can add a few other parsing
niceties, like dropping trailing whitespace, and handling
names that do not end in "/".

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index b34b6ace7..d62ca8953 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -296,11 +296,13 @@ static void process_alternates_response(void *callback_data)
 					okay = 1;
 				}
 			}
-			/* skip "objects\n" at end */
 			if (okay) {
 				struct strbuf target = STRBUF_INIT;
 				strbuf_add(&target, base, serverlen);
-				strbuf_add(&target, data + i, posn - i - 7);
+				strbuf_add(&target, data + i, posn - i);
+				strbuf_rtrim(&target);
+				strbuf_strip_suffix(&target, "objects");
+				strbuf_complete(&target, '/');
 
 				if (is_alternate_allowed(target.buf)) {
 					warning("adding alternate object store: %s",
-- 
2.12.0.404.g442e75cca

