Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA701F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeH1NCe (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:02:34 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:6977 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeH1NCe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:02:34 -0400
X-Greylist: delayed 762 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2018 09:02:34 EDT
Received: from [87.191.187.70] (helo=localhost)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jochen@sprickerhof.de>)
        id 1fuZqB-000161-EJ; Tue, 28 Aug 2018 10:59:11 +0200
From:   Jochen Sprickerhof <git@jochen.sprickerhof.de>
To:     git@vger.kernel.org
Cc:     Jochen Sprickerhof <git@jochen.sprickerhof.de>
Subject: [PATCH] add -p: coalesce hunks before testing applicability
Date:   Tue, 28 Aug 2018 10:58:58 +0200
Message-Id: <20180828085858.3933-1-git@jochen.sprickerhof.de>
X-Mailer: git-send-email 2.18.0
X-Df-Sender: NTc3MDAz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a hunk was split before being edited manually, it does not apply
anymore cleanly. Apply coalesce_overlapping_hunks() first to make it
work. Enable test for it as well.

Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
---
 git-add--interactive.perl  | 8 ++++----
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 36f38ced9..c9f434e4a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1195,10 +1195,10 @@ sub edit_hunk_loop {
 		# delta from the original unedited hunk.
 		$hunk->{OFS_DELTA} and
 				$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
-		if (diff_applies($head,
-				 @{$hunks}[0..$ix-1],
-				 $newhunk,
-				 @{$hunks}[$ix+1..$#{$hunks}])) {
+		my @hunk = @{$hunks};
+		splice (@hunk, $ix, 1, $newhunk);
+		@hunk = coalesce_overlapping_hunks(@hunk);
+		if (diff_applies($head, @hunk)) {
 			$newhunk->{DISPLAY} = [color_diff(@{$newtext})];
 			return $newhunk;
 		}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b170fb02b..b04806ad7 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -348,7 +348,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '
 
-test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
+test_expect_success 'split hunk "add -p (no, yes, edit)"' '
 	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
 	git reset &&
 	# test sequence is s(plit), n(o), y(es), e(dit)
-- 
2.18.0

