Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCFD1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755000AbdLUTJZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:09:25 -0500
Received: from siwi.pair.com ([209.68.5.199]:46518 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752222AbdLUTJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 14:09:18 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 31879844E6;
        Thu, 21 Dec 2017 14:09:18 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BBC94844E1;
        Thu, 21 Dec 2017 14:09:17 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 2/5] stat_tracking_info: return +1 when branches are not equal
Date:   Thu, 21 Dec 2017 19:09:06 +0000
Message-Id: <20171221190909.62995-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171221190909.62995-1-git@jeffhostetler.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Extend stat_tracking_info() return +1 when the branches are not equal
and to take a new "enum ahead_behind_flag" ABF_QUICK to avoid the
expensive ahead/behind computation when requested.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 ref-filter.c |  4 ++--
 remote.c     | 24 ++++++++++++++++--------
 remote.h     |  7 ++++++-
 wt-status.c  |  9 +++++----
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e728b15..6191cb4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1239,7 +1239,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL)) {
+				       &num_theirs, NULL, ABF_FULL) < 0) {
 			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
 			*s = "";
@@ -1257,7 +1257,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		}
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL, ABF_FULL) < 0)
 			return;
 
 		if (!num_ours && !num_theirs)
diff --git a/remote.c b/remote.c
index b220f0d..91b5afb 100644
--- a/remote.c
+++ b/remote.c
@@ -1977,16 +1977,22 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 }
 
 /*
- * Compare a branch with its upstream, and save their differences (number
- * of commits) in *num_ours and *num_theirs. The name of the upstream branch
- * (or NULL if no upstream is defined) is returned via *upstream_name, if it
- * is not itself NULL.
+ * Compare a branch with its upstream and report on their differences.
+ * If abf is ABF_FULL, save their differences (number of commits) in
+ * *num_ours and *num_theirs.
+ * If abf is ABF_QUICK, skip the (possibly expensive) ahead/behind
+ * computation (and leave *num_ours and *num_theirs undefined).
+ *
+ * The name of the upstream branch (or NULL if no upstream is defined) is
+ * returned via *upstream_name, if it is not itself NULL.
  *
  * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
- * upstream defined, or ref does not exist), 0 otherwise.
+ * upstream defined, or ref does not exist).
+ * Returns 0 if the commits are the same.
+ * Returns 1 if the commits are different (ahead, behind, or both).
  */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name)
+		       const char **upstream_name, enum ahead_behind_flags abf)
 {
 	struct object_id oid;
 	struct commit *ours, *theirs;
@@ -2019,6 +2025,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		*num_theirs = *num_ours = 0;
 		return 0;
 	}
+	if (abf == ABF_QUICK)
+		return 1;
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	argv_array_push(&argv, ""); /* ignored */
@@ -2051,7 +2059,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
 
 	argv_array_clear(&argv);
-	return 0;
+	return 1;
 }
 
 /*
@@ -2064,7 +2072,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	char *base;
 	int upstream_is_gone = 0;
 
-	if (stat_tracking_info(branch, &ours, &theirs, &full_base) < 0) {
+	if (stat_tracking_info(branch, &ours, &theirs, &full_base, ABF_FULL) < 0) {
 		if (!full_base)
 			return 0;
 		upstream_is_gone = 1;
diff --git a/remote.h b/remote.h
index 2ecf4c8..1e12dfb 100644
--- a/remote.h
+++ b/remote.h
@@ -255,9 +255,14 @@ enum match_refs_flags {
 	MATCH_REFS_FOLLOW_TAGS	= (1 << 3)
 };
 
+enum ahead_behind_flags {
+	ABF_QUICK = 0,  /* just eq/neq reporting */
+	ABF_FULL  = 1,  /* traditional ahead/behind reporting */
+};
+
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name);
+		       const char **upstream_name, enum ahead_behind_flags abf);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 struct ref *get_local_heads(void);
diff --git a/wt-status.c b/wt-status.c
index 94e5eba..80c23ba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1791,7 +1791,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base) < 0) {
+	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base, ABF_FULL) < 0) {
 		if (!base)
 			goto conclude;
 
@@ -1896,7 +1896,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 	const char *base;
 	const char *branch_name;
 	struct wt_status_state state;
-	int ab_info, nr_ahead, nr_behind;
+	int have_ab_info, nr_ahead, nr_behind;
 	char eol = s->null_termination ? '\0' : '\n';
 
 	memset(&state, 0, sizeof(state));
@@ -1928,13 +1928,14 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		/* Lookup stats on the upstream tracking branch, if set. */
 		branch = branch_get(branch_name);
 		base = NULL;
-		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
+		have_ab_info = (stat_tracking_info(branch, &nr_ahead,
+						   &nr_behind, &base, ABF_FULL) >= 0);
 		if (base) {
 			base = shorten_unambiguous_ref(base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
 			free((char *)base);
 
-			if (ab_info)
+			if (have_ab_info)
 				fprintf(s->fp, "# branch.ab +%d -%d%c", nr_ahead, nr_behind, eol);
 		}
 	}
-- 
2.9.3

