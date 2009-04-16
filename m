From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Thu, 16 Apr 2009 03:14:15 -0400
Message-ID: <20090416071415.GC20071@coredump.intra.peff.net>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr> <7vws9rdmgd.fsf@gitster.siamese.dyndns.org> <vpqfxgevy58.fsf@bauges.imag.fr> <vpqtz4rynhp.fsf@bauges.imag.fr> <7v7i1lqz24.fsf@gitster.siamese.dyndns.org> <20090416060027.GA2992@coredump.intra.peff.net> <20090416065223.GA927@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 09:16:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuLpF-0007aT-Kj
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 09:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbZDPHOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbZDPHOW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 03:14:22 -0400
Received: from peff.net ([208.65.91.99]:49804 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbZDPHOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 03:14:21 -0400
Received: (qmail 657 invoked by uid 107); 16 Apr 2009 07:14:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 03:14:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 03:14:15 -0400
Content-Disposition: inline
In-Reply-To: <20090416065223.GA927@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116677>

On Thu, Apr 16, 2009 at 02:52:23AM -0400, Jeff King wrote:

> Anyway, I think this is a nice improvement on its own, and it should
> make Matthieu's patch a little cleaner.

Hmm, it looks like you just applied Matthieu's patch to next already.
Here is the rebased version of mine (the conflict resolution was pretty
trivial, though: just delete the newly added 'q' option from the mode
loop, which no longer exists).

-- >8 --
Subject: [PATCH] add-interactive: refactor mode hunk handling

The original implementation considered the mode separately
from the rest of the hunks, asking about it outside the main
hunk-selection loop. This patch instead places a mode change
as the first hunk in the loop. This has two advantages:

  1. less duplicated code (since we use the main selection
     loop). This also cleans up an inconsistency, which is
     that the main selection loop separates options with a
     comma, whereas the mode prompt used slashes.

  2. users can now skip the mode change and come back to it,
     search for it (via "/mode"), etc, as they can with other
     hunks.

To facilitate this, each hunk is now marked with a "type".
Mode hunks are not considered for splitting (which would
make no sense, and also confuses the split_hunk function),
nor are they editable. In theory, one could edit the mode
lines and change to a new mode. In practice, there are only
two modes that git cares about (0644 and 0755), so either
you want to move from one to the other or not (and you can
do that by staging or not staging).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |   64 ++++++++++++++------------------------------
 1 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 210d230..60dd1b5 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -620,11 +620,12 @@ sub parse_diff {
 	if ($diff_use_color) {
 		@colored = run_cmd_pipe(qw(git diff-files -p --color --), $path);
 	}
-	my (@hunk) = { TEXT => [], DISPLAY => [] };
+	my (@hunk) = { TEXT => [], DISPLAY => [], TYPE => 'header' };
 
 	for (my $i = 0; $i < @diff; $i++) {
 		if ($diff[$i] =~ /^@@ /) {
-			push @hunk, { TEXT => [], DISPLAY => [] };
+			push @hunk, { TEXT => [], DISPLAY => [],
+				TYPE => 'hunk' };
 		}
 		push @{$hunk[-1]{TEXT}}, $diff[$i];
 		push @{$hunk[-1]{DISPLAY}},
@@ -636,8 +637,8 @@ sub parse_diff {
 sub parse_diff_header {
 	my $src = shift;
 
-	my $head = { TEXT => [], DISPLAY => [] };
-	my $mode = { TEXT => [], DISPLAY => [] };
+	my $head = { TEXT => [], DISPLAY => [], TYPE => 'header' };
+	my $mode = { TEXT => [], DISPLAY => [], TYPE => 'mode' };
 
 	for (my $i = 0; $i < @{$src->{TEXT}}; $i++) {
 		my $dest = $src->{TEXT}->[$i] =~ /^(old|new) mode (\d+)$/ ?
@@ -684,6 +685,7 @@ sub split_hunk {
 		my $this = +{
 			TEXT => [],
 			DISPLAY => [],
+			TYPE => 'hunk',
 			OLD => $o_ofs,
 			NEW => $n_ofs,
 			OCNT => 0,
@@ -873,7 +875,11 @@ sub edit_hunk_loop {
 		if (!defined $text) {
 			return undef;
 		}
-		my $newhunk = { TEXT => $text, USE => 1 };
+		my $newhunk = {
+			TEXT => $text,
+			TYPE => $hunk->[$ix]->{TYPE},
+			USE => 1
+		};
 		if (diff_applies($head,
 				 @{$hunk}[0..$ix-1],
 				 $newhunk,
@@ -987,37 +993,7 @@ sub patch_update_file {
 	}
 
 	if (@{$mode->{TEXT}}) {
-		while (1) {
-			print @{$mode->{DISPLAY}};
-			print colored $prompt_color,
-				"Stage mode change [y/n/a/d/?]? ";
-			my $line = prompt_single_character;
-			if ($line =~ /^y/i) {
-				$mode->{USE} = 1;
-				last;
-			}
-			elsif ($line =~ /^n/i) {
-				$mode->{USE} = 0;
-				last;
-			}
-			elsif ($line =~ /^a/i) {
-				$_->{USE} = 1 foreach ($mode, @hunk);
-				last;
-			}
-			elsif ($line =~ /^d/i) {
-				$_->{USE} = 0 foreach ($mode, @hunk);
-				last;
-			}
-			elsif ($line =~ /^q/i) {
-				$_->{USE} = 0 foreach ($mode, @hunk);
-				$quit = 1;
-				last;
-			}
-			else {
-				help_patch_cmd('');
-				next;
-			}
-		}
+		unshift @hunk, $mode;
 	}
 
 	$num = scalar @hunk;
@@ -1061,14 +1037,19 @@ sub patch_update_file {
 		}
 		last if (!$undecided);
 
-		if (hunk_splittable($hunk[$ix]{TEXT})) {
+		if ($hunk[$ix]{TYPE} eq 'hunk' &&
+		    hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= ',s';
 		}
-		$other .= ',e';
+		if ($hunk[$ix]{TYPE} eq 'hunk') {
+			$other .= ',e';
+		}
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, "Stage this hunk [y,n,a,d,/$other,?]? ";
+		print colored $prompt_color, 'Stage ',
+		  ($hunk[$ix]{TYPE} eq 'mode' ? 'mode change' : 'this hunk'),
+		  " [y,n,a,d,/$other,?]? ";
 		my $line = prompt_single_character;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -1210,7 +1191,7 @@ sub patch_update_file {
 				$num = scalar @hunk;
 				next;
 			}
-			elsif ($line =~ /^e/) {
+			elsif ($other =~ /e/ && $line =~ /^e/) {
 				my $newhunk = edit_hunk_loop($head, \@hunk, $ix);
 				if (defined $newhunk) {
 					splice @hunk, $ix, 1, $newhunk;
@@ -1231,9 +1212,6 @@ sub patch_update_file {
 
 	my $n_lofs = 0;
 	my @result = ();
-	if ($mode->{USE}) {
-		push @result, @{$mode->{TEXT}};
-	}
 	for (@hunk) {
 		if ($_->{USE}) {
 			push @result, @{$_->{TEXT}};
-- 
1.6.3.rc0.204.g6bb2
