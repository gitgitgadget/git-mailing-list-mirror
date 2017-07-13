Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F91202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 14:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdGMO6o convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 13 Jul 2017 10:58:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:39092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751201AbdGMO6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 10:58:43 -0400
Received: (qmail 23975 invoked by uid 109); 13 Jul 2017 14:58:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 14:58:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32075 invoked by uid 111); 13 Jul 2017 14:58:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 10:58:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 10:58:41 -0400
Date:   Thu, 13 Jul 2017 10:58:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/15] t: use test_decode_color rather than literal ANSI codes
Message-ID: <20170713145841.4win5tbx4efwjsa2@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we put literal ANSI terminal codes into our test
scripts, it makes diffs on those scripts hard to read (the
colors may be indistinguishable from diff coloring, or in
the case of a reset, may not be visible at all).

Some scripts get around this by including human-readable
names and converting to literal codes with a git-config
hack. This makes the actual code diffs look OK, but test_cmp
output suffers from the same problem.

Let's use test_decode_color instead, which turns the codes
into obvious text tags.

Signed-off-by: Jeff King <peff@peff.net>
---
I really only need t6300 and t6006 converted to build on for the rest of
the series. But t4207 was easy to do. t4026 still uses raw codes, but
converting it would be a pretty big job, so I punted.

 t/t4207-log-decoration-colors.sh | 22 +++++++++------------
 t/t6006-rev-list-format.sh       | 42 +++++++++++++++++++++++++---------------
 t/t6300-for-each-ref.sh          | 18 ++++++++---------
 t/test-lib-functions.sh          |  1 +
 4 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index b972296f0..60f040cab 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -7,11 +7,6 @@ test_description='Test for "git log --decorate" colors'
 
 . ./test-lib.sh
 
-get_color ()
-{
-	git config --get-color no.such.slot "$1"
-}
-
 test_expect_success setup '
 	git config diff.color.commit yellow &&
 	git config color.decorate.branch green &&
@@ -20,14 +15,14 @@ test_expect_success setup '
 	git config color.decorate.stash magenta &&
 	git config color.decorate.HEAD cyan &&
 
-	c_reset=$(get_color reset) &&
+	c_reset="<RESET>" &&
 
-	c_commit=$(get_color yellow) &&
-	c_branch=$(get_color green) &&
-	c_remoteBranch=$(get_color red) &&
-	c_tag=$(get_color "reverse bold yellow") &&
-	c_stash=$(get_color magenta) &&
-	c_HEAD=$(get_color cyan) &&
+	c_commit="<YELLOW>" &&
+	c_branch="<GREEN>" &&
+	c_remoteBranch="<RED>" &&
+	c_tag="<BOLD;REVERSE;YELLOW>" &&
+	c_stash="<MAGENTA>" &&
+	c_HEAD="<CYAN>" &&
 
 	test_commit A &&
 	git clone . other &&
@@ -59,7 +54,8 @@ EOF
 # to this test since it does not contain any decoration, hence --first-parent
 test_expect_success 'Commit Decorations Colored Correctly' '
 	git log --first-parent --abbrev=10 --all --decorate --oneline --color=always |
-	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" >out &&
+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
+	test_decode_color >out &&
 	test_cmp expected out
 '
 
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a1dcdb81d..647218b4e 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -61,8 +61,9 @@ test_format () {
 # Feed to --format to provide predictable colored sequences.
 AUTO_COLOR='%C(auto,red)foo%C(auto,reset)'
 has_color () {
-	printf '\033[31mfoo\033[m\n' >expect &&
-	test_cmp expect "$1"
+	test_decode_color <"$1" >decoded &&
+	echo "<RED>foo<RESET>" >expect &&
+	test_cmp expect decoded
 }
 
 has_no_color () {
@@ -170,19 +171,27 @@ $added
 
 EOF
 
-test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<EOF
-commit $head2
-[31mfoo[32mbar[34mbaz[mxyzzy
-commit $head1
-[31mfoo[32mbar[34mbaz[mxyzzy
-EOF
+test_expect_success 'basic colors' '
+	cat >expect <<-EOF &&
+	commit $head2
+	<RED>foo<GREEN>bar<BLUE>baz<RESET>xyzzy
+	EOF
+	format="%Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy" &&
+	git rev-list --format="$format" -1 master >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
 
-test_format advanced-colors '%C(red yellow bold)foo%C(reset)' <<EOF
-commit $head2
-[1;31;43mfoo[m
-commit $head1
-[1;31;43mfoo[m
-EOF
+test_expect_success 'advanced colors' '
+	cat >expect <<-EOF &&
+	commit $head2
+	<BOLD;RED;BYELLOW>foo<RESET>
+	EOF
+	format="%C(red yellow bold)foo%C(reset)" &&
+	git rev-list --format="$format" -1 master >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success '%C(auto,...) does not enable color by default' '
 	git log --format=$AUTO_COLOR -1 >actual &&
@@ -224,8 +233,9 @@ test_expect_success '%C(auto,...) respects --color=auto (stdout not tty)' '
 '
 
 test_expect_success '%C(auto) respects --color' '
-	git log --color --format="%C(auto)%H" -1 >actual &&
-	printf "\\033[33m%s\\033[m\\n" $(git rev-parse HEAD) >expect &&
+	git log --color --format="%C(auto)%H" -1 >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	echo "<YELLOW>$(git rev-parse HEAD)<RESET>" >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 834a9ed16..7872a2f54 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -412,20 +412,18 @@ test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
 
-get_color ()
-{
-	git config --get-color no.such.slot "$1"
-}
-
 cat >expected <<EOF
-$(git rev-parse --short refs/heads/master) $(get_color green)master$(get_color reset)
-$(git rev-parse --short refs/remotes/origin/master) $(get_color green)origin/master$(get_color reset)
-$(git rev-parse --short refs/tags/testtag) $(get_color green)testtag$(get_color reset)
-$(git rev-parse --short refs/tags/two) $(get_color green)two$(get_color reset)
+$(git rev-parse --short refs/heads/master) <GREEN>master<RESET>
+$(git rev-parse --short refs/remotes/origin/master) <GREEN>origin/master<RESET>
+$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>
+$(git rev-parse --short refs/tags/two) <GREEN>two<RESET>
 EOF
 
 test_expect_success 'Check %(color:...) ' '
-	git for-each-ref --format="%(objectname:short) %(color:green)%(refname:short)" >actual &&
+	git for-each-ref \
+		--format="%(objectname:short) %(color:green)%(refname:short)" \
+		>actual.raw &&
+	test_decode_color <actual.raw >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index db622c355..e09e93b38 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -42,6 +42,7 @@ test_decode_color () {
 		function name(n) {
 			if (n == 0) return "RESET";
 			if (n == 1) return "BOLD";
+			if (n == 7) return "REVERSE";
 			if (n == 30) return "BLACK";
 			if (n == 31) return "RED";
 			if (n == 32) return "GREEN";
-- 
2.13.2.1157.gc6daca446

