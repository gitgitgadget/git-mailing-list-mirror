Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3BEB1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeKBPmn (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:42:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:37722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728409AbeKBPmn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:42:43 -0400
Received: (qmail 29460 invoked by uid 109); 2 Nov 2018 06:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 976 invoked by uid 111); 2 Nov 2018 06:35:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:35:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:36:36 -0400
Date:   Fri, 2 Nov 2018 02:36:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/9] diff: discard hunk headers for patch-ids earlier
Message-ID: <20181102063636.GD31216@sigill.intra.peff.net>
References: <20181102063156.GA30252@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102063156.GA30252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not include hunk header lines when computing patch-ids, since
the line numbers would create false negatives. Rather than detect and
skip them in our line callback, we can simply tell xdiff to avoid
generating them.

This is similar to the previous commit, but split out because it
actually requires modifying the matching line callback.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index d84356e007..8a83ce6058 100644
--- a/diff.c
+++ b/diff.c
@@ -5666,10 +5666,6 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 	struct patch_id_t *data = priv;
 	int new_len;
 
-	/* Ignore line numbers when computing the SHA1 of the patch */
-	if (starts_with(line, "@@ -"))
-		return;
-
 	new_len = remove_space(line, len);
 
 	git_SHA1_Update(data->ctx, line, new_len);
@@ -5771,8 +5767,8 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		xpp.flags = 0;
 		xecfg.ctxlen = 3;
 		xecfg.flags = 0;
-		if (xdi_diff_outf(&mf1, &mf2, NULL, patch_id_consume,
-				  &data, &xpp, &xecfg))
+		if (xdi_diff_outf(&mf1, &mf2, discard_hunk_line,
+				  patch_id_consume, &data, &xpp, &xecfg))
 			return error("unable to generate patch-id diff for %s",
 				     p->one->path);
 	}
-- 
2.19.1.1336.g081079ac04

