Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE521F404
	for <e@80x24.org>; Wed, 13 Dec 2017 11:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbdLMLqj (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 06:46:39 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:3967 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdLMLqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 06:46:38 -0500
Received: from lindisfarne.localdomain ([92.22.15.141])
        by smtp.talktalk.net with SMTP
        id P5Uae8bdsbjdZP5UheRELe; Wed, 13 Dec 2017 11:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513165596;
        bh=0i25Ykmp7hYiwkJkWbr5cnIFowisJEOHCSCArsQzZFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Tb2G5GmQZ4oUVn5xiaYCiwsh+bmvZ6QtP7F9EmuHze4sIsmkPztihMV/VwO/ll87d
         B6OJg2NM1QosSh+PrtqNoiAo0FBUjlXN91xW6ZlgKzTeGtGed/hCdji+69funkqm9c
         HFS1okawisje5REzCfIBc2Su50b84RWKhQnXVDM8=
X-Originating-IP: [92.22.15.141]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=GtR6SX75q4uFXsZmIa626w==:117
 a=GtR6SX75q4uFXsZmIa626w==:17 a=evINK-nbAAAA:8 a=mmkzuikSo1YOMf3xSZ0A:9
 a=NGXZNMTylMvnupn3:21 a=TWMsmX4pV3R21y5S:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] sequencer: improve config handling
Date:   Wed, 13 Dec 2017 11:46:21 +0000
Message-Id: <20171213114621.30250-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNQ6hy5caG3OhRIhDlwBccmmcj97cqX+nvTYcgnBk2aj8auLbOJ0lpUX/Bc4c1KbBN2Dpj0k2hFVnkxbD3j0IVyTG03P7GZIbNCWsqht54bHpFoXseTy
 4UyNdUppBPG+L9T1ii89pSpbWRGtMO4g6sMd8MW6O3SoHUJDQyaJnupUtKrdf4XMjSzen0/61n7mvS34ndQKris2e0SYfOjzIXwZa38C4QnUZT3cgKt4mNt0
 /qOsKLuqDst7E2jZjGYJ/ysef6VrsWpTnqiRVYILQ1zuCCms+6PMXu72wfaWiatH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The previous config handling relied on global variables, called
git_default_config() even when the key had already been handled by
git_sequencer_config() and did not initialize the diff configuration
variables. Improve this by: i) loading the default values for message
cleanup and gpg signing of commits into struct replay_opts;
ii) restructuring the code to return immediately once a key is
handled; and iii) calling git_diff_basic_config(). Note that
unfortunately it is not possible to return early if the key is handled
by git_gpg_config() as it does not indicate to the caller if the key
has been handled or not.

The sequencer should probably have been calling
git_diff_basic_config() before as it creates a patch when there are
conflicts. The shell version uses 'diff-tree' to create the patch so
calling git_diff_basic_config() should match that. Although 'git
commit' calls git_diff_ui_config() I don't think the output of
print_commit_summary() is affected by anything that is loaded by that
as print_commit_summary() always turns on rename detection so would
ignore the value in the user's configuration anyway. The other values
loaded by git_diff_ui_config() are about the formatting of patches so
are not relevant to print_commit_summary().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase--helper.c | 13 +-------
 builtin/revert.c         | 15 ++-------
 sequencer.c              | 87 ++++++++++++++++++++++++++----------------------
 sequencer.h              | 19 ++++++-----
 4 files changed, 61 insertions(+), 73 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 68194d3aed950f327a8bc624fa1991478dfea01e..decb8f7a09e42eb94bed264164985e54e13a32f6 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -9,17 +9,6 @@ static const char * const builtin_rebase_helper_usage[] = {
 	NULL
 };
 
-static int git_rebase_helper_config(const char *k, const char *v, void *cb)
-{
-	int status;
-
-	status = git_sequencer_config(k, v, NULL);
-	if (status)
-		return status;
-
-	return git_default_config(k, v, NULL);
-}
-
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
@@ -50,7 +39,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_rebase_helper_config, NULL);
+	sequencer_init_config(&opts);
 
 	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
diff --git a/builtin/revert.c b/builtin/revert.c
index 1938825efa6ad20ede5aba57f097863aeb33d1d5..76f0a35b074b858ab4cb3e3894bc7c877401b7e8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -31,17 +31,6 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int common_config(const char *k, const char *v, void *cb)
-{
-	int status;
-
-	status = git_sequencer_config(k, v, NULL);
-	if (status)
-		return status;
-
-	return git_default_config(k, v, NULL);
-}
-
 static const char *action_name(const struct replay_opts *opts)
 {
 	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
@@ -219,7 +208,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
-	git_config(common_config, NULL);
+	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
@@ -232,7 +221,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	opts.action = REPLAY_PICK;
-	git_config(common_config, NULL);
+	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
diff --git a/sequencer.c b/sequencer.c
index 0f17b4d32580aa637ddfeedfaec68468a9995e3d..c3035bb5f3d8bb1c6a6be8f3bc8d1bb29cf4383c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -132,6 +132,51 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 
+static int git_sequencer_config(const char *k, const char *v, void *cb)
+{
+	struct replay_opts *opts = cb;
+	int status;
+
+	if (!strcmp(k, "commit.cleanup")) {
+		const char *s;
+
+		status = git_config_string(&s, k, v);
+		if (status)
+			return status;
+
+		if (!strcmp(s, "verbatim"))
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
+		else if (!strcmp(s, "whitespace"))
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
+		else if (!strcmp(s, "strip"))
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
+		else if (!strcmp(s, "scissors"))
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
+		else
+			warning(_("invalid commit message cleanup mode '%s'"),
+				  s);
+
+		return status;
+	}
+
+	if (!strcmp(k, "commit.gpgsign")) {
+		opts->gpg_sign = git_config_bool(k, v) ? "" : NULL;
+		return 0;
+	}
+
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
+
+	return git_diff_basic_config(k, v, NULL);
+}
+
+void sequencer_init_config(struct replay_opts *opts)
+{
+	opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
+	git_config(git_sequencer_config, opts);
+}
+
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
 	return opts->action == REPLAY_INTERACTIVE_REBASE;
@@ -703,40 +748,6 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	return run_command(&cmd);
 }
 
-static enum commit_msg_cleanup_mode default_msg_cleanup =
-						COMMIT_MSG_CLEANUP_NONE;
-static char *default_gpg_sign;
-
-int git_sequencer_config(const char *k, const char *v, void *cb)
-{
-	if (!strcmp(k, "commit.cleanup")) {
-		int status;
-		const char *s;
-
-		status = git_config_string(&s, k, v);
-		if (status)
-			return status;
-
-		if (!strcmp(s, "verbatim"))
-			default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
-		else if (!strcmp(s, "whitespace"))
-			default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else if (!strcmp(s, "strip"))
-			default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
-		else if (!strcmp(s, "scissors"))
-			default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-
-		return status;
-	}
-
-	if (!strcmp(k, "commit.gpgsign")) {
-		default_gpg_sign = git_config_bool(k, v) ? "" : NULL;
-		return 0;
-	}
-
-	return git_gpg_config(k, v, NULL);
-}
-
 static int rest_is_empty(const struct strbuf *sb, int start)
 {
 	int i, eol;
@@ -1042,7 +1053,6 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf amend_msg = STRBUF_INIT;
 	char *amend_author = NULL;
-	const char *gpg_sign;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
 
@@ -1075,7 +1085,8 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	}
 
 	cleanup = (flags & CLEANUP_MSG) ? COMMIT_MSG_CLEANUP_ALL :
-					  default_msg_cleanup;
+					  opts->default_msg_cleanup;
+
 	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
 		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
 	if (!opts->allow_empty_message && message_is_empty(msg, cleanup)) {
@@ -1083,8 +1094,6 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 		goto out;
 	}
 
-	gpg_sign = opts->gpg_sign ? opts->gpg_sign : default_gpg_sign;
-
 	if (write_cache_as_tree(tree.hash, 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
@@ -1098,7 +1107,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	}
 
 	if (commit_tree_extended(msg->buf, msg->len, tree.hash, parents,
-				 oid->hash, author, gpg_sign, extra)) {
+				 oid->hash, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
 		goto out;
 	}
diff --git a/sequencer.h b/sequencer.h
index 77cb174b2aaf3972ebb9e6ec379252be96dedd3d..3a5072c2ab9088c237b83d92deae3c801289e543 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -11,6 +11,13 @@ enum replay_action {
 	REPLAY_INTERACTIVE_REBASE
 };
 
+enum commit_msg_cleanup_mode {
+	COMMIT_MSG_CLEANUP_SPACE,
+	COMMIT_MSG_CLEANUP_NONE,
+	COMMIT_MSG_CLEANUP_SCISSORS,
+	COMMIT_MSG_CLEANUP_ALL
+};
+
 struct replay_opts {
 	enum replay_action action;
 
@@ -29,6 +36,7 @@ struct replay_opts {
 	int mainline;
 
 	char *gpg_sign;
+	enum commit_msg_cleanup_mode default_msg_cleanup;
 
 	/* Merge strategy */
 	char *strategy;
@@ -40,6 +48,8 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { -1 }
 
+/* Call this to setup defaults before parsing command line options */
+void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
 int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
@@ -57,15 +67,6 @@ extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf);
-int git_sequencer_config(const char *k, const char *v, void *cb);
-
-enum commit_msg_cleanup_mode {
-	COMMIT_MSG_CLEANUP_SPACE,
-	COMMIT_MSG_CLEANUP_NONE,
-	COMMIT_MSG_CLEANUP_SCISSORS,
-	COMMIT_MSG_CLEANUP_ALL
-};
-
 int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
-- 
2.15.1

