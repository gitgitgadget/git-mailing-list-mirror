Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633BF1FAE2
	for <e@80x24.org>; Sat,  3 Mar 2018 05:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCCF6w (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 00:58:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:45368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751721AbeCCF6v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 00:58:51 -0500
Received: (qmail 8215 invoked by uid 109); 3 Mar 2018 05:58:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 05:58:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3471 invoked by uid 111); 3 Mar 2018 05:59:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 00:59:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 00:58:49 -0500
Date:   Sat, 3 Mar 2018 00:58:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: [PATCH 2/2] add--interactive: detect bogus diffFilter output
Message-ID: <20180303055849.GB15952@sigill.intra.peff.net>
References: <20180303055715.GH27689@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180303055715.GH27689@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's important that the diff-filter only filter the
individual lines, and that there remain a one-to-one mapping
between the input and output lines. Otherwise, things like
hunk-splitting will behave quite unexpectedly (e.g., you
think you are splitting at one point, but it has a different
effect in the text patch we apply).

We can't detect all problematic cases, but we can at least
catch the obvious case where we don't even have the correct
number of lines.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl  | 8 ++++++++
 t/t3701-add-interactive.sh | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 964c3a7542..ff02008abe 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -705,6 +705,14 @@ sub parse_diff {
 	}
 	my (@hunk) = { TEXT => [], DISPLAY => [], TYPE => 'header' };
 
+	if (@colored && @colored != @diff) {
+		print STDERR
+		  "fatal: mismatched output from interactive.diffFilter\n",
+		  "hint: Your filter must maintain a one-to-one correspondence\n",
+		  "hint: between its input and output lines.\n";
+		exit 1;
+	}
+
 	for (my $i = 0; $i < @diff; $i++) {
 		if ($diff[$i] =~ /^@@ /) {
 			push @hunk, { TEXT => [], DISPLAY => [],
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 64fe56c3d5..9bb17f91b2 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -404,6 +404,14 @@ test_expect_success TTY 'diffFilter filters diff' '
 	grep foo:.*content output
 '
 
+test_expect_success TTY 'detect bogus diffFilter output' '
+	git reset --hard &&
+
+	echo content >test &&
+	test_config interactive.diffFilter "echo too-short" &&
+	printf y | test_must_fail test_terminal git add -p
+'
+
 test_expect_success 'patch-mode via -i prompts for files' '
 	git reset --hard &&
 
-- 
2.16.2.708.g0b2ed7f536
