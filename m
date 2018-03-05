Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C321FAE3
	for <e@80x24.org>; Mon,  5 Mar 2018 10:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934462AbeCEK4y (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:56:54 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:60442 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934405AbeCEK4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:44 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnMesOzH; Mon, 05 Mar 2018 10:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247401;
        bh=r0gs3zifnXvs7YOWxNb0PuIz1LOdqOSTrnY441hHaxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=UVeZz8zgjg3PnPHfNTPCWRBsbNxegKFaPAcvr66n48Exr8j4KKHeYQ0RXB+uIKCGP
         l7bqVlWpYS++hHHiXbqaObSelCkAvzWwxO84dTv3NWT+uUQV5j1Jmk8IFppt1/KS6V
         Fgmzdbm1ybqNY8g6im3aqzRE+0kWbMbrae4a5wYA=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=fBBCDHGnm-2Ex6T01o0A:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 0/9] Correct offsets of hunks when one is skipped
Date:   Mon,  5 Mar 2018 10:56:21 +0000
Message-Id: <20180305105630.14407-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180213104408.9887-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLMVi47rlez5W7FB6A3Ni0pu1EvahjjHR5pvBo67OQPgB/ZzlAtRDT9XWe1/1u2SNmvQdeW++iBKrhFaejAx/vrJFqAPzz0A6K5DhhqRDCzy6uBhs6tE
 LBO44UE9XYLhaDrNEAalpwQT0hqePNYwJly7Wb4AjQeLXFX6Zh77vXj1jlM6Mhn/IHyMAFbTse5AfFiLZti0KgKvPGormE6P6xxg6DLeELRClAtYjNkPHHuN
 XCj5tcsg8YCGOjuuVZ5vC/i0N3x2q9UirY8vLSZLfSDXpj6cM7YKCQJ/szh9tzZNXLV+RWN3uSO5NwKgxd1AXdus/udp+LuGxjXJLZeThO4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated these to clean up the perl style in response to Junio's
comments on v4.

Cover letter to v1:

While working on a patch series to stage selected lines from a hunk
without having to edit it I got worried that subsequent patches would
be applied in the wrong place which lead to this series to correct the
offsets of hunks following those that are skipped or edited.

Interdiff to v4:
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a64c0db57d..f83e7450ad 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -892,8 +892,11 @@ sub merge_hunk {
 	$o_cnt = $n_cnt = 0;
 	for ($i = 1; $i < @{$prev->{TEXT}}; $i++) {
 		my $line = $prev->{TEXT}[$i];
-		if ($line =~ /^[+\\]/) {
-			$n_cnt++ if ($line =~ /^\+/);
+		if ($line =~ /^\+/) {
+			$n_cnt++;
+			push @line, $line;
+			next;
+		} elsif ($line =~ /^\\/) {
 			push @line, $line;
 			next;
 		}
@@ -910,8 +913,11 @@ sub merge_hunk {
 
 	for ($i = 1; $i < @{$this->{TEXT}}; $i++) {
 		my $line = $this->{TEXT}[$i];
-		if ($line =~ /^[+\\]/) {
-			$n_cnt++ if ($line =~ /^\+/);
+		if ($line =~ /^\+/) {
+			$n_cnt++;
+			push @line, $line;
+			next;
+		} elsif ($line =~ /^\\/) {
 			push @line, $line;
 			next;
 		}
@@ -945,7 +951,9 @@ sub coalesce_overlapping_hunks {
 			$ofs_delta += $o_cnt - $n_cnt;
 			# If this hunk has been edited then subtract
 			# the delta that is due to the edit.
-			$_->{OFS_DELTA} and $ofs_delta -= $_->{OFS_DELTA};
+			if ($_->{OFS_DELTA}) {
+				$ofs_delta -= $_->{OFS_DELTA};
+			}
 			next;
 		}
 		if ($ofs_delta) {
@@ -955,7 +963,9 @@ sub coalesce_overlapping_hunks {
 		}
 		# If this hunk was edited then adjust the offset delta
 		# to reflect the edit.
-		$_->{OFS_DELTA} and $ofs_delta += $_->{OFS_DELTA};
+		if ($_->{OFS_DELTA}) {
+			$ofs_delta += $_->{OFS_DELTA};
+		}
 		if (defined $last_o_ctx &&
 		    $o_ofs <= $last_o_ctx &&
 		    !$_->{DIRTY} &&


Phillip Wood (9):
  add -i: add function to format hunk header
  t3701: indent here documents
  t3701: use test_write_lines and write_script
  t3701: don't hard code sha1 hash values
  t3701: add failing test for pathological context lines
  add -p: adjust offsets of subsequent hunks when one is skipped
  add -p: calculate offset delta for edited patches
  add -p: fix counting when splitting and coalescing
  add -p: don't rely on apply's '--recount' option

 git-add--interactive.perl  | 108 +++++++++++++----
 t/t3701-add-interactive.sh | 291 +++++++++++++++++++++++++--------------------
 2 files changed, 249 insertions(+), 150 deletions(-)

-- 
2.16.2

