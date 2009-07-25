From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 3/5] Implement 'git reset --patch'
Date: Sat, 25 Jul 2009 23:29:32 +0200
Message-ID: <9a85f03f0205fd97ee9dd11d1f11c94be063aa40.1248557241.git.trast@student.ethz.ch>
References: <7vzlat64u1.fsf@alter.siamese.dyndns.org> <cover.1248557241.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 23:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUooh-00037K-Ip
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbZGYV36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbZGYV3u
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:29:50 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9118 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbZGYV3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 17:29:47 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:45 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:44 +0200
X-Mailer: git-send-email 1.6.4.rc2.227.gf5e17
In-Reply-To: <cover.1248557241.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 25 Jul 2009 21:29:44.0561 (UTC) FILETIME=[0720EE10:01CA0D6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124077>

This introduces a --patch mode for git-reset.  The basic case is

  git reset --patch -- [files...]

which acts as the opposite of 'git add --patch -- [files...]': it
offers hunks for *un*staging.  Advanced usage is

  git reset --patch <revision> -- [files...]

which offers hunks from the diff between <revision> and the index for
reverse application to the index.  (That is, the basic case is just
<revision> = HEAD.)  This means it can be used to "undo" changes since
<revision> in the index, but may be slightly confusing when <revision>
is logically "newer" than the index state.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |   15 +++++++++++++--
 builtin-reset.c             |   15 +++++++++++++++
 git-add--interactive.perl   |   36 +++++++++++++++++++++++++++++++++---
 3 files changed, 61 insertions(+), 5 deletions(-)

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
index 5fa1789..e4fef5d 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -142,6 +142,13 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	}
 }
 
+static int interactive_reset(const char *revision, const char **argv,
+			     const char *prefix)
+{
+	return run_add_interactive(revision, "--patch=reset",
+				   get_pathspec(prefix, argv));
+}
+
 static int read_from_tree(const char *prefix, const char **argv,
 		unsigned char *tree_sha1, int refresh_flags)
 {
@@ -183,6 +190,7 @@ static void prepend_reflog_action(const char *action, char *buf, size_t size)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int patch_mode = 0;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
@@ -198,6 +206,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", MERGE),
 		OPT_BOOLEAN('q', NULL, &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
+		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
 		OPT_END()
 	};
 
@@ -251,6 +260,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die("Could not parse object '%s'.", rev);
 	hashcpy(sha1, commit->object.sha1);
 
+	if (patch_mode) {
+		if (reset_type != NONE)
+			die("--patch is incompatible with --{hard,mixed,soft}");
+		return interactive_reset(rev, argv, prefix);
+	}
+
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 58c3332..b1aa846 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -72,6 +72,7 @@
 
 # command line options
 my $patch_mode;
+my $patch_mode_revision;
 
 sub apply_patch;
 
@@ -84,6 +85,14 @@
 		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
 	},
+	'reset' => {
+		DIFF => 'diff-index -p --cached',
+		APPLY => sub { apply_patch 'apply -R --cached', @_; },
+		APPLY_CHECK => 'apply -R --cached',
+		VERB => 'Reset',
+		PARTICIPLE => 'resetting',
+		FILTER => 'index-only',
+	},
 );
 
 my %patch_mode_flavour = %{$patch_modes{stage}};
@@ -639,6 +648,9 @@
 sub parse_diff {
 	my ($path) = @_;
 	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
+	if (defined $patch_mode_revision) {
+		push @diff_cmd, $patch_mode_revision;
+	}
 	my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
 	my @colored = ();
 	if ($diff_use_color) {
@@ -1388,11 +1400,29 @@
 sub process_args {
 	return unless @ARGV;
 	my $arg = shift @ARGV;
-	if ($arg eq "--patch") {
-		$patch_mode = 1;
-		$arg = shift @ARGV or die "missing --";
+	if ($arg =~ /--patch(?:=(.*))?/) {
+		if (defined $1) {
+			if ($1 eq 'reset') {
+				$patch_mode = 'reset';
+				$patch_mode_revision = 'HEAD';
+				$arg = shift @ARGV or die "missing --";
+				if ($arg ne '--') {
+					$patch_mode_revision = $arg;
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
-- 
1.6.4.rc2.227.gf5e17
