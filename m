Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC3F1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 14:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbdCMOEw (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 10:04:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:43144 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752923AbdCMOEt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 10:04:49 -0400
Received: (qmail 10022 invoked by uid 109); 13 Mar 2017 14:04:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 14:04:48 +0000
Received: (qmail 18326 invoked by uid 111); 13 Mar 2017 14:04:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 10:04:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 10:04:45 -0400
Date:   Mon, 13 Mar 2017 10:04:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] http-walker: fix buffer underflow processing remote
 alternates
Message-ID: <20170313140445.bjdxnjylirn3e5z3@sigill.intra.peff.net>
References: <20170312123853.55ehe2jurozb6zad@sigill.intra.peff.net>
 <xmqqfuihu382.fsf@gitster.mtv.corp.google.com>
 <20170313135053.3pi56dfdlcva66ml@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170313135053.3pi56dfdlcva66ml@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 09:50:53AM -0400, Jeff King wrote:

> > Isn't the reason why the function wants to strip "objects" at the
> > end because it then expects to be able to tack strings like
> > "objects/info/packs", etc. after the result of stripping, i.e.
> > $URL/../foo.git/, and get usable URLs to download other things?
> 
> Good point. I think that behavior is a misfeature in the first place. It
> should be leaving the path as-is and tacking "info/packs", etc.
> 
> But without fixing that, yeah, there is not much value in the "maybe
> strip" behavior (unless you happen to provide the incorrect path that
> does not include "objects" in the first place, but then it would not
> work as a _local_ alternate).
> 
> > I think it is very sensible to use strip_suffix() to notice that the
> > alternate does not end with "/objects", but I am not sure if it is a
> > good idea to proceed without stripping when it does not end with
> > "/objects".  Shouldn't we be ignoring (with warning, possibly) such
> > a remote alternate?
> 
> Yeah, probably warn and ignore is the best bet. I'll re-work the patch.

OK, so here's v2 that just rejects things that don't end in "objects".
For the expected case, it would be more robust to look for "/objects",
but we do not add back in the "/" when making requests. So technically:

  ../some-path/my-objects

works now, and would not if we were more picky. I doubt anybody cares,
but I went for the minimal behavior change here. If anybody wants to get
more fancy, the correct path is to leave the path intact here and teach
the appending side to stop re-adding "objects".

-- >8 --
Subject: http-walker: fix buffer underflow processing remote alternates

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
fail (since we can't generall allocate the max size_t minus
7 bytes), so there shouldn't be any security implications.

Let's fix this by using strbuf_strip_suffix() to drop the
characters we want. If they're not present, we'll ignore the
alternate (in theory we could use it as-is, but the rest of
the http-walker code unconditionally tacks "objects/" back
on, so it is it not prepared to handle such a case).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index b34b6ace7..507c200f0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -296,13 +296,16 @@ static void process_alternates_response(void *callback_data)
 					okay = 1;
 				}
 			}
-			/* skip "objects\n" at end */
 			if (okay) {
 				struct strbuf target = STRBUF_INIT;
 				strbuf_add(&target, base, serverlen);
-				strbuf_add(&target, data + i, posn - i - 7);
-
-				if (is_alternate_allowed(target.buf)) {
+				strbuf_add(&target, data + i, posn - i);
+				if (!strbuf_strip_suffix(&target, "objects")) {
+					warning("ignoring alternate that does"
+						" not end in 'objects': %s",
+						target.buf);
+					strbuf_release(&target);
+				} else if (is_alternate_allowed(target.buf)) {
 					warning("adding alternate object store: %s",
 						target.buf);
 					newalt = xmalloc(sizeof(*newalt));
-- 
2.12.0.518.gfbf68a9d3

