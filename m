Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C39D208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdIEMPA (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:15:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:57198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIEMO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:58 -0400
Received: (qmail 31340 invoked by uid 109); 5 Sep 2017 12:14:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12343 invoked by uid 111); 5 Sep 2017 12:15:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:56 -0400
Date:   Tue, 5 Sep 2017 08:14:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 14/20] tempfile: release deactivated strbufs instead of
 resetting
Message-ID: <20170905121456.x4gwz3kuvvygpt55@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a tempfile is deactivated, we reset its strbuf to the
empty string, which means we hold onto the memory for later
reuse.

Since we'd like to move to a system where tempfile structs
can actually be freed, deactivating one should drop all
resources it is currently using. And thus "release" rather
than "reset" is the appropriate function to call.

In theory the reset may have saved a malloc() when a
tempfile (or a lockfile) is reused multiple times. But in
practice this happened rarely. Most of our tempfiles are
single-use, since in cases where we might actually use many
(like ref locking) we xcalloc() a fresh one for each ref. In
fact, we leak those locks (to appease the rule that tempfile
storage can never be freed). Which means that using reset is
actively hurting us: instead of leaking just the tempfile
struct, we're leaking the extra heap chunk for the filename,
too.

Signed-off-by: Jeff King <peff@peff.net>
---
 tempfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tempfile.c b/tempfile.c
index 3348ad59dd..e655e28477 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -128,7 +128,7 @@ static void activate_tempfile(struct tempfile *tempfile)
 static void deactivate_tempfile(struct tempfile *tempfile)
 {
 	tempfile->active = 0;
-	strbuf_reset(&tempfile->filename);
+	strbuf_release(&tempfile->filename);
 }
 
 /* Make sure errno contains a meaningful value on error */
-- 
2.14.1.721.gc5bc1565f1

