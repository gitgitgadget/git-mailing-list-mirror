From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 3/3] Implement unstage --patch and discard --patch
Date: Fri, 24 Jul 2009 18:24:36 +0200
Message-ID: <9cad6176fe941bd56bad7fed49cc55a96a7040ae.1248452530.git.trast@student.ethz.ch>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 18:25:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUNZv-0004JF-8w
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 18:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbZGXQYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 12:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZGXQYu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 12:24:50 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52303 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbZGXQYs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 12:24:48 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Jul 2009 18:24:46 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Jul 2009 18:24:46 +0200
X-Mailer: git-send-email 1.6.4.rc2.217.g74c0b.dirty
In-Reply-To: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 24 Jul 2009 16:24:46.0249 (UTC) FILETIME=[42125990:01CA0C7B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123927>

This implements a new optional argument --patch=<mode> in the
git-add--interactive helper.  The modes are:

'stage' (default, as before): offer hunks from 'git diff' and stage
  the ones selected by the user.

'unstage': offer hunks from 'git diff --cached', and unstage the ones
  selected.

'discard': offer hunks from 'git diff', and discard (i.e., undo the
  edit in the working tree) the ones selected.

With this in hand, we can then easily add a --patch option to the
git-unstage and git-discard scripts that run git-add--interactive in
the corresponding modes.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-discard.txt |    7 ++++
 Documentation/git-unstage.txt |    7 ++++
 git-add--interactive.perl     |   69 +++++++++++++++++++++++++++++++---------
 git-discard.sh                |    9 ++++-
 git-unstage.sh                |    9 ++++-
 5 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-discard.txt b/Documentation/git-discard.txt
index 4db14f0..2c063d1 100644
--- a/Documentation/git-discard.txt
+++ b/Documentation/git-discard.txt
@@ -24,6 +24,13 @@ lost.
 (This is the same as `git checkout \-- <paths>`.)
 
 
+OPTIONS
+-------
+-p::
+--patch::
+	Interactively select hunks to discard.
+
+
 SEE ALSO
 --------
 linkgit:git-checkout[1]
diff --git a/Documentation/git-unstage.txt b/Documentation/git-unstage.txt
index 49d09fb..d3da3e1 100644
--- a/Documentation/git-unstage.txt
+++ b/Documentation/git-unstage.txt
@@ -21,6 +21,13 @@ is not affected.  (This is the same as `git reset \-- <paths>` unless
 you are on an unborn branch.)
 
 
+OPTIONS
+-------
+-p::
+--patch::
+	Interactively select hunks to unstage.
+
+
 SEE ALSO
 --------
 linkgit:git-reset[1]
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index df9f231..502a0e4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -73,6 +73,30 @@
 # command line options
 my $patch_mode;
 
+my %patch_modes = (
+	'stage' => {
+		DIFF => 'diff-files -p',
+		APPLY => 'apply --cached',
+		VERB => 'Stage',
+		PARTICIPLE => 'Staging',
+		FILTER => 'file-only',
+	},
+	'unstage' => {
+		DIFF => 'diff-index -p --cached HEAD',
+		APPLY => 'apply -R --cached',
+		VERB => 'UNstage',
+		PARTICIPLE => 'UNstaging',
+		FILTER => 'index-only',
+	},
+	'discard' => {
+		DIFF => 'diff-files -p',
+		APPLY => 'apply -R',
+		VERB => 'RESET',
+		PARTICIPLE => 'RESETTING',
+		FILTER => 'file-only',
+	},
+);
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32' || $^O eq 'msys') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -615,10 +639,11 @@
 
 sub parse_diff {
 	my ($path) = @_;
-	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
+	my @diff_cmd = split(" ", $patch_modes{$patch_mode}{DIFF});
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
+	my $participle = $patch_modes{$patch_mode}{PARTICIPLE};
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
@@ -918,7 +944,7 @@
 
 sub diff_applies {
 	my $fh;
-	open $fh, '| git apply --recount --cached --check';
+	open $fh, '| git '.$patch_modes{$patch_mode}{APPLY}.' --recount --check';
 	for my $h (@_) {
 		print $fh @{$h->{TEXT}};
 	}
@@ -988,12 +1014,13 @@
 }
 
 sub help_patch_cmd {
-	print colored $help_color, <<\EOF ;
-y - stage this hunk
-n - do not stage this hunk
-q - quit, do not stage this hunk nor any of the remaining ones
-a - stage this and all the remaining hunks in the file
-d - do not stage this hunk nor any of the remaining hunks in the file
+	my $verb = lc $patch_modes{$patch_mode}{VERB};
+	print colored $help_color, <<EOF ;
+y - $verb this hunk
+n - do not $verb this hunk
+q - quit, do not $verb this hunk nor any of the remaining ones
+a - $verb this and all the remaining hunks in the file
+d - do not $verb this hunk nor any of the remaining hunks in the file
 g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
@@ -1007,7 +1034,11 @@
 }
 
 sub patch_update_cmd {
-	my @all_mods = list_modified('file-only');
+	my $filter = 'file-only';
+	if ($patch_mode) {
+		$filter = $patch_modes{$patch_mode}{FILTER};
+	}
+	my @all_mods = list_modified($filter);
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
@@ -1138,8 +1169,8 @@
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, 'Stage ',
-		  ($hunk[$ix]{TYPE} eq 'mode' ? 'mode change' : 'this hunk'),
+		print colored $prompt_color, $patch_modes{$patch_mode}{VERB},
+		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' : ' this hunk'),
 		  " [y,n,q,a,d,/$other,?]? ";
 		my $line = prompt_single_character;
 		if ($line) {
@@ -1314,7 +1345,7 @@
 	if (@result) {
 		my $fh;
 
-		open $fh, '| git apply --cached --recount';
+		open $fh, '| git '.$patch_modes{$patch_mode}{APPLY}.' --recount';
 		for (@{$head->{TEXT}}, @result) {
 			print $fh $_;
 		}
@@ -1363,8 +1394,14 @@
 sub process_args {
 	return unless @ARGV;
 	my $arg = shift @ARGV;
-	if ($arg eq "--patch") {
-		$patch_mode = 1;
+	if ($arg =~ /--patch(?:=(.*))?/) {
+		if (defined $1 && defined $patch_modes{$1}) {
+			$patch_mode = $1;
+		} elsif (defined $1) {
+			die "unknown --patch mode: $1";
+		} else {
+			$patch_mode = 'stage';
+		}
 		$arg = shift @ARGV or die "missing --";
 		die "invalid argument $arg, expecting --"
 		    unless $arg eq "--";
diff --git a/git-discard.sh b/git-discard.sh
index 595df98..628346d 100644
--- a/git-discard.sh
+++ b/git-discard.sh
@@ -3,13 +3,18 @@
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git discard file ...
---"
+git discard [-p] file ...
+--
+p,patch         interactively select hunks to discard"
 
 . git-sh-setup
 
 
 case "$1" in
+    -p|--patch)
+	shift
+	exec git add--interactive --patch=discard "$@"
+	;;
     --)
 	if [ $# -eq 1 ]; then
 	    die "You must specify at least one file to discard changes from"
diff --git a/git-unstage.sh b/git-unstage.sh
index 7f99adf..921e12b 100644
--- a/git-unstage.sh
+++ b/git-unstage.sh
@@ -3,13 +3,18 @@
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git unstage file ...
---"
+git unstage [-p] file ...
+--
+p,patch         interactively select hunks to unstage"
 
 . git-sh-setup
 
 
 case "$1" in
+    -p|--patch)
+	shift
+	exec git add--interactive --patch=unstage "$@"
+	;;
     --)
 	if [ $# -eq 1 ]; then
 	    die "You must specify at least one file to unstage"
-- 
1.6.4.rc2.217.g74c0b.dirty
