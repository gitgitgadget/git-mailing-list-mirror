From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] cvsexportcommit: introduce -W for shared working trees
 (between Git and CVS)
Date: Wed, 14 May 2008 15:29:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141528370.30431@racer>
References: <alpine.DEB.1.00.0805141526160.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 16:31:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwI0C-0004DW-Uu
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 16:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbYENO3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 10:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYENO3t
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 10:29:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:60377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752881AbYENO3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 10:29:48 -0400
Received: (qmail invoked by alias); 14 May 2008 14:29:47 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp030) with SMTP; 14 May 2008 16:29:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196er9QNt96gtB0fK//xNNHSqgw8l/E8ix7oU7OZD
	mmUicrxitrp32i
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805141526160.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82104>


If you have a CVS checkout, it is easy to import the CVS history by
calling "git cvsimport".  However, interacting with the CVS repository
using "git cvsexportcommit" was cumbersome, since that script assumes
separate working directories for Git and CVS.

Now, you can call cvsexportcommit with the -W option.  This will
automatically discover the GIT_DIR, and it will check out the parent
commit before exporting the commit.

The intended workflow is this:

$ CVSROOT=$URL cvs co module
$ cd module
$ git cvsimport
hack, hack, hack, making two commits, cleaning them up using rebase -i.
$ git cvsexportcommit -W -c -p -u HEAD^
$ git cvsexportcommit -W -c -p -u HEAD

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This makes cvsexportcommit slightly more usable for me.  It is
	not (yet) a "git cvs dcommit", because it does not perform the
	test what to commit (and possibly commit more than one patch),
	and it does not rebase either.

 Documentation/git-cvsexportcommit.txt |    7 +++++-
 git-cvsexportcommit.perl              |   35 ++++++++++++++++++++++++++++----
 t/t9200-git-cvsexportcommit.sh        |   17 ++++++++++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 9a47b4c..b78c9f3 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -8,7 +8,7 @@ git-cvsexportcommit - Export a single commit to a CVS checkout
 
 SYNOPSIS
 --------
-'git-cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot] [-w cvsworkdir] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
+'git-cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot] [-w cvsworkdir] [-W] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
 
 
 DESCRIPTION
@@ -67,6 +67,11 @@ OPTIONS
 	option does not require GIT_DIR to be set before execution if the
 	current directory is within a git repository.
 
+-W::
+	Tell cvsexportcommit that the current working directory is not only
+	a Git checkout, but also the CVS checkout.  Therefore, Git will
+	reset the working directory to the parent commit before proceeding.
+
 -v::
 	Verbose.
 
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 3b20bd1..7105825 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -7,15 +7,15 @@ use Data::Dumper;
 use File::Basename qw(basename dirname);
 use File::Spec;
 
-our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u, $opt_w);
+our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u, $opt_w, $opt_W);
 
-getopts('uhPpvcfam:d:w:');
+getopts('uhPpvcfam:d:w:W');
 
 $opt_h && usage();
 
 die "Need at least one commit identifier!" unless @ARGV;
 
-if ($opt_w) {
+if ($opt_w || $opt_W) {
 	# Remember where GIT_DIR is before changing to CVS checkout
 	unless ($ENV{GIT_DIR}) {
 		# No GIT_DIR set. Figure it out for ourselves
@@ -25,7 +25,9 @@ if ($opt_w) {
 	}
 	# Make sure GIT_DIR is absolute
 	$ENV{GIT_DIR} = File::Spec->rel2abs($ENV{GIT_DIR});
+}
 
+if ($opt_w) {
 	if (! -d $opt_w."/CVS" ) {
 		die "$opt_w is not a CVS checkout";
 	}
@@ -116,6 +118,15 @@ if ($parent) {
     }
 }
 
+my $go_back_to = 0;
+
+if ($opt_W) {
+    $opt_v && print "Resetting to $parent\n";
+    $go_back_to = `git symbolic-ref HEAD 2> /dev/null ||
+	git rev-parse HEAD` || die "Could not determine current branch";
+    system("git checkout -q $parent^0") && die "Could not check out $parent^0";
+}
+
 $opt_v && print "Applying to CVS commit $commit from parent $parent\n";
 
 # grab the commit message
@@ -260,7 +271,11 @@ if ($dirty) {
 }
 
 print "Applying\n";
-`GIT_DIR= git-apply $context --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
+if ($opt_W) {
+    system("git checkout -q $commit^0") && die "cannot patch";
+} else {
+    `GIT_DIR= git-apply $context --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
+}
 
 print "Patch applied successfully. Adding new files and directories to CVS\n";
 my $dirtypatch = 0;
@@ -313,7 +328,9 @@ if ($dirtypatch) {
     print "using a patch program. After applying the patch and resolving the\n";
     print "problems you may commit using:";
     print "\n    cd \"$opt_w\"" if $opt_w;
-    print "\n    $cmd\n\n";
+    print "\n    $cmd\n";
+    print "\n    git checkout $go_back_to\n" if $go_back_to;
+    print "\n";
     exit(1);
 }
 
@@ -333,6 +350,14 @@ if ($opt_c) {
 # clean up
 unlink(".cvsexportcommit.diff");
 
+if ($opt_W) {
+    system("git checkout $go_back_to") && die "cannot move back to $go_back_to";
+    if (!($go_back_to =~ /^[0-9a-fA-F]{40}$/)) {
+	system("git symbolic-ref HEAD $go_back_to") &&
+	    die "cannot move back to $go_back_to";
+    }
+}
+
 # CVS version 1.11.x and 1.12.x sleeps the wrong way to ensure the timestamp
 # used by CVS and the one set by subsequence file modifications are different.
 # If they are not different CVS will not detect changes.
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 42b144b..b1dc32d 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -297,4 +297,21 @@ test_expect_success 'commit a file with leading spaces in the name' '
 
 '
 
+test_expect_success 'use the same checkout for Git and CVS' '
+
+	(mkdir shared &&
+	 cd shared &&
+	 unset GIT_DIR &&
+	 cvs co . &&
+	 git init &&
+	 git add " space" &&
+	 git commit -m "fake initial commit" &&
+	 echo Hello >> " space" &&
+	 git commit -m "Another change" " space" &&
+	 git cvsexportcommit -W -p -u -c HEAD &&
+	 grep Hello " space" &&
+	 git diff-files)
+
+'
+
 test_done
-- 
1.5.5.1.375.g1becb
