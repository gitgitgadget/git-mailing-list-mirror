From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] cvsexportcommit: Add switch to specify CVS workdir
Date: Wed, 31 Oct 2007 23:12:20 +0100
Message-ID: <1193868740-3092-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 31 23:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLlh-00019Q-Id
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbXJaWKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 18:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbXJaWKL
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:10:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2778 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbXJaWKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 18:10:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 274A1A149BD;
	Wed, 31 Oct 2007 23:01:16 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17937-02; Wed, 31 Oct 2007 23:01:15 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 168D68026C1;
	Wed, 31 Oct 2007 23:01:15 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 560E52A3DE; Wed, 31 Oct 2007 23:12:19 +0100 (CET)
X-Mailer: git-send-email 1.5.3.4-dirty
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62889>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/git-cvsexportcommit.txt |   22 ++++++++++++++----
 git-cvsexportcommit.perl              |   39 ++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 17 deletions(-)

I finally got tired of swapping working directories.

-- robin

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index c3922f9..310d56a 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -8,7 +8,7 @@ git-cvsexportcommit - Export a single commit to a CVS checkout
 
 SYNOPSIS
 --------
-'git-cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
+'git-cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot] [-w cvsworkdir] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
 
 
 DESCRIPTION
@@ -16,8 +16,9 @@ DESCRIPTION
 Exports a commit from GIT to a CVS checkout, making it easier
 to merge patches from a git repository into a CVS repository.
 
-Execute it from the root of the CVS working copy. GIT_DIR must be defined.
-See examples below.
+Specify the name of a CVS checkout using the -w switch or execute it 
+from the root of the CVS working copy. In the latter case GIT_DIR must
+be defined. See examples below.
 
 It does its best to do the safe thing, it will check that the files are
 unchanged and up to date in the CVS checkout, and it will not autocommit
@@ -61,6 +62,11 @@ OPTIONS
 -u::
 	Update affected files from CVS repository before attempting export.
 
+-w::
+	Specify the location of the CVS checkout to use for the export. This
+	option does not require GIT_DIR to be set before execution if the 
+	current directory is within a git repository.
+
 -v::
 	Verbose.
 
@@ -76,6 +82,12 @@ $ git-cvsexportcommit -v <commit-sha1>
 $ cvs commit -F .msg <files>
 ------------
 
+Merge one patch into CVS (-c and -w options). The working directory is within the Git Repo::
++
+------------
+	$ git-cvsexportcommit -v -c -w ~/project_cvs_checkout <commit-sha1>
+------------
+
 Merge pending patches into CVS automatically -- only if you really know what you are doing::
 +
 ------------
@@ -86,11 +98,11 @@ $ git-cherry cvshead myhead | sed -n 's/^+ //p' | xargs -l1 git-cvsexportcommit
 
 Author
 ------
-Written by Martin Langhoff <martin@catalyst.net.nz>
+Written by Martin Langhoff <martin@catalyst.net.nz> and others.
 
 Documentation
 --------------
-Documentation by Martin Langhoff <martin@catalyst.net.nz>
+Documentation by Martin Langhoff <martin@catalyst.net.nz> and others.
 
 GIT
 ---
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index f284c88..47973e8 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,28 +1,42 @@
 #!/usr/bin/perl -w
 
-# Known limitations:
-# - does not propagate permissions
-# - error handling has not been extensively tested
-#
-
 use strict;
 use Getopt::Std;
 use File::Temp qw(tempdir);
 use Data::Dumper;
 use File::Basename qw(basename dirname);
 
-unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
-    die "GIT_DIR is not defined or is unreadable";
-}
-
-our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u);
+our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u, $opt_w);
 
-getopts('uhPpvcfam:d:');
+getopts('uhPpvcfam:d:w:');
 
 $opt_h && usage();
 
 die "Need at least one commit identifier!" unless @ARGV;
 
+if ($opt_w) {
+	unless ($ENV{GIT_DIR}) {
+		# Remember where our GIT_DIR is before changing to CVS checkout
+		my $gd =`git-rev-parse --git-dir`;
+		chomp($gd);
+		if ($gd eq '.git') {
+			my $wd = `pwd`;
+			chomp($wd);
+			$gd = $wd."/.git"	;
+		}
+		$ENV{GIT_DIR} = $gd;
+	}
+
+	if (! -d $opt_w."/CVS" ) {
+		die "$opt_w is not a CVS checkout";
+	}
+	chdir $opt_w or die "Cannot change to CVS checkout at $opt_w";
+}
+unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
+    die "GIT_DIR is not defined or is unreadable";
+}
+
+
 my @cvs;
 if ($opt_d) {
 	@cvs = ('cvs', '-d', $opt_d);
@@ -267,6 +281,7 @@ if ($dirtypatch) {
     print "You'll need to apply the patch in .cvsexportcommit.diff manually\n";
     print "using a patch program. After applying the patch and resolving the\n";
     print "problems you may commit using:";
+    print "\n    cd \"$opt_w\"" if $opt_w;
     print "\n    $cmd\n\n";
     exit(1);
 }
@@ -294,7 +309,7 @@ sleep(1);
 
 sub usage {
 	print STDERR <<END;
-Usage: GIT_DIR=/path/to/.git ${\basename $0} [-h] [-p] [-v] [-c] [-f] [-m msgprefix] [ parent ] commit
+Usage: GIT_DIR=/path/to/.git ${\basename $0} [-h] [-p] [-v] [-c] [-f] [-u] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
 END
 	exit(1);
 }
-- 
1.5.3.4-dirty
