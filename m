Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA55C201A7
	for <e@80x24.org>; Sat, 13 May 2017 03:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdEMD3W (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 23:29:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:50641 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbdEMD3V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 23:29:21 -0400
Received: (qmail 6580 invoked by uid 109); 13 May 2017 03:29:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 03:29:21 +0000
Received: (qmail 29078 invoked by uid 111); 13 May 2017 03:29:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 23:29:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 23:29:18 -0400
Date:   Fri, 12 May 2017 23:29:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] setup_git_env: convert die("BUG") to BUG()
Message-ID: <20170513032918.cisxuwoi6lvswetg@sigill.intra.peff.net>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Converting to BUG() makes it easier to detect and debug
cases where we hit this assertion. Coupled with a new test
in t1300, this shows that the test suite can detect such
corner cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 environment.c          | 2 +-
 t/t1300-repo-config.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index ff6e4f06e..1f0bda5af 100644
--- a/environment.c
+++ b/environment.c
@@ -169,7 +169,7 @@ static void setup_git_env(void)
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir) {
 		if (!startup_info->have_repository)
-			die("BUG: setup_git_env called without repository");
+			BUG("setup_git_env called without repository");
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 	}
 	gitfile = read_gitfile(git_dir);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index afcca0d52..867704a64 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1539,4 +1539,10 @@ test_expect_success !MINGW '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+test_expect_failure '--local requires a repo' '
+	# we expect 128 to ensure that we do not simply
+	# fail to find anything and return code "1"
+	test_expect_code 128 nongit git config --local foo.bar
+'
+
 test_done
-- 
2.13.0.452.g0afc8e12b

