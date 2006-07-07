From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: migrate out of contrib
Date: Fri, 7 Jul 2006 03:03:05 -0700
Message-ID: <20060707100305.GA13767@soma>
References: <20060704215643.GA31763@localdomain> <11521700563472-git-send-email-normalperson@yhbt.net> <7v8xn64658.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 12:03:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FynB2-0000JB-GZ
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWGGKDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWGGKDI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:03:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:6072 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932102AbWGGKDH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 06:03:07 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7881C7DC021;
	Fri,  7 Jul 2006 03:03:05 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  7 Jul 2006 03:03:05 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xn64658.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23416>

Allow NO_SVN_TESTS to be defined to skip git-svn tests.  These
tests are time-consuming due to SVN being slow, and even more so
if SVN Perl libraries are not available.

Also added a check for SVN::Core so test 910[45] don't fail
if the user doesn't have those installed, thanks to Junio for
noticing this.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Junio C Hamano <junkio@cox.net> wrote:
 > Overall it looks good.
 > 
 > 9104 and 9105 fail when GIT_SVN_NO_LIB is unset and the
 > libsvn-*-perl is not available.  Maybe check this just like you
 > check and omit tests when svn or svnadmin is unavailable?

 Done.  While I was at it, I changed the test != to test -eq
 and brought the similarity below the threshold, which may
 make me want to expand on another patch...

 .gitignore                                         |    1 
 {contrib/git-svn => Documentation}/git-svn.txt     |    0 
 Makefile                                           |    6 ++-
 contrib/git-svn/.gitignore                         |    4 --
 contrib/git-svn/Makefile                           |   44 --------------------
 contrib/git-svn/git-svn.perl => git-svn.perl       |    2 -
 t/Makefile                                         |   10 +++++
 {contrib/git-svn/t => t}/lib-git-svn.sh            |   29 ++++++++-----
 .../t9100-git-svn-basic.sh                         |    4 ++
 .../t9101-git-svn-props.sh                         |    0 
 .../t9102-git-svn-deep-rmdir.sh                    |    0 
 .../t9103-git-svn-graft-branches.sh                |    0 
 .../t9104-git-svn-follow-parent.sh                 |    0 
 .../t9105-git-svn-commit-diff.sh                   |    0 
 14 files changed, 37 insertions(+), 63 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2bcc604..52d61f3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -107,6 +107,7 @@ git-ssh-push
 git-ssh-upload
 git-status
 git-stripspace
+git-svn
 git-svnimport
 git-symbolic-ref
 git-tag
diff --git a/contrib/git-svn/git-svn.txt b/Documentation/git-svn.txt
similarity index 100%
rename from contrib/git-svn/git-svn.txt
rename to Documentation/git-svn.txt
diff --git a/Makefile b/Makefile
index 202f261..a0e90c0 100644
--- a/Makefile
+++ b/Makefile
@@ -33,6 +33,10 @@ #
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
+# Define NO_SVN_TESTS if you want to skip time-consuming SVN interopability
+# tests.  These tests take up a significant amount of the total test time
+# but are not needed unless you plan to talk to SVN repos.
+#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -134,7 +138,7 @@ SCRIPT_PERL = \
 	git-shortlog.perl git-rerere.perl \
 	git-annotate.perl git-cvsserver.perl \
 	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl \
-	git-send-email.perl
+	git-send-email.perl git-svn.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
diff --git a/contrib/git-svn/.gitignore b/contrib/git-svn/.gitignore
deleted file mode 100644
index d8d87e3..0000000
--- a/contrib/git-svn/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-git-svn
-git-svn.xml
-git-svn.html
-git-svn.1
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
deleted file mode 100644
index 7c20946..0000000
--- a/contrib/git-svn/Makefile
+++ /dev/null
@@ -1,44 +0,0 @@
-all: git-svn
-
-prefix?=$(HOME)
-bindir=$(prefix)/bin
-mandir=$(prefix)/man
-man1=$(mandir)/man1
-INSTALL?=install
-doc_conf=../../Documentation/asciidoc.conf
--include ../../config.mak
-
-git-svn: git-svn.perl
-	cp $< $@
-	chmod +x $@
-
-install: all
-	$(INSTALL) -d -m755 $(DESTDIR)$(bindir)
-	$(INSTALL) git-svn $(DESTDIR)$(bindir)
-
-install-doc: doc
-	$(INSTALL) git-svn.1 $(DESTDIR)$(man1)
-
-doc: git-svn.1
-git-svn.1 : git-svn.xml
-	xmlto man git-svn.xml
-git-svn.xml : git-svn.txt
-	asciidoc -b docbook -d manpage \
-		-f ../../Documentation/asciidoc.conf $<
-git-svn.html : git-svn.txt
-	asciidoc -b xhtml11 -d manpage \
-		-f ../../Documentation/asciidoc.conf $<
-test: git-svn
-	cd t && for i in t????-*.sh; do $(SHELL) ./$$i $(TEST_FLAGS); done
-
-# we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
-full-test:
-	$(MAKE) test GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
-	$(MAKE) test GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
-	$(MAKE) test GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
-							LC_ALL=en_US.UTF-8
-	$(MAKE) test GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
-							LC_ALL=en_US.UTF-8
-
-clean:
-	rm -f git-svn *.xml *.html *.1
diff --git a/contrib/git-svn/git-svn.perl b/git-svn.perl
similarity index 100%
rename from contrib/git-svn/git-svn.perl
rename to git-svn.perl
index 8bc4188..145eaa8 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/git-svn.perl
@@ -8,7 +8,7 @@ use vars qw/	$AUTHOR $VERSION
 		$GIT_SVN_INDEX $GIT_SVN
 		$GIT_DIR $GIT_SVN_DIR $REVDB/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '1.1.1-broken';
+$VERSION = '@@GIT_VERSION@@';
 
 use Cwd qw/abs_path/;
 $GIT_DIR = abs_path($ENV{GIT_DIR} || '.git');
diff --git a/t/Makefile b/t/Makefile
index 632c55f..8983509 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -11,6 +11,7 @@ # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
+TSVN = $(wildcard t91[0-9][0-9]-*.sh)
 
 ifdef NO_PYTHON
 	GIT_TEST_OPTS += --no-python
@@ -24,6 +25,15 @@ all: $(T) clean
 clean:
 	rm -fr trash
 
+# we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
+full-svn-test:
+	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
+	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
+	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=1 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
+							LC_ALL=en_US.UTF-8
+	$(MAKE) $(TSVN) GIT_SVN_NO_LIB=0 GIT_SVN_NO_OPTIMIZE_COMMITS=0 \
+							LC_ALL=en_US.UTF-8
+
 .PHONY: $(T) clean
 .NOTPARALLEL:
 
diff --git a/contrib/git-svn/t/lib-git-svn.sh b/t/lib-git-svn.sh
similarity index 49%
rename from contrib/git-svn/t/lib-git-svn.sh
rename to t/lib-git-svn.sh
index d7f972a..29a1e72 100644
--- a/contrib/git-svn/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -1,30 +1,35 @@
-PATH=$PWD/../:$PATH
-if test -d ../../../t
+. ./test-lib.sh
+
+if test -n "$NO_SVN_TESTS"
 then
-    cd ../../../t
-else
-    echo "Must be run in contrib/git-svn/t" >&2
-    exit 1
+	test_expect_success 'skipping git-svn tests, NO_SVN_TESTS defined' :
+	test_done
+	exit
 fi
 
-. ./test-lib.sh
-
 GIT_DIR=$PWD/.git
 GIT_SVN_DIR=$GIT_DIR/svn/git-svn
 SVN_TREE=$GIT_SVN_DIR/svn-tree
 
+perl -e 'use SVN::Core' >/dev/null 2>&1
+if test $? -ne 0
+then
+   echo 'Perl SVN libraries not found, tests requiring those will be skipped'
+   GIT_SVN_NO_LIB=1
+fi
+
 svnadmin >/dev/null 2>&1
-if test $? != 1
+if test $? -ne 1
 then
-    test_expect_success 'skipping contrib/git-svn test' :
+    test_expect_success 'skipping git-svn tests, svnadmin not found' :
     test_done
     exit
 fi
 
 svn >/dev/null 2>&1
-if test $? != 1
+if test $? -ne 1
 then
-    test_expect_success 'skipping contrib/git-svn test' :
+    test_expect_success 'skipping git-svn tests, svn not found' :
     test_done
     exit
 fi
diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/t/t9100-git-svn-basic.sh
old mode 100644
new mode 100755
similarity index 98%
rename from contrib/git-svn/t/t0000-contrib-git-svn.sh
rename to t/t9100-git-svn-basic.sh
index b482bb6..bf1d638
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -3,7 +3,7 @@ #
 # Copyright (c) 2006 Eric Wong
 #
 
-test_description='git-svn tests'
+test_description='git-svn basic tests'
 GIT_SVN_LC_ALL=$LC_ALL
 
 case "$LC_ALL" in
@@ -17,6 +17,8 @@ esac
 
 . ./lib-git-svn.sh
 
+echo 'define NO_SVN_TESTS to skip git-svn tests'
+
 mkdir import
 cd import
 
diff --git a/contrib/git-svn/t/t0001-contrib-git-svn-props.sh b/t/t9101-git-svn-props.sh
old mode 100644
new mode 100755
similarity index 100%
rename from contrib/git-svn/t/t0001-contrib-git-svn-props.sh
rename to t/t9101-git-svn-props.sh
diff --git a/contrib/git-svn/t/t0002-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
old mode 100644
new mode 100755
similarity index 100%
rename from contrib/git-svn/t/t0002-deep-rmdir.sh
rename to t/t9102-git-svn-deep-rmdir.sh
diff --git a/contrib/git-svn/t/t0003-graft-branches.sh b/t/t9103-git-svn-graft-branches.sh
old mode 100644
new mode 100755
similarity index 100%
rename from contrib/git-svn/t/t0003-graft-branches.sh
rename to t/t9103-git-svn-graft-branches.sh
diff --git a/contrib/git-svn/t/t0004-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
old mode 100644
new mode 100755
similarity index 100%
rename from contrib/git-svn/t/t0004-follow-parent.sh
rename to t/t9104-git-svn-follow-parent.sh
diff --git a/contrib/git-svn/t/t0005-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
old mode 100644
new mode 100755
similarity index 100%
rename from contrib/git-svn/t/t0005-commit-diff.sh
rename to t/t9105-git-svn-commit-diff.sh
-- 
1.4.1.g3dc65
