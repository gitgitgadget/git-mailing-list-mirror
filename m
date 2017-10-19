Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1155202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753698AbdJSUYG (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:24:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:58156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752656AbdJSUYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:24:05 -0400
Received: (qmail 2674 invoked by uid 109); 19 Oct 2017 20:24:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 20:24:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11935 invoked by uid 111); 19 Oct 2017 20:24:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:24:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 16:24:03 -0400
Date:   Thu, 19 Oct 2017 16:24:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: [PATCH 1/5] t4015: refactor --color-moved whitespace test
Message-ID: <20171019202403.7srcpos5xlsvmqrl@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for testing several different whitespace
options, let's split out the setup and cleanup steps of the
whitespace test.

While we're here, let's also switch to using "<<-" to indent
our here-documents properly, and use q_to_tab to more
explicitly mark where we expect whitespace to appear.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4015-diff-whitespace.sh | 49 +++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 87083f728f..164b502405 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1318,30 +1318,34 @@ test_expect_success 'no effect from --color-moved with --word-diff' '
 	test_cmp expect actual
 '
 
-test_expect_success 'move detection ignoring whitespace ' '
+test_expect_success 'set up whitespace tests' '
 	git reset --hard &&
-	cat <<\EOF >lines.txt &&
-line 1
-line 2
-line 3
-line 4
-long line 5
-long line 6
-long line 7
-EOF
-	git add lines.txt &&
-	git commit -m "add poetry" &&
-	cat <<\EOF >lines.txt &&
+	# Note that these lines have no leading or trailing whitespace.
+	cat <<-\EOF >lines.txt &&
+	line 1
+	line 2
+	line 3
+	line 4
 	long line 5
 	long line 6
 	long line 7
-line 1
-line 2
-line 3
-line 4
-EOF
-	test_config color.diff.oldMoved "magenta" &&
-	test_config color.diff.newMoved "cyan" &&
+	EOF
+	git add lines.txt &&
+	git commit -m "add poetry" &&
+	git config color.diff.oldMoved "magenta" &&
+	git config color.diff.newMoved "cyan"
+'
+
+test_expect_success 'move detection ignoring whitespace ' '
+	q_to_tab <<-\EOF >lines.txt &&
+	Qlong line 5
+	Qlong line 6
+	Qlong line 7
+	line 1
+	line 2
+	line 3
+	line 4
+	EOF
 	git diff HEAD --no-renames --color-moved --color |
 		grep -v "index" |
 		test_decode_color >actual &&
@@ -1385,6 +1389,11 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'clean up whitespace-test colors' '
+	git config --unset color.diff.oldMoved &&
+	git config --unset color.diff.newMoved
+'
+
 test_expect_success '--color-moved block at end of diff output respects MIN_ALNUM_COUNT' '
 	git reset --hard &&
 	>bar &&
-- 
2.15.0.rc1.560.g5f0609e481

