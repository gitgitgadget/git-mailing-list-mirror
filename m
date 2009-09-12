From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH v4 2/2] gitweb: append short hash ids to snapshot files
Date: Sat, 12 Sep 2009 19:04:55 -0400
Message-ID: <4AAC2917.6000306@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 01:05:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmbeV-00016u-AX
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 01:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbZILXE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 19:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbZILXE6
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 19:04:58 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:60638 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751159AbZILXE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 19:04:58 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8CN4tae013030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Sep 2009 19:04:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: 23f7fccb-d9d0-4dc4-9cd1-58e78083dd0e
X-Miltered: at mailchk-m04 with ID 4AAC2917.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Sat, 12 Sep 2009 19:04:57 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128312>

Teach gitweb how to produce nicer snapshot names by only using the
short hash id. If clients make requests using a tree-ish that is not a
partial or full SHA-1 hash, then the short hash will also be appended
to whatever they asked for.

This also includes tests cases for t9502-gitweb-standalone-parse-output.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 gitweb/gitweb.perl                        |   26 +++++++++++
 t/t9502-gitweb-standalone-parse-output.sh |   67 +++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 t/t9502-gitweb-standalone-parse-output.sh

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e1beca5..fdecc3d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2006,6 +2006,26 @@ sub git_get_full_hash {
 	return $retval;
 }
 
+# try and get a shorter hash id
+sub git_get_short_hash {
+	my $project = shift;
+	my $hash = shift;
+	my $o_git_dir = $git_dir;
+	my $retval = undef;
+	$git_dir = "$projectroot/$project";
+	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--short', $hash) {
+		$hash = <$fd>;
+		close $fd;
+		if (defined $hash && $hash =~ /^([0-9a-fA-F]{7,})$/) {
+			$retval = $1;
+		}
+	}
+	if (defined $o_git_dir) {
+		$git_dir = $o_git_dir;
+	}
+	return $retval;
+}
+
 # get type of given object
 sub git_get_type {
 	my $hash = shift;
@@ -5207,6 +5227,12 @@ sub git_snapshot {
 		die_error(404, 'Hash id was not valid');
 	}
 
+
+	if ($full_hash !~ /$hash/) {
+		$hash .= '-' . git_get_short_hash($project, $hash);
+	} else {
+		$hash = git_get_short_hash($project, $hash);
+	}
 	my $name = $project;
 	$name =~ s,([^/])/*\.git$,$1,;
 	$name = basename($name);
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
new file mode 100644
index 0000000..1a2a27f
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
+test_expect_success \
+	'snapshots: give full hash' \
+	'ID=`git rev-parse --verify HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	ID=`git rev-parse --short HEAD` &&
+	grep ".git-$ID.tar.gz" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: give short hash' \
+	'ID=`git rev-parse --short HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	grep ".git-$ID.tar.gz" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: give almost full hash' \
+	'ID=`git rev-parse --short=30 HEAD` &&
+	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
+	ID=`git rev-parse --short HEAD` &&
+	grep ".git-$ID.tar.gz" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: give HEAD tree-ish' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+	ID=`git rev-parse --short HEAD` &&
+	grep ".git-HEAD-$ID.tar.gz" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: give branch name tree-ish' \
+	'gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
+	ID=`git rev-parse --short master` &&
+	grep ".git-master-$ID.tar.gz" gitweb.output'
+test_debug 'cat gitweb.output'
+
+test_expect_success \
+	'snapshots: give tag tree-ish' \
+	'gitweb_run "p=.git;a=snapshot;h=SnapshotFileTests;sf=tgz" &&
+	ID=`git rev-parse --short SnapshotFileTests` &&
+	grep ".git-SnapshotFileTests-$ID.tar.gz" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+test_done
-- 
1.6.4.2
