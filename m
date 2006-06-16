From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/4] git-svn: svn (command-line) 1.0.x compatibility
Date: Fri, 16 Jun 2006 10:57:25 -0700
Message-ID: <11504806492195-git-send-email-normalperson@yhbt.net>
References: <11504049343825-git-send-email-normalperson@yhbt.net> <11504806463470-git-send-email-normalperson@yhbt.net> <11504806472857-git-send-email-normalperson@yhbt.net> <11504806481800-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 16 19:57:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIZh-0006lH-KH
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWFPR5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWFPR5d
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:57:33 -0400
Received: from hand.yhbt.net ([66.150.188.102]:12516 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751199AbWFPR5c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 13:57:32 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 188917DC024;
	Fri, 16 Jun 2006 10:57:30 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 16 Jun 2006 10:57:29 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11504806481800-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21958>

Tested on a plain Ubuntu Warty installation
using subversion 1.0.6-1.2ubuntu3

svn add --force was never needed, as it only affected
directories, which git (thankfully) doesn't track

The 1.0.x also didn't support symlinks(!), so allow NO_SYMLINK
to be defined for running tests

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl               |    4 +
 contrib/git-svn/t/t0000-contrib-git-svn.sh |   90 +++++++++++++++-------------
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 417fcf1..ab1d065 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -1306,12 +1306,12 @@ sub svn_checkout_tree {
 		} elsif ($m->{chg} eq 'T') {
 			sys(qw(svn rm --force),$m->{file_b});
 			apply_mod_line_blob($m);
-			sys(qw(svn add --force), $m->{file_b});
+			sys(qw(svn add), $m->{file_b});
 			svn_check_prop_executable($m);
 		} elsif ($m->{chg} eq 'A') {
 			svn_ensure_parent_path( $m->{file_b} );
 			apply_mod_line_blob($m);
-			sys(qw(svn add --force), $m->{file_b});
+			sys(qw(svn add), $m->{file_b});
 			svn_check_prop_executable($m);
 		} else {
 			croak "Invalid chg: $m->{chg}\n";
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
index 0f52746..443d518 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -11,7 +11,10 @@ mkdir import
 cd import
 
 echo foo > foo
-ln -s foo foo.link
+if test -z "$NO_SYMLINK"
+then
+	ln -s foo foo.link
+fi
 mkdir -p dir/a/b/c/d/e
 echo 'deep dir' > dir/a/b/c/d/e/file
 mkdir -p bar
@@ -129,46 +132,45 @@ test_expect_success "$name" \
 
 
 
-name='executable file becomes a symlink to bar/zzz (file)'
-rm exec.sh
-ln -s bar/zzz exec.sh
-git update-index exec.sh
-git commit -m "$name"
-
-test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
-     svn up $SVN_TREE &&
-     test -L $SVN_TREE/exec.sh"
-
-
-
-name='new symlink is added to a file that was also just made executable'
-chmod +x bar/zzz
-ln -s bar/zzz exec-2.sh
-git update-index --add bar/zzz exec-2.sh
-git commit -m "$name"
-
-test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
-     svn up $SVN_TREE &&
-     test -x $SVN_TREE/bar/zzz &&
-     test -L $SVN_TREE/exec-2.sh"
-
-
-
-name='modify a symlink to become a file'
-git help > help || true
-rm exec-2.sh
-cp help exec-2.sh
-git update-index exec-2.sh
-git commit -m "$name"
-
-test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
-     svn up $SVN_TREE &&
-     test -f $SVN_TREE/exec-2.sh &&
-     test ! -L $SVN_TREE/exec-2.sh &&
-     diff -u help $SVN_TREE/exec-2.sh"
+if test -z "$NO_SYMLINK"
+then
+	name='executable file becomes a symlink to bar/zzz (file)'
+	rm exec.sh
+	ln -s bar/zzz exec.sh
+	git update-index exec.sh
+	git commit -m "$name"
+
+	test_expect_success "$name" \
+	    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
+	     svn up $SVN_TREE &&
+	     test -L $SVN_TREE/exec.sh"
+
+	name='new symlink is added to a file that was also just made executable'
+	chmod +x bar/zzz
+	ln -s bar/zzz exec-2.sh
+	git update-index --add bar/zzz exec-2.sh
+	git commit -m "$name"
+
+	test_expect_success "$name" \
+	    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
+	     svn up $SVN_TREE &&
+	     test -x $SVN_TREE/bar/zzz &&
+	     test -L $SVN_TREE/exec-2.sh"
+
+	name='modify a symlink to become a file'
+	git help > help || true
+	rm exec-2.sh
+	cp help exec-2.sh
+	git update-index exec-2.sh
+	git commit -m "$name"
+
+	test_expect_success "$name" \
+	    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
+	     svn up $SVN_TREE &&
+	     test -f $SVN_TREE/exec-2.sh &&
+	     test ! -L $SVN_TREE/exec-2.sh &&
+	     diff -u help $SVN_TREE/exec-2.sh"
+fi
 
 
 if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-8$'
@@ -193,6 +195,12 @@ test_expect_success "$name" \
      git-rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      diff -u a b"
 
+if test -n "$NO_SYMLINK"
+then
+	test_done
+	exit 0
+fi
+
 name='check imported tree checksums expected tree checksums'
 rm -f expected
 if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-8$'
-- 
1.4.0
