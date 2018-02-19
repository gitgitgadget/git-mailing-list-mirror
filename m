Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3801C1F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeBSL3d (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:29:33 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:25652 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeBSL3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:29:25 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njdCe9qQuoNnDnjdLeU69T; Mon, 19 Feb 2018 11:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519039764;
        bh=gqMVl2Opnw2NWeAOfOm9QWqcCeJ+g0RWJ72ETuIPGfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=LSFeDgDj5+yY0Kl/6rpRYorovSwaGQrZVjcJ3HGcw3vINSe6wDQIYhcYOQ33Bs2d4
         XxUAfdzhWEw9phILV8npj6XyooaiE6hi4NBYVVA8y9s/cOnPLZ2S0IbfwWNN5EGowy
         w0fFQq73PisXxrlnCFDOWN7S5PhbQ63kw0wbqg04=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=EYDacz-VJOdVlux0XgEA:9
 a=CrZenD-wUA8T-5r8:21 a=4bZHRSDtxEHSKISB:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 8/9] add -p: fix counting when splitting and coalescing
Date:   Mon, 19 Feb 2018 11:29:09 +0000
Message-Id: <20180219112910.24471-9-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219112910.24471-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGntb76DMRoFAubR+Z+KHc9x6WKiKggqClgHjTj9cAIl9IDm1oo6ahXdlrCgHXvy0aTlqKunhDw92wjOpzLg008Bpzt+W5AT0ibiajLJkVzQbb0DqPI9
 yDkwlazJrmHpFO4sYya8dRoJjPl0AsmgR6U+eS607MgTMLvhLEELbN7Ftx/qxSEgLWR9l0AA6Wu7hd6CaIT1oPpeJSQNLgpmb2yTidKM9oMWE8fJXJIzNaxU
 3z51crKSM6Mr4/YkFR9NehNhNC59kASnF5e1Ex16U7O/udHVDu1mrQPz6RVLCKhn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a file has no trailing new line at the end diff records this by
appending "\ No newline at end of file" below the last line of the
file. This line should not be counted in the hunk header. Fix the
splitting and coalescing code to count files without a trailing new line
properly and change one of the tests to test splitting without a
trailing new line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl  | 13 +++++++++----
 t/t3701-add-interactive.sh | 28 ++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0df0c2aa065af88e159f8e9a2febe12f4ef8ee75..3226c2c4f02d5f8679d77b8eede984fc727b422d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -793,6 +793,11 @@ sub split_hunk {
 		while (++$i < @$text) {
 			my $line = $text->[$i];
 			my $display = $display->[$i];
+			if ($line =~ /^\\/) {
+				push @{$this->{TEXT}}, $line;
+				push @{$this->{DISPLAY}}, $display;
+				next;
+			}
 			if ($line =~ /^ /) {
 				if ($this->{ADDDEL} &&
 				    !defined $next_hunk_start) {
@@ -887,8 +892,8 @@ sub merge_hunk {
 	$o_cnt = $n_cnt = 0;
 	for ($i = 1; $i < @{$prev->{TEXT}}; $i++) {
 		my $line = $prev->{TEXT}[$i];
-		if ($line =~ /^\+/) {
-			$n_cnt++;
+		if ($line =~ /^[+\\]/) {
+			$n_cnt++ if ($line =~ /^\+/);
 			push @line, $line;
 			next;
 		}
@@ -905,8 +910,8 @@ sub merge_hunk {
 
 	for ($i = 1; $i < @{$this->{TEXT}}; $i++) {
 		my $line = $this->{TEXT}[$i];
-		if ($line =~ /^\+/) {
-			$n_cnt++;
+		if ($line =~ /^[+\\]/) {
+			$n_cnt++ if ($line =~ /^\+/);
 			push @line, $line;
 			next;
 		}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index bbda771ba7e516aa37a204beffba7eeb0c85a2f4..0fb9c0e0f140e21ef7ad467c40b9211d29f53db6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -221,30 +221,46 @@ test_expect_success 'setup patch' '
 	 baseline
 	 content
 	+lastline
+	\ No newline at end of file
 	EOF
 '
 
-# Expected output, similar to the patch but w/ diff at the top
+# Expected output, diff is similar to the patch but w/ diff at the top
 test_expect_success 'setup expected' '
-	cat >expected <<-EOF
-	diff --git a/file b/file
+	echo diff --git a/file b/file >expected &&
+	cat patch >>expected &&
+	cat >expected-output <<-EOF
 	--- a/file
 	+++ b/file
 	@@ -1,2 +1,4 @@
 	+firstline
 	 baseline
 	 content
 	+lastline
+	\ No newline at end of file
+	@@ -1,2 +1,3 @@
+	+firstline
+	 baseline
+	 content
+	@@ -1,2 +2,3 @@
+	 baseline
+	 content
+	+lastline
+	\ No newline at end of file
 	EOF
 '
 
 # Test splitting the first patch, then adding both
-test_expect_success 'add first line works' '
+test_expect_success C_LOCALE_OUTPUT 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
-	(echo s; echo y; echo y) | git add -p file &&
+	printf "%s\n" s y y | git add -p file 2>error |
+		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
+		       -e "/^[-+@ \\\\]"/p  >output &&
+	test_must_be_empty error &&
 	git diff --cached | sed /^index/d >diff &&
-	test_cmp expected diff
+	test_cmp expected diff &&
+	test_cmp expected-output output
 '
 
 test_expect_success 'setup expected' '
-- 
2.16.1

