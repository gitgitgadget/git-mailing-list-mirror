Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204361F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfAXM1b (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:27:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:47094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727871AbfAXM1a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:27:30 -0500
Received: (qmail 25564 invoked by uid 109); 24 Jan 2019 12:27:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:27:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27933 invoked by uid 111); 24 Jan 2019 12:27:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:27:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:27:29 -0500
Date:   Thu, 24 Jan 2019 07:27:29 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] t4006: resurrect commented-out tests
Message-ID: <20190124122728.GA11354@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124122603.GA10415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This set of tests was added by 4434e6ba6c (tests: check --[short]stat
output after chmod, 2012-05-01), and is primarily about the handling of
binary versus text files.

Later, 74faaa16f0 (Fix "git diff --stat" for interesting - but empty -
file changes, 2012-10-17) changed the stat output so that the empty text
file is mentioned rather than omitted. That commit just comments out
these tests. There's no discussion in the commit message, but the
original email[1] says:

  NOTE! This does break two of our tests, so we clearly did this on
  purpose, or at least tested for it. I just uncommented the subtests
  that this makes irrelevant, and changed the output of another one.

I don't think they're irrelevant, though. We should be testing this
"mode change only" case and making sure that it has the post-74faaa16f0
behavior. So this commit brings back those tests, with the current
expected output.

[1] https://public-inbox.org/git/CA+55aFz88GPJcfMSqiyY+u0Cdm48bEyrsTGxHVJbGsYsDg=Q5w@mail.gmail.com/

Signed-off-by: Jeff King <peff@peff.net>
---
Not actually relevant to the rest of the series; I just found this while
looking for existing --shortstat tests.

 t/t4006-diff-mode.sh | 55 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index a8e01eccd1..03489aff14 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -32,28 +32,37 @@ test_expect_success 'prepare binary file' '
 	git commit -m binbin
 '
 
-# test_expect_success '--stat output after text chmod' '
-# 	test_chmod -x rezrov &&
-# 	echo " 0 files changed" >expect &&
-# 	git diff HEAD --stat >actual &&
-#	test_i18ncmp expect actual
-# '
-#
-# test_expect_success '--shortstat output after text chmod' '
-# 	git diff HEAD --shortstat >actual &&
-# 	test_i18ncmp expect actual
-# '
-#
-# test_expect_success '--stat output after binary chmod' '
-# 	test_chmod +x binbin &&
-# 	echo " 0 files changed" >expect &&
-# 	git diff HEAD --stat >actual &&
-# 	test_i18ncmp expect actual
-# '
-#
-# test_expect_success '--shortstat output after binary chmod' '
-# 	git diff HEAD --shortstat >actual &&
-# 	test_i18ncmp expect actual
-# '
+test_expect_success '--stat output after text chmod' '
+	test_chmod -x rezrov &&
+	cat >expect <<-\EOF &&
+	 rezrov | 0
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	git diff HEAD --stat >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success '--shortstat output after text chmod' '
+	tail -n 1 <expect >expect.short &&
+	git diff HEAD --shortstat >actual &&
+	test_i18ncmp expect.short actual
+'
+
+test_expect_success '--stat output after binary chmod' '
+	test_chmod +x binbin &&
+	cat >expect <<-EOF &&
+	 binbin | Bin
+	 rezrov |   0
+	 2 files changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	git diff HEAD --stat >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success '--shortstat output after binary chmod' '
+	tail -n 1 <expect >expect.short &&
+	git diff HEAD --shortstat >actual &&
+	test_i18ncmp expect.short actual
+'
 
 test_done
-- 
2.20.1.842.g8986705066

