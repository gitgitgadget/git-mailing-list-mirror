From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] Implement unstage and reset modes for git-add--interactive
Date: Fri, 24 Jul 2009 11:15:51 +0200
Message-ID: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
References: <200907231041.32567.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 11:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUGsw-0002IT-96
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 11:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZGXJQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 05:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbZGXJQC
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 05:16:02 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:31131 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbZGXJQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 05:16:00 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Jul 2009 11:15:58 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Jul 2009 11:15:58 +0200
X-Mailer: git-send-email 1.6.4.rc2.215.g4f661
In-Reply-To: <200907231041.32567.trast@student.ethz.ch>
X-OriginalArrivalTime: 24 Jul 2009 09:15:58.0458 (UTC) FILETIME=[5B1CFDA0:01CA0C3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123909>

This is just the required change to git-add--interactive.  Since the
use of this script is an implementation detail, the next step would be
to wrap this option in other commands such as 'git reset --patch' and
'git unstage --patch'.

Since there is no frontend support whatsoever, you have to run

  git add--interactive --patch=unstage --

manually (including the --), and similarly for --patch=reset.
---

I wrote:
> This is what 'git checkout --interactive -- $file' or 'git reset
> --interactive --hard' would accomplish, if they existed.  I wonder if
> there would be a way to avoid yet more command letters, and instead
> have "modes" that affect what happens with hunks you said 'y' to.  For
> example:
> 
>   add -p                apply --cached
>   undo -p               apply -R
>   unstage -p            apply -R --cached
>     [with hunks coming from diff --cached obviously]
> 
> (I picked 'undo' and 'unstage' semi-randomly, but it's not, after all,
> an 'add' operation any more and the user doesn't need to know that the
> program doing this is in fact git-add--interactive.)

Like so, maybe.  I realise that it does _not_ fill Pierre's need for a
command that can do it all in one go, but if people like this I'll
make a real patch series.

I'm not completely happy with the idea of reset --interactive by the
way, as it's not a reset in the 'reset $commit' sense.



 git-add--interactive.perl |   60 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index df9f231..ad322df 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -73,6 +73,27 @@
 # command line options
 my $patch_mode;
 
+my %patch_modes = (
+	'stage' => {
+		DIFF => 'diff-files -p',
+		APPLY => 'apply --cached',
+		VERB => 'Stage',
+		PARTICIPLE => 'Staging',
+	},
+	'unstage' => {
+		DIFF => 'diff-index -p --cached HEAD',
+		APPLY => 'apply -R --cached',
+		VERB => 'UNstage',
+		PARTICIPLE => 'UNstaging',
+	},
+	'reset' => {
+		DIFF => 'diff-files -p',
+		APPLY => 'apply -R',
+		VERB => 'RESET',
+		PARTICIPLE => 'RESETTING',
+	},
+);
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32' || $^O eq 'msys') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -615,10 +636,11 @@
 
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
 
@@ -877,6 +899,7 @@
 		or die "failed to open hunk edit file for writing: " . $!;
 	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
 	print $fh @$oldtext;
+	my $participle = $patch_modes{$patch_mode}{PARTICIPLE};
 	print $fh <<EOF;
 # ---
 # To remove '-' lines, make them ' ' lines (context).
@@ -884,7 +907,7 @@
 # Lines starting with # will be removed.
 #
 # If the patch applies cleanly, the edited hunk will immediately be
-# marked for staging. If it does not apply cleanly, you will be given
+# marked for $participle. If it does not apply cleanly, you will be given
 # an opportunity to edit again. If all lines of the hunk are removed,
 # then the edit is aborted and the hunk is left unchanged.
 EOF
@@ -918,7 +941,7 @@
 
 sub diff_applies {
 	my $fh;
-	open $fh, '| git apply --recount --cached --check';
+	open $fh, '| git '.$patch_modes{$patch_mode}{APPLY}.' --recount --check';
 	for my $h (@_) {
 		print $fh @{$h->{TEXT}};
 	}
@@ -988,12 +1011,13 @@
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
@@ -1138,8 +1162,8 @@
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
@@ -1314,7 +1338,7 @@
 	if (@result) {
 		my $fh;
 
-		open $fh, '| git apply --cached --recount';
+		open $fh, '| git '.$patch_modes{$patch_mode}{APPLY}.' --recount';
 		for (@{$head->{TEXT}}, @result) {
 			print $fh $_;
 		}
@@ -1363,8 +1387,14 @@
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
-- 
1.6.4.rc2.215.g4f661
