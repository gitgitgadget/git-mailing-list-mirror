Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA473208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdIENEQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:04:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:57304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751160AbdIENEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:04:16 -0400
Received: (qmail 2070 invoked by uid 109); 5 Sep 2017 13:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:04:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12760 invoked by uid 111); 5 Sep 2017 13:04:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:04:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:04:14 -0400
Date:   Tue, 5 Sep 2017 09:04:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/10] update-index: fix cache entry leak in add_one_file()
Message-ID: <20170905130413.eyifiklpr53s5kg4@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we fail to add the cache entry to the index, we end up
just leaking the struct. We should follow the pattern of the
early-return above and free it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/update-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 655e6d60d3..bf7420b808 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -287,8 +287,10 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option))
+	if (add_cache_entry(ce, option)) {
+		free(ce);
 		return error("%s: cannot add to the index - missing --add option?", path);
+	}
 	return 0;
 }
 
-- 
2.14.1.721.gc5bc1565f1

