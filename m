From: Jim Klimov <jim@jimklimov.com>
Subject: [PATCH 5/6] gitweb.perl changed (and tested) to return HTTP-404 when
 missing objects are requested via snapshot
Date: Fri, 11 Mar 2016 14:24:48 +0100
Message-ID: <1457702689-9084-5-git-send-email-jim@jimklimov.com>
References: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
Content-Transfer-Encoding: 7BIT
Cc: Jim Klimov <jim@jimklimov.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 14:30:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeN9J-0000qY-7k
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 14:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbcCKNaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 08:30:30 -0500
Received: from relay-mta.cos.ru ([93.175.31.8]:43370 "EHLO relay-mta.cos.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbcCKNa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 08:30:28 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Mar 2016 08:30:25 EST
Received: from sunmail.cos.ru (mail.cos.ru [81.5.113.73])
	by relay-mta.cos.ru (8.14.3+Sun/8.14.3) with ESMTP id u2BDOxJr025365
	for <git@vger.kernel.org>; Fri, 11 Mar 2016 16:25:08 +0300 (MSK)
Received: from debian8.roz.lab.etn.com. ([31.7.243.238])
 by sunmail.cos.ru (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26
 2008; 64bit)) with ESMTPA id <0O3V0013IMPRKC00@sunmail.cos.ru> for
 git@vger.kernel.org; Fri, 11 Mar 2016 16:27:35 +0300 (MSK)
X-Mailer: git-send-email 2.8.0.rc1.4.ge2bf47e.dirty
In-reply-to: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
X-Greylist-Inspected: inspected by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:08 +0300 (MSK) for IP:'81.5.113.73' DOMAIN:'mail.cos.ru' HELO:'sunmail.cos.ru' FROM:'jim@jimklimov.com'
X-Greylist: Sender IP whitelisted, ACL 386 matched, not delayed by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:08 +0300 (MSK)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288680>

---
 gitweb/gitweb.perl                        | 62 +++++++++++++++++++++++++------
 t/t9502-gitweb-standalone-parse-output.sh | 24 ++++++------
 2 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fc5b62d..2369ae3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7418,20 +7418,60 @@ sub git_snapshot {
 		%latest_date = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 	}
 
-	print $cgi->header(
-		-type => $known_snapshot_formats{$format}{'type'},
-		-content_disposition => 'inline; filename="' . $filename . '"',
-		%co ? (-last_modified => $latest_date{'rfc2822'}) : (),
-		-status => '200 OK');
-
 	printf STDERR "Starting git-archive: $cmd\n" if $DEBUG;
-	open my $fd, "-|", $cmd
-		or die_error(500, "Execute git-archive failed");
+	my $fd;
+	if ( ! open $fd, "-|", $cmd ) {
+		print $cgi->header(-status => '500 Execute git-archive failed');
+		die_error(500, "Execute git-archive failed");
+		return;
+	}
 	printf STDERR "Started git-archive...\n" if $DEBUG;
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	my $tempByte;
+	my $readSize = read ($fd, $tempByte, 1);
+	my $retCode = 200;
+	if ( defined $readSize ) {
+		if ( $readSize > 0 ) {
+			print $cgi->header(
+				-type => $known_snapshot_formats{$format}{'type'},
+				-content_disposition => 'inline; filename="' . $filename . '"',
+				%co ? (-last_modified => $latest_date{'rfc2822'}) : (),
+				-status => '200 OK' );
+			binmode STDOUT, ':raw';
+			print $tempByte;
+			if ( ! print <$fd> ) {
+				$retCode = 503;
+			}
+			binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+		} else {
+			$retCode = 404;
+		}
+	} else {
+		$readSize = -1;
+		$retCode = 500;
+	}
+
 	close $fd;
+	my $retError = "" ;
+	if ( ($? >> 8) != 0 ) {
+		$retCode = 500;
+		if ( $readSize == 0 ) {
+			# We had empty but not failed read - re-inspect stderr
+			$retError = `$cmd 2>&1`;
+			if ( $retError =~ /did not match any/ ) {
+				$retCode = 404;
+			}
+		}
+	}
+	if ( $retError ne "" ) {
+		$retError = "<br/><pre>$retError</pre><br/>";
+	}
+
+	if ( $retCode == 404 ) {
+		die_error(404, "Not Found - maybe requested objects absent in git path?" . "$retError");
+	} elsif ( $retCode == 500 ) {
+		die_error(500, "Failed to transmit output from git-archive" . "$retError");
+	}
+
 	printf STDERR "Finished posting output of git-archive...\n" if $DEBUG;
 }
 
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 11a116f..a2ae5c4 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -156,21 +156,21 @@ test_expect_success 'snapshot certain objects: have expected content in master b
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
-test_expect_success 'snapshot certain objects: have expected content in master branch - subdir name is required in requested nested path (bad path - empty output)' '
+test_expect_success 'snapshot certain objects: have expected content in master branch - subdir name is required in requested nested path (bad path - empty output and/or HTTP-404)' '
 	rm -f gitweb.body file_list &&
 	BRANCH=master &&
 	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=third" &&
-	[ ! -s gitweb.body ]
+	[ ! -s gitweb.body -o -n "`head -1 gitweb.headers | egrep "^Status: 404 "`" ]
 '
-test_debug 'cat gitweb.headers && cat file_list'
+test_debug 'cat gitweb.headers && ls -la gitweb.body file_list || true'
 
-test_expect_success 'snapshot certain objects: have expected content in master branch - correct subdir name is required in requested nested path (bad path - empty output)' '
+test_expect_success 'snapshot certain objects: have expected content in master branch - correct subdir name is required in requested nested path (bad path - empty output and/or HTTP-404)' '
 	rm -f gitweb.body file_list &&
 	BRANCH=master &&
 	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir1/third" &&
-	[ ! -s gitweb.body ]
+	[ ! -s gitweb.body -o -n "`head -1 gitweb.headers | egrep "^Status: 404 "`" ]
 '
-test_debug 'cat gitweb.headers && cat file_list'
+test_debug 'cat gitweb.headers && ls -la gitweb.body file_list || true'
 
 test_expect_success 'snapshot certain objects: have expected content in master branch - can request filenames with spaces (backslash + HTML-escape)' '
 	rm -f gitweb.body file_list &&
@@ -223,21 +223,21 @@ test_expect_success 'snapshot certain objects: have only expected content in ref
 '
 test_debug 'cat gitweb.headers && cat file_list'
 
-test_expect_success 'snapshot certain objects: have expected content in xx/test branch - request for only absent subdir dir2/ fails (empty output)' '
+test_expect_success 'snapshot certain objects: have expected content in xx/test branch - request for only absent subdir dir2/ fails (empty output and/or HTTP-404)' '
 	rm -f gitweb.body file_list &&
 	BRANCH=xx/test &&
 	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir2" &&
-        [ ! -s "gitweb.body" ]
+	[ ! -s gitweb.body -o -n "`head -1 gitweb.headers | egrep "^Status: 404 "`" ]
 '
-test_debug 'cat gitweb.headers'
+test_debug 'cat gitweb.headers && ls -la gitweb.body file_list || true'
 
-test_expect_success 'snapshot certain objects: have expected content in xx/test branch - request for file /foo and absent subdir dir2/ also fails (empty output)' '
+test_expect_success 'snapshot certain objects: have expected content in xx/test branch - request for file /foo and absent subdir dir2/ also fails (empty output and/or HTTP-404)' '
 	rm -f gitweb.body file_list &&
 	BRANCH=xx/test &&
 	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir2%20foo" &&
-        [ ! -s "gitweb.body" ]
+	[ ! -s gitweb.body -o -n "`head -1 gitweb.headers | egrep "^Status: 404 "`" ]
 '
-test_debug 'cat gitweb.headers'
+test_debug 'cat gitweb.headers && ls -la gitweb.body file_list || true'
 
 test_expect_success 'snapshot certain objects: have expected content in xx/test branch - have /foo file (and only it)' '
 	rm -f gitweb.body file_list &&
-- 
2.1.4
