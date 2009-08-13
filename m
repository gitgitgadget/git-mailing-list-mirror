From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 1/6] git-apply--interactive: Refactor patch mode code
Date: Thu, 13 Aug 2009 14:29:39 +0200
Message-ID: <d7c4f69f13bf6939e37f2cd43752943108a7071d.1250164190.git.trast@student.ethz.ch>
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
	id 1MbZS8-0002tc-Pw
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbZHMMaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbZHMMaS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:30:18 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54458 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbZHMMaL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:30:11 -0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125813>

This makes some aspects of the 'git add -p' loop configurable (within
the code), so that we can later reuse git-add--interactive for other
similar tools.

Most fields are fairly straightforward, but APPLY gets a subroutine
(instead of just a string a la 'apply --cached') so that we can handle
'checkout -p', which will need to atomically apply the patch twice
(index and worktree).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-add--interactive.perl |   82 ++++++++++++++++++++++++++++++---------------
 1 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index df9f231..3606103 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -73,6 +73,22 @@
 # command line options
 my $patch_mode;
 
+sub apply_patch;
+
+my %patch_modes = (
+	'stage' => {
+		DIFF => 'diff-files -p',
+		APPLY => sub { apply_patch 'apply --cached', @_; },
+		APPLY_CHECK => 'apply --cached',
+		VERB => 'Stage',
+		TARGET => '',
+		PARTICIPLE => 'staging',
+		FILTER => 'file-only',
+	},
+);
+
+my %patch_mode_flavour = %{$patch_modes{stage}};
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32' || $^O eq 'msys') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -613,12 +629,21 @@
 	print "\n";
 }
 
+sub run_git_apply {
+	my $cmd = shift;
+	my $fh;
+	open $fh, '| git ' . $cmd;
+	print $fh @_;
+	return close $fh;
+}
+
 sub parse_diff {
 	my ($path) = @_;
-	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
+	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
+	my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
 	my @colored = ();
 	if ($diff_use_color) {
-		@colored = run_cmd_pipe(qw(git diff-files -p --color --), $path);
+		@colored = run_cmd_pipe("git", @diff_cmd, qw(--color --), $path);
 	}
 	my (@hunk) = { TEXT => [], DISPLAY => [], TYPE => 'header' };
 
@@ -877,6 +902,7 @@
 		or die "failed to open hunk edit file for writing: " . $!;
 	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
 	print $fh @$oldtext;
+	my $participle = $patch_mode_flavour{PARTICIPLE};
 	print $fh <<EOF;
 # ---
 # To remove '-' lines, make them ' ' lines (context).
@@ -884,7 +910,7 @@
 # Lines starting with # will be removed.
 #
 # If the patch applies cleanly, the edited hunk will immediately be
-# marked for staging. If it does not apply cleanly, you will be given
+# marked for $participle. If it does not apply cleanly, you will be given
 # an opportunity to edit again. If all lines of the hunk are removed,
 # then the edit is aborted and the hunk is left unchanged.
 EOF
@@ -918,11 +944,8 @@
 
 sub diff_applies {
 	my $fh;
-	open $fh, '| git apply --recount --cached --check';
-	for my $h (@_) {
-		print $fh @{$h->{TEXT}};
-	}
-	return close $fh;
+	return run_git_apply($patch_mode_flavour{APPLY_CHECK} . ' --recount --check',
+			     map { @{$_->{TEXT}} } @_);
 }
 
 sub _restore_terminal_and_die {
@@ -988,12 +1011,14 @@
 }
 
 sub help_patch_cmd {
-	print colored $help_color, <<\EOF ;
-y - stage this hunk
-n - do not stage this hunk
-q - quit, do not stage this hunk nor any of the remaining ones
-a - stage this and all the remaining hunks in the file
-d - do not stage this hunk nor any of the remaining hunks in the file
+	my $verb = lc $patch_mode_flavour{VERB};
+	my $target = $patch_mode_flavour{TARGET};
+	print colored $help_color, <<EOF ;
+y - $verb this hunk$target
+n - do not $verb this hunk$target
+q - quit, do not $verb this hunk nor any of the remaining ones
+a - $verb this and all the remaining hunks in the file
+d - do not $verb this hunk nor any of the remaining hunks in the file
 g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
@@ -1006,8 +1031,17 @@
 EOF
 }
 
+sub apply_patch {
+	my $cmd = shift;
+	my $ret = run_git_apply $cmd . ' --recount', @_;
+	if (!$ret) {
+		print STDERR @_;
+	}
+	return $ret;
+}
+
 sub patch_update_cmd {
-	my @all_mods = list_modified('file-only');
+	my @all_mods = list_modified($patch_mode_flavour{FILTER});
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
@@ -1138,8 +1172,9 @@
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, 'Stage ',
-		  ($hunk[$ix]{TYPE} eq 'mode' ? 'mode change' : 'this hunk'),
+		print colored $prompt_color, $patch_mode_flavour{VERB},
+		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' : ' this hunk'),
+		  $patch_mode_flavour{TARGET},
 		  " [y,n,q,a,d,/$other,?]? ";
 		my $line = prompt_single_character;
 		if ($line) {
@@ -1313,16 +1348,9 @@
 
 	if (@result) {
 		my $fh;
-
-		open $fh, '| git apply --cached --recount';
-		for (@{$head->{TEXT}}, @result) {
-			print $fh $_;
-		}
-		if (!close $fh) {
-			for (@{$head->{TEXT}}, @result) {
-				print STDERR $_;
-			}
-		}
+		my @patch = (@{$head->{TEXT}}, @result);
+		my $apply_routine = $patch_mode_flavour{APPLY};
+		&$apply_routine(@patch);
 		refresh();
 	}
 
-- 
1.6.4.262.gbda8
