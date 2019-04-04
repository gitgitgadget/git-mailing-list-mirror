Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0713220248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfDDX2L (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:28:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:47428 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727039AbfDDX2K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:28:10 -0400
Received: (qmail 1489 invoked by uid 109); 4 Apr 2019 23:28:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:28:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20461 invoked by uid 111); 4 Apr 2019 23:28:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:28:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:28:08 -0400
Date:   Thu, 4 Apr 2019 19:28:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/12] server-info: simplify cleanup in parse_pack_def()
Message-ID: <20190404232808.GG21839@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have two exits from the function: either we jump to the out_stale
label or not. But in both exits we repeat our cleanup, and the only
difference is our return value. Let's just use a variable for the return
value to avoid repeating ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 server-info.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/server-info.c b/server-info.c
index b61a6be4c2..ba44cece7f 100644
--- a/server-info.c
+++ b/server-info.c
@@ -133,6 +133,7 @@ static int read_pack_info_file(const char *infofile)
 	FILE *fp;
 	char line[1000];
 	int old_cnt = 0;
+	int stale = 1;
 
 	fp = fopen_or_warn(infofile, "r");
 	if (!fp)
@@ -161,11 +162,11 @@ static int read_pack_info_file(const char *infofile)
 			error("unrecognized: %s", line);
 		}
 	}
-	fclose(fp);
-	return 0;
+	stale = 0;
+
  out_stale:
 	fclose(fp);
-	return 1;
+	return stale;
 }
 
 static int compare_info(const void *a_, const void *b_)
-- 
2.21.0.714.gd1be1d035b

