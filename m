Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D8D1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755046AbdLUTJZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:09:25 -0500
Received: from siwi.pair.com ([209.68.5.199]:46530 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753199AbdLUTJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 14:09:19 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 65FBF844E8;
        Thu, 21 Dec 2017 14:09:19 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F141D844E1;
        Thu, 21 Dec 2017 14:09:18 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 4/5] status: update short status to use --no-ahead-behind
Date:   Thu, 21 Dec 2017 19:09:08 +0000
Message-Id: <20171221190909.62995-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171221190909.62995-1-git@jeffhostetler.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach "git status --short --branch" to use "--no-ahead-behind"
flag to skip computing ahead/behind counts for the branch and
its upstream and just report '[different]'.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t6040-tracking-info.sh | 13 +++++++++++++
 wt-status.c              |  9 ++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 8f17fd9..0190220 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -147,6 +147,19 @@ test_expect_success 'status -s -b (diverged from upstream)' '
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
 ## b5...brokenbase [gone]
 EOF
 
diff --git a/wt-status.c b/wt-status.c
index d03b47a..3235ec2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1765,7 +1765,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	const char *base;
 	char *short_base;
 	const char *branch_name;
-	int num_ours, num_theirs;
+	int num_ours, num_theirs, sti;
 	int upstream_is_gone = 0;
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
@@ -1791,7 +1791,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base, ABF_FULL) < 0) {
+	sti = stat_tracking_info(branch, &num_ours, &num_theirs, &base, s->ab_flags);
+	if (sti < 0) {
 		if (!base)
 			goto conclude;
 
@@ -1803,12 +1804,14 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
 	free(short_base);
 
-	if (!upstream_is_gone && !num_ours && !num_theirs)
+	if (!upstream_is_gone && !sti)
 		goto conclude;
 
 	color_fprintf(s->fp, header_color, " [");
 	if (upstream_is_gone) {
 		color_fprintf(s->fp, header_color, LABEL(N_("gone")));
+	} else if (s->ab_flags == ABF_QUICK) {
+		color_fprintf(s->fp, header_color, LABEL(N_("different")));
 	} else if (!num_ours) {
 		color_fprintf(s->fp, header_color, LABEL(N_("behind ")));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
-- 
2.9.3

