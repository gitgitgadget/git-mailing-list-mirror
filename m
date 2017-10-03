Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C79202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdJCNoa (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:44:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:59140 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751296AbdJCNoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:44:30 -0400
Received: (qmail 29530 invoked by uid 109); 3 Oct 2017 13:44:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:44:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7929 invoked by uid 111); 3 Oct 2017 13:44:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:44:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:44:27 -0400
Date:   Tue, 3 Oct 2017 09:44:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 07/12] t6006: drop "always" color config tests
Message-ID: <20171003134427.n7iy47yse5rydnfm@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We test the %C() format placeholders with a variety of
color-inducing options, including "--color" and
"-c color.ui=always". In preparation for the behavior of
"always" changing, we need to do something with those
"always" tests.

We can drop ones that expect "always" to turn on color even
to a file, as that will become a synonym for "auto", which
is already tested.

For the "--no-color" test, we need to make sure that color
would otherwise be shown. To do this, we can use
test_terminal, which enables colors in the default setup.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6006-rev-list-format.sh | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 98be78b4a2..25a9c65dc5 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -208,26 +208,11 @@ do
 		has_no_color actual
 	'
 
-	test_expect_success "$desc enables colors for color.diff" '
-		git -c color.diff=always log --format=$color -1 >actual &&
-		has_color actual
-	'
-
-	test_expect_success "$desc enables colors for color.ui" '
-		git -c color.ui=always log --format=$color -1 >actual &&
-		has_color actual
-	'
-
 	test_expect_success "$desc respects --color" '
 		git log --format=$color -1 --color >actual &&
 		has_color actual
 	'
 
-	test_expect_success "$desc respects --no-color" '
-		git -c color.ui=always log --format=$color -1 --no-color >actual &&
-		has_no_color actual
-	'
-
 	test_expect_success TTY "$desc respects --color=auto (stdout is tty)" '
 		test_terminal git log --format=$color -1 --color=auto >actual &&
 		has_color actual
@@ -240,6 +225,11 @@ do
 			has_no_color actual
 		)
 	'
+
+	test_expect_success TTY "$desc respects --no-color" '
+		test_terminal git log --format=$color -1 --no-color >actual &&
+		has_no_color actual
+	'
 done
 
 test_expect_success '%C(always,...) enables color even without tty' '
-- 
2.14.2.1079.gce6b466188

