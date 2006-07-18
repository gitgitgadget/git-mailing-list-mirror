From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsexportcommit - add -a (add author line) flag, cleanup warnings
Date: Tue, 18 Jul 2006 14:22:49 +1200
Message-ID: <11531893692075-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jul 18 04:12:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2f3u-0004Sm-70
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 04:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWGRCLr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 22:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWGRCLr
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 22:11:47 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:4812 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1750860AbWGRCLq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 22:11:46 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1G2f3m-0004jq-V0; Tue, 18 Jul 2006 14:11:43 +1200
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1G2fEX-0000rx-00; Tue, 18 Jul 2006 14:22:49 +1200
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.4.1.ga3e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23989>

This patch adds support for -a which will add an "Author: " line, and possibly
a "Committer: " line to the bottom of the commit message for CVS.

The commit message parser is now a little bit better, and some warnings
have been cleaned up.
---
 Documentation/git-cvsexportcommit.txt |    6 +++-
 git-cvsexportcommit.perl              |   50 +++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 27ac72d..b689c1b 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -8,7 +8,7 @@ git-cvsexportcommit - Export a commit to
 
 SYNOPSIS
 --------
-'git-cvsexportcommit' [-h] [-v] [-c] [-p] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
+'git-cvsexportcommit' [-h] [-v] [-c] [-p] [-a] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
 
 
 DESCRIPTION
@@ -39,6 +39,10 @@ OPTIONS
 	Be pedantic (paranoid) when applying patches. Invokes patch with 
 	--fuzz=0
 
+-a::
+	Add authorship information. Adds Author line, and Committer (if
+	different from Author) to the message. 
+
 -f::
 	Force the merge even if the files are not up to date.
 
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 5d13a54..99b3dc3 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -16,9 +16,9 @@ unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR
     die "GIT_DIR is not defined or is unreadable";
 }
 
-our ($opt_h, $opt_p, $opt_v, $opt_c, $opt_f, $opt_m );
+our ($opt_h, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m );
 
-getopts('hpvcfm:');
+getopts('hpvcfam:');
 
 $opt_h && usage();
 
@@ -29,7 +29,6 @@ our ($tmpdir, $tmpdirname) = tempdir('gi
 				     TMPDIR => 1,
 				     CLEANUP => 1);
 
-print Dumper(@ARGV);
 # resolve target commit
 my $commit;
 $commit = pop @ARGV;
@@ -53,12 +52,32 @@ if (@ARGV) {
 # find parents from the commit itself
 my @commit  = safe_pipe_capture('git-cat-file', 'commit', $commit);
 my @parents;
-foreach my $p (@commit) {
-    if ($p =~ m/^$/) { # end of commit headers, we're done
-	last;
+my $committer;
+my $author;
+my $stage = 'headers'; # headers, msg
+my $title;
+my $msg = '';
+
+foreach my $line (@commit) {
+    chomp $line;
+    if ($stage eq 'headers' && $line eq '') {
+	$stage = 'msg';
+	next;
     }
-    if ($p =~ m/^parent (\w{40})$/) { # found a parent
-	push @parents, $1;
+
+    if ($stage eq 'headers') {
+	if ($line =~ m/^parent (\w{40})$/) { # found a parent
+	    push @parents, $1;
+	} elsif ($line =~ m/^author (.+) \d+ \+\d+$/) {
+	    $author = $1;
+	} elsif ($line =~ m/^committer (.+) \d+ \+\d+$/) {
+	    $committer = $1;
+	}
+    } else {
+	$msg .= $line . "\n";
+	unless ($title) {
+	    $title = $line;
+	}
     }
 }
 
@@ -84,12 +103,18 @@ if ($parent) {
 
 # grab the commit message
 open(MSG, ">.msg") or die "Cannot open .msg for writing";
-print MSG $opt_m;
+if ($opt_m) {
+    print MSG $opt_m;
+}
+print MSG $msg;
+if ($opt_a) {
+    print MSG "\n\nAuthor: $author\n";
+    if ($author ne $committer) {
+	print MSG "Committer: $committer\n";
+    }
+}
 close MSG;
 
-`git-cat-file commit $commit | sed -e '1,/^\$/d' >> .msg`;
-$? && die "Error extracting the commit message";
-
 my (@afiles, @dfiles, @mfiles, @dirs);
 my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
 #print @files;
@@ -233,6 +258,7 @@ foreach my $f (@dfiles) {
 }
 
 print "Commit to CVS\n";
+print "Patch: $title\n";
 my $commitfiles = join(' ', @afiles, @mfiles, @dfiles);
 my $cmd = "cvs commit -F .msg $commitfiles";
 
-- 
1.4.1.ga3e6
