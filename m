Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3AC202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdJCNnc (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:43:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:59112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751315AbdJCNnc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:43:32 -0400
Received: (qmail 29420 invoked by uid 109); 3 Oct 2017 13:43:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:43:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7889 invoked by uid 111); 3 Oct 2017 13:43:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:43:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:43:29 -0400
Date:   Tue, 3 Oct 2017 09:43:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 05/12] t7508: use test_terminal for color output
Message-ID: <20171003134329.wtgpwrvdpf2s6ls7@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script tests the output of status with various formats
when color is enabled. It uses the "always" setting so that
the output is valid even though we capture it in a file.
Using test_terminal gives us a more realistic environment,
and prepares us for the behavior of "always" changing.

Arguably we are testing less than before, since "auto" is
already the default, and we can no longer tell if the config
is actually doing anything.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed that "status" does not have a "--color" option. I think it
might be worth adding one for completeness, though I still prefer the
test_terminal solution here.

 t/t7508-status.sh | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 43d19a9b22..a3d760e63a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -6,6 +6,7 @@
 test_description='git status'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'status -h in broken repository' '
 	git config --global advice.statusuoption false &&
@@ -667,7 +668,7 @@ test_expect_success 'setup unique colors' '
 
 '
 
-test_expect_success 'status with color.ui' '
+test_expect_success TTY 'status with color.ui' '
 	cat >expect <<\EOF &&
 On branch <GREEN>master<RESET>
 Your branch and '\''upstream'\'' have diverged,
@@ -694,14 +695,14 @@ Untracked files:
 	<BLUE>untracked<RESET>
 
 EOF
-	test_config color.ui always &&
-	git status | test_decode_color >output &&
+	test_config color.ui auto &&
+	test_terminal git status | test_decode_color >output &&
 	test_i18ncmp expect output
 '
 
-test_expect_success 'status with color.status' '
-	test_config color.status always &&
-	git status | test_decode_color >output &&
+test_expect_success TTY 'status with color.status' '
+	test_config color.status auto &&
+	test_terminal git status | test_decode_color >output &&
 	test_i18ncmp expect output
 '
 
@@ -714,19 +715,19 @@ cat >expect <<\EOF
 <BLUE>??<RESET> untracked
 EOF
 
-test_expect_success 'status -s with color.ui' '
+test_expect_success TTY 'status -s with color.ui' '
 
-	git config color.ui always &&
-	git status -s | test_decode_color >output &&
+	git config color.ui auto &&
+	test_terminal git status -s | test_decode_color >output &&
 	test_cmp expect output
 
 '
 
-test_expect_success 'status -s with color.status' '
+test_expect_success TTY 'status -s with color.status' '
 
 	git config --unset color.ui &&
-	git config color.status always &&
-	git status -s | test_decode_color >output &&
+	git config color.status auto &&
+	test_terminal git status -s | test_decode_color >output &&
 	test_cmp expect output
 
 '
@@ -741,9 +742,9 @@ cat >expect <<\EOF
 <BLUE>??<RESET> untracked
 EOF
 
-test_expect_success 'status -s -b with color.status' '
+test_expect_success TTY 'status -s -b with color.status' '
 
-	git status -s -b | test_decode_color >output &&
+	test_terminal git status -s -b | test_decode_color >output &&
 	test_i18ncmp expect output
 
 '
@@ -757,20 +758,20 @@ A  dir2/added
 ?? untracked
 EOF
 
-test_expect_success 'status --porcelain ignores color.ui' '
+test_expect_success TTY 'status --porcelain ignores color.ui' '
 
 	git config --unset color.status &&
-	git config color.ui always &&
-	git status --porcelain | test_decode_color >output &&
+	git config color.ui auto &&
+	test_terminal git status --porcelain | test_decode_color >output &&
 	test_cmp expect output
 
 '
 
-test_expect_success 'status --porcelain ignores color.status' '
+test_expect_success TTY 'status --porcelain ignores color.status' '
 
 	git config --unset color.ui &&
-	git config color.status always &&
-	git status --porcelain | test_decode_color >output &&
+	git config color.status auto &&
+	test_terminal git status --porcelain | test_decode_color >output &&
 	test_cmp expect output
 
 '
-- 
2.14.2.1079.gce6b466188

