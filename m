X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Rocco Rutte <pdmef@gmx.net>
Subject: [PATCH] Fix git-runstatus for repositories containing a file named HEAD
Date: Sun,  5 Nov 2006 21:52:50 +0000
Message-ID: <11627635702846-git-send-email-pdmef@gmx.net>
NNTP-Posting-Date: Sun, 5 Nov 2006 21:53:16 +0000 (UTC)
Cc: Rocco Rutte <pdmef@gmx.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1642131
X-Mailer: git-send-email 1.4.3.4.g50f39-dirty
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30987>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgpvF-0002zA-3w for gcvg-git@gmane.org; Sun, 05 Nov
 2006 22:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422718AbWKEVwy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 16:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWKEVwy
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 16:52:54 -0500
Received: from mail.gmx.de ([213.165.64.20]:59049 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1422718AbWKEVwx (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 16:52:53 -0500
Received: (qmail invoked by alias); 05 Nov 2006 21:52:51 -0000
Received: from cable-62-117-23-87.cust.blue-cable.de (EHLO
 peter.daprodeges.fqdn.th-h.de) [62.117.23.87] by mail.gmx.net (mp038) with
 SMTP; 05 Nov 2006 22:52:51 +0100
Received: from localhost.localdomain (robert.daprodeges.dyndns.org
 [192.168.0.113]) by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id
 D710A20F0B; Sun,  5 Nov 2006 21:52:50 +0000 (UTC)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The wt_status_print_updated() and wt_status_print_untracked() routines
call setup_revisions() with 'HEAD' being the reference to the tip of the
current branch. However, setup_revisions() gets confused if the branch
also contains a file named 'HEAD' resulting in a fatal error.

The fix is to append the '--' delimiter to the setup_revisions() call so
that it knows for sure that the 'HEAD' argument is a revision and not a
filename.

Signed-off-by: Rocco Rutte <pdmef@gmx.net>
---
 wt-status.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 7dd6857..7c0dbdb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -154,10 +154,10 @@ void wt_status_print_initial(struct wt_s
 static void wt_status_print_updated(struct wt_status *s)
 {
 	struct rev_info rev;
-	const char *argv[] = { NULL, NULL, NULL };
+	const char *argv[] = { NULL, NULL, "--", NULL };
 	argv[1] = s->reference;
 	init_revisions(&rev, NULL);
-	setup_revisions(2, argv, &rev, NULL);
+	setup_revisions(3, argv, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
@@ -225,10 +225,10 @@ static void wt_status_print_untracked(co
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
-	const char *argv[] = { NULL, NULL, NULL };
+	const char *argv[] = { NULL, NULL, "--", NULL };
 	argv[1] = s->reference;
 	init_revisions(&rev, NULL);
-	setup_revisions(2, argv, &rev, NULL);
+	setup_revisions(3, argv, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
 	run_diff_index(&rev, 1);
-- 
1.4.3.4.g50f39-dirty
