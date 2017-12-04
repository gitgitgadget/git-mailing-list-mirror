Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0F620954
	for <e@80x24.org>; Mon,  4 Dec 2017 22:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbdLDWF0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 17:05:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:47984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752464AbdLDWFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 17:05:25 -0500
Received: (qmail 11007 invoked by uid 109); 4 Dec 2017 22:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 22:05:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27498 invoked by uid 111); 4 Dec 2017 22:05:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 17:05:45 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 17:05:23 -0500
Date:   Mon, 4 Dec 2017 17:05:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 1/2] progress: set default delay threshold to 100%, not 0%
Message-ID: <20171204220523.GA18828@sigill.intra.peff.net>
References: <20171204220228.GA29422@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171204220228.GA29422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 8aade107dd (progress: simplify "delayed" progress
API, 2017-08-19) dropped the parameter by which callers
could say "show my progress only if I haven't passed M%
progress after N seconds". The intent was to just show
nothing for 2 seconds, and then always progress after that.

But we flipped the logic in the wrapper: it sets M=0,
meaning that we'd almost _never_ show progress after 2
seconds, since we'd generally have made some progress. This
should have been 100%, not 0%.

We were fooled by existing calls like:

  start_progress_delay("foo", 0, 0, 2);

which behaved this way. The trick is that the first "0"
there is "how many items total", and there zero means "we
don't know". And without knowing that, we cannot compute a
completed percent at all, and we ignored the threshold
parameter entirely! Modeling our wrapper after that broke
callers which pass a non-zero value for "total".

We can switch to the intended behavior by using "100" in the
wrapper call.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index 289678d43d..b774cb1cd1 100644
--- a/progress.c
+++ b/progress.c
@@ -229,7 +229,7 @@ static struct progress *start_progress_delay(const char *title, unsigned total,
 
 struct progress *start_delayed_progress(const char *title, unsigned total)
 {
-	return start_progress_delay(title, total, 0, 2);
+	return start_progress_delay(title, total, 100, 2);
 }
 
 struct progress *start_progress(const char *title, unsigned total)
-- 
2.15.0.691.g622df76569

