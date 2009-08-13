From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 5/6] Implement 'git checkout --patch'
Date: Thu, 13 Aug 2009 14:29:43 +0200
Message-ID: <b75f4adebf7f417b8c46746202933e8f7ff80331.1250164190.git.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <cover.1250164190.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZSB-0002tc-1Y
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZHMMa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754389AbZHMMaW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:30:22 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54458 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357AbZHMMaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:30:14 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:09 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:01 +0200
X-Mailer: git-send-email 1.6.4.262.gbda8
In-Reply-To: <cover.1250164190.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125815>

This introduces a --patch mode for git-checkout.  In the index usage

  git checkout --patch -- [files...]

it lets the user discard edits from the <files> at the granularity of
hunks (by selecting hunks from 'git diff' and then reverse applying
them to the worktree).

We also accept a revision argument.  In the case

  git checkout --patch HEAD -- [files...]

we offer hunks from the difference between HEAD and the worktree, and
reverse applies them to both index and worktree, allowing you to
discard staged changes completely.  In the non-HEAD usage

  git checkout --patch <revision> -- [files...]

it offers hunks from the difference between the worktree and
<revision>.  The chosen hunks are then applied to both index and
worktree.

The application to worktree and index is done "atomically" in the
sense that we first check if the patch applies to the index (it should
always apply to the worktree).  If it does not, we give the user a
choice to either abort or apply to the worktree anyway.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-checkout.txt |   13 +++++-
 builtin-checkout.c             |   19 +++++++
 git-add--interactive.perl      |   61 +++++++++++++++++++++++
 t/t2015-checkout-patch.sh      |  107 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+), 1 deletions(-)
 create mode 100755 t/t2015-checkout-patch.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ad4b31e..26a5447 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [<branch>]
 'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
+'git checkout' --patch [<tree-ish>] [--] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -25,7 +26,7 @@ use the --track or --no-track options, which will be passed to `git
 branch`.  As a convenience, --track without `-b` implies branch
 creation; see the description of --track below.
 
-When <paths> are given, this command does *not* switch
+When <paths> or --patch are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
 the index file, or from a named <tree-ish> (most often a commit).  In
 this case, the `-b` and `--track` options are meaningless and giving
@@ -113,6 +114,16 @@ the conflicted merge in the specified paths.
 	"merge" (default) and "diff3" (in addition to what is shown by
 	"merge" style, shows the original contents).
 
+-p::
+--patch::
+	Interactively select hunks in the difference between the
+	<tree-ish> (or the index, if unspecified) and the working
+	tree.  The chosen hunks are then applied in reverse to the
+	working tree (and if a <tree-ish> was specified, the index).
++
+This means that you can use `git checkout -p` to selectively discard
+edits from your current working tree.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 8a9a474..8b942ba 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -572,6 +572,13 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	return git_xmerge_config(var, value, cb);
 }
 
+static int interactive_checkout(const char *revision, const char **pathspec,
+				struct checkout_opts *opts)
+{
+	return run_add_interactive(revision, "--patch=checkout", pathspec);
+}
+
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -580,6 +587,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct branch_info new;
 	struct tree *source_tree = NULL;
 	char *conflict_style = NULL;
+	int patch_mode = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
@@ -594,6 +602,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
+		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
 		OPT_END(),
 	};
 	int has_dash_dash;
@@ -608,6 +617,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (patch_mode && (opts.track > 0 || opts.new_branch
+			   || opts.new_branch_log || opts.merge || opts.force))
+		die ("--patch is incompatible with all other options");
+
 	/* --track without -b should DWIM */
 	if (0 < opts.track && !opts.new_branch) {
 		const char *argv0 = argv[0];
@@ -714,6 +727,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		if (!pathspec)
 			die("invalid path specification");
 
+		if (patch_mode)
+			return interactive_checkout(new.name, pathspec, &opts);
+
 		/* Checkout paths */
 		if (opts.new_branch) {
 			if (argc == 1) {
@@ -729,6 +745,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		return checkout_paths(source_tree, pathspec, &opts);
 	}
 
+	if (patch_mode)
+		return interactive_checkout(new.name, NULL, &opts);
+
 	if (opts.new_branch) {
 		struct strbuf buf = STRBUF_INIT;
 		if (strbuf_check_branch_ref(&buf, opts.new_branch))
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f040249..9c202fc 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -75,6 +75,7 @@
 my $patch_mode_revision;
 
 sub apply_patch;
+sub apply_patch_for_checkout_commit;
 
 my %patch_modes = (
 	'stage' => {
@@ -104,6 +105,33 @@
 		PARTICIPLE => 'applying',
 		FILTER => 'index-only',
 	},
+	'checkout_index' => {
+		DIFF => 'diff-files -p',
+		APPLY => sub { apply_patch 'apply -R', @_; },
+		APPLY_CHECK => 'apply -R',
+		VERB => 'Discard',
+		TARGET => ' from worktree',
+		PARTICIPLE => 'discarding',
+		FILTER => 'file-only',
+	},
+	'checkout_head' => {
+		DIFF => 'diff-index -p',
+		APPLY => sub { apply_patch_for_checkout_commit '-R', @_ },
+		APPLY_CHECK => 'apply',
+		VERB => 'Discard',
+		TARGET => ' from index and worktree',
+		PARTICIPLE => 'discarding',
+		FILTER => undef,
+	},
+	'checkout_nothead' => {
+		DIFF => 'diff-index -R -p',
+		APPLY => sub { apply_patch_for_checkout_commit '', @_ },
+		APPLY_CHECK => 'apply',
+		VERB => 'Apply',
+		TARGET => ' to index and worktree',
+		PARTICIPLE => 'applying',
+		FILTER => undef,
+	},
 );
 
 my %patch_mode_flavour = %{$patch_modes{stage}};
@@ -1069,6 +1097,29 @@
 	return $ret;
 }
 
+sub apply_patch_for_checkout_commit {
+	my $reverse = shift;
+	my $applies_index = run_git_apply 'apply '.$reverse.' --cached --recount --check', @_;
+	my $applies_worktree = run_git_apply 'apply '.$reverse.' --recount --check', @_;
+
+	if ($applies_worktree && $applies_index) {
+		run_git_apply 'apply '.$reverse.' --cached --recount', @_;
+		run_git_apply 'apply '.$reverse.' --recount', @_;
+		return 1;
+	} elsif (!$applies_index) {
+		print colored $error_color, "The selected hunks do not apply to the index!\n";
+		if (prompt_yesno "Apply them to the worktree anyway? ") {
+			return run_git_apply 'apply '.$reverse.' --recount', @_;
+		} else {
+			print colored $error_color, "Nothing was applied.\n";
+			return 0;
+		}
+	} else {
+		print STDERR @_;
+		return 0;
+	}
+}
+
 sub patch_update_cmd {
 	my @all_mods = list_modified($patch_mode_flavour{FILTER});
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
@@ -1432,6 +1483,16 @@
 						       'reset_head' : 'reset_nothead');
 					$arg = shift @ARGV or die "missing --";
 				}
+			} elsif ($1 eq 'checkout') {
+				$arg = shift @ARGV or die "missing --";
+				if ($arg eq '--') {
+					$patch_mode = 'checkout_index';
+				} else {
+					$patch_mode_revision = $arg;
+					$patch_mode = ($arg eq 'HEAD' ?
+						       'checkout_head' : 'checkout_nothead');
+					$arg = shift @ARGV or die "missing --";
+				}
 			} elsif ($1 eq 'stage') {
 				$patch_mode = 'stage';
 				$arg = shift @ARGV or die "missing --";
diff --git a/t/t2015-checkout-patch.sh b/t/t2015-checkout-patch.sh
new file mode 100755
index 0000000..4d1c2e9
--- /dev/null
+++ b/t/t2015-checkout-patch.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description='git checkout --patch'
+
+. ./lib-patch-mode.sh
+
+test_expect_success 'setup' '
+	mkdir dir &&
+	echo parent > dir/foo &&
+	echo dummy > bar &&
+	git add bar dir/foo &&
+	git commit -m initial &&
+	test_tick &&
+	test_commit second dir/foo head &&
+	set_and_save_state bar bar_work bar_index &&
+	save_head
+'
+
+# note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
+
+test_expect_success 'saying "n" does nothing' '
+	set_and_save_state dir/foo work head &&
+	(echo n; echo n) | git checkout -p &&
+	verify_saved_state bar &&
+	verify_saved_state dir/foo
+'
+
+test_expect_success 'git checkout -p' '
+	(echo n; echo y) | git checkout -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success 'git checkout -p with staged changes' '
+	set_state dir/foo work index
+	(echo n; echo y) | git checkout -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo index index
+'
+
+test_expect_success 'git checkout -p HEAD with NO staged changes: abort' '
+	set_and_save_state dir/foo work head &&
+	(echo n; echo y; echo n) | git checkout -p HEAD &&
+	verify_saved_state bar &&
+	verify_saved_state dir/foo
+'
+
+test_expect_success 'git checkout -p HEAD with NO staged changes: apply' '
+	(echo n; echo y; echo y) | git checkout -p HEAD &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success 'git checkout -p HEAD with change already staged' '
+	set_state dir/foo index index
+	# the third n is to get out in case it mistakenly does not apply
+	(echo n; echo y; echo n) | git checkout -p HEAD &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success 'git checkout -p HEAD^' '
+	# the third n is to get out in case it mistakenly does not apply
+	(echo n; echo y; echo n) | git checkout -p HEAD^ &&
+	verify_saved_state bar &&
+	verify_state dir/foo parent parent
+'
+
+# The idea in the rest is that bar sorts first, so we always say 'y'
+# first and if the path limiter fails it'll apply to bar instead of
+# dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
+# the failure case (and thus get out of the loop).
+
+test_expect_success 'path limiting works: dir' '
+	set_state dir/foo work head &&
+	(echo y; echo n) | git checkout -p dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success 'path limiting works: -- dir' '
+	set_state dir/foo work head &&
+	(echo y; echo n) | git checkout -p -- dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success 'path limiting works: HEAD^ -- dir' '
+	# the third n is to get out in case it mistakenly does not apply
+	(echo y; echo n; echo n) | git checkout -p HEAD^ -- dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo parent parent
+'
+
+test_expect_success 'path limiting works: foo inside dir' '
+	set_state dir/foo work head &&
+	# the third n is to get out in case it mistakenly does not apply
+	(echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success 'none of this moved HEAD' '
+	verify_saved_head
+'
+
+test_done
-- 
1.6.4.262.gbda8
