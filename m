Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665D51FAE3
	for <e@80x24.org>; Mon,  5 Mar 2018 10:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934443AbeCEK5I (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:57:08 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:4782 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934431AbeCEK4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:46 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnQesP08; Mon, 05 Mar 2018 10:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247405;
        bh=UGjXux/qAZLd6H0pB7Pdj6rJ4gDaLzNTqE7JQ7MiMi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Z4WJcKX39mtv6II6O7C3RAlBCckWz2qGaTSkJBx9OK0CHrgODYQ3ksOan5+HxcDsJ
         7vn55SiKvnR5V8bYmNtM00CBZUp0B3AdgZQ8Y2sWAv6PzITTYJSaFfuaUS6r/MDiCI
         pTqmOPci1SHH6o6t+2dtk7qJcIDeasmAv07B0Fs8=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=76_Ygab1W7R3FFaEkVEA:9
 a=-Kvfx_iHoI2PqTrv:21 a=0Yj9-hOKYjLvEu0h:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 8/9] add -p: fix counting when splitting and coalescing
Date:   Mon,  5 Mar 2018 10:56:29 +0000
Message-Id: <20180305105630.14407-9-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKzMatwMYEoLtPekFwJKSJ0E8T05KnRNakZttMVMqcdcwJ0cV5q29BsenrFMXVxDUjKBZP0lFbAOpt7NcCxzBYN4xG0BHutzDSdhg6AxVKudco2h+Uy7
 DzWK5a+mU7yoMvIoUj9v+44aPMg4ARTP4Wok5/UUA4gF+0WCRSFqi/fHHU5ASBpSpFPuAMm+cKVB1kU/UirKPZu4udA0Tr7nNar+JThFG3pGHRK3kJw7YH2l
 eVeVx5u/J4h5D9TRUw42q5jomHfhgNymdaV2trmkAqV/VTBFtaKe6L63TxiDRjZGuZOIxlJAzzk5Fcz/20fGVuAh4lWIyHMWoHQncoLjxhs=
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

Notes:
    changes since v4:
     - use a separate if clause to handle with "\ No newline at end of
       file" lines rather than crowbarring them into the "+" line
       handling.

 git-add--interactive.perl  | 11 +++++++++++
 t/t3701-add-interactive.sh | 31 +++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f80372d3ad..d1b550d4d8 100755
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
@@ -891,6 +896,9 @@ sub merge_hunk {
 			$n_cnt++;
 			push @line, $line;
 			next;
+		} elsif ($line =~ /^\\/) {
+			push @line, $line;
+			next;
 		}
 
 		last if ($o1_ofs <= $ofs);
@@ -909,6 +917,9 @@ sub merge_hunk {
 			$n_cnt++;
 			push @line, $line;
 			next;
+		} elsif ($line =~ /^\\/) {
+			push @line, $line;
+			next;
 		}
 		$ofs++;
 		$o_cnt++;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 4cc9517eda..a9a9478a29 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -237,31 +237,46 @@ test_expect_success 'setup patch' '
 	 baseline
 	 content
 	+lastline
+	\ No newline at end of file
 	EOF
 '
 
-# Expected output, similar to the patch but w/ diff at the top
+# Expected output, diff is similar to the patch but w/ diff at the top
 test_expect_success 'setup expected' '
-	cat >expected <<-\EOF
-	diff --git a/file b/file
-	index b6f2c08..61b9053 100755
+	echo diff --git a/file b/file >expected &&
+	cat patch |sed "/^index/s/ 100644/ 100755/" >>expected &&
+	cat >expected-output <<-\EOF
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
2.16.2

