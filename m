Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F611F597
	for <e@80x24.org>; Thu, 26 Jul 2018 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeGZRX5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 13:23:57 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:9420 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbeGZRX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 13:23:56 -0400
Received: from lindisfarne.localdomain ([89.242.182.230])
        by smtp.talktalk.net with SMTP
        id iimGfHvLPoI6LiimWfsryw; Thu, 26 Jul 2018 17:06:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532621185;
        bh=nOfmsPhuoUJINegd46H+fc9EyOqR/7JB0oH/7XdGpWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=VmoSBQ5ugAlI1AjEifseYKsL5DKh+A5NQwCqeMw8E0uKpvFhtSpx7Xi3r314/udJ8
         9Usz9i2wfnvZUyPQ9n3jxxOubHv65CllFDc3PdPcLF1bf5cFytSu3E05evrSfqKmNB
         P2xrCHFjJuJN26nOCVZ61mkQGHAE/fUYK/u9hLTQ=
X-Originating-IP: [89.242.182.230]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=tQBg3IHG1C6KDs2Ec9TG5Q==:117
 a=tQBg3IHG1C6KDs2Ec9TG5Q==:17 a=evINK-nbAAAA:8 a=bEdQegGtLMKMq23hAgQA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=VKDqxjlPEKk1lGLg:21 a=fyGZWw98MZy55wag:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 4/4] add -p: optimize line selection for short hunks
Date:   Thu, 26 Jul 2018 16:58:54 +0100
Message-Id: <20180726155854.20832-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726155854.20832-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726155854.20832-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNA78nA9pRYX0oauqlNjzrC4XxHwpXTiBuZGcFr2pUHN7TYDGZPcHvjpJ3FSCAjaES8t0Pv+482K6KAt5X0K0bdtySR9kzNWg9IsA8LJ1MMdf1RJ2ymm
 hokkNVAJ52q9M+Ybxi/jOQ2NvvPX7XinBMzvHeiNTRrmy49ttKPRYK+EyTEp4HRGNfm2+6PG+2sRnsNgy7rZ3kZArxU/HpiCjW6Hm4S21P1PdirbzRF5tmcH
 XdHVAvp1r67e/3lPB4gWSe6rsKsOrbgCO4Ee27AWlJzff9jycWiDSW7EbhDz4rbkxkQTw9SE2aA3263nbk7neWPNVDgNT5GIIEoXLPYqXDY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are fewer than ten changes in a hunk then make spaces
optional when selecting individual lines. This means that for short
hunks one can just type 1-357 to stage lines 1, 2, 3, 5 & 7.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-add.txt  |  9 +++++----
 git-add--interactive.perl  | 26 ++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |  2 +-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 01ff4d7d24..f3c81dfb11 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -340,10 +340,11 @@ patch::
 If you press "l" then the hunk will be reprinted with each insertion or
 deletion labelled with a number and you will be prompted to enter which
 lines you wish to select. Individual line numbers should be separated by
-a space or comma, to specify a range of lines use a dash between
-them. If the upper bound of a range of lines is omitted it defaults to
-the last line. To invert the selection prefix it with "-" so "-3-5,8"
-will select everything except lines 3, 4, 5 and 8.
+a space or comma (these can be omitted if there are fewer than ten
+labelled lines), to specify a range of lines use a dash between them. If
+the upper bound of a range of lines is omitted it defaults to the last
+line. To invert the selection prefix it with "-" so "-3-5,8" will select
+everything except lines 3, 4, 5 and 8.
 +
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 63541d0f90..054c1168a7 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1243,6 +1243,29 @@ sub check_hunk_label {
 	return 1;
 }
 
+sub split_hunk_selection {
+	my @fields = @_;
+	my @ret;
+	for my $field (@fields) {
+		while ($field ne '') {
+			if ($field =~ /^[0-9]-$/) {
+				push @ret, $field;
+				last;
+			} elsif (my ($sel, $rest) =
+					($field =~ /^([0-9](?:-[0-9])?)(.*)/)) {
+				push @ret, $sel;
+				$field = $rest;
+			} else {
+				error_msg sprintf
+				    __("invalid hunk line '%s'\n"),
+				    substr($field, 0, 1);
+				return ();
+			}
+		}
+	}
+	return @ret;
+}
+
 sub parse_hunk_selection {
 	my ($hunk, $line) = @_;
 	my $lines = $hunk->{LABELS}->{LINES};
@@ -1262,6 +1285,9 @@ sub parse_hunk_selection {
 			}
 		}
 	}
+	if ($max_label < 10) {
+		@fields = split_hunk_selection(@fields) or return undef;
+	}
 	for my $f (@fields) {
 		if (my ($lo, $hi) = ($f =~ /^([0-9]+)-([0-9]*)$/)) {
 			if ($hi eq '') {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 2fd456017f..b2b808275c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -457,7 +457,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l -6,2,5 |
+	printf "%s\n" l -625 |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&
-- 
2.18.0

