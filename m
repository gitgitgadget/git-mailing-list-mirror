Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2492202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbdJSU0A (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:26:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:58172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754011AbdJSUZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:25:59 -0400
Received: (qmail 2769 invoked by uid 109); 19 Oct 2017 20:25:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 20:25:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11955 invoked by uid 111); 19 Oct 2017 20:26:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:26:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 16:25:57 -0400
Date:   Thu, 19 Oct 2017 16:25:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: [PATCH 2/5] t4015: check "negative" case for "-w --color-moved"
Message-ID: <20171019202556.hkz4r7hq4tlkjhvh@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We test that lines with whitespace changes are not found by
"--color-moved" by default, but are found if "-w" is added.
Let's add one more twist: a line that has non-whitespace
changes should not be marked as a pure move.

This is perhaps an obvious case for us to get right (and we
do), but as we add more whitespace tests, they will form a
pattern of "make sure this case is a move and this other
case is not".

Note that we have to add a line to our moved block, since
having a too-small block doesn't trigger the "moved"
heuristics.  And we also add a line of context to ensure
that there's more context lines than moved lines (so the
diff shows us moving the lines up, rather than moving the
context down).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4015-diff-whitespace.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 164b502405..503c9bc7f3 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1326,9 +1326,11 @@ test_expect_success 'set up whitespace tests' '
 	line 2
 	line 3
 	line 4
-	long line 5
+	line 5
 	long line 6
 	long line 7
+	long line 8
+	long line 9
 	EOF
 	git add lines.txt &&
 	git commit -m "add poetry" &&
@@ -1338,13 +1340,15 @@ test_expect_success 'set up whitespace tests' '
 
 test_expect_success 'move detection ignoring whitespace ' '
 	q_to_tab <<-\EOF >lines.txt &&
-	Qlong line 5
 	Qlong line 6
 	Qlong line 7
+	Qlong line 8
+	Qchanged long line 9
 	line 1
 	line 2
 	line 3
 	line 4
+	line 5
 	EOF
 	git diff HEAD --no-renames --color-moved --color |
 		grep -v "index" |
@@ -1353,17 +1357,20 @@ test_expect_success 'move detection ignoring whitespace ' '
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
-	<CYAN>@@ -1,7 +1,7 @@<RESET>
-	<GREEN>+<RESET>	<GREEN>long line 5<RESET>
+	<CYAN>@@ -1,9 +1,9 @@<RESET>
 	<GREEN>+<RESET>	<GREEN>long line 6<RESET>
 	<GREEN>+<RESET>	<GREEN>long line 7<RESET>
+	<GREEN>+<RESET>	<GREEN>long line 8<RESET>
+	<GREEN>+<RESET>	<GREEN>changed long line 9<RESET>
 	 line 1<RESET>
 	 line 2<RESET>
 	 line 3<RESET>
 	 line 4<RESET>
-	<RED>-long line 5<RESET>
+	 line 5<RESET>
 	<RED>-long line 6<RESET>
 	<RED>-long line 7<RESET>
+	<RED>-long line 8<RESET>
+	<RED>-long line 9<RESET>
 	EOF
 	test_cmp expected actual &&
 
@@ -1374,17 +1381,20 @@ test_expect_success 'move detection ignoring whitespace ' '
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
-	<CYAN>@@ -1,7 +1,7 @@<RESET>
-	<CYAN>+<RESET>	<CYAN>long line 5<RESET>
+	<CYAN>@@ -1,9 +1,9 @@<RESET>
 	<CYAN>+<RESET>	<CYAN>long line 6<RESET>
 	<CYAN>+<RESET>	<CYAN>long line 7<RESET>
+	<CYAN>+<RESET>	<CYAN>long line 8<RESET>
+	<GREEN>+<RESET>	<GREEN>changed long line 9<RESET>
 	 line 1<RESET>
 	 line 2<RESET>
 	 line 3<RESET>
 	 line 4<RESET>
-	<MAGENTA>-long line 5<RESET>
+	 line 5<RESET>
 	<MAGENTA>-long line 6<RESET>
 	<MAGENTA>-long line 7<RESET>
+	<MAGENTA>-long line 8<RESET>
+	<RED>-long line 9<RESET>
 	EOF
 	test_cmp expected actual
 '
-- 
2.15.0.rc1.560.g5f0609e481

