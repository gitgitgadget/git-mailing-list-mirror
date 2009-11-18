From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 2/6] gitweb: Add second-stage matching of bug IDs in bugzilla committag
Date: Tue, 17 Nov 2009 22:22:26 -0800
Message-ID: <1258525350-5528-3-git-send-email-marcel@oak.homeunix.org>
References: <200906221318.19598.jnareb@gmail.com>
 <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 07:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAdwY-0001Od-P4
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbZKRGWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010AbZKRGWp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:22:45 -0500
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:38149 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753922AbZKRGWn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 01:22:43 -0500
Received: (qmail 9538 invoked from network); 18 Nov 2009 06:22:49 -0000
Received: from adsl-76-246-148-73.dsl.pltn13.sbcglobal.net (marcel@76.246.148.73 with plain)
        by smtp126.sbc.mail.sp1.yahoo.com with SMTP; 17 Nov 2009 22:22:48 -0800 PST
X-Yahoo-SMTP: WxgK_ZmswBCwjfqSjWfXdnSm2tyuJVtcxuu8Nw--
X-YMail-OSG: gyV1heYVM1nzNIgNsEnyFOHZftjqUKSM1npKb9tcEbr.rAOhCb3idORwcWewiY0AfPOiLF.iZNuFn6RV6YpWT.sW0mqShB7pcTUk7LNYFWOdukGNHg3BNVyxrZuPKi61vi15UchqHHOfyctBAaTpDnzxvWXxop2LSRXwQkQBw0p8PHy4CxaAZLcEXgsTaVcEyT3pjvF2m_rU1eFLmwYjcMmjoWq0GzfSN..0lxZ1vnYL2bYE7wxa4W8g7HTeamw251wHXZdCFrDBtvOQ31uTYVtCilIHQWA8ms.VA1xhrtVHoIo2
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1NAdvz-0004p6-Em; Tue, 17 Nov 2009 22:22:31 -0800
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133140>

Currently it's not easy to capture an unbounded number of items
in a committag phrase to hyperlink individually.

For example, I would like to match and hyperlinking each bug ID
individually in these situations:

	[#1234, #1235]
	Resolves-bug: 1234, 1235
	bugs 1234, 1235, and 1236

Match Bugzilla bug IDs with two regexes instead of one.  The first is
a pre-filter that allows easy matching of multiple bug IDs and
contextual queues like "bugs ___ and ___" in a phrase, and the second
easily picks out the individual big IDs for hyperlinking.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---
 gitweb/gitweb.perl           |   68 +++++++++++++++++++++++++++++------------
 t/t9502-gitweb-committags.sh |   69 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 112 insertions(+), 25 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2d72202..032b1c5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -262,14 +262,31 @@ our %committags = (
 		'override' => 0,
 		'sub' => \&hyperlink_committag,
 	},
-	# Link mentions of bug IDs to bugzilla
+	# Link mentions of bugs to bugzilla, allowing for separate outer
+	# and inner regexes (see unit test for example)
 	'bugzilla' => {
 		'options' => {
-			'pattern' => qr/bug\s+(\d+)/,
+			'pattern' => qr/(?i:bugs?):?\s+
+			                [#]?\d+(?:(?:,\s*|,?\sand\s|,?\sn?or\s|\s+)
+			                          [#]?\d+\b)*/x,
+			'innerpattern' => qr/#?(\d+)/,
 			'url' => 'http://bugzilla.example.com/show_bug.cgi?id=',
 		},
 		'override' => 0,
-		'sub' => \&hyperlink_committag,
+		'sub' => sub {
+			my ($opts, @match) = @_;
+			if ($opts->{'innerpattern'}) {
+				my @message_fragments = ();
+				push_or_append_replacements(\@message_fragments,
+				                            $opts->{'innerpattern'},
+				                            $match[0], sub {
+						return hyperlink_committag($opts, @_);
+					});
+				return @message_fragments;
+			} else {
+				return hyperlink_committag(@_);
+			}
+		},
 	},
 	# Link URLs
 	'url' => {
@@ -1626,23 +1643,10 @@ COMMITTAG:
 				next PART;
 			}
 
-			my $oldpos = 0;
-
-		MATCH:
-			while ($fragment =~ m/$pattern/gc) {
-				my ($prepos, $postpos) = ($-[0], $+[0]);
-				my $repl = $sub->($opts, $&, $1);
-				$repl = "" if (!defined $repl);
-
-				my $pre = substr($fragment, $oldpos, $prepos - $oldpos);
-				push_or_append(\@new_message_fragments, $pre);
-				push_or_append(\@new_message_fragments, $repl);
-
-				$oldpos = $postpos;
-			} # end while [regexp matches]
-
-			my $rest = substr($fragment, $oldpos);
-			push_or_append(\@new_message_fragments, $rest);
+			push_or_append_replacements(\@new_message_fragments,
+			                            $pattern, $fragment, sub {
+					$sub->($opts, @_);
+				});
 
 		} # end foreach (@message_fragments)
 
@@ -1672,6 +1676,30 @@ sub hyperlink_committag {
 	                esc_html($match[0], -nbsp=>1));
 }
 
+# Find $pattern in string $fragment, and push_or_append the parts
+# between matches and the result of calling $sub with matched text to
+# $new_fragments.
+sub push_or_append_replacements {
+	my ($new_fragments, $pattern, $fragment, $sub) = @_;
+
+	my $oldpos = 0;
+
+MATCH:
+	while ($fragment =~ m/$pattern/gc) {
+		my ($prepos, $postpos) = ($-[0], $+[0]);
+
+		my @repl = $sub->($&, $1);
+
+		my $pre = substr($fragment, $oldpos, $prepos - $oldpos);
+		push_or_append($new_fragments, $pre);
+		push_or_append($new_fragments, @repl);
+
+		$oldpos = $postpos;
+	} # end while [regexp matches]
+
+	my $rest = substr($fragment, $oldpos);
+	push_or_append($new_fragments, $rest);
+}
 
 sub push_or_append (\@@) {
 	my $fragments = shift;
diff --git a/t/t9502-gitweb-committags.sh b/t/t9502-gitweb-committags.sh
index f86cb3d..718e763 100755
--- a/t/t9502-gitweb-committags.sh
+++ b/t/t9502-gitweb-committags.sh
@@ -52,7 +52,7 @@ echo '$feature{"committags"}{"override"} = 1;' >> gitweb_config.perl
 test_expect_success 'bugzilla: enabled' '
 	gitweb_run "p=.git;a=commit;h=HEAD" &&
 	grep -F -q \
-		"Fixes&nbsp;<a class=\"text\" href=\"http://bugzilla.example.com/show_bug.cgi?id=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		"Fixes&nbsp;bug&nbsp;<a class=\"text\" href=\"http://bugzilla.example.com/show_bug.cgi?id=1234\">1234</a>&nbsp;involving" \
 		gitweb.output
 '
 test_debug 'cat gitweb.log'
@@ -62,7 +62,7 @@ git config gitweb.committag.bugzilla.url 'http://bts.example.com?bug='
 test_expect_success 'bugzilla: url overridden but not permitted' '
 	gitweb_run "p=.git;a=commit;h=HEAD" &&
 	grep -F -q \
-		"Fixes&nbsp;<a class=\"text\" href=\"http://bugzilla.example.com/show_bug.cgi?id=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		"Fixes&nbsp;bug&nbsp;<a class=\"text\" href=\"http://bugzilla.example.com/show_bug.cgi?id=1234\">1234</a>&nbsp;involving" \
 		gitweb.output
 '
 test_debug 'cat gitweb.log'
@@ -72,12 +72,13 @@ echo '$committags{"bugzilla"}{"override"} = 1;' >> gitweb_config.perl
 test_expect_success 'bugzilla: url overridden' '
 	gitweb_run "p=.git;a=commit;h=HEAD" &&
 	grep -F -q \
-		"Fixes&nbsp;<a class=\"text\" href=\"http://bts.example.com?bug=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		"Fixes&nbsp;bug&nbsp;<a class=\"text\" href=\"http://bts.example.com?bug=1234\">1234</a>&nbsp;involving" \
 		gitweb.output
 '
 test_debug 'cat gitweb.log'
 test_debug 'grep 1234 gitweb.output'
 
+git config gitweb.committag.bugzilla.innerpattern ''
 git config gitweb.committag.bugzilla.pattern 'Fixes bug (\d+)'
 test_expect_success 'bugzilla: pattern overridden' '
 	gitweb_run "p=.git;a=commit;h=HEAD" &&
@@ -87,17 +88,75 @@ test_expect_success 'bugzilla: pattern overridden' '
 '
 test_debug 'cat gitweb.log'
 test_debug 'grep 1234 gitweb.output'
-git config --unset gitweb.committag.bugzilla.pattern
 
+git config --unset gitweb.committag.bugzilla.innerpattern
+git config --unset gitweb.committag.bugzilla.pattern
 test_expect_success 'bugzilla: affects log view too' '
 	gitweb_run "p=.git;a=log" &&
 	grep -F -q \
-		"<a class=\"text\" href=\"http://bts.example.com?bug=1234\">bug&nbsp;1234</a>" \
+		"<a class=\"text\" href=\"http://bts.example.com?bug=1234\">1234</a>" \
 		gitweb.output
 '
 test_debug 'cat gitweb.log'
 test_debug 'grep 1234 gitweb.output'
 
+echo more_bugzilla > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+[#123,#45] This commit fixes two bugs involving bar and baz.
+END
+git config gitweb.committag.bugzilla.pattern       '^\[#\d+(, ?#\d+)\]'
+git config gitweb.committag.bugzilla.innerpattern  '#(\d+)'
+git config gitweb.committag.bugzilla.url           'http://bugs/'
+test_expect_success 'bugzilla: override everything, use fancier url format' '
+       gitweb_run "p=.git;a=commit;h=HEAD" &&
+       grep -F -q \
+               "[<a class=\"text\" href=\"http://bugs/123\">#123</a>,<a class=\"text\" href=\"http://bugs/45\">#45</a>]" \
+               gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 123 gitweb.output'
+
+echo even_more_bugzilla > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+Fix memory leak in confabulator from bug 123.
+
+Based on history from bugs 223, 224, and 225,
+fix bug 323 or 324.
+
+Bug: 423,424,425,426,427,428,429,430,431,432,435
+Resolves-bugs: #523 #524
+END
+git config --unset gitweb.committag.bugzilla.pattern
+git config --unset gitweb.committag.bugzilla.innerpattern
+git config --unset gitweb.committag.bugzilla.url
+gitweb_run "p=.git;a=commit;h=HEAD"
+test_expect_success 'bugzilla: fancy defaults: match one bug' '
+	grep -q "from&nbsp;bug&nbsp;<a[^>]*>123</a>." gitweb.output
+'
+test_expect_success 'bugzilla: fancy defaults: comma-separated list' '
+	grep -q \
+		"bugs&nbsp;<a[^>]*>223</a>,&nbsp;<a[^>]*>224</a>,&nbsp;and&nbsp;<a[^>]*>225</a>," \
+		gitweb.output
+'
+test_expect_success 'bugzilla: fancy defaults: or-pair' '
+	grep -q "bug&nbsp;<a[^>]*>323</a>&nbsp;or&nbsp;<a[^>]*>324</a>." \
+		gitweb.output
+'
+test_expect_success 'bugzilla: fancy defaults: comma-separated, caps, >10' '
+	grep -q \
+		"Bug:&nbsp;<a[^>]*>423</a>,<a[^>]*>424</a>,.*,<a[^>]*>435</a>" \
+		gitweb.output
+'
+test_expect_success 'bugzilla: fancy defaults: space-separated with hash' '
+	grep -q -e \
+		"-bugs:&nbsp;<a[^>]*>#523</a>&nbsp;<a[^>]*>#524</a>" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 23 gitweb.output'
+
 # ----------------------------------------------------------------------
 # url linking
 #
-- 
1.6.4.4
