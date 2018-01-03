Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E981F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeACVrr (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:47:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:65525 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbeACVrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:47:46 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B3472844DE;
        Wed,  3 Jan 2018 16:47:45 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 49C79844DC;
        Wed,  3 Jan 2018 16:47:45 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 3/5] status: update short status to respect --no-ahead-behind
Date:   Wed,  3 Jan 2018 21:47:31 +0000
Message-Id: <20180103214733.797-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180103214733.797-1-git@jeffhostetler.com>
References: <20180103214733.797-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach "git status --short --branch" to respect "--no-ahead-behind"
parameter to skip computing ahead/behind counts for the branch and
its upstream and just report '[different]'.

Short status also respect the "status.aheadBehind" config setting.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t6040-tracking-info.sh | 26 ++++++++++++++++++++++++++
 wt-status.c              | 11 +++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 8f17fd9..053dff3 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -147,6 +147,32 @@ test_expect_success 'status -s -b (diverged from upstream)' '
 '
 
 cat >expect <<\EOF
+## b1...origin/master [different]
+EOF
+
+test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git status -s -b --no-ahead-behind | head -1
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
+cat >expect <<\EOF
+## b1...origin/master [different]
+EOF
+
+test_expect_success 'status.aheadbehind=false status -s -b (diverged from upstream)' '
+	(
+		cd test &&
+		git checkout b1 >/dev/null &&
+		git -c status.aheadbehind=false status -s -b | head -1
+	) >actual &&
+	test_i18ncmp expect actual
+'
+
+cat >expect <<\EOF
 ## b5...brokenbase [gone]
 EOF
 
diff --git a/wt-status.c b/wt-status.c
index 3959d31..df6cc33 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1766,7 +1766,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	const char *base;
 	char *short_base;
 	const char *branch_name;
-	int num_ours, num_theirs;
+	int num_ours, num_theirs, sti;
 	int upstream_is_gone = 0;
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
@@ -1792,8 +1792,9 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base,
-			       AHEAD_BEHIND_FULL) < 0) {
+	sti = stat_tracking_info(branch, &num_ours, &num_theirs, &base,
+				 s->ahead_behind_flags);
+	if (sti < 0) {
 		if (!base)
 			goto conclude;
 
@@ -1805,12 +1806,14 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
 	free(short_base);
 
-	if (!upstream_is_gone && !num_ours && !num_theirs)
+	if (!upstream_is_gone && !sti)
 		goto conclude;
 
 	color_fprintf(s->fp, header_color, " [");
 	if (upstream_is_gone) {
 		color_fprintf(s->fp, header_color, LABEL(N_("gone")));
+	} else if (s->ahead_behind_flags == AHEAD_BEHIND_QUICK) {
+		color_fprintf(s->fp, header_color, LABEL(N_("different")));
 	} else if (!num_ours) {
 		color_fprintf(s->fp, header_color, LABEL(N_("behind ")));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
-- 
2.9.3

