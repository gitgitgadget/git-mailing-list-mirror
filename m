From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 1/2] gitweb: Hyperlink various committags in commit message with regex
Date: Fri, 19 Jun 2009 07:13:50 -0700
Message-ID: <1245420831-5103-1-git-send-email-marcel@oak.homeunix.org>
References: <200902180438.55081.jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fg@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 16:21:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHexp-0007UR-9g
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 16:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbZFSOUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 10:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbZFSOUt
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 10:20:49 -0400
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:42731 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751357AbZFSOUs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 10:20:48 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2009 10:20:47 EDT
Received: (qmail 86391 invoked from network); 19 Jun 2009 14:14:09 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.100.199 with plain)
  by smtp117.sbc.mail.sp1.yahoo.com with SMTP; 19 Jun 2009 14:14:08 -0000
X-YMail-OSG: Ads2iJgVM1k0NAmZ5y3qF90inLmx8eLwBTaoQSLgr9QrmzI3PyiCGcNpvmVDB5brgiOu4dVNETGj6PAy3xvuMnEp4jcuyIr2yUCSZPuP7TZyWBZaQ8m0dh_7aky3LctanPgt_Whh5nVXeP4GuL3P5X70BMx5ZcmpPyn7iYvR2uS3bfvX4Cg3kjTRDcHxzsQkspZe1r3BlmOXG0sTjWhqCMWBG3tpBE2A0OURw9vMGYkOw6VrDaBTKaeD45wXCK5aLuuGZcnuQ9o-
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1MHeqm-0001rB-96; Fri, 19 Jun 2009 07:13:52 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <200902180438.55081.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121899>

I want gitweb to hyperlink commits to my bug tracking system so that
information regarding the current status of a commit can be easily
cross-referenced.  For example, the QA and release status of a commit
cannot be inserted into the comment.  Maybe someday a "git notes"
feature will help with this, but for now, my organization has a
separate bug tracking system.  Other repository browsers such as
unfuddle and websvn support similar features.

Since the bug hyperlinking feature was previously discussed as part of
"committags," a more general mechanism to embellish commit messages,
implement the more general mechanism instead, including the following
capabilities:

* Hyperlinking mentions of bug IDs to Bugzilla
* Hyperlinking URLs
* Hyperlinking Message-Ids to a mailing list archive
* Hyperlinking commit hashes as before by default, now with a
  configurable regex
* Defining new committags per gitweb installation

Since different repositories may use different bug tracking systems or
mailing list archives, the URL parameter may be configured
per-repository without reiterating the regexes.  To accomodate
different conventions, regexes may also be configured per-project.

This patch is heavily based on discussions and code samples from the
Git list:

	[RFC/PATCH] gitweb: Add committags support, Sep 2006
	http://thread.gmane.org/gmane.comp.version-control.git/27504

	[RFC] gitweb: Add committags support (take 2), Dec 2006
	http://thread.gmane.org/gmane.comp.version-control.git/33150

	[RFC] Configuring (future) committags support in gitweb, Nov 2008
	http://thread.gmane.org/gmane.comp.version-control.git/100415

Some issues I considered but punted:

* Should this configuration try to follow the bugtraq spec?

  As far as I know, only subversion implements it.  Separation of
  regexes by a newline would be a little awkward in the git config.
  And it is broader than just hyperlinking bugs: it also encompasses
  GUI bug ID form fields.  So gitweb would only implement a subset.
  The gitweb configuration mechanism currently only reads
  keys starting with "gitweb.", but these parameters would be more
  broadly applicable, potentially to git-gui, for example.

  However, it *would* be useful for Git tools to standardize on
  config keys and interpretations of regexes and url formats.  For
  example, git-gui might be able to hyperlink the same text as gitweb,
  and even show a separate bugID field when composing a commit
  message.

* I would prefer the regex match against the whole commit message.

  This would allow the regex to insist that a bug reference occur
  on the first line or non-first line of the commit message.  However,
  even if we concatenated the log lines for the first committag,
  subsequent committags would see the text broken up.

  Also, it would allow the regex to match a phrase split across a
  line boundary, as dicussed at some length in the first thread,
  but again, only if no prior committags had interfered.

  This could happen in a later patch.

* I would prefer the site admin have a way to let a repository
  owner define new committags, which means having a way to specify
  the 'sub' key from the repo config or having a flexible default.

The bugtraq and some of the regex questions must be decided now to
avoid breaking gitweb configs later.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---
 gitweb/INSTALL                         |    4 +
 gitweb/gitweb.perl                     |  221 +++++++++++++++++++++++++++++++-
 t/t9500-gitweb-standalone-no-errors.sh |  150 +++++++++++++++++++++-
 3 files changed, 367 insertions(+), 8 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 18c9ce3..223e39e 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -123,6 +123,10 @@ GITWEB_CONFIG file:
 	$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
 	$feature{'snapshot'}{'override'} = 1;
 
+	$feature{'committags'}{'default'} = ['sha1', 'url', 'bugzilla'];
+	$feature{'committags'}{'override'} = 1;
+
+
 
 Gitweb repositories
 -------------------
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1e7e2d8..c66fdf3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -195,6 +195,81 @@ our %known_snapshot_format_aliases = (
 	'x-zip' => undef, '' => undef,
 );
 
+# Could call these something else besides committags... embellishments,
+# patterns, rewrite rules, ?
+#
+# In general, the site admin can enable/disable per-project configuration
+# of each committag.  Only the 'options' part of the committag is configurable
+# per-project.
+#
+# The site admin can of course add new tags to this hash or override the
+# 'sub' key if necessary.  But such changes may be fragile; this is not
+# designed as a full-blown plugin architecture.
+our %committags = (
+	# Link Git-style hashes to this gitweb
+	'sha1' => {
+		'options' => {
+			'pattern' => qr/\b([0-9a-fA-F]{8,40})\b/,
+		},
+		'override' => 0,
+		'sub' => sub {
+			my ($opts, @match) = @_;
+			\$cgi->a({-href => href(action=>"object", hash=>$match[1]),
+			          -class => "text"}, esc_html($match[0], -nbsp=>1));
+		},
+	},
+	# Link bug/features to Mantis bug tracker using Mantis-style contextual cues
+	'mantis' => {
+		'options' => {
+			'pattern' => qr/(?:BUG|FEATURE)\((\d+)\)/,
+			'url' => 'http://bugs.xmms2.xmms.se/view.php?id=',
+		},
+		'override' => 0,
+		'sub' => \&hyperlink_committag,
+	},
+	# Link mentions of bug IDs to bugzilla
+	'bugzilla' => {
+		'options' => {
+			'pattern' => qr/bug\s+(\d+)/,
+			'url' => 'http://bugzilla.kernel.org/show_bug.cgi?id=',
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
+			'pattern' => qr!(http|ftp)s?://[-_a-zA-Z0-9\@/&=+~#<>;%:.?]+
+			                               [-_a-zA-Z0-9\@/&=+~#<>]!x,
+		},
+		'override' => 0,
+		'sub' => sub {
+			my ($opts, @match) = @_;
+			return
+				\$cgi->a({-href => $match[0],
+				          -class => "text"},
+				         esc_html($match[0], -nbsp=>1));
+		},
+	},
+	# Link Message-Id to mailing list archive
+	'messageid' => {
+		'options' => {
+			# The original pattern, which I don't really understand
+			#'pattern' => qr!(?:message|msg)-id:?\s+<([^>]+)>;!i,
+			'pattern' => qr!(?:message|msg)-?id:?\s+(<[^>]+>)!i,
+			'url' => 'http://news.gmane.org/find-root.php?message_id=',
+		},
+		'override' => 0,
+		# The original version didn't include the "msg-id" text in the
+		# link text, but this does.  In general, I think a little more
+		# context makes for better link text.
+		'sub' => \&hyperlink_committag,
+	},
+);
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -365,6 +440,21 @@ our %feature = (
 		'sub' => \&feature_patches,
 		'override' => 0,
 		'default' => [16]},
+
+	# The selection and ordering of committags that are enabled.
+	# Committag transformations will be applied to commit log messages
+	# in this order if listed here.
+
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'committags'}{'default'} = [];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'committags'}{'override'} = 1;
+	# and in project config gitweb.committags = sha1, url, bugzilla
+	# to enable those three committags for that project
+	'committags' => {
+		'sub' => \&feature_committags,
+		'override' => 0,
+		'default' => ['sha1']},
 );
 
 sub gitweb_get_feature {
@@ -433,6 +523,18 @@ sub feature_patches {
 	return ($_[0]);
 }
 
+sub feature_committags {
+	my (@defaults) = @_;
+
+	my ($cfg) = git_get_project_config('committags');
+
+	if ($cfg) {
+		return ($cfg eq 'none' ? () : split(/\s*[,\s]\s*/, $cfg));
+	}
+
+	return @defaults;
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -814,6 +916,34 @@ $git_dir = "$projectroot/$project" if $project;
 our @snapshot_fmts = gitweb_get_feature('snapshot');
 @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
+# ordering of committags
+our @committags = gitweb_get_feature('committags');
+
+# Merge project configs with default committag definitions
+gitweb_load_project_committags();
+
+# Load committag configs from the repository config file and and
+# incorporate them into the gitweb defaults where permitted by the
+# site administrator.
+sub gitweb_load_project_committags {
+	return if (!$git_dir);
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
+}
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -1384,13 +1514,92 @@ sub file_type_long {
 sub format_log_line_html {
 	my $line = shift;
 
-	$line = esc_html($line, -nbsp=>1);
-	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
-		$cgi->a({-href => href(action=>"object", hash=>$1),
-					-class => "text"}, $1);
-	}eg;
+	# In this list of log message fragments, a string ref indicates HTML,
+	# and a string indicates plain text
+	my @list = ( $line );
 
-	return $line;
+COMMITTAG:
+	foreach my $ctname (@committags) {
+		next COMMITTAG unless exists $committags{$ctname};
+		my $committag = $committags{$ctname};
+
+		next COMMITTAG unless exists $committag->{'options'};
+		my $opts = $committag->{'options'};
+
+		next COMMITTAG unless exists $opts->{'pattern'};
+		my $pattern = $opts->{'pattern'};
+
+		my @newlist = ();
+
+	PART:
+		foreach my $part (@list) {
+			next PART if $part eq "";
+			if (ref($part)) {
+				push @newlist, $part;
+				next PART;
+			}
+
+			my $oldpos = 0;
+
+		MATCH:
+			while ($part =~ m/$pattern/gc) {
+				my ($prepos, $postpos) = ($-[0], $+[0]);
+				my $repl = $committag->{'sub'}->($opts, $&, $1);
+				$repl = "" if (!defined $repl);
+
+				my $pre = substr($part, $oldpos, $prepos - $oldpos);
+				push_or_append(\@newlist, $pre);
+				push_or_append(\@newlist, $repl);
+
+				$oldpos = $postpos;
+			} # end while [regexp matches]
+
+			my $rest = substr($part, $oldpos);
+			push_or_append(\@newlist, $rest);
+
+		} # end foreach (@list)
+
+		@list = @newlist;
+	} # end foreach (@committags)
+
+	# Escape any remaining plain text and concatenate
+	my $html = '';
+	for my $part (@list) {
+		if (ref($part)) {
+			$html .= $$part;
+		} else {
+			$html .= esc_html($part, -nbsp=>1);
+		}
+	}
+
+	return $html;
+}
+
+# Returns a ref to an HTML snippet that links the second
+# parameter to a URL formed from the first and last parameters.
+# This is a helper function used in %committags.
+sub hyperlink_committag {
+	my ($opts, @match) = @_;
+	return
+		\$cgi->a({-href => $opts->{url} . CGI::escape($match[1]),
+				  -class => "text"},
+				 esc_html($match[0], -nbsp=>1));
+}
+
+
+sub push_or_append (\@@) {
+	my $list = shift;
+
+	if (ref $_[0] || ! @$list || ref $list->[-1]) {
+		push @$list, @_;
+	} else {
+		my $a = pop @$list;
+		my $b = shift @_;
+
+		push @$list, $a . $b, @_;
+	}
+	# imitate push
+	return scalar @$list;
 }
 
 # format marker of refs pointing to given object
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index d539619..37a127c 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -55,9 +55,9 @@ gitweb_run () {
 	# some of git commands write to STDERR on error, but this is not
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
-	rm -f gitweb.log &&
+	rm -f resp.http gitweb.log &&
 	perl -- "$SCRIPT_NAME" \
-		>/dev/null 2>gitweb.log &&
+		> resp.http 2>gitweb.log &&
 	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
 
 	# gitweb.log is left for debugging
@@ -702,4 +702,150 @@ test_expect_success \
 	 gitweb_run "p=.git;a=summary"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# sha1 linking
+#
+echo hi > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+Summary
+
+See also commit 567890ab
+END
+test_expect_success 'sha1 link: enabled by default' '
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -q \
+		"commit&nbsp;<a class=\"text\" href=\".*\">567890ab</a>" \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 567890ab resp.http'
+
+# ----------------------------------------------------------------------
+# bugzilla commit tag
+#
+
+echo foo > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+Fix foo
+
+Fixes bug 1234 involving foo.
+END
+git config gitweb.committags 'sha1, bugzilla'
+test_expect_success 'bugzilla: enabled but not permitted' '
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -F -q \
+		"Fixes&nbsp;bug&nbsp;1234&nbsp;involving" \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 resp.http'
+
+echo '$feature{"committags"}{"override"} = 1;' >> gitweb_config.perl
+test_expect_success 'bugzilla: enabled' '
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -F -q \
+		"Fixes&nbsp;<a class=\"text\" href=\"http://bugzilla.kernel.org/show_bug.cgi?id=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 resp.http'
+
+git config gitweb.committag.bugzilla.url 'http://bts.example.com?bug='
+test_expect_success 'bugzilla: url overridden but not permitted' '
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -F -q \
+		"Fixes&nbsp;<a class=\"text\" href=\"http://bugzilla.kernel.org/show_bug.cgi?id=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 resp.http'
+
+echo '$committags{"bugzilla"}{"override"} = 1;' >> gitweb_config.perl
+test_expect_success 'bugzilla: url overridden' '
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -F -q \
+		"Fixes&nbsp;<a class=\"text\" href=\"http://bts.example.com?bug=1234\">bug&nbsp;1234</a>&nbsp;involving" \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 resp.http'
+
+git config gitweb.committag.bugzilla.pattern 'Fixes bug (\d+)'
+test_expect_success 'bugzilla: pattern overridden' '
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -F -q \
+		"<a class=\"text\" href=\"http://bts.example.com?bug=1234\">Fixes&nbsp;bug&nbsp;1234</a>&nbsp;involving" \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 resp.http'
+git config --unset gitweb.committag.bugzilla.pattern
+
+test_expect_success 'bugzilla: affects log view too' '
+	gitweb_run "p=.git;a=log" &&
+	grep -F -q \
+		"<a class=\"text\" href=\"http://bts.example.com?bug=1234\">bug&nbsp;1234</a>" \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 resp.http'
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
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -q -F \
+		"See&nbsp;also&nbsp;<a class=\"text\" href=\"$url_esc\">$url_esc</a>." \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep -F "$url" resp.http'
+
+# ----------------------------------------------------------------------
+# message id linking
+#
+echo msgid_test > file.txt
+git add file.txt
+url='http://news.gmane.org/find-root.php?message_id='
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
+	h=$(git rev-parse --verify HEAD) &&
+	gitweb_run "p=.git;a=commit;h=$h" &&
+	grep -q -F \
+		"See&nbsp;<a class=\"text\" href=\"$msgid_url\">msg-id&nbsp;$msgid_esc</a>." \
+		resp.http
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep -F "y.z" resp.http'
+
 test_done
-- 
1.6.2
