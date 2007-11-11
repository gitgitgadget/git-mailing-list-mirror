From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 3/3] Added diff hunk coloring to git-add--interactive
Date: Sat, 10 Nov 2007 18:03:44 -0600
Message-ID: <20071110180344.05a81497@paradox.zwell.net>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 02:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir1Dk-00016I-Rp
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 02:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbXKKBCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 20:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbXKKBCX
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 20:02:23 -0500
Received: from gateway03.websitewelcome.com ([69.93.223.26]:57054 "EHLO
	gateway03.websitewelcome.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751259AbXKKBCV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 20:02:21 -0500
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2007 20:02:21 EST
Received: (qmail 21178 invoked from network); 11 Nov 2007 00:04:49 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway03.websitewelcome.com with ESMTPS (DHE-RSA-AES256-SHA encrypted); 11 Nov 2007 00:04:49 -0000
Received: from [143.44.70.185] (port=41462 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Ir0Js-0008AB-RQ; Sat, 10 Nov 2007 18:04:58 -0600
In-Reply-To: <20071104054305.GA13929@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64391>

Added and integrated method "color_diff_hunk", which colors
lines, and returns them in an array. Coloring bad whitespace is
not yet supported.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
 git-add--interactive.perl |   58 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 508531f..d92e8ed 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -3,7 +3,11 @@
 use strict;
 use Git;
 
+# Prompt colors:
 my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
+# Diff colors:
+my ($diff_use_color, $new_color, $old_color, $fraginfo_color,
+    $metainfo_color, $whitespace_color);
 my $color_config = qx(git config --get color.interactive);
 if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
 	eval { require Term::ANSIColor; };
@@ -21,6 +25,24 @@ if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
 		$help_color = Git::color_to_ansi_code(
 			Git::config($repo, "color.interactive.help") || "red bold");
 		$normal_color = Git::color_to_ansi_code("normal");
+
+		# Do we also set diff colors?
+		my $diff_colors = Git::config($repo, "color.diff");
+		if ($diff_colors=~/true/ ||
+			-t STDOUT && $diff_colors=~/auto/) {
+			$diff_use_color = 1;
+			$new_color = Git::color_to_ansi_code(
+				Git::config($repo, "color.diff.new") || "green");
+			$old_color = Git::color_to_ansi_code(
+				Git::config($repo, "color.diff.old") || "red");
+			$fraginfo_color = Git::color_to_ansi_code(
+				Git::config($repo, "color.diff.frag") || "cyan");
+			$metainfo_color = Git::color_to_ansi_code(
+				Git::config($repo, "color.diff.meta") || "bold");
+			# Not implemented:
+			#$whitespace_color = Git::color_to_ansi_code(
+				#Git::config($repo, "color.diff.whitespace") || "normal red");
+		}
 	}
 }
 
@@ -389,6 +411,31 @@ sub parse_diff {
 	return @hunk;
 }
 
+sub colored_diff_hunk {
+	my ($text) = @_;
+	# return the text, so that it can be passed to print()
+	my @ret;
+	for (@$text) {
+		if (!$diff_use_color) {
+			push @ret, $_;
+			next;
+		}
+
+		if (/^\+/) {
+			push @ret, colored($new_color, $_);
+		} elsif (/^\-/) {
+			push @ret, colored($old_color, $_);
+		} elsif (/^\@/) {
+			push @ret, colored($fraginfo_color, $_);
+		} elsif (/^ /) {
+			push @ret, colored($normal_color, $_);
+		} else {
+			push @ret, colored($metainfo_color, $_);
+		}
+	}
+	return @ret;
+}
+
 sub hunk_splittable {
 	my ($text) = @_;
 
@@ -611,9 +658,7 @@ sub patch_update_cmd {
 	my ($ix, $num);
 	my $path = $it->{VALUE};
 	my ($head, @hunk) = parse_diff($path);
-	for (@{$head->{TEXT}}) {
-		print;
-	}
+	print colored_diff_hunk($head->{TEXT});
 	$num = scalar @hunk;
 	$ix = 0;
 
@@ -655,9 +700,7 @@ sub patch_update_cmd {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
-		for (@{$hunk[$ix]{TEXT}}) {
-			print;
-		}
+		print colored_diff_hunk($hunk[$ix]{TEXT});
 		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line = <STDIN>;
 		if ($line) {
@@ -795,8 +838,7 @@ sub diff_cmd {
 				     HEADER => $status_head, },
 				   @mods);
 	return if (!@them);
-	system(qw(git diff-index -p --cached HEAD --),
-	       map { $_->{VALUE} } @them);
+	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} } @them);
 }
 
 sub quit_cmd {
-- 
1.5.3.5.565.gf0b83-dirty
