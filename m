From: wking@tremily.us
Subject: [PATCH v6 3/3] gitweb: add If-Modified-Since handling to
 git_snapshot().
Date: Wed, 28 Mar 2012 11:47:01 -0400
Message-ID: <8129a671c793613ad2a0b00e1239e6a7ded7491a.1332949186.git.wking@drexel.edu>
References: <201203281613.52624.jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"W. Trevor King" <wking@drexel.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCv6d-0003qu-Ih
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213Ab2C1PsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 11:48:10 -0400
Received: from vms173001pub.verizon.net ([206.46.173.1]:10945 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab2C1PsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:48:09 -0400
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1L0092WQJLVE10@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 10:47:51 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id 9FE6143ADE8; Wed,
 28 Mar 2012 11:47:39 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 28 Mar 2012 11:47:55 -0400
X-Mailer: git-send-email 1.7.3.4
In-reply-to: <201203281613.52624.jnareb@gmail.com>
In-reply-to: <cover.1332949186.git.wking@drexel.edu>
References: <cover.1332949186.git.wking@drexel.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194137>

Because snapshots can be large, you can save some bandwidth by
supporting caching via If-Modified-Since.  This patch adds support for
the i-m-s request to git_snapshot() if the request is a commit.
Requests for snapshots of trees, which lack well defined timestamps,
are still handled as they were before.

Signed-off-by: W Trevor King <wking@drexel.edu>
---
 gitweb/gitweb.perl                       |   10 +++++++++
 t/t9501-gitweb-standalone-http-status.sh |   33 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ba106c1..591c793 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7051,6 +7051,10 @@ sub git_snapshot {
 
 	my ($name, $prefix) = snapshot_name($project, $hash);
 	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
+
+	my %co = parse_commit($hash);
+	exit_if_unmodified_since($co{'committer_epoch'}) if %co;
+
 	my $cmd = quote_command(
 		git_cmd(), 'archive',
 		"--format=$known_snapshot_formats{$format}{'format'}",
@@ -7060,9 +7064,15 @@ sub git_snapshot {
 	}
 
 	$filename =~ s/(["\\])/\\$1/g;
+	my %latest_date;
+	if (%co) {
+		%latest_date = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
+	}
+
 	print $cgi->header(
 		-type => $known_snapshot_formats{$format}{'type'},
 		-content_disposition => 'inline; filename="' . $filename . '"',
+		-last_modified => (%co ? $latest_date{'rfc2822'} : undef),
 		-status => '200 OK');
 
 	open my $fd, "-|", $cmd
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index afa6bd4..1487820 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -138,6 +138,39 @@ test_expect_success 'modification: feed if-modified-since (unmodified)' '
 '
 test_debug 'cat gitweb.headers'
 
+test_expect_success 'modification: snapshot last-modified' '
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output &&
+	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: snapshot if-modified-since (modified)' '
+	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
+	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: snapshot if-modified-since (unmodified)' '
+	export HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
+	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	grep "Status: 304 Not Modified" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: tree snapshot' '
+	ID=`git rev-parse --verify HEAD^{tree}` &&
+	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
+	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output &&
+	! grep "Last-Modified" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
 # ----------------------------------------------------------------------
 # load checking
 
-- 
1.7.3.4
