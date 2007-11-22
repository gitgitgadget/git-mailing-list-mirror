From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 4/5] Let git-add--interactive read colors from configuration
Date: Thu, 22 Nov 2007 04:56:06 -0600
Message-ID: <20071122045606.0232fc2d@paradox.zwell.net>
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
X-From: git-owner@vger.kernel.org Thu Nov 22 12:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9ql-0001t4-Ef
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbXKVLDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbXKVLDp
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:03:45 -0500
Received: from gateway03.websitewelcome.com ([69.93.223.19]:39733 "HELO
	gateway03.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751977AbXKVLDn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 06:03:43 -0500
Received: (qmail 29743 invoked from network); 22 Nov 2007 10:56:45 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway03.websitewelcome.com with SMTP; 22 Nov 2007 10:56:45 -0000
Received: from [143.44.70.185] (port=40114 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dzwell@zwell.net>)
	id 1Iv9jK-0004I1-HM; Thu, 22 Nov 2007 04:56:22 -0600
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65786>

Colors are specified in color.interactive.{prompt,header,help}.
They are specified as git color strings as described in the
documentation. The method color_to_ansi_code() in Git.pm parses
these strings and returns ANSI color codes (using
Term::ANSIColor).

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
 Documentation/config.txt  |    7 ++++
 git-add--interactive.perl |   20 ++++++++---
 perl/Git.pm               |   80 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 100 insertions(+), 7 deletions(-)

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
index 2b5559f..f76f008 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -6,8 +6,8 @@ use Git;
 my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
 
 {
-	# set color options:
 	my $repo = Git->repository();
+	# set interactive color options:
 	my $color_config = $repo->config('color.interactive');
 	$use_color = 0;
 	if (!defined $color_config) {
@@ -28,11 +28,19 @@ my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
 			$use_color = 0;
 		}
 		else { # set up colors
-			# Sane (visible) defaults:
-			$prompt_color = Term::ANSIColor::color('blue bold');
-			$header_color = Term::ANSIColor::color('bold');
-			$help_color   = Term::ANSIColor::color('red bold');
-			$normal_color = Term::ANSIColor::color('reset');
+			# Grab the 3 main colors in git color string format, with sane
+			# (visible) defaults:
+			$prompt_color = Git::color_to_ansi_code(
+				scalar $repo->config_default('color.interactive.prompt',
+					'bold blue'));
+			$header_color = Git::color_to_ansi_code(
+				scalar $repo->config_default('color.interactive.header',
+					'bold'));
+			$help_color = Git::color_to_ansi_code(
+				scalar $repo->config_default('color.interactive.help',
+					'red bold'));
+
+			$normal_color = Git::color_to_ansi_code('normal');
 		}
 	}
 }
diff --git a/perl/Git.pm b/perl/Git.pm
index 7327300..18ef6b4 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -515,7 +515,6 @@ sub config {
 	};
 }
 
-
 =item config_bool ( VARIABLE )
 
 Retrieve the bool configuration C<VARIABLE>. The return value
@@ -578,6 +577,85 @@ sub config_default {
 	}
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
+color_to_ansi_code('') returns the empty string, and should do
+nothing when printed.
+
+=cut
+
+sub color_to_ansi_code {
+	my ($git_string) = @_;
+	my @ansi_words;
+	my %git_to_perl_color = (
+		'bold'    => 'bold',
+		'ul'      => 'underline',
+		'blink'   => 'blink',
+		'reverse' => 'reverse'
+		# not supported by Term::ANSIColor:
+		#'dim'     => ''
+	);
+	my %valid_color = map { $_ => 1 } qw(black red green yellow
+					    blue magenta cyan white);
+
+	my ($fg_done, $token);
+	foreach $token (split /\s+/, $git_string) {
+		$token = lc($token);
+
+		if ($token eq 'normal') {
+			$fg_done = 1;
+		}
+		elsif (exists $valid_color{$token}) {
+			# is a color.
+			if ($fg_done) {
+				# this is the background
+				push @ansi_words, 'on_' . $token;
+			}
+			else {
+				# this is foreground
+				$fg_done = 1;
+				push @ansi_words, $token;
+			}
+		}
+		else {
+			# this is an attribute, not a color.
+			if ($git_to_perl_color{$token}) {
+				push(@ansi_words,
+					 $git_to_perl_color{$token});
+			}
+			else {
+				print STDERR 'Warning: bad color or attribute: ';
+				print STDERR "\"$token\". Check git configuration.\n";
+			}
+		}
+	}
+
+	# decide what to return--return color codes, 'clear' code, or
+	# the empty string, depending on the input we were passed /
+	# what we have processed:
+	if (@ansi_words) {
+		return Term::ANSIColor::color(join(' ', @ansi_words));
+	}
+	else {
+		if ($fg_done) {
+			# the git attrib 'normal' was processed
+			return Term::ANSIColor::color('clear');
+		}
+		else {
+			return '';
+		}
+	}
+}
+
 =item ident ( TYPE | IDENTSTR )
 
 =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
-- 
1.5.3.5.565.gf0b83-dirty
