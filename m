Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43971F404
	for <e@80x24.org>; Sat,  3 Mar 2018 05:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeCCF6M (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 00:58:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:45356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750992AbeCCF6M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 00:58:12 -0500
Received: (qmail 8172 invoked by uid 109); 3 Mar 2018 05:58:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 05:58:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3452 invoked by uid 111); 3 Mar 2018 05:59:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 00:59:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 00:58:10 -0500
Date:   Sat, 3 Mar 2018 00:58:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: [PATCH 1/2] t3701: add a test for interactive.diffFilter
Message-ID: <20180303055809.GA15952@sigill.intra.peff.net>
References: <20180303055715.GH27689@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180303055715.GH27689@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This feature was added in 01143847db (add--interactive:
allow custom diff highlighting programs, 2016-02-27) but
never tested. Let's add a basic test.

Note that we only apply the filter when color is enabled,
so we have to use test_terminal. This is an open limitation
explicitly mentioned in the original commit. So take this
commit as testing the status quo, and not making a statement
on whether we'd want to enhance that in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3701-add-interactive.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 058698df6a..64fe56c3d5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -392,6 +392,18 @@ test_expect_success TTY 'diffs can be colorized' '
 	grep "$(printf "\\033")" output
 '
 
+test_expect_success TTY 'diffFilter filters diff' '
+	git reset --hard &&
+
+	echo content >test &&
+	test_config interactive.diffFilter "sed s/^/foo:/" &&
+	printf y | test_terminal git add -p >output 2>&1 &&
+
+	# avoid depending on the exact coloring or content of the prompts,
+	# and just make sure we saw our diff prefixed
+	grep foo:.*content output
+'
+
 test_expect_success 'patch-mode via -i prompts for files' '
 	git reset --hard &&
 
-- 
2.16.2.708.g0b2ed7f536

