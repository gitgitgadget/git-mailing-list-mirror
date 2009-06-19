From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 2/2] gitweb: Add second-stage matching of bug IDs in bugzilla committag
Date: Fri, 19 Jun 2009 07:13:51 -0700
Message-ID: <1245420831-5103-2-git-send-email-marcel@oak.homeunix.org>
References: <1245420831-5103-1-git-send-email-marcel@oak.homeunix.org>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fg@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 16:20:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHexY-0007Lj-SE
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 16:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbZFSOUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 10:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbZFSOUm
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 10:20:42 -0400
Received: from n16.bullet.mail.mud.yahoo.com ([68.142.206.43]:22249 "HELO
	n16.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751357AbZFSOUl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 10:20:41 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2009 10:20:41 EDT
Received: from [68.142.200.221] by n16.bullet.mail.mud.yahoo.com with NNFMP; 19 Jun 2009 14:14:06 -0000
Received: from [68.142.201.251] by t9.bullet.mud.yahoo.com with NNFMP; 19 Jun 2009 14:14:06 -0000
Received: from [127.0.0.1] by omp412.mail.mud.yahoo.com with NNFMP; 19 Jun 2009 14:14:06 -0000
X-Yahoo-Newman-Id: 96923.8708.bm@omp412.mail.mud.yahoo.com
Received: (qmail 25810 invoked from network); 19 Jun 2009 14:14:05 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.100.199 with plain)
  by smtp109.sbc.mail.sp1.yahoo.com with SMTP; 19 Jun 2009 14:14:05 -0000
X-YMail-OSG: gbP16oEVM1m5jcqBm.OByWw73CiB0O8jBNzRtp0_d32bpHsOT1YdI6wU0YsIeOyB4MjF4omwLH78H4m6UuHcB_EfS9BXRQXJqzRDp2HInEpif2gSmgVX4pPRMWlry.ktRHke9JfZxK0ijciDgfNlyxiIo7DC4mvxaDT9ks5YjaD3bLbSqHPz7eK55_bx6NvLtwpNKzcgJSNm0dUt8FFYrC74nWv6_jVf2wCXOW6.46g_yKrveH4VgwDUXPVd69veo_NCVltSsku3kAt1B1iuujQ_fjU-
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1MHeqn-0001rB-3F; Fri, 19 Jun 2009 07:13:53 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1245420831-5103-1-git-send-email-marcel@oak.homeunix.org>
In-Reply-To: <200902180438.55081.jnareb@gmail.com>
References: <200902180438.55081.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121898>

Match Bugzilla bug IDs with two regexes instead of one.  The first is
a pre-filter that allows easy matching of multiple bug IDs on the same
line, and the second easily picks out the individual big IDs for
hyperlinking in the context of the first regex.

For example, it would help in matching these and hyperlinking each ID
individually.

	[#1234, #1235]
	Resolves-bug: 1234, 1235
	bugs 1234, 1235, and 1236

Maybe there's a better naming scheme for the two patterns?

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---
 gitweb/gitweb.perl                     |   61 ++++++++++++++++++++++----------
 t/t9500-gitweb-standalone-no-errors.sh |   18 +++++++++
 2 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c66fdf3..47c8cd5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -227,14 +227,28 @@ our %committags = (
 		'override' => 0,
 		'sub' => \&hyperlink_committag,
 	},
-	# Link mentions of bug IDs to bugzilla
+	# Link mentions of bugs to bugzilla, allowing for separate outer
+	# and inner regexes (see unit test for example)
 	'bugzilla' => {
 		'options' => {
 			'pattern' => qr/bug\s+(\d+)/,
+			'innerpattern' => undef,
 			'url' => 'http://bugzilla.kernel.org/show_bug.cgi?id=',
 		},
 		'override' => 0,
-		'sub' => \&hyperlink_committag,
+		'sub' => sub {
+			my ($opts, @match) = @_;
+			if (defined($opts->{'innerpattern'})) {
+				my @list = ();
+				push_or_append_replacements(\@list, $opts->{innerpattern},
+				                            $match[0], sub {
+						return hyperlink_committag($opts, @_);
+					});
+				return @list;
+			} else {
+				return hyperlink_committag(@_);
+			}
+		},
 	},
 	# Link URLs
 	'url' => {
@@ -1539,23 +1553,9 @@ COMMITTAG:
 				next PART;
 			}
 
-			my $oldpos = 0;
-
-		MATCH:
-			while ($part =~ m/$pattern/gc) {
-				my ($prepos, $postpos) = ($-[0], $+[0]);
-				my $repl = $committag->{'sub'}->($opts, $&, $1);
-				$repl = "" if (!defined $repl);
-
-				my $pre = substr($part, $oldpos, $prepos - $oldpos);
-				push_or_append(\@newlist, $pre);
-				push_or_append(\@newlist, $repl);
-
-				$oldpos = $postpos;
-			} # end while [regexp matches]
-
-			my $rest = substr($part, $oldpos);
-			push_or_append(\@newlist, $rest);
+			push_or_append_replacements(\@newlist, $opts->{'pattern'}, $part, sub {
+					$committag->{'sub'}->($opts, @_);
+				});
 
 		} # end foreach (@list)
 
@@ -1586,6 +1586,29 @@ sub hyperlink_committag {
 				 esc_html($match[0], -nbsp=>1));
 }
 
+# Find $pattern in string $part, and push_or_append the parts between
+# matches and the result of calling $sub with matched text to $newlist.
+sub push_or_append_replacements {
+	my ($newlist, $pattern, $part, $sub) = @_;
+
+	my $oldpos = 0;
+
+MATCH:
+	while ($part =~ m/$pattern/gc) {
+		my ($prepos, $postpos) = ($-[0], $+[0]);
+
+		my @repl = $sub->($&, $1);
+
+		my $pre = substr($part, $oldpos, $prepos - $oldpos);
+		push_or_append($newlist, $pre);
+		push_or_append($newlist, @repl);
+
+		$oldpos = $postpos;
+	} # end while [regexp matches]
+
+	my $rest = substr($part, $oldpos);
+	push_or_append($newlist, $rest);
+}
 
 sub push_or_append (\@@) {
 	my $list = shift;
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 37a127c..573f03c 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -798,6 +798,24 @@ test_expect_success 'bugzilla: affects log view too' '
 test_debug 'cat gitweb.log'
 test_debug 'grep 1234 resp.http'
 
+echo hello > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+[#123,#45] This commit fixes two bugs involving bar and baz.
+END
+git config gitweb.committag.bugzilla.pattern       '^\[#\d+(,(&nbsp;)?#\d+)\]'
+git config gitweb.committag.bugzilla.innerpattern  '#(\d+)'
+git config gitweb.committag.bugzilla.url           'http://bugs/'
+test_expect_success 'bugzilla: override everything, use fancier url format' '
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -F -q \
+		"[<a class=\"text\" href=\"http://bugs/123\">#123</a>,<a class=\"text\" href=\"http://bugs/45\">#45</a>]" \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 123 resp.http'
+
 # ----------------------------------------------------------------------
 # url linking
 #
-- 
1.6.2
