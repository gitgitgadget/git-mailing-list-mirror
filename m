Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BD5202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 12:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755736AbdCLMjk (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 08:39:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:42825 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755727AbdCLMji (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 08:39:38 -0400
Received: (qmail 29947 invoked by uid 109); 12 Mar 2017 12:38:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 12:38:56 +0000
Received: (qmail 12410 invoked by uid 111); 12 Mar 2017 12:39:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 08:39:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 08:38:54 -0400
Date:   Sun, 12 Mar 2017 08:38:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] http-walker: fix buffer underflow processing remote
 alternates
Message-ID: <20170312123853.55ehe2jurozb6zad@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we parse a remote alternates (or http-alternates), we
expect relative lines like:

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
7 bytes), so there shouldn't be any security implications.

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
I posted this last week in the middle of another thread[1], but it
didn't get any attention. So here it is again.

I admit I don't care at all about http-alternates, but potential
out-of-range errors worry me.

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
2.12.0.518.gfbf68a9d3
