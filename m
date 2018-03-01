Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E0A1F576
	for <e@80x24.org>; Thu,  1 Mar 2018 10:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967598AbeCAKvb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 05:51:31 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:23459 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967577AbeCAKvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 05:51:22 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id rLnoeYfgY59cnrLnuexaFb; Thu, 01 Mar 2018 10:51:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519901475;
        bh=0W9QB0CDmw3WSKDt28Pdfguv9WGZmpzOeaQDnk2oi0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=UsPEXVWm7zKbwFbTHStCgYOVdglI+jJuITEnHIo5GhqIFkyWgK7spjjxjnVWkZxqh
         HTDINK/1+hUu6+Gaktz43mV2x9UTZ7/kgOu/QzYgNZuHfkNa9+7h0SrImkOWg7Akuq
         L3GlrlG9J2G3mF3i/CL94Md3uwhMWLMg54txy89A=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=Yr8hubQX c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=TgBjFQ-4gL6B6trCziwA:9
 a=lEOF10Py47WRiUkP:21 a=vgxmcP0Jzq72Yh1e:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 1/9] add -i: add function to format hunk header
Date:   Thu,  1 Mar 2018 10:50:55 +0000
Message-Id: <20180301105103.24268-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301105103.24268-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfEVYF08KmMk5o2Z53RUVHJz03zr7JqAyA2XHrHtJJiCwOCbc+bFAuailOitiNNw7cDCIdBA5PxlLwiK29xOl2buK7+XJk+TNZtPRh/fQ9l/fiWkeDdOK
 WJsApcTymjbwZAbq3zngYZRd7DUoyV8EZ4ASlxGOv7Z0eGRFFIgS8imSazLf6tNveTPNYC2jmUoT4T2gNytjVkek4orbdnofYP2fNXN8c+x6/6v0utVl9uH4
 xBNzoL+sG92f9BqF2ALx/4ubTXPfItrbXamjBihHpN2hfUG9x3R1LR6lLtlAi40Wpjy5A/TqcFO++SnwtCpvJCWdvISyevBUIeqQPgznFSA=
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

