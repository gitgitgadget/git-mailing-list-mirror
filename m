Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E2820437
	for <e@80x24.org>; Fri, 13 Oct 2017 17:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbdJMRXo (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 13:23:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751057AbdJMRXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 13:23:44 -0400
Received: (qmail 31371 invoked by uid 109); 13 Oct 2017 17:23:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 17:23:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27254 invoked by uid 111); 13 Oct 2017 17:23:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:23:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 13:23:41 -0400
Date:   Fri, 13 Oct 2017 13:23:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 2/4] Revert "t6006: drop "always" color config tests"
Message-ID: <20171013172341.kdxckcl4mum5wsoq@sigill.intra.peff.net>
References: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit c5bdfe677cfab5b2e87771c35565d44d3198efda.

That commit was done primarily to prepare for the weakening
of "always" in 6be4595edb (color: make "always" the same as
"auto" in config, 2017-10-03). But since we've now reverted
6be4595edb, there's no need for us to remove "-c
color.ui=always" from the tests. And in fact it's a good
idea to restore these tests, to make sure that "always"
continues to work.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6006-rev-list-format.sh | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 25a9c65dc5..98be78b4a2 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -208,11 +208,26 @@ do
 		has_no_color actual
 	'
 
+	test_expect_success "$desc enables colors for color.diff" '
+		git -c color.diff=always log --format=$color -1 >actual &&
+		has_color actual
+	'
+
+	test_expect_success "$desc enables colors for color.ui" '
+		git -c color.ui=always log --format=$color -1 >actual &&
+		has_color actual
+	'
+
 	test_expect_success "$desc respects --color" '
 		git log --format=$color -1 --color >actual &&
 		has_color actual
 	'
 
+	test_expect_success "$desc respects --no-color" '
+		git -c color.ui=always log --format=$color -1 --no-color >actual &&
+		has_no_color actual
+	'
+
 	test_expect_success TTY "$desc respects --color=auto (stdout is tty)" '
 		test_terminal git log --format=$color -1 --color=auto >actual &&
 		has_color actual
@@ -225,11 +240,6 @@ do
 			has_no_color actual
 		)
 	'
-
-	test_expect_success TTY "$desc respects --no-color" '
-		test_terminal git log --format=$color -1 --no-color >actual &&
-		has_no_color actual
-	'
 done
 
 test_expect_success '%C(always,...) enables color even without tty' '
-- 
2.15.0.rc1.395.ga4290b5804

