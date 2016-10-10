Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7F4209B4
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbcJJR0J (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:53727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753230AbcJJR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:00 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MOTRh-1bq5QS2k1l-005pwc; Mon, 10 Oct 2016 19:25:45
 +0200
Date:   Mon, 10 Oct 2016 19:25:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 13/25] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <9b2782e64f678ab2d261042b63fafc3e4a519295.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:F0zr18mDsygJn5y0UTqiicT1TF6CTsQRUtU8QxDkbjuG77JVTBw
 x8z2d5Wag6pZF+21/7CJd8T2yfX6z9/IQIkhEfgJ4RsP2uLTdPS9FXe5mO3PrBvkUqmCPb5
 GSEwEW1B++UNWHmBnNKgRmoR+lhX8k9pAUh2hnKfz6cqRYIlLNXDd6e/eBR+IVTXspRY37I
 yCP+kSeAjpagK8R/PcXFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TYUsjyl1lsU=:HkcVGMO7XbnTcMzMBkjEge
 wclXLZ3/z+T4HQQvrren4Q/pDWSL05LY/Nv3n7xF5L+Z56iGm82yQ0k2FUoEy72L3d0vft6O7
 mhkQDLjQRZuMIFPR1RR9EgyK6VC/YUwxN2Bblws2zejuJ3WjfkK8nuDVs146tOtM24gy7Of9v
 1Y5l58wXNxyv9ods6ypIM/9nQqXWlcb9tNb934W56qTTiz7nxuO2wXk4IAAc6FzdWeerClozo
 /HdTc0iIujJDbBY0UBvqNXbhp3PgqnTNQ88ZJRmjBwHi+fyDXCDh7/c4Zx6PpF8EWvIUJx8V8
 aw2GneiMUBFar7B5LNaQ2oqC36DWWyKTx6z0lm6jM9V6n2YbIbNX6gnZlNgue4Wa8nsEXPYkn
 gVz8yxNOaadzk4sPyK9EJXc5ba1cIHajtU0dhWqgw2jgEl2TeTjAzhFXc93sHHdZNiPH7EdG7
 /7pHSEZCeMLI66GjK8y/j0lPIxFXsCghYY/XHavtkvuSlqGNIiu4Iyh9NsqGAli2aC9EF1xJ+
 Yl7qQSvwFvD9noeu/RvpvHOfN/lDUWbTvJ0RzbICOErPz7qn3mSPBe5tLmZbZ9ejBUo6GUWsL
 mG9qWWWVrf+ecs/oQX9hEcMvyspNaKy2ey4biO6FVSZBnY8zbTmg12g2p6ffRbTYgENo3hvYa
 viLUqbkux9ludb6oikw/xs71/E7KSyu7C6tTZUsj+xsuq+oJeRWWtLuhO3qQ1HchinOHaAm2U
 AYSiQMsZFxcq/z+uqqSbUXE0qKFzCLP407K8zZr7r4tDvpimiDTwkzeMNVWClVLzcUJMH7wym
 mh5pKBD
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
index 7ba5e07..b694ace 100644
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
 
@@ -659,7 +734,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = run_git_commit(git_path_merge_msg(), opts, allow);
+		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
+				     opts, allow);
 
 leave:
 	free_message(commit, &msg);
@@ -883,6 +959,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
+	if (is_rebase_i(opts))
+		return 0;
+
 	if (!file_exists(git_path_opts_file()))
 		return 0;
 	/*
-- 
2.10.0.windows.1.325.ge6089c1


