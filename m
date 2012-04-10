From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v3 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Tue, 10 Apr 2012 11:47:46 -0400
Message-ID: <1334072868-9435-3-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
Cc: Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 17:48:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHdIv-0004NT-VH
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 17:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759147Ab2DJPsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 11:48:23 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:49335 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759103Ab2DJPsW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 11:48:22 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SHdIk-0005X6-Ag; Tue, 10 Apr 2012 11:48:20 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195096>

The git-cherry-pick --allow-empty command by default only preserves empty
commits that were originally empty, i.e only those commits for which
<commit>^{tree} and <commit>^^{tree} are equal.  By default commits which are
non-empty, but were made empty by the inclusion of a prior commit on the current
history are filtered out.  This option allows us to override that behavior and
include redundant commits as empty commits in the change history.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
---
 Documentation/git-cherry-pick.txt |   12 ++++-
 builtin/commit.c                  |    5 ++
 builtin/revert.c                  |    8 +++-
 sequencer.c                       |  106 ++++++++++++++++++++++++++++++++-----
 sequencer.h                       |    1 +
 5 files changed, 117 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 730237a..f96b8c5 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -110,7 +110,17 @@ effect to your index in a row.
 	behavior, allowing empty commits to be preserved automatically
 	in a cherry-pick. Note that when "--ff" is in effect, empty
 	commits that meet the "fast-forward" requirement will be kept
-	even without this option.
+	even without this option.  Note also, that use of this option only
+	keeps commits that were initially empty (i.e. where for commit C
+	C^{tree} and C^^{tree} are equal).  Commits which are made empty due to
+	a previous commit are ignored.  To force the inclusion of those commits
+	use `--keep-redundant-commits`
+
+--keep-redundant-commits::
+	If a commit being cherry picked duplicates a commit already in the
+	current history, it will result in an empty changeset.  By default these
+	redundant commits are ignored.  This option overrides that behavior and
+	creates an empty commit object.  Implies `--allow-empty`
 
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
diff --git a/builtin/commit.c b/builtin/commit.c
index 0cd10ab..c386189 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -61,6 +61,11 @@ N_("The previous cherry-pick is empty.\n"
 "\n"
 "    git cherry-pick --allow-empty\n"
 "\n"
+"If the commit was made empty via conflict resolution, and you wish\n"
+"to keep the now-empty commit anyway, use:\n"
+"\n"
+"    git cherry-pick --keep-redundant-commits\n"
+"\n"
 "Otherwise, please use 'git reset'\n");
 
 static const char *use_message_buffer;
diff --git a/builtin/revert.c b/builtin/revert.c
index 06b00e6..4f0d979 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -115,13 +115,15 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
-			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve empty commits"),
+			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve initially empty commits"),
+			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_if_made_empty, "keep redundant, empty commits"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
@@ -139,6 +141,10 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"--abort", rollback,
 				NULL);
 
+	/* keep_if_made_empty implies allow_empty */
+	if (opts->keep_if_made_empty)
+		opts->allow_empty = 1;
+
 	/* Set the subcommand */
 	if (remove_state)
 		opts->subcommand = REPLAY_REMOVE_STATE;
diff --git a/sequencer.c b/sequencer.c
index 71929ba..5d033db 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -13,6 +13,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "argv-array.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -258,26 +259,102 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
  */
-static int run_git_commit(const char *defmsg, struct replay_opts *opts)
+static int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
 {
-	/* 7 is max possible length of our args array including NULL */
-	const char *args[7];
-	int i = 0;
+	struct argv_array array;
+	int rc;
+
+	if (!empty && !opts->keep_if_made_empty) {
+		const char *argv[] = { "diff-index", "--quiet", "--exit-code",
+					"--cached", "HEAD", NULL };
+
+		/*
+ 		 * If we run git diff-index with the above option and it returns
+ 		 * zero, then there have been no changes made to the index by
+ 		 * this patch, i.e. its empty.  Since our previous empty test
+ 		 * indicated that this patch was not created empty, its been made
+ 		 * redundant.  Since keep_if_made_empty is not set, we just skip
+ 		 * it
+ 		 */
+		if (run_command_v_opt(argv, RUN_GIT_CMD) == 0)
+			return 0;
+	}
+
+	argv_array_init(&array);
+	argv_array_push(&array, "commit");
+	argv_array_push(&array, "-n");
 
-	args[i++] = "commit";
-	args[i++] = "-n";
 	if (opts->signoff)
-		args[i++] = "-s";
+		argv_array_push(&array, "-s");
 	if (!opts->edit) {
-		args[i++] = "-F";
-		args[i++] = defmsg;
+		argv_array_push(&array, "-F");
+		argv_array_push(&array, defmsg);
 	}
+	
 	if (opts->allow_empty)
-		args[i++] = "--allow-empty";
+		argv_array_push(&array, "--allow-empty");
 
-	args[i] = NULL;
 
-	return run_command_v_opt(args, RUN_GIT_CMD);
+	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
+	argv_array_clear(&array);
+	return rc;
+}
+
+static int is_original_commit_empty(struct commit *commit)
+{
+	struct argv_array argv_array;
+	struct child_process cp;
+	char ptree[40], pptree[40];
+	int ret = 0;
+
+	argv_array_init(&argv_array);
+	memset(&cp, 0, sizeof(struct child_process));
+
+	argv_array_push(&argv_array, "rev-parse");
+	argv_array_pushf(&argv_array, "%s^{tree}", sha1_to_hex(commit->object.sha1));
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.out = -1;
+	cp.argv = argv_array.argv;
+
+	if (start_command(&cp) < 0)
+		goto out;
+
+	if (read_in_full(cp.out, ptree, sizeof(ptree)) < sizeof(ptree)) {
+		close(cp.out);
+		goto out;
+	}
+
+	close(cp.out);
+
+	finish_command(&cp);
+
+	argv_array_clear(&argv_array);
+
+	argv_array_push(&argv_array, "rev-parse");
+	argv_array_pushf(&argv_array, "%s^^{tree}", sha1_to_hex(commit->object.sha1));
+	cp.out = -1;
+	cp.argv = argv_array.argv;
+
+	if (start_command(&cp) < 0)
+		goto out;
+
+	if (read_in_full(cp.out, pptree, sizeof(pptree)) < sizeof(ptree)) {
+		close(cp.out);
+		goto out;
+	}
+
+	close(cp.out);
+
+	finish_command(&cp);
+
+	if (!strncmp(ptree, pptree, sizeof(ptree)))
+		ret = 1;
+out:
+	argv_array_clear(&argv_array);	
+	return ret;
 }
 
 static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
@@ -289,6 +366,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
+	int empty_commit;
 
 	if (opts->no_commit) {
 		/*
@@ -414,6 +492,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		free_commit_list(remotes);
 	}
 
+	empty_commit = is_original_commit_empty(commit);
+
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
 	 * CHERRY_PICK_HEAD for the subsequent invocation of commit to use.
@@ -435,7 +515,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		rerere(opts->allow_rerere_auto);
 	} else {
 		if (!opts->no_commit)
-			res = run_git_commit(defmsg, opts);
+			res = run_git_commit(defmsg, opts, empty_commit);
 	}
 
 	free_message(&msg);
diff --git a/sequencer.h b/sequencer.h
index e2cd725..862a79a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -30,6 +30,7 @@ struct replay_opts {
 	int allow_ff;
 	int allow_rerere_auto;
 	int allow_empty;
+	int keep_if_made_empty;
 
 	int mainline;
 
-- 
1.7.7.6
