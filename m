From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 5/5] Added diff hunk coloring to git-add--interactive
Date: Thu, 22 Nov 2007 04:56:24 -0600
Message-ID: <20071122045624.405e2b2b@paradox.zwell.net>
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
	<20071110180109.34febc3f@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:57:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9k1-0008BA-4a
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXKVK4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 05:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXKVK4r
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:56:47 -0500
Received: from gateway01.websitewelcome.com ([67.18.65.19]:56105 "HELO
	gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751604AbXKVK4q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 05:56:46 -0500
Received: (qmail 16649 invoked from network); 22 Nov 2007 10:57:27 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway01.websitewelcome.com with SMTP; 22 Nov 2007 10:57:27 -0000
Received: from [143.44.70.185] (port=40117 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dzwell@zwell.net>)
	id 1Iv9jc-0001p4-5C; Thu, 22 Nov 2007 04:56:40 -0600
In-Reply-To: <20071110180109.34febc3f@paradox.zwell.net>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.12.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65783>

Added and integrated method "color_diff_hunk", which colors
lines, and returns them in an array. Coloring bad whitespace is
not yet supported.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
 git-add--interactive.perl |   93 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f76f008..ba9430c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -4,9 +4,12 @@ use strict;
 use Git;
 
 my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
+my ($diff_use_color, $new_color, $old_color, $fraginfo_color,
+	$metainfo_color, $whitespace_color);
 
 {
 	my $repo = Git->repository();
+
 	# set interactive color options:
 	my $color_config = $repo->config('color.interactive');
 	$use_color = 0;
@@ -21,27 +24,55 @@ my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
 		$use_color = 1;
 	}
 
-	if ($use_color) {
+	# set diff color options
+	my $diff_color_config = $repo->config('color.diff');
+	if (!defined $diff_color_config) {
+		$diff_use_color = 0;
+	}
+	elsif ($diff_color_config =~ /true|always/) {
+		$diff_use_color = 1;
+	}
+	elsif ($diff_color_config eq 'auto' && -t STDOUT &&
+		   $ENV{'TERM'} ne 'dumb') {
+		$diff_use_color = 1;
+	}
+
+	# load color library if needed
+	if ($use_color || $diff_use_color) {
 		eval { require Term::ANSIColor; };
 		if ($@) {
 			# library did not load.
 			$use_color = 0;
+			$diff_use_color = 0;
 		}
-		else { # set up colors
-			# Grab the 3 main colors in git color string format, with sane
-			# (visible) defaults:
-			$prompt_color = Git::color_to_ansi_code(
-				scalar $repo->config_default('color.interactive.prompt',
-					'bold blue'));
-			$header_color = Git::color_to_ansi_code(
-				scalar $repo->config_default('color.interactive.header',
-					'bold'));
-			$help_color = Git::color_to_ansi_code(
-				scalar $repo->config_default('color.interactive.help',
-					'red bold'));
+	}
 
-			$normal_color = Git::color_to_ansi_code('normal');
-		}
+	# convenience function:
+	sub get_color {
+		my ($key, $default) = @_;
+		return Git::color_to_ansi_code(
+			scalar $repo->config_default($key, $default));
+	}
+	# set interactive colors
+	if ($use_color) {
+		# Grab the 3 main colors in git color string format, with sane
+		# (visible) defaults:
+		$prompt_color = get_color('color.interactive.prompt', 'bold blue');
+		$header_color = get_color('color.interactive.header', 'bold');
+		$help_color = get_color('color.interactive.help', 'red bold');
+		$normal_color = Git::color_to_ansi_code('normal');
+	}
+
+	# set diff colors
+	if ($diff_use_color) {
+		$new_color = get_color('color.diff.new', 'green');
+		$old_color = get_color('color.diff.old', 'red');
+		$fraginfo_color = get_color('color.diff.frag', 'cyan');
+		$metainfo_color = get_color('color.diff.meta', 'bold');
+		$normal_color = Git::color_to_ansi_code('normal');
+		# Not implemented:
+		#$whitespace_color = get_color('color.diff.whitespace',
+			#'normal red');
 	}
 }
 
@@ -410,6 +441,30 @@ sub parse_diff {
 	return @hunk;
 }
 
+sub color_diff_hunk {
+	# return the colored text, so that it can be passed to print()
+	my ($text) = @_;
+	if (!$diff_use_color) {
+		return @$text;
+	}
+
+	my @ret;
+	for (@$text) {
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
 
@@ -632,9 +687,7 @@ sub patch_update_cmd {
 	my ($ix, $num);
 	my $path = $it->{VALUE};
 	my ($head, @hunk) = parse_diff($path);
-	for (@{$head->{TEXT}}) {
-		print;
-	}
+	print color_diff_hunk($head->{TEXT});
 	$num = scalar @hunk;
 	$ix = 0;
 
@@ -676,9 +729,7 @@ sub patch_update_cmd {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
-		for (@{$hunk[$ix]{TEXT}}) {
-			print;
-		}
+		print color_diff_hunk($hunk[$ix]{TEXT});
 		print colored($prompt_color, "Stage this hunk [y/n/a/d$other/?]? ");
 		my $line = <STDIN>;
 		if ($line) {
-- 
1.5.3.5.565.gf0b83-dirty
