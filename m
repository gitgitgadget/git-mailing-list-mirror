Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7DB71F404
	for <e@80x24.org>; Wed, 20 Dec 2017 14:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755350AbdLTOnA (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 09:43:00 -0500
Received: from siwi.pair.com ([209.68.5.199]:62725 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755121AbdLTOm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 09:42:57 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DF61B845FE;
        Wed, 20 Dec 2017 09:42:56 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 73ED7845D4;
        Wed, 20 Dec 2017 09:42:56 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 3/4] status: update short status to use --no-ahead-behind
Date:   Wed, 20 Dec 2017 14:42:44 +0000
Message-Id: <20171220144245.39401-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171220144245.39401-1-git@jeffhostetler.com>
References: <20171220144245.39401-1-git@jeffhostetler.com>
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
 Documentation/git-status.txt |  3 +++
 remote.c                     | 12 +++++++++---
 t/t6040-tracking-info.sh     | 13 +++++++++++++
 wt-status.c                  | 11 +++++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 6ce8cf8..ea029ad 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -117,6 +117,9 @@ configuration variable documented in linkgit:git-config[1].
 	expensive computation on extremely large repositories.
 +
 	In porcelain V2 format, the 'branch.ab' line will not be present.
++
+	In short format with --branch, '[different]' will printed rather
+	than detailed ahead/behind counts.
 
 <pathspec>...::
 	See the 'pathspec' entry in linkgit:gitglossary[7].
diff --git a/remote.c b/remote.c
index a38b42e..0a63ac1 100644
--- a/remote.c
+++ b/remote.c
@@ -1978,9 +1978,12 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 
 /*
  * Compare a branch with its upstream, and save their differences (number
- * of commits) in *num_ours and *num_theirs. The name of the upstream branch
- * (or NULL if no upstream is defined) is returned via *upstream_name, if it
- * is not itself NULL.
+ * of commits) in *num_ours and *num_theirs.  If either num_ours or num_theirs
+ * are NULL, we skip counting the commits and just return whether they are
+ * different.
+ *
+ * The name of the upstream branch (or NULL if no upstream is defined) is
+ * returned via *upstream_name, if it is not itself NULL.
  *
  * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
  * upstream defined, or ref does not exist).
@@ -2016,6 +2019,9 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (!ours)
 		return -1;
 
+	if (!num_ours || !num_theirs)
+		return theirs != ours;
+
 	/* are we the same? */
 	if (theirs == ours) {
 		*num_theirs = *num_ours = 0;
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
index 471ba15..6b4f969 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1767,6 +1767,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	const char *branch_name;
 	int num_ours, num_theirs;
 	int upstream_is_gone = 0;
+	int sti;
 
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");
 
@@ -1791,7 +1792,11 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base) < 0) {
+	if (s->no_ahead_behind)
+		sti = stat_tracking_info(branch, NULL, NULL, &base);
+	else
+		sti = stat_tracking_info(branch, &num_ours, &num_theirs, &base);
+	if (sti < 0) {
 		if (!base)
 			goto conclude;
 
@@ -1803,12 +1808,14 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
 	free(short_base);
 
-	if (!upstream_is_gone && !num_ours && !num_theirs)
+	if (!upstream_is_gone && !sti)
 		goto conclude;
 
 	color_fprintf(s->fp, header_color, " [");
 	if (upstream_is_gone) {
 		color_fprintf(s->fp, header_color, LABEL(N_("gone")));
+	} else if (s->no_ahead_behind) {
+		color_fprintf(s->fp, header_color, LABEL(N_("different")));
 	} else if (!num_ours) {
 		color_fprintf(s->fp, header_color, LABEL(N_("behind ")));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
-- 
2.9.3

