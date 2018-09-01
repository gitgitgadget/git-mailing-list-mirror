Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B098B1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 23:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeIBEGi (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 00:06:38 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:35232 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeIBEGi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 00:06:38 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180901235257.CHQZ4136.fed1rmfepo103.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Sat, 1 Sep 2018 19:52:57 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id WPsw1y00L59yGBo01Pswcu; Sat, 01 Sep 2018 19:52:57 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090209.5B8B2659.000A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Ip1uSP3g c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=kviXuzpPAAAA:8 a=ttFGt-jwIwjusGOcAy8A:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 773B929A010A;
        Sat,  1 Sep 2018 16:52:56 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] wt-status.c: Move has_unmerged earlier in the file.
Date:   Sat,  1 Sep 2018 16:52:54 -0700
Message-Id: <20180901235256.4260-2-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180901235256.4260-1-ischis2@cox.net>
References: <20180901235256.4260-1-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move has_unmerged up in the file so that has_unmerged can be called in
wt_status_collect where we need to place a merge check.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 wt-status.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 5ffab6101..180faf6ba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -724,6 +724,19 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
+static int has_unmerged(struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		d = s->change.items[i].util;
+		if (d->stagemask)
+			return 1;
+	}
+	return 0;
+}
+
 void wt_status_collect(struct wt_status *s)
 {
 	wt_status_collect_changes_worktree(s);
@@ -1063,19 +1076,6 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
-static int has_unmerged(struct wt_status *s)
-{
-	int i;
-
-	for (i = 0; i < s->change.nr; i++) {
-		struct wt_status_change_data *d;
-		d = s->change.items[i].util;
-		if (d->stagemask)
-			return 1;
-	}
-	return 0;
-}
-
 static void show_merge_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
-- 
2.18.0

