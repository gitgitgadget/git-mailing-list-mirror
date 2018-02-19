Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7371F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeBSLgf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:36:35 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:55790 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeBSLgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:36:31 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njk7e9rCnoNnDnjkEeU6PK; Mon, 19 Feb 2018 11:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519040190;
        bh=jtp4PFb/pPfVuhvE287tdVmARyyUnS91krfSHvLCjsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=oFhA140wLVNMD8h6HlHt5cCtgaULWsHUtyx+uadGs5N5+JY8Vf1OCFZYI6POgcV0S
         kRtWHnv+jRFo+ZmvwlWUycWYI283D+erZalUSoeAwCrSKFgPP/gqTtqG31IsdiIK2A
         EjEJ61JG5p/xoQr1NBC6XKfwGwatBkWxRBEH0eP0=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=swg0IrpoHZ5_w8mBtXsA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=kLn7Op8jVmEGbLkZ:21 a=06jbKfjSUb0NSWct:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 3/3] add -p: optimize line selection for short hunks
Date:   Mon, 19 Feb 2018 11:36:19 +0000
Message-Id: <20180219113619.26566-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219113619.26566-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPiq8V0zOiYCabzB+oOlHa8mDedD8UNKMF+NCI29zzQdDiLEJFk43Gvm0XSjgv6W71jDx6sEY1miWbzP+WXvlvNYenoUgl4+HwSzAmUkyshZQbxxzKpi
 QAPN2d8aQiZLYn42PJuV0WMj+Px4PMS5m+ERLDpu/b/ceEHAipO0BLgfhfhU3iUnpiqSul+c3pdO2NqYcZj4tt4VCDzDlXxPnwnf86qFY+cBkdMk3SZZScb1
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
 git-add--interactive.perl  | 30 ++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |  2 +-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 0e3960b1ecf004bff51d28d540f685a5dc91fad1..3d9720af03eb113c7f3d2b73f17b4b51a7685bf3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1067,6 +1067,33 @@ sub check_hunk_label {
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
@@ -1085,6 +1112,9 @@ sub parse_hunk_selection {
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
index 4ae706fd121f157e9cbd93ec293f45ce2a3a53b5..c6d847dc495c92782e37ef7b0e2800d7936aabd7 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -390,7 +390,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l "^1 3" |
+	printf "%s\n" l ^13 |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD | sed /^index/d >actual &&
-- 
2.16.1

