Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F661F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbdLKON6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:13:58 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:34764 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbdLKONs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:13:48 -0500
Received: from lindisfarne.localdomain ([92.22.30.250])
        by smtp.talktalk.net with SMTP
        id OOpteDPs4CbAZOOq3eBivt; Mon, 11 Dec 2017 14:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513001627;
        bh=Iaro/Ok3x8iG2+RZngLhbwim2Ao6/i+XMtIG0eYQRAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=FcR6ALNuGAlubLQVxp91WjMHdF3nrhTSPOVF0gVM9b59oRXt8zppb7pUydbP5tGeI
         Hop+bjYuzcxZs7YQHnsdle7P9cLkg8xYRb9gSQ1xVJE1lXAjQKxqzFGHlFy/MsFTup
         uAX9n0RbEDkM/YTbmCS1rW/MWlxGn1aEALPIcKQ0=
X-Originating-IP: [92.22.30.250]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=hCO86xb6nvxPok+3LE1svw==:117
 a=hCO86xb6nvxPok+3LE1svw==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=0o2gBBPYjOzhW3oaBd4A:9 a=YJku6Dbm9i31fc1J:21 a=d8ba_cfY3pfL5CLH:21
 a=10xEi4siOC0A:10 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 5/9] commit: move print_commit_summary() to libgit
Date:   Mon, 11 Dec 2017 14:13:26 +0000
Message-Id: <20171211141330.23566-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171211141330.23566-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCOX2IO/S2ZIhDmBWeV7qA0J2H/kpLKDVanop7AemI5Ep5YQpWDdd8sGlClzebRFhe81anAtVH5eAAVMgyUA1XX28jJm+keIUvysUR3SW+HJJRptI/uc
 7apVDlkqTbXXlHun0PhbiYL0ZdQZoWSx8CXlZbnXP4HX8gVLy5w6fnh23cnyusyo8T83W4jLnipghLH5qNYv0ycV4LZj/Pr9//WguckC+nNzs8oRIgRw8stg
 2/iOybZ/6LIMMXSOOb6pC9FroIRBugfIDU/7NMsbJwkkZw0cTVb/Znncl5vRksbMNjJppctEtchCd47gVrMgBISZEw9WrDImR2YE00KC+CCvIluZKvCZTsEY
 JN2AJhYWQ7ggtBn/3aKXVfRcZMt2GX8EHOi0KobhfeT1TGkknI8=
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

If the sequencer dies in print_commit_summary() (which can only happen
when cherry-picking or reverting) then neither the todo list nor the
abort safety file are updated to reflect the commit that was just
made. print_commit_summary() can die if:

 - The commit that was just created cannot be found or parsed.

 - HEAD cannot be resolved either because some other process is
   updating it (which is bad news in the middle of a cherry-pick) or
   because it is corrupt.

 - log_tree_commit() cannot read some objects.

In all those cases dying will leave the sequencer in a sane state for
aborting; 'git cherry-pick --abort' will rewind HEAD to the last
successful commit before there was a problem with HEAD or the object
database. If the user somehow fixes the problem and runs 'git
cherry-pick --continue' then the sequencer will try and pick the same
commit again which may or may not be what the user wants depending on
what caused print_commit_summary() to die. If print_commit_summary()
returned an error instead then update_abort_safety_file() would try to
resolve HEAD which may or may not be successful. If it is successful
then running 'git rebase --abort' would not rewind HEAD to the last
successful commit which is not what we want.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - expanded commit message to explain why it is ok to die in
       print_commit_summary() and dropped the next patch which made it
       return an error instead.
     - style fixes.
    
    changes since v1:
     - convert flags passed to print_commit_summary() to unsigned int

 builtin/commit.c | 128 ++++---------------------------------------------------
 sequencer.c      | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |   5 +++
 3 files changed, 133 insertions(+), 119 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d376d282cda95d491f2fcbee5063709d02aed77a..0f78958c89cdd91c54f0154102b08e1a8121cce0 100644
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
@@ -1374,98 +1349,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
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
@@ -1727,8 +1610,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(current_head, &oid);
 	}
-	if (!quiet)
-		print_summary(prefix, &oid, !current_head);
+	if (!quiet) {
+		unsigned int flags = 0;
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
index 132319be0dbc15ed34f87af769235a4c6f3c6159..b4ff2a4a973b2733cca7bb65fcb7947cb8d08988 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -837,6 +837,125 @@ void commit_post_rewrite(const struct commit *old_head,
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
+			  unsigned int flags)
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
+
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
+	printf("[%s%s ", head, (flags & SUMMARY_INITIAL_COMMIT) ?
+						_(" (root-commit)") : "");
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
index e97fb288498bf524e43db4217087cb66682fad52..bf72e339adbb81900283d8811ed51569aa3e05ee 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -74,4 +74,9 @@ int update_head_with_reflog(const struct commit *old_head,
 			    struct strbuf *err);
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
+
+#define SUMMARY_INITIAL_COMMIT   (1 << 0)
+#define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
+void print_commit_summary(const char *prefix, const struct object_id *oid,
+			  unsigned int flags);
 #endif
-- 
2.15.1

