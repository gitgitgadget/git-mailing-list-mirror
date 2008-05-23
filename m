From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] git-add--interactive: manual hunk editing mode
Date: Fri, 23 May 2008 22:21:43 +0200
Message-ID: <200805232221.45406.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:22:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzdmZ-0001M0-Vw
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbYEWUVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbYEWUVj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:21:39 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:36759 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbYEWUVi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:21:38 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 23 May 2008 22:21:36 +0200
Received: from [192.168.0.2] ([84.75.156.10]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 23 May 2008 22:21:36 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
Content-Disposition: inline
X-OriginalArrivalTime: 23 May 2008 20:21:36.0775 (UTC) FILETIME=[99D14970:01C8BD12]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82730>

Adds a new option 'e' to the 'add -p' command loop that lets you
discard or keep one hunk line at a time.  This is useful if there are
no unchanged lines in the middle of the hunk, so 's' will not work,
but you would still like to split it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is my first patch, and I had to dust off my Perl knowledge a bit,
so I hope it is up to your standards.

I could have used this a few times because I frequently hack around a
bit, then after some time notice that this should really go in two
separate commits.  Usually 'add -p' can separate the changes, but if
their diff lines are immediately adjacent, one has to go back and
undo some editing before the first commit, then redo later.

I'm not quite happy with the scheme I use to handle colored diffs.
'git diff' apparently does not always reset the color before newlines
(is this a bug?), so I insert extra resets.  However, I did not want
to implement "full" diff coloring directly in git-add--interactive.

Also, I would be glad to hear your comments on the "user interface" of
the edit command loop.  I haven't found a good way of saying "an
optional number followed by y or n" that is consistent with the
"[y/n]" format used in the rest of the patch loop.  Similiarly, an
option to undo an edit might be nice, but would complicate the code a
fair bit.

Best regards,
Thomas


 Documentation/git-add.txt |    1 +
 git-add--interactive.perl |  110 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index bb4abe2..8de4d4a 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -229,6 +229,7 @@ patch::
        k - leave this hunk undecided, see previous undecided hunk
        K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
+       e - manually edit the current hunk
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..8af841a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -18,6 +18,10 @@ my ($fraginfo_color) =
 	$diff_use_color ? (
 		$repo->get_color('color.diff.frag', 'cyan'),
 	) : ();
+my ($diff_plain_color) =
+	$diff_use_color ? (
+		$repo->get_color('color.diff.plain', ''),
+	) : ();
 
 my $normal_color = $repo->get_color("", "reset");
 
@@ -682,6 +686,107 @@ sub split_hunk {
 	return @split;
 }
 
+sub edit_hunk_manually {
+	my ($in_text, $in_display) = @_;
+
+	my @text = @$in_text;
+	my @display = @$in_display;
+
+	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) = parse_hunk_header($text[0]);
+	my $num = scalar @text;
+
+	my $ix = 0;
+
+      OUTER:
+	while (1) {
+		$text[0] = ("@@ -$o_ofs" .
+			    (($o_cnt != 1) ? ",$o_cnt" : '') .
+			    " +$n_ofs" .
+			    (($n_cnt != 1) ? ",$n_cnt" : '') .
+			    " @@\n");
+		if ($diff_use_color) {
+			$display[0] = colored $fraginfo_color, $text[0];
+		}
+		else {
+			$display[0] = $text[0];
+		}
+
+		while ($text[$ix] !~ /^[+-]/) {
+			$ix++;
+			last OUTER if $ix >= $num;
+		}
+		my $lineno = 0;
+		for (my $i = 0; $i < $num; $i++) {
+			if ($i >= $ix && $text[$i] =~ /^[+-]/) {
+				$lineno++;
+				if ($lineno == 1) {
+					print $normal_color . colored($prompt_color, ">1 ");
+				}
+				elsif ($lineno <  100) {
+					print $normal_color . colored($prompt_color, sprintf("%2d ", $lineno));
+				}
+				else {
+					print "   ";
+				}
+			}
+			else {
+				print "   ";
+			}
+			print $display[$i];
+		}
+		print colored $prompt_color, "Use line(s) [<num>y/n]? ";
+		my $line = <STDIN>;
+		if ($line) {
+			if ($line =~ /^(\d*)y/) {
+				my $repeat = $1 || 1;
+				while (1) {
+					last if ($repeat <= 0 || $ix >= $num);
+					$repeat-- if ($text[$ix] =~ /^[+-]/);
+					$ix++;
+				}
+			}
+			elsif ($line =~ /^(\d*)n/) {
+				# This is the interesting case.
+				# - lines become context, + lines are dropped
+				my $repeat = $1 || 1;
+				while (1) {
+					last if ($repeat <= 0 || $ix >= $num);
+					if ($text[$ix] =~ /^\+/) {
+						$repeat--;
+						splice(@text, $ix, 1);
+						splice(@display, $ix, 1);
+						$n_cnt--;
+						$num--;
+						$ix--;
+					}
+					elsif ($text[$ix] =~ /^-/) {
+						$repeat--;
+						$n_cnt++;
+						$text[$ix] =~ s/^-/ /;
+						# need a better way to do this
+						$display[$ix] = $normal_color . colored $diff_plain_color, $text[$ix];
+					}
+					$ix++;
+				}
+			}
+		}
+	}
+
+	while (1) {
+		for (@display) {
+			print;
+		}
+		print colored $prompt_color, "Accept and replace old hunk [y/n]? ";
+		my $line = <STDIN>;
+		if ($line =~ /^y/) {
+			return (\@text, \@display);
+		}
+		elsif ($line =~ /^n/) {
+			return ($in_text, $in_display);
+		}
+	}
+}
+
 sub find_last_o_ctx {
 	my ($it) = @_;
 	my $text = $it->{TEXT};
@@ -781,6 +886,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+e - manually edit the current hunk
 ? - print help
 EOF
 }
@@ -885,6 +991,7 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
+		$other .= '/e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -949,6 +1056,9 @@ sub patch_update_file {
 				$num = scalar @hunk;
 				next;
 			}
+			elsif ($line =~ /^e/) {
+				($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY}) = edit_hunk_manually($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
+			}
 			else {
 				help_patch_cmd($other);
 				next;
-- 
1.5.4.5
