Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F05520229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbcJUMZM (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:64921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755451AbcJUMZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:11 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M0tr1-1cnBfS0KIZ-00v5a0; Fri, 21 Oct 2016 14:25:05
 +0200
Date:   Fri, 21 Oct 2016 14:25:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 13/27] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <7020e27fab4f8d190dec2ab4cbb7e6483161dffc.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bKPHbm1DN4bL2UjXituDzTJcxrIPLC2lDlQWJFz35DWyir831el
 XWWddpu6uMaU58HxmvFJZmqrVDkrzKfaauw/LDWOOi2obZxt5VMegzG6C9+wOh3owreAbfk
 cYm1vy8cCPq640/WGBwSv8pkHA9TOHetmWNBVJFNqKNT+ouQS/MNMMFw8KmeFHS0LP62/xa
 RGqdfTmbMO/BjZkUcy0Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PMf5C4AwIfs=:bfpDrSv25NQU84U1/D9ZIM
 4eJRuDt52BlumLJ4jrkiHHpU4lsLOg/FBQGOLBCvQPiVEjt+go3hu3KEcSmaQQc9WB78LMkhV
 hLevVW6qHzK/DmBRgt7nGx0bYTI0HIZSlmvm3UduQVbygmBCAVn/8MONwray8/fSPE1CYierX
 LegLIUZevAAc/T/v6KElpKdrK3PKCrFxrxfTIdhJJexVUNn8TvoKWldkX6nEl4oqdyE9W4Twa
 RMVk5VUWODn8jM+3tarvMQ9Zb8LxL8pEH+R7qI0BdnnXgu3X/DOKJkkwQdqbkWNPlt9oNN9u4
 tW9YHmuUnz5d3AA6Z9ctpQbMtM7jvz04tMR2yWNRfo7rUCAfQG+4APsSj4Gx7RNGagJdzS5JV
 DHr/IwdVdVIJ/YLUAYJj3tItDct5rCxpQN0apDoaM10rmjYxRBz0G4BjAxESJA0C3sTL1iAbn
 8q2e0bm7lCNbH+UG2hEaIQMaJlPh9j0jYqIwNS2Rf9aoHPkdzn22EtRIkSzDGS7f1XyXg3SE+
 AyFcL19TtLCo0VZglUC2TzCa1RnKe759+kd/cTBR16d+kebUnMn7KR0k+nci9hYn6evcPHTCK
 cyGaMYFfnkr3h7iyfogSSJ6vhFqOFuNJcsmGqat6o3ssVHXO3DdCRc+fCTukCijFPtXRQ3lg1
 uAk7N3N0PGOHwb6ZdCoFek6yVxHTTUfI8MWLrHH8VloaJ51LNuMu75A/DgX1M3GzVMYKvqzHU
 1LKx1F7lOuUR4P5qSRdC9v21eqI18BvdmCLU9fc/RPEKZMit4hfHhbx6qgTUK/1u5JM1TlaRR
 gDhJeTk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In interactive rebases, we commit a little bit differently than the
sequencer did so far: we heed the "author-script", the "message" and the
"amend" files in the .git/rebase-merge/ subdirectory.

Likewise, we may want to edit the commit message *even* when providing a
file containing the suggested commit message. Therefore we change the
code to not even provide a default message when we do not want any, and
to call the editor explicitly.

Also, in "interactive rebase" mode we want to skip reading the options
in the state directory of the cherry-pick/revert commands.

Finally, as interactive rebase's GPG settings are configured differently
from how cherry-pick (and therefore sequencer) handles them, we will
leave support for that to the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3d1fdac..6d5fe94 100644
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
@@ -370,19 +383,79 @@ static int is_index_unchanged(void)
 }
 
 /*
+ * Read the author-script file into an environment block, ready for use in
+ * run_command(), that can be free()d afterwards.
+ */
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
+/*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
  * author date and name.
+ *
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
+ *
+ * An exception is when run_git_commit() is called during an
+ * interactive rebase: in that case, we will want to retain the
+ * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
@@ -391,14 +464,13 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
@@ -406,8 +478,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
 
@@ -657,7 +732,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = run_git_commit(git_path_merge_msg(), opts, allow);
+		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
+				     opts, allow);
 
 leave:
 	free_message(commit, &msg);
@@ -879,6 +955,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
+	if (is_rebase_i(opts))
+		return 0;
+
 	if (!file_exists(git_path_opts_file()))
 		return 0;
 	/*
-- 
2.10.1.583.g721a9e0


