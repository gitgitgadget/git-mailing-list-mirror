Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8D3203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 12:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbcGUM7k (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 08:59:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33068 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381AbcGUM7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 08:59:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u6LCxVMj027194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 21 Jul 2016 14:59:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u6LCxWOT003668;
	Thu, 21 Jul 2016 14:59:33 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	git@vger.kernel.org
Cc:	Thibault Durand <thibault.durand.28@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] status: suggest 'git merge --abort' when appropriate
Date:	Thu, 21 Jul 2016 14:58:37 +0200
Message-Id: <20160721125837.3127-1-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 21 Jul 2016 14:59:31 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u6LCxVMj027194
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1469710774.64005@W55dZPeSteYgN6fg6928gQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We already suggest 'git rebase --abort' during a conflicted rebase.
Similarly, suggest 'git merge --abort' during conflict resolution on
'git merge'.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7060-wtstatus.sh    | 4 ++++
 t/t7512-status-help.sh | 1 +
 wt-status.c            | 7 +++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 44bf1d8..4d17363 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -34,6 +34,7 @@ test_expect_success 'M/D conflict does not segfault' '
 On branch side
 You have unmerged paths.
   (fix conflicts and run "git commit")
+  (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
@@ -138,6 +139,7 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
 On branch master
 You have unmerged paths.
   (fix conflicts and run "git commit")
+  (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
@@ -171,6 +173,7 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
 On branch conflict_second
 You have unmerged paths.
   (fix conflicts and run "git commit")
+  (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
@@ -195,6 +198,7 @@ test_expect_success 'status when conflicts with only rm advice (both deleted)' '
 On branch conflict_second
 You have unmerged paths.
   (fix conflicts and run "git commit")
+  (use "git merge --abort" to abort the merge)
 
 Changes to be committed:
 
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 49d19a3..5c3db65 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -29,6 +29,7 @@ test_expect_success 'status when conflicts unresolved' '
 On branch conflicts
 You have unmerged paths.
   (fix conflicts and run "git commit")
+  (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
   (use "git add <file>..." to mark resolution)
diff --git a/wt-status.c b/wt-status.c
index de62ab2..1f21b6a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -948,9 +948,12 @@ static void show_merge_in_progress(struct wt_status *s,
 {
 	if (has_unmerged(s)) {
 		status_printf_ln(s, color, _("You have unmerged paths."));
-		if (s->hints)
+		if (s->hints) {
 			status_printf_ln(s, color,
-				_("  (fix conflicts and run \"git commit\")"));
+					 _("  (fix conflicts and run \"git commit\")"));
+			status_printf_ln(s, color,
+					 _("  (use \"git merge --abort\" to abort the merge)"));
+		}
 	} else {
 		s-> commitable = 1;
 		status_printf_ln(s, color,
-- 
2.8.2.397.gbe91ebf.dirty

