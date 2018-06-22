Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E441F516
	for <e@80x24.org>; Fri, 22 Jun 2018 09:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeFVJX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 05:23:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:51760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753177AbeFVJXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 05:23:54 -0400
Received: (qmail 3844 invoked by uid 109); 22 Jun 2018 09:23:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Jun 2018 09:23:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16645 invoked by uid 111); 22 Jun 2018 09:24:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Jun 2018 05:24:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2018 05:23:52 -0400
Date:   Fri, 22 Jun 2018 05:23:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 1/4] t3200: unset core.logallrefupdates when testing
 reflog creation
Message-ID: <20180622092352.GA13573@sigill.intra.peff.net>
References: <20180622092327.GA8361@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622092327.GA8361@sigill.intra.peff.net>
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
confusing downstream tests (the helper is not not smart
enough to restore the previous value, and just always runs
test_unconfig).

Signed-off-by: Jeff King <peff@peff.net>
---
Same as before.

 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 08467982f6..ec56176093 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -51,7 +51,7 @@ $ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	bran
 EOF
 test_expect_success 'git branch -l d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
-	git branch -l d/e/f &&
+	git -c core.logallrefupdates=false branch -l d/e/f &&
 	test_path_is_file .git/refs/heads/d/e/f &&
 	test_path_is_file .git/logs/refs/heads/d/e/f &&
 	test_cmp expect .git/logs/refs/heads/d/e/f
-- 
2.18.0.539.gcf23d6d4f1

