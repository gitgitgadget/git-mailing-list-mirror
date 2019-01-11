Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7FB211B5
	for <e@80x24.org>; Fri, 11 Jan 2019 19:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbfAKTaO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 14:30:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:34090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387696AbfAKTaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 14:30:13 -0500
Received: (qmail 9029 invoked by uid 109); 11 Jan 2019 19:30:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 19:30:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12548 invoked by uid 111); 11 Jan 2019 19:30:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 14:30:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 14:30:11 -0500
Date:   Fri, 11 Jan 2019 14:30:11 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] remote: check config validity before creating rewrite struct
Message-ID: <20190111193011.GA19839@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing url.foo.insteadOf, we call make_rewrite() and only then
check to make sure the value is a string (and return an error if it
isn't). This isn't quite a leak, because the struct we allocate is part
of a global array, but it does leave a funny half-finished struct.

In practice, it doesn't make much difference because we exit soon after
due to the config error anyway. But let's flip the order here to avoid
leaving a trap for somebody in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
This was a minor cleanup I mentioned in:

  https://public-inbox.org/git/20181122173109.GI28192@sigill.intra.peff.net/

but didn't get picked up.

 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 670dd44813..9cc3b07d21 100644
--- a/remote.c
+++ b/remote.c
@@ -337,14 +337,14 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!name)
 			return 0;
 		if (!strcmp(subkey, "insteadof")) {
-			rewrite = make_rewrite(&rewrites, name, namelen);
 			if (!value)
 				return config_error_nonbool(key);
+			rewrite = make_rewrite(&rewrites, name, namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		} else if (!strcmp(subkey, "pushinsteadof")) {
-			rewrite = make_rewrite(&rewrites_push, name, namelen);
 			if (!value)
 				return config_error_nonbool(key);
+			rewrite = make_rewrite(&rewrites_push, name, namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
-- 
2.20.1.651.g2d41a78c67
