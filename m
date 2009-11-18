From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 4/6] gitweb: Allow committag pattern matches to span multiple lines
Date: Tue, 17 Nov 2009 22:22:28 -0800
Message-ID: <1258525350-5528-5-git-send-email-marcel@oak.homeunix.org>
References: <200906221318.19598.jnareb@gmail.com>
 <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-3-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-4-git-send-email-marcel@oak.homeunix.org>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 07:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAe2s-000378-CA
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbZKRG3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbZKRG3P
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:29:15 -0500
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:45161 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753729AbZKRG3O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 01:29:14 -0500
Received: (qmail 7172 invoked from network); 18 Nov 2009 06:22:41 -0000
Received: from adsl-76-246-148-73.dsl.pltn13.sbcglobal.net (marcel@76.246.148.73 with plain)
        by smtp128.sbc.mail.sp1.yahoo.com with SMTP; 17 Nov 2009 22:22:41 -0800 PST
X-Yahoo-SMTP: WxgK_ZmswBCwjfqSjWfXdnSm2tyuJVtcxuu8Nw--
X-YMail-OSG: eRbKZCoVM1n7NHq8kjHhQUhD9Cyu3iQQQ0JzE4zcvRXLy.QOBMmUxKiBARU8lA8Ejdn7e5pkpj9QfODnpw6UVtHnl8Mw7v25_RS6jmVJ36MXKD0OktOAzhSP.uZu8R3Pnap.oN.8N3nOKppmWOrQLRH6bJw0N96UyHDu6cMrk95mabOmX_SL4JcMBJHXnVb9khpEFmV09zu6YpgV5zeGovn39ApGBmTwAIaP2UepddF92NEqq5_qioZ1Ga2qHxu9VXRUOyrIWtuh4USCOsESrsxwYnS5fvbHR47Z6jUMZlQooPC0f_AnrjUCaz.2O8Ls2Jr9iWWu9AkKJ86phzci4NvXFPdqwaA_yFEbsgwd5Fi_LhgjU.I5zyFHsje.9iHgGL3moShIAvkDe3A-
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1NAdvz-0004p6-Rw; Tue, 17 Nov 2009 22:22:31 -0800
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1258525350-5528-4-git-send-email-marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133143>

Committags cannot currently span multiple lines.  Since some committag
patterns match multiple words.  If some of those words wrap to the
next line, the committag would miss an opportunity to match.

Eliminate the for-loop over @log and pull the signoff transformation
from that loop into a committag.

The message will still get cut into pieces as committags are applied,
but at least newlines no longer force a cut.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---
 gitweb/gitweb.perl           |   67 +++++++++++++++++++-----------------------
 t/t9502-gitweb-committags.sh |    8 +++++
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8f4480e..7f7d3a3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -255,6 +255,21 @@ our %committags = (
 			                esc_html($match[0], -nbsp=>1));
 		},
 	},
+	# Facilitate styling of common header/footer lines, suppressing
+	# any trailing newlines
+	'signoff' => {
+		'options' => {
+			'pattern' =>
+				qr/^( *(?:signed[ \-]off[ \-]by|acked[ \-]by|cc)[ :].*)\n*$/mi,
+		},
+		'override' => 0,
+		'sub' => sub {
+			my ($opts, @match) = @_;
+			return (\$cgi->span({'class' => 'signoff'},
+			                    esc_html($match[1], -nbsp=>1)),
+			        "\n");
+		},
+	},
 	# Link bug/features to Mantis bug tracker using Mantis-style
 	# contextual cues
 	'mantis' => {
@@ -542,7 +557,7 @@ our %feature = (
 	'committags' => {
 		'sub' => sub { feature_list('committags', @_) },
 		'override' => 0,
-		'default' => ['sha1']},
+		'default' => ['signoff', 'sha1']},
 );
 
 sub gitweb_get_feature {
@@ -1619,8 +1634,8 @@ sub file_type_long {
 ## which don't belong to other sections
 
 # format line of commit message.
-sub format_log_line_html {
-	my $line = shift;
+sub format_log_html {
+	my $text = shift;
 
 	# Merge project configs with site default committag definitions if
 	# it hasn't been done yet
@@ -1629,7 +1644,7 @@ sub format_log_line_html {
 	# In this list of log message fragments, a string ref indicates
 	# HTML, and a string indicates plain text.  The string refs are
 	# also currently not processed by subsequent committags.
-	my @message_fragments = ( $line );
+	my @message_fragments = ( $text );
 
 COMMITTAG:
 	foreach my $ctname (@committags) {
@@ -1671,7 +1686,9 @@ COMMITTAG:
 		if (ref($fragment)) {
 			$html .= $$fragment;
 		} else {
-			$html .= esc_html($fragment, -nbsp=>1);
+			# Don't let esc_html turn "\n" into "\\n"
+			$html .= join("<br/>\n", map { esc_html($_, -nbsp=>1) }
+			                             split("\n", $fragment, -1));
 		}
 	}
 
@@ -3776,40 +3793,16 @@ sub git_print_log {
 		shift @$log;
 	}
 
-	# print log
-	my $signoff = 0;
-	my $empty = 0;
-	foreach my $line (@$log) {
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			$signoff = 1;
-			$empty = 0;
-			if (! $opts{'-remove_signoff'}) {
-				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
-				next;
-			} else {
-				# remove signoff lines
-				next;
-			}
-		} else {
-			$signoff = 0;
-		}
-
-		# print only one empty line
-		# do not print empty line after signoff
-		if ($line eq "") {
-			next if ($empty || $signoff);
-			$empty = 1;
-		} else {
-			$empty = 0;
-		}
-
-		print format_log_line_html($line) . "<br/>\n";
-	}
-
 	if ($opts{'-final_empty_line'}) {
-		# end with single empty line
-		print "<br/>\n" unless $empty;
+		# If we already have a trailing newline, this will be
+		# coalesced with it later.
+		push @$log, "";
 	}
+
+	# print log
+	my $text = join("\n", @$log) . "\n";
+	$text =~ s{\n\n+}{\n\n}g;
+	print format_log_html($text);
 }
 
 # return link target (what link points to)
diff --git a/t/t9502-gitweb-committags.sh b/t/t9502-gitweb-committags.sh
index e13ac47..0753630 100755
--- a/t/t9502-gitweb-committags.sh
+++ b/t/t9502-gitweb-committags.sh
@@ -138,6 +138,10 @@ Fix memory leak in confabulator from bug 123.
 Based on history from bugs 223, 224, and 225,
 fix bug 323 or 324.
 
+Bugs:
+1234,
+1235
+
 Bug: 423,424,425,426,427,428,429,430,431,432,435
 Resolves-bugs: #523 #524
 END
@@ -167,6 +171,10 @@ test_expect_success 'bugzilla: fancy defaults: space-separated with hash' '
 		"-bugs:&nbsp;<a[^>]*>#523</a>&nbsp;<a[^>]*>#524</a>" \
 		gitweb.output
 '
+test_expect_success 'bugzilla: fancy defaults: spanning newlines' '
+	grep -q -e "<a[^>]*>1234</a>,<br" gitweb.output &&
+	grep -q -e "<a[^>]*>1235</a><br" gitweb.output
+'
 test_debug 'cat gitweb.log'
 test_debug 'grep 23 gitweb.output'
 
-- 
1.6.4.4
