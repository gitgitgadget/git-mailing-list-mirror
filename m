From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/3] git-add--interactive: manual hunk editing mode
Date: Thu,  3 Jul 2008 00:00:00 +0200
Message-ID: <1215036000-26322-1-git-send-email-trast@student.ethz.ch>
References: <1215035984-26263-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 00:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEANc-000299-Fg
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 00:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbYGBV7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755795AbYGBV7t
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:59:49 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:19542 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755790AbYGBV7s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:59:48 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 23:59:47 +0200
Received: from localhost.localdomain ([84.75.156.10]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 23:59:46 +0200
X-Mailer: git-send-email 1.5.6.1.276.gde9a
In-Reply-To: <1215035984-26263-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 02 Jul 2008 21:59:47.0003 (UTC) FILETIME=[F130C0B0:01C8DC8E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87200>

Adds a new option 'e' to the 'add -p' command loop that lets you edit
the current hunk in your favourite editor.

If the resulting patch applies cleanly, the edited hunk will
immediately be marked for staging. If it does not apply cleanly, you
will be given an opportunity to edit again. If all lines of the hunk
are removed, then the edit is aborted and the hunk is left unchanged.

Applying the changed hunk(s) relies on Johannes Schindelin's new
--recount option for git-apply.

Note that the "real patch" test intentionally uses
  (echo e; echo n; echo d) | git add -p
even though the 'n' and 'd' are superfluous at first sight.  They
serve to get out of the interaction loop if git add -p wrongly
concludes the patch does not apply.

Many thanks to Jeff King <peff@peff.net> for lots of help and
suggestions.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-add.txt  |    1 +
 git-add--interactive.perl  |  119 ++++++++++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |   67 +++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 011a743..46dd56c 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -236,6 +236,7 @@ patch::
        k - leave this hunk undecided, see previous undecided hunk
        K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
+       e - manually edit the current hunk
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a4234d3..801d7c0 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -18,6 +18,18 @@ my ($fraginfo_color) =
 	$diff_use_color ? (
 		$repo->get_color('color.diff.frag', 'cyan'),
 	) : ();
+my ($diff_plain_color) =
+	$diff_use_color ? (
+		$repo->get_color('color.diff.plain', ''),
+	) : ();
+my ($diff_old_color) =
+	$diff_use_color ? (
+		$repo->get_color('color.diff.old', 'red'),
+	) : ();
+my ($diff_new_color) =
+	$diff_use_color ? (
+		$repo->get_color('color.diff.new', 'green'),
+	) : ();
 
 my $normal_color = $repo->get_color("", "reset");
 
@@ -683,6 +695,105 @@ sub split_hunk {
 }
 
 
+sub color_diff {
+	return map {
+		colored((/^@/  ? $fraginfo_color :
+			 /^\+/ ? $diff_new_color :
+			 /^-/  ? $diff_old_color :
+			 $diff_plain_color),
+			$_);
+	} @_;
+}
+
+sub edit_hunk_manually {
+	my ($oldtext) = @_;
+
+	my $hunkfile = $repo->repo_path . "/addp-hunk-edit.diff";
+	my $fh;
+	open $fh, '>', $hunkfile
+		or die "failed to open hunk edit file for writing: " . $!;
+	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
+	print $fh @$oldtext;
+	print $fh <<EOF;
+# ---
+# To remove '-' lines, make them ' ' lines (context).
+# To remove '+' lines, delete them.
+# Lines starting with # will be removed.
+#
+# If the patch applies cleanly, the edited hunk will immediately be
+# marked for staging. If it does not apply cleanly, you will be given
+# an opportunity to edit again. If all lines of the hunk are removed,
+# then the edit is aborted and the hunk is left unchanged.
+EOF
+	close $fh;
+
+	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor")
+		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	system('sh', '-c', $editor.' "$@"', $editor, $hunkfile);
+
+	open $fh, '<', $hunkfile
+		or die "failed to open hunk edit file for reading: " . $!;
+	my @newtext = grep { !/^#/ } <$fh>;
+	close $fh;
+	unlink $hunkfile;
+
+	# Abort if nothing remains
+	if (!grep { /\S/ } @newtext) {
+		return undef;
+	}
+
+	# Reinsert the first hunk header if the user accidentally deleted it
+	if ($newtext[0] !~ /^@/) {
+		unshift @newtext, $oldtext->[0];
+	}
+	return \@newtext;
+}
+
+sub diff_applies {
+	my $fh;
+	open $fh, '| git apply --recount --cached --check';
+	for my $h (@_) {
+		print $fh @{$h->{TEXT}};
+	}
+	return close $fh;
+}
+
+sub prompt_yesno {
+	my ($prompt) = @_;
+	while (1) {
+		print colored $prompt_color, $prompt;
+		my $line = <STDIN>;
+		return 0 if $line =~ /^n/i;
+		return 1 if $line =~ /^y/i;
+	}
+}
+
+sub edit_hunk_loop {
+	my ($head, $hunk, $ix) = @_;
+	my $text = $hunk->[$ix]->{TEXT};
+
+	while (1) {
+		$text = edit_hunk_manually($text);
+		if (!defined $text) {
+			return undef;
+		}
+		my $newhunk = { TEXT => $text, USE => 1 };
+		if (diff_applies($head,
+				 @{$hunk}[0..$ix-1],
+				 $newhunk,
+				 @{$hunk}[$ix+1..$#{$hunk}])) {
+			$newhunk->{DISPLAY} = [color_diff(@{$text})];
+			return $newhunk;
+		}
+		else {
+			prompt_yesno(
+				'Your edited hunk does not apply. Edit again '
+				. '(saying "no" discards!) [y/n]? '
+				) or return undef;
+		}
+	}
+}
+
 sub help_patch_cmd {
 	print colored $help_color, <<\EOF ;
 y - stage this hunk
@@ -694,6 +805,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+e - manually edit the current hunk
 ? - print help
 EOF
 }
@@ -798,6 +910,7 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
+		$other .= '/e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -862,6 +975,12 @@ sub patch_update_file {
 				$num = scalar @hunk;
 				next;
 			}
+			elsif ($line =~ /^e/) {
+				my $newhunk = edit_hunk_loop($head, \@hunk, $ix);
+				if (defined $newhunk) {
+					splice @hunk, $ix, 1, $newhunk;
+				}
+			}
 			else {
 				help_patch_cmd($other);
 				next;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fae64ea..e95663d 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -66,6 +66,73 @@ test_expect_success 'revert works (commit)' '
 	grep "unchanged *+3/-0 file" output
 '
 
+cat >expected <<EOF
+EOF
+cat >fake_editor.sh <<EOF
+EOF
+chmod a+x fake_editor.sh
+test_set_editor "$(pwd)/fake_editor.sh"
+test_expect_success 'dummy edit works' '
+	(echo e; echo a) | git add -p &&
+	git diff > diff &&
+	test_cmp expected diff
+'
+
+cat >patch <<EOF
+@@ -1,1 +1,4 @@
+ this
++patch
+-doesn't
+ apply
+EOF
+echo "#!$SHELL_PATH" >fake_editor.sh
+cat >>fake_editor.sh <<\EOF
+mv -f "$1" oldpatch &&
+mv -f patch "$1"
+EOF
+chmod a+x fake_editor.sh
+test_set_editor "$(pwd)/fake_editor.sh"
+test_expect_success 'bad edit rejected' '
+	git reset &&
+	(echo e; echo n; echo d) | git add -p >output &&
+	grep "hunk does not apply" output
+'
+
+cat >patch <<EOF
+this patch
+is garbage
+EOF
+test_expect_success 'garbage edit rejected' '
+	git reset &&
+	(echo e; echo n; echo d) | git add -p >output &&
+	grep "hunk does not apply" output
+'
+
+cat >patch <<EOF
+@@ -1,0 +1,0 @@
+ baseline
++content
++newcontent
++lines
+EOF
+cat >expected <<EOF
+diff --git a/file b/file
+index b5dd6c9..f910ae9 100644
+--- a/file
++++ b/file
+@@ -1,4 +1,4 @@
+ baseline
+ content
+-newcontent
++more
+ lines
+EOF
+test_expect_success 'real edit works' '
+	(echo e; echo n; echo d) | git add -p &&
+	git diff >output &&
+	test_cmp expected output
+'
+
 if test "$(git config --bool core.filemode)" = false
 then
     say 'skipping filemode tests (filesystem does not properly support modes)'
-- 
1.5.6.1.276.gde9a
