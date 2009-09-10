From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH 2/2] gitweb: check given hash before trying to create
 snapshot
Date: Thu, 10 Sep 2009 17:20:47 -0400
Message-ID: <4AA96DAF.4070200@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 23:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlr4e-00022l-Hb
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 23:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbZIJVUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 17:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbZIJVUt
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 17:20:49 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:39524 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754457AbZIJVUt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 17:20:49 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8ALKl66001863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Sep 2009 17:20:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: b70d1fb6-5c1f-4b8f-8efe-241a1eb07800
X-Miltered: at mailchk-m04 with ID 4AA96DAF.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Thu, 10 Sep 2009 17:20:50 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128150>

This patch is dual purposed.

First, it makes things nicer in cases when you hand craft the snapshot
URL but make a typo (e.g. netx instead of next); you will now get an
error message instead of a broken tarball.

Second, any given treeish will always be translated to the full length,
unambiguous, hash id; this will be useful for things like creating
unique names for snapshot caches.

This patch includes test for t9501 to demonstrate the changed
functionality.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 gitweb/gitweb.perl                       |    5 +++--
 t/t9501-gitweb-standalone-http-status.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d650188..4ae960c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5197,8 +5197,9 @@ sub git_snapshot {
 		die_error(403, "Unsupported snapshot format");
 	}
 
-	if (!defined $hash) {
-		$hash = &git_get_hash($project);
+	my $snapshot = &git_get_hash($project, $hash);
+	if (!$snapshot) {
+		die_error(400, "Not a valid hash id: $hash");
 	}
 
 	my $name = $project;
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index d0ff21d..4f8f147 100644
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -75,4 +75,30 @@ test_expect_success \
 test_debug 'cat gitweb.output'
 
 
+test_expect_success \
+	'snapshots: bad treeish id' \
+	'gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
+	grep "400 - Not a valid hash id:" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: good treeish id' \
+	'gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: good object id' \
+	'ID=`git rev-parse --verify HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: bad object id' \
+	'gitweb_run "p=.git;a=snapshot;h=abcdef01234;sf=tgz" &&
+	grep "400 - Not a valid hash id:" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
 test_done
-- 
1.6.4.2
