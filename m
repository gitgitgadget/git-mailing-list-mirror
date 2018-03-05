Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156D41FAE2
	for <e@80x24.org>; Mon,  5 Mar 2018 10:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeCEK4u (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:56:50 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:56424 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934407AbeCEK4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:44 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnNesOzM; Mon, 05 Mar 2018 10:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247401;
        bh=f6xVTm9t09IS+yWfYhldxrJhsxVzhUakds9cZ/4fT2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=h1pkoGIIwXHzpptvNPg6eIIAaezmceMnF7wagoRpP0QVguawKM2H1/1x/khYU6l86
         q7+W4ttiZwyhm1uHv7p9EmT02VTTo0Amb/Xpdbe6pSZNfAUsLa3kmNCIuKIvU7kxLf
         KAm3PuDcdaXsdr8PJ9YZ/p+DwL5ixTn8QBv34E5Y=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=TgBjFQ-4gL6B6trCziwA:9
 a=yfwzc4U-CyS2LBU1:21 a=vgxmcP0Jzq72Yh1e:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 1/9] add -i: add function to format hunk header
Date:   Mon,  5 Mar 2018 10:56:22 +0000
Message-Id: <20180305105630.14407-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLMVi47rlez5W7FB6A3Ni0pu1EvahjjHR5pvBo67OQPgB/ZzlAtRDT9XWe1/1u2SNmvQdeW++iBKrhFaejAx/vrJFqAPzz0A6K5DhhqRDCzy6uBhs6tE
 LBO44UE9XYLhaDrNEAalpwQT0hqePNYwJly7Wb4AjQeLXFX6Zh77vXj1jlM6Mhn/IHyMAFbTse5AfFiLZti0KgKvPGormE6P6xxg6DLeELRClAtYjNkPHHuN
 XCj5tcsg8YCGOjuuVZ5vC/i0N3x2q9UirY8vLSZLfSDXpj6cM7YKCQJ/szh9tzZNXLV+RWN3uSO5NwKgxd1AXdus/udp+LuGxjXJLZeThO4=
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
2.16.2

