From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] Fix race condition in t9119-git-svn-info.sh
Date: Mon, 31 Dec 2007 12:07:45 -0800
Message-ID: <1199131665-1633-1-git-send-email-ddkilzer@kilzer.net>
References: <377939.62541.qm@web52402.mail.re2.yahoo.com>
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 21:18:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9R5c-0006qY-B5
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 21:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXLaUR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 15:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbXLaUR5
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 15:17:57 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:50340 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbXLaUR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 15:17:56 -0500
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2007 15:17:55 EST
Received: from relay12.apple.com (relay12.apple.com [17.128.113.53])
	by mail-out4.apple.com (Postfix) with ESMTP id 3EADA1D82E24;
	Mon, 31 Dec 2007 12:07:47 -0800 (PST)
Received: from relay12.apple.com (unknown [127.0.0.1])
	by relay12.apple.com (Symantec Mail Security) with ESMTP id 25E2128095;
	Mon, 31 Dec 2007 12:07:47 -0800 (PST)
X-AuditID: 11807135-a70e8bb000002b6d-07-47794c124734
Received: from localhost.localdomain (unknown [17.151.86.187])
	by relay12.apple.com (Apple SCV relay) with ESMTP id C6AA428094;
	Mon, 31 Dec 2007 12:07:46 -0800 (PST)
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <377939.62541.qm@web52402.mail.re2.yahoo.com>
In-Reply-To: <377939.62541.qm@web52402.mail.re2.yahoo.com>
References: <377939.62541.qm@web52402.mail.re2.yahoo.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69417>

Changed the ptouch bash function to use the "Text Last Updated"
date reported by 'svn info' when changing the modified time
(mtime) of the file/symlink/directory in the git working
directory.  Previously it used the mtime of the item in the
svn working directory, which caused the race condition.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---

Ran a "burn-in" test by applying the "make test" patch in
<http://marc.info/?l=git&m=119452148511531&w=2> for over an hour
with no test failures:

$ set -e
$ while /usr/bin/true; do (make t/t9119-git-svn-info.sh); done

Also ran "make -C t full-svn-test" to verify the fix.

 t/t9119-git-svn-info.sh |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index cc61911..6d9bec9 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -5,17 +5,22 @@
 test_description='git-svn info'
 
 . ./lib-git-svn.sh
-say 'skipping svn-info test (has a race undiagnosed yet)'
-test_done
 
 ptouch() {
 	perl -w -e '
 		use strict;
+		use POSIX qw(mktime);
 		die "ptouch requires exactly 2 arguments" if @ARGV != 2;
-		die "$ARGV[0] does not exist" if ! -e $ARGV[0];
-		my @s = stat $ARGV[0];
-		utime $s[8], $s[9], $ARGV[1];
-	' "$1" "$2"
+		my $text_last_updated = shift @ARGV;
+		my $git_file = shift @ARGV;
+		die "\"$git_file\" does not exist" if ! -e $git_file;
+		if ($text_last_updated
+		    =~ /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/) {
+			my $mtime = mktime($6, $5, $4, $3, $2 - 1, $1 - 1900);
+			my $atime = $mtime;
+			utime $atime, $mtime, $git_file;
+		}
+	' "`svn info $1 | grep '^Text Last Updated:'`" "$2"
 }
 
 test_expect_success 'setup repository and import' "
@@ -111,7 +116,7 @@ test_expect_success 'info added-file' "
 		git add added-file &&
 	cd .. &&
 	cp gitwc/added-file svnwc/added-file &&
-	ptouch gitwc/added-file svnwc/added-file &&
+	ptouch svnwc/added-file gitwc/added-file &&
 	cd svnwc &&
 		svn add added-file > /dev/null &&
 	cd .. &&
@@ -127,7 +132,7 @@ test_expect_success 'info --url added-file' '
 
 test_expect_success 'info added-directory' "
 	mkdir gitwc/added-directory svnwc/added-directory &&
-	ptouch gitwc/added-directory svnwc/added-directory &&
+	ptouch svnwc/added-directory gitwc/added-directory &&
 	touch gitwc/added-directory/.placeholder &&
 	cd svnwc &&
 		svn add added-directory > /dev/null &&
@@ -156,7 +161,7 @@ test_expect_success 'info added-symlink-file' "
 		ln -s added-file added-symlink-file &&
 		svn add added-symlink-file > /dev/null &&
 	cd .. &&
-	ptouch gitwc/added-symlink-file svnwc/added-symlink-file &&
+	ptouch svnwc/added-symlink-file gitwc/added-symlink-file &&
 	(cd svnwc; svn info added-symlink-file) \
 		> expected.info-added-symlink-file &&
 	(cd gitwc; git-svn info added-symlink-file) \
@@ -179,7 +184,7 @@ test_expect_success 'info added-symlink-directory' "
 		ln -s added-directory added-symlink-directory &&
 		svn add added-symlink-directory > /dev/null &&
 	cd .. &&
-	ptouch gitwc/added-symlink-directory svnwc/added-symlink-directory &&
+	ptouch svnwc/added-symlink-directory gitwc/added-symlink-directory &&
 	(cd svnwc; svn info added-symlink-directory) \
 		> expected.info-added-symlink-directory &&
 	(cd gitwc; git-svn info added-symlink-directory) \
@@ -290,7 +295,7 @@ test_expect_success 'info --url symlink-directory (deleted)' '
 test_expect_success 'info unknown-file' "
 	echo two > gitwc/unknown-file &&
 	cp gitwc/unknown-file svnwc/unknown-file &&
-	ptouch gitwc/unknown-file svnwc/unknown-file &&
+	ptouch svnwc/unknown-file gitwc/unknown-file &&
 	(cd svnwc; svn info unknown-file) 2> expected.info-unknown-file &&
 	(cd gitwc; git-svn info unknown-file) 2> actual.info-unknown-file &&
 	git-diff expected.info-unknown-file actual.info-unknown-file
@@ -304,7 +309,7 @@ test_expect_success 'info --url unknown-file' '
 
 test_expect_success 'info unknown-directory' "
 	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
-	ptouch gitwc/unknown-directory svnwc/unknown-directory &&
+	ptouch svnwc/unknown-directory gitwc/unknown-directory &&
 	touch gitwc/unknown-directory/.placeholder &&
 	(cd svnwc; svn info unknown-directory) \
 		2> expected.info-unknown-directory &&
@@ -327,7 +332,7 @@ test_expect_success 'info unknown-symlink-file' "
 	cd svnwc &&
 		ln -s unknown-file unknown-symlink-file &&
 	cd .. &&
-	ptouch gitwc/unknown-symlink-file svnwc/unknown-symlink-file &&
+	ptouch svnwc/unknown-symlink-file gitwc/unknown-symlink-file &&
 	(cd svnwc; svn info unknown-symlink-file) \
 		2> expected.info-unknown-symlink-file &&
 	(cd gitwc; git-svn info unknown-symlink-file) \
@@ -350,8 +355,8 @@ test_expect_success 'info unknown-symlink-directory' "
 	cd svnwc &&
 		ln -s unknown-directory unknown-symlink-directory &&
 	cd .. &&
-	ptouch gitwc/unknown-symlink-directory \
-	       svnwc/unknown-symlink-directory &&
+	ptouch svnwc/unknown-symlink-directory \
+	       gitwc/unknown-symlink-directory &&
 	(cd svnwc; svn info unknown-symlink-directory) \
 		2> expected.info-unknown-symlink-directory &&
 	(cd gitwc; git-svn info unknown-symlink-directory) \
-- 
1.5.3.7
