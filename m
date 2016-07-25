Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F69203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 19:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbcGYT27 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 15:28:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:27502 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867AbcGYT25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 15:28:57 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 2A13F8460E;
	Mon, 25 Jul 2016 15:28:55 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com,
	jeffhost@microsoft.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 6/8] status: print branch info with --porcelain=v2 --branch
Date:	Mon, 25 Jul 2016 15:25:48 -0400
Message-Id: <1469474750-49075-7-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Expand porcelain v2 output to include branch and tracking
branch information.  This includes the commit SHA, the branch,
the upstream branch, and the ahead and behind counts.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/commit.c |  5 ++++
 wt-status.c      | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h      |  1 +
 3 files changed, 92 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5b9efd2..ebb43dd 100644
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
index ffdfe11..39eef4b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1889,6 +1889,88 @@ void wt_status_print(struct wt_status *s)
 }
 
 /*
+ * Print branch and tracking header for porcelain v2 output.
+ * This is printed when the '--branch' parameter is given.
+ *
+ *    "## branch: <commit> <head>[ <upstream>[ +<ahead> -<behind>]]<eol>"
+ *
+ *              <commit> ::= the current commit hash or the the literal
+ *                           "(initial)" to indicate an initialized repo
+ *                           with no commits.
+ *
+ *                <head> ::= <branch_name> the current branch name or
+ *                           "(detached)" literal when detached head or
+ *                           "(unknown)" when something is wrong.
+ *
+ *            <upstream> ::= the upstream branch name, when set.
+ *
+ *               <ahead> ::= integer ahead value, when upstream set
+ *                           and commit is present.
+ *
+ *              <behind> ::= integer behind value, when upstream set
+ *                           and commit is present.
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
+
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
+
+	fprintf(s->fp, "## branch:");
+	fprintf(s->fp, " %s",
+		(s->is_initial ? "(initial)" : sha1_to_hex(s->sha1_commit)));
+
+	if (!s->branch)
+		fprintf(s->fp, " %s", "(unknown)");
+	else {
+		if (!strcmp(s->branch, "HEAD")) {
+			fprintf(s->fp, " %s", "(detached)");
+			if (state.rebase_in_progress || state.rebase_interactive_in_progress)
+				branch_name = state.onto;
+			else if (state.detached_from)
+				branch_name = state.detached_from;
+			else
+				branch_name = "";
+		} else {
+			branch_name = NULL;
+			skip_prefix(s->branch, "refs/heads/", &branch_name);
+			fprintf(s->fp, " %s", branch_name);
+		}
+
+		/* Lookup stats on the upstream tracking branch, if set. */
+		branch = branch_get(branch_name);
+		base = NULL;
+		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
+		if (base) {
+			base = shorten_unambiguous_ref(base, 0);
+			fprintf(s->fp, " %s", base);
+			free((char *)base);
+
+			if (ab_info)
+				fprintf(s->fp, " +%d -%d", nr_ahead, nr_behind);
+		}
+	}
+
+	fprintf(s->fp, "%c", (s->null_termination ? '\0' : '\n'));
+
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+}
+
+/*
  * Convert various submodule status values into a
  * string of characters in the buffer provided.
  */
@@ -2132,6 +2214,7 @@ static void wt_porcelain_v2_print_other(
 /*
  * Print porcelain V2 status.
  *
+ * [<v2_branch>]
  * [<v2_changed_items>]*
  * [<v2_unmerged_items>]*
  * [<v2_untracked_items>]*
@@ -2144,6 +2227,9 @@ void wt_porcelain_v2_print(struct wt_status *s)
 	struct string_list_item *it;
 	int i;
 
+	if (s->show_branch)
+		wt_porcelain_v2_print_tracking(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		it = &(s->change.items[i]);
 		d = it->util;
diff --git a/wt-status.h b/wt-status.h
index f2cb65d..99f2879 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -93,6 +93,7 @@ struct wt_status {
 	int hints;
 
 	enum wt_status_format status_format;
+	unsigned char sha1_commit[GIT_SHA1_RAWSZ]; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
-- 
2.8.0.rc4.17.gac42084.dirty

