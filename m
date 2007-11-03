From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 2/2] Let git-add--interactive read colors from .gitconfig
Date: Fri, 2 Nov 2007 22:41:11 -0500
Message-ID: <20071102224111.7f7e165c@paradox.zwell.net>
References: <471045DA.5050902@gmail.com>
	<19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	<20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 03 04:41:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io9tK-00049Y-P7
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 04:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722AbXKCDlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 23:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756772AbXKCDlc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 23:41:32 -0400
Received: from gator290.hostgator.com ([74.53.26.226]:49349 "EHLO
	gator290.hostgator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbXKCDlb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 23:41:31 -0400
Received: from [143.44.70.185] (port=59544 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Io9sz-0007Jy-Pa; Fri, 02 Nov 2007 22:41:27 -0500
In-Reply-To: <20071023035221.66ea537f@danzwell.com>
X-Mailer: Claws Mail 3.0.0 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63202>

>From ad3c6a2f015197a72d85039783a63a24c19f7017 Mon Sep 17 00:00:00 2001
From: Dan Zwell <dzwell@zwell.net>
Date: Mon, 22 Oct 2007 16:08:01 -0500
Subject: [PATCH] Let git-add--interactive read colors from .gitconfig

Colors are specified in color.interactive.{prompt,header,help}.
They are specified as git color strings as described in the
documentation. The method color_to_ansi_string() in Git.pm parses
these strings and returns ANSI color codes (using
Term::ANSIColor).

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
One thought is that is seems a bit sloppy to call "require Term::ANSIColor"
within color_to_ansi_code(), but I can't really see a better way. After all,
that is where the methods from that library are really needed. And I don't
know why Git.pm should need to know whether color will end up being used.

 Documentation/config.txt  |    7 +++++
 git-add--interactive.perl |   22 ++++++++++++-----
 perl/Git.pm               |   56 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2fd783f..ade3399 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -388,6 +388,13 @@ color.interactive::
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
index 16dc7b0..2bce5a1 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,18 +1,26 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Git;
 
 my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
 my $color_config = qx(git config --get color.interactive);
 if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
-	require Term::ANSIColor;
-
 	$use_color = "true";
-	# Sane (visible) defaults:
-	$prompt_color = Term::ANSIColor::color("blue bold");
-	$header_color = Term::ANSIColor::color("bold");
-	$help_color   = Term::ANSIColor::color("red bold");
-	$normal_color = Term::ANSIColor::color("reset");
+	# Grab the 3 main colors in git color string format, with sane
+	# (visible) defaults:
+	my $repo = Git->repository();
+	my $git_prompt_color =
+		Git::config($repo, "color.interactive.prompt")||"bold blue";
+	my $git_header_color =
+		Git::config($repo, "color.interactive.header")||"bold";
+	my $git_help_color =
+		Git::config($repo, "color.interactive.help")||"red bold";
+
+	$prompt_color = Git::color_to_ansi_code($git_prompt_color);
+	$header_color = Git::color_to_ansi_code($git_header_color);
+	$help_color   = Git::color_to_ansi_code($git_help_color);
+	$normal_color = Git::color_to_ansi_code("normal");
 }
 
 sub print_colored {
diff --git a/perl/Git.pm b/perl/Git.pm
index 3f4080c..9100e0b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -515,7 +515,6 @@ sub config {
 	};
 }
 
-
 =item config_bool ( VARIABLE )
 
 Retrieve the bool configuration C<VARIABLE>. The return value
@@ -550,6 +549,61 @@ sub config_bool {
 }
 
 
+=item color_to_ansi_code ( COLOR )
+
+Converts a git-style color string, like "underline blue white" to
+an ANSI color code. The code is generated by Term::ANSIColor,
+after the string is parsed into the format that is accepted by
+that module. Used as follows:
+
+	print color_to_ansi_code("underline blue white");
+	print "some text";
+	print color_to_ansi_code("normal");
+
+=cut
+
+sub color_to_ansi_code {
+	my ($git_string) = @_;
+	my @ansi_words;
+	my %attrib_mappings = (
+		"bold"    => "bold",
+		"ul"      => "underline",
+		"blink"   => "blink",
+		# not supported:
+		#"dim"     => "",
+		"reverse" => "reverse"
+	);
+	my ($fg_done, $word);
+
+	foreach $word (split /\s+/, $git_string) {
+		if ($word =~ /normal/) {
+			$fg_done = "true";
+		}
+		elsif ($word =~ /black|red|green|yellow/ ||
+			   $word =~ /blue|magenta|cyan|white/) {
+			# is a color.
+			if ($fg_done) {
+				# this is the background
+				push @ansi_words, "on_" . $word;
+			}
+			else {
+				# this is foreground
+				$fg_done = "true";
+				push @ansi_words, $word;
+			}
+		}
+		else {
+			# this is an attribute, not a color.
+			if ($attrib_mappings{$word}) {
+				push(@ansi_words,
+					 $attrib_mappings{$word});
+			}
+		}
+	}
+	require Term::ANSIColor;
+	return Term::ANSIColor::color(join(" ", @ansi_words)||"reset");
+}
+
 =item ident ( TYPE | IDENTSTR )
 
 =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
-- 
1.5.3.5.474.g3e4bb
