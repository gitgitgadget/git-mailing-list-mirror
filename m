Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3965220281
	for <e@80x24.org>; Mon, 25 Sep 2017 10:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934559AbdIYKL1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 06:11:27 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:6263 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934434AbdIYKLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 06:11:15 -0400
Received: from lindisfarne.localdomain ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id wQLndvDfQbjdZwQM4dIVIh; Mon, 25 Sep 2017 11:11:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1506334274; bh=bSRR3zobmU18ONf4b2WJjY0kimzPLM9SynMraNo7CRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=IcfgOFWxgLpEu8qfc7AdZ6Lh0WnrxJQOJsWFv2Iu8vRGE7oUDJu2QAUori7eGdart
         MmY9GISXpiTv34x5onoa6ADNGdhGhNRFht+7JiWPyVfCMKXCJoQj8hqqdkhWM3RdEW
         To+rrAqvIrS6bA+cfA4qiEA9T32RJH3HofcN57Jw=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=6UQaZ2ApgGGEfPE4JckA:9 a=O0TJxjolashYLJEw:21 a=tzRq636rJr26ACIg:21
 a=10xEi4siOC0A:10 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 5/8] commit: move print_commit_summary() to libgit
Date:   Mon, 25 Sep 2017 11:10:38 +0100
Message-Id: <20170925101041.18344-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170925101041.18344-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfP04GRSgTBkwlNqmiTaeeu7CGO43b4lzVQkVTgZk1B0VioaLC+nVAA3gF5FLzU5RTRTJc2kSZxRLKu/ozpQgTqP6iUsxxh6ZwL2wifLX2I6WrpoK+ssp
 /ktoLNnon35v2rVlFvwvgXLubeExZqRfFHKOu4dOUY1XVKqj24M1orKBpoeBsKc26sIMiBCkm8M1HhuLs2sqWb8rCY1c4f0Fs6hRNDrCwN1cibS9m6RBLRTe
 Q+DhsdUV4tgxsFZyPoFIWZHxFSTppKGfcO8H+mMVuBE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 126 ++++---------------------------------------------------
 sequencer.c      | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |   5 +++
 3 files changed, 129 insertions(+), 118 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9d621098823d196643180226491e43c806154c13..fac392216c4dc4d4a2b9fbee1d9ee14da0a14209 100644
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
@@ -1343,97 +1318,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
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
-	struct object_id junk_oid;
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
-	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
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
@@ -1694,9 +1578,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(current_head, &oid);
 	}
-	if (!quiet)
-		print_summary(prefix, &oid, !current_head);
+	if (!quiet) {
+		int flags = 0;
 
+		if (!current_head)
+			flags|= SUMMARY_INITIAL_COMMIT;
+		if (author_date_is_interesting())
+			flags |= SUMMARY_SHOW_AUTHOR_DATE;
+		print_commit_summary(prefix, &oid, flags);
+	}
 	strbuf_release(&err);
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 81bd0810df6bcf2e078abc220bb8984345bf467f..65031353f01d75624951222c2de280c427e26ac5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -832,6 +832,122 @@ void commit_post_rewrite(const struct commit *old_head,
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
+	struct object_id junk_oid;
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
+	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
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
index 45def684ad751d0b8dc62b6cfdfb819ddf183c89..d491f5cae2e6152859d114a08bbd7c935d1e80a6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -64,4 +64,9 @@ int update_head(const struct commit *old_head, const struct object_id *new_head,
 		const struct strbuf *msg, struct strbuf *err);
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
+
+#define SUMMARY_INITIAL_COMMIT   (1 << 0)
+#define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
+void print_commit_summary(const char *prefix, const struct object_id *oid,
+			  int flags);
 #endif
-- 
2.14.1

