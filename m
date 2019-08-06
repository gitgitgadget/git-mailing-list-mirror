Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8C71F731
	for <e@80x24.org>; Tue,  6 Aug 2019 14:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbfHFOkR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 10:40:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:35404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729535AbfHFOkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 10:40:17 -0400
Received: (qmail 17886 invoked by uid 109); 6 Aug 2019 14:40:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 14:40:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2409 invoked by uid 111); 6 Aug 2019 14:42:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 10:42:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 10:40:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] parse-options: allow --end-of-options as a synonym for
 "--"
Message-ID: <20190806144015.GB2161@sigill.intra.peff.net>
References: <20190806143829.GA515@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806143829.GA515@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The revision option parser recently learned about --end-of-options, but
that's not quite enough for all callers. Some of them, like git-log,
pick out some options using parse_options(), and then feed the remainder
to setup_revisions(). For those cases we need to stop parse_options()
from finding more options when it sees --end-of-options, and to retain
that option in argv so that setup_revisions() can see it as well.

Let's handle this the same as we do "--". We can even piggy-back on the
handling of PARSE_OPT_KEEP_DASHDASH, because any caller that wants to
retain one will want to retain the other.

I've included two tests here. The "log" test covers "--source", which is
one of the options it handles with parse_options(), and would fail
before this patch. There's also a test that uses the parse-options
helper directly. That confirms that the option is handled correctly even
in cases without KEEP_DASHDASH or setup_revisions(). I.e., it is safe to
use --end-of-options in place of "--" in other programs.

Signed-off-by: Jeff King <peff@peff.net>
---
 parse-options.c          | 3 ++-
 t/t0040-parse-options.sh | 7 +++++++
 t/t4202-log.sh           | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 87b26a1d92..b42f54d48b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -780,7 +780,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			continue;
 		}
 
-		if (!arg[2]) { /* "--" */
+		if (!arg[2] /* "--" */ ||
+		    !strcmp(arg + 2, "end-of-options")) {
 			if (!(ctx->flags & PARSE_OPT_KEEP_DASHDASH)) {
 				ctx->argc--;
 				ctx->argv++;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index cebc77fab0..705a136ed9 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -399,4 +399,11 @@ test_expect_success 'GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS works' '
 		test-tool parse-options --ye
 '
 
+test_expect_success '--end-of-options treats remainder as args' '
+	test-tool parse-options \
+	    --expect="verbose: -1" \
+	    --expect="arg 00: --verbose" \
+	    --end-of-options --verbose
+'
+
 test_done
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index c20209324c..e88ccb04a9 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1707,4 +1707,11 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git log --exclude-promisor-objects source-a
 '
 
+test_expect_success 'log --end-of-options' '
+       git update-ref refs/heads/--source HEAD &&
+       git log --end-of-options --source >actual &&
+       git log >expect &&
+       test_cmp expect actual
+'
+
 test_done
-- 
2.23.0.rc1.436.g24d2e81391

