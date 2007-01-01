From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: t/t9100-git-svn-basic: remove old check for NO_SYMLINK
Date: Sun, 31 Dec 2006 21:49:46 -0800
Message-ID: <1167630588899-git-send-email-normalperson@yhbt.net>
References: <1167630587505-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 01 06:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1G3X-00033h-0R
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 06:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbXAAFtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 00:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbXAAFtv
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 00:49:51 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58436 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932908AbXAAFtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 00:49:50 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0B5CF7DC099;
	Sun, 31 Dec 2006 21:49:49 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 31 Dec 2006 21:49:48 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.g1ed48
In-Reply-To: <1167630587505-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35726>

We don't support the svn command-line client anymore; nor
do we support anything before SVN 1.1.0, so we can be certain
symlinks will be supported in the SVN repository.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9100-git-svn-basic.sh |   84 +++++++++++++++++++---------------------------
 1 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index c22fe47..040da92 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -24,10 +24,7 @@ test_expect_success \
 	mkdir import &&
 	cd import &&
 	echo foo > foo &&
-	if test -z '$NO_SYMLINK'
-	then
-		ln -s foo foo.link
-	fi
+	ln -s foo foo.link
 	mkdir -p dir/a/b/c/d/e &&
 	echo 'deep dir' > dir/a/b/c/d/e/file &&
 	mkdir bar &&
@@ -136,48 +133,43 @@ test_expect_success "$name" "
 	test -x '$SVN_TREE'/exec.sh"
 
 
-if test -z "$NO_SYMLINK"
-then
-	name='executable file becomes a symlink to bar/zzz (file)'
-
-	test_expect_success "$name" "
-		rm exec.sh &&
-		ln -s bar/zzz exec.sh &&
-		git update-index exec.sh &&
-		git commit -m '$name' &&
-		git-svn set-tree --find-copies-harder --rmdir \
-			remotes/git-svn..mybranch5 &&
-		svn up '$SVN_TREE' &&
-		test -L '$SVN_TREE'/exec.sh"
+name='executable file becomes a symlink to bar/zzz (file)'
+test_expect_success "$name" "
+	rm exec.sh &&
+	ln -s bar/zzz exec.sh &&
+	git update-index exec.sh &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch5 &&
+	svn up '$SVN_TREE' &&
+	test -L '$SVN_TREE'/exec.sh"
 
-	name='new symlink is added to a file that was also just made executable'
+name='new symlink is added to a file that was also just made executable'
 
-	test_expect_success "$name" "
-		chmod +x bar/zzz &&
-		ln -s bar/zzz exec-2.sh &&
-		git update-index --add bar/zzz exec-2.sh &&
-		git commit -m '$name' &&
-		git-svn set-tree --find-copies-harder --rmdir \
-			remotes/git-svn..mybranch5 &&
-		svn up '$SVN_TREE' &&
-		test -x '$SVN_TREE'/bar/zzz &&
-		test -L '$SVN_TREE'/exec-2.sh"
-
-	name='modify a symlink to become a file'
-	test_expect_success "$name" "
-		echo git help > help || true &&
-		rm exec-2.sh &&
-		cp help exec-2.sh &&
-		git update-index exec-2.sh &&
-		git commit -m '$name' &&
-		git-svn set-tree --find-copies-harder --rmdir \
-			remotes/git-svn..mybranch5 &&
-		svn up '$SVN_TREE' &&
-		test -f '$SVN_TREE'/exec-2.sh &&
-		test ! -L '$SVN_TREE'/exec-2.sh &&
-		diff -u help $SVN_TREE/exec-2.sh"
-fi
+test_expect_success "$name" "
+	chmod +x bar/zzz &&
+	ln -s bar/zzz exec-2.sh &&
+	git update-index --add bar/zzz exec-2.sh &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch5 &&
+	svn up '$SVN_TREE' &&
+	test -x '$SVN_TREE'/bar/zzz &&
+	test -L '$SVN_TREE'/exec-2.sh"
 
+name='modify a symlink to become a file'
+test_expect_success "$name" "
+	echo git help > help || true &&
+	rm exec-2.sh &&
+	cp help exec-2.sh &&
+	git update-index exec-2.sh &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch5 &&
+	svn up '$SVN_TREE' &&
+	test -f '$SVN_TREE'/exec-2.sh &&
+	test ! -L '$SVN_TREE'/exec-2.sh &&
+	diff -u help $SVN_TREE/exec-2.sh"
 
 if test "$have_utf8" = t
 then
@@ -203,12 +195,6 @@ test_expect_success "$name" \
      git-rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      diff -u a b"
 
-if test -n "$NO_SYMLINK"
-then
-	test_done
-	exit 0
-fi
-
 name='check imported tree checksums expected tree checksums'
 rm -f expected
 if test "$have_utf8" = t
-- 
1.5.0.rc0.g1ed48
