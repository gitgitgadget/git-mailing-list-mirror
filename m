Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2CE1F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeBSLgg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:36:36 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:64167 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeBSLgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:36:31 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njk7e9rCnoNnDnjkDeU6PH; Mon, 19 Feb 2018 11:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519040190;
        bh=n5UVNcknfbicOmTy6htfiw8KP5j7tCfD2zxk9pIqspQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=KAwHdw4nXf4KP/AA4bX3JrY6YhX4PhtkZ/X/KkPA/xvC3HTChF/Ukjq7elhhb32Qk
         kE89jrKy+H/HH1U8U8olHMgMXwuozyT5EBRvbhJTEBxQIydq1dQ8hw5+nRP75O2WEt
         wd7wskjIjfxFxYyt1vkYmn+oqrSgj2aVP77KcpzY=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=2kG5L1IlKlJr-47OeXQA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=pCjOdX2K6EewF96w:21 a=jxotn7kL3FWZOjvQ:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 2/3] add -p: allow line selection to be inverted
Date:   Mon, 19 Feb 2018 11:36:18 +0000
Message-Id: <20180219113619.26566-3-phillip.wood@talktalk.net>
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

If the list of lines to be selected begins with '^' select all the
lines except the ones listed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl  | 15 ++++++++++++++-
 t/t3701-add-interactive.sh |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8a33796e1f6a564d0a27ba06c216dbb9848827b9..0e3960b1ecf004bff51d28d540f685a5dc91fad1 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1070,9 +1070,21 @@ sub check_hunk_label {
 sub parse_hunk_selection {
 	local $_;
 	my ($hunk, $line) = @_;
-	my $max_label = $hunk->{MAX_LABEL};
+	my ($max_label, $invert) = ($hunk->{MAX_LABEL}, undef);
 	my @selected = (0) x ($max_label + 1);
 	my @fields = split(/[,\s]+/, $line);
+	if ($fields[0] =~ /^\^(.*)/) {
+		$invert = 1;
+		if ($1 ne '') {
+			$fields[0] = $1;
+		} else {
+			shift @fields;
+			unless (@fields) {
+				error_msg __("no lines to invert\n");
+				return undef;
+			}
+		}
+	}
 	for (@fields) {
 		if (/^([0-9]*)-([0-9]*)$/) {
 			if ($1 eq '' and $2 eq '') {
@@ -1093,6 +1105,7 @@ sub parse_hunk_selection {
 			return undef;
 		}
 	}
+	$invert and @selected = map { !$_ } @selected;
 	return \@selected;
 }
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index caa80327c461785949eb2b9c919c253f4bef72cc..4ae706fd121f157e9cbd93ec293f45ce2a3a53b5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -390,7 +390,7 @@ test_expect_success 'setup expected diff' '
 '
 
 test_expect_success 'can reset individual lines of patch' '
-	printf "%s\n" l 2 |
+	printf "%s\n" l "^1 3" |
 	EDITOR=: git reset -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached HEAD | sed /^index/d >actual &&
-- 
2.16.1

