From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH v5 2/2] gitweb: append short hash ids to snapshot files
Date: Sat, 26 Sep 2009 13:46:21 -0400
Message-ID: <4ABE536D.3070705@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 19:46:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrbM3-00081W-D0
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 19:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbZIZRq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbZIZRq0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 13:46:26 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:53686 "EHLO
	mailchk-m03.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752075AbZIZRq0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 13:46:26 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m03.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8QHkLED026836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Sep 2009 13:46:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: d0729f59-1cbf-4533-8ae5-767d2d6a3a22
X-Miltered: at mailchk-m03 with ID 4ABE536D.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m03
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m03.uwaterloo.ca [129.97.128.141]); Sat, 26 Sep 2009 13:46:25 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129162>

Teach gitweb how to produce nicer snapshot names by only using the
short hash id. If clients make requests using a tree-ish that is not a
partial or full SHA-1 hash, then the short hash will also be appended
to whatever they asked for.

This also includes tests cases for t9502-gitweb-standalone-parse-output.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---


	Changes since v4:
		- moved git_get_full_hash into this commit
		- changed test case format, suggested by Junio
		- explicity request at least a length of 7 for short hashes


 gitweb/gitweb.perl                        |   40 +++++++++++++++--
 t/t9502-gitweb-standalone-parse-output.sh |   67 +++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 4 deletions(-)
 create mode 100644 t/t9502-gitweb-standalone-parse-output.sh

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d4a2ae..bc132a5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1983,14 +1983,39 @@ sub quote_command {
 
 # get HEAD ref of given project as hash
 sub git_get_head_hash {
+	return git_get_full_hash(shift, 'HEAD');
+}
+
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
+			$retval = $1;
+		}
+	}
+	if (defined $o_git_dir) {
+		$git_dir = $o_git_dir;
+	}
+	return $retval;
+}
+
+# try and get a shorter hash id
+sub git_get_short_hash {
+	my $project = shift;
+	my $hash = shift;
+	my $o_git_dir = $git_dir;
+	my $retval = undef;
+	$git_dir = "$projectroot/$project";
+	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--short=7', $hash) {
+		$hash = <$fd>;
+		close $fd;
+		if (defined $hash && $hash =~ /^([0-9a-fA-F]{7,})$/) {
 			$retval = $1;
 		}
 	}
@@ -5203,6 +5228,13 @@ sub git_snapshot {
 		die_error(400, 'Object is not a tree-ish');
 	}
 
+
+	my $full_hash = git_get_full_hash($project, $hash);
+	if ($full_hash =~ /^$hash/) {
+		$hash = git_get_short_hash($project, $hash);
+	} else {
+		$hash .= '-' . git_get_short_hash($project, $hash);
+	}
 	my $name = $project;
 	$name =~ s,([^/])/*\.git$,$1,;
 	$name = basename($name);
@@ -5213,7 +5245,7 @@ sub git_snapshot {
 	$cmd = quote_command(
 		git_cmd(), 'archive',
 		"--format=$known_snapshot_formats{$format}{'format'}",
-		"--prefix=$name/", $hash);
+		"--prefix=$name/", $full_hash);
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
 	}
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
new file mode 100644
index 0000000..5f2b1d5
--- /dev/null
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Mark Rada
+#
+
+test_description='gitweb as standalone script (parsing script output).
+
+This test runs gitweb (git web interface) as a CGI script from the
+commandline, and checks that it produces the correct output, either
+in the HTTP header or the actual script output.'
+
+
+. ./gitweb-lib.sh
+
+# ----------------------------------------------------------------------
+# snapshot file name
+
+test_commit \
+	'SnapshotFileTests' \
+	'i can has snapshot?'
+
+test_expect_success 'snapshots: give full hash' '
+	ID=`git rev-parse --verify HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	ID=`git rev-parse --short HEAD` &&
+	grep ".git-$ID.tar.gz" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: give short hash' '
+	ID=`git rev-parse --short HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	grep ".git-$ID.tar.gz" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: give almost full hash' '
+	ID=`git rev-parse --short=30 HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	ID=`git rev-parse --short HEAD` &&
+	grep ".git-$ID.tar.gz" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: give HEAD tree-ish' '
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+	ID=`git rev-parse --short HEAD` &&
+	grep ".git-HEAD-$ID.tar.gz" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: give branch name tree-ish' '
+	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	ID=`git rev-parse --short master` &&
+	grep ".git-master-$ID.tar.gz" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+test_expect_success 'snapshots: give tag tree-ish' '
+	gitweb_run "p=.git;a=snapshot;h=SnapshotFileTests;sf=tgz" &&
+	ID=`git rev-parse --short SnapshotFileTests` &&
+	grep ".git-SnapshotFileTests-$ID.tar.gz" gitweb.output
+'
+test_debug 'cat gitweb.output'
+
+
+test_done
-- 
1.6.4.GIT
