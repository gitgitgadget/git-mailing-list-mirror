Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB431F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeKBPpr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:45:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:37746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727745AbeKBPpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:45:46 -0400
Received: (qmail 29619 invoked by uid 109); 2 Nov 2018 06:39:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:39:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1040 invoked by uid 111); 2 Nov 2018 06:38:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:38:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:39:40 -0400
Date:   Fri, 2 Nov 2018 02:39:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 8/9] range-diff: use a hunk callback
Message-ID: <20181102063939.GH31216@sigill.intra.peff.net>
References: <20181102063156.GA30252@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102063156.GA30252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we count the lines in a diff, we don't actually care about the
contents of each line. By using a hunk callback, we tell xdiff that it
does not need to even bother generating a hunk header line, saving a
small amount of work.

Arguably we could even ignore the hunk headers completely, since we're
just computing a cost function between patches. But doing it this way
maintains the exact same behavior before and after.

Signed-off-by: Jeff King <peff@peff.net>
---
This one might be going overboard. It can be dropped without affecting
any of the other patches.

 range-diff.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 245fc17fee..3958720f00 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -197,6 +197,12 @@ static void diffsize_consume(void *data, char *line, unsigned long len)
 	(*(int *)data)++;
 }
 
+static void diffsize_hunk(void *data, long ob, long on, long nb, long nn,
+			  const char *funcline, long funclen)
+{
+	diffsize_consume(data, NULL, 0);
+}
+
 static int diffsize(const char *a, const char *b)
 {
 	xpparam_t pp = { 0 };
@@ -210,7 +216,9 @@ static int diffsize(const char *a, const char *b)
 	mf2.size = strlen(b);
 
 	cfg.ctxlen = 3;
-	if (!xdi_diff_outf(&mf1, &mf2, NULL, diffsize_consume, &count, &pp, &cfg))
+	if (!xdi_diff_outf(&mf1, &mf2,
+			   diffsize_hunk, diffsize_consume, &count,
+			   &pp, &cfg))
 		return count;
 
 	error(_("failed to generate diff"));
-- 
2.19.1.1336.g081079ac04

