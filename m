Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A410C207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755886AbcIKKyX (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:54:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:57962 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755479AbcIKKyW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:54:22 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MhiPD-1bNMVu209r-00MuI9; Sun, 11 Sep 2016 12:54:17
 +0200
Date:   Sun, 11 Sep 2016 12:54:16 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 13/25] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <6b8be36604a78b5069eaefce3e8dcff6b7e67c78.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rUQR2Tzu6h95p+r2cl6SNpjvJh1nIuTr9QV7zcuyTJ/KZimYGHY
 vIB981L/yGWhNHQc7B7I8qPqrRhvMaz3zk2Kebi8syYbeTMILSWLV5k8K+ibVOvgHCp71Fl
 CHrs/+5eckzrQLormzsKk2N5tey7WalOEPhoiPhHPKJe0e4Rf59tfDLe3nf89KdXd4Fhtvk
 91o0qmtc/GKoSY0SUbESg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OHyHqKLKAkg=:D4fCyX9AndLlOskrNoO/Qg
 Rfez1Gro+nsqu8q59rA9+t7J5KsXbKtE5oxbjCNcgE+5icdL9V3BaV3U43JowinZK4ylcg3i0
 F4oEKdIW/0rZCvhACm4XSJt9EQBTpGkHf7ExYJ8LTRv4AoOl09RUnmF8VMn+5kqOWwOBv9sDe
 zG0Pk3xUrxiqPrrQPVBAG1erbQ/vK+sktrk40R9QZZn4tnN87LCiPe4Doq2iIyy7kj9/3F0Jo
 LsD7YOHGCXRRL7HtrhqbOnQ74MrWtdet+V6nkOHx1pKKEL+fQPdAa+Ox6bTwTpS4OJPj9GG8W
 Ok/oJED8xd9fdq2cSKoezkjFWEzu5kUF4zvFG3soxoVF9Ql4sSfgKPzIQRR2LZKCC4UqnK3QL
 f0BKcGWDJ0lfw3xT7iRvOt/LxCYWgrSI0LRvbtdDWS4VfiZMOoj29nv0A2VyUpvwaqs6hFlJ1
 f/DDB8tijGHi1qk2RprZwuRZY+ErTcOtVaLYuZiXDQPh0DoJnDWn1g+32EArB4GBi9pcxlmIL
 wn5m87/BV80TW3EZGJCtsrS8uzyJOWAz7DSpJTqa7C8lxcoeucMtCH9diO+ODT7zEtWa4lwSR
 NPSJvOqiEaee4k8HGHLiNznGogHGYMZ+Z3onBVPYkk9tvBcl0lpmrqdMcP21A/9AaVTGD21cn
 FSP+hXsm4j+OFLcLDoiAB8IWmyxEwz0cxHT63momhf7ukMLiuHbZOI0ZhS5SAcnTP2DyhcJTg
 DNTMjyYx4cxmtuFoVdX37M2rfQmELABojkq3FT5EAJUOVaoCLHBUp/Ujswz/kq+ETU1nNb7B4
 9uFBJ/O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In interactive rebases, we commit a little bit differently than the
sequencer did so far: we heed the "author-script", the "message" and
the "amend" files in the .git/rebase-merge/ subdirectory.

Likewise, we may want to edit the commit message *even* when providing
a file containing the suggested commit message. Therefore we change the
code to not even provide a default message when we do not want any, and
to call the editor explicitly.

As interactive rebase's GPG settings are configured differently from
how cherry-pick (and therefore sequencer) handles them, we will leave
support for that to the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 sequencer.h |  3 ++
 2 files changed, 89 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ca1961c..6c35fe8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,6 +27,19 @@ static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 
+/*
+ * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
+ * GIT_AUTHOR_DATE that will be used for the commit that is currently
+ * being rebased.
+ */
+static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
+
+/* We will introduce the 'interactive rebase' mode later */
+static inline int is_rebase_i(const struct replay_opts *opts)
+{
+	return 0;
+}
+
 static const char *get_dir(const struct replay_opts *opts)
 {
 	return git_path_seq_dir();
@@ -377,20 +390,76 @@ static int is_index_unchanged(void)
 	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
 }
 
+static char **read_author_script(void)
+{
+	struct strbuf script = STRBUF_INIT;
+	int i, count = 0;
+	char *p, *p2, **env;
+	size_t env_size;
+
+	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
+		return NULL;
+
+	for (p = script.buf; *p; p++)
+		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
+			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
+		else if (*p == '\'')
+			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
+		else if (*p == '\n') {
+			*p = '\0';
+			count++;
+		}
+
+	env_size = (count + 1) * sizeof(*env);
+	strbuf_grow(&script, env_size);
+	memmove(script.buf + env_size, script.buf, script.len);
+	p = script.buf + env_size;
+	env = (char **)strbuf_detach(&script, NULL);
+
+	for (i = 0; i < count; i++) {
+		env[i] = p;
+		p += strlen(p) + 1;
+	}
+	env[count] = NULL;
+
+	return env;
+}
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
  * author date and name.
+ *
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
+ *
+ * An exception is when sequencer_commit() is called during an
+ * interactive rebase: in that case, we will want to retain the
+ * author metadata.
  */
-static int run_git_commit(const char *defmsg, struct replay_opts *opts,
+int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 			  int allow_empty)
 {
+	char **env = NULL;
 	struct argv_array array;
 	int rc;
 	const char *value;
 
+	if (is_rebase_i(opts)) {
+		env = read_author_script();
+		if (!env)
+			return error("You have staged changes in your working "
+				"tree. If these changes are meant to be\n"
+				"squashed into the previous commit, run:\n\n"
+				"  git commit --amend $gpg_sign_opt_quoted\n\n"
+				"If they are meant to go into a new commit, "
+				"run:\n\n"
+				"  git commit $gpg_sign_opt_quoted\n\n"
+				"In both cases, once you're done, continue "
+				"with:\n\n"
+				"  git rebase --continue\n");
+	}
+
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
@@ -399,14 +468,13 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
-	if (!opts->edit) {
-		argv_array_push(&array, "-F");
-		argv_array_push(&array, defmsg);
-		if (!opts->signoff &&
-		    !opts->record_origin &&
-		    git_config_get_value("commit.cleanup", &value))
-			argv_array_push(&array, "--cleanup=verbatim");
-	}
+	if (defmsg)
+		argv_array_pushl(&array, "-F", defmsg, NULL);
+	if (opts->edit)
+		argv_array_push(&array, "-e");
+	else if (!opts->signoff && !opts->record_origin &&
+		 git_config_get_value("commit.cleanup", &value))
+		argv_array_push(&array, "--cleanup=verbatim");
 
 	if (allow_empty)
 		argv_array_push(&array, "--allow-empty");
@@ -414,8 +482,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&array, "--allow-empty-message");
 
-	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
+	rc = run_command_v_opt_cd_env(array.argv, RUN_GIT_CMD, NULL,
+			(const char *const *)env);
 	argv_array_clear(&array);
+	free(env);
+
 	return rc;
 }
 
@@ -664,7 +735,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = run_git_commit(git_path_merge_msg(), opts, allow);
+		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
+			opts, allow);
 
 leave:
 	free_message(commit, &msg);
@@ -877,6 +949,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
+	if (is_rebase_i(opts))
+		return 0;
+
 	if (!file_exists(git_path_opts_file()))
 		return 0;
 	/*
diff --git a/sequencer.h b/sequencer.h
index 0b3950d..16deb6c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -53,6 +53,9 @@ int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
+int sequencer_commit(const char *defmsg, struct replay_opts *opts,
+			  int allow_empty);
+
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-- 
2.10.0.windows.1.10.g803177d


