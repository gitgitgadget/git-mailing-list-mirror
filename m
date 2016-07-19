Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE35202F3
	for <e@80x24.org>; Tue, 19 Jul 2016 22:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcGSWNg (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 18:13:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:20834 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbcGSWNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 18:13:33 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 4842184638;
	Tue, 19 Jul 2016 18:13:32 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, gitster@pobox.com, jeffhost@microsoft.com
Subject: [PATCH v1 4/6] Expanded branch header for Porcelain Status V2
Date:	Tue, 19 Jul 2016 18:10:56 -0400
Message-Id: <1468966258-11191-5-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This commit expand porcelain status V2 to print
detailed information about the current branch.
This includes the SHA of the current commit, the
current branch name, the upstream branch name,
and the ahead/behind counts.

This additional information is included when
the --branch argument is given.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/commit.c |  5 ++++
 wt-status.c      | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h      |  2 ++
 3 files changed, 96 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index b5ec9b9..830f688 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -512,6 +512,8 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->fp = fp;
 	s->nowarn = nowarn;
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
+	if (!s->is_initial)
+		hashcpy(s->sha_commit, sha1);
 	s->status_format = status_format;
 
 	wt_status_collect(s);
@@ -1397,6 +1399,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	fd = hold_locked_index(&index_lock, 0);
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
+	if (!s.is_initial)
+		hashcpy(s.sha_commit, sha1);
+
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	s.status_format = status_format;
 
diff --git a/wt-status.c b/wt-status.c
index 2d4829e..9ba4da5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1847,6 +1847,92 @@ void wt_porcelain_print(struct wt_status *s)
 	wt_shortstatus_print(s);
 }
 
+/*
+ * Print branch and tracking header for porcelain v2 output.
+ * This is printed when the '--branch' parameter is given.
+ *
+ *    "## branch: <commit> <head>[ <upstream>[ +<ahead> -<behind>]]<eol>"
+ *
+ *              <commit> ::= 40 character SHA1 of the current commit or
+ *                           "(initial)" literal to indicate initialized
+ *                           repo with no commits.
+ *
+ *                <head> ::= <branch_name> the current branch name or
+ *                           "(detached)" literal when detached head.
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
+		(s->is_initial ? "(initial)" : sha1_to_hex(s->sha_commit)));
+
+	if (s->branch) {
+		if (!strcmp(s->branch, "HEAD")) {
+			fprintf(s->fp, " %s", "(detached)");
+			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
+				branch_name = state.onto;
+			} else if (state.detached_from) {
+				branch_name = state.detached_from;
+			} else {
+				branch_name = "";
+			}
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
+	} else {
+		/*
+		 * TODO All of various print routines allow for s->branch to be null.
+		 * TODO When can this happen and what should we report here?
+		 */
+		fprintf(s->fp, " %s", "(unknown)");
+	}
+
+	fprintf(s->fp, "%c", (s->null_termination ? '\0' : '\n'));
+
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+}
+
 /* Convert various submodule status values into a
  * string of characters in the buffer provided.
  */
@@ -2122,6 +2208,9 @@ void wt_porcelain_v2_print(struct wt_status *s)
 {
 	int i;
 
+	if (s->show_branch)
+		wt_porcelain_v2_print_tracking(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
diff --git a/wt-status.h b/wt-status.h
index c062e30..168556f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -88,6 +88,8 @@ struct wt_status {
 	int hints;
 
 	enum wt_status_format status_format;
+	unsigned char sha_commit[GIT_SHA1_RAWSZ]; /* Commit SHA (when not Initial) */
+
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
-- 
2.8.0.rc4.17.gac42084.dirty

