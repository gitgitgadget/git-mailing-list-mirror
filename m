From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] add a pre-merge hook
Date: Tue, 27 Aug 2008 14:19:42 +0200
Message-ID: <E1KYK3t-0000ZX-3b@fencepost.gnu.org>
References: <E1KW9NC-0003mM-6F@fencepost.gnu.org>
Cc: <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 14:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYK6Q-0006mQ-3g
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 14:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbYH0MZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 08:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbYH0MZR
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 08:25:17 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:42919 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbYH0MZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 08:25:15 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1KYK3t-0000ZX-3b; Wed, 27 Aug 2008 08:23:45 -0400
In-Reply-To: <E1KW9NC-0003mM-6F@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93888>

This hook provides a way to look at what kind of merge is invoked,
and stop it.  The type of merge is passed to the hook.

The patch provides a sample implementation that implements
a `branch.<branch-name>.allowmerges` key.  It can be useful for
project whose policy is "only fast forwards on the integrator's
repository".

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/githooks.txt        |   18 +++++
 builtin-merge.c                   |   65 +++++++++++++++----
 t/t5407-pre-merge-hook.sh         |  130 +++++++++++++++++++++++++++++++++++++
 templates/hooks--pre-merge.sample |   49 ++++++++++++++
 4 files changed, 250 insertions(+), 12 deletions(-)
 create mode 100755 t/t5407-pre-merge-hook.sh
 create mode 100755 templates/hooks--pre-merge.sample

	The only difference with respect to the previous version is
	that the trivial merge testcase passes.

	The follow-up at
	http://permalink.gmane.org/gmane.comp.version-control.git/93147
	is unchanged.

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 046a2a7..c45602c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -187,6 +187,24 @@ Both standard output and standard error output are forwarded to
 'git-send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
+pre-merge
+---------
+
+This hook is invoked before a merge is attempted.  The command
+line passed to the hook can have multiple parameters.  The
+first parameter is the type of merge, which can be one of
+"squash" (if --squash was given on the command line), "ff"
+(fast-forward), "trivial" (trivial in-index merge), "merge"
+(non-trivial 2-head merge), "octopus" (any other merge).  After this
+there is a "--" argument, followed by the commit SHA1 values for the
+heads being merged.
+
+The hook can interrupt the merge by returning a non-zero
+status.  The default hook checks for a boolean configuration
+key `branch.<branch-name>.allowmerges`, where `<branch-name>`
+is the current branch.  If the key is false, only squash or
+fast-forward merges are allowed.
+
 [[update]]
 update
 ------
diff --git a/builtin-merge.c b/builtin-merge.c
index a3b9b10..e7f3ece 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -298,12 +298,16 @@ static void squash_message(void)
 	strbuf_release(&out);
 }
 
-static int run_hook(const char *name)
+static int run_hook(const char *name, struct commit_list *heads, ...)
 {
 	struct child_process hook;
-	const char *argv[3], *env[2];
+	char **argv, *env[2];
 	char index[PATH_MAX];
+	va_list args;
+	int first_remote_head, i, rc;
 
+	va_start(args, heads);
+	argv = xmalloc((10 + commit_list_count(remoteheads)) * sizeof(char *));
 	argv[0] = git_path("hooks/%s", name);
 	if (access(argv[0], X_OK) < 0)
 		return 0;
@@ -312,19 +316,43 @@ static int run_hook(const char *name)
 	env[0] = index;
 	env[1] = NULL;
 
-	if (squash)
-		argv[1] = "1";
-	else
-		argv[1] = "0";
-	argv[2] = NULL;
+	i = 0;
+	do { 
+		/* "--" ovewrites the last string returned by va_arg, but we
+		   still have to reserve a slot for the final NULL in argv.  */
+	        if (++i >= 9)
+	                die("run_hook(): too many arguments");
+	        argv[i] = va_arg(args, char *);
+	} while (argv[i]);
+	va_end(args);
+
+	if (heads) {
+		argv[i] = "--";
+		first_remote_head = i + 1;
+		for (; heads; heads = heads->next)
+			argv[++i] = xstrdup(sha1_to_hex(heads->item->object.sha1));
+		argv[++i] = NULL;
+	} else
+		first_remote_head = i;
 
 	memset(&hook, 0, sizeof(hook));
-	hook.argv = argv;
+	hook.argv = (const char **) argv;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
-	hook.env = env;
+	hook.env = (const char **) env;
+
+	rc = run_command(&hook);
 
-	return run_command(&hook);
+	for (i = first_remote_head; argv[i]; i++)
+		free (argv[i]);
+	free (argv);
+	return rc;
+}
+
+static int run_pre_merge_hook(const char *kind)
+{
+	return run_hook("pre-merge", remoteheads,
+			squash ? "squash" : kind, "--", NULL);
 }
 
 static void finish(const unsigned char *new_head, const char *msg)
@@ -372,7 +400,7 @@ static void finish(const unsigned char *new_head, const char *msg)
 	}
 
 	/* Run a post-merge hook */
-	run_hook("post-merge");
+	run_hook("post-merge", NULL, squash ? "1" : "0", NULL);
 
 	strbuf_release(&reflog_message);
 }
@@ -877,6 +905,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
 		if (!remote_head)
 			die("%s - not something we can merge", argv[0]);
+		if (run_hook("pre-merge", NULL, "ff", "--",
+			     remote_head->sha1, NULL))
+			return 1;
+
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
 		reset_hard(remote_head->sha1, 0);
@@ -974,6 +1006,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
 
+		if (run_pre_merge_hook("ff"))
+			return 1;
+
 		printf("Updating %s..%s\n",
 			hex,
 			find_unique_abbrev(remoteheads->item->object.sha1,
@@ -1011,8 +1046,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			git_committer_info(IDENT_ERROR_ON_NO_NAME);
 			printf("Trying really trivial in-index merge...\n");
 			if (!read_tree_trivial(common->item->object.sha1,
-					head, remoteheads->item->object.sha1))
+					head, remoteheads->item->object.sha1)) {
+				if (run_pre_merge_hook("trivial"))
+					return 1;
 				return merge_trivial();
+			}
 			printf("Nope.\n");
 		}
 	} else {
@@ -1045,6 +1083,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (run_pre_merge_hook(remoteheads->next ? "octopus" : "merge"))
+		return 1;
+
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_ERROR_ON_NO_NAME);
 
diff --git a/t/t5407-pre-merge-hook.sh b/t/t5407-pre-merge-hook.sh
new file mode 100755
index 0000000..b7029ce
--- /dev/null
+++ b/t/t5407-pre-merge-hook.sh
@@ -0,0 +1,130 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Paolo Bonzini
+#
+
+test_description='Test the pre-merge hook.'
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo Data for commit0. >a &&
+	echo a >>a &&
+	echo b >>a &&
+	echo c >>a &&
+	git add a &&
+	git commit -m"setup" &&
+	commit0=$(git rev-parse HEAD) &&
+
+	git checkout -b branch1 &&
+	echo Data for branch1. >b &&
+	git add b &&
+	git commit -m"setup branch1" &&
+	git checkout master &&
+
+	git checkout -b branch2 &&
+	echo Data for branch2. >c &&
+	git add c &&
+	git commit -m"setup branch2" &&
+	git checkout master &&
+
+	git checkout -b branch3 &&
+	echo Changed data for branch3. >a &&
+	echo a >>a &&
+	echo b >>a &&
+	echo c >>a &&
+	git commit -m"setup branch3" a &&
+	git checkout master &&
+
+	git checkout -b branch4 &&
+	echo Data for commit0. >a &&
+	echo a >>a &&
+	echo b >>a &&
+	echo c for branch4 >>a &&
+	git commit -m"setup branch4" a &&
+	git checkout master
+'
+
+mkdir .git/hooks
+cat >.git/hooks/pre-merge <<'EOF'
+#!/bin/sh
+echo $# $1 $2 >> $GIT_DIR/pre-merge.args
+EOF
+chmod u+x .git/hooks/pre-merge
+
+test_expect_success 'pre-merge runs as expected ' '
+	rm -f .git/pre-merge.args &&
+	git reset --hard $commit0 &&
+	git merge branch1 &&
+	test -e .git/pre-merge.args
+'
+
+test_expect_success 'pre-merge from fast-forward merge receives the right argument ' '
+	test "`cat .git/pre-merge.args`" = "4 ff --"
+'
+
+test_expect_success 'pre-merge from squash merge receives the right argument ' '
+	rm -f .git/pre-merge.args &&
+	git reset --hard $commit0 &&
+	git merge --squash branch1 &&
+	test "`cat .git/pre-merge.args`" = "4 squash --"
+'
+
+test_expect_success 'pre-merge from trivial merge receives the right argument ' '
+	rm -f .git/pre-merge.args &&
+	git checkout $(git rev-parse branch1) &&
+	git merge --no-ff -s resolve branch1 &&
+	test "`cat .git/pre-merge.args`" = "4 trivial --"
+'
+
+test_expect_success 'pre-merge from real merge receives the right argument ' '
+	rm -f .git/pre-merge.args &&
+	git reset --hard branch3 &&
+	git merge --no-ff branch4 &&
+	test "`cat .git/pre-merge.args`" = "4 merge --"
+'
+
+test_expect_success 'pre-merge from octopus merge receives the right argument ' '
+	rm -f .git/pre-merge.args &&
+	git reset --hard $commit0 &&
+	git merge branch1 branch2 branch3 &&
+	test "`cat .git/pre-merge.args`" = "6 octopus --"
+'
+
+test_expect_success 'pre-merge into empty head receives the right argument ' '
+	# Here we use a subshell so that the next tests have the right
+	# cwd if this test fails.
+	mkdir second &&
+	(cd second &&
+	git init &&
+	cp ../.git/hooks/pre-merge .git/hooks/pre-merge &&
+	chmod u+x .git/hooks/pre-merge &&
+	git fetch .. &&
+	git merge $commit0 &&
+	test "`cat .git/pre-merge.args`" = "3 ff --" &&
+	cd .. &&
+	rm -rf second)
+'
+
+test_expect_success 'pre-merge does not run for up-to-date ' '
+	rm -f .git/pre-merge.args &&
+	git merge $commit0 &&
+	! test -f .git/pre-merge.args
+'
+
+test_expect_success 'pre-merge does not run for up-to-date octopus ' '
+	rm -f .git/pre-merge.args &&
+	git merge branch1 branch2 branch3 &&
+	! test -f .git/pre-merge.args
+'
+
+cat >.git/hooks/pre-merge <<'EOF'
+#!/bin/sh
+exit 1
+EOF
+chmod u+x .git/hooks/pre-merge
+
+test_expect_success 'pre-merge can stop merge ' '
+	! git merge --no-ff branch4
+'
+
+test_done
diff --git a/templates/hooks--pre-merge.sample b/templates/hooks--pre-merge.sample
new file mode 100755
index 0000000..bf2e82c
--- /dev/null
+++ b/templates/hooks--pre-merge.sample
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# An example hook script to block merges on same branches.
+# Called by git-merge with arguments: type -- head remote1 remote2...
+#
+# To enable this hook, rename this file to "pre-merge".
+#
+# Config
+# ------
+# branch.<branch-name>.allowmerges
+#   This boolean sets whether merges will be allowed for the
+#   given branch in the repository.  By default they will be.
+
+# --- Command line
+type="$1"
+
+# --- Safety check
+if [ -z "$GIT_DIR" ]; then
+	echo "Don't run this script from the command line." >&2
+	echo " (if you want, you could supply GIT_DIR then run" >&2
+	echo "  $0 <type> -- <head>...)" >&2
+	exit 1
+fi
+
+if [ -z "$type" ]; then
+	echo "Usage: $0 <type> -- <head>..." >&2
+	exit 1
+fi
+
+# --- Examine repository state
+head=`git symbolic-ref HEAD 2>/dev/null || echo detached`
+
+# --- Do the actual check
+case "$head,$type" in
+	detached,* | *,squash | *,ff)
+		;;
+	refs/heads/*)
+		allowmerges=$(git config --bool branch.${head#refs/heads/}.allowmerges)
+		test "$allowmerges" = false && {
+			echo Merge commits not allowed on this branch.
+			exit 1
+		}
+		;;
+	*)
+		;;
+esac
+
+# --- Finished
+exit 0
-- 
1.5.5
