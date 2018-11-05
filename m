Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFAD1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeKEP4r (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:56:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:40360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbeKEP4r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:56:47 -0500
Received: (qmail 21534 invoked by uid 109); 5 Nov 2018 06:38:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:38:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17094 invoked by uid 111); 5 Nov 2018 06:37:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:37:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:38:39 -0500
Date:   Mon, 5 Nov 2018 01:38:39 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/13] am: handle --no-patch-format option
Message-ID: <20181105063839.GB25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "git am --no-patch-format" will currently segfault, since it
tries to parse a NULL argument. Instead, let's have it cancel any
previous --patch-format option.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3ee9a9d2a9..dcb880b699 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2165,7 +2165,9 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 {
 	int *opt_value = opt->value;
 
-	if (!strcmp(arg, "mbox"))
+	if (unset)
+		*opt_value = PATCH_FORMAT_UNKNOWN;
+	else if (!strcmp(arg, "mbox"))
 		*opt_value = PATCH_FORMAT_MBOX;
 	else if (!strcmp(arg, "stgit"))
 		*opt_value = PATCH_FORMAT_STGIT;
-- 
2.19.1.1505.g9cd28186cf

