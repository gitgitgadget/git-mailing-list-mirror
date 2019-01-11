Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CC4211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfAKWP4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:15:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:34216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725812AbfAKWP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:15:56 -0500
Received: (qmail 15740 invoked by uid 109); 11 Jan 2019 22:15:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 22:15:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13435 invoked by uid 111); 11 Jan 2019 22:15:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 17:15:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 17:15:54 -0500
Date:   Fri, 11 Jan 2019 17:15:54 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] config: make a copy of $GIT_CONFIG string
Message-ID: <20190111221554.GC10188@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111221414.GA31335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_config() points our source filename pointer at the return value of
getenv(), but that value may be invalidated by further calls to
environment functions. Let's copy it to make sure it remains valid.

We don't need to bother freeing it, as it remains part of the
whole-process global state until we exit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 84385ef165..2db4e763e7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -598,7 +598,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	int nongit = !startup_info->have_repository;
 	char *value;
 
-	given_config_source.file = getenv(CONFIG_ENVIRONMENT);
+	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
 
 	argc = parse_options(argc, argv, prefix, builtin_config_options,
 			     builtin_config_usage,
-- 
2.20.1.651.g2d41a78c67

