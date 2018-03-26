Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1FF1F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeCZH0V (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:26:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:42836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750923AbeCZH0U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:26:20 -0400
Received: (qmail 3205 invoked by uid 109); 26 Mar 2018 07:26:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 07:26:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17363 invoked by uid 111); 26 Mar 2018 07:27:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 03:27:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 03:26:18 -0400
Date:   Mon, 26 Mar 2018 03:26:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH 1/5] t3200: unset core.logallrefupdates when testing reflog
 creation
Message-ID: <20180326072618.GA12530@sigill.intra.peff.net>
References: <20180326072505.GA12436@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180326072505.GA12436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test checks that the "-l" option creates a reflog. But
in fact we'd create one even without it, since the default
in a non-bare repository is to do so. Let's unset the config
so we can be sure our "-l" option is kicking in.

Note that we can't do this with test_config, since that
would leave the variable unset after our test finishes,
confusing downstream tests (the helper is not smart enough
to restore the previous value, and just always runs
test_unconfig).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6c0b7ea4ad..e0c316b71a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -50,7 +50,7 @@ $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch:
 EOF
 test_expect_success 'git branch -l d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
-	git branch -l d/e/f &&
+	git -c core.logallrefupdates=false branch -l d/e/f &&
 	test_path_is_file .git/refs/heads/d/e/f &&
 	test_path_is_file .git/logs/refs/heads/d/e/f &&
 	test_cmp expect .git/logs/refs/heads/d/e/f
-- 
2.17.0.rc1.509.g060626845b

