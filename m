Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694F5202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbdJCNjh (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:39:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:59050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751241AbdJCNjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:39:36 -0400
Received: (qmail 29080 invoked by uid 109); 3 Oct 2017 13:39:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:39:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7800 invoked by uid 111); 3 Oct 2017 13:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:39:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:39:34 -0400
Date:   Tue, 3 Oct 2017 09:39:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 01/12] test-terminal: set TERM=vt100
Message-ID: <20171003133934.oo2xkcxvweh36tcs@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The point of the test-terminal script is to simulate in the
test scripts an environment where output is going to a real
terminal.

But since test-lib.sh also sets TERM=dumb, the simulation
isn't very realistic. The color code will skip auto-coloring
for TERM=dumb, leading to us liberally sprinkling

  test_terminal env TERM=vt100 git ...

through the test suite to convince the tests to actually
generate colors. Let's set TERM for programs run under
test_terminal, which is one less thing for test-writers to
remember.

In most cases the callers can be simplified, but note there
is one interesting case in t4202. It uses test_terminal to
check the auto-enabling of --decorate, but the expected
output _doesn't_ contain colors (because TERM=dumb
suppresses them). Using TERM=vt100 is closer to what the
real world looks like; adjust the expected output to match.

Signed-off-by: Jeff King <peff@peff.net>
---
Not strictly necessary for this series, but after banging my shins on
this nuisance for the umpteenth time, I decided to finally do something
about it.

 t/t3203-branch-output.sh   | 2 +-
 t/t4202-log.sh             | 2 +-
 t/t6006-rev-list-format.sh | 3 +--
 t/t6300-for-each-ref.sh    | 3 +--
 t/t7004-tag.sh             | 2 +-
 t/t7006-pager.sh           | 6 +++---
 t/test-terminal.perl       | 1 +
 7 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d2aec0f38b..86286f263d 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -253,7 +253,7 @@ test_expect_success '%(color) omitted without tty' '
 '
 
 test_expect_success TTY '%(color) present with tty' '
-	test_terminal env TERM=vt100 git branch $color_args >actual.raw &&
+	test_terminal git branch $color_args >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect.color actual
 '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 36d120c969..8f155da7a5 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -750,7 +750,7 @@ test_expect_success 'log.decorate config parsing' '
 '
 
 test_expect_success TTY 'log output on a TTY' '
-	git log --oneline --decorate >expect.short &&
+	git log --color --oneline --decorate >expect.short &&
 
 	test_terminal git log --oneline >actual &&
 	test_cmp expect.short actual
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index b326d550f3..98be78b4a2 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -229,8 +229,7 @@ do
 	'
 
 	test_expect_success TTY "$desc respects --color=auto (stdout is tty)" '
-		test_terminal env TERM=vt100 \
-			git log --format=$color -1 --color=auto >actual &&
+		test_terminal git log --format=$color -1 --color=auto >actual &&
 		has_color actual
 	'
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2274a4b733..d6bffe6273 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -425,8 +425,7 @@ test_expect_success 'set up color tests' '
 '
 
 test_expect_success TTY '%(color) shows color with a tty' '
-	test_terminal env TERM=vt100 \
-		git for-each-ref --format="$color_format" >actual.raw &&
+	test_terminal git for-each-ref --format="$color_format" >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expected.color actual
 '
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b545c33f83..0a86f8ea39 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1907,7 +1907,7 @@ test_expect_success '%(color) omitted without tty' '
 '
 
 test_expect_success TTY '%(color) present with tty' '
-	test_terminal env TERM=vt100 git tag $color_args >actual.raw &&
+	test_terminal git tag $color_args >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect.color actual
 '
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 9128ec5acd..f0f1abd1c2 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -239,7 +239,7 @@ test_expect_success 'no color when stdout is a regular file' '
 test_expect_success TTY 'color when writing to a pager' '
 	rm -f paginated.out &&
 	test_config color.ui auto &&
-	test_terminal env TERM=vt100 git log &&
+	test_terminal git log &&
 	colorful paginated.out
 '
 
@@ -247,7 +247,7 @@ test_expect_success TTY 'colors are suppressed by color.pager' '
 	rm -f paginated.out &&
 	test_config color.ui auto &&
 	test_config color.pager false &&
-	test_terminal env TERM=vt100 git log &&
+	test_terminal git log &&
 	! colorful paginated.out
 '
 
@@ -266,7 +266,7 @@ test_expect_success 'color when writing to a file intended for a pager' '
 test_expect_success TTY 'colors are sent to pager for external commands' '
 	test_config alias.externallog "!git log" &&
 	test_config color.ui auto &&
-	test_terminal env TERM=vt100 git -p externallog &&
+	test_terminal git -p externallog &&
 	colorful paginated.out
 '
 
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 96b6a03e1c..46bf618479 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -80,6 +80,7 @@ sub copy_stdio {
 if ($#ARGV < 1) {
 	die "usage: test-terminal program args";
 }
+$ENV{TERM} = 'vt100';
 my $master_in = new IO::Pty;
 my $master_out = new IO::Pty;
 my $master_err = new IO::Pty;
-- 
2.14.2.1079.gce6b466188

