Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CAA1F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeBSL3n (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:29:43 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:3823 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbeBSL3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:29:24 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njdCe9qQuoNnDnjdKeU69L; Mon, 19 Feb 2018 11:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519039763;
        bh=Xih2VbhGfBKErAsYKM8DUFwcVNtlY6/cLKm60GkXQAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=oQDBPlXzhvwc8vBbw6zbKRIUQS4ojuaUOm87yzhtUn37LwTbpy+sfNChanTUKjsxa
         8tzW2OMUNRpCnE89unVzoxlCFyfu4CJl3WSsDoM9zGQCKGdbwT6x+y1te+FR+f6yKp
         2bw7gulzkC7Owo6JCM+0Wck1jy15aO346dKoyL+g=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=Vi1R3C_QCdLrTvDhwxkA:9
 a=6YDPZE5VyCnXASPI:21 a=qNE3FlwjLGDp7qyu:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 6/9] add -p: Adjust offsets of subsequent hunks when one is skipped
Date:   Mon, 19 Feb 2018 11:29:07 +0000
Message-Id: <20180219112910.24471-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219112910.24471-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPKeOwzoAL34nkkUtAB7ssMkRC3GedaQxWA20R4ehR+9ayz9MX2Ul0VDzvVIJ1HKviObe/cRnovXodnsacG9medxTJe0nnyaIQM7ba84El0u7bnWJZsh
 pWwJ2NmBebSXlOidc2TSB33/YZNn0Yu2/0NvLSvXkhMPR+PmJX++kzOWgNBA46olETH1xlJQo0smC608JRNQ3TK1URIQhDEndEWWPzK/AzK4H4m0B7x+Mv8U
 IMnEw4Hyf9szs+jjUtgF0yruiFb55xZwEwFNNVzJw3md4iXNn2/gb+JlKoAQT87V
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
index 8ababa6453ac4f57a925aacbb8b9bb1c973e4a54..7a0a5896bb8fa063ace29b85840849c867b874f5 100755
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
index 06c4747f506a1b05ccad0f9387e1fbd69cfd7784..e153a02605df25ea40e49dd48b7c9fd981713b9d 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -524,7 +524,7 @@ test_expect_success 'set up pathological context' '
 	test_write_lines +b " a" >patch
 '
 
-test_expect_failure 'add -p works with pathological context lines' '
+test_expect_success 'add -p works with pathological context lines' '
 	git reset &&
 	printf "%s\n" n y |
 	git add -p &&
-- 
2.16.1

