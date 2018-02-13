Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B83B1F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbeBMKdH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:33:07 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:61770 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934029AbeBMKc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:32:58 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id lXtIeSz2sr5N9lXtQeMEfG; Tue, 13 Feb 2018 10:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1518517976;
        bh=6NE2Q9INcz+nLTIMi8cbvhZ3/RNEGkerXkKRjGANeAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=LZvP59eivtFVGMmwEGdI+vT0qzk8raw4AZHGC8jxOBC8xXCEkQVokHWACSW7pI8Jp
         w4h+N+aZJIdmyG6Ey69WYDYwud2BE3mC5iDSX+RSyykr4Jyh+sMOC/AhKTJL0lJS6m
         +Fl9To9BteqBRAWdH1h21NixvdZfptAugFORcxrE=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=M9M9E24s c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=JzM69pRzq2IBrcMo0JgA:9
 a=swAj3W41_4NpEwgy:21 a=EOHAvB21wBt59z69:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/3] add -p: Only bind search key if there's more than one hunk
Date:   Tue, 13 Feb 2018 10:32:40 +0000
Message-Id: <20180213103241.6789-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213103241.6789-1-phillip.wood@talktalk.net>
References: <20180213103241.6789-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKm18bHShCHQH2s3GTXATFxvcQgHSTRGnY0fFqzY5f/VQhVFDZhMkE7O3HSt/QRjyjHt4Qeyk9YsoTFmLr7nGWrI+SO5RzrTcBs3aUPNEDUVviGvq1bs
 Jq1RFU8xk1y6VTl5scQ+4Xktnk7EcZlt78Tq3d5+ININLuW3HObs7WzzWhmEhYA2JQbda+goT+309aTMvMllMeTqzu4YcgiqDirO+GboSQ6Yyqp06u3baBY1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there is only a single hunk then disable searching as there is
nothing to search for. Also print a specific error message if the user
tries to search with '/' when there's only a single hunk rather than
just listing the key bindings.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl | 50 +++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 76b941f8f0071b7bfa9d515af25b69997ef4581a..79ab36aacf84ed329a9d50886b98bb4ef8b8e312 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1185,7 +1185,7 @@ d - do not apply this hunk or any of the later hunks in the file"),
 
 sub help_patch_cmd {
 	local $_;
-	my $other = $_[0] . ",/,?";
+	my $other = $_[0] . ",?";
 	print colored $help_color, __($help_patch_modes{$patch_mode}), "\n",
 		map { "$_\n" } grep {
 			my $c = quotemeta(substr($_, 0, 1));
@@ -1308,39 +1308,39 @@ sub display_hunks {
 
 my %patch_update_prompt_modes = (
 	stage => {
-		mode => N__("Stage mode change [y,n,q,a,d,/%s,?]? "),
-		deletion => N__("Stage deletion [y,n,q,a,d,/%s,?]? "),
-		hunk => N__("Stage this hunk [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Stage mode change [y,n,q,a,d%s,?]? "),
+		deletion => N__("Stage deletion [y,n,q,a,d%s,?]? "),
+		hunk => N__("Stage this hunk [y,n,q,a,d%s,?]? "),
 	},
 	stash => {
-		mode => N__("Stash mode change [y,n,q,a,d,/%s,?]? "),
-		deletion => N__("Stash deletion [y,n,q,a,d,/%s,?]? "),
-		hunk => N__("Stash this hunk [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Stash mode change [y,n,q,a,d%s,?]? "),
+		deletion => N__("Stash deletion [y,n,q,a,d%s,?]? "),
+		hunk => N__("Stash this hunk [y,n,q,a,d%s,?]? "),
 	},
 	reset_head => {
-		mode => N__("Unstage mode change [y,n,q,a,d,/%s,?]? "),
-		deletion => N__("Unstage deletion [y,n,q,a,d,/%s,?]? "),
-		hunk => N__("Unstage this hunk [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Unstage mode change [y,n,q,a,d%s,?]? "),
+		deletion => N__("Unstage deletion [y,n,q,a,d%s,?]? "),
+		hunk => N__("Unstage this hunk [y,n,q,a,d%s,?]? "),
 	},
 	reset_nothead => {
-		mode => N__("Apply mode change to index [y,n,q,a,d,/%s,?]? "),
-		deletion => N__("Apply deletion to index [y,n,q,a,d,/%s,?]? "),
-		hunk => N__("Apply this hunk to index [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Apply mode change to index [y,n,q,a,d%s,?]? "),
+		deletion => N__("Apply deletion to index [y,n,q,a,d%s,?]? "),
+		hunk => N__("Apply this hunk to index [y,n,q,a,d%s,?]? "),
 	},
 	checkout_index => {
-		mode => N__("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "),
-		deletion => N__("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "),
-		hunk => N__("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
 	},
 	checkout_head => {
-		mode => N__("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "),
-		deletion => N__("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "),
-		hunk => N__("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	checkout_nothead => {
-		mode => N__("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "),
-		deletion => N__("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "),
-		hunk => N__("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "),
+		mode => N__("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
 );
 
@@ -1396,7 +1396,7 @@ sub patch_update_file {
 			$other .= ',J';
 		}
 		if ($num > 1) {
-			$other .= ',g';
+			$other .= ',g,/';
 		}
 		for ($i = 0; $i < $num; $i++) {
 			if (!defined $hunk[$i]{USE}) {
@@ -1484,6 +1484,10 @@ sub patch_update_file {
 			}
 			elsif ($line =~ m|^/(.*)|) {
 				my $regex = $1;
+				unless ($other =~ m|/|) {
+					error_msg __("No other hunks to search\n");
+					next;
+				}
 				if ($1 eq "") {
 					print colored $prompt_color, __("search for regex? ");
 					$regex = <STDIN>;
-- 
2.16.1

