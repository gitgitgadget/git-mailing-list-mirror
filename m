Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0529B1F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeB0LE1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:04:27 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:55253 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeB0LEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:04:25 -0500
Received: from lindisfarne.localdomain ([89.242.176.20])
        by smtp.talktalk.net with SMTP
        id qd3QeQ4WdoNnDqd3XeXd0V; Tue, 27 Feb 2018 11:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519729464;
        bh=0W9QB0CDmw3WSKDt28Pdfguv9WGZmpzOeaQDnk2oi0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=B30tMrgfe+IKFQQU4H19qlyvGwfsnRvd+77cCPDP6xZ4Rf2Z+B25A1IPfj2mS/Dct
         5l337BMV+KvXuJs2WE7yRqn2OVY7/Xv9qvRr/9z/VPLpCavRMZ2DF8c9txvXYa3OM+
         S7BQC9pcrdH3HMcXKm0gAZ23mpeenLVZVfxSNT8U=
X-Originating-IP: [89.242.176.20]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=BZXIa/HMvEOrkAULb1ciZg==:117
 a=BZXIa/HMvEOrkAULb1ciZg==:17 a=evINK-nbAAAA:8 a=TgBjFQ-4gL6B6trCziwA:9
 a=lEOF10Py47WRiUkP:21 a=vgxmcP0Jzq72Yh1e:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/9] add -i: add function to format hunk header
Date:   Tue, 27 Feb 2018 11:03:56 +0000
Message-Id: <20180227110404.16816-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180227110404.16816-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNQAq7iSApLOxHuMk+ZDh+sk3k5LCxS8Yl5sEcMuWbTdV+VkbxtHeoHG2jaC4ZIisAeAcVtbZvwL/6vDRznNIsQITitUkFHwG3ACxFM290wQ4n7GDt77
 5Pi3cIZ5fUPq9S5qYQl3lVc79lDK35nrpy7CICmooB1BJx9RGrDWId7UUwctOc2IPj58dskMJS6KueL0iz7UgT0Qnwgd7j0INRi8b/+rboo6gTFk2VcWYufK
 Mzl+Pp3LZ7iAuzTne3MPpHuvJvuEn5siVIZ9H1N3KasO0r9bOym0AGzfZs0z4MPnDgGgRRFwtKESOPTua2qave83aXAKKJGn8zVNOnnVyoU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This code is duplicated in a couple of places so make it into a
function as we're going to add some more callers shortly.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 964c3a7542..8ababa6453 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -751,6 +751,15 @@ sub parse_hunk_header {
 	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
 }
 
+sub format_hunk_header {
+	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) = @_;
+	return ("@@ -$o_ofs" .
+		(($o_cnt != 1) ? ",$o_cnt" : '') .
+		" +$n_ofs" .
+		(($n_cnt != 1) ? ",$n_cnt" : '') .
+		" @@\n");
+}
+
 sub split_hunk {
 	my ($text, $display) = @_;
 	my @split = ();
@@ -838,11 +847,7 @@ sub split_hunk {
 		my $o_cnt = $hunk->{OCNT};
 		my $n_cnt = $hunk->{NCNT};
 
-		my $head = ("@@ -$o_ofs" .
-			    (($o_cnt != 1) ? ",$o_cnt" : '') .
-			    " +$n_ofs" .
-			    (($n_cnt != 1) ? ",$n_cnt" : '') .
-			    " @@\n");
+		my $head = format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
 		my $display_head = $head;
 		unshift @{$hunk->{TEXT}}, $head;
 		if ($diff_use_color) {
@@ -912,11 +917,7 @@ sub merge_hunk {
 		}
 		push @line, $line;
 	}
-	my $head = ("@@ -$o0_ofs" .
-		    (($o_cnt != 1) ? ",$o_cnt" : '') .
-		    " +$n0_ofs" .
-		    (($n_cnt != 1) ? ",$n_cnt" : '') .
-		    " @@\n");
+	my $head = format_hunk_header($o0_ofs, $o_cnt, $n0_ofs, $n_cnt);
 	@{$prev->{TEXT}} = ($head, @line);
 }
 
-- 
2.16.1

