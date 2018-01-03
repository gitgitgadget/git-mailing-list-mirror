Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9541F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeACVrr (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:47:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:65514 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbeACVrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:47:45 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7FEA6844E0;
        Wed,  3 Jan 2018 16:47:44 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 18D7E844DC;
        Wed,  3 Jan 2018 16:47:44 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 1/5] stat_tracking_info: return +1 when branches not equal
Date:   Wed,  3 Jan 2018 21:47:29 +0000
Message-Id: <20180103214733.797-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180103214733.797-1-git@jeffhostetler.com>
References: <20180103214733.797-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Extend stat_tracking_info() to return +1 when branches are not equal and to
take a new "enum ahead_behind_flags" argument to allow skipping the (possibly
expensive) ahead/behind computation.

This will be used in the next commit to allow "git status" to avoid full
ahead/behind calculations for performance reasons.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 ref-filter.c |  8 ++++----
 remote.c     | 26 ++++++++++++++++++--------
 remote.h     |  8 +++++++-
 wt-status.c  |  6 ++++--
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e728b15..23bcdc4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1238,8 +1238,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 	if (atom->u.remote_ref.option == RR_REF)
 		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
-		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL)) {
+		if (stat_tracking_info(branch, &num_ours, &num_theirs,
+				       NULL, AHEAD_BEHIND_FULL) < 0) {
 			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
 			*s = "";
@@ -1256,8 +1256,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			free((void *)to_free);
 		}
 	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
-		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+		if (stat_tracking_info(branch, &num_ours, &num_theirs,
+				       NULL, AHEAD_BEHIND_FULL) < 0)
 			return;
 
 		if (!num_ours && !num_theirs)
diff --git a/remote.c b/remote.c
index b220f0d..ca5a416 100644
--- a/remote.c
+++ b/remote.c
@@ -1977,16 +1977,23 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 }
 
 /*
- * Compare a branch with its upstream, and save their differences (number
- * of commits) in *num_ours and *num_theirs. The name of the upstream branch
- * (or NULL if no upstream is defined) is returned via *upstream_name, if it
- * is not itself NULL.
+ * Lookup the upstream branch for the given branch and if present, optionally
+ * compute the commit ahead/behind values for the pair.
+ *
+ * If abf is AHEAD_BEHIND_FULL, compute the full ahead/behind and return the
+ * counts in *num_ours and *num_theirs.  If abf is AHEAD_BEHIND_QUICK, skip
+ * the (potentially expensive) a/b computation (*num_ours and *num_theirs are
+ * left undefined).
+ *
+ * The name of the upstream branch (or NULL if no upstream is defined) is
+ * returned via *upstream_name, if it is not itself NULL.
  *
  * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
- * upstream defined, or ref does not exist), 0 otherwise.
+ * upstream defined, or ref does not exist).  Returns 0 if the commits are
+ * identical.  Returns 1 if commits are different.
  */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name)
+		       const char **upstream_name, enum ahead_behind_flags abf)
 {
 	struct object_id oid;
 	struct commit *ours, *theirs;
@@ -2019,6 +2026,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		*num_theirs = *num_ours = 0;
 		return 0;
 	}
+	if (abf == AHEAD_BEHIND_QUICK)
+		return 1;
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	argv_array_push(&argv, ""); /* ignored */
@@ -2051,7 +2060,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
 
 	argv_array_clear(&argv);
-	return 0;
+	return 1;
 }
 
 /*
@@ -2064,7 +2073,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	char *base;
 	int upstream_is_gone = 0;
 
-	if (stat_tracking_info(branch, &ours, &theirs, &full_base) < 0) {
+	if (stat_tracking_info(branch, &ours, &theirs, &full_base,
+			       AHEAD_BEHIND_FULL) < 0) {
 		if (!full_base)
 			return 0;
 		upstream_is_gone = 1;
diff --git a/remote.h b/remote.h
index 2ecf4c8..00932f5 100644
--- a/remote.h
+++ b/remote.h
@@ -255,9 +255,15 @@ enum match_refs_flags {
 	MATCH_REFS_FOLLOW_TAGS	= (1 << 3)
 };
 
+/* Flags for --ahead-behind option. */
+enum ahead_behind_flags {
+	AHEAD_BEHIND_QUICK = 0,  /* just eq/neq reporting */
+	AHEAD_BEHIND_FULL  = 1,  /* traditional a/b reporting */
+};
+
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name);
+		       const char **upstream_name, enum ahead_behind_flags abf);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 struct ref *get_local_heads(void);
diff --git a/wt-status.c b/wt-status.c
index 94e5eba..8f7fdc6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1791,7 +1791,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base) < 0) {
+	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base,
+			       AHEAD_BEHIND_FULL) < 0) {
 		if (!base)
 			goto conclude;
 
@@ -1928,7 +1929,8 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		/* Lookup stats on the upstream tracking branch, if set. */
 		branch = branch_get(branch_name);
 		base = NULL;
-		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
+		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind,
+					      &base, AHEAD_BEHIND_FULL) >= 0);
 		if (base) {
 			base = shorten_unambiguous_ref(base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
-- 
2.9.3

