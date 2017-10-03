Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CFF6202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbdJCNly (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:41:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:59078 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751238AbdJCNlx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:41:53 -0400
Received: (qmail 29259 invoked by uid 109); 3 Oct 2017 13:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:41:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7841 invoked by uid 111); 3 Oct 2017 13:41:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:41:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:41:51 -0400
Date:   Tue, 3 Oct 2017 09:41:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 03/12] t4015: use --color with --color-moved
Message-ID: <20171003134151.znylpiijmlmk2akx@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests for --color-moved write their output to a file,
but doing so suppresses color output under "auto". Right now
this is solved by running the whole script under
"color.diff=always". In preparation for the behavior of
"always" changing, let's explicitly enable color.

Signed-off-by: Jeff King <peff@peff.net>
---
I kind of think `--color-moved` should imply `--color`, as
`--color-words` seems to. But that seemed like a potential rabbit-hole,
and this series is already contentious enough.

 t/t4015-diff-whitespace.sh | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b9df886e37..3bca958863 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -802,7 +802,6 @@ test_expect_success 'combined diff with autocrlf conversion' '
 # Start testing the colored format for whitespace checks
 
 test_expect_success 'setup diff colors' '
-	git config color.diff always &&
 	git config color.diff.plain normal &&
 	git config color.diff.meta bold &&
 	git config color.diff.frag cyan &&
@@ -986,7 +985,7 @@ test_expect_success 'detect moved code, complete file' '
 	git mv test.c main.c &&
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
-	git diff HEAD --color-moved=zebra --no-renames | test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>new file mode 100644<RESET>
@@ -1087,7 +1086,7 @@ test_expect_success 'detect malicious moved code, inside file' '
 			bar();
 		}
 	EOF
-	git diff HEAD --no-renames --color-moved=zebra| test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved=zebra --color | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>index 27a619c..7cf9336 100644<RESET>
@@ -1136,7 +1135,7 @@ test_expect_success 'plain moved code, inside file' '
 	test_config color.diff.oldMovedAlternative "blue" &&
 	test_config color.diff.newMovedAlternative "yellow" &&
 	# needs previous test as setup
-	git diff HEAD --no-renames --color-moved=plain| test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved=plain --color | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>index 27a619c..7cf9336 100644<RESET>
@@ -1227,7 +1226,7 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
-	git diff HEAD --no-renames --color-moved=dimmed_zebra |
+	git diff HEAD --no-renames --color-moved=dimmed_zebra --color |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1271,7 +1270,7 @@ test_expect_success 'cmd option assumes configured colored-moved' '
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
 	test_config diff.colorMoved zebra &&
-	git diff HEAD --no-renames --color-moved |
+	git diff HEAD --no-renames --color-moved --color |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1343,7 +1342,7 @@ line 4
 EOF
 	test_config color.diff.oldMoved "magenta" &&
 	test_config color.diff.newMoved "cyan" &&
-	git diff HEAD --no-renames --color-moved |
+	git diff HEAD --no-renames --color-moved --color |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1364,7 +1363,7 @@ EOF
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -w --color-moved |
+	git diff HEAD --no-renames -w --color-moved --color |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1403,7 +1402,7 @@ test_expect_success '--color-moved block at end of diff output respects MIN_ALNU
 	irrelevant_line
 	EOF
 
-	git diff HEAD --color-moved=zebra --no-renames |
+	git diff HEAD --color-moved=zebra --color --no-renames |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat >expected <<-\EOF &&
@@ -1442,7 +1441,7 @@ test_expect_success '--color-moved respects MIN_ALNUM_COUNT' '
 	nineteen chars 456789
 	EOF
 
-	git diff HEAD --color-moved=zebra --no-renames |
+	git diff HEAD --color-moved=zebra --color --no-renames |
 		grep -v "index" |
 		test_decode_color >actual &&
 	cat >expected <<-\EOF &&
@@ -1485,7 +1484,7 @@ test_expect_success '--color-moved treats adjacent blocks as separate for MIN_AL
 	7charsA
 	EOF
 
-	git diff HEAD --color-moved=zebra --no-renames | grep -v "index" | test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames | grep -v "index" | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
@@ -1519,7 +1518,7 @@ test_expect_success 'move detection with submodules' '
 	echo foul >bananas/recipe &&
 	echo ripe >fruit.t &&
 
-	git diff --submodule=diff --color-moved >actual &&
+	git diff --submodule=diff --color-moved --color >actual &&
 
 	# no move detection as the moved line is across repository boundaries.
 	test_decode_color <actual >decoded_actual &&
@@ -1527,7 +1526,7 @@ test_expect_success 'move detection with submodules' '
 	! grep BRED decoded_actual &&
 
 	# nor did we mess with it another way
-	git diff --submodule=diff | test_decode_color >expect &&
+	git diff --submodule=diff --color | test_decode_color >expect &&
 	test_cmp expect decoded_actual
 '
 
-- 
2.14.2.1079.gce6b466188

