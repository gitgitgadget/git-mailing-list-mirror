From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH v2] gitweb: check given hash before trying to create snapshot
Date: Fri, 11 Sep 2009 01:01:10 -0400
Message-ID: <4AA9D996.8030405@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlyGL-0002hO-6u
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbZIKFBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbZIKFBY
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:01:24 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:55914 "EHLO
	mailchk-m02.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751144AbZIKFBY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 01:01:24 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m02.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8B51ASO027193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Sep 2009 01:01:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: 435e38ab-c63a-4855-a884-142015004b92
X-Miltered: at mailchk-m02 with ID 4AA9D996.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m02
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m02.uwaterloo.ca [129.97.128.141]); Fri, 11 Sep 2009 01:01:24 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128169>

I squashed the two commits together and I also used Jakub's idea to
create a wrapper for git_get_head_hash.

--
Mark Rada (ferrous26)
marada@uwaterloo.ca


--->8---
Make things nicer in cases when you hand craft the snapshot URL but
make a typo in defining the hash variable (e.g. netx instead of next);
you will now get an error message instead of a broken tarball.

To maintain backwards compatibility, git_get_head_hash is now a wrapper
for git_get_full_hash, as suggested by Jakub Narebski.

Tests for t9501 are included to demonstrate changed functionality.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 gitweb/gitweb.perl                       |   13 ++++++++++---
 t/t9501-gitweb-standalone-http-status.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..a40a50d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1983,11 +1983,17 @@ sub quote_command {
 
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
+	return git_get_full_hash(shift, 'HEAD');
+}
+
+# given a project and tree-ish, returns full hash
+sub git_get_full_hash {
 	my $project = shift;
+	my $hash = shift;
 	my $o_git_dir = $git_dir;
 	my $retval = undef;
 	$git_dir = "$projectroot/$project";
-	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
+	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--verify', $hash) {
 		my $head = <$fd>;
 		close $fd;
 		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
@@ -5196,8 +5202,9 @@ sub git_snapshot {
 		die_error(403, "Unsupported snapshot format");
 	}
 
-	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
+	my $snapshot = git_get_full_hash($project, $hash);
+	if (!$snapshot) {
+		die_error(400, "Not a valid hash id: $hash");
 	}
 
 	my $name = $project;
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index d0ff21d..81abfae 100644
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -75,4 +75,33 @@ test_expect_success \
 test_debug 'cat gitweb.output'
 
 
+# ----------------------------------------------------------------------
+# snapshot hash ids
+
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
+	'snapshots: bad object id' \
+	'gitweb_run "p=.git;a=snapshot;h=abcdef01234;sf=tgz" &&
+	grep "400 - Not a valid hash id:" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: good object id' \
+	'ID=`git rev-parse --verify HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
 test_done
-- 
1.6.4.2
