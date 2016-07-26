Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EA2203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbcGZVNy (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:13:54 -0400
Received: from siwi.pair.com ([209.68.5.199]:59222 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161003AbcGZVNs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:13:48 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 36A0584631;
	Tue, 26 Jul 2016 17:13:47 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>,
	Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v3 6/8] status: print branch info with --porcelain=v2 --branch
Date:	Tue, 26 Jul 2016 17:11:21 -0400
Message-Id: <1469567483-58794-7-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Expand porcelain v2 output to include branch and tracking
branch information.  This includes the commit SHA, the branch,
the upstream branch, and the ahead and behind counts.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <git@jeffhostetler.com>
---
 builtin/commit.c |  5 ++++
 wt-status.c      | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h      |  1 +
 3 files changed, 96 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 93ce28c..b1fd2d1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -510,6 +510,8 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->fp = fp;
 	s->nowarn = nowarn;
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
+	if (!s->is_initial)
+		hashcpy(s->sha1_commit, sha1);
 	s->status_format = status_format;
 	s->ignore_submodule_arg = ignore_submodule_arg;
 
@@ -1378,6 +1380,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	fd = hold_locked_index(&index_lock, 0);
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
+	if (!s.is_initial)
+		hashcpy(s.sha1_commit, sha1);
+
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	s.status_format = status_format;
 	s.verbose = verbose;
diff --git a/wt-status.c b/wt-status.c
index 46061d4..592fbd2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1814,6 +1814,92 @@ static void wt_porcelain_print(struct wt_status *s)
 }
 
 /*
+ * Print branch information for porcelain v2 output.  These lines
+ * are printed when the '--branch' parameter is given.
+ *
+ *    # branch.oid <commit><eol>
+ *    # branch.head <head><eol>
+ *   [# branch.upstream <upstream><eol>
+ *   [# branch.ab +<ahead> -<behind><eol>]]
+ *
+ *      <commit> ::= the current commit hash or the the literal
+ *                   "(initial)" to indicate an initialized repo
+ *                   with no commits.
+ *
+ *        <head> ::= <branch_name> the current branch name or
+ *                   "(detached)" literal when detached head or
+ *                   "(unknown)" when something is wrong.
+ *
+ *    <upstream> ::= the upstream branch name, when set.
+ *
+ *       <ahead> ::= integer ahead value, when upstream set
+ *                   and the commit is present (not gone).
+ *
+ *      <behind> ::= integer behind value, when upstream set
+ *                   and commit is present.
+ *
+ *
+ * The end-of-line is defined by the -z flag.
+ *
+ *                 <eol> ::= NUL when -z,
+ *                           LF when NOT -z.
+ *
+ */
+static void wt_porcelain_v2_print_tracking(struct wt_status *s)
+{
+	struct branch *branch;
+	const char *base;
+	const char *branch_name;
+	struct wt_status_state state;
+	int ab_info, nr_ahead, nr_behind;
+	char eol = s->null_termination ? '\0' : '\n';
+
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
+
+	fprintf(s->fp, "# branch.oid %s%c",
+			(s->is_initial ? "(initial)" : sha1_to_hex(s->sha1_commit)),
+			eol);
+
+	if (!s->branch)
+		fprintf(s->fp, "# branch.head %s%c", "(unknown)", eol);
+	else {
+		if (!strcmp(s->branch, "HEAD")) {
+			fprintf(s->fp, "# branch.head %s%c", "(detached)", eol);
+
+			if (state.rebase_in_progress || state.rebase_interactive_in_progress)
+				branch_name = state.onto;
+			else if (state.detached_from)
+				branch_name = state.detached_from;
+			else
+				branch_name = "";
+		} else {
+			branch_name = NULL;
+			skip_prefix(s->branch, "refs/heads/", &branch_name);
+
+			fprintf(s->fp, "# branch.head %s%c", branch_name, eol);
+		}
+
+		/* Lookup stats on the upstream tracking branch, if set. */
+		branch = branch_get(branch_name);
+		base = NULL;
+		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
+		if (base) {
+			base = shorten_unambiguous_ref(base, 0);
+			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
+			free((char *)base);
+
+			if (ab_info)
+				fprintf(s->fp, "# branch.ab +%d -%d%c", nr_ahead, nr_behind, eol);
+		}
+	}
+
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+}
+
+/*
  * Convert various submodule status values into a
  * fixed-length string of characters in the buffer provided.
  */
@@ -2057,6 +2143,7 @@ static void wt_porcelain_v2_print_other(
 /*
  * Print porcelain V2 status.
  *
+ * [<v2_branch>]
  * [<v2_changed_items>]*
  * [<v2_unmerged_items>]*
  * [<v2_untracked_items>]*
@@ -2069,6 +2156,9 @@ void wt_porcelain_v2_print(struct wt_status *s)
 	struct string_list_item *it;
 	int i;
 
+	if (s->show_branch)
+		wt_porcelain_v2_print_tracking(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		it = &(s->change.items[i]);
 		d = it->util;
diff --git a/wt-status.h b/wt-status.h
index 89a6d43..baedfe3 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -80,6 +80,7 @@ struct wt_status {
 	int hints;
 
 	enum wt_status_format status_format;
+	unsigned char sha1_commit[GIT_SHA1_RAWSZ]; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
-- 
2.8.0.rc4.17.gac42084.dirty

