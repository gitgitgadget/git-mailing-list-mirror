From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 4/6] Implement 'git reset --patch'
Date: Thu, 13 Aug 2009 14:29:42 +0200
Message-ID: <f3b8fdbcf451fe28786ed221d02717e28423e6dd.1250164190.git.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <cover.1250164190.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZS9-0002tc-Hj
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbZHMMaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbZHMMaV
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:30:21 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54458 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbZHMMaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:30:13 -0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125810>

This introduces a --patch mode for git-reset.  The basic case is

  git reset --patch -- [files...]

which acts as the opposite of 'git add --patch -- [files...]': it
offers hunks for *un*staging.  Advanced usage is

  git reset --patch <revision> -- [files...]

which offers hunks from the diff between the index and <revision> for
forward application to the index.  (That is, the basic case is just
<revision> = HEAD.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |   15 ++++++++-
 builtin-reset.c             |   19 ++++++++++++
 git-add--interactive.perl   |   57 +++++++++++++++++++++++++++++++++--
 t/t7105-reset-patch.sh      |   69 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 6 deletions(-)
 create mode 100755 t/t7105-reset-patch.sh

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index abb25d1..469cf6d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git reset' [--mixed | --soft | --hard | --merge] [-q] [<commit>]
 'git reset' [-q] [<commit>] [--] <paths>...
+'git reset' --patch [<commit>] [--] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -23,8 +24,9 @@ the undo in the history.
 If you want to undo a commit other than the latest on a branch,
 linkgit:git-revert[1] is your friend.
 
-The second form with 'paths' is used to revert selected paths in
-the index from a given commit, without moving HEAD.
+The second and third forms with 'paths' and/or --patch are used to
+revert selected paths in the index from a given commit, without moving
+HEAD.
 
 
 OPTIONS
@@ -50,6 +52,15 @@ OPTIONS
 	and updates the files that are different between the named commit
 	and the current commit in the working tree.
 
+-p::
+--patch::
+	Interactively select hunks in the difference between the index
+	and <commit> (defaults to HEAD).  The chosen hunks are applied
+	in reverse to the index.
++
+This means that `git reset -p` is the opposite of `git add -p` (see
+linkgit:git-add[1]).
+
 -q::
 	Be quiet, only report errors.
 
diff --git a/builtin-reset.c b/builtin-reset.c
index 5fa1789..246a127 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -142,6 +142,17 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	}
 }
 
+static int interactive_reset(const char *revision, const char **argv,
+			     const char *prefix)
+{
+	const char **pathspec = NULL;
+
+	if (*argv)
+		pathspec = get_pathspec(prefix, argv);
+
+	return run_add_interactive(revision, "--patch=reset", pathspec);
+}
+
 static int read_from_tree(const char *prefix, const char **argv,
 		unsigned char *tree_sha1, int refresh_flags)
 {
@@ -183,6 +194,7 @@ static void prepend_reflog_action(const char *action, char *buf, size_t size)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int patch_mode = 0;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
@@ -198,6 +210,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", MERGE),
 		OPT_BOOLEAN('q', NULL, &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
+		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
 		OPT_END()
 	};
 
@@ -251,6 +264,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die("Could not parse object '%s'.", rev);
 	hashcpy(sha1, commit->object.sha1);
 
+	if (patch_mode) {
+		if (reset_type != NONE)
+			die("--patch is incompatible with --{hard,mixed,soft}");
+		return interactive_reset(rev, argv + i, prefix);
+	}
+
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3606103..f040249 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -72,6 +72,7 @@
 
 # command line options
 my $patch_mode;
+my $patch_mode_revision;
 
 sub apply_patch;
 
@@ -85,6 +86,24 @@
 		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
 	},
+	'reset_head' => {
+		DIFF => 'diff-index -p --cached',
+		APPLY => sub { apply_patch 'apply -R --cached', @_; },
+		APPLY_CHECK => 'apply -R --cached',
+		VERB => 'Unstage',
+		TARGET => '',
+		PARTICIPLE => 'unstaging',
+		FILTER => 'index-only',
+	},
+	'reset_nothead' => {
+		DIFF => 'diff-index -p --cached',
+		APPLY => sub { apply_patch 'apply -R --cached', @_; },
+		APPLY_CHECK => 'apply -R --cached',
+		VERB => 'Apply',
+		TARGET => ' to index',
+		PARTICIPLE => 'applying',
+		FILTER => 'index-only',
+	},
 );
 
 my %patch_mode_flavour = %{$patch_modes{stage}};
@@ -206,7 +225,14 @@
 		return if (!@tracked);
 	}
 
-	my $reference = is_initial_commit() ? get_empty_tree() : 'HEAD';
+	my $reference;
+	if (defined $patch_mode_revision and $patch_mode_revision ne 'HEAD') {
+		$reference = $patch_mode_revision;
+	} elsif (is_initial_commit()) {
+		$reference = get_empty_tree();
+	} else {
+		$reference = 'HEAD';
+	}
 	for (run_cmd_pipe(qw(git diff-index --cached
 			     --numstat --summary), $reference,
 			     '--', @tracked)) {
@@ -640,6 +666,9 @@
 sub parse_diff {
 	my ($path) = @_;
 	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
+	if (defined $patch_mode_revision) {
+		push @diff_cmd, $patch_mode_revision;
+	}
 	my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
 	my @colored = ();
 	if ($diff_use_color) {
@@ -1391,11 +1420,31 @@
 sub process_args {
 	return unless @ARGV;
 	my $arg = shift @ARGV;
-	if ($arg eq "--patch") {
-		$patch_mode = 1;
-		$arg = shift @ARGV or die "missing --";
+	if ($arg =~ /--patch(?:=(.*))?/) {
+		if (defined $1) {
+			if ($1 eq 'reset') {
+				$patch_mode = 'reset_head';
+				$patch_mode_revision = 'HEAD';
+				$arg = shift @ARGV or die "missing --";
+				if ($arg ne '--') {
+					$patch_mode_revision = $arg;
+					$patch_mode = ($arg eq 'HEAD' ?
+						       'reset_head' : 'reset_nothead');
+					$arg = shift @ARGV or die "missing --";
+				}
+			} elsif ($1 eq 'stage') {
+				$patch_mode = 'stage';
+				$arg = shift @ARGV or die "missing --";
+			} else {
+				die "unknown --patch mode: $1";
+			}
+		} else {
+			$patch_mode = 'stage';
+			$arg = shift @ARGV or die "missing --";
+		}
 		die "invalid argument $arg, expecting --"
 		    unless $arg eq "--";
+		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
 	}
 	elsif ($arg ne "--") {
 		die "invalid argument $arg, expecting --";
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
new file mode 100755
index 0000000..c1f4fc3
--- /dev/null
+++ b/t/t7105-reset-patch.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='git reset --patch'
+. ./lib-patch-mode.sh
+
+test_expect_success 'setup' '
+	mkdir dir &&
+	echo parent > dir/foo &&
+	echo dummy > bar &&
+	git add dir &&
+	git commit -m initial &&
+	test_tick &&
+	test_commit second dir/foo head &&
+	set_and_save_state bar bar_work bar_index &&
+	save_head
+'
+
+# note: bar sorts before foo, so the first 'n' is always to skip 'bar'
+
+test_expect_success 'saying "n" does nothing' '
+	set_and_save_state dir/foo work work
+	(echo n; echo n) | git reset -p &&
+	verify_saved_state dir/foo &&
+	verify_saved_state bar
+'
+
+test_expect_success 'git reset -p' '
+	(echo n; echo y) | git reset -p &&
+	verify_state dir/foo work head &&
+	verify_saved_state bar
+'
+
+test_expect_success 'git reset -p HEAD^' '
+	(echo n; echo y) | git reset -p HEAD^ &&
+	verify_state dir/foo work parent &&
+	verify_saved_state bar
+'
+
+# The idea in the rest is that bar sorts first, so we always say 'y'
+# first and if the path limiter fails it'll apply to bar instead of
+# dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
+# the failure case (and thus get out of the loop).
+
+test_expect_success 'git reset -p dir' '
+	set_state dir/foo work work
+	(echo y; echo n) | git reset -p dir &&
+	verify_state dir/foo work head &&
+	verify_saved_state bar
+'
+
+test_expect_success 'git reset -p -- foo (inside dir)' '
+	set_state dir/foo work work
+	(echo y; echo n) | (cd dir && git reset -p -- foo) &&
+	verify_state dir/foo work head &&
+	verify_saved_state bar
+'
+
+test_expect_success 'git reset -p HEAD^ -- dir' '
+	(echo y; echo n) | git reset -p HEAD^ -- dir &&
+	verify_state dir/foo work parent &&
+	verify_saved_state bar
+'
+
+test_expect_success 'none of this moved HEAD' '
+	verify_saved_head
+'
+
+
+test_done
-- 
1.6.4.262.gbda8
