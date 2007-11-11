From: Dan Zwell <dzwell@zwell.net>
Subject: Subject: [PATCH 1/3] Added basic color support to git add
 --interactive
Date: Sat, 10 Nov 2007 20:23:19 -0600
Message-ID: <20071110202319.1f89a755@paradox.zwell.net>
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
X-From: git-owner@vger.kernel.org Sun Nov 11 06:11:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir56Q-00082t-IE
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 06:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbXKKFKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 00:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXKKFKt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 00:10:49 -0500
Received: from gateway01.websitewelcome.com ([67.18.66.19]:43856 "EHLO
	gateway01.websitewelcome.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750871AbXKKFKs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 00:10:48 -0500
X-Greylist: delayed 6400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2007 00:10:48 EST
Received: (qmail 7767 invoked from network); 11 Nov 2007 02:24:18 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway01.websitewelcome.com with ESMTPS (DHE-RSA-AES256-SHA encrypted); 11 Nov 2007 02:24:18 -0000
Received: from [143.44.70.185] (port=54808 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Ir2Ux-0001aM-Vr; Sat, 10 Nov 2007 20:24:34 -0600
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64398>

Added function "colored()" that prints text with a color that
is passed in. Converted many calls to "print" to being calls to
"print colored".

The prompt, the header, and the help output are the 3 types of
colorized output, and each has its own color.

Colorization is done through Term::ANSIColor, which is included
with modern versions of perl. This is optional, and should not
need to be present if color.interactive is not turned on.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
The last version of this e-mail was line wrapped, if it was 
successfully sent at all...
 Documentation/config.txt  |    6 ++++++
 git-add--interactive.perl |   44 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8d5d200..3712d6a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -382,6 +382,12 @@ color.diff.<slot>::
 	whitespace).  The values of these variables may be specified as
 	in color.branch.<slot>.
 
+color.interactive::
+	When true (or `always`), always use colors in `git add
+	--interactive`.  When false (or `never`), never.  When set to
+	`auto`, use colors only when the output is to the
+	terminal. Defaults to false.
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ac598f8..f2b0e56 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,38 @@
 
 use strict;
 
+my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
+my $color_config = qx(git config --get color.interactive);
+if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
+	eval { require Term::ANSIColor; };
+	if (!$@) {
+		$use_color = 1;
+
+		# Sane (visible) defaults:
+		$prompt_color = Term::ANSIColor::color("blue bold");
+		$header_color = Term::ANSIColor::color("bold");
+		$help_color   = Term::ANSIColor::color("red bold");
+		$normal_color = Term::ANSIColor::color("reset");
+	}
+}
+
+sub colored {
+	my $color = shift;
+	my $string = join("", @_);
+
+	if ($use_color) {
+		# Put a color code at the beginning of each line, a reset at the end
+		# color after newlines that are not at the end of the string
+		$string =~ s/(\n+)(.)/$1$color$2/g;
+		# reset before newlines
+		$string =~ s/(\n+)/$normal_color$1/g;
+		# codes at beginning and end (if necessary):
+		$string =~ s/^/$color/;
+		$string =~ s/$/$normal_color/ unless $string =~ /\n$/;
+	}
+	return $string;
+}
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -175,7 +207,7 @@ sub list_and_choose {
 			if (!$opts->{LIST_FLAT}) {
 				print "     ";
 			}
-			print "$opts->{HEADER}\n";
+			print colored $header_color, "$opts->{HEADER}\n";
 		}
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
@@ -205,7 +237,7 @@ sub list_and_choose {
 
 		return if ($opts->{LIST_ONLY});
 
-		print $opts->{PROMPT};
+		print colored $prompt_color, $opts->{PROMPT};
 		if ($opts->{SINGLETON}) {
 			print "> ";
 		}
@@ -544,7 +576,7 @@ sub coalesce_overlapping_hunks {
 }
 
 sub help_patch_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks
@@ -619,7 +651,7 @@ sub patch_update_cmd {
 		for (@{$hunk[$ix]{TEXT}}) {
 			print;
 		}
-		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -673,7 +705,7 @@ sub patch_update_cmd {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT});
 				if (1 < @split) {
-					print "Split into ",
+					print colored $header_color, "Split into ",
 					scalar(@split), " hunks.\n";
 				}
 				splice(@hunk, $ix, 1,
@@ -766,7 +798,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
-- 
1.5.3.5.565.gf0b83-dirty
