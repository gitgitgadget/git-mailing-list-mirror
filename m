Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26EB01F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeB0LEl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:04:41 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:2919 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbeB0LE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:04:28 -0500
Received: from lindisfarne.localdomain ([89.242.176.20])
        by smtp.talktalk.net with SMTP
        id qd3QeQ4WdoNnDqd3beXd1A; Tue, 27 Feb 2018 11:04:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519729467;
        bh=DN1NTrb34o7/6rAUagY4RuyDIRgSWSJyD4msaeua2nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=f8UK0Cp2axwEhtGqxeh9Y+3JfzkAcKQvh/idnCjEzwlA9Qsro/ZRfE1ULbtbQWgl8
         OoS7aBHI4eZIaBGPEu5eluRQCGwKl0ZkVyl07UIwyczQMwuMukcee/QnrJn8qBB/aZ
         U+cvpXRR3A8GhvpFb/Z8wHAQOfztr/zP0KWeqFFQ=
X-Originating-IP: [89.242.176.20]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=BZXIa/HMvEOrkAULb1ciZg==:117
 a=BZXIa/HMvEOrkAULb1ciZg==:17 a=evINK-nbAAAA:8 a=QyFuo6YoAJgrWRj-plYA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=w8z8zXR_VpDmHua2:21 a=ebkmgI51Gd_NgFZ5:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 8/9] add -p: fix counting when splitting and coalescing
Date:   Tue, 27 Feb 2018 11:04:03 +0000
Message-Id: <20180227110404.16816-9-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180227110404.16816-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfMI425tsV7vc2Pxpyoin0CULZkuRa4i8+425+qTzz/Pz5Vp4sFBMttu+03bkGdXt9v7NBk1vgnJU9yvX04Hdtm/gBuJ8d6+21G+lAkJ2qJuNVeXPF27e
 V5hv8k06NxdLc+9Yc5FGKUovvLhRQke8ECtoMHv8Sof6SuozI0ys5PuvpY9tbFLpPXuz4qjmW1QiuYOKuIRJ6976t1nNfyMjpUMBZQYXzkbqzaKsKtlWaFNJ
 QWSqOsgEUr05YVjWq22/rM4OtfEQiGRAU79LMOlPsh/4cfZkQJ7wb+8r0B+rqyVLsvJxBxKcmj3kPb8vz73n1KYfoQ8djxAFxwfMGPmLgIQ=
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
 t/t3701-add-interactive.sh | 31 +++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0df0c2aa06..3226c2c4f0 100755
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
index 83f4c8d6ea..05540ee9ef 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -234,31 +234,46 @@ test_expect_success 'setup patch' '
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
-	index b6f2c08..61b9053 100755
+	echo diff --git a/file b/file >expected &&
+	cat patch |sed "/^index/s/ 100644/ 100755/" >>expected &&
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
-	git diff --cached > diff &&
-	diff_cmp expected diff
+	printf "%s\n" s y y | git add -p file 2>error |
+		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
+		       -e "/^[-+@ \\\\]"/p  >output &&
+	test_must_be_empty error &&
+	git diff --cached >diff &&
+	diff_cmp expected diff &&
+	test_cmp expected-output output
 '
 
 test_expect_success 'setup expected' '
-- 
2.16.1

