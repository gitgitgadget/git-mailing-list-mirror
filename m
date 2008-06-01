From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Sun, 1 Jun 2008 02:41:48 +0200
Message-ID: <200806010241.51464.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 01 02:42:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2beR-0000GS-Tl
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 02:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbYFAAla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 20:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755033AbYFAAla
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 20:41:30 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:1911 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948AbYFAAl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 20:41:29 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Jun 2008 02:41:27 +0200
Received: from [192.168.0.11] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Jun 2008 02:41:26 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080529185808.GA2140@sigill.intra.peff.net>
Content-Disposition: inline
X-OriginalArrivalTime: 01 Jun 2008 00:41:27.0034 (UTC) FILETIME=[39A405A0:01C8C380]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83419>

Adds a new option 'e' to the 'add -p' command loop that lets you
edit the current hunk in your favourite editor.
---

This is a draft of Jeff King's idea

Jeff King wrote:
> But I find the interface a bit clunky. I would much rather get dumped in
> my favorite editor, which happens to be quite fast at removing a subset
> of lines. After editing, any lines remaining would be staged.
>
> We would have to figure out what happens if lines are added or edited,
> of course. It may be right to signal an error, or maybe there is some
> other useful functionality that can come of that.

in the hope that I might get some more ideas and pointers on the details.

The current implementation rejects edits that break the (whole) patch
(thanks Junio for pointing out --check...), but it does help the user
in one aspect: @ lines are edited to reflect their hunk contents, even
inferring the starting line numbers from the last hunk if they are
missing.  This means you can insert a line consisting just of an @,
and it will silently be fixed to start a new hunk at that point.

Some things that might need improvement/fixing:

- Does anyone need a way to force a broken diff past the git-apply
  check?  I don't know what use such a diff might have, but who knows,
  perhaps it applies cleanly once you exclude a hunk or two...

- Perhaps the instructions should go to the bottom, but then the odds
  are they would not be visible in many cases.

- Should I try to come up with a unique filename to support concurrent
  edits?  (git-commit doesn't...)

- Perl's autovivification is out to get me.  I've fixed a few, but
  there are probably still bugs.

Thomas

---
 git-add--interactive.perl |  171 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 171 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..c752e20 100755
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
 
@@ -770,6 +782,158 @@ sub coalesce_overlapping_hunks {
 	return @out;
 }
 
+sub edit_hunk_manually {
+	my @oldtext;
+	for (@_) {
+		push @oldtext, @{$_->{TEXT}};
+	}
+
+	# use a .diff file to help editors with highlighting
+	my $editpath = $repo->repo_path() . "/ADDP_HUNK_EDIT.diff";
+	my $fh;
+	open $fh, '>', $editpath
+		or die "failed to open hunk edit file for writing: " . $!;
+	print $fh <<EOF;
+# MANUAL HUNK EDIT MODE
+#
+# You can change the hunk to your heart's content, but it will be
+# refused if the end result (the entire patch including your edited
+# hunk) does not apply cleanly.
+#
+# To remove '-' lines, make them ' ' lines (context).
+# To remove '+' lines, delete them.
+# Empty lines and lines starting with # will be removed.
+#
+# Lines starting with @ start a new hunk. Line counts will be adjusted
+# according to contents. If the line numbers are missing altogether,
+# they will be inferred from the previous hunk.
+EOF
+	print $fh @oldtext;
+	close $fh;
+
+	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor")
+		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	system('sh', '-c', $editor.' "$@"', $editor, $editpath);
+
+	open $fh, '<', $editpath
+		or die "failed to open hunk edit file for reading: " . $!;
+	my @newtext;
+	while (<$fh>) {
+		push (@newtext, $_) unless /^#/ || /^$/;
+	}
+	close $fh;
+	my @heads = ();
+	my ($o_ofs, $n_ofs);
+	my $o_cnt = 0;
+	my $n_cnt = 0;
+	my ($guess_o_ofs, undef, $guess_n_ofs, undef) = parse_hunk_header($oldtext[0]);
+	for (my $i = 0; $i < @newtext; $i++) {
+		if ((scalar @heads) == 0 && $newtext[$i] =~ /^[ +-]/) {
+			splice @newtext, $i, 0, $oldtext[0];
+			push @heads, $i;
+		}
+		elsif ($newtext[$i] =~ /^ /) {
+			$o_cnt++;
+			$n_cnt++;
+		}
+		elsif ($newtext[$i] =~ /^-/) {
+			$o_cnt++;
+		}
+		elsif ($newtext[$i] =~ /^\+/) {
+			$n_cnt++;
+		}
+		elsif ($newtext[$i] =~ /^@/) {
+			if (@heads > 0) {
+				# fix up the previous header first
+				($o_ofs, undef, $n_ofs, undef)
+					= parse_hunk_header($newtext[$heads[-1]]);
+				$o_ofs = $guess_o_ofs unless defined $o_ofs;
+				$n_ofs = $guess_n_ofs unless defined $n_ofs;
+				$newtext[$heads[-1]] = (
+					"@@ -$o_ofs" . (($o_cnt != 1) ? ",$o_cnt" : '')
+					. " +$n_ofs" . (($n_cnt != 1) ? ",$n_cnt" : '')
+					. " @@\n");
+				$guess_o_ofs = $o_ofs + $o_cnt;
+				$guess_n_ofs = $n_ofs + $n_cnt;
+			}
+			$o_cnt = 0;
+			$n_cnt = 0;
+			push @heads, $i;
+		}
+	}
+	($o_ofs, undef, $n_ofs, undef)
+		= parse_hunk_header($newtext[$heads[-1]]);
+	$o_ofs = $guess_o_ofs unless defined $o_ofs;
+	$n_ofs = $guess_n_ofs unless defined $n_ofs;
+	$newtext[$heads[-1]] = (
+		"@@ -$o_ofs" . (($o_cnt != 1) ? ",$o_cnt" : '')
+		. " +$n_ofs" . (($n_cnt != 1) ? ",$n_cnt" : '')
+		. " @@\n");
+
+	push @heads, (scalar @newtext);
+	my (@hunks) = ();
+	for (my $i = 0; $i < @heads-1; $i++) {
+		my @hunktext = @newtext[$heads[$i]..$heads[$i+1]-1];
+		my @hunkdisplay = ();
+		for (@hunktext) {
+			if (/^@/) {
+				push @hunkdisplay, (colored $fraginfo_color, $_);
+			}
+			elsif (/^\+/) {
+				push @hunkdisplay, (colored $diff_new_color, $_);
+			}
+			elsif (/^-/) {
+				push @hunkdisplay, (colored $diff_old_color, $_);
+			}
+			else {
+				push @hunkdisplay, (colored $diff_plain_color, $_);
+			}
+		}
+		push @hunks, {TEXT => \@hunktext, DISPLAY => \@hunkdisplay};
+	}
+
+	return @hunks;
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
+		my $fh;
+		open $fh, '| git apply --cached --check';
+		for my $h ($head,
+			   $ix > 0 ? @$hunks[0..$ix-1] : (),
+			   @newhunks,
+			   $ix < (scalar @$hunks)-2 ? @$hunks[$ix+1..@$hunks] : ()) {
+			for (@{$h->{TEXT}}) {
+				print $fh $_;
+			}
+		}
+		if (!close $fh) {
+			# didn't apply cleanly
+			while (1) {
+				print colored $prompt_color, "Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? ";
+				my $line = <STDIN>;
+				if ($line =~ /^y/) {
+					redo EDIT;
+				}
+				elsif ($line =~ /^n/) {
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
@@ -781,6 +945,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+e - manually edit the current hunk
 ? - print help
 EOF
 }
@@ -885,6 +1050,7 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
+		$other .= '/e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -949,6 +1115,11 @@ sub patch_update_file {
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
-- 
1.5.6.rc0.159.g710c6
