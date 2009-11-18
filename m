From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 1/6] gitweb: Hyperlink committags in a commit message by regex matching
Date: Tue, 17 Nov 2009 22:22:25 -0800
Message-ID: <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
References: <200906221318.19598.jnareb@gmail.com>
 <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 07:29:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAe2t-000378-1f
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbZKRG3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbZKRG3S
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:29:18 -0500
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:45160 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753903AbZKRG3O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 01:29:14 -0500
Received: (qmail 7156 invoked from network); 18 Nov 2009 06:22:41 -0000
Received: from adsl-76-246-148-73.dsl.pltn13.sbcglobal.net (marcel@76.246.148.73 with plain)
        by smtp128.sbc.mail.sp1.yahoo.com with SMTP; 17 Nov 2009 22:22:40 -0800 PST
X-Yahoo-SMTP: WxgK_ZmswBCwjfqSjWfXdnSm2tyuJVtcxuu8Nw--
X-YMail-OSG: FhvVWbgVM1kt65gNb9ejYfmKwbjxjSHYnI_awPAoFd5up_spy23Ytd4vW2cAuf77hnVhYLcoMvurPwG.LpQ_yjepn_YPIvCREjP9CU1kJVIBtwbxb_PHKmHgdHqrX0zXugBWjDrkS6RhA4GfM4wtkIVr3nehwBFHb5uK1NjDzk4qhx8dqrxmevkR0y.WlFi_5_3qXCTgHYMXElM43TzzUlPyHPD_No2nBjbQeBd3gYp20gsKHkd9KNsij51onE0Lm42sMd3M9Z7hQNvzd_GbVIyGFslWjRDsU9G5L6Tqua6pQNjW
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1NAdvz-0004p6-3y; Tue, 17 Nov 2009 22:22:31 -0800
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133144>

I want gitweb to hyperlink commits to my bug tracking system so that
information regarding the current status of a commit can be easily
cross-referenced.  The QA and release status of a commit cannot be
directly inserted into the commit message because they change over
time.  But if the commit message mentions a bug number, gitweb could
detect the bug reference in the message and hyperlink it to the bug
tracking system.  Other repository browsers such as unfuddle and
websvn support similar features.

Currently only commit hashes are hyperlinked in this manner.

Since the bug hyperlinking feature was previously discussed as part of
"committags," a more general mechanism to embellish commit messages,
implement the more general mechanism instead, including the following
capabilities:

* Hyperlinking mentions of bug IDs to Bugzilla
* Hyperlinking URLs
* Hyperlinking Message-Ids to a mailing list archive
* Hyperlinking commit hashes, as before by default, now with a
  configurable regex
* Defining new committags per gitweb installation

Since different repositories may use different bug tracking systems or
mailing list archives, the URL parameter may be configured
per-repository without reiterating the regexes.  To accomodate
different conventions, regexes may also be configured per-project.

The order in which gitweb applies committags may be configured
per-project as well, because one committag may affect subsequent ones.
Inclusion in this sequence determines whether a committag is enabled
or not.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---

One additional thing that occured to me is that maybe the hyperlinks
added by committags should have 'rel="nofollow"' by default?  And if
so, maybe that needs to be configurable?  On the other hand, I'm not
sure how useful it is to hide real URLs in the commit messages from
search engines... ?


 gitweb/INSTALL               |    5 +
 gitweb/gitweb.perl           |  247 +++++++++++++++++++++++++++++++++++++++---
 t/t9502-gitweb-committags.sh |  150 +++++++++++++++++++++++++
 3 files changed, 389 insertions(+), 13 deletions(-)
 create mode 100755 t/t9502-gitweb-committags.sh

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index b76a0cf..9081ed8 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -132,6 +132,11 @@ adding the following lines to your $GITWEB_CONFIG:
 	$known_snapshot_formats{'zip'}{'disabled'} = 1;
 	$known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
 
+To add a committag to the default list of commit tags, for example to
+enable hyperlinking of bug numbers to a bug tracker for all projects:
+
+	push @{$feature{'committags'}{'default'}}, 'bugzilla';
+
 
 Gitweb repositories
 -------------------
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e4cbfc3..2d72202 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -213,6 +213,97 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# In general, the site admin can enable/disable per-project
+# configuration of each committag.  Only the 'options' part of the
+# committag is configurable per-project.
+#
+# The site admin can of course add new tags to this hash or override
+# the 'sub' key if necessary.  But such changes may be fragile; this
+# is not designed as a full-blown plugin architecture.  The 'sub' must
+# return a list of strings or string refs.  The strings must contain
+# plain text and the string refs must contain HTML.  The string refs
+# will not be processed further.
+#
+# For any committag, set the 'override' key to 1 to allow individual
+# projects to override entries in the 'options' hash for that tag.
+# For example, to match only commit hashes given in lowercase in one
+# project, add this to the $GITWEB_CONFIG:
+#
+#     $committags{'sha1'}{'override'} = 1;
+#
+# And in the project's config:
+#
+#     gitweb.committags.sha1.pattern = \\b([0-9a-f]{8,40})\\b
+#
+# Some committags have additional options whose interpretation depends
+# on the implementation of the 'sub' key.  The hyperlink_committag
+# value appends the first captured group to the 'url' option.
+our %committags = (
+	# Link Git-style hashes to this gitweb
+	'sha1' => {
+		'options' => {
+			'pattern' => qr/\b([0-9a-fA-F]{8,40})\b/,
+		},
+		'override' => 0,
+		'sub' => sub {
+			my ($opts, @match) = @_;
+			return \$cgi->a({-href => href(action=>"object", hash=>$match[1]),
+			                 -class => "text"},
+			                esc_html($match[0], -nbsp=>1));
+		},
+	},
+	# Link bug/features to Mantis bug tracker using Mantis-style
+	# contextual cues
+	'mantis' => {
+		'options' => {
+			'pattern' => qr/(?:BUG|FEATURE)\((\d+)\)/,
+			'url' => 'http://www.example.com/mantisbt/view.php?id=',
+		},
+		'override' => 0,
+		'sub' => \&hyperlink_committag,
+	},
+	# Link mentions of bug IDs to bugzilla
+	'bugzilla' => {
+		'options' => {
+			'pattern' => qr/bug\s+(\d+)/,
+			'url' => 'http://bugzilla.example.com/show_bug.cgi?id=',
+		},
+		'override' => 0,
+		'sub' => \&hyperlink_committag,
+	},
+	# Link URLs
+	'url' => {
+		'options' => {
+			# Avoid matching punctuation that might immediately follow
+			# a url, is not part of the url, and is allowed in urls,
+			# like a full-stop ('.').
+			'pattern' => qr!(https?|ftps?|git|ssh|ssh+git|sftp|smb|webdavs?|
+			                 nfs|irc|nntp|rsync)
+			                ://[-_a-zA-Z0-9\@/&=+~#<>;%:.?]+
+			                   [-_a-zA-Z0-9\@/&=+~#<>]!x,
+		},
+		'override' => 0,
+		'sub' => sub {
+			my ($opts, @match) = @_;
+			return \$cgi->a({-href => $match[0],
+			                 -class => "text"},
+			                esc_html($match[0], -nbsp=>1));
+		},
+	},
+	# Link Message-Id to mailing list archive
+	'messageid' => {
+		'options' => {
+			'pattern' => qr!(?:message|msg)-?id:?\s+(<[^>]+>)!i,
+			'url' => 'http://mid.gmane.org/',
+		},
+		'override' => 0,
+		# Includes the "msg-id" text in the link text.
+		# Since we don't support linking multiple msg-ids in one match, we
+		# can include the "msg-id" in the link text for better context.
+		'sub' => \&hyperlink_committag,
+	},
+);
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -258,7 +349,7 @@ our %feature = (
 	# and in project config, a comma-separated list of formats or "none"
 	# to disable.  Example: gitweb.snapshot = tbz2,zip;
 	'snapshot' => {
-		'sub' => \&feature_snapshot,
+		'sub' => sub { feature_list('snapshot', @_) },
 		'override' => 0,
 		'default' => ['tgz']},
 
@@ -417,6 +508,21 @@ our %feature = (
 		'sub' => \&feature_avatar,
 		'override' => 0,
 		'default' => ['']},
+
+	# The selection and ordering of committags that are enabled.
+	# Committag transformations will be applied to commit log messages
+	# in the order listed here if listed here.
+
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'committags'}{'default'} = [];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'committags'}{'override'} = 1;
+	# and in project config gitweb.committags = sha1, url, bugzilla
+	# to enable those three committags for that project
+	'committags' => {
+		'sub' => sub { feature_list('committags', @_) },
+		'override' => 0,
+		'default' => ['sha1']},
 );
 
 sub gitweb_get_feature {
@@ -463,16 +569,16 @@ sub feature_bool {
 	}
 }
 
-sub feature_snapshot {
-	my (@fmts) = @_;
+sub feature_list {
+	my ($key, @defaults) = @_;
 
-	my ($val) = git_get_project_config('snapshot');
+	my ($cfg) = git_get_project_config($key);
 
-	if ($val) {
-		@fmts = ($val eq 'none' ? () : split /\s*[,\s]\s*/, $val);
+	if ($cfg) {
+		return ($cfg eq 'none' ? () : split(/\s*[,\s]\s*/, $cfg));
 	}
 
-	return @fmts;
+	return @defaults;
 }
 
 sub feature_patches {
@@ -886,6 +992,35 @@ if ($git_avatar eq 'gravatar') {
 	$git_avatar = '';
 }
 
+# ordering of committags
+our @committags = gitweb_get_feature('committags');
+
+# whether we've loaded committags for the project yet
+our $loaded_project_committags = 0;
+
+# Load committag configs from the repository config file and and
+# incorporate them into the gitweb defaults where permitted by the
+# site administrator.
+sub gitweb_load_project_committags {
+	return if (!$git_dir || $loaded_project_committags);
+	my %project_config = ();
+	my %raw_config = git_parse_project_config('gitweb\.committag');
+	foreach my $key (keys(%raw_config)) {
+		next if ($key !~ /gitweb\.committag\.[^.]+\.[^.]/);
+		my ($gitweb_prefix, $committag_prefix, $ctname, $option) =
+			split(/\./, $key, 4);
+		$project_config{$ctname}{$option} = $raw_config{$key};
+	}
+	foreach my $ctname (keys(%committags)) {
+		next if (!$committags{$ctname}{'override'});
+		foreach my $optname (keys %{$project_config{$ctname}}) {
+			$committags{$ctname}{'options'}{$optname} =
+				$project_config{$ctname}{$optname};
+		}
+	}
+	$loaded_project_committags = 1;
+}
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -1458,13 +1593,99 @@ sub file_type_long {
 sub format_log_line_html {
 	my $line = shift;
 
-	$line = esc_html($line, -nbsp=>1);
-	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
-		$cgi->a({-href => href(action=>"object", hash=>$1),
-					-class => "text"}, $1);
-	}eg;
+	# Merge project configs with site default committag definitions if
+	# it hasn't been done yet
+	gitweb_load_project_committags();
 
-	return $line;
+	# In this list of log message fragments, a string ref indicates
+	# HTML, and a string indicates plain text.  The string refs are
+	# also currently not processed by subsequent committags.
+	my @message_fragments = ( $line );
+
+COMMITTAG:
+	foreach my $ctname (@committags) {
+		next COMMITTAG unless exists $committags{$ctname};
+		my $committag = $committags{$ctname};
+
+		next COMMITTAG unless exists $committag->{'sub'};
+		my $sub = $committag->{'sub'};
+
+		next COMMITTAG unless exists $committag->{'options'};
+		my $opts = $committag->{'options'};
+
+		next COMMITTAG unless exists $opts->{'pattern'};
+		my $pattern = $opts->{'pattern'};
+
+		my @new_message_fragments = ();
+
+	PART:
+		foreach my $fragment (@message_fragments) {
+			next PART if $fragment eq "";
+			if (ref($fragment)) {
+				push @new_message_fragments, $fragment;
+				next PART;
+			}
+
+			my $oldpos = 0;
+
+		MATCH:
+			while ($fragment =~ m/$pattern/gc) {
+				my ($prepos, $postpos) = ($-[0], $+[0]);
+				my $repl = $sub->($opts, $&, $1);
+				$repl = "" if (!defined $repl);
+
+				my $pre = substr($fragment, $oldpos, $prepos - $oldpos);
+				push_or_append(\@new_message_fragments, $pre);
+				push_or_append(\@new_message_fragments, $repl);
+
+				$oldpos = $postpos;
+			} # end while [regexp matches]
+
+			my $rest = substr($fragment, $oldpos);
+			push_or_append(\@new_message_fragments, $rest);
+
+		} # end foreach (@message_fragments)
+
+		@message_fragments = @new_message_fragments;
+	} # end foreach (@committags)
+
+	# Escape any remaining plain text and concatenate
+	my $html = '';
+	for my $fragment (@message_fragments) {
+		if (ref($fragment)) {
+			$html .= $$fragment;
+		} else {
+			$html .= esc_html($fragment, -nbsp=>1);
+		}
+	}
+
+	return $html;
+}
+
+# Returns a ref to an HTML snippet that links the whole match to a URL
+# formed from the 'url' option and the first captured subgroup.  This
+# is a helper function used in %committags.
+sub hyperlink_committag {
+	my ($opts, @match) = @_;
+	return \$cgi->a({-href => $opts->{'url'} . $cgi->escape($match[1]),
+	                 -class => "text"},
+	                esc_html($match[0], -nbsp=>1));
+}
+
+
+sub push_or_append (\@@) {
+	my $fragments = shift;
+
+	if (ref $_[0] || ! @$fragments || ref $fragments->[-1]) {
+		push @$fragments, @_;
+	} else {
+		my $a = pop @$fragments;
+		my $b = shift @_;
+
+		push @$fragments, $a . $b, @_;
+	}
+	# imitate push
+	return scalar @$fragments;
 }
 
 # format marker of refs pointing to given object
diff --git a/t/t9502-gitweb-committags.sh b/t/t9502-gitweb-committags.sh
new file mode 100755
index 0000000..f86cb3d
--- /dev/null
+++ b/t/t9502-gitweb-committags.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+
+test_description='gitweb committag tests.
+
+This test runs gitweb (git web interface) as CGI script from
+commandline, and checks that committags perform the expected
+transformations on log messages.'
+
+. ./gitweb-lib.sh
+
+# ----------------------------------------------------------------------
+# sha1 linking
+#
+echo sha1_test > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+Summary
+
+See also commit 567890ab
+END
+test_expect_success 'sha1 link: enabled by default' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -q \
+		"commit&nbsp;<a class=\"text\" href=\".*\">567890ab</a>" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 567890ab gitweb.output'
+
+# ----------------------------------------------------------------------
+# bugzilla commit tag
+#
+
+echo bugzilla_test > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+Fix foo
+
+Fixes bug 1234 involving foo.
+END
+git config gitweb.committags 'sha1, bugzilla'
+test_expect_success 'bugzilla: enabled but not permitted' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -F -q \
+		"Fixes&nbsp;bug&nbsp;1234&nbsp;involving" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 gitweb.output'
+
+echo '$feature{"committags"}{"override"} = 1;' >> gitweb_config.perl
+test_expect_success 'bugzilla: enabled' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -F -q \
+		"Fixes&nbsp;<a class=\"text\" href=\"http://bugzilla.example.com/show_bug.cgi?id=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 gitweb.output'
+
+git config gitweb.committag.bugzilla.url 'http://bts.example.com?bug='
+test_expect_success 'bugzilla: url overridden but not permitted' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -F -q \
+		"Fixes&nbsp;<a class=\"text\" href=\"http://bugzilla.example.com/show_bug.cgi?id=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 gitweb.output'
+
+echo '$committags{"bugzilla"}{"override"} = 1;' >> gitweb_config.perl
+test_expect_success 'bugzilla: url overridden' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -F -q \
+		"Fixes&nbsp;<a class=\"text\" href=\"http://bts.example.com?bug=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 gitweb.output'
+
+git config gitweb.committag.bugzilla.pattern 'Fixes bug (\d+)'
+test_expect_success 'bugzilla: pattern overridden' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -F -q \
+		"<a class=\"text\" href=\"http://bts.example.com?bug=1234\">Fixes&nbsp;bug&nbsp;1234</a>&nbsp;involving" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 gitweb.output'
+git config --unset gitweb.committag.bugzilla.pattern
+
+test_expect_success 'bugzilla: affects log view too' '
+	gitweb_run "p=.git;a=log" &&
+	grep -F -q \
+		"<a class=\"text\" href=\"http://bts.example.com?bug=1234\">bug&nbsp;1234</a>" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 gitweb.output'
+
+# ----------------------------------------------------------------------
+# url linking
+#
+echo url_test > file.txt
+git add file.txt
+url='http://user@pass:example.com/foo.html?u=v&x=y#z'
+url_esc="$(echo "$url" | sed 's/&/&amp;/g')"
+git commit -q -F - file.txt <<END
+Summary
+
+See also $url.
+END
+echo '$feature{"committags"}{"override"} = 1;' >> gitweb_config.perl
+git config gitweb.committags 'sha1, url'
+test_expect_success 'url link: links when enabled' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -q -F \
+		"See&nbsp;also&nbsp;<a class=\"text\" href=\"$url_esc\">$url_esc</a>." \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep -F "$url" gitweb.output'
+
+# ----------------------------------------------------------------------
+# message id linking
+#
+echo msgid_test > file.txt
+git add file.txt
+url='http://mid.gmane.org/'
+msgid='<x@y.z>'
+msgid_esc="$(echo "$msgid" | sed 's/</\&lt;/g; s/>/\&gt;/g')"
+msgid_url="$url$(echo "$msgid" | sed 's/</%3C/g; s/@/%40/g; s/>/%3E/g')"
+git commit -q -F - file.txt <<END
+Summary
+
+See msg-id $msgid.
+END
+echo '$feature{"committags"}{"override"} = 1;' >> gitweb_config.perl
+git config gitweb.committags 'sha1, messageid'
+test_expect_success 'msgid link: linked when enabled' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -q -F \
+		"See&nbsp;<a class=\"text\" href=\"$msgid_url\">msg-id&nbsp;$msgid_esc</a>." \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep -F "y.z" gitweb.output'
+
+
+test_done
-- 
1.6.4.4
