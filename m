Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B512C6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 13:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDVN4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDVN4u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 09:56:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F22C1FEC
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 06:56:47 -0700 (PDT)
Received: (qmail 13729 invoked by uid 109); 22 Apr 2023 13:56:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 13:56:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29069 invoked by uid 111); 22 Apr 2023 13:56:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 09:56:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 09:56:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 2/2] fetch_bundle_uri(): drop pointless NULL check
Message-ID: <20230422135646.GA3942917@coredump.intra.peff.net>
References: <20230422135455.GA3942740@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230422135455.GA3942740@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check if "uri" is NULL, but it cannot be since we'd have segfaulted
earlier in the function when we unconditionally called xstrdup() on it.

In theory we might want to soften that xstrdup() to handle this case,
but even before the code which added it via c23f592117 (bundle-uri:
fetch a list of bundles, 2022-10-12), we'd have fed NULL to
fetch_bundle_uri_internal(), which would also segfault.

The extra check isn't hurting anything, but it does cause Coverity to
complain, and it may mislead somebody reading the code into thinking
that a NULL uri is something we're prepared to handle.

Signed-off-by: Jeff King <peff@peff.net>
---
 bundle-uri.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index e2b267cc02..f22490a2ca 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -795,10 +795,10 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
 	init_bundle_list(&list);
 
 	/*
-	 * Do not fetch a NULL or empty bundle URI. An empty bundle URI
+	 * Do not fetch an empty bundle URI. An empty bundle URI
 	 * could signal that a configured bundle URI has been disabled.
 	 */
-	if (!uri || !*uri) {
+	if (!*uri) {
 		result = 0;
 		goto cleanup;
 	}
-- 
2.40.0.653.g15ca972062
