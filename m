Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9E81F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeKEP6T (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:58:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:40378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbeKEP6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:58:19 -0500
Received: (qmail 21666 invoked by uid 109); 5 Nov 2018 06:40:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:40:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17142 invoked by uid 111); 5 Nov 2018 06:39:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:39:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:40:10 -0500
Date:   Mon, 5 Nov 2018 01:40:10 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/13] cat-file: mark batch options with NONEG
Message-ID: <20181105064010.GE25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "cat-file --no-batch" will behave as if "--batch" was given,
since the option callback does not handle the "unset" flag (likewise for
"--no-batch-check").

In theory this might be used to cancel an earlier --batch, but it's not
immediately obvious how that would interact with --batch-check. Let's
just disallow the negated form of both options.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8d97c84725..4a5289079c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -631,10 +631,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
-			PARSE_OPT_OPTARG, batch_option_callback },
+			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
+			batch_option_callback },
 		{ OPTION_CALLBACK, 0, "batch-check", &batch, "format",
 			N_("show info about objects fed from the standard input"),
-			PARSE_OPT_OPTARG, batch_option_callback },
+			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
+			batch_option_callback },
 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
 		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
-- 
2.19.1.1505.g9cd28186cf

