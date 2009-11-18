From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 5/6] gitweb: Allow per-repository definition of new committags
Date: Tue, 17 Nov 2009 22:22:29 -0800
Message-ID: <1258525350-5528-6-git-send-email-marcel@oak.homeunix.org>
References: <200906221318.19598.jnareb@gmail.com>
 <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-3-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-4-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-5-git-send-email-marcel@oak.homeunix.org>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 07:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAdwB-0001Ib-5G
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbZKRGWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbZKRGWa
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:22:30 -0500
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:38011 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752733AbZKRGW3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 01:22:29 -0500
Received: (qmail 9375 invoked from network); 18 Nov 2009 06:22:35 -0000
Received: from adsl-76-246-148-73.dsl.pltn13.sbcglobal.net (marcel@76.246.148.73 with plain)
        by smtp126.sbc.mail.sp1.yahoo.com with SMTP; 17 Nov 2009 22:22:34 -0800 PST
X-Yahoo-SMTP: WxgK_ZmswBCwjfqSjWfXdnSm2tyuJVtcxuu8Nw--
X-YMail-OSG: mSkVOhEVM1nugrf_Rs3uYjNkCct0x9XzKqtwIHx9DNMrQtEvQyMcFbYxKLUkljjgjBYbCRkcWPYYD2qsyLpCBV4F8V_8ZrfDJi5_A95i9pqglP0Jj_B.GMXZweoJOG.Udsh3UCjwpQvtWkSzGuCvgRSHMtx0geavZpswgJtwogVsYYB93ZTSifXIRik040fLL6XaI_ujaP7HFEV.TFDGzHISV9TitOnhf21YvyyO1cBRUzxB_0uVQJ3czQjK3otTyQxmdgV25WhbOwsO.n3qT_ciIpOWfUgdZ7J5tWC5MJtrCJ0k
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1NAdvz-0004p6-U1; Tue, 17 Nov 2009 22:22:31 -0800
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1258525350-5528-5-git-send-email-marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133138>

Committags are limited to the functionality configured by the site
administrator.

Provide two more general purpose committag subroutines that replace
text by feeding the capturing groups of a pattern to a sprintf format.
One additionally escapes the parameters of the capturing groups for
producing HTML snippets, the other does not.

Then, if permitted by the site administrator, allow the 'sub' key to
be overridden in an existing committag and allow a new committag to be
defined completely from within the repository configuration.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---
 gitweb/gitweb.perl           |  135 ++++++++++++++++++++++++++++--------------
 t/t9502-gitweb-committags.sh |   50 +++++++++++++++
 2 files changed, 141 insertions(+), 44 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7f7d3a3..d413f22 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -214,8 +214,7 @@ our %avatar_size = (
 );
 
 # In general, the site admin can enable/disable per-project
-# configuration of each committag.  Only the 'options' part of the
-# committag is configurable per-project.
+# configuration of each committag.
 #
 # The site admin can of course add new tags to this hash or override
 # the 'sub' key if necessary.  But such changes may be fragile; this
@@ -241,12 +240,18 @@ our %avatar_size = (
 # on the implementation of the 'sub' key.  The hyperlink_committag
 # value appends the first captured group to the 'url' option, for example.
 #
+# The project configuration can define new committags.  Although the
+# project configuration cannot supply code defining a new 'sub' key,
+# the project configuration can choose from a list of pre-approved
+# subroutines named in the 'allowed_committag_subs' feature.  Both a
+# 'sub' key and 'pattern' key must be defined for the committag to be
+# used.  If the 'allowed_committag_subs' feature is empty, no new
+# committags can be defined in the project config.
+#
 our %committags = (
 	# Link Git-style hashes to this gitweb
 	'sha1' => {
-		'options' => {
-			'pattern' => qr/\b([0-9a-fA-F]{8,40})\b/,
-		},
+		'pattern' => qr/\b([0-9a-fA-F]{8,40})\b/,
 		'override' => 0,
 		'sub' => sub {
 			my ($opts, @match) = @_;
@@ -258,10 +263,8 @@ our %committags = (
 	# Facilitate styling of common header/footer lines, suppressing
 	# any trailing newlines
 	'signoff' => {
-		'options' => {
-			'pattern' =>
-				qr/^( *(?:signed[ \-]off[ \-]by|acked[ \-]by|cc)[ :].*)\n*$/mi,
-		},
+		'pattern' =>
+			qr/^( *(?:signed[ \-]off[ \-]by|acked[ \-]by|cc)[ :].*)\n*$/mi,
 		'override' => 0,
 		'sub' => sub {
 			my ($opts, @match) = @_;
@@ -273,23 +276,19 @@ our %committags = (
 	# Link bug/features to Mantis bug tracker using Mantis-style
 	# contextual cues
 	'mantis' => {
-		'options' => {
-			'pattern' => qr/(?:BUG|FEATURE)\((\d+)\)/,
-			'url' => 'http://www.example.com/mantisbt/view.php?id=',
-		},
+		'pattern' => qr/(?:BUG|FEATURE)\((\d+)\)/,
+		'url' => 'http://www.example.com/mantisbt/view.php?id=',
 		'override' => 0,
 		'sub' => \&hyperlink_committag,
 	},
 	# Link mentions of bugs to bugzilla, allowing for separate outer
 	# and inner regexes (see unit test for example)
 	'bugzilla' => {
-		'options' => {
-			'pattern' => qr/(?i:bugs?):?\s+
-			                [#]?\d+(?:(?:,\s*|,?\sand\s|,?\sn?or\s|\s+)
-			                          [#]?\d+\b)*/x,
-			'innerpattern' => qr/#?(\d+)/,
-			'url' => 'http://bugzilla.example.com/show_bug.cgi?id=',
-		},
+		'pattern' => qr/(?i:bugs?):?\s+
+		                [#]?\d+(?:(?:,\s*|,?\sand\s|,?\sn?or\s|\s+)
+		                          [#]?\d+\b)*/x,
+		'innerpattern' => qr/#?(\d+)/,
+		'url' => 'http://bugzilla.example.com/show_bug.cgi?id=',
 		'override' => 0,
 		'sub' => sub {
 			my ($opts, @match) = @_;
@@ -308,15 +307,13 @@ our %committags = (
 	},
 	# Link URLs
 	'url' => {
-		'options' => {
-			# Avoid matching punctuation that might immediately follow
-			# a url, is not part of the url, and is allowed in urls,
-			# like a full-stop ('.').
-			'pattern' => qr!(https?|ftps?|git|ssh|ssh+git|sftp|smb|webdavs?|
-			                 nfs|irc|nntp|rsync)
-			                ://[-_a-zA-Z0-9\@/&=+~#<>;%:.?]+
-			                   [-_a-zA-Z0-9\@/&=+~#<>]!x,
-		},
+		# Avoid matching punctuation that might immediately follow
+		# a url, is not part of the url, and is allowed in urls,
+		# like a full-stop ('.').
+		'pattern' => qr!(https?|ftps?|git|ssh|ssh+git|sftp|smb|webdavs?|
+		                 nfs|irc|nntp|rsync)
+		                ://[-_a-zA-Z0-9\@/&=+~#<>;%:.?]+
+		                   [-_a-zA-Z0-9\@/&=+~#<>]!x,
 		'override' => 0,
 		'sub' => sub {
 			my ($opts, @match) = @_;
@@ -327,10 +324,8 @@ our %committags = (
 	},
 	# Link Message-Id to mailing list archive
 	'messageid' => {
-		'options' => {
-			'pattern' => qr!(?:message|msg)-?id:?\s+(<[^>]+>)!i,
-			'url' => 'http://mid.gmane.org/',
-		},
+		'pattern' => qr!(?:message|msg)-?id:?\s+(<[^>]+>)!i,
+		'url' => 'http://mid.gmane.org/',
 		'override' => 0,
 		# Includes the "msg-id" text in the link text.
 		# Since we don't support linking multiple msg-ids in one match, we
@@ -558,6 +553,22 @@ our %feature = (
 		'sub' => sub { feature_list('committags', @_) },
 		'override' => 0,
 		'default' => ['signoff', 'sha1']},
+
+	# The list of committag callbacks that are permitted to be used
+	# from within a repository configuration.  These are interpretted
+	# as perl subrouting names.  If none are listed, no new committags
+	# can be defined in the project config, which is the default.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'allowed_committag_subs'}{'default'} = [
+	#		'hyperlink_committag',
+	#		'markup_committag',
+	#		'transform_committag',
+	#		];
+	# It would not make sense to allow per-project overrides of this.
+	'allowed_committag_subs' => {
+		'override' => 0,
+		'default' => []},
 );
 
 sub gitweb_get_feature {
@@ -1030,6 +1041,9 @@ if ($git_avatar eq 'gravatar') {
 # ordering of committags
 our @committags = gitweb_get_feature('committags');
 
+# ordering of committags
+our @allowed_committag_subs = gitweb_get_feature('allowed_committag_subs');
+
 # whether we've loaded committags for the project yet
 our $loaded_project_committags = 0;
 
@@ -1046,9 +1060,18 @@ sub gitweb_load_project_committags {
 			split(/\./, $key, 4);
 		$project_config{$ctname}{$option} = $raw_config{$key};
 	}
-	foreach my $ctname (keys(%committags)) {
-		my $override = $committags{$ctname}{'override'};
+
+	my %allowed_subs = ();
+	foreach my $sub (@allowed_committag_subs) {
+		$allowed_subs{$sub} = 1;
+	}
+
+	foreach my $ctname (keys(%project_config)) {
+		my $override = $committags{$ctname}
+			? $committags{$ctname}{'override'}
+			: 1;
 		next if (!$override);
+
 		my $override_keys = undef;
 		if (ref($override) eq "ARRAY") {
 			$override_keys = {};
@@ -1056,12 +1079,19 @@ sub gitweb_load_project_committags {
 				$override_keys->{$optname} = 1;
 			}
 		}
+
 		foreach my $optname (keys %{$project_config{$ctname}}) {
 			next if ($override_keys && !$override_keys->{$optname});
-			$committags{$ctname}{'options'}{$optname} =
-				$project_config{$ctname}{$optname};
+			my $value = $project_config{$ctname}{$optname};
+			if ($optname eq 'sub') {
+				if (!$allowed_subs{$value}) {
+					next;
+				}
+			}
+			$committags{$ctname}{$optname} = $value;
 		}
 	}
+
 	$loaded_project_committags = 1;
 }
 
@@ -1654,11 +1684,8 @@ COMMITTAG:
 		next COMMITTAG unless exists $committag->{'sub'};
 		my $sub = $committag->{'sub'};
 
-		next COMMITTAG unless exists $committag->{'options'};
-		my $opts = $committag->{'options'};
-
-		next COMMITTAG unless exists $opts->{'pattern'};
-		my $pattern = $opts->{'pattern'};
+		next COMMITTAG unless exists $committag->{'pattern'};
+		my $pattern = $committag->{'pattern'};
 
 		my @new_message_fragments = ();
 
@@ -1672,7 +1699,8 @@ COMMITTAG:
 
 			push_or_append_replacements(\@new_message_fragments,
 			                            $pattern, $fragment, sub {
-					$sub->($opts, @_);
+					no strict "refs"; # for custome committags
+					$sub->($committag, @_);
 				});
 
 		} # end foreach (@message_fragments)
@@ -1705,6 +1733,25 @@ sub hyperlink_committag {
 	                esc_html($match[0], -nbsp=>1));
 }
 
+# Returns a ref to an HTML snippet formed from the 'replacement'
+# option and match data.  The match data is HTML-escaped, and the
+# 'replacement' option is used as a sprintf format.  This is a helper
+# function used in %committags.
+sub markup_committag {
+	my ($opts, @match) = @_;
+	return \sprintf($opts->{'replacement'},
+	                map { esc_html($_, -nbsp=>1) if defined } @match);
+}
+
+# Returns a text snippet formed from the 'replacement' option and
+# match data.  The 'replacement' option is used as a sprintf format.
+# Because the result is text, it can be re-processed by subsequent
+# committags.  This is a helper function used in %committags.
+sub transform_committag {
+	my ($opts, @match) = @_;
+	return sprintf($opts->{'replacement'}, @match);
+}
+
 # Find $pattern in string $fragment, and push_or_append the parts
 # between matches and the result of calling $sub with matched text to
 # $new_fragments.
@@ -1717,7 +1764,7 @@ MATCH:
 	while ($fragment =~ m/$pattern/gc) {
 		my ($prepos, $postpos) = ($-[0], $+[0]);
 
-		my @repl = $sub->($&, $1);
+		my @repl = $sub->($&, $1, $2);
 
 		my $pre = substr($fragment, $oldpos, $prepos - $oldpos);
 		push_or_append($new_fragments, $pre);
diff --git a/t/t9502-gitweb-committags.sh b/t/t9502-gitweb-committags.sh
index 0753630..cbe607b 100755
--- a/t/t9502-gitweb-committags.sh
+++ b/t/t9502-gitweb-committags.sh
@@ -226,5 +226,55 @@ test_expect_success 'msgid link: linked when enabled' '
 test_debug 'cat gitweb.log'
 test_debug 'grep -F "y.z" gitweb.output'
 
+# ----------------------------------------------------------------------
+# custom committags
+#
+echo custom_test > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+Something for <foo&bar@bar.com>
+END
+echo '$feature{"allowed_committag_subs"}{"default"} = [
+	"hyperlink_committag",
+	"markup_committag",
+	"transform_committag",
+	];' >> gitweb_config.perl
+git config gitweb.committags 'sha1, obfuscate'
+git config gitweb.committag.obfuscate.pattern '([a-z&]+@)[a-z]+(.com)'
+git config gitweb.committag.obfuscate.sub 'transform_committag'
+git config gitweb.committag.obfuscate.replacement '%2$sXXX%3$s'
+test_expect_success 'custom committags: transform_committag' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -q -F \
+		"foo&amp;bar@XXX.com" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep -F "foo" gitweb.output'
+
+git config gitweb.committags 'sha1, linkemail'
+git config gitweb.committag.linkemail.pattern '<([a-z&]+@[a-z]+.com)>'
+git config gitweb.committag.linkemail.sub 'markup_committag'
+git config gitweb.committag.linkemail.replacement '<a href="mailto:%2$s">%1$s</a>'
+test_expect_success 'custom committags: markup_committag' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -q -F \
+		"<a href=\"mailto:foo&amp;bar@bar.com\">&lt;foo&amp;bar@bar.com&gt;</a>" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep -F "foo" gitweb.output'
+
+echo '$feature{"allowed_committag_subs"}{"default"} = [
+	];' >> gitweb_config.perl
+test_expect_success 'custom committags: ignored when disabled' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -q -F \
+		"Something&nbsp;for&nbsp;&lt;foo&amp;bar@bar.com&gt;" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep -F "foo" gitweb.output'
+
 
 test_done
-- 
1.6.4.4
