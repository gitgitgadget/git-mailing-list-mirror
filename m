From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 4/5] Implement 'git checkout --patch'
Date: Sat, 25 Jul 2009 23:29:33 +0200
Message-ID: <93da49abd5fc514906bac73553d6802eb7fb69fd.1248557241.git.trast@student.ethz.ch>
References: <7vzlat64u1.fsf@alter.siamese.dyndns.org> <cover.1248557241.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 23:30:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUooi-00037K-A4
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbZGYVaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZGYVaA
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:30:00 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9118 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946AbZGYV3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 17:29:48 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:45 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:44 +0200
X-Mailer: git-send-email 1.6.4.rc2.227.gf5e17
In-Reply-To: <cover.1248557241.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 25 Jul 2009 21:29:44.0842 (UTC) FILETIME=[074BCEA0:01CA0D6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124080>

This introduces a --patch mode for git-checkout.  In the index usage

  git checkout --patch -- [files...]

it lets the user discard edits from the <files> at the granularity of
hunks (by selecting hunks from 'git diff' and then reverse applying
them to the worktree).

We also accept a revision argument

  git checkout --patch <revision> -- [files...]

which offers hunks from the difference between the <revision> and the
worktree.  The chosen hunks are then reverse applied to both index and
worktree, discarding them completely.  This application is done
"atomically" in the sense that we first check if the patch applies to
the index (it should always apply to the worktree).  If it does not,
we give the user a choice to either abort or apply to the worktree
anyway.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-checkout.txt |   13 ++++++++++-
 builtin-checkout.c             |   19 +++++++++++++++
 git-add--interactive.perl      |   48 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletions(-)

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
index 446cac7..7d57741 100644
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
+			return interactive_checkout(NULL, pathspec, &opts);
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
index b1aa846..5005a8d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -75,6 +75,7 @@
 my $patch_mode_revision;
 
 sub apply_patch;
+sub apply_patch_for_checkout_commit;
 
 my %patch_modes = (
 	'stage' => {
@@ -93,6 +94,22 @@
 		PARTICIPLE => 'resetting',
 		FILTER => 'index-only',
 	},
+	'checkout_index' => {
+		DIFF => 'diff-files -p',
+		APPLY => sub { apply_patch 'apply -R', @_; },
+		APPLY_CHECK => 'apply -R',
+		VERB => 'Check out',
+		PARTICIPLE => 'checking out',
+		FILTER => 'file-only',
+	},
+	'checkout_commit' => {
+		DIFF => 'diff-files -p',
+		APPLY => \&apply_patch_for_checkout_commit,
+		APPLY_CHECK => 'apply -R',
+		VERB => 'Check out',
+		PARTICIPLE => 'checking out',
+		FILTER => undef,
+	},
 );
 
 my %patch_mode_flavour = %{$patch_modes{stage}};
@@ -1050,6 +1067,28 @@
 	return $ret;
 }
 
+sub apply_patch_for_checkout_commit {
+	my $applies_index = run_git_apply 'apply -R --cached --recount --check', @_;
+	my $applies_worktree = run_git_apply 'apply -R --recount --check', @_;
+
+	if ($applies_worktree && $applies_index) {
+		run_git_apply 'apply -R --cached --recount', @_;
+		run_git_apply 'apply -R --recount', @_;
+		return 1;
+	} elsif (!$applies_index) {
+		print colored $error_color, "The selected hunks do not apply to the index tree!\n";
+		if (prompt_yesno "Apply them to the worktree anyway? ") {
+			return run_git_apply 'apply -R --recount', @_;
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
@@ -1410,6 +1449,15 @@
 					$patch_mode_revision = $arg;
 					$arg = shift @ARGV or die "missing --";
 				}
+			} elsif ($1 eq 'checkout') {
+				$arg = shift @ARGV or die "missing --";
+				if ($arg eq '--') {
+					$patch_mode = 'checkout_index';
+				} else {
+					$patch_mode = 'checkout_commit';
+					$patch_mode_revision = $arg;
+					$arg = shift @ARGV or die "missing --";
+				}
 			} elsif ($1 eq 'stage') {
 				$patch_mode = 'stage';
 				$arg = shift @ARGV or die "missing --";
-- 
1.6.4.rc2.227.gf5e17
