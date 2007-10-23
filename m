From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH] Let git-add--interactive read "git colors" from git-config
Date: Mon, 22 Oct 2007 21:19:58 -0500
Message-ID: <20071022211958.045895ac@danzwell.com>
References: <471045DA.5050902@gmail.com>
	<19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	<20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022163244.4af72973@danzwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 04:21:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik9P3-0007vq-Br
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 04:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbXJWCVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 22:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXJWCVm
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 22:21:42 -0400
Received: from gator290.hostgator.com ([74.53.26.226]:57660 "EHLO
	gator290.hostgator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbXJWCVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 22:21:41 -0400
Received: from [143.44.70.185] (port=53483 helo=danzwell.com)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Ik9Oh-0004wt-VT; Mon, 22 Oct 2007 21:21:37 -0500
In-Reply-To: <20071022163244.4af72973@danzwell.com>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62072>

Colors are specified in color.interactive.{prompt,header,help}.
They are specified as git color strings as described in the
documentation, then parsed into perl color strings (slightly
different). Ugly but visible defaults are still used.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
This patch is againts Shawn Pearce's "pu" branch.
 Documentation/config.txt  |   17 ++-------
 git-add--interactive.perl |   78 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 19 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 99b3817..d06f55f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -390,19 +390,10 @@ color.interactive::
 
 color.interactive.<slot>::
 	Use customized color for `git add --interactive`
-	output. `<slot>` may be `prompt`, `header`, or `help`,
-	for three distinct types of common output from interactive
-	programs. The values may be a space-delimited combination
-	of up to three of the following:
-+
-(optional attribute, optional foreground color, and optional background)
-+
-dark, bold, underline, underscore, blink, reverse, concealed,
-black, red, green, yellow, blue, magenta, cyan, white, on_black,
-on_red, on_green, on_yellow, on_blue, on_magenta, on_cyan, on_white
-+
-Note these are not the same colors/attributes that the rest of
-git supports, but are specific to `git-add --interactive`.
+	output. `<slot>` may be `prompt`, `header`, or `help`, for
+	three distinct types of normal output from interactive
+	programs.  The values of these variables may be specified as
+	in color.branch.<slot>.
 
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 37be4b0..ca1ca28 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -6,12 +6,78 @@ my ($use_color, $prompt_color, $header_color, $help_color);
 my $color_config = qx(git config --get color.interactive);
 if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
 	$use_color = "true";
-	chomp( $prompt_color = qx(git config --get color.interactive.prompt) );
-	chomp( $header_color = qx(git config --get color.interactive.header) );
-	chomp( $help_color = qx(git config --get color.interactive.help) );
-	$prompt_color ||= "red bold";
-	$header_color ||= "bold";
-	$help_color ||= "blue bold";
+	# Grab the 3 main colors in git color string format:
+	my @git_prompt_color =
+		split(/\s+/, qx(git config --get color.interactive.prompt));
+	my @git_header_color =
+		split(/\s+/, qx(git config --get color.interactive.header));
+	my @git_help_color =
+		split(/\s+/, qx(git config --get color.interactive.help));
+
+	# Sane (visible) defaults:
+	if (! @git_prompt_color) {
+		@git_prompt_color = ("blue", "bold");
+	}
+	if (! @git_header_color) {
+		@git_header_color = ("bold");
+	}
+	if (! @git_help_color) {
+		@git_help_color = ("red", "bold");
+	}
+
+	# Parse the git colors into perl colors:
+	my %attrib_mappings = (
+		"bold"    => "bold",
+		"ul"      => "underline",
+		"blink"   => "blink",
+		# not supported:
+		#"dim"     => "",
+		"reverse" => "reverse"
+	);
+
+	my @tmp_perl_colors;
+	my $color_list;
+	# Loop over the array of (arrays of) git-style colors
+	foreach $color_list ([@git_prompt_color], [@git_header_color],
+	                     [@git_help_color]) {
+		my $fg_done;
+		my @perl_attribs;
+		my $word;
+		foreach $word (@{$color_list}) {
+			if ($word =~ /normal/) {
+				$fg_done = "true";
+			}
+			elsif ($word =~ /black|red|green|yellow/ ||
+			       $word =~ /blue|magenta|cyan|white/) {
+				# is a color.
+				if ($fg_done) {
+					# this is the background
+					push @perl_attribs, "on_" . $word;
+				}
+				else {
+					# this is foreground
+					$fg_done = "true";
+					push @perl_attribs, $word;
+				}
+			}
+			else {
+				# this is an attribute, not a color.
+				if ($attrib_mappings{$word}) {
+					push(@perl_attribs,
+						 $attrib_mappings{$word});
+				}
+			}
+		}
+		if (@perl_attribs) {
+			push @tmp_perl_colors, join(" ", @perl_attribs);
+		}
+		else {
+			#@perl_attribs is empty, need a placeholder
+			push @tmp_perl_colors, "reset";
+		}
+	}
+	($prompt_color, $header_color, $help_color) =
+		@tmp_perl_colors;
 
 	require Term::ANSIColor;
 }
-- 
1.5.3.4.207.gc0ee
