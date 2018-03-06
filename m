Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574DB1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbeCFKSH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:18:07 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:2529 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeCFKSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:18:01 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id t9fNelwjTlYtpt9fTexEqJ; Tue, 06 Mar 2018 10:18:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520331480;
        bh=rsb0tX6yo+3HGEQPHhFswLB/qI0XdA4sTBECuL1+mF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=jHgxVY5B71/1K/6p3hBUeaRwCMme5dXFf9lnguDqE8HH/0y/aTzBXfIkauEpusMSw
         XCHGKw6xZEefZRoEfUWVRYhIOS0jrPYI9VJYJHRzHP+/UNPOeXRmgfgA3giAd/IFGU
         TwI/8A6MjHVm2TicXQNuNP447FQ44FHZyaN5FL1Y=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JZeSU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=7PuQ9dypriAC8fFJya0A:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=jl7oZPXPbMuOGlJn:21 a=hKPZ34yjrIDJDwPR:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/3] add -p: optimize line selection for short hunks
Date:   Tue,  6 Mar 2018 10:17:50 +0000
Message-Id: <20180306101750.18794-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306101750.18794-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBsxIT5P2V301LDp5ZRvFA47QaHyQt9xcG5XP8LbqX3I1+m749gP7+WzVVMOhYE0tlMPN1pGNtOVVWSlPVIaYKNFi92fFQOBvzez8Hrhm4+RzZj/JkbX
 bt+c4+wH5eFVzYL+20VYFm3d0j9v9/kDynJOOrt88Y904m4UnergQfet9eyeGG4xQcrs9ADPIc8HEDEuxjOoAoYg74hiO9eQVsksXGd1cHsFfieiZO99Jc+S
 IWqfHEHeJWPTqyBJ1+hNAC/DLvbeOTzAaknPNp2NnLTVLTrc86T/h11JGm7FlWc5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are fewer than ten changes in a hunk then make spaces
optional when selecting individual lines. This means that for short
hunks one can just type -357 to stage lines 1, 2, 3, 5 & 7.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-add.txt  |  3 ++-
 git-add--interactive.perl  | 30 ++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |  2 +-
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 0e2c11e97b..d52acfc722 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -340,7 +340,8 @@ patch::
 If you press "l" then the hunk will be reprinted with each insertion
 or deletion labelled with a number and you will be prompted to enter
 which lines you wish to select. Individual line numbers should be
-separated by a space or comma, to specify a range of lines use a dash
+separated by a space or comma (these can be omitted if there are fewer
+than ten labelled lines), to specify a range of lines use a dash
 between them. To invert the selection prefix it with "\^" so "^3-5,8"
 will select everything except lines 3, 4, 5 and 8.
 +
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 6fa3d0a87c..9a6bcd5085 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1082,6 +1082,33 @@ sub check_hunk_label {
 	return 1;
 }
 
+sub split_hunk_selection {
+	local $_;
+	my @fields = @_;
+	my @ret;
+	for (@fields) {
+		if (/^(-[0-9])(.*)/) {
+			push @ret, $1;
+			$_ = $2;
+		}
+		while ($_ ne '') {
+			if (/^[0-9]-$/) {
+				push @ret, $_;
+				last;
+			} elsif (/^([0-9](?:-[0-9])?)(.*)/) {
+				push @ret, $1;
+				$_ = $2;
+			} else {
+				error_msg sprintf
+				    __("invalid hunk line '%s'\n"),
+				    substr($_, 0, 1);
+				return ();
+			}
+		}
+	}
+	return @ret;
+}
+
 sub parse_hunk_selection {
 	local $_;
 	my ($hunk, $line) = @_;
@@ -1100,6 +1127,9 @@ sub parse_hunk_selection {
 			}
 		}
 	}
+	if ($max_label < 10) {
+		@fields = split_hunk_selection(@fields) or return undef;
+	}
 	for (@fields) {
 		if (/^([0-9]*)-([0-9]*)$/) {
 			if ($1 eq '' and $2 eq '') {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 89c0e73f2b..d3bce154da 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -410,7 +410,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l "^1 3" |
+	printf "%s\n" l ^13 |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&
-- 
2.16.2

