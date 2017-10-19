Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A248F202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbdJSU0d (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:26:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:58180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753239AbdJSU0d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:26:33 -0400
Received: (qmail 2790 invoked by uid 109); 19 Oct 2017 20:26:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 20:26:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11974 invoked by uid 111); 19 Oct 2017 20:26:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:26:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 16:26:31 -0400
Date:   Thu, 19 Oct 2017 16:26:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: [PATCH 3/5] t4015: test the output of "diff --color-moved -b"
Message-ID: <20171019202630.plnm6g4x3cuggxoj@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit fa5ba2c1dd (diff: fix infinite loop with
--color-moved --ignore-space-change, 2017-10-12) added a
test to make sure that "--color-moved -b" doesn't run
forever, but the test in question doesn't actually have any
moved lines in it.

Let's scrap that test and add a variant of the existing
"--color-moved -w" test, but this time we'll check that we
find the move with whitespace changes, but not arbitrary
whitespace additions.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4015-diff-whitespace.sh | 73 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 9 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 503c9bc7f3..1f54816c6b 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1399,6 +1399,70 @@ test_expect_success 'move detection ignoring whitespace ' '
 	test_cmp expected actual
 '
 
+test_expect_success 'move detection ignoring whitespace changes' '
+	git reset --hard &&
+	# Lines 6-8 have a space change, but 9 is new whitespace
+	q_to_tab <<-\EOF >lines.txt &&
+	longQline 6
+	longQline 7
+	longQline 8
+	long liQne 9
+	line 1
+	line 2
+	line 3
+	line 4
+	line 5
+	EOF
+
+	git diff HEAD --no-renames --color-moved --color |
+		grep -v "index" |
+		test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,9 +1,9 @@<RESET>
+	<GREEN>+<RESET><GREEN>long	line 6<RESET>
+	<GREEN>+<RESET><GREEN>long	line 7<RESET>
+	<GREEN>+<RESET><GREEN>long	line 8<RESET>
+	<GREEN>+<RESET><GREEN>long li	ne 9<RESET>
+	 line 1<RESET>
+	 line 2<RESET>
+	 line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	<RED>-long line 6<RESET>
+	<RED>-long line 7<RESET>
+	<RED>-long line 8<RESET>
+	<RED>-long line 9<RESET>
+	EOF
+	test_cmp expected actual &&
+
+	git diff HEAD --no-renames -b --color-moved --color |
+		grep -v "index" |
+		test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,9 +1,9 @@<RESET>
+	<CYAN>+<RESET><CYAN>long	line 6<RESET>
+	<CYAN>+<RESET><CYAN>long	line 7<RESET>
+	<CYAN>+<RESET><CYAN>long	line 8<RESET>
+	<GREEN>+<RESET><GREEN>long li	ne 9<RESET>
+	 line 1<RESET>
+	 line 2<RESET>
+	 line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	<MAGENTA>-long line 6<RESET>
+	<MAGENTA>-long line 7<RESET>
+	<MAGENTA>-long line 8<RESET>
+	<RED>-long line 9<RESET>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'clean up whitespace-test colors' '
 	git config --unset color.diff.oldMoved &&
 	git config --unset color.diff.newMoved
@@ -1549,13 +1613,4 @@ test_expect_success 'move detection with submodules' '
 	test_cmp expect decoded_actual
 '
 
-test_expect_success 'move detection with whitespace changes' '
-	test_when_finished "git reset --hard" &&
-	test_seq 10 >test &&
-	git add test &&
-	sed s/3/42/ <test >test.tmp &&
-	mv test.tmp test &&
-	git -c diff.colormoved diff --ignore-space-change -- test
-'
-
 test_done
-- 
2.15.0.rc1.560.g5f0609e481

