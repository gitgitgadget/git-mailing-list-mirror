From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] git-mv: fix moves into a subdir from outside
Date: Fri, 3 Mar 2006 17:23:32 +0100
Message-ID: <200603031723.32905.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 17:24:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFD4A-0002mg-4J
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 17:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWCCQXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 11:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWCCQXj
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 11:23:39 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:26286 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932154AbWCCQXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 11:23:38 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 0A3C6BD;
	Fri,  3 Mar 2006 17:23:35 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17156>

git-mv needs to be run from the base directory so that
the check if a file is under revision also covers files
outside of a subdirectory. Previously, e.g. in the git repo,

  cd Documentation; git-mv ../README .

produced the error

  Error: '../README' not under version control

The test is extended for this case; it previously only tested
one direction.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

 git-mv.perl   |    8 ++++++++
 t/t7001-mv.sh |   18 ++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

08d21abe95064934ea559b88801415e09b19f628
diff --git a/git-mv.perl b/git-mv.perl
index f3e859a..0a63860 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -62,9 +62,17 @@ else {
     $dstDir = "";
 }
 
+my $subdir_prefix = `git rev-parse --show-prefix`;
+chomp($subdir_prefix);
+
+# run in git base directory, so that git-ls-files lists all revisioned files
+chdir "$GIT_DIR/..";
+
 # normalize paths, needed to compare against versioned files and update-index
 # also, this is nicer to end-users by doing ".//a/./b/.//./c" ==> "a/b/c"
 for (@srcArgs, @dstArgs) {
+    # prepend git prefix as we run from base directory
+    $_ = $subdir_prefix.$_;
     s|^\./||;
     s|/\./|/| while (m|/\./|);
     s|//+|/|g;
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 43d74c5..811a479 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -11,17 +11,31 @@ test_expect_success \
      git-commit -m add -a'
 
 test_expect_success \
-    'moving the file' \
+    'moving the file out of subdirectory' \
     'cd path0 && git-mv COPYING ../path1/COPYING'
 
 # in path0 currently
 test_expect_success \
     'commiting the change' \
-    'cd .. && git-commit -m move -a'
+    'cd .. && git-commit -m move-out -a'
 
 test_expect_success \
     'checking the commit' \
     'git-diff-tree -r -M --name-status  HEAD^ HEAD | \
     grep -E "^R100.+path0/COPYING.+path1/COPYING"'
 
+test_expect_success \
+    'moving the file back into subdirectory' \
+    'cd path0 && git-mv ../path1/COPYING COPYING'
+
+# in path0 currently
+test_expect_success \
+    'commiting the change' \
+    'cd .. && git-commit -m move-in -a'
+
+test_expect_success \
+    'checking the commit' \
+    'git-diff-tree -r -M --name-status  HEAD^ HEAD | \
+    grep -E "^R100.+path1/COPYING.+path0/COPYING"'
+
 test_done
-- 
1.2.0.g719b
