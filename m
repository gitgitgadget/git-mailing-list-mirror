Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC1A1F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbeBMKoZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:44:25 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:50460 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933999AbeBMKoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:44:23 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id lY4NeT0Dyr5N9lY4UeMF1e; Tue, 13 Feb 2018 10:44:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1518518662;
        bh=33nEtog+hEq2+EIRcOfNJwuUpYKLZsGP8BO2BpIyq5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Tk+HCKJ0Y6cCeDMq+lyYHaOgyFQGH9ZO+Enk+kGsuvWQhlxcCcGq9jAySbk+WHNcb
         RlSyMImk90z2jQFcZHy/pF6hnyRy2LNPQYvcFDWYhTJrMuB1KUojUofFSTNzNKLMPv
         7KXrTlFPBhrfO5WOAO/n7cUjJ691XeY0CI5q8Wu8=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=M9M9E24s c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=TgBjFQ-4gL6B6trCziwA:9
 a=lEOF10Py47WRiUkP:21 a=vwLR2gsJwxG7gmcR:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/4] add -i: add function to format hunk header
Date:   Tue, 13 Feb 2018 10:44:05 +0000
Message-Id: <20180213104408.9887-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213104408.9887-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNR7JzisyBvKFCCUs+CWAowm/8Qlu+xMInVfO06ruI+gIqOxIhN6CHZuFevq4Hxl+10DNmuQ6YON+04wIleXylaoQGXRR+VPvb+lGgYyVWOzcC334AUJ
 wNe7YPoy7diynSK3ueaSQvdR5SAugwE4iIrwpxe9eThNKHdW2xKn4NOwzZZ3AICGJjSkG8YA2JsMLav9HO9w1v94wcQaF0+tXUkqLKaJS92bcGABnC9VhGs9
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
index 964c3a75420db4751cf11125b68b6904112632f1..8ababa6453ac4f57a925aacbb8b9bb1c973e4a54 100755
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

