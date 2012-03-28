From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH v7 2/3] gitweb: refactor If-Modified-Since handling
Date: Wed, 28 Mar 2012 13:44:17 -0400
Message-ID: <d2b8995e12466f1518a50418c3e296d8d8983096.1332956550.git.wking@drexel.edu>
References: <20120328164513.GA4389@odin.tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 20:44:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxr8-0004W0-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530Ab2C1SoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:44:22 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:61003 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab2C1SoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:44:21 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Mar 2012 14:44:21 EDT
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1L00JJ9VXQPE40@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 12:44:15 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id 7337243B266; Wed,
 28 Mar 2012 13:44:13 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 28 Mar 2012 13:44:29 -0400
X-Mailer: git-send-email 1.7.3.4
In-reply-to: <20120328164513.GA4389@odin.tremily.us>
In-reply-to: <cover.1332956550.git.wking@drexel.edu>
References: <cover.1332956550.git.wking@drexel.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194161>

The current gitweb only generates Last-Modified and handles
If-Modified-Since headers for the git_feed action.  This patch breaks
the Last-Modified and If-Modified-Since handling code out from
git_feed into a new function exit_if_unmodified_since.  This makes the
code easy to reuse for other actions.

Only gitweb actions which can easily calculate a modification time
should use exit_if_unmodified_since, as the goal is to balance local
processing time vs. upload bandwidth.

Signed-off-by: W Trevor King <wking@drexel.edu>
---
 gitweb/gitweb.perl                       |   57 +++++++++++++++--------------
 t/t9501-gitweb-standalone-http-status.sh |   27 +++++++++++++-
 2 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 041da17..6d3f9c0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7003,6 +7003,28 @@ sub snapshot_name {
 	return wantarray ? ($name, $name) : $name;
 }
 
+sub exit_if_unmodified_since {
+	my ($latest_epoch) = @_;
+	our $cgi;
+
+	my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
+	if (defined $if_modified) {
+		my $since;
+		if (eval { require HTTP::Date; 1; }) {
+			$since = HTTP::Date::str2time($if_modified);
+		} elsif (eval { require Time::ParseDate; 1; }) {
+			$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
+		}
+		if (defined $since && $latest_epoch <= $since) {
+			my %latest_date = parse_date($latest_epoch);
+			print $cgi->header(
+				-last_modified => $latest_date{'rfc2822'},
+				-status => '304 Not Modified');
+			goto DONE_GITWEB;
+		}
+	}
+}
+
 sub git_snapshot {
 	my $format = $input_params{'snapshot_format'};
 	if (!@snapshot_fmts) {
@@ -7820,35 +7842,14 @@ sub git_feed {
 	if (defined($commitlist[0])) {
 		%latest_commit = %{$commitlist[0]};
 		my $latest_epoch = $latest_commit{'committer_epoch'};
-		%latest_date   = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
-		my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
-		if (defined $if_modified) {
-			my $since;
-			if (eval { require HTTP::Date; 1; }) {
-				$since = HTTP::Date::str2time($if_modified);
-			} elsif (eval { require Time::ParseDate; 1; }) {
-				$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
-			}
-			if (defined $since && $latest_epoch <= $since) {
-				print $cgi->header(
-					-type => $content_type,
-					-charset => 'utf-8',
-					-last_modified => $latest_date{'rfc2822'},
-					-status => '304 Not Modified');
-				return;
-			}
-		}
-		print $cgi->header(
-			-type => $content_type,
-			-charset => 'utf-8',
-			-last_modified => $latest_date{'rfc2822'},
-			-status => '200 OK');
-	} else {
-		print $cgi->header(
-			-type => $content_type,
-			-charset => 'utf-8',
-			-status => '200 OK');
+		exit_if_unmodified_since($latest_epoch);
+		%latest_date = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
 	}
+	print $cgi->header(
+		-type => $content_type,
+		-charset => 'utf-8',
+		%latest_date ? (-last_modified => $latest_date{'rfc2822'}) : (),
+		-status => '200 OK');
 
 	# Optimization: skip generating the body if client asks only
 	# for Last-Modified date.
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 31076ed..afa6bd4 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -92,7 +92,7 @@ test_debug 'cat gitweb.output'
 test_expect_success 'snapshots: bad tree-ish id (tagged object)' '
 	echo object > tag-object &&
 	git add tag-object &&
-	git commit -m "Object to be tagged" &&
+	test_tick && git commit -m "Object to be tagged" &&
 	git tag tagged-object `git hash-object tag-object` &&
 	gitweb_run "p=.git;a=snapshot;h=tagged-object;sf=tgz" &&
 	grep "400 - Object is not a tree-ish" gitweb.output
@@ -112,6 +112,31 @@ test_expect_success 'snapshots: bad object id' '
 '
 test_debug 'cat gitweb.output'
 
+# ----------------------------------------------------------------------
+# modification times (Last-Modified and If-Modified-Since)
+
+test_expect_success 'modification: feed last-modified' '
+	gitweb_run "p=.git;a=atom;h=master" &&
+	grep "Status: 200 OK" gitweb.output &&
+	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: feed if-modified-since (modified)' '
+	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
+	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
+	gitweb_run "p=.git;a=atom;h=master" &&
+	grep "Status: 200 OK" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: feed if-modified-since (unmodified)' '
+	export HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
+	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
+	gitweb_run "p=.git;a=atom;h=master" &&
+	grep "Status: 304 Not Modified" gitweb.output
+'
+test_debug 'cat gitweb.headers'
 
 # ----------------------------------------------------------------------
 # load checking
-- 
1.7.3.4
