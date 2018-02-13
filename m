Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4531F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934443AbeBMKdB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:33:01 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:41363 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934146AbeBMKc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:32:58 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id lXtIeSz2sr5N9lXtQeMEfI; Tue, 13 Feb 2018 10:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1518517976;
        bh=ZjOreJ7M7ZznpJFb4REeCddPw36qhOWNeZoDcUOIM+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=F7PUmbokFm9cSh8LJQf9xgOKbI/0SrfBqtROorbcj+qxs31OpdtHnQQ56o19Xnx2A
         KBjB9aNboGaYvczoh4Y0HH7PBYL3T5Hyoub808ej7wqFOCIkNZAWbYADj94Fz8sxmQ
         QwNA40DIAfwFKuNY2qispSIeuy2AAfPv3/9v5+kU=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=M9M9E24s c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=eN4Qt2GFzVF6TNEfxdQA:9
 a=qoH4ge6fbHlzvLNY:21 a=PjFmXyvvG58ckR5_:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/3] add -p: improve error messages
Date:   Tue, 13 Feb 2018 10:32:41 +0000
Message-Id: <20180213103241.6789-4-phillip.wood@talktalk.net>
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

If the user presses a key that isn't currently active then explain why
it isn't active rather than just listing all the keys. It already did
this for some keys, this patch does the same for the those that
weren't already handled.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 79ab36aacf84ed329a9d50886b98bb4ef8b8e312..d9d8ff3090e914421ab67071117789f6b3554475 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1437,8 +1437,12 @@ sub patch_update_file {
 				}
 				next;
 			}
-			elsif ($other =~ /g/ && $line =~ /^g(.*)/) {
+			elsif ($line =~ /^g(.*)/) {
 				my $response = $1;
+				unless ($other =~ /g/) {
+					error_msg __("No other hunks to goto\n");
+					next;
+				}
 				my $no = $ix > 10 ? $ix - 10 : 0;
 				while ($response eq '') {
 					$no = display_hunks(\@hunk, $no);
@@ -1556,7 +1560,11 @@ sub patch_update_file {
 					next;
 				}
 			}
-			elsif ($other =~ /s/ && $line =~ /^s/) {
+			elsif ($line =~ /^s/) {
+				unless ($other =~ /s/) {
+					error_msg __("Sorry, cannot split this hunk\n");
+					next;
+				}
 				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
 				if (1 < @split) {
 					print colored $header_color, sprintf(
@@ -1568,7 +1576,11 @@ sub patch_update_file {
 				$num = scalar @hunk;
 				next;
 			}
-			elsif ($other =~ /e/ && $line =~ /^e/) {
+			elsif ($line =~ /^e/) {
+				unless ($other =~ /e/) {
+					error_msg __("Sorry, cannot edit this hunk\n");
+					next;
+				}
 				my $newhunk = edit_hunk_loop($head, \@hunk, $ix);
 				if (defined $newhunk) {
 					splice @hunk, $ix, 1, $newhunk;
-- 
2.16.1

