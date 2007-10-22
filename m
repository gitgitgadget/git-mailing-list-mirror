From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 1/2] Added basic color support to git add --interactive
Date: Mon, 22 Oct 2007 16:32:44 -0500
Message-ID: <20071022163244.4af72973@danzwell.com>
References: <471045DA.5050902@gmail.com>
	<19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	<20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 00:57:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6Cj-0002R9-Bx
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 00:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbXJVW4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 18:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXJVW4t
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 18:56:49 -0400
Received: from gator290.hostgator.com ([74.53.26.226]:44963 "EHLO
	gator290.hostgator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbXJVW4s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 18:56:48 -0400
Received: from [143.44.70.185] (port=48528 helo=danzwell.com)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Ik54O-0000ij-8I; Mon, 22 Oct 2007 16:44:21 -0500
In-Reply-To: <20071017015152.GN13801@spearce.org>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62053>

Added function "print_colored" that prints text with a color that
is passed in. Converted many calls to "print" to being calls to
"print_colored".

The prompt, the header, and the help output are the 3 types of
colorized output, and each has its own color.

Colorization is done through Term::ANSIColor, which is included
with modern versions of perl. This is optional, and should not
need to be present if color.interactive is not turned on.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
 Documentation/config.txt  |    6 ++++++
 git-add--interactive.perl |   37 +++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 971fd9f..c795a35 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -381,6 +381,12 @@ color.diff.<slot>::
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
index be68814..c66ed4d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,31 @@
 
 use strict;
 
+my ($use_color, $prompt_color, $header_color, $help_color);
+my $color_config = qx(git config --get color.interactive);
+if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
+	$use_color = "true";
+        # Sane (visible) defaults:
+        $prompt_color = "blue bold";
+        $header_color = "bold";
+        $help_color = "red bold";
+
+	require Term::ANSIColor;
+}
+
+sub print_colored {
+	my $color = shift;
+	my @strings = @_;
+
+	if ($use_color) {
+		print Term::ANSIColor::color($color);
+		print(@strings);
+		print Term::ANSIColor::color("reset");
+	} else {
+		print @strings;
+	}
+}
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -175,7 +200,7 @@ sub list_and_choose {
 			if (!$opts->{LIST_FLAT}) {
 				print "     ";
 			}
-			print "$opts->{HEADER}\n";
+			print_colored $header_color, "$opts->{HEADER}\n";
 		}
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
@@ -205,7 +230,7 @@ sub list_and_choose {
 
 		return if ($opts->{LIST_ONLY});
 
-		print $opts->{PROMPT};
+		print_colored $prompt_color, $opts->{PROMPT};
 		if ($opts->{SINGLETON}) {
 			print "> ";
 		}
@@ -544,7 +569,7 @@ sub coalesce_overlapping_hunks {
 }
 
 sub help_patch_cmd {
-	print <<\EOF ;
+	print_colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks
@@ -619,7 +644,7 @@ sub patch_update_cmd {
 		for (@{$hunk[$ix]{TEXT}}) {
 			print;
 		}
-		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print_colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -673,7 +698,7 @@ sub patch_update_cmd {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT});
 				if (1 < @split) {
-					print "Split into ",
+					print_colored "$header_color", "Split into ",
 					scalar(@split), " hunks.\n";
 				}
 				splice(@hunk, $ix, 1,
@@ -769,7 +794,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print <<\EOF ;
+	print_colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
-- 
1.5.3.4.207.gc0ee
