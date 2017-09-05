Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9B5208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdIEMOT (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:57130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751138AbdIEMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:18 -0400
Received: (qmail 31254 invoked by uid 109); 5 Sep 2017 12:14:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12175 invoked by uid 111); 5 Sep 2017 12:14:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:14:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:16 -0400
Date:   Tue, 5 Sep 2017 08:14:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/20] setup_temporary_shallow: avoid using inactive tempfile
Message-ID: <20170905121415.xo64jttpbzae7fsj@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there are no shallow entries to write, we skip creating
the tempfile entirely and try to return the empty string.

But we do so by calling get_tempfile_path() on the inactive
tempfile object. This will trigger an assertion that kills
the program. The bug was introduced by 6e122b449b
(setup_temporary_shallow(): use tempfile module,
2015-08-10). But nobody seems to have noticed since then
because we do not end up calling this function at all when
there are no shallow items. In other words, this code path
is completely unexercised.

Since the tempfile object is a static global, it _is_
possible that we call the function twice, writing out
shallow info the first time and then "reusing" our tempfile
object the second time. But:

  1. It seems unlikely that this was the intent, as hitting
     this code path would imply somebody clearing the
     shallow_info list between calls.

     And if somebody _did_ call the function multiple times
     without clearing the shallow_info list, we'd hit a
     different BUG for trying to reuse an already-active
     tempfile.

  2. I verified by code inspection that the function is only
     called once per program. And also replacing this code
     with a BUG() and running the test suite demonstrates
     that it is not triggered there.

So we could probably just replace this with an assertion and
confirm that it's never called. However, the original intent
does seem to be that you _could_ call it when the
shallow_info is empty. And that's easy enough to do; since
the return value doesn't need to point to a writable buffer,
we can just return a string literal.

Signed-off-by: Jeff King <peff@peff.net>
---
 shallow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index f5591e56da..29194b475a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -307,7 +307,7 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
 	 * is_repository_shallow() sees empty string as "no shallow
 	 * file".
 	 */
-	return get_tempfile_path(&temporary_shallow);
+	return "";
 }
 
 void setup_alternate_shallow(struct lock_file *shallow_lock,
-- 
2.14.1.721.gc5bc1565f1

