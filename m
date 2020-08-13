Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC095C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF1620771
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMPzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:55:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:57890 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMPzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:55:53 -0400
Received: (qmail 20322 invoked by uid 109); 13 Aug 2020 15:55:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 15:55:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15122 invoked by uid 111); 13 Aug 2020 15:55:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 11:55:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 11:55:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] ls-remote: simplify UNLEAK() usage
Message-ID: <20200813155551.GB897132@coredump.intra.peff.net>
References: <20200813155426.GA896769@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813155426.GA896769@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We UNLEAK() the "sorting" list created by parsing command-line options
(which is essentially used until the program exits). But we do so right
before leaving the cmd_ls_remote() function, which means we have to hit
all of the exits. But the point of UNLEAK() is that it's an annotation
which doesn't impact the variable itself. We can mark it as soon as
we're done writing its value, and then we only have to do so once.

This gives us a minor code reduction, and serves as a better example of
how UNLEAK() can be used.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/ls-remote.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index ea91679f33..092917eca2 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -83,6 +83,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
 
+	UNLEAK(sorting);
+
 	if (argc > 1) {
 		int i;
 		pattern = xcalloc(argc, sizeof(const char *));
@@ -107,7 +109,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	if (get_url) {
 		printf("%s\n", *remote->url);
-		UNLEAK(sorting);
 		return 0;
 	}
 
@@ -122,10 +123,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
-	if (transport_disconnect(transport)) {
-		UNLEAK(sorting);
+	if (transport_disconnect(transport))
 		return 1;
-	}
 
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
@@ -150,7 +149,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		status = 0; /* we found something */
 	}
 
-	UNLEAK(sorting);
 	ref_array_clear(&ref_array);
 	return status;
 }
-- 
2.28.0.573.gec6564704b
