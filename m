From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] add --no-verify to git-merge and git-pull
Date: Thu, 21 Aug 2008 15:00:34 +0200
Message-ID: <E1KW9wI-0005K5-1y@fencepost.gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 15:14:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW9yf-0008AT-QX
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 15:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbYHUNMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 09:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYHUNMV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 09:12:21 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:46427 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbYHUNMU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 09:12:20 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1KW9wI-0005K5-1y
	for git@vger.kernel.org; Thu, 21 Aug 2008 09:10:58 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93147>

This patch adds the --no-verify option to skip the pre-merge hook.
The corresponding testcase is also updated to test the new option.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-merge.txt     |    2 +-
 Documentation/merge-options.txt |    3 +++
 builtin-merge.c                 |   15 +++++++++------
 git-pull.sh                     |    9 ++++++---
 t/t5407-pre-merge-hook.sh       |   15 ++++++++++-----
 5 files changed, 29 insertions(+), 15 deletions(-)

	I'm submitting this separately because it touches a substantially
	disjoint set of files (besides builtin-merge.c).

	As an aside, I'm not particularly attached to this set of
	patches as long as there is a way to achieve what I wanted,
	i.e. blocking merge commits.  One way would be with
	branch.<name>.mergeoptions and the fast forward strategies
	patch from Sverre.

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 17a15ac..5a0f398 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
-	[-m <msg>] <remote> <remote>...
+	[-m <msg>] [--no-verify] <remote> <remote>...
 'git merge' <msg> HEAD <remote>...
 
 DESCRIPTION
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 007909a..9a4f0bb 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -51,6 +51,9 @@
 	a fast-forward, only update the branch pointer. This is
 	the default behavior of git-merge.
 
+--no-verify::
+	Bypasses the pre-merge hook.  See also linkgit:githooks[5].
+
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/builtin-merge.c b/builtin-merge.c
index e7f3ece..0999dca 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -42,7 +42,7 @@ static const char * const builtin_merge_usage[] = {
 
 static int show_diffstat = 1, option_log, squash;
 static int option_commit = 1, allow_fast_forward = 1;
-static int allow_trivial = 1, have_message;
+static int allow_trivial = 1, have_message, no_verify;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
 static unsigned char head[20], stash[20];
@@ -166,6 +166,8 @@ static struct option builtin_merge_options[] = {
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
 		"perform a commit if the merge succeeds (default)"),
+	OPT_BOOLEAN(0, "no-verify", &no_verify,
+		"bypass the pre-merge hook"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast forward (default)"),
 	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
@@ -905,8 +907,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
 		if (!remote_head)
 			die("%s - not something we can merge", argv[0]);
-		if (run_hook("pre-merge", NULL, "ff", "--",
-			     remote_head->sha1, NULL))
+		if (!no_verify && run_hook("pre-merge", NULL, "ff", "--",
+					   remote_head->sha1, NULL))
 			return 1;
 
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
@@ -1006,7 +1008,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
 
-		if (run_pre_merge_hook("ff"))
+		if (!no_verify && run_pre_merge_hook("ff"))
 			return 1;
 
 		printf("Updating %s..%s\n",
@@ -1047,7 +1049,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			printf("Trying really trivial in-index merge...\n");
 			if (!read_tree_trivial(common->item->object.sha1,
 					head, remoteheads->item->object.sha1)) {
-				if (run_pre_merge_hook("trivial"))
+				if (!no_verify && run_pre_merge_hook("trivial"))
 					return 1;
 				return merge_trivial();
 			}
@@ -1083,7 +1085,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (run_pre_merge_hook(remoteheads->next ? "octopus" : "merge"))
+	if (!no_verify &&
+	    run_pre_merge_hook(remoteheads->next ? "octopus" : "merge"))
 		return 1;
 
 	/* We are going to make a new commit. */
diff --git a/git-pull.sh b/git-pull.sh
index 429d02c..52aaea9 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,7 +4,7 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
+USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [--no-verify] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
@@ -16,7 +16,7 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
-strategy_args= no_stat= no_commit= squash= no_ff= log_arg=
+strategy_args= no_stat= no_commit= squash= no_ff= no_verify= log_arg=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
@@ -41,6 +41,8 @@ do
 		no_ff=--ff ;;
 	--no-ff)
 		no_ff=--no-ff ;;
+	--no-verify)
+		no_verify=--no-verify ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -181,5 +183,6 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
+exec git-merge $no_stat $no_commit $squash $no_ff $no_verify \
+	$log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t5407-pre-merge-hook.sh b/t/t5407-pre-merge-hook.sh
index b7029ce..961040f 100755
--- a/t/t5407-pre-merge-hook.sh
+++ b/t/t5407-pre-merge-hook.sh
@@ -117,14 +117,19 @@ test_expect_success 'pre-merge does not run for up-to-date octopus ' '
 	! test -f .git/pre-merge.args
 '
 
-cat >.git/hooks/pre-merge <<'EOF'
-#!/bin/sh
-exit 1
-EOF
+echo 'exit 1' >>.git/hooks/pre-merge
 chmod u+x .git/hooks/pre-merge
 
 test_expect_success 'pre-merge can stop merge ' '
-        ! git merge --no-ff branch4
+	rm -f .git/pre-merge.args &&
+        ! git merge --no-ff branch4 &&
+	test -f .git/pre-merge.args
+'
+
+test_expect_success 'pre-merge is not invoked with --no-verify' '
+	rm -f .git/pre-merge.args &&
+        git merge --no-ff --no-verify branch4 &&
+	! test -f .git/pre-merge.args
 '
 
 test_done
-- 
1.5.5
