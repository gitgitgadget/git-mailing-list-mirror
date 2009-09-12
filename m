From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH v4 1/2] gitweb: check given hash before trying to create
 snapshot
Date: Sat, 12 Sep 2009 19:03:52 -0400
Message-ID: <4AAC28D8.8050907@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 01:04:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmbda-0000vK-OL
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 01:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbZILXEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 19:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbZILXEA
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 19:04:00 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:47384 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750714AbZILXD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 19:03:59 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8CN3rfq000732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Sep 2009 19:03:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: 34b88587-d1bf-422b-930a-72c461b2ba1e
X-Miltered: at mailchk-m05 with ID 4AAC28D9.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Sat, 12 Sep 2009 19:04:01 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128311>

I changed some variable names to be nicer looking.

--
Mark Rada (ferrous26)
marada@uwaterloo.ca


--->8---
Makes things nicer in cases when you hand craft the snapshot URL but
make a typo in defining the hash variable (e.g. netx instead of next);
you will now get an error message instead of a broken tarball.

To maintain backwards compatibility, git_get_head_hash is now a wrapper
for git_get_full_hash, as suggested by Jakub Narebski.

Tests for t9501 are included to demonstrate added functionality.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 gitweb/gitweb.perl                       |   19 +++++++++++++------
 t/t9501-gitweb-standalone-http-status.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..e1beca5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1983,14 +1983,20 @@ sub quote_command {
 
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
-		my $head = <$fd>;
+	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--verify', $hash) {
+		$hash = <$fd>;
 		close $fd;
-		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
+		if (defined $hash && $hash =~ /^([0-9a-fA-F]{40})$/) {
 			$retval = $1;
 		}
 	}
@@ -5196,8 +5202,9 @@ sub git_snapshot {
 		die_error(403, "Unsupported snapshot format");
 	}
 
-	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
+	my $full_hash = git_get_full_hash($project, $hash);
+	if (!$full_hash) {
+		die_error(404, 'Hash id was not valid');
 	}
 
 	my $name = $project;
@@ -5210,7 +5217,7 @@ sub git_snapshot {
 	$cmd = quote_command(
 		git_cmd(), 'archive',
 		"--format=$known_snapshot_formats{$format}{'format'}",
-		"--prefix=$name/", $hash);
+		"--prefix=$name/", $full_hash);
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
 	}
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index d0ff21d..632007e 100644
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -75,4 +75,33 @@ test_expect_success \
 test_debug 'cat gitweb.output'
 
 
+# ----------------------------------------------------------------------
+# snapshot hash ids
+
+test_expect_success \
+	'snapshots: good treeish id' \
+	'gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: bad treeish id' \
+	'gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
+	grep "404 - Hash id was not valid" gitweb.output'
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
+	grep "404 - Hash id was not valid" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
 test_done
-- 
1.6.4.2
