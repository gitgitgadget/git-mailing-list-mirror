From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v8 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Fri, 20 Apr 2012 10:36:15 -0400
Message-ID: <1334932577-31232-3-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 16:37:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLEy3-0001sN-IF
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 16:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359Ab2DTOh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 10:37:28 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40349 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab2DTOhC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 10:37:02 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SLExB-00020o-8U; Fri, 20 Apr 2012 10:36:59 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195995>

The git-cherry-pick --allow-empty command by default only preserves empty
commits that were originally empty, i.e only those commits for which
<commit>^{tree} and <commit>^^{tree} are equal.  By default commits which are
non-empty, but were made empty by the inclusion of a prior commit on the current
history are filtered out.  This option allows us to override that behavior and
include redundant commits as empty commits in the change history.

Note that this patch changes the default behavior of git cherry-pick slightly.
Prior to this patch all commits in a cherry-pick sequence were applied and git
commit was run.  The implication here was that, if a commit was redundant, and
the commit did not trigger the fast forward logic, the git commit operation, and
therefore the git cherry-pick operation would fail, displaying the cherry pick
advice (i.e. run git commit --allow-empty).  With this patch however, such
redundant commits are automatically skipped without stopping, unless
--keep-redundant-commits is specified, in which case, they are automatically
applied as empty commits.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
---
 Documentation/git-cherry-pick.txt |   12 ++++-
 builtin/revert.c                  |    8 +++-
 sequencer.c                       |   94 ++++++++++++++++++++++++++++++++----
 sequencer.h                       |    1 +
 4 files changed, 102 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 730237a..0c004e9 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -110,7 +110,17 @@ effect to your index in a row.
 	behavior, allowing empty commits to be preserved automatically
 	in a cherry-pick. Note that when "--ff" is in effect, empty
 	commits that meet the "fast-forward" requirement will be kept
-	even without this option.
+	even without this option.  Note also, that use of this option only
+	keeps commits that were initially empty (i.e. the commit recorded the
+	same tree as its parent).  Commits which are made empty due to a
+	previous commit are ignored.  To force the inclusion of those commits
+	use `--keep-redundant-commits`.
+
+--keep-redundant-commits::
+	If a commit being cherry picked duplicates a commit already in the
+	current history, it will result in an empty changeset.  By default these
+	redundant commits are ignored.  This option overrides that behavior and
+	creates an empty commit object.  Implies `--allow-empty`.
 
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
diff --git a/builtin/revert.c b/builtin/revert.c
index 06b00e6..f135502 100644
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
+			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, "keep redundant, empty commits"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
@@ -139,6 +141,10 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"--abort", rollback,
 				NULL);
 
+	/* keep_if_made_empty implies allow_empty */
+	if (opts->keep_redundant_commits)
+		opts->allow_empty = 1;
+
 	/* Set the subcommand */
 	if (remove_state)
 		opts->subcommand = REPLAY_REMOVE_STATE;
diff --git a/sequencer.c b/sequencer.c
index 71929ba..4e3af82 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -13,6 +13,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "argv-array.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -251,6 +252,30 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	return !clean;
 }
 
+static int is_index_unchanged(void)
+{
+	unsigned char head_sha1[20];
+	struct commit *head_commit;
+
+	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+		return error(_("Could not resolve HEAD commit\n"));
+
+	head_commit = lookup_commit(head_sha1);
+	if (!head_commit || parse_commit(head_commit))
+		return error(_("could not parse commit %s\n"),
+			     sha1_to_hex(head_commit->object.sha1));
+
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
+
+	if (!cache_tree_fully_valid(active_cache_tree))
+		if (cache_tree_update(active_cache_tree, active_cache,
+				  active_nr, 0))
+			return error(_("Unable to update cache tree\n"));
+
+	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
+}
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -260,24 +285,46 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 {
-	/* 7 is max possible length of our args array including NULL */
-	const char *args[7];
-	int i = 0;
+	struct argv_array array;
+	int rc;
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
+	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
+	argv_array_clear(&array);
+	return rc;
+}
+
+static int is_original_commit_empty(struct commit *commit)
+{
+	const unsigned char *ptree_sha1;
+
+	if (parse_commit(commit))
+		return error(_("Could not parse commit %s\n"),
+			     sha1_to_hex(commit->object.sha1));
+	if (commit->parents) {
+		struct commit *parent = commit->parents->item;
+		if (parse_commit(parent))
+			return error(_("Could not parse parent commit %s\n"),
+				sha1_to_hex(parent->object.sha1));
+		ptree_sha1 = parent->tree->object.sha1;
+	} else {
+		ptree_sha1 = EMPTY_TREE_SHA1_BIN; /* commit is root */
+	}
 
-	return run_command_v_opt(args, RUN_GIT_CMD);
+	return !hashcmp(ptree_sha1, commit->tree->object.sha1);
 }
 
 static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
@@ -289,6 +336,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
+	int empty_commit;
+	int index_unchanged;
 
 	if (opts->no_commit) {
 		/*
@@ -414,6 +463,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		free_commit_list(remotes);
 	}
 
+	empty_commit = is_original_commit_empty(commit);
+	if (empty_commit < 0)
+		return empty_commit;
+
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
 	 * CHERRY_PICK_HEAD for the subsequent invocation of commit to use.
@@ -434,6 +487,25 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
 	} else {
+		index_unchanged = is_index_unchanged();
+		/*
+		 * If index_unchanged is less than 0, that indicates we either
+		 * couldn't parse HEAD or the index, so error out here.
+		 */
+		if (index_unchanged < 0)
+			return index_unchanged;
+
+		if (!empty_commit && !opts->keep_redundant_commits && index_unchanged)
+			/*
+			 * The head tree and the index match
+			 * meaning the commit is empty.  Since it wasn't created
+			 * empty (based on the previous test), we can conclude
+			 * the commit has been made redundant.  Since we don't
+			 * want to keep redundant commits, we can just return
+			 * here, skipping this commit
+			 */
+			return 0;
+
 		if (!opts->no_commit)
 			res = run_git_commit(defmsg, opts);
 	}
diff --git a/sequencer.h b/sequencer.h
index e2cd725..aa5f17c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -30,6 +30,7 @@ struct replay_opts {
 	int allow_ff;
 	int allow_rerere_auto;
 	int allow_empty;
+	int keep_redundant_commits;
 
 	int mainline;
 
-- 
1.7.7.6
