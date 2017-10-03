Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39646202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdJCNmS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:42:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:59092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751238AbdJCNmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:42:17 -0400
Received: (qmail 29332 invoked by uid 109); 3 Oct 2017 13:42:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:42:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7861 invoked by uid 111); 3 Oct 2017 13:42:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:42:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:42:15 -0400
Date:   Tue, 3 Oct 2017 09:42:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 04/12] t3701: use test-terminal to collect color output
Message-ID: <20171003134215.oce7bdemb7cjyg22@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When testing whether "add -p" can generate colors, we set
color.ui to "always". This isn't a very good test, as in the
real-world a user typically has "auto" coupled with stdout
going to a terminal (and it's plausible that this could mask
a real bug in add--interactive if we depend on plumbing's
isatty check).

Let's switch to test_terminal, which gives us a more
realistic environment. This also prepare us for future
changes to the "always" color option.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3701-add-interactive.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 2f3e7cea64..39d0130f88 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -2,6 +2,7 @@
 
 test_description='add -i basic tests'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 if ! test_have_prereq PERL
 then
@@ -380,14 +381,11 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	test_cmp expected diff
 '
 
-test_expect_success 'diffs can be colorized' '
+test_expect_success TTY 'diffs can be colorized' '
 	git reset --hard &&
 
-	# force color even though the test script has no terminal
-	test_config color.ui always &&
-
 	echo content >test &&
-	printf y | git add -p >output 2>&1 &&
+	printf y | test_terminal git add -p >output 2>&1 &&
 
 	# We do not want to depend on the exact coloring scheme
 	# git uses for diffs, so just check that we saw some kind of color.
-- 
2.14.2.1079.gce6b466188

