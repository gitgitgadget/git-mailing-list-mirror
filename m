From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Mon, 9 Jun 2008 00:32:26 +0200
Message-ID: <200806090032.27516.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <20080605014618.GA27381@sigill.intra.peff.net> <200806051438.12758.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 00:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5TSz-0004uk-MD
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 00:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbYFHWdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 18:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbYFHWdc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 18:33:32 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:7137 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754755AbYFHWda (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 18:33:30 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Jun 2008 00:33:28 +0200
Received: from [192.168.0.11] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Jun 2008 00:33:28 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <200806051438.12758.trast@student.ethz.ch>
Content-Disposition: inline
X-OriginalArrivalTime: 08 Jun 2008 22:33:28.0438 (UTC) FILETIME=[AC254160:01C8C9B7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84335>

Subject: [PATCH] git-add--interactive: manual hunk editing mode

Adds a new option 'e' to the 'add -p' command loop that lets you
edit the current hunk in your favourite editor.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

On top of the previous patch, this adds basic testing.

Compared to the competing bikeshed
  http://article.gmane.org/gmane.comp.version-control.git/83894 
this integrates into the 'add -p' loop.  I (still) prefer it because I
use 'add -p' a lot, thus having the editing feature at my fingertips.

- Thomas


 git-add--interactive.perl  |  164 +++++++++++++++++++++++++++++++++++++++-----
 t/t3701-add-interactive.sh |   57 +++++++++++++++
 2 files changed, 204 insertions(+), 17 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..5fb8402 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,7 @@
 
 use strict;
 use Git;
+use File::Temp qw/tempfile/;
 
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
 
@@ -581,6 +594,13 @@ sub parse_hunk_header {
 	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
 }
 
+sub format_hunk_header {
+	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) = @_;
+	return ("@@ -$o_ofs" . (($o_cnt != 1) ? ",$o_cnt" : '')
+		. " +$n_ofs" . (($n_cnt != 1) ? ",$n_cnt" : '')
+		. " @@\n");
+}
+
 sub split_hunk {
 	my ($text, $display) = @_;
 	my @split = ();
@@ -667,11 +687,7 @@ sub split_hunk {
 		my $o_cnt = $hunk->{OCNT};
 		my $n_cnt = $hunk->{NCNT};
 
-		my $head = ("@@ -$o_ofs" .
-			    (($o_cnt != 1) ? ",$o_cnt" : '') .
-			    " +$n_ofs" .
-			    (($n_cnt != 1) ? ",$n_cnt" : '') .
-			    " @@\n");
+		my $head = format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
 		my $display_head = $head;
 		unshift @{$hunk->{TEXT}}, $head;
 		if ($diff_use_color) {
@@ -741,11 +757,7 @@ sub merge_hunk {
 		}
 		push @line, $line;
 	}
-	my $head = ("@@ -$o0_ofs" .
-		    (($o_cnt != 1) ? ",$o_cnt" : '') .
-		    " +$n0_ofs" .
-		    (($n_cnt != 1) ? ",$n_cnt" : '') .
-		    " @@\n");
+	my $head = format_hunk_header($o0_ofs, $o_cnt, $n0_ofs, $n_cnt);
 	@{$prev->{TEXT}} = ($head, @line);
 }
 
@@ -770,6 +782,122 @@ sub coalesce_overlapping_hunks {
 	return @out;
 }
 
+sub edit_hunk_manually {
+	my @oldtext = map { @{$_->{TEXT}} } @_;
+
+	my ($fh, $editpath) = tempfile($repo->repo_path() . "/git-hunk-edit.XXXXXX",
+				       SUFFIX => ".diff", UNLINK => 0);
+	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
+	print $fh @oldtext;
+	print $fh <<EOF;
+# ---
+# To remove '-' lines, make them ' ' lines (context).
+# To remove '+' lines, delete them.
+# Empty lines and lines starting with # will be removed.
+#
+# Lines starting with @ start a new hunk. Line counts will be adjusted
+# according to contents. If the line numbers are missing altogether,
+# they will be inferred from the previous hunk.
+#
+# You can change the hunk to your heart's content, but it will be
+# refused if the end result (the entire patch including your edited
+# hunk) does not apply cleanly.
+EOF
+	close $fh;
+
+	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor")
+		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	system('sh', '-c', $editor.' "$@"', $editor, $editpath);
+
+	open $fh, '<', $editpath
+		or die "failed to open hunk edit file for reading: " . $!;
+	my @newtext = grep { !/^#/ } <$fh>;
+	close $fh;
+	unlink(glob($editpath . "*"));
+	# Reinsert the first hunk header if the user accidentally deleted it
+	if ($newtext[0] !~ /^@/) {
+		splice @newtext, 0, 0, $oldtext[0];
+	}
+	# Split into hunks
+	my @hunktexts = ();
+	my $curhunk = [];
+	for (@newtext) {
+		if (/^@/ && @{$curhunk} > 0) {
+			push @hunktexts, $curhunk;
+			$curhunk = [];
+		}
+		push @{$curhunk}, $_;
+	}
+	push @hunktexts, $curhunk;
+	# Fix the hunk headers
+	my ($guess_o_ofs, undef, $guess_n_ofs, undef) = parse_hunk_header($oldtext[0]);
+	for my $hunk (@hunktexts) {
+		my ($o_ofs, undef, $n_ofs, undef) = parse_hunk_header($hunk->[0]);
+		$o_ofs = $guess_o_ofs unless defined $o_ofs;
+		$n_ofs = $guess_n_ofs unless defined $n_ofs;
+		my $plus_cnt = grep /^\+/, @{$hunk};
+		my $minus_cnt = grep /^-/, @{$hunk};
+		my $context_cnt = grep { /^ / || /^$/ } @{$hunk};
+		my $o_cnt = $context_cnt + $minus_cnt;
+		my $n_cnt = $context_cnt + $plus_cnt;
+		$hunk->[0] = format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
+		$guess_o_ofs = $o_ofs + $o_cnt;
+		$guess_n_ofs = $n_ofs + $n_cnt;
+	}
+	# Recolor the hunks
+	my (@hunks) = ();
+	for my $hunk (@hunktexts) {
+		my @hunkdisplay = map {
+			colored((/^@/  ? $fraginfo_color :
+				 /^\+/ ? $diff_new_color :
+				 /^-/  ? $diff_old_color :
+				 $diff_plain_color),
+				$_);
+		} @{$hunk};
+		push @hunks, {TEXT => $hunk, DISPLAY => \@hunkdisplay};
+	}
+
+	return @hunks;
+}
+
+sub diff_applies {
+	my $fh;
+	open $fh, '| git apply --cached --check';
+	for my $h (@_) {
+		print $fh @{$h->{TEXT}};
+	}
+	return close $fh;
+}
+
+sub edit_hunk_loop {
+	my ($head, $hunks, $ix) = @_;
+
+	my @newhunks = ($hunks->[$ix]);
+
+      EDIT:
+	while (1) {
+		@newhunks = edit_hunk_manually(@newhunks);
+		if (!diff_applies($head, @$hunks[0..$ix-1], @newhunks,
+				  @$hunks[$ix+1..$#{$hunks}])) {
+			while (1) {
+				print colored $prompt_color, 'Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]? ';
+				my $line = <STDIN>;
+				if ($line =~ /^y/i) {
+					redo EDIT;
+				}
+				elsif ($line =~ /^n/i) {
+					return $hunks->[$ix];
+				}
+			}
+		}
+		if (1 < @newhunks) {
+			print colored $header_color, "Manually edited into ",
+			scalar(@newhunks), " hunks.\n";
+		}
+		return @newhunks;
+	}
+}
+
 sub help_patch_cmd {
 	print colored $help_color, <<\EOF ;
 y - stage this hunk
@@ -781,6 +909,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+e - manually edit the current hunk
 ? - print help
 EOF
 }
@@ -885,6 +1014,7 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
+		$other .= '/e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -949,6 +1079,11 @@ sub patch_update_file {
 				$num = scalar @hunk;
 				next;
 			}
+			elsif ($line =~ /^e/) {
+				splice @hunk, $ix, 1, edit_hunk_loop($head, \@hunk, $ix);
+				$num = scalar @hunk;
+				next;
+			}
 			else {
 				help_patch_cmd($other);
 				next;
@@ -985,13 +1120,8 @@ sub patch_update_file {
 		else {
 			if ($n_lofs) {
 				$n_ofs += $n_lofs;
-				$text->[0] = ("@@ -$o_ofs" .
-					      (($o_cnt != 1)
-					       ? ",$o_cnt" : '') .
-					      " +$n_ofs" .
-					      (($n_cnt != 1)
-					       ? ",$n_cnt" : '') .
-					      " @@\n");
+				$text->[0] = format_hunk_header($o_ofs, $o_cnt,
+								$n_ofs, $n_cnt);
 			}
 			for (@$text) {
 				push @result, $_;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fae64ea..7c8d459 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -66,6 +66,63 @@ test_expect_success 'revert works (commit)' '
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
+@@ -1 +1,4 @@
+this
+patch
+is
+malformed
+EOF
+echo "#!$SHELL_PATH" >fake_editor.sh
+cat >>fake_editor.sh <<\EOF
+mv -f "$1" oldpatch &&
+mv -f patch "$1"
+EOF
+chmod a+x fake_editor.sh
+test_set_editor "$(pwd)/fake_editor.sh"
+test_expect_success 'garbage edit rejected' '
+	git reset &&
+	(echo e; echo n; echo d) | git add -p >output &&
+	grep "hunk does not apply" output
+'
+
+cat >patch <<EOF
+@
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
+	(echo e; echo a) | git add -p &&
+	git diff >output &&
+	test_cmp expected output
+'
+
 if test "$(git config --bool core.filemode)" = false
 then
     say 'skipping filemode tests (filesystem does not properly support modes)'
-- 
1.5.6.rc2.129.gcd433
