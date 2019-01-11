Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5297211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfAKWPC (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:15:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:34204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725812AbfAKWPC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:15:02 -0500
Received: (qmail 15723 invoked by uid 109); 11 Jan 2019 22:15:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 22:15:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13399 invoked by uid 111); 11 Jan 2019 22:15:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 17:15:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 17:15:00 -0500
Date:   Fri, 11 Jan 2019 17:15:00 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] get_super_prefix(): copy getenv() result
Message-ID: <20190111221500.GA10188@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111221414.GA31335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value of getenv() is not guaranteed to remain valid across
multiple calls (nor across calls to setenv()). Since this function
caches the result for the length of the program, we must make a copy to
ensure that it is still valid when we need it.

Reported-by: Yngve N. Pettersen <yngve@vivaldi.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 environment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index 0e37741d83..89af47cb85 100644
--- a/environment.c
+++ b/environment.c
@@ -107,7 +107,7 @@ char *git_work_tree_cfg;
 
 static char *git_namespace;
 
-static const char *super_prefix;
+static char *super_prefix;
 
 /*
  * Repository-local GIT_* environment variables; see cache.h for details.
@@ -240,7 +240,7 @@ const char *get_super_prefix(void)
 {
 	static int initialized;
 	if (!initialized) {
-		super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);
+		super_prefix = xstrdup_or_null(getenv(GIT_SUPER_PREFIX_ENVIRONMENT));
 		initialized = 1;
 	}
 	return super_prefix;
-- 
2.20.1.651.g2d41a78c67

