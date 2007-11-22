From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 1/5] Added basic color support to git add --interactive
Date: Thu, 22 Nov 2007 04:54:46 -0600
Message-ID: <20071122045446.4b904632@paradox.zwell.net>
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
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:22:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvA8A-0007jw-39
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXKVLVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXKVLVo
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:21:44 -0500
Received: from gateway03.websitewelcome.com ([67.18.34.22]:44579 "HELO
	gateway03.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751011AbXKVLVn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 06:21:43 -0500
Received: (qmail 27306 invoked from network); 22 Nov 2007 10:55:25 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway03.websitewelcome.com with SMTP; 22 Nov 2007 10:55:25 -0000
Received: from [143.44.70.185] (port=40108 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dzwell@zwell.net>)
	id 1Iv9i2-0005i2-RD; Thu, 22 Nov 2007 04:55:02 -0600
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65794>

Added function "colored()" that prints text with a color that
is passed in. Converted many calls to "print" to being calls to
"print colored()".

The prompt, the header, and the help output are the 3 types of
colorized output, and each has its own color.

Colorization is done through Term::ANSIColor, which is included
with modern versions of perl. This is optional, and should not
need to be present if color.interactive is not turned on.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
 Documentation/config.txt  |    6 ++++
 git-add--interactive.perl |   66 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 7 deletions(-)

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
index ac598f8..2b5559f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,58 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Git;
+
+my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
+
+{
+	# set color options:
+	my $repo = Git->repository();
+	my $color_config = $repo->config('color.interactive');
+	$use_color = 0;
+	if (!defined $color_config) {
+		$use_color = 0;
+	}
+	elsif ($color_config =~ /true|always/) {
+		$use_color = 1;
+	}
+	elsif ($color_config eq 'auto' && -t STDOUT &&
+		   $ENV{'TERM'} ne 'dumb') {
+		$use_color = 1;
+	}
+
+	if ($use_color) {
+		eval { require Term::ANSIColor; };
+		if ($@) {
+			# library did not load.
+			$use_color = 0;
+		}
+		else { # set up colors
+			# Sane (visible) defaults:
+			$prompt_color = Term::ANSIColor::color('blue bold');
+			$header_color = Term::ANSIColor::color('bold');
+			$help_color   = Term::ANSIColor::color('red bold');
+			$normal_color = Term::ANSIColor::color('reset');
+		}
+	}
+}
+
+sub colored {
+	my $color = shift;
+	my $string = join('', @_);
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
 
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
@@ -175,7 +227,7 @@ sub list_and_choose {
 			if (!$opts->{LIST_FLAT}) {
 				print "     ";
 			}
-			print "$opts->{HEADER}\n";
+			print colored($header_color, "$opts->{HEADER}\n");
 		}
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
@@ -205,7 +257,7 @@ sub list_and_choose {
 
 		return if ($opts->{LIST_ONLY});
 
-		print $opts->{PROMPT};
+		print colored($prompt_color, $opts->{PROMPT});
 		if ($opts->{SINGLETON}) {
 			print "> ";
 		}
@@ -544,7 +596,7 @@ sub coalesce_overlapping_hunks {
 }
 
 sub help_patch_cmd {
-	print <<\EOF ;
+	print colored($help_color, <<\EOF );
 y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks
@@ -619,7 +671,7 @@ sub patch_update_cmd {
 		for (@{$hunk[$ix]{TEXT}}) {
 			print;
 		}
-		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored($prompt_color, "Stage this hunk [y/n/a/d$other/?]? ");
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -673,8 +725,8 @@ sub patch_update_cmd {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT});
 				if (1 < @split) {
-					print "Split into ",
-					scalar(@split), " hunks.\n";
+					print colored($header_color, "Split into ",
+						scalar(@split), " hunks.\n");
 				}
 				splice(@hunk, $ix, 1,
 				       map { +{ TEXT => $_, USE => undef } }
@@ -766,7 +818,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print <<\EOF ;
+	print colored($help_color, <<\EOF );
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
-- 
1.5.3.5.565.gf0b83-dirty
