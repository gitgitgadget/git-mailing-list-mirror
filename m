Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB041FAE3
	for <e@80x24.org>; Mon,  5 Mar 2018 10:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934488AbeCEK5K (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:57:10 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:34191 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934422AbeCEK4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:45 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnPesOzv; Mon, 05 Mar 2018 10:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247404;
        bh=2d5smY9SnmHUDL99wRTxXeROt8F2BLvKMxbbEAoPgpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=lfJoWvDTKIh4fLCtpaVfhrRnUQdyt7fwn7ErDpSKzd7Ld3QkQMHkXM/BaxurWamq+
         9Snr4WV87g/5/VaFcP1Ue/F0cp6L20KCkQeOpU94nigBDNAxvR5CJ/LHtm3p1FiY2j
         O8iS5ycz+g83Mkz5Axm31AXXNhaFc/xsthWqT7j0=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=Vi1R3C_QCdLrTvDhwxkA:9
 a=p-yatSCVgE3Rd7fy:21 a=qNE3FlwjLGDp7qyu:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 6/9] add -p: adjust offsets of subsequent hunks when one is skipped
Date:   Mon,  5 Mar 2018 10:56:27 +0000
Message-Id: <20180305105630.14407-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfIG5LJPAr8qtj+zVvkwsx2BTGcQGfMGg93xXqEvqGcOAqmux0vPv7fVoaV3wg/DrVah+wdz1YIJpoAY7MNJmV7ucyWmfPmHENQ5NcK99+P8n6SQeqK5r
 TddV0L/SlXiwb2+AZy2bneLg9aAqgfIFcDh/OgFBPUkUnBJGP0EE9kBvgaP1A0UsXwKR/YdXnUeYwR4kUhZyqpQ4T5Akw62WT0yoIZCzuJTJvLRir13G7bNT
 LO2IPpm+BUfnJm7pO53zv/qqdW6QDMuqKIKE7RNLfn3vP2z2AWslYB20800xnGACTzdhbQw0nF3EZTYrq8c3fSr3LZyJ+GhKDrKySYqhowg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since commit 8cbd431082 ("git-add--interactive: replace hunk
recounting with apply --recount", 2008-7-2) if a hunk is skipped then
we rely on the context lines to apply subsequent hunks in the right
place. While this works most of the time it is possible for hunks to
end up being applied in the wrong place. To fix this adjust the offset
of subsequent hunks to correct for any change in the number of
insertions or deletions due to the skipped hunk. The change in offset
due to edited hunks that have the number of insertions or deletions
changed is ignored here, it will be fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl  | 15 +++++++++++++--
 t/t3701-add-interactive.sh |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8ababa6453..7a0a5896bb 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -926,14 +926,25 @@ sub coalesce_overlapping_hunks {
 	my @out = ();
 
 	my ($last_o_ctx, $last_was_dirty);
+	my $ofs_delta = 0;
 
-	for (grep { $_->{USE} } @in) {
+	for (@in) {
 		if ($_->{TYPE} ne 'hunk') {
 			push @out, $_;
 			next;
 		}
 		my $text = $_->{TEXT};
-		my ($o_ofs) = parse_hunk_header($text->[0]);
+		my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
+						parse_hunk_header($text->[0]);
+		unless ($_->{USE}) {
+			$ofs_delta += $o_cnt - $n_cnt;
+			next;
+		}
+		if ($ofs_delta) {
+			$n_ofs += $ofs_delta;
+			$_->{TEXT}->[0] = format_hunk_header($o_ofs, $o_cnt,
+							     $n_ofs, $n_cnt);
+		}
 		if (defined $last_o_ctx &&
 		    $o_ofs <= $last_o_ctx &&
 		    !$_->{DIRTY} &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 094eeca405..e3150a4e07 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -544,7 +544,7 @@ test_expect_success 'set up pathological context' '
 	test_write_lines +b " a" >patch
 '
 
-test_expect_failure 'add -p works with pathological context lines' '
+test_expect_success 'add -p works with pathological context lines' '
 	git reset &&
 	printf "%s\n" n y |
 	git add -p &&
-- 
2.16.2

