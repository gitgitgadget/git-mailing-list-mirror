From: Dan Zwell <dzwell@zwell.net>
Subject: Subject: [PATCH 2/3] Let git-add--interactive read colors from
 .gitconfig
Date: Sat, 10 Nov 2007 20:23:51 -0600
Message-ID: <20071110202351.7b4544aa@paradox.zwell.net>
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
X-From: git-owner@vger.kernel.org Sun Nov 11 06:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir56j-00084o-Qk
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 06:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXKKFLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 00:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbXKKFLY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 00:11:24 -0500
Received: from gateway01.websitewelcome.com ([67.18.66.19]:51509 "EHLO
	gateway01.websitewelcome.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750836AbXKKFLX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 00:11:23 -0500
Received: (qmail 8530 invoked from network); 11 Nov 2007 02:24:51 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway01.websitewelcome.com with ESMTPS (DHE-RSA-AES256-SHA encrypted); 11 Nov 2007 02:24:51 -0000
Received: from [143.44.70.185] (port=54812 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Ir2VT-0003Yp-U4; Sat, 10 Nov 2007 20:25:06 -0600
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64399>

Colors are specified in color.interactive.{prompt,header,help}.
They are specified as git color strings as described in the
documentation. The method color_to_ansi_string() in Git.pm parses
these strings and returns ANSI color codes (using
Term::ANSIColor).

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
The last version of this e-mail was line wrapped, if it was 
successfully sent at all.

 Documentation/config.txt  |    7 +++++
 git-add--interactive.perl |   19 ++++++++++-----
 perl/Git.pm               |   55 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3712d6a..47c1ab2 100644
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
index f2b0e56..508531f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,7 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Git;
 
 my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
 my $color_config = qx(git config --get color.interactive);
@@ -8,12 +9,18 @@ if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
 	eval { require Term::ANSIColor; };
 	if (!$@) {
 		$use_color = 1;
-
-		# Sane (visible) defaults:
-		$prompt_color = Term::ANSIColor::color("blue bold");
-		$header_color = Term::ANSIColor::color("bold");
-		$help_color   = Term::ANSIColor::color("red bold");
-		$normal_color = Term::ANSIColor::color("reset");
+		# Set interactive colors:
+
+		# Grab the 3 main colors in git color string format, with sane
+		# (visible) defaults:
+		my $repo = Git->repository();
+		$prompt_color = Git::color_to_ansi_code(
+			Git::config($repo, "color.interactive.prompt") || "bold blue");
+		$header_color = Git::color_to_ansi_code(
+			Git::config($repo, "color.interactive.header") || "bold");
+		$help_color = Git::color_to_ansi_code(
+			Git::config($repo, "color.interactive.help") || "red bold");
+		$normal_color = Git::color_to_ansi_code("normal");
 	}
 }
 
diff --git a/perl/Git.pm b/perl/Git.pm
index dca92c8..c9e661a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -515,7 +515,6 @@ sub config {
 	};
 }
 
-
 =item config_bool ( VARIABLE )
 
 Retrieve the bool configuration C<VARIABLE>. The return value
@@ -550,6 +549,60 @@ sub config_bool {
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
+	return Term::ANSIColor::color(join(" ", @ansi_words)||"reset");
+}
+
 =item ident ( TYPE | IDENTSTR )
 
 =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
-- 
1.5.3.5.565.gf0b83-dirty
