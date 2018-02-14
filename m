Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A340A1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161620AbeBNSHV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:07:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:52278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1161585AbeBNSHU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:07:20 -0500
Received: (qmail 29299 invoked by uid 109); 14 Feb 2018 18:07:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 18:07:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31029 invoked by uid 111); 14 Feb 2018 18:08:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 13:08:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 13:07:19 -0500
Date:   Wed, 14 Feb 2018 13:07:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] test-hashmap: use strbuf_getline rather than fgets
Message-ID: <20180214180718.GD9919@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214180322.GA9190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using fgets() with a fixed-size buffer can lead to lines
being accidentally split across two calls if they are larger
than the buffer size.

As this is just a test helper, this is unlikely to be a
problem in practice. But since people may look at test
helpers as reference code, it's a good idea for them to
model the preferred behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-hashmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 28b913fbd6..15fc4e372f 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "hashmap.h"
+#include "strbuf.h"
 
 struct test_entry
 {
@@ -143,7 +144,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
  */
 int cmd_main(int argc, const char **argv)
 {
-	char line[1024];
+	struct strbuf line = STRBUF_INIT;
 	struct hashmap map;
 	int icase;
 
@@ -152,13 +153,13 @@ int cmd_main(int argc, const char **argv)
 	hashmap_init(&map, test_entry_cmp, &icase, 0);
 
 	/* process commands from stdin */
-	while (fgets(line, sizeof(line), stdin)) {
+	while (strbuf_getline(&line, stdin) != EOF) {
 		char *cmd, *p1 = NULL, *p2 = NULL;
 		int l1 = 0, l2 = 0, hash = 0;
 		struct test_entry *entry;
 
 		/* break line into command and up to two parameters */
-		cmd = strtok(line, DELIM);
+		cmd = strtok(line.buf, DELIM);
 		/* ignore empty lines */
 		if (!cmd || *cmd == '#')
 			continue;
@@ -262,6 +263,7 @@ int cmd_main(int argc, const char **argv)
 		}
 	}
 
+	strbuf_release(&line);
 	hashmap_free(&map, 1);
 	return 0;
 }
-- 
2.16.1.464.gc4bae515b7

