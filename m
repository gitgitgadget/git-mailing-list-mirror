From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 2/2] Let git-add--interactive read colors from git-config
Date: Mon, 22 Oct 2007 16:40:48 -0500
Message-ID: <20071022164048.71a3dceb@danzwell.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 23 00:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6Ci-0002R9-NE
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 00:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbXJVW4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 18:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbXJVW4s
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 18:56:48 -0400
Received: from gator290.hostgator.com ([74.53.26.226]:44962 "EHLO
	gator290.hostgator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbXJVW4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 18:56:47 -0400
X-Greylist: delayed 4341 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2007 18:56:47 EDT
Received: from [143.44.70.185] (port=48528 helo=danzwell.com)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Ik54M-0000ij-4O; Mon, 22 Oct 2007 16:44:18 -0500
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62054>

Colors are specified in color.interactive.{prompt,header,help}.
They are specified as git color strings as described in the
documentation, then parsed into perl color strings (slightly
different). Ugly but visible defaults are still used.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
Note: the code to parse git-style color strings to perl-style color
strings should eventually be added to Git.pm so that other (perl)
parts of git can be configured to read colors from .gitconfig in
a nicer way. A git-style string is "ul red black", while perl 
likes strings like "underline red on_black".

 Documentation/config.txt  |    7 ++++
 git-add--interactive.perl |   76
++++++++++++++++++++++++++++++++++++++++++-- 2 files changed, 79
insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c795a35..75a976a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -387,6 +387,13 @@ color.interactive::
 	`auto`, use colors only when the output is to the
 	terminal. Defaults to false.
 
+color.interactive.<slot>::
+	Use customized color for `git add --interactive`
+	output. `<slot>` may be `prompt`, `header`, or `help`, for
+	three distinct types of normal output from interactive
+	programs.  The values of these variables may be specified as
+	in color.branch.<slot>.
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c66ed4d..d85ec92 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -6,10 +6,78 @@ my ($use_color, $prompt_color, $header_color, $help_color);
 my $color_config = qx(git config --get color.interactive);
 if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
 	$use_color = "true";
-        # Sane (visible) defaults:
-        $prompt_color = "blue bold";
-        $header_color = "bold";
-        $help_color = "red bold";
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
