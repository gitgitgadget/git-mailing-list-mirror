From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] git-svn: quiet down tests and fix some unportable shell constructs
Date: Tue, 26 Dec 2006 16:27:37 -0800
Message-ID: <1167179258485-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 27 01:27:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzMe2-0008Fm-GI
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 01:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbWL0A1l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 19:27:41 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWL0A1l
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 19:27:41 -0500
Received: from hand.yhbt.net ([66.150.188.102]:41800 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932849AbWL0A1k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 19:27:40 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 049567DC02A;
	Tue, 26 Dec 2006 16:27:38 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 26 Dec 2006 16:27:38 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35439>

The latest changes to git-commit have made it more verbose; and
I was running the setup of the tests outside of the test_expect_*,
so errors in those were not caught.  Now we move them to where
they can be eval'ed and have their output trapped.

export var=3Dvalue has been removed

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9100-git-svn-basic.sh |  258 +++++++++++++++++++++++---------------=
--------
 1 files changed, 127 insertions(+), 131 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 0edf19e..c22fe47 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -19,180 +19,176 @@ esac
=20
 echo 'define NO_SVN_TESTS to skip git-svn tests'
=20
-mkdir import
-cd import
-
-echo foo > foo
-if test -z "$NO_SYMLINK"
-then
-	ln -s foo foo.link
-fi
-mkdir -p dir/a/b/c/d/e
-echo 'deep dir' > dir/a/b/c/d/e/file
-mkdir -p bar
-echo 'zzz' > bar/zzz
-echo '#!/bin/sh' > exec.sh
-chmod +x exec.sh
-svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
-
-cd ..
-rm -rf import
-
 test_expect_success \
-    'initialize git-svn' \
-    "git-svn init $svnrepo"
+    'initialize git-svn' "
+	mkdir import &&
+	cd import &&
+	echo foo > foo &&
+	if test -z '$NO_SYMLINK'
+	then
+		ln -s foo foo.link
+	fi
+	mkdir -p dir/a/b/c/d/e &&
+	echo 'deep dir' > dir/a/b/c/d/e/file &&
+	mkdir bar &&
+	echo 'zzz' > bar/zzz &&
+	echo '#!/bin/sh' > exec.sh &&
+	chmod +x exec.sh &&
+	svn import -m 'import for git-svn' . $svnrepo >/dev/null &&
+	cd .. &&
+	rm -rf import &&
+	git-svn init $svnrepo"
=20
 test_expect_success \
     'import an SVN revision into git' \
     'git-svn fetch'
=20
-test_expect_success "checkout from svn" "svn co $svnrepo $SVN_TREE"
+test_expect_success "checkout from svn" "svn co $svnrepo '$SVN_TREE'"
=20
 name=3D'try a deep --rmdir with a commit'
-git checkout -f -b mybranch remotes/git-svn
-mv dir/a/b/c/d/e/file dir/file
-cp dir/file file
-git update-index --add --remove dir/a/b/c/d/e/file dir/file file
-git commit -m "$name"
-
-test_expect_success "$name" \
-    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch &&
-     svn up $SVN_TREE &&
-     test -d $SVN_TREE/dir && test ! -d $SVN_TREE/dir/a"
+test_expect_success "$name" "
+	git checkout -f -b mybranch remotes/git-svn &&
+	mv dir/a/b/c/d/e/file dir/file &&
+	cp dir/file file &&
+	git update-index --add --remove dir/a/b/c/d/e/file dir/file file &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch &&
+	svn up '$SVN_TREE' &&
+	test -d '$SVN_TREE'/dir && test ! -d '$SVN_TREE'/dir/a"
=20
=20
 name=3D'detect node change from file to directory #1'
-mkdir dir/new_file
-mv dir/file dir/new_file/file
-mv dir/new_file dir/file
-git update-index --remove dir/file
-git update-index --add dir/file/file
-git commit -m "$name"
-
-test_expect_failure "$name" \
-    'git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch' \
-    || true
+test_expect_failure "$name" "
+	mkdir dir/new_file &&
+	mv dir/file dir/new_file/file &&
+	mv dir/new_file dir/file &&
+	git update-index --remove dir/file &&
+	git update-index --add dir/file/file &&
+	git commit -m '$name'  &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch" || true
=20
=20
 name=3D'detect node change from directory to file #1'
-rm -rf dir $GIT_DIR/index
-git checkout -f -b mybranch2 remotes/git-svn
-mv bar/zzz zzz
-rm -rf bar
-mv zzz bar
-git update-index --remove -- bar/zzz
-git update-index --add -- bar
-git commit -m "$name"
-
-test_expect_failure "$name" \
-    'git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch2' \
-    || true
+test_expect_failure "$name" "
+	rm -rf dir '$GIT_DIR'/index &&
+	git checkout -f -b mybranch2 remotes/git-svn &&
+	mv bar/zzz zzz &&
+	rm -rf bar &&
+	mv zzz bar &&
+	git update-index --remove -- bar/zzz &&
+	git update-index --add -- bar &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch2" || true
=20
=20
 name=3D'detect node change from file to directory #2'
-rm -f $GIT_DIR/index
-git checkout -f -b mybranch3 remotes/git-svn
-rm bar/zzz
-git-update-index --remove bar/zzz
-mkdir bar/zzz
-echo yyy > bar/zzz/yyy
-git-update-index --add bar/zzz/yyy
-git commit -m "$name"
-
-test_expect_failure "$name" \
-    'git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch3' \
-    || true
+test_expect_failure "$name" "
+	rm -f '$GIT_DIR'/index &&
+	git checkout -f -b mybranch3 remotes/git-svn &&
+	rm bar/zzz &&
+	git-update-index --remove bar/zzz &&
+	mkdir bar/zzz &&
+	echo yyy > bar/zzz/yyy &&
+	git-update-index --add bar/zzz/yyy &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch3" || true
=20
=20
 name=3D'detect node change from directory to file #2'
-rm -f $GIT_DIR/index
-git checkout -f -b mybranch4 remotes/git-svn
-rm -rf dir
-git update-index --remove -- dir/file
-touch dir
-echo asdf > dir
-git update-index --add -- dir
-git commit -m "$name"
-
-test_expect_failure "$name" \
-    'git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch4' \
-    || true
+test_expect_failure "$name" "
+	rm -f '$GIT_DIR'/index &&
+	git checkout -f -b mybranch4 remotes/git-svn &&
+	rm -rf dir &&
+	git update-index --remove -- dir/file &&
+	touch dir &&
+	echo asdf > dir &&
+	git update-index --add -- dir &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch4" || true
=20
=20
 name=3D'remove executable bit from a file'
-rm -f $GIT_DIR/index
-git checkout -f -b mybranch5 remotes/git-svn
-chmod -x exec.sh
-git update-index exec.sh
-git commit -m "$name"
-
-test_expect_success "$name" \
-    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch5 &&
-     svn up $SVN_TREE &&
-     test ! -x $SVN_TREE/exec.sh"
+test_expect_success "$name" "
+	rm -f '$GIT_DIR'/index &&
+	git checkout -f -b mybranch5 remotes/git-svn &&
+	chmod -x exec.sh &&
+	git update-index exec.sh &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch5 &&
+	svn up '$SVN_TREE' &&
+	test ! -x '$SVN_TREE'/exec.sh"
=20
=20
 name=3D'add executable bit back file'
-chmod +x exec.sh
-git update-index exec.sh
-git commit -m "$name"
-
-test_expect_success "$name" \
-    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch5 &&
-     svn up $SVN_TREE &&
-     test -x $SVN_TREE/exec.sh"
-
+test_expect_success "$name" "
+	chmod +x exec.sh &&
+	git update-index exec.sh &&
+	git commit -m '$name' &&
+	git-svn set-tree --find-copies-harder --rmdir \
+		remotes/git-svn..mybranch5 &&
+	svn up '$SVN_TREE' &&
+	test -x '$SVN_TREE'/exec.sh"
=20
=20
 if test -z "$NO_SYMLINK"
 then
 	name=3D'executable file becomes a symlink to bar/zzz (file)'
-	rm exec.sh
-	ln -s bar/zzz exec.sh
-	git update-index exec.sh
-	git commit -m "$name"
=20
-	test_expect_success "$name" \
-	    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..m=
ybranch5 &&
-	     svn up $SVN_TREE &&
-	     test -L $SVN_TREE/exec.sh"
+	test_expect_success "$name" "
+		rm exec.sh &&
+		ln -s bar/zzz exec.sh &&
+		git update-index exec.sh &&
+		git commit -m '$name' &&
+		git-svn set-tree --find-copies-harder --rmdir \
+			remotes/git-svn..mybranch5 &&
+		svn up '$SVN_TREE' &&
+		test -L '$SVN_TREE'/exec.sh"
=20
 	name=3D'new symlink is added to a file that was also just made execut=
able'
-	chmod +x bar/zzz
-	ln -s bar/zzz exec-2.sh
-	git update-index --add bar/zzz exec-2.sh
-	git commit -m "$name"
=20
-	test_expect_success "$name" \
-	    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..m=
ybranch5 &&
-	     svn up $SVN_TREE &&
-	     test -x $SVN_TREE/bar/zzz &&
-	     test -L $SVN_TREE/exec-2.sh"
+	test_expect_success "$name" "
+		chmod +x bar/zzz &&
+		ln -s bar/zzz exec-2.sh &&
+		git update-index --add bar/zzz exec-2.sh &&
+		git commit -m '$name' &&
+		git-svn set-tree --find-copies-harder --rmdir \
+			remotes/git-svn..mybranch5 &&
+		svn up '$SVN_TREE' &&
+		test -x '$SVN_TREE'/bar/zzz &&
+		test -L '$SVN_TREE'/exec-2.sh"
=20
 	name=3D'modify a symlink to become a file'
-	echo git help > help || true
-	rm exec-2.sh
-	cp help exec-2.sh
-	git update-index exec-2.sh
-	git commit -m "$name"
-
-	test_expect_success "$name" \
-	    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..m=
ybranch5 &&
-	     svn up $SVN_TREE &&
-	     test -f $SVN_TREE/exec-2.sh &&
-	     test ! -L $SVN_TREE/exec-2.sh &&
-	     diff -u help $SVN_TREE/exec-2.sh"
+	test_expect_success "$name" "
+		echo git help > help || true &&
+		rm exec-2.sh &&
+		cp help exec-2.sh &&
+		git update-index exec-2.sh &&
+		git commit -m '$name' &&
+		git-svn set-tree --find-copies-harder --rmdir \
+			remotes/git-svn..mybranch5 &&
+		svn up '$SVN_TREE' &&
+		test -f '$SVN_TREE'/exec-2.sh &&
+		test ! -L '$SVN_TREE'/exec-2.sh &&
+		diff -u help $SVN_TREE/exec-2.sh"
 fi
=20
=20
 if test "$have_utf8" =3D t
 then
 	name=3D"commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
-	echo '# hello' >> exec-2.sh
-	git update-index exec-2.sh
-	git commit -m '=C3=A9=C3=AF=E2=88=8F'
-	export LC_ALL=3D"$GIT_SVN_LC_ALL"
-	test_expect_success "$name" "git-svn set-tree HEAD"
+	LC_ALL=3D"$GIT_SVN_LC_ALL"
+	export LC_ALL
+	test_expect_success "$name" "
+		echo '# hello' >> exec-2.sh &&
+		git update-index exec-2.sh &&
+		git commit -m '=C3=A9=C3=AF=E2=88=8F' &&
+		git-svn set-tree HEAD"
 	unset LC_ALL
 else
 	echo "UTF-8 locale not set, test skipped ($GIT_SVN_LC_ALL)"
--=20
1.4.4.3.gd4ada
