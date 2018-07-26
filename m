Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA801F597
	for <e@80x24.org>; Thu, 26 Jul 2018 10:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeGZLiu (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 07:38:50 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:22725 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbeGZLit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 07:38:49 -0400
Received: from lindisfarne.localdomain ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id idPhfHPXuoI6LidPnfsjbf; Thu, 26 Jul 2018 11:22:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532600556;
        bh=vWpGv1AZcPpTHyBiaSib4O4TwQtKuTgo4eAXgPj8rCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=aLsRCzfaLA82N5uvpa9dwxKV8MC/2OoE9decHdg3jzAyzs0prhmkXCAr0/+CGMiSc
         iyyyNsTD5z+x/ZQtqa53buJ00XcBGhMspSbV9F3nRX96qrGMIcMb7MhQRzNc8U2NtR
         X+4NR/ydmgZ6W6eCTyBv/3LJVRF9O1Z6wk4h2OO8=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=evINK-nbAAAA:8 a=AYlvAQ_5uU6KR0DxsCcA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=j6ol63fQbFhTYyq0:21 a=FjtkH5aydcWljJhY:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 3/4] add -p: allow line selection to be inverted
Date:   Thu, 26 Jul 2018 11:22:26 +0100
Message-Id: <20180726102227.997-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726102227.997-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726102227.997-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGlI7m9d7BBwuDJ1ohgCwMv4oRHbgCxoLpy+8GOq259tzfxDLXmes9lP70kj4jxu+hNmWFpj9tiadbm/oukirnoQD0p6cjx+wL6LyoqEABoAlse5p71P
 1k0t3Ixn25r98PYAQIcP4lB57ZL86vgNEIn/1VCpPFINQztulzsZ/sZoCKwfNGnPevgscEmACFlpyuYTTzxJl3L4U3jjIsaBHv3Fw3jEqFaebzmQDHu7ftVx
 xQXfKBDbKVYJeauaRMHYNC35q/cks5ndVg5Ms5u4gT0/H2G3GtAdG7oY38EE06pZ9EFH6wJoI78m5g89flXlC58mDyOK6Bb4uEFtsmabDAc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the list of lines to be selected begins with '-' select all the
lines except the ones listed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-add.txt  |  3 ++-
 git-add--interactive.perl  | 19 +++++++++++++++++++
 t/t3701-add-interactive.sh |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 965e192a09..01ff4d7d24 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -342,7 +342,8 @@ deletion labelled with a number and you will be prompted to enter which
 lines you wish to select. Individual line numbers should be separated by
 a space or comma, to specify a range of lines use a dash between
 them. If the upper bound of a range of lines is omitted it defaults to
-the last line.
+the last line. To invert the selection prefix it with "-" so "-3-5,8"
+will select everything except lines 3, 4, 5 and 8.
 +
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b7e3da0210..0b490cf1e9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1248,8 +1248,21 @@ sub parse_hunk_selection {
 	my ($hunk, $line) = @_;
 	my $lines = $hunk->{LABELS}->{LINES};
 	my $max_label = $#{$lines};
+	my $invert = undef;
 	my %selected;
 	my @fields = split(/[,\s]+/, $line);
+	if (my ($rest) = ($fields[0] =~ /^-(.*)/)) {
+		$invert = 1;
+		if ($rest ne '') {
+			$fields[0] = $rest;
+		} else {
+			shift @fields;
+			unless (@fields) {
+				error_msg __("no lines to invert\n");
+				return undef;
+			}
+		}
+	}
 	for my $f (@fields) {
 		if (my ($lo, $hi) = ($f =~ /^([0-9]+)-([0-9]*)$/)) {
 			if ($hi eq '') {
@@ -1269,6 +1282,12 @@ sub parse_hunk_selection {
 			return undef;
 		}
 	}
+	if ($invert) {
+		my %inverted;
+		undef @inverted{1..$max_label};
+		delete @inverted{keys(%selected)};
+		%selected = %inverted;
+	}
 	return process_hunk_selection($hunk, keys(%selected));
 }
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 1d917ad018..2fd456017f 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -457,7 +457,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l 4,1,3 |
+	printf "%s\n" l -6,2,5 |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&
-- 
2.18.0

