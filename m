Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32331F404
	for <e@80x24.org>; Fri, 19 Jan 2018 14:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755836AbeASOUU (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 09:20:20 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:38942 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754951AbeASOUO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 09:20:14 -0500
Received: from lindisfarne.localdomain ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id cXWWeW8PQbjdZcXWeepurU; Fri, 19 Jan 2018 14:20:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516371612;
        bh=sXhu+cm7eyvCsfU1r7vmhvuhl3lpZ/QyPV4ZQhhYArk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=SxrXV8azcsl4sFlR7Fgg9eo0EQ1rZrlNcAJ0tPeWDeJA1kb2FrFXUacSuUp3rH7Ob
         CF2vV/+cLgK+RVexk/bU+9LEmbbM6wbeYyyvc/PnxmtF55m82omBFh+41mA9fmBalb
         MHD0kvhs8HbvUarOdou1djydCnV2Kh7Zir/porVg=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=evINK-nbAAAA:8 a=pGLkceISAAAA:8
 a=UdaD1JBUYmn_XgJ1rEgA:9 a=Mv8VOK7-q9uYIcft:21 a=UxtYmMyoJtgWtkWK:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] sequencer: run 'prepare-commit-msg' hook
Date:   Fri, 19 Jan 2018 14:19:40 +0000
Message-Id: <20180119141940.5421-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180119141940.5421-1-phillip.wood@talktalk.net>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
 <20180119141940.5421-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDxyz3UXO1HPDqO1L0uvA5MmmrhDMBHqj7phlU7kE0ctdAjPswJvy6c5oYaHhRVLEMNdIvsIzCFYYCU0iPEwRwkREmr8r7v1lmEk54QnRRTUNLRxKogr
 92Js/zH3+nvp5plhr5ZWLC3qz+mSLLKmkbJDYTBR9QtN9GoY3ib8CI8sRY8yAYcDAWxXXmnwhDzKZON2zHpLScmpaA2StDufPgf1VoYlBCRLFnegnr8zKn37
 7luzZlkIGZNYPsYAV3sQZzzdJ/fnD9hhfWquQg+VKL6AbH52FfFnK1mM3JKXDeagwAr+D7WgJCxzQWSm4zG5AOePggj5qAnbvBrzZmpS51Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit 356ee4659b ("sequencer: try to commit without forking 'git
commit'", 2017-11-24) forgot to run the 'prepare-commit-msg' hook when
creating the commit. Fix this by writing the commit message to a
different file and running the hook. Using a different file means that
if the commit is cancelled the original message file is
unchanged. Also move the checks for an empty commit so the order
matches 'git commit'.

Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c                   |  2 --
 sequencer.c                        | 69 +++++++++++++++++++++++++++++++-------
 sequencer.h                        |  1 +
 t/t7505-prepare-commit-msg-hook.sh |  8 ++---
 4 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4a64428ca8ed8c3066aec7cfd8ad7b71217af7dd..5dd766af2842dddb80d30cd73b8be8ccb4956eac 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -66,8 +66,6 @@ N_("If you wish to skip this commit, use:\n"
 "Then \"git cherry-pick --continue\" will resume cherry-picking\n"
 "the remaining commits.\n");
 
-static GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
-
 static const char *use_message_buffer;
 static struct lock_file index_lock; /* real index */
 static struct lock_file false_lock; /* used only for partial commits */
diff --git a/sequencer.c b/sequencer.c
index 63a8ec9a61e7a7bf603ffa494621af79b60e0b76..79579ba118e2743c3463a8662368cb4008f02165 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -29,6 +29,8 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
+GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
+
 GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
 
 static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
@@ -891,6 +893,31 @@ void commit_post_rewrite(const struct commit *old_head,
 	run_rewrite_hook(&old_head->object.oid, new_head);
 }
 
+int run_prepare_commit_msg_hook(struct strbuf *msg, const char *commit)
+{
+	struct argv_array hook_env = ARGV_ARRAY_INIT;
+	int ret;
+	const char *name;
+
+	name = git_path_commit_editmsg();
+	if (write_message(msg->buf, msg->len, name, 0))
+		return -1;
+
+	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", get_index_file());
+	argv_array_push(&hook_env, "GIT_EDITOR=:");
+	if (commit)
+		ret = run_hook_le(hook_env.argv, "prepare-commit-msg", name,
+				  "commit", commit, NULL);
+	else
+		ret = run_hook_le(hook_env.argv, "prepare-commit-msg", name,
+				  "message", NULL);
+	if (ret)
+		ret = error(_("'prepare-commit-msg' hook failed"));
+	argv_array_clear(&hook_env);
+
+	return ret;
+}
+
 static const char implicit_ident_advice_noconfig[] =
 N_("Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n"
@@ -1051,8 +1078,9 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	struct commit_list *parents = NULL;
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
-	struct strbuf amend_msg = STRBUF_INIT;
+	struct strbuf commit_msg = STRBUF_INIT;
 	char *amend_author = NULL;
+	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
 
@@ -1069,8 +1097,9 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 			const char *orig_message = NULL;
 
 			find_commit_subject(message, &orig_message);
-			msg = &amend_msg;
+			msg = &commit_msg;
 			strbuf_addstr(msg, orig_message);
+			hook_commit = "HEAD";
 		}
 		author = amend_author = get_author(message);
 		unuse_commit_buffer(current_head, message);
@@ -1084,16 +1113,6 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 		commit_list_insert(current_head, &parents);
 	}
 
-	cleanup = (flags & CLEANUP_MSG) ? COMMIT_MSG_CLEANUP_ALL :
-					  opts->default_msg_cleanup;
-
-	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
-	if (!opts->allow_empty_message && message_is_empty(msg, cleanup)) {
-		res = 1; /* run 'git commit' to display error message */
-		goto out;
-	}
-
 	if (write_cache_as_tree(tree.hash, 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
@@ -1106,6 +1125,30 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 		goto out;
 	}
 
+	if (find_hook("prepare-commit-msg")) {
+		res = run_prepare_commit_msg_hook(msg, hook_commit);
+		if (res)
+			goto out;
+		if (strbuf_read_file(&commit_msg, git_path_commit_editmsg(),
+				     2048) < 0) {
+			res = error_errno(_("unable to read commit message "
+					      "from '%s'"),
+					    git_path_commit_editmsg());
+			goto out;
+		}
+		msg = &commit_msg;
+	}
+
+	cleanup = (flags & CLEANUP_MSG) ? COMMIT_MSG_CLEANUP_ALL :
+					  opts->default_msg_cleanup;
+
+	if (cleanup != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(msg, cleanup == COMMIT_MSG_CLEANUP_ALL);
+	if (!opts->allow_empty_message && message_is_empty(msg, cleanup)) {
+		res = 1; /* run 'git commit' to display error message */
+		goto out;
+	}
+
 	if (commit_tree_extended(msg->buf, msg->len, tree.hash, parents,
 				 oid->hash, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
@@ -1124,7 +1167,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 out:
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
-	strbuf_release(&amend_msg);
+	strbuf_release(&commit_msg);
 	free(amend_author);
 
 	return res;
diff --git a/sequencer.h b/sequencer.h
index 24401b07d57b7ca875dea939f465f3e6cf1162a5..e45b178dfc41d723bf186f20674c4515d7c7fa00 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,6 +1,7 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
 
+const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 74b2eff71e886503d41b093953b9dd6ede29de3a..5df914a67cd74ce7101f792b4b9edcb913c665a7 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -251,10 +251,10 @@ test_rebase () {
 	'
 }
 
-test_rebase failure -i
-test_rebase failure -p
+test_rebase success -i
+test_rebase success -p
 
-test_expect_failure 'with hook (cherry-pick)' '
+test_expect_success 'with hook (cherry-pick)' '
 	test_when_finished "git checkout -f master" &&
 	git checkout -B other b &&
 	git cherry-pick rebase-1 &&
@@ -309,7 +309,7 @@ test_expect_success 'with failing hook (merge)' '
 
 '
 
-test_expect_failure C_LOCALE_OUTPUT 'with failing hook (cherry-pick)' '
+test_expect_success C_LOCALE_OUTPUT 'with failing hook (cherry-pick)' '
 	test_when_finished "git checkout -f master" &&
 	git checkout -B other b &&
 	test_must_fail git cherry-pick rebase-1 2>actual &&
-- 
2.15.1

