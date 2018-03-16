Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74091F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 10:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeCPKOG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 06:14:06 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:35210 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeCPKN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 06:13:58 -0400
Received: from lindisfarne.localdomain ([92.22.2.60])
        by smtp.talktalk.net with SMTP
        id wmMuefAH1C0WbwmN2espwe; Fri, 16 Mar 2018 10:13:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521195237;
        bh=QquQKDSg+hLhbBm5Xr9rFoj9PqQkUeEKA3Pf/a3HY7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=NhPBMRUbElB3cPHXHfy6olszZqDYIPIENgwmebostTca3tYApXXGroWdXzSY2duh/
         nddiRMlPxdTfseB/Bww6aqMvkC6A6+YEDQnnwQKsE/2ZoKQ9db8h5WvQJ5xkvkLdcy
         WnyOfeUf0Oa/foT95L1axqJAByplkBpfkq3Z+Gh0=
X-Originating-IP: [92.22.2.60]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=pcfIiQRzx6UxJOplHTSsng==:117
 a=pcfIiQRzx6UxJOplHTSsng==:17 a=evINK-nbAAAA:8 a=bEdQegGtLMKMq23hAgQA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=2BfCruEJydzrig08:21 a=0Vjt_3ZtrWKCcHe1:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 3/3] add -p: optimize line selection for short hunks
Date:   Fri, 16 Mar 2018 10:13:46 +0000
Message-Id: <20180316101346.7137-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316101346.7137-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180316101346.7137-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGYsJFLcGfexvLoiCDDelsxnpQPs9ZkqCHsjC/oWw2HZc8yOWDcyhF8dCwlpFpEC3YSKojXBp+y95NQ8f7xT9HWN+1FpWXepZqAdOn66pyX651jIlH0W
 +mQU3JnB12rLpXo3zzW6bDqLRRa3VdpP/aUUPjc134YBLAX7t2BiJ8lmaGyAQfWgpvlRvphrNhVPhyWQZj0rIAdYRPwXpaGb/SdTfG6pPJBi+MxT9TOHGp8K
 sJYu3YFmmCrDNwoS6EqsDb8OPOANz9r7qc9/mJ1dH/Rm/E/z3G4K/mvtUt+K2V9b4/dw3k+PHLbeatt7JtptuHaxFzowj6bprSSIN0ehJjw=
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

Notes:
    changes since v2:
     - removed code that handled the default lower bound now that '-...'
       means invert the selection.

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
index 54fbe114f3..d65ad7c26d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1082,6 +1082,29 @@ sub check_hunk_label {
 	return 1;
 }
 
+sub split_hunk_selection {
+	local $_;
+	my @fields = @_;
+	my @ret;
+	for (@fields) {
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
@@ -1100,6 +1123,9 @@ sub parse_hunk_selection {
 			}
 		}
 	}
+	if ($max_label < 10) {
+		@fields = split_hunk_selection(@fields) or return undef;
+	}
 	for (@fields) {
 		if (my ($lo, $hi) = /^([0-9]+)-([0-9]*)$/) {
 			if ($hi eq '') {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 46814babf3..467c6eff0e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -410,7 +410,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l "-1 3" |
+	printf "%s\n" l -13 |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD >actual &&
-- 
2.16.2

