From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] git-add--interactive: manual hunk editing mode
Date: Tue,  1 Jul 2008 13:44:34 +0200
Message-ID: <1214912674-9443-1-git-send-email-trast@student.ethz.ch>
References: <20080701101114.GA6379@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 13:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDeIQ-0001bg-5w
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 13:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbYGALoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 07:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYGALoV
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 07:44:21 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:35427 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146AbYGALoU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 07:44:20 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Jul 2008 13:44:18 +0200
Received: from localhost.localdomain ([129.132.149.71]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Jul 2008 13:44:18 +0200
X-Mailer: git-send-email 1.5.6.1.248.gff8c5
In-Reply-To: <20080701101114.GA6379@sigill.intra.peff.net>
X-OriginalArrivalTime: 01 Jul 2008 11:44:18.0416 (UTC) FILETIME=[CB9FCF00:01C8DB6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87028>

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

Jeff King wrote:
> Now that this is in next, maybe it is a good time to repost the
> add--interactive patch (it should be independent of Dscho's 2/2 "add -e"
> patch).

It is independent, so I suppose you're right.  (Dscho mentioned in
passing he might repost "add -e" himself.)

- Thomas

 Documentation/git-add.txt  |    1 +
 git-add--interactive.perl  |  124 +++++++++++++++++++++++++++++++++++++++++++-
 t/t3701-add-interactive.sh |   67 ++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index c6de028..1d8d209 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -246,6 +246,7 @@ patch::
        k - leave this hunk undecided, see previous undecided hunk
        K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
+       e - manually edit the current hunk
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..6bb117a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,7 @@
 
 use strict;
 use Git;
+use File::Temp;
 
 my $repo = Git->repository();
 
@@ -18,6 +19,18 @@ my ($fraginfo_color) =
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
 
@@ -770,6 +783,104 @@ sub coalesce_overlapping_hunks {
 	return @out;
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
+	my $t = File::Temp->new(
+		TEMPLATE => $repo->repo_path . "/git-hunk-edit.XXXXXX",
+		SUFFIX => '.diff'
+	);
+	print $t "# Manual hunk edit mode -- see bottom for a quick guide\n";
+	print $t @$oldtext;
+	print $t <<EOF;
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
+	close $t;
+
+	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor")
+		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	system('sh', '-c', $editor.' "$@"', $editor, $t);
+
+	open my $fh, '<', $t
+		or die "failed to open hunk edit file for reading: " . $!;
+	my @newtext = grep { !/^#/ } <$fh>;
+	close $fh;
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
@@ -781,6 +892,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+e - manually edit the current hunk
 ? - print help
 EOF
 }
@@ -846,6 +958,7 @@ sub patch_update_file {
 
 	$num = scalar @hunk;
 	$ix = 0;
+	my $need_recount = 0;
 
 	while (1) {
 		my ($prev, $next, $other, $undecided, $i);
@@ -885,6 +998,7 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
+		$other .= '/e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -949,6 +1063,13 @@ sub patch_update_file {
 				$num = scalar @hunk;
 				next;
 			}
+			elsif ($line =~ /^e/) {
+				my $newhunk = edit_hunk_loop($head, \@hunk, $ix);
+				if (defined $newhunk) {
+					splice @hunk, $ix, 1, $newhunk;
+					$need_recount = 1;
+				}
+			}
 			else {
 				help_patch_cmd($other);
 				next;
@@ -1002,7 +1123,8 @@ sub patch_update_file {
 	if (@result) {
 		my $fh;
 
-		open $fh, '| git apply --cached';
+		open $fh, '| git apply --cached'
+			. ($need_recount ? ' --recount' : '');
 		for (@{$head->{TEXT}}, @result) {
 			print $fh $_;
 		}
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
1.5.4.5
