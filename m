Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_BLACK shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DBE3202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbdKFLbG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:31:06 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:15362 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbdKFL3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:29:05 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id BfYqeiZ2C3CyHBfZyewtwN; Mon, 06 Nov 2017 11:28:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509967738; bh=Gf25+fX1OVzFZxP8CuHNU+islZTU1aOXmZxeJLDCWkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=FhzaSvquiRmbCbcwi6SrIANkr9HnDF3K19IAwpITlqp7oRc7QoB7lGdJV7ffhO7qC
         ZYyz9QkcIumFvIXeLfGsC68Y6cEV9CTighzdw0lsKSy1YZctXXOHlC71+taDQuIdn9
         EPUiJoMQfdOP6i8hmitUIFOyuIGGa2TMkftpJC5k=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=6UQaZ2ApgGGEfPE4JckA:9 a=uK6MvomN3SrH8T2P:21 a=8aduUHzUAkW3MI1V:21
 a=10xEi4siOC0A:10 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 4/8] commit: move print_commit_summary() to libgit
Date:   Mon,  6 Nov 2017 11:27:05 +0000
Message-Id: <20171106112709.2121-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171106112709.2121-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfO/dslwSE2GiRRCm+DAmQCn2P9on2wBEqN5QJd0Z4K9ELEJQJ9zpTdIlMhg3vyP97Nay90pE9rnFVwOaxr7FuYZG7Uk8xw6qew9PnGJPyp3VO8bJMU/6
 /U9WKHWnQr8Awjacr1abNhfTxzuK4y3K/xR1D8oJ5glXS075cCo3Uj5XS5Adq2cg58Gf5WgSLRPcMXphVP2vW/jbDuu82lFtdR8aX6+qVjiTx8fuEFy+KZam
 rjGHE3Tn7/5cxoLEESGe2UxGdlr0FGQkhkZxMytIBdRyOsYwazP3a6s/a92RAJwZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move print_commit_summary() from builtin/commit.c to sequencer.c so it
can be shared with other commands. The function is modified by
changing the last argument to a flag so callers can specify whether
they want to show the author date in addition to specifying if this is
an initial commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 128 ++++---------------------------------------------------
 sequencer.c      | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |   5 +++
 3 files changed, 131 insertions(+), 119 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4f0092b91b9553855fe16864b16b7779b7d1f330..b109feaca11e3e43b1a59dee1868244824eaf345 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -43,31 +43,6 @@ static const char * const builtin_status_usage[] = {
 	NULL
 };
 
-static const char implicit_ident_advice_noconfig[] =
-N_("Your name and email address were configured automatically based\n"
-"on your username and hostname. Please check that they are accurate.\n"
-"You can suppress this message by setting them explicitly. Run the\n"
-"following command and follow the instructions in your editor to edit\n"
-"your configuration file:\n"
-"\n"
-"    git config --global --edit\n"
-"\n"
-"After doing this, you may fix the identity used for this commit with:\n"
-"\n"
-"    git commit --amend --reset-author\n");
-
-static const char implicit_ident_advice_config[] =
-N_("Your name and email address were configured automatically based\n"
-"on your username and hostname. Please check that they are accurate.\n"
-"You can suppress this message by setting them explicitly:\n"
-"\n"
-"    git config --global user.name \"Your Name\"\n"
-"    git config --global user.email you@example.com\n"
-"\n"
-"After doing this, you may fix the identity used for this commit with:\n"
-"\n"
-"    git commit --amend --reset-author\n");
-
 static const char empty_amend_advice[] =
 N_("You asked to amend the most recent commit, but doing so would make\n"
 "it empty. You can repeat your command with --allow-empty, or you can\n"
@@ -1370,98 +1345,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static const char *implicit_ident_advice(void)
-{
-	char *user_config = expand_user_path("~/.gitconfig", 0);
-	char *xdg_config = xdg_config_home("config");
-	int config_exists = file_exists(user_config) || file_exists(xdg_config);
-
-	free(user_config);
-	free(xdg_config);
-
-	if (config_exists)
-		return _(implicit_ident_advice_config);
-	else
-		return _(implicit_ident_advice_noconfig);
-
-}
-
-static void print_summary(const char *prefix, const struct object_id *oid,
-			  int initial_commit)
-{
-	struct rev_info rev;
-	struct commit *commit;
-	struct strbuf format = STRBUF_INIT;
-	const char *head;
-	struct pretty_print_context pctx = {0};
-	struct strbuf author_ident = STRBUF_INIT;
-	struct strbuf committer_ident = STRBUF_INIT;
-
-	commit = lookup_commit(oid);
-	if (!commit)
-		die(_("couldn't look up newly created commit"));
-	if (parse_commit(commit))
-		die(_("could not parse newly created commit"));
-
-	strbuf_addstr(&format, "format:%h] %s");
-
-	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
-	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
-	if (strbuf_cmp(&author_ident, &committer_ident)) {
-		strbuf_addstr(&format, "\n Author: ");
-		strbuf_addbuf_percentquote(&format, &author_ident);
-	}
-	if (author_date_is_interesting()) {
-		struct strbuf date = STRBUF_INIT;
-		format_commit_message(commit, "%ad", &date, &pctx);
-		strbuf_addstr(&format, "\n Date: ");
-		strbuf_addbuf_percentquote(&format, &date);
-		strbuf_release(&date);
-	}
-	if (!committer_ident_sufficiently_given()) {
-		strbuf_addstr(&format, "\n Committer: ");
-		strbuf_addbuf_percentquote(&format, &committer_ident);
-		if (advice_implicit_identity) {
-			strbuf_addch(&format, '\n');
-			strbuf_addstr(&format, implicit_ident_advice());
-		}
-	}
-	strbuf_release(&author_ident);
-	strbuf_release(&committer_ident);
-
-	init_revisions(&rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
-
-	rev.diff = 1;
-	rev.diffopt.output_format =
-		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
-
-	rev.verbose_header = 1;
-	rev.show_root_diff = 1;
-	get_commit_format(format.buf, &rev);
-	rev.always_show_header = 0;
-	rev.diffopt.detect_rename = 1;
-	rev.diffopt.break_opt = 0;
-	diff_setup_done(&rev.diffopt);
-
-	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!head)
-		die_errno(_("unable to resolve HEAD after creating commit"));
-	if (!strcmp(head, "HEAD"))
-		head = _("detached HEAD");
-	else
-		skip_prefix(head, "refs/heads/", &head);
-	printf("[%s%s ", head, initial_commit ? _(" (root-commit)") : "");
-
-	if (!log_tree_commit(&rev, commit)) {
-		rev.always_show_header = 1;
-		rev.use_terminator = 1;
-		log_tree_commit(&rev, commit);
-	}
-
-	strbuf_release(&format);
-}
-
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s = cb;
@@ -1722,8 +1605,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(current_head, &oid);
 	}
-	if (!quiet)
-		print_summary(prefix, &oid, !current_head);
+	if (!quiet) {
+		int flags = 0;
+
+		if (!current_head)
+			flags |= SUMMARY_INITIAL_COMMIT;
+		if (author_date_is_interesting())
+			flags |= SUMMARY_SHOW_AUTHOR_DATE;
+		print_commit_summary(prefix, &oid, flags);
+	}
 
 	UNLEAK(err);
 	UNLEAK(sb);
diff --git a/sequencer.c b/sequencer.c
index 6d9e393f8368ac03d92019189f9fccd6a3ba1d77..d4f77a5f24c89479a4a18c2b89a3cd4e7ba7ba6c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -834,6 +834,123 @@ void commit_post_rewrite(const struct commit *old_head,
 	run_rewrite_hook(&old_head->object.oid, new_head);
 }
 
+static const char implicit_ident_advice_noconfig[] =
+N_("Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n"
+"You can suppress this message by setting them explicitly. Run the\n"
+"following command and follow the instructions in your editor to edit\n"
+"your configuration file:\n"
+"\n"
+"    git config --global --edit\n"
+"\n"
+"After doing this, you may fix the identity used for this commit with:\n"
+"\n"
+"    git commit --amend --reset-author\n");
+
+static const char implicit_ident_advice_config[] =
+N_("Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n"
+"You can suppress this message by setting them explicitly:\n"
+"\n"
+"    git config --global user.name \"Your Name\"\n"
+"    git config --global user.email you@example.com\n"
+"\n"
+"After doing this, you may fix the identity used for this commit with:\n"
+"\n"
+"    git commit --amend --reset-author\n");
+
+static const char *implicit_ident_advice(void)
+{
+	char *user_config = expand_user_path("~/.gitconfig", 0);
+	char *xdg_config = xdg_config_home("config");
+	int config_exists = file_exists(user_config) || file_exists(xdg_config);
+
+	free(user_config);
+	free(xdg_config);
+
+	if (config_exists)
+		return _(implicit_ident_advice_config);
+	else
+		return _(implicit_ident_advice_noconfig);
+
+}
+
+void print_commit_summary(const char *prefix, const struct object_id *oid,
+			  int flags)
+{
+	struct rev_info rev;
+	struct commit *commit;
+	struct strbuf format = STRBUF_INIT;
+	const char *head;
+	struct pretty_print_context pctx = {0};
+	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf committer_ident = STRBUF_INIT;
+
+	commit = lookup_commit(oid);
+	if (!commit)
+		die(_("couldn't look up newly created commit"));
+	if (parse_commit(commit))
+		die(_("could not parse newly created commit"));
+
+	strbuf_addstr(&format, "format:%h] %s");
+
+	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
+	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
+	if (strbuf_cmp(&author_ident, &committer_ident)) {
+		strbuf_addstr(&format, "\n Author: ");
+		strbuf_addbuf_percentquote(&format, &author_ident);
+	}
+	if (flags & SUMMARY_SHOW_AUTHOR_DATE) {
+		struct strbuf date = STRBUF_INIT;
+		format_commit_message(commit, "%ad", &date, &pctx);
+		strbuf_addstr(&format, "\n Date: ");
+		strbuf_addbuf_percentquote(&format, &date);
+		strbuf_release(&date);
+	}
+	if (!committer_ident_sufficiently_given()) {
+		strbuf_addstr(&format, "\n Committer: ");
+		strbuf_addbuf_percentquote(&format, &committer_ident);
+		if (advice_implicit_identity) {
+			strbuf_addch(&format, '\n');
+			strbuf_addstr(&format, implicit_ident_advice());
+		}
+	}
+	strbuf_release(&author_ident);
+	strbuf_release(&committer_ident);
+
+	init_revisions(&rev, prefix);
+	setup_revisions(0, NULL, &rev, NULL);
+
+	rev.diff = 1;
+	rev.diffopt.output_format =
+		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
+
+	rev.verbose_header = 1;
+	rev.show_root_diff = 1;
+	get_commit_format(format.buf, &rev);
+	rev.always_show_header = 0;
+	rev.diffopt.detect_rename = 1;
+	rev.diffopt.break_opt = 0;
+	diff_setup_done(&rev.diffopt);
+
+	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	if (!head)
+		die_errno(_("unable to resolve HEAD after creating commit"));
+	if (!strcmp(head, "HEAD"))
+		head = _("detached HEAD");
+	else
+		skip_prefix(head, "refs/heads/", &head);
+	printf("[%s%s ", head, (flags & SUMMARY_INITIAL_COMMIT) ? _(" (root-commit)") : "");
+
+	if (!log_tree_commit(&rev, commit)) {
+		rev.always_show_header = 1;
+		rev.use_terminator = 1;
+		log_tree_commit(&rev, commit);
+	}
+
+	strbuf_release(&format);
+}
+
 static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
diff --git a/sequencer.h b/sequencer.h
index 5734c8a3d869564354e5193c52bf45c119a8b840..c7989f93fcf08f979f5869cd4ec27f0dd0b88c82 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -73,4 +73,9 @@ int update_head(const struct commit *old_head, const struct object_id *new_head,
 		struct strbuf *err);
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
+
+#define SUMMARY_INITIAL_COMMIT   (1 << 0)
+#define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
+void print_commit_summary(const char *prefix, const struct object_id *oid,
+			  int flags);
 #endif
-- 
2.14.3

