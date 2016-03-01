From: Kevin Daudt <me@ikke.info>
Subject: [PATCH] cherry-pick: add --no-verify option
Date: Tue,  1 Mar 2016 21:40:46 +0100
Message-ID: <1456864846-14185-1-git-send-email-me@ikke.info>
References: <56D576A1.3020202@greg0ire.fr>
Cc: Kevin Daudt <me@ikke.info>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 21:41:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aar6Z-0007EX-I2
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 21:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbcCAUlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 15:41:10 -0500
Received: from ikke.info ([178.21.113.177]:43656 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbcCAUlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 15:41:09 -0500
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id 121CE2D8009; Tue,  1 Mar 2016 21:41:07 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on ikke.info
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.1
Received: from io.ikke (unknown [10.8.0.30])
	by vps892.directvps.nl (Postfix) with ESMTP id 7BAC52D8007;
	Tue,  1 Mar 2016 21:41:06 +0100 (CET)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <56D576A1.3020202@greg0ire.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288063>

git commit has a --no-verify option to prevent the pre-commit hook from
running. When continuing a conflicted cherry-pick, git commit gets
executed which also causes the pre-commit hook to be run.

Add --no-verify and pass that through to the git commit command so that
the can prevent that from happening

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 builtin/revert.c                |  2 ++
 sequencer.c                     | 21 ++++++++++++++++-----
 sequencer.h                     |  1 +
 t/t3510-cherry-pick-sequence.sh | 12 ++++++++++++
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 56a2c36..81d9c85 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -97,6 +97,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -106,6 +107,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL(0, "no-verify", &opts->no_verify, N_("don't run pre-commit hook when continuing cherry-pick")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/sequencer.c b/sequencer.c
index e66f2fe..657a381 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -978,14 +978,25 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	return 0;
 }
 
-static int continue_single_pick(void)
+static int continue_single_pick(struct replay_opts *opts)
 {
-	const char *argv[] = { "commit", NULL };
+	struct argv_array array;
+	int rc;
+
+	argv_array_init(&array);
+	argv_array_push(&array, "commit");
 
 	if (!file_exists(git_path_cherry_pick_head()) &&
 	    !file_exists(git_path_revert_head()))
 		return error(_("no cherry-pick or revert in progress"));
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+
+	if (opts->no_verify)
+		argv_array_push(&array, "--no-verify");
+
+	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
+	argv_array_clear(&array);
+
+	return rc;
 }
 
 static int sequencer_continue(struct replay_opts *opts)
@@ -993,14 +1004,14 @@ static int sequencer_continue(struct replay_opts *opts)
 	struct commit_list *todo_list = NULL;
 
 	if (!file_exists(git_path_todo_file()))
-		return continue_single_pick();
+		return continue_single_pick(opts);
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path_cherry_pick_head()) ||
 	    file_exists(git_path_revert_head())) {
-		int ret = continue_single_pick();
+		int ret = continue_single_pick(opts);
 		if (ret)
 			return ret;
 	}
diff --git a/sequencer.h b/sequencer.h
index 5ed5cb1..d868a50 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -34,6 +34,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int no_verify;
 
 	int mainline;
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89d..29a06f8 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -340,6 +340,18 @@ test_expect_success '--continue after resolving conflicts and committing' '
 	test_cmp expect actual
 '
 
+test_expect_success '--continue --no-verify does not run pre-commit hook ' '
+	pristine_detach initial &&
+	mkdir -p .git/hooks &&
+	echo -e "#!/bin/sh\nexit 1" >.git/hooks/pre-commit &&
+	chmod u+x .git/hooks/pre-commit &&
+	test_when_finished "rm -r .git/hooks/" &&
+
+	test_must_fail git cherry-pick picked &&
+	git add foo &&
+	git cherry-pick --continue --no-verify
+'
+
 test_expect_success '--continue asks for help after resolving patch to nil' '
 	pristine_detach conflicting &&
 	test_must_fail git cherry-pick initial..picked &&
-- 
2.7.2
