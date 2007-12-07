From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Teach "git add -i" to colorize whitespace errors
Date: Fri,  7 Dec 2007 13:35:10 +0100
Message-ID: <1197030910-29638-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 13:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0cR7-0001M3-8v
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 13:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbXLGMfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 07:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbXLGMfm
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 07:35:42 -0500
Received: from wincent.com ([72.3.236.74]:41803 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbXLGMfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 07:35:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB7CZD0F013052;
	Fri, 7 Dec 2007 06:35:14 -0600
X-Mailer: git-send-email 1.5.3.7.1079.gb270a-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67418>

Rather than replicating the colorization logic of "git diff-files" we
rely on "git diff-files" itself. This guarantees consistent colorization
in and outside "git add -i".

Seeing as speed is not a concern here (the bottleneck is how fast the
user can read, not how fast "git diff-files" runs) we do this by
actually running it twice, once without color and once with.

In this way as the whitespace colorization provided by "git diff-files"
evolves (per-path attributes, new classes of whitespace error), "git
add -i" will automatically benefit from it and stay in synch.

Also, by working with two sets of diff output (an uncolorized one for
internal processing and a colorized one for display only) we minimize
the risk of regressions because the changes required to implement this
are minimally invasive.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

This applies on top of these patches that Junio sent out yesterday:
	git config --get-colorbool
	Color support for "git-add -i"

I've tested it here and it works for me but it would be nice if
someone else could play with it and see if this is good.

 git-add--interactive.perl |   67 +++++++++++++++++++-------------------------
 1 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 1019a72..e492fac 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -525,42 +525,21 @@ sub add_untracked_cmd {
 sub parse_diff {
 	my ($path) = @_;
 	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
-	my (@hunk) = { TEXT => [] };
+	my @colored = run_cmd_pipe(qw(git diff-files -p --color --), $path)
+	   if $diff_use_color;
+	my (@hunk) = { TEXT => [], DISPLAY => [] };
 
-	for (@diff) {
-		if (/^@@ /) {
-			push @hunk, { TEXT => [] };
+	for (my $i = 0; $i < @diff; $i++) {
+		if ($diff[$i] =~ /^@@ /) {
+			push @hunk, { TEXT => [], DISPLAY => [] };
 		}
-		push @{$hunk[-1]{TEXT}}, $_;
+		push @{$hunk[-1]{TEXT}}, $diff[$i];
+		push @{$hunk[-1]{DISPLAY}},
+		    $diff_use_color ? $colored[$i] : $diff[$i];
 	}
 	return @hunk;
 }
 
-sub colored_diff_hunk {
-	my ($text) = @_;
-	# return the text, so that it can be passed to print()
-	my @ret;
-	for (@$text) {
-		if (!$diff_use_color) {
-			push @ret, $_;
-			next;
-		}
-
-		if (/^\+/) {
-			push @ret, colored($new_color, $_);
-		} elsif (/^\-/) {
-			push @ret, colored($old_color, $_);
-		} elsif (/^\@/) {
-			push @ret, colored($fraginfo_color, $_);
-		} elsif (/^ /) {
-			push @ret, colored($normal_color, $_);
-		} else {
-			push @ret, colored($metainfo_color, $_);
-		}
-	}
-	return @ret;
-}
-
 sub hunk_splittable {
 	my ($text) = @_;
 
@@ -578,7 +557,9 @@ sub parse_hunk_header {
 }
 
 sub split_hunk {
-	my ($text) = @_;
+	my $text = shift;
+	my $display = shift;
+	$display = $text unless $display;
 	my @split = ();
 
 	# If there are context lines in the middle of a hunk,
@@ -594,16 +575,19 @@ sub split_hunk {
 		my $i = $hunk_start - 1;
 		my $this = +{
 			TEXT => [],
+			DISPLAY => [],
 			OLD => $o_ofs,
 			NEW => $n_ofs,
 			OCNT => 0,
 			NCNT => 0,
 			ADDDEL => 0,
 			POSTCTX => 0,
+			USE => undef,
 		};
 
 		while (++$i < @$text) {
 			my $line = $text->[$i];
+			my $display = $display->[$i];
 			if ($line =~ /^ /) {
 				if ($this->{ADDDEL} &&
 				    !defined $next_hunk_start) {
@@ -615,6 +599,7 @@ sub split_hunk {
 					$next_hunk_start = $i;
 				}
 				push @{$this->{TEXT}}, $line;
+				push @{$this->{DISPLAY}}, $display;
 				$this->{OCNT}++;
 				$this->{NCNT}++;
 				if (defined $next_hunk_start) {
@@ -637,6 +622,7 @@ sub split_hunk {
 				redo OUTER;
 			}
 			push @{$this->{TEXT}}, $line;
+			push @{$this->{DISPLAY}}, $display;
 			$this->{ADDDEL}++;
 			if ($line =~ /^-/) {
 				$this->{OCNT}++;
@@ -662,8 +648,10 @@ sub split_hunk {
 			    (($n_cnt != 1) ? ",$n_cnt" : '') .
 			    " @@\n");
 		unshift @{$hunk->{TEXT}}, $head;
+		unshift @{$hunk->{DISPLAY}},
+		    $use_color ? (colored $fraginfo_color, $head) : $head;
 	}
-	return map { $_->{TEXT} } @split;
+	return @split;
 }
 
 sub find_last_o_ctx {
@@ -794,7 +782,9 @@ sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
-	print colored_diff_hunk($head->{TEXT});
+	for (@{$head->{DISPLAY}}) {
+		print;
+	}
 	$num = scalar @hunk;
 	$ix = 0;
 
@@ -836,7 +826,9 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
-		print colored_diff_hunk($hunk[$ix]{TEXT});
+		for (@{$hunk[$ix]{DISPLAY}}) {
+			print;
+		}
 		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line = <STDIN>;
 		if ($line) {
@@ -889,14 +881,13 @@ sub patch_update_file {
 				next;
 			}
 			elsif ($other =~ /s/ && $line =~ /^s/) {
-				my @split = split_hunk($hunk[$ix]{TEXT});
+				my @split = split_hunk($hunk[$ix]{TEXT},
+				    $hunk[$ix]{DISPLAY});
 				if (1 < @split) {
 					print colored $header_color, "Split into ",
 					scalar(@split), " hunks.\n";
 				}
-				splice(@hunk, $ix, 1,
-				       map { +{ TEXT => $_, USE => undef } }
-				       @split);
+				splice (@hunk, $ix, 1, @split);
 				$num = scalar @hunk;
 				next;
 			}
-- 
1.5.3.7.1079.gb270a-dirty
