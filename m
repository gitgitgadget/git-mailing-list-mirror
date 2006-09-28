From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames containing spaces.
Date: Fri, 29 Sep 2006 01:28:55 +0200
Message-ID: <200609290128.56217.robin.rosenberg@dewire.com>
References: <20060922223506.3377.34859.stgit@lathund.dewire.com> <7vvenfw727.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4qFHFeNWGZLei7X"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 01:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5J9-0000vL-W8
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWI1X2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWI1X2p
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:28:45 -0400
Received: from [83.140.172.130] ([83.140.172.130]:55906 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751103AbWI1X2n
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:28:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id DC1A8802895;
	Fri, 29 Sep 2006 01:25:53 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29572-07; Fri, 29 Sep 2006 01:25:53 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 24A4C802676;
	Fri, 29 Sep 2006 01:25:49 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vvenfw727.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28067>

--Boundary-00=_4qFHFeNWGZLei7X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Jounio. Thanks for the feedback. It is your fedora patch 2.5.4 that doesn't work. 
It doesn't seem to handle spaces in filenames in any way. Not much I can do about that.

Btw, 2.5.4 is nine years old, but strangely that's the one that's around everywhere on
source mirrors, but most (=the few ones I checked) Linux distros have 2.5.9 (except RH).

-- robin

--Boundary-00=_4qFHFeNWGZLei7X
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cvsexportcommit"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cvsexportcommit"

Make cvsexportcommit work with filenames containing spaces.

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Binary files are except to this so far.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 git-cvsexportcommit.perl       |   27 +++++++++++++++++---
 t/t9200-git-cvsexportcommit.sh |   55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 99b3dc3..ecded35 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -5,6 +5,7 @@ # - cannot add or remove binary files
 # - does not propagate permissions
 # - tells "ready for commit" even when things could not be completed
 #   (eg addition of a binary file)
+# - Fedora/RHEL uses patch 2.5.4 which doesn't handles spaces in file names
 
 use strict;
 use Getopt::Std;
@@ -121,7 +122,14 @@ #print @files;
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
@@ -217,7 +225,7 @@ foreach my $f (@bfiles) {
     }
 
     # replace with the new file
-     `git-cat-file blob $blob > $f`;
+     `git-cat-file blob $blob > "$f"`;
 
     # TODO: something smart with file modes
 
@@ -231,7 +239,20 @@ ## apply non-binary changes
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
+unless (defined $ENV{'GIT_CVSEXPORTCOMMIT_NO_SPACES'}) {
+  $delta =~ s/\n(index [^\n]*)\n(--- [^\n]*)\n(\+\+\+ [^\n]*)\n(@@[^\n]*@@)\n/$1\n$2\t\n$3\t\n$4\n/sg
+}
+print PATCH $delta;
+close PATCH || die "Could not patch";
+$/ = $saveslash;
 
 my $dirtypatch = 0;
 if (($? >> 8) == 2) {
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
new file mode 100755
index 0000000..548e329
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
+export CVSROOT=$(pwd)/cvsroot
+export CVSWORK=$(pwd)/cvswork
+rm -rf "$CVSROOT" "$CVSWORK"
+mkdir "$CVSROOT" &&
+cvs init &&
+cvs -Q co -d "$CVSWORK" . &&
+export GIT_DIR=$(pwd)/.git &&
+echo >empty &&
+git add empty &&
+git commit -a -m "Initial" 2>/dev/null ||
+exit 1
+
+test_expect_success \
+    'New file' \
+    'echo hello >newfile.txt &&
+     git add newfile.txt &&
+     git commit -a -m "Hello" &&
+     id=$(git rev-list --max-count=1 HEAD) &&
+     (cd "$CVSWORK" &&
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
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -c $id &&
+      test $(cat CVS/Entries|wc -l) = 3
+      )'
+
+test_expect_success \
+     'Update file with spaces in file name' \
+     'echo Ok then >>"with spaces.txt" &&
+      git add "with spaces.txt" &&
+      git commit -a -m "Update with spaces" &&
+      id=$(git rev-list --max-count=1 HEAD) &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -c $id &&
+      test $(cat CVS/Entries|wc -l) = 3
+      )'
+     
+test_done

--Boundary-00=_4qFHFeNWGZLei7X
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cvsexportcommitrm"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cvsexportcommitrm"

Make cvsexportcommit remove files.

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 git-cvsexportcommit.perl       |    2 +-
 t/t9200-git-cvsexportcommit.sh |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index ecded35..4fb55a6 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -143,7 +143,7 @@ foreach my $f (@files) {
     if ($fields[4] eq 'M') {
 	push @mfiles, $fields[5];
     }
-    if ($fields[4] eq 'R') {
+    if ($fields[4] eq 'D') {
 	push @dfiles, $fields[5];
     }
 }
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 548e329..6f28da6 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -52,4 +52,16 @@ test_expect_success \
       test $(cat CVS/Entries|wc -l) = 3
       )'
      
+test_expect_success \
+     'Remove file with spaces in file name' \
+     'echo Ok then >"with spaces.txt" &&
+      rm -v "with spaces.txt" && \
+      git rm "with spaces.txt" && \
+      git commit -a -m "Remove file" &&
+      id=$(git rev-list --max-count=1 HEAD) &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -v -c $id &&
+      test $(cat CVS/Entries|wc -l) = 2
+      )'
+     
 test_done

--Boundary-00=_4qFHFeNWGZLei7X--
