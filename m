From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH v5 1/2] gitweb: check given hash before trying to create snapshot
Date: Sat, 26 Sep 2009 13:46:08 -0400
Message-ID: <4ABE5360.8090204@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 19:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrbLq-0007yY-FL
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 19:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbZIZRqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 13:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbZIZRqU
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 13:46:20 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:45537 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751588AbZIZRqU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 13:46:20 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8QHk9df026542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Sep 2009 13:46:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: e0693e21-3407-4a37-b33d-56553a8d727d
X-Miltered: at mailchk-m04 with ID 4ABE5361.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Sat, 26 Sep 2009 13:46:16 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129161>

Makes things nicer in cases when you hand craft the snapshot URL but
make a typo in defining the hash variable (e.g. netx instead of next);
you will now get an error message instead of a broken tarball.

Tests for t9501 are included to demonstrate added functionality.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---

	Changes since v4:
		- used Jakub's suggestion for checking hash validity
			- moved git_get_full_hash to the second commit
		- changed test cases format, suggested by Junio
		- added another test case for tagged objects due to the
		  bug Junio pointed out

	Sorry it's been a while since the v4, school started and I got
	buried under a whole lot of other things I had to take care of
	first. I've got time now, so further fix ups will happen in a
	more reasonable time frame (but hopefully aren't needed!).


 gitweb/gitweb.perl                       |    7 ++++-
 t/t9501-gitweb-standalone-http-status.sh |   39 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..8d4a2ae 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5196,8 +5196,11 @@ sub git_snapshot {
 		die_error(403, "Unsupported snapshot format");
 	}
 
-	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
+	my $type = git_get_type("$hash^{}");
+	if (!$type) {
+		die_error(404, 'Object does not exist');
+	}  elsif ($type eq 'blob') {
+		die_error(400, 'Object is not a tree-ish');
 	}
 
 	my $name = $project;
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index d0ff21d..0688a57 100644
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -75,4 +75,43 @@ test_expect_success \
 test_debug 'cat gitweb.output'
 
 
+# ----------------------------------------------------------------------
+# snapshot hash ids
+
+test_expect_success 'snapshots: good tree-ish id' '
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: bad tree-ish id' '
+	gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
+	grep "404 - Object does not exist" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: bad tree-ish id (tagged object)' '
+	echo object > tag-object &&
+	git add tag-object &&
+	git commit -m "Object to be tagged" &&
+	git tag tagged-object `git hash-object tag-object` &&
+	gitweb_run "p=.git;a=snapshot;h=tagged-object;sf=tgz" &&
+	grep "400 - Object is not a tree-ish" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: good object id' '
+	ID=`git rev-parse --verify HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: bad object id' '
+	gitweb_run "p=.git;a=snapshot;h=abcdef01234;sf=tgz" &&
+	grep "404 - Object does not exist" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+
 test_done
-- 
1.6.4.GIT
