Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB071F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEIV3Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:29:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:53672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726682AbfEIV3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:29:24 -0400
Received: (qmail 10046 invoked by uid 109); 9 May 2019 21:29:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:29:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6453 invoked by uid 111); 9 May 2019 21:30:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:30:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:29:22 -0400
Date:   Thu, 9 May 2019 17:29:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/14] clone: drop dest parameter from copy_alternates()
Message-ID: <20190509212922.GD15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the inception of this function in e6baf4a1ae (clone: clone
from a repository with relative alternates, 2011-08-22), the "dest"
parameter has been unused. Instead, we use add_to_alternates_file(),
which relies on git_pathdup() to find the right file. That in turn works
because we will have initialized and entered the destination repo by
this point.

It's a bit subtle, but this is how it has always worked. And if our
assumptions change, the test in t5601 from e6baf4a1ae should let us
know.

In the meantime, let's drop this unused and confusing parameter from
copy_alternates().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 31a47d190a..9ddf4f99e5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -357,8 +357,7 @@ static void setup_reference(void)
 			     add_one_reference, &required);
 }
 
-static void copy_alternates(struct strbuf *src, struct strbuf *dst,
-			    const char *src_repo)
+static void copy_alternates(struct strbuf *src, const char *src_repo)
 {
 	/*
 	 * Read from the source objects/info/alternates file
@@ -439,7 +438,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 
 		/* Files that cannot be copied bit-for-bit... */
 		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
-			copy_alternates(src, dest, src_repo);
+			copy_alternates(src, src_repo);
 			continue;
 		}
 
-- 
2.21.0.1382.g4c6032d436

