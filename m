Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66291F454
	for <e@80x24.org>; Mon,  5 Nov 2018 06:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeKEQBy (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:01:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:40408 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbeKEQBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:01:54 -0500
Received: (qmail 21899 invoked by uid 109); 5 Nov 2018 06:43:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:43:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17228 invoked by uid 111); 5 Nov 2018 06:43:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:43:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:43:44 -0500
Date:   Mon, 5 Nov 2018 01:43:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/13] cat-file: report an error on multiple --batch options
Message-ID: <20181105064344.GJ25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options callback for --batch and --batch-check detects when the two
mutually incompatible options are used. But it simply returns an error
code to parse-options, meaning the program will quit without any kind of
message to the user.

Instead, let's use error() to print something and return -1. Note that
this flips the error return from 1 to -1, but negative values are more
idiomatic here (and parse-options treats them the same).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4a5289079c..0f6b692df6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -596,7 +596,7 @@ static int batch_option_callback(const struct option *opt,
 	struct batch_options *bo = opt->value;
 
 	if (bo->enabled) {
-		return 1;
+		return error(_("only one batch option may be specified"));
 	}
 
 	bo->enabled = 1;
-- 
2.19.1.1505.g9cd28186cf

