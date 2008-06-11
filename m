From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Wed, 11 Jun 2008 11:02:29 +0200
Message-ID: <200806111102.31481.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200806092319.23906.johan@herland.net> <20080610110553.GA13655@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 11:03:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6MEq-0000Ot-Gl
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 11:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYFKJCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 05:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbYFKJCe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 05:02:34 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:26820 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbYFKJCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 05:02:32 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Jun 2008 11:02:30 +0200
Received: from vpn-global-dhcp3-202.ethz.ch ([129.132.210.202]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Jun 2008 11:02:29 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080610110553.GA13655@sigill.intra.peff.net>
Content-Disposition: inline
X-OriginalArrivalTime: 11 Jun 2008 09:02:29.0300 (UTC) FILETIME=[E0474740:01C8CBA1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84601>

Jeff King wrote:
>
> Below is a simple patch to build interactive edit support on top of
> Dscho's "git apply --recount" patch. Rather than create new hunks, the
> action is just "edit and apply": if the apply is successful, the hunk is
> removed from further consideration.

Ok, I finally see what you meant earlier.  So how about this, which is
basically "middle ground":

As in the parent, editing is restricted to a single hunk, no splitting
allowed (almost---you can still insert @ lines if you are good at
counting, but you're on your own).

However, as in the earlier versions, the hunk is placed in the editing
loop again.  In this version, I made it so it will be marked for use
as if you had entered 'y', so if it was the last (or only) hunk, the
files will be patched immediately.  But if you Ctrl-C out in the
middle, nothing has been changed yet.

The following two remarks also apply:

>   - it's not very well tested :)
[...]
> This should be applied on top of "allow git-apply to ignore the hunk
> headers" (v3) which can be found on the list.

By the way, current 'add -p' recounts the headers to account for all
hunks that the user answered 'n'.  I haven't given it enough thought
to put it in the code yet, but it may be possible to rip that out as
well and unconditionally --recount.  Only the preimage line numbers
matter, and those never change.

-- 8< --
 git-add--interactive.perl |  128 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 127 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..8c39149 100755
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
 
@@ -770,6 +783,108 @@ sub coalesce_overlapping_hunks {
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
+# If the patch applies cleanly, the hunk will immediately be marked
+# for staging as if you had answered 'y'.  (However, if you remove
+# everything, nothing happens.)  Otherwise, you will be asked to edit
+# again.
+#
+# Do not add @ lines unless you know what you are doing.  The original
+# @ line will be reinserted if you remove it.
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
+	if (@newtext == 0) {
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
+			my @display = color_diff(@{$text});
+			$newhunk->{DISPLAY} = \@display;
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
@@ -781,6 +896,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+e - manually edit the current hunk
 ? - print help
 EOF
 }
@@ -846,6 +962,7 @@ sub patch_update_file {
 
 	$num = scalar @hunk;
 	$ix = 0;
+	my $need_recount = 0;
 
 	while (1) {
 		my ($prev, $next, $other, $undecided, $i);
@@ -885,6 +1002,7 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
+		$other .= '/e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -949,6 +1067,13 @@ sub patch_update_file {
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
@@ -1002,7 +1127,8 @@ sub patch_update_file {
 	if (@result) {
 		my $fh;
 
-		open $fh, '| git apply --cached';
+		open $fh, '| git apply --cached'
+			. ($need_recount ? ' --recount' : '');
 		for (@{$head->{TEXT}}, @result) {
 			print $fh $_;
 		}
-- 
1.5.6.rc1.134.g8dfb.dirty
