From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 8/9] contrib/git-svn: add Makefile, test, and associated ignores
Date: Mon, 20 Feb 2006 10:57:29 -0800
Message-ID: <11404618491275-git-send-email-normalperson@yhbt.net>
References: <11404618483587-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:59:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGER-0001UO-2n
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWBTS5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWBTS5h
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60859 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932634AbWBTS5a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:30 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 41B9A2DC097;
	Mon, 20 Feb 2006 10:57:29 -0800 (PST)
In-Reply-To: <11404618483587-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16497>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/.gitignore                 |    4 +
 contrib/git-svn/Makefile                   |   32 ++++
 contrib/git-svn/git-svn.perl               |    0 
 contrib/git-svn/t/t0000-contrib-git-svn.sh |  216 ++++++++++++++++++++++++++++
 4 files changed, 252 insertions(+), 0 deletions(-)
 create mode 100644 contrib/git-svn/.gitignore
 create mode 100644 contrib/git-svn/Makefile
 rename contrib/git-svn/{git-svn => git-svn.perl} (100%)
 create mode 100644 contrib/git-svn/t/t0000-contrib-git-svn.sh

1f5de0dcbe26fedb3236c437808d2cb20ab282c1
diff --git a/contrib/git-svn/.gitignore b/contrib/git-svn/.gitignore
new file mode 100644
index 0000000..d8d87e3
--- /dev/null
+++ b/contrib/git-svn/.gitignore
@@ -0,0 +1,4 @@
+git-svn
+git-svn.xml
+git-svn.html
+git-svn.1
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
new file mode 100644
index 0000000..a330c61
--- /dev/null
+++ b/contrib/git-svn/Makefile
@@ -0,0 +1,32 @@
+all: git-svn
+
+prefix?=$(HOME)
+bindir=$(prefix)/bin
+mandir=$(prefix)/man
+man1=$(mandir)/man1
+INSTALL?=install
+doc_conf=../../Documentation/asciidoc.conf
+-include ../../config.mak
+
+git-svn: git-svn.perl
+	cp $< $@
+	chmod +x $@
+
+install: all
+	$(INSTALL) -d -m755 $(DESTDIR)$(bindir)
+	$(INSTALL) git-svn $(DESTDIR)$(bindir)
+
+install-doc: doc
+	$(INSTALL) git-svn.1 $(DESTDIR)$(man1)
+
+doc: git-svn.1
+git-svn.1 : git-svn.xml
+	xmlto man git-svn.xml
+git-svn.xml : git-svn.txt
+	asciidoc -b docbook -d manpage \
+		-f ../../Documentation/asciidoc.conf $<
+test:
+	cd t && $(SHELL) ./t0000-contrib-git-svn.sh
+
+clean:
+	rm -f git-svn *.xml *.html *.1
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn.perl
similarity index 100%
rename from contrib/git-svn/git-svn
rename to contrib/git-svn/git-svn.perl
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-svn/t/t0000-contrib-git-svn.sh
new file mode 100644
index 0000000..181dfe0
--- /dev/null
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -0,0 +1,216 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+#
+
+
+PATH=$PWD/../:$PATH
+test_description='git-svn tests'
+if test -d ../../../t
+then
+    cd ../../../t
+else
+    echo "Must be run in contrib/git-svn/t" >&2
+    exit 1
+fi
+
+. ./test-lib.sh
+
+GIT_DIR=$PWD/.git
+GIT_SVN_DIR=$GIT_DIR/git-svn
+SVN_TREE=$GIT_SVN_DIR/tree
+
+svnadmin >/dev/null 2>&1
+if test $? != 1
+then
+    test_expect_success 'skipping contrib/git-svn test' :
+    test_done
+    exit
+fi
+
+svn >/dev/null 2>&1
+if test $? != 1
+then
+    test_expect_success 'skipping contrib/git-svn test' :
+    test_done
+    exit
+fi
+
+svnrepo=$PWD/svnrepo
+
+set -e
+
+svnadmin create $svnrepo
+svnrepo="file://$svnrepo/test-git-svn"
+
+mkdir import
+
+cd import
+
+echo foo > foo
+ln -s foo foo.link
+mkdir -p dir/a/b/c/d/e
+echo 'deep dir' > dir/a/b/c/d/e/file
+mkdir -p bar
+echo 'zzz' > bar/zzz
+echo '#!/bin/sh' > exec.sh
+chmod +x exec.sh
+svn import -m 'import for git-svn' . $svnrepo >/dev/null
+
+cd ..
+
+rm -rf import
+
+test_expect_success \
+    'initialize git-svn' \
+    "git-svn init $svnrepo"
+
+test_expect_success \
+    'import an SVN revision into git' \
+    'git-svn fetch'
+
+
+name='try a deep --rmdir with a commit'
+git checkout -b mybranch git-svn-HEAD
+mv dir/a/b/c/d/e/file dir/file
+cp dir/file file
+git update-index --add --remove dir/a/b/c/d/e/file dir/file file
+git commit -m "$name"
+
+test_expect_success "$name" \
+    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch &&
+     test -d $SVN_TREE/dir && test ! -d $SVN_TREE/dir/a"
+
+
+name='detect node change from file to directory #1'
+mkdir dir/new_file
+mv dir/file dir/new_file/file
+mv dir/new_file dir/file
+git update-index --remove dir/file
+git update-index --add dir/file/file
+git commit -m "$name"
+
+test_expect_code 1 "$name" \
+    'git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch' \
+    || true
+
+
+name='detect node change from directory to file #1'
+rm -rf dir $GIT_DIR/index
+git checkout -b mybranch2 git-svn-HEAD
+mv bar/zzz zzz
+rm -rf bar
+mv zzz bar
+git update-index --remove -- bar/zzz
+git update-index --add -- bar
+git commit -m "$name"
+
+test_expect_code 1 "$name" \
+    'git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch2' \
+    || true
+
+
+name='detect node change from file to directory #2'
+rm -f $GIT_DIR/index
+git checkout -b mybranch3 git-svn-HEAD
+rm bar/zzz
+git-update-index --remove bar/zzz
+mkdir bar/zzz
+echo yyy > bar/zzz/yyy
+git-update-index --add bar/zzz/yyy
+git commit -m "$name"
+
+test_expect_code 1 "$name" \
+    'git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch3' \
+    || true
+
+
+name='detect node change from directory to file #2'
+rm -f $GIT_DIR/index
+git checkout -b mybranch4 git-svn-HEAD
+rm -rf dir
+git update-index --remove -- dir/file
+touch dir
+echo asdf > dir
+git update-index --add -- dir
+git commit -m "$name"
+
+test_expect_code 1 "$name" \
+    'git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch4' \
+    || true
+
+
+name='remove executable bit from a file'
+rm -f $GIT_DIR/index
+git checkout -b mybranch5 git-svn-HEAD
+chmod -x exec.sh
+git update-index exec.sh
+git commit -m "$name"
+
+test_expect_success "$name" \
+    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+     test ! -x $SVN_TREE/exec.sh"
+
+
+name='add executable bit back file'
+chmod +x exec.sh
+git update-index exec.sh
+git commit -m "$name"
+
+test_expect_success "$name" \
+    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+     test -x $SVN_TREE/exec.sh"
+
+
+
+name='executable file becomes a symlink to bar/zzz (file)'
+rm exec.sh
+ln -s bar/zzz exec.sh
+git update-index exec.sh
+git commit -m "$name"
+
+test_expect_success "$name" \
+    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+     test -L $SVN_TREE/exec.sh"
+
+
+
+name='new symlink is added to a file that was also just made executable'
+chmod +x bar/zzz
+ln -s bar/zzz exec-2.sh
+git update-index --add bar/zzz exec-2.sh
+git commit -m "$name"
+
+test_expect_success "$name" \
+    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+     test -x $SVN_TREE/bar/zzz &&
+     test -L $SVN_TREE/exec-2.sh"
+
+
+
+name='modify a symlink to become a file'
+git help > help || true
+rm exec-2.sh
+cp help exec-2.sh
+git update-index exec-2.sh
+git commit -m "$name"
+
+test_expect_success "$name" \
+    "git-svn commit --find-copies-harder --rmdir git-svn-HEAD..mybranch5 &&
+     test -f $SVN_TREE/exec-2.sh &&
+     test ! -L $SVN_TREE/exec-2.sh &&
+     diff -u help $SVN_TREE/exec-2.sh"
+
+
+
+name='test fetch functionality (svn => git) with alternate GIT_SVN_ID'
+GIT_SVN_ID=alt
+export GIT_SVN_ID
+test_expect_success "$name" \
+    "git-svn init $svnrepo && git-svn fetch -v &&
+     git-rev-list --pretty=raw git-svn-HEAD | grep ^tree | uniq > a &&
+     git-rev-list --pretty=raw alt-HEAD | grep ^tree | uniq > b &&
+     diff -u a b"
+
+test_done
+
-- 
1.2.0.gdee6
