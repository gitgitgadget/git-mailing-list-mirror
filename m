Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4391F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfIEWyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:54:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:41484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725975AbfIEWyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:54:32 -0400
Received: (qmail 10427 invoked by uid 109); 5 Sep 2019 22:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 22:54:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32593 invoked by uid 111); 5 Sep 2019 22:56:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 18:56:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 18:54:31 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH 5/6] test-read-cache: drop namelen variable
Message-ID: <20190905225431.GE25657@sigill.intra.peff.net>
References: <20190905224859.GA28660@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905224859.GA28660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Early in the function we set "namelen = strlen(name)" if "name" is
non-NULL. Later, we use "namelen" only if "name" is non-NULL. However,
it's hard to immediately see this, and it seems to confuse gcc 9.2.1
(with "-flto" interestingly, though all of the involved logic is in
inline functions; it also triggers when building with ASan).

Let's simplify the code and remove the variable entirely. There's only
one use of namelen anyway, so we can just call strlen() then. It's true
this is in a loop, so we might execute strlen() more often. But:

  - this is test code that only ever loops twice in our test suite (we
    do loop 1000 times in a t/perf test, but without using this option).

  - a decent compiler ought to be able to hoist that out of the loop
    anyway (though I wouldn't count on gcc 9.2.1 doing so!)

Reported-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-read-cache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 7e79b555de..244977a29b 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -4,11 +4,10 @@
 
 int cmd__read_cache(int argc, const char **argv)
 {
-	int i, cnt = 1, namelen;
+	int i, cnt = 1;
 	const char *name = NULL;
 
 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
-		namelen = strlen(name);
 		argc--;
 		argv++;
 	}
@@ -24,7 +23,7 @@ int cmd__read_cache(int argc, const char **argv)
 
 			refresh_index(&the_index, REFRESH_QUIET,
 				      NULL, NULL, NULL);
-			pos = index_name_pos(&the_index, name, namelen);
+			pos = index_name_pos(&the_index, name, strlen(name));
 			if (pos < 0)
 				die("%s not in index", name);
 			printf("%s is%s up to date\n", name,
-- 
2.23.0.463.g883b23b1c5

