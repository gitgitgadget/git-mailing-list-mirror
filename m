From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 3/5] git-cherry-pick: Add ignore-if-made-empty option [v2]
Date: Thu,  5 Apr 2012 15:39:03 -0400
Message-ID: <1333654745-7898-4-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 21:41:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFsYP-00006V-JY
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 21:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab2DETkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 15:40:18 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:57291 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881Ab2DETji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 15:39:38 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SFsWr-0005W8-62; Thu, 05 Apr 2012 15:39:36 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194800>

Since we'll be using git-cherry-pick to enhance git-rebase's ability to preserve
empty commits, we open ourselves to the possibility of preserving commits that
are made empty by a previous merge as well, which is almost certainly not what
we want (most of the time).  To handle this, we can add the ignore-if-made-empty
option.  If enabled, it will look at cherry-picked commits, and if the origional
sha1 has the same tree as its parent, then the cherry-pick is comitted as an
empty commit, otherwise the commit is skipped (because it previously made
changes to the tree, but no longer does).

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Jeff King <peff@peff.net>
CC: Phil Hord <phil.hord@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-cherry-pick.txt |   10 +++-
 builtin/revert.c                  |    2 +
 sequencer.c                       |  113 ++++++++++++++++++++++++++++++++-----
 sequencer.h                       |    1 +
 4 files changed, 111 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c283d8c..bb7eb4a 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -103,7 +103,7 @@ effect to your index in a row.
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
---allow-empty:
+--allow-empty:::
 	By default, cherry-picking an empty commit will fail,
 	indicating that an explicit invocation of `git commit
 	--allow-empty` is required. This option overrides that
@@ -112,6 +112,14 @@ effect to your index in a row.
 	commits that meet the "fast-forward" requirement will be kept
 	even without this option.
 
+--ignore-if-made-empty::
+	If the --allow-empty option is used, all empty commits are kept,
+	including those which were made empty due to a previous change.
+	While this may be desireable, likely it is not.  This option
+	restricts the scope of --allow-empty to only those commits which
+	were created as empty commits (i.e. if for commit C,  C^{tree} and 
+	C^^{tree} are identical).
+
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
diff --git a/builtin/revert.c b/builtin/revert.c
index 06b00e6..0fa76ca 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -115,6 +115,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -122,6 +123,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
 			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve empty commits"),
+			OPT_BOOLEAN(0, "ignore-if-made-empty", &opts->ignore_if_made_empty, "ignore commits already in tree"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/sequencer.c b/sequencer.c
index 71929ba..a512598 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -13,6 +13,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "argv-array.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -258,26 +259,107 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
  */
-static int run_git_commit(const char *defmsg, struct replay_opts *opts)
-{
-	/* 7 is max possible length of our args array including NULL */
-	const char *args[7];
-	int i = 0;
+static int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
+{
+	struct argv_array array;
+	int rc;
+
+	argv_array_init(&array);
+	argv_array_push(&array, "commit");
+	argv_array_push(&array, "-n");
+
+	if ((!empty) && (opts->ignore_if_made_empty)) {
+		/* Note: This implies --dry-run */
+		argv_array_push(&array, "--porcelain");
+		if (run_command_v_opt(array.argv, RUN_GIT_CMD) == 1) {
+			/* The dry run exit code of 1 tells us this is
+ 			 * an empty commit, just skip it.
+ 			 */
+			argv_array_clear(&array);
+			return 0;
+		}
+		argv_array_pop(&array, 1);
+	}
+
 
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
+
+
+	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
+	argv_array_clear(&array);
+	return rc;
+}
+
+static int is_origional_commit_empty(struct commit *commit)
+{
+	struct argv_array argv_array;
+	struct child_process cp;
+	char ptree[41], pptree[41];
+	int pipefd[2];
+	FILE *output;
+	int ret = 0;
+
+	if (pipe2(pipefd, 0) < 0)
+		return 0;
+
+	output = xfdopen(pipefd[0], "r");
+
+	argv_array_init(&argv_array);
+	memset(&cp, 0, sizeof(struct child_process));
 
-	args[i] = NULL;
+	argv_array_push(&argv_array, "rev-parse");
+	argv_array_pushf(&argv_array, "%s^{tree}", sha1_to_hex(commit->object.sha1));
 
-	return run_command_v_opt(args, RUN_GIT_CMD);
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.no_stderr = 1;
+	cp.out = pipefd[1];
+	cp.argv = argv_array.argv;
+
+	if (start_command(&cp) < 0)
+		goto out;
+
+	if (fscanf(output, "%s\n", ptree) < 1)
+		goto out;
+
+	finish_command(&cp);
+
+	fclose(output);
+	close(pipefd[0]);
+	argv_array_clear(&argv_array);
+
+	if (pipe2(pipefd, 0) < 0)
+		return 0;
+
+	output = xfdopen(pipefd[0], "r");
+
+	argv_array_push(&argv_array, "rev-parse");
+	argv_array_pushf(&argv_array, "%s^^{tree}", sha1_to_hex(commit->object.sha1));
+	cp.argv = argv_array.argv;
+
+	if (start_command(&cp) < 0)
+		goto out;
+
+	if (fscanf(output, "%s\n", pptree) < 1)
+		goto out;
+
+	finish_command(&cp);
+	close(pipefd[0]);
+
+	if (!strncmp(ptree, pptree, 40))
+		ret = 1;
+out:
+	fclose(output);
+	argv_array_clear(&argv_array);	
+	return ret;
 }
 
 static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
@@ -289,6 +371,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
+	int empty_commit;
 
 	if (opts->no_commit) {
 		/*
@@ -414,6 +497,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		free_commit_list(remotes);
 	}
 
+	empty_commit = is_origional_commit_empty(commit);
+
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
 	 * CHERRY_PICK_HEAD for the subsequent invocation of commit to use.
@@ -435,7 +520,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		rerere(opts->allow_rerere_auto);
 	} else {
 		if (!opts->no_commit)
-			res = run_git_commit(defmsg, opts);
+			res = run_git_commit(defmsg, opts, empty_commit);
 	}
 
 	free_message(&msg);
diff --git a/sequencer.h b/sequencer.h
index e2cd725..3e1106f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -30,6 +30,7 @@ struct replay_opts {
 	int allow_ff;
 	int allow_rerere_auto;
 	int allow_empty;
+	int ignore_if_made_empty;
 
 	int mainline;
 
-- 
1.7.7.6
