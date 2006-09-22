From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Make cvsexportcommit work with filenames containing spaces.
Date: Sat, 23 Sep 2006 00:35:06 +0200
Message-ID: <20060922223506.3377.34859.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Sep 23 00:42:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQtiU-00056f-FL
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 00:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWIVWlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWIVWlL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 18:41:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19511 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S965250AbWIVWlG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 18:41:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id AFCF280286A
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:20 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06746-09 for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:20 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id E9704802888
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:17 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 0CBC928FB0
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:41:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id NvHvZepv8d7i for <git@vger.kernel.org>;
	Sat, 23 Sep 2006 00:41:12 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 365C428E15
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:35:07 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27537>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Binary files are except to this so far.
---

 git-cvsexportcommit.perl       |   24 +++++++++++++++--
 t/t9200-git-cvsexportcommit.sh |   55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 99b3dc3..d78100c 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -121,7 +121,14 @@ #print @files;
 $? && die "Error in git-diff-tree";
 foreach my $f (@files) {
     chomp $f;
-    my @fields = split(m!\s+!, $f);
+    $f =~ m/^(\S+) (\S+) (\S+) (\S+) (\S+)	(.*)/;
+    my @fields = ();
+    $fields[++$#fields] = $1;
+    $fields[++$#fields] = $2;
+    $fields[++$#fields] = $3;
+    $fields[++$#fields] = $4;
+    $fields[++$#fields] = $5;
+    $fields[++$#fields] = $6;
     if ($fields[4] eq 'A') {
         my $path = $fields[5];
 	push @afiles, $path;
@@ -217,7 +224,7 @@ foreach my $f (@bfiles) {
     }
 
     # replace with the new file
-     `git-cat-file blob $blob > $f`;
+     `git-cat-file blob $blob > "$f"`;
 
     # TODO: something smart with file modes
 
@@ -231,7 +238,18 @@ ## apply non-binary changes
 my $fuzz = $opt_p ? 0 : 2;
 
 print "Patching non-binary files\n";
-print `(git-diff-tree -p $parent -p $commit | patch -p1 -F $fuzz ) 2>&1`;
+
+my $saveslash = $/;
+undef $/;
+
+open DIFF, "git-diff-tree -p $parent -p $commit|" || die "Cannot diff";
+open PATCH, "|patch -p1 -F $fuzz" || die "Cannot patch";
+my $delta = <DIFF>;
+close DIFF || die "Could not diff";
+$delta =~ s/\n(index [^\n]*)\n(--- [^\n]*)\n(\+\+\+ [^\n]*)\n(@@[^\n]*@@)\n/$1\n$2\t\n$3\t\n$4\n/sg;
+print PATCH $delta;
+close PATCH || die "Could not patch";
+$/ = $saveslash;
 
 my $dirtypatch = 0;
 if (($? >> 8) == 2) {
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
new file mode 100755
index 0000000..1041bb6
--- /dev/null
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+
+test_description='CVS export comit. 
+
+These tests are ad-hoc ones made to test
+some changes, not a complete test.'
+
+. ./test-lib.sh
+
+export CVSROOT=$(dirname $(pwd))/cvsroot
+export CVSWORK=$(dirname $(pwd))/cvswork
+rm -rf $CVSROOT $CVSWORK
+mkdir $CVSROOT
+cvs init
+cvs -Q co -d $CVSWORK .
+export GIT_DIR=$(pwd)/.git
+
+echo >empty &&
+git add empty &&
+git commit -a -m "Initial"
+
+test_expect_success \
+    'New file' \
+    'echo hello >newfile.txt &&
+     git add newfile.txt &&
+     git commit -a -m "Hello" &&
+     id=$(git rev-list --max-count=1 HEAD) &&
+     (cd $CVSWORK &&
+     git cvsexportcommit -c $id &&
+     test $(cat CVS/Entries|wc -l) = 2
+     )'
+
+test_expect_success \
+     'New file with spaces in file name' \
+     'echo ok then >"with spaces.txt" &&
+      git add "with spaces.txt" && \
+      git commit -a -m "With spaces" &&
+      id=$(git rev-list --max-count=1 HEAD) &&
+      (cd $CVSWORK &&
+      git-cvsexportcommit.perl -c $id &&
+      test $(cat CVS/Entries|wc -l) = 3
+      )'
+
+test_expect_success \
+     'Update file with spaces in file name' \
+     'echo Ok then >>"with spaces.txt" &&
+      git add "with spaces.txt" &&
+      git commit -a -m "Update with spaces" &&
+      id=$(git rev-list --max-count=1 HEAD) &&
+      (cd $CVSWORK &&
+      git-cvsexportcommit.perl -c $id &&
+      test $(cat CVS/Entries|wc -l) = 3
+      )'
+     
+test_done
