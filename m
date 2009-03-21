From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 10/16] Use prerequisite tags to skip tests that depend on symbolic links
Date: Sat, 21 Mar 2009 22:26:33 +0100
Message-ID: <a79bfc08b7d2d08498ff48223ddd51e3cefa37e5.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8lk-0004Ii-Iu
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbZCUV1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755617AbZCUV1m
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27964 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401AbZCUV1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:27:00 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DB52ECDF89;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 882375BBF4;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114073>

Many tests depend on that symbolic links work.  This introduces a check
that sets the prerequisite tag SYMLINKS if the file system supports
symbolic links.  Since so many tests have to check for this prerequisite,
we do the check in test-lib.sh, so that we don't need to repeat the test
in many scripts.

To check for 'ln -s' failures, you can use a FAT partition on Linux:

$ mkdosfs -C git-on-fat 1000000
$ sudo mount -o loop,uid=j6t,gid=users,shortname=winnt git-on-fat /mnt

Clone git to /mnt and

$ GIT_SKIP_TESTS='t0001.1[34] t0010 t1301 t403[34] t4129.[47] t5701.7
          t7701.3 t9100 t9101.26 t9119 t9124.[67] t9200.10 t9600.6' \
        make test

(These additionally skipped tests depend on POSIX permissions that FAT on
Linux does not provide.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0000-basic.sh                       |   43 +++++++++++++++++++++++---------
 t/t0055-beyond-symlinks.sh             |    6 ++--
 t/t1004-read-tree-m-u-wf.sh            |    6 ++--
 t/t1020-subdirectory.sh                |    2 +-
 t/t1300-repo-config.sh                 |    2 +-
 t/t2001-checkout-cache-clash.sh        |    6 ++--
 t/t2003-checkout-cache-mkdir.sh        |    8 +++---
 t/t2004-checkout-cache-temp.sh         |    2 +-
 t/t2007-checkout-symlink.sh            |    6 ++++
 t/t2100-update-cache-badpath.sh        |   14 +++++++++-
 t/t2200-add-update.sh                  |    2 +-
 t/t2201-add-update-typechange.sh       |   16 +++++++++--
 t/t2300-cd-to-toplevel.sh              |   14 +++++-----
 t/t3000-ls-files-others.sh             |    7 ++++-
 t/t3010-ls-files-killed-modified.sh    |   17 ++++++++++--
 t/t3100-ls-tree-restrict.sh            |   40 +++++++++++++++++++----------
 t/t3200-branch.sh                      |    2 +-
 t/t3700-add.sh                         |    6 ++--
 t/t4004-diff-rename-symlink.sh         |    7 +++++
 t/t4008-diff-break-rewrite.sh          |    8 +++---
 t/t4011-diff-symlink.sh                |    7 +++++
 t/t4023-diff-rename-typechange.sh      |    7 +++++
 t/t4114-apply-typechange.sh            |    7 +++++
 t/t4115-apply-symlink.sh               |    7 +++++
 t/t4122-apply-symlink-inside.sh        |    7 +++++
 t/t5000-tar-tree.sh                    |    6 +++-
 t/t5522-pull-symlink.sh                |    7 +++++
 t/t7001-mv.sh                          |    4 +-
 t/t9131-git-svn-empty-symlink.sh       |    2 +-
 t/t9132-git-svn-broken-symlink.sh      |    4 +-
 t/t9500-gitweb-standalone-no-errors.sh |   11 ++++++--
 t/test-lib.sh                          |    4 +++
 32 files changed, 211 insertions(+), 76 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index c53de1f..f4ca4fc 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -115,12 +115,31 @@ test_expect_success \
     'test "$tree" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904'
 
 # Various types of objects
+# Some filesystems do not support symblic links; on such systems
+# some expected values are different
 mkdir path2 path3 path3/subp3
-for p in path0 path2/file2 path3/file3 path3/subp3/file3
+paths='path0 path2/file2 path3/file3 path3/subp3/file3'
+for p in $paths
 do
     echo "hello $p" >$p
-    ln -s "hello $p" ${p}sym
 done
+if test_have_prereq SYMLINKS
+then
+	for p in $paths
+	do
+		ln -s "hello $p" ${p}sym
+	done
+	expectfilter=cat
+	expectedtree=087704a96baf1c2d1c869a8b084481e121c88b5b
+	expectedptree1=21ae8269cacbe57ae09138dcc3a2887f904d02b3
+	expectedptree2=3c5e5399f3a333eddecce7a9b9465b63f65f51e2
+else
+	expectfilter='grep -v sym'
+	expectedtree=8e18edf7d7edcf4371a3ac6ae5f07c2641db7c46
+	expectedptree1=cfb8591b2f65de8b8cc1020cd7d9e67e7793b325
+	expectedptree2=ce580448f0148b985a513b693fdf7d802cacb44f
+fi
+
 test_expect_success \
     'adding various types of objects with git update-index --add.' \
     'find path* ! -type d -print | xargs git update-index --add'
@@ -130,7 +149,7 @@ test_expect_success \
     'showing stage with git ls-files --stage' \
     'git ls-files --stage >current'
 
-cat >expected <<\EOF
+$expectfilter >expected <<\EOF
 100644 f87290f8eb2cbbea7857214459a0739927eab154 0	path0
 120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0	path0sym
 100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0	path2/file2
@@ -149,7 +168,7 @@ test_expect_success \
     'tree=$(git write-tree)'
 test_expect_success \
     'validate object ID for a known tree.' \
-    'test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b'
+    'test "$tree" = "$expectedtree"'
 
 test_expect_success \
     'showing tree with git ls-tree' \
@@ -160,7 +179,7 @@ cat >expected <<\EOF
 040000 tree 58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
 040000 tree 21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
 EOF
-test_expect_success \
+test_expect_success SYMLINKS \
     'git ls-tree output for a known tree.' \
     'test_cmp expected current'
 
@@ -169,7 +188,7 @@ test_expect_success \
 test_expect_success \
     'showing tree with git ls-tree -r' \
     'git ls-tree -r $tree >current'
-cat >expected <<\EOF
+$expectfilter >expected <<\EOF
 100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
 120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
 100644 blob 3feff949ed00a62d9f7af97c15cd8a30595e7ac7	path2/file2
@@ -200,7 +219,7 @@ cat >expected <<\EOF
 100644 blob 00fb5908cb97c2564a9783c0c64087333b3b464f	path3/subp3/file3
 120000 blob 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c	path3/subp3/file3sym
 EOF
-test_expect_success \
+test_expect_success SYMLINKS \
     'git ls-tree -r output for a known tree.' \
     'test_cmp expected current'
 
@@ -209,14 +228,14 @@ test_expect_success \
     'ptree=$(git write-tree --prefix=path3)'
 test_expect_success \
     'validate object ID for a known tree.' \
-    'test "$ptree" = 21ae8269cacbe57ae09138dcc3a2887f904d02b3'
+    'test "$ptree" = "$expectedptree1"'
 
 test_expect_success \
     'writing partial tree out with git write-tree --prefix.' \
     'ptree=$(git write-tree --prefix=path3/subp3)'
 test_expect_success \
     'validate object ID for a known tree.' \
-    'test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2'
+    'test "$ptree" = "$expectedptree2"'
 
 cat >badobjects <<EOF
 100644 blob 1000000000000000000000000000000000000000	dir/file1
@@ -249,7 +268,7 @@ test_expect_success \
      newtree=$(git write-tree) &&
      test "$newtree" = "$tree"'
 
-cat >expected <<\EOF
+$expectfilter >expected <<\EOF
 :100644 100644 f87290f8eb2cbbea7857214459a0739927eab154 0000000000000000000000000000000000000000 M	path0
 :120000 120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0000000000000000000000000000000000000000 M	path0sym
 :100644 100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0000000000000000000000000000000000000000 M	path2/file2
@@ -272,7 +291,7 @@ test_expect_success \
     'git diff-files >current && cmp -s current /dev/null'
 
 ################################################################
-P=087704a96baf1c2d1c869a8b084481e121c88b5b
+P=$expectedtree
 test_expect_success \
     'git commit-tree records the correct tree in a commit.' \
     'commit0=$(echo NO | git commit-tree $P) &&
@@ -308,7 +327,7 @@ test_expect_success 'update-index D/F conflict' '
 	test $numpath0 = 1
 '
 
-test_expect_success 'absolute path works as expected' '
+test_expect_success SYMLINKS 'absolute path works as expected' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
 	mkdir second &&
diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
index b29c37a..0c6ff56 100755
--- a/t/t0055-beyond-symlinks.sh
+++ b/t/t0055-beyond-symlinks.sh
@@ -4,7 +4,7 @@ test_description='update-index and add refuse to add beyond symlinks'
 
 . ./test-lib.sh
 
-test_expect_success setup '
+test_expect_success SYMLINKS setup '
 	>a &&
 	mkdir b &&
 	ln -s b c &&
@@ -12,12 +12,12 @@ test_expect_success setup '
 	git update-index --add a b/d
 '
 
-test_expect_success 'update-index --add beyond symlinks' '
+test_expect_success SYMLINKS 'update-index --add beyond symlinks' '
 	test_must_fail git update-index --add c/d &&
 	! ( git ls-files | grep c/d )
 '
 
-test_expect_success 'add beyond symlinks' '
+test_expect_success SYMLINKS 'add beyond symlinks' '
 	test_must_fail git add c/d &&
 	! ( git ls-files | grep c/d )
 '
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 570d372..f19b4a2 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -157,7 +157,7 @@ test_expect_success '3-way not overwriting local changes (their side)' '
 
 '
 
-test_expect_success 'funny symlink in work tree' '
+test_expect_success SYMLINKS 'funny symlink in work tree' '
 
 	git reset --hard &&
 	git checkout -b sym-b side-b &&
@@ -177,7 +177,7 @@ test_expect_success 'funny symlink in work tree' '
 
 '
 
-test_expect_success 'funny symlink in work tree, un-unlink-able' '
+test_expect_success SYMLINKS 'funny symlink in work tree, un-unlink-able' '
 
 	rm -fr a b &&
 	git reset --hard &&
@@ -189,7 +189,7 @@ test_expect_success 'funny symlink in work tree, un-unlink-able' '
 '
 
 # clean-up from the above test
-chmod a+w a
+chmod a+w a 2>/dev/null
 rm -fr a b
 
 test_expect_success 'D/F setup' '
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index fc386ba..210e594 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -126,7 +126,7 @@ test_expect_success 'no file/rev ambiguity check inside a bare repo' '
 	cd foo.git && git show -s HEAD
 '
 
-test_expect_success 'detection should not be fooled by a symlink' '
+test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
 	cd "$HERE" &&
 	rm -fr foo.git &&
 	git clone -s .git another &&
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3c06842..64663e1 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -726,7 +726,7 @@ echo >>result
 
 test_expect_success '--null --get-regexp' 'cmp result expect'
 
-test_expect_success 'symlinked configuration' '
+test_expect_success SYMLINKS 'symlinked configuration' '
 
 	ln -s notyet myconfig &&
 	GIT_CONFIG=myconfig git config test.frotz nitfol &&
diff --git a/t/t2001-checkout-cache-clash.sh b/t/t2001-checkout-cache-clash.sh
index ef00753..98aa73e 100755
--- a/t/t2001-checkout-cache-clash.sh
+++ b/t/t2001-checkout-cache-clash.sh
@@ -59,10 +59,10 @@ test_expect_success \
     'git read-tree -m $tree1 && git checkout-index -f -a'
 test_debug 'show_files $tree1'
 
-ln -s path0 path1
-test_expect_success \
+test_expect_success SYMLINKS \
     'git update-index --add a symlink.' \
-    'git update-index --add path1'
+    'ln -s path0 path1 &&
+     git update-index --add path1'
 test_expect_success \
     'writing tree out with git write-tree' \
     'tree3=$(git write-tree)'
diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index 71894b3..02a4fc5 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -19,7 +19,7 @@ test_expect_success \
     echo rezrov >path1/file1 &&
     git update-index --add path0 path1/file1'
 
-test_expect_success \
+test_expect_success SYMLINKS \
     'have symlink in place where dir is expected.' \
     'rm -fr path0 path1 &&
      mkdir path2 &&
@@ -59,7 +59,7 @@ test_expect_success \
      test ! -f path1/file1'
 
 # Linus fix #1
-test_expect_success \
+test_expect_success SYMLINKS \
     'use --prefix=tmp/orary/ where tmp is a symlink' \
     'rm -fr path0 path1 path2 tmp* &&
      mkdir tmp1 tmp1/orary &&
@@ -71,7 +71,7 @@ test_expect_success \
      test -h tmp'
 
 # Linus fix #2
-test_expect_success \
+test_expect_success SYMLINKS \
     'use --prefix=tmp/orary- where tmp is a symlink' \
     'rm -fr path0 path1 path2 tmp* &&
      mkdir tmp1 &&
@@ -82,7 +82,7 @@ test_expect_success \
      test -h tmp'
 
 # Linus fix #3
-test_expect_success \
+test_expect_success SYMLINKS \
     'use --prefix=tmp- where tmp-path1 is a symlink' \
     'rm -fr path0 path1 path2 tmp* &&
      mkdir tmp1 &&
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 39133b8..36cca14 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -194,7 +194,7 @@ test_expect_success \
  test $(cat ../$s1) = tree1asubdir/path5)
 )'
 
-test_expect_success \
+test_expect_success SYMLINKS \
 'checkout --temp symlink' '
 rm -f path* .merge_* out .git/index &&
 ln -s b a &&
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 0526fce..20f3343 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -6,6 +6,12 @@ test_description='git checkout to switch between branches with symlink<->dir'
 
 . ./test-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	say "symbolic links not supported - skipping tests"
+	test_done
+fi
+
 test_expect_success setup '
 
 	mkdir frotz &&
diff --git a/t/t2100-update-cache-badpath.sh b/t/t2100-update-cache-badpath.sh
index 6ef2dcf..2df3fdd 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -26,7 +26,12 @@ All of the attempts should fail.
 
 mkdir path2 path3
 date >path0
-ln -s xyzzy path1
+if test_have_prereq SYMLINKS
+then
+	ln -s xyzzy path1
+else
+	date > path1
+fi
 date >path2/file2
 date >path3/file3
 
@@ -38,7 +43,12 @@ rm -fr path?
 
 mkdir path0 path1
 date >path2
-ln -s frotz path3
+if test_have_prereq SYMLINKS
+then
+	ln -s frotz path3
+else
+	date > path3
+fi
 date >path0/file0
 date >path1/file1
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 5a8d52f..9120750 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -80,7 +80,7 @@ test_expect_success 'change gets noticed' '
 
 '
 
-test_expect_success 'replace a file with a symlink' '
+test_expect_success SYMLINKS 'replace a file with a symlink' '
 
 	rm foo &&
 	ln -s top foo &&
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index d24c7d9..2e8f702 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -11,7 +11,13 @@ test_expect_success setup '
 	_empty=$(git hash-object --stdin <xyzzy) &&
 	>yomin &&
 	>caskly &&
-	ln -s frotz nitfol &&
+	if test_have_prereq SYMLINKS; then
+		ln -s frotz nitfol &&
+		T_letter=T
+	else
+		printf %s frotz > nitfol &&
+		T_letter=M
+	fi &&
 	mkdir rezrov &&
 	>rezrov/bozbar &&
 	git add caskly xyzzy yomin nitfol rezrov/bozbar &&
@@ -29,7 +35,11 @@ test_expect_success modify '
 	>nitfol &&
 	# rezrov/bozbar disappears
 	rm -fr rezrov &&
-	ln -s xyzzy rezrov &&
+	if test_have_prereq SYMLINKS; then
+		ln -s xyzzy rezrov
+	else
+		printf %s xyzzy > rezrov
+	fi &&
 	# xyzzy disappears (not a submodule)
 	mkdir xyzzy &&
 	echo gnusto >xyzzy/bozbar &&
@@ -71,7 +81,7 @@ test_expect_success modify '
 				s/blob/000000/
 			}
 			/	nitfol/{
-				s/	nitfol/ $_z40 T&/
+				s/	nitfol/ $_z40 $T_letter&/
 				s/blob/100644/
 			}
 			/	rezrov.bozbar/{
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index 293dc35..3b01ad2 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -5,7 +5,7 @@ test_description='cd_to_toplevel'
 . ./test-lib.sh
 
 test_cd_to_toplevel () {
-	test_expect_success "$2" '
+	test_expect_success $3 "$2" '
 		(
 			cd '"'$1'"' &&
 			. git-sh-setup &&
@@ -24,14 +24,14 @@ test_cd_to_toplevel repo 'at physical root'
 
 test_cd_to_toplevel repo/sub/dir 'at physical subdir'
 
-ln -s repo symrepo
-test_cd_to_toplevel symrepo 'at symbolic root'
+ln -s repo symrepo 2>/dev/null
+test_cd_to_toplevel symrepo 'at symbolic root' SYMLINKS
 
-ln -s repo/sub/dir subdir-link
-test_cd_to_toplevel subdir-link 'at symbolic subdir'
+ln -s repo/sub/dir subdir-link 2>/dev/null
+test_cd_to_toplevel subdir-link 'at symbolic subdir' SYMLINKS
 
 cd repo
-ln -s sub/dir internal-link
-test_cd_to_toplevel internal-link 'at internal symbolic subdir'
+ln -s sub/dir internal-link 2>/dev/null
+test_cd_to_toplevel internal-link 'at internal symbolic subdir' SYMLINKS
 
 test_done
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 36eee0f..b7e0306 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -17,7 +17,12 @@ filesystem.
 . ./test-lib.sh
 
 date >path0
-ln -s xyzzy path1
+if test_have_prereq SYMLINKS
+then
+	ln -s xyzzy path1
+else
+	date > path1
+fi
 mkdir path2 path3
 date >path2/file2
 date >path2-junk
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index e4f02a0..95671c2 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -38,7 +38,12 @@ modified without reporting path9 and path10.
 . ./test-lib.sh
 
 date >path0
-ln -s xyzzy path1
+if test_have_prereq SYMLINKS
+then
+	ln -s xyzzy path1
+else
+	date > path1
+fi
 mkdir path2 path3
 date >path2/file2
 date >path3/file3
@@ -52,8 +57,14 @@ test_expect_success \
 
 rm -fr path? ;# leave path10 alone
 date >path2
-ln -s frotz path3
-ln -s nitfol path5
+if test_have_prereq SYMLINKS
+then
+	ln -s frotz path3
+	ln -s nitfol path5
+else
+	date > path3
+	date > path5
+fi
 mkdir path0 path1 path6
 date >path0/file0
 date >path1/file1
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 6e6a254..ee60d03 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -22,9 +22,21 @@ test_expect_success \
     'setup' \
     'mkdir path2 path2/baz &&
      echo Hi >path0 &&
-     ln -s path0 path1 &&
+     if test_have_prereq SYMLINKS
+     then
+	ln -s path0 path1 &&
+	ln -s ../path1 path2/bazbo
+	make_expected () {
+		cat >expected
+	}
+     else
+	printf path0 > path1 &&
+	printf ../path1 > path2/bazbo
+	make_expected () {
+		sed -e "s/120000 /100644 /" >expected
+	}
+     fi &&
      echo Lo >path2/foo &&
-     ln -s ../path1 path2/bazbo &&
      echo Mi >path2/baz/b &&
      find path? \( -type f -o -type l \) -print |
      xargs git update-index --add &&
@@ -41,7 +53,7 @@ test_output () {
 test_expect_success \
     'ls-tree plain' \
     'git ls-tree $tree >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 100644 blob X	path0
 120000 blob X	path1
 040000 tree X	path2
@@ -51,7 +63,7 @@ EOF
 test_expect_success \
     'ls-tree recursive' \
     'git ls-tree -r $tree >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 100644 blob X	path0
 120000 blob X	path1
 100644 blob X	path2/baz/b
@@ -63,7 +75,7 @@ EOF
 test_expect_success \
     'ls-tree recursive with -t' \
     'git ls-tree -r -t $tree >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 100644 blob X	path0
 120000 blob X	path1
 040000 tree X	path2
@@ -77,7 +89,7 @@ EOF
 test_expect_success \
     'ls-tree recursive with -d' \
     'git ls-tree -r -d $tree >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 040000 tree X	path2
 040000 tree X	path2/baz
 EOF
@@ -86,7 +98,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path' \
     'git ls-tree $tree path >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 EOF
      test_output'
 
@@ -96,7 +108,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path1 path0' \
     'git ls-tree $tree path1 path0 >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 100644 blob X	path0
 120000 blob X	path1
 EOF
@@ -105,7 +117,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path0/' \
     'git ls-tree $tree path0/ >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 EOF
      test_output'
 
@@ -114,7 +126,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path2' \
     'git ls-tree $tree path2 >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 040000 tree X	path2
 EOF
      test_output'
@@ -123,7 +135,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path2/' \
     'git ls-tree $tree path2/ >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 040000 tree X	path2/baz
 120000 blob X	path2/bazbo
 100644 blob X	path2/foo
@@ -135,7 +147,7 @@ EOF
 test_expect_success \
     'ls-tree filtered with path2/baz' \
     'git ls-tree $tree path2/baz >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 040000 tree X	path2/baz
 EOF
      test_output'
@@ -143,14 +155,14 @@ EOF
 test_expect_success \
     'ls-tree filtered with path2/bak' \
     'git ls-tree $tree path2/bak >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 EOF
      test_output'
 
 test_expect_success \
     'ls-tree -t filtered with path2/bak' \
     'git ls-tree -t $tree path2/bak >current &&
-     cat >expected <<\EOF &&
+     make_expected <<\EOF &&
 040000 tree X	path2
 EOF
      test_output'
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 61a2010..f82bcdb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -121,7 +121,7 @@ test_expect_success 'renaming a symref is not allowed' \
 	! test -f .git/refs/heads/master3
 '
 
-test_expect_success \
+test_expect_success SYMLINKS \
     'git branch -m u v should fail when the reflog for u is a symlink' '
      git branch -l u &&
      mv .git/logs/refs/heads/u real-u &&
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 9f6454d..e98f982 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -30,7 +30,7 @@ test_expect_success \
 	 *) echo fail; git ls-files --stage xfoo1; (exit 1);;
 	 esac'
 
-test_expect_success 'git add: filemode=0 should not get confused by symlink' '
+test_expect_success SYMLINKS 'git add: filemode=0 should not get confused by symlink' '
 	rm -f xfoo1 &&
 	ln -s foo xfoo1 &&
 	git add xfoo1 &&
@@ -51,7 +51,7 @@ test_expect_success \
 	 *) echo fail; git ls-files --stage xfoo2; (exit 1);;
 	 esac'
 
-test_expect_success 'git add: filemode=0 should not get confused by symlink' '
+test_expect_success SYMLINKS 'git add: filemode=0 should not get confused by symlink' '
 	rm -f xfoo2 &&
 	ln -s foo xfoo2 &&
 	git update-index --add xfoo2 &&
@@ -61,7 +61,7 @@ test_expect_success 'git add: filemode=0 should not get confused by symlink' '
 	esac
 '
 
-test_expect_success \
+test_expect_success SYMLINKS \
 	'git update-index --add: Test that executable bit is not used...' \
 	'git config core.filemode 0 &&
 	 ln -s xfoo2 xfoo3 &&
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index b35af9b..3db7444 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -12,6 +12,13 @@ by an edit for them.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	say 'Symbolic links not supported, skipping tests.'
+	test_done
+	exit
+fi
+
 test_expect_success \
     'prepare reference tree' \
     'echo xyzzy | tr -d '\\\\'012 >yomin &&
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 7e343a9..e19ca65 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -99,7 +99,7 @@ test_expect_success \
     'validate result of -B -M (#4)' \
     'compare_diff_raw expected current'
 
-test_expect_success \
+test_expect_success SYMLINKS \
     'make file0 into something completely different' \
     'rm -f file0 &&
      ln -s frotz file0 &&
@@ -114,7 +114,7 @@ cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M100	file1
 EOF
 
-test_expect_success \
+test_expect_success SYMLINKS \
     'validate result of -B (#5)' \
     'compare_diff_raw expected current'
 
@@ -129,7 +129,7 @@ cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 R	file0	file1
 EOF
 
-test_expect_success \
+test_expect_success SYMLINKS \
     'validate result of -B -M (#6)' \
     'compare_diff_raw expected current'
 
@@ -144,7 +144,7 @@ cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M	file1
 EOF
 
-test_expect_success \
+test_expect_success SYMLINKS \
     'validate result of -M (#7)' \
     'compare_diff_raw expected current'
 
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 9055c8b..3a81309 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -9,6 +9,13 @@ test_description='Test diff of symlinks.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	say 'Symbolic links not supported, skipping tests.'
+	test_done
+	exit
+fi
+
 cat > expected << EOF
 diff --git a/frotz b/frotz
 new file mode 120000
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 297ddb5..5099862 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -4,6 +4,13 @@ test_description='typechange rename detection'
 
 . ./test-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	say 'Symbolic links not supported, skipping tests.'
+	test_done
+	exit
+fi
+
 test_expect_success setup '
 
 	rm -f foo bar &&
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index 0f185ca..7dc35de 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -9,6 +9,13 @@ test_description='git apply should not get confused with type changes.
 
 . ./test-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	say 'Symbolic links not supported, skipping tests.'
+	test_done
+	exit
+fi
+
 test_expect_success 'setup repository and commits' '
 	echo "hello world" > foo &&
 	echo "hi planet" > bar &&
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index 9ace578..1a3aea3 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -9,6 +9,13 @@ test_description='git apply symlinks and partial files
 
 . ./test-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	say 'Symbolic links not supported, skipping tests.'
+	test_done
+	exit
+fi
+
 test_expect_success setup '
 
 	ln -s path1/path2/path3/path4/path5 link1 &&
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 841773f..8aad20b 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -3,6 +3,13 @@
 test_description='apply to deeper directory without getting fooled with symlink'
 . ./test-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	say 'Symbolic links not supported, skipping tests.'
+	test_done
+	exit
+fi
+
 lecho () {
 	for l_
 	do
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7a84ab6..60a4b8d 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -37,7 +37,11 @@ test_expect_success \
      cp /bin/sh a/bin &&
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      printf "A not substituted O" >a/substfile2 &&
-     ln -s a a/l1 &&
+     if test_have_prereq SYMLINKS; then
+	ln -s a a/l1
+     else
+	printf %s a > a/l1
+     fi &&
      (p=long_path_to_a_file && cd a &&
       for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
       echo text >file_with_long_path) &&
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index 5672b51..d887eb6 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -4,6 +4,13 @@ test_description='pulling from symlinked subdir'
 
 . ./test-lib.sh
 
+if ! test_have_prereq SYMLINKS
+then
+	say 'Symbolic links not supported, skipping tests.'
+	test_done
+	exit
+fi
+
 # The scenario we are building:
 #
 #   trash\ directory/
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 8fb3a56..10b8f8c 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -206,7 +206,7 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 
 rm -f dirty dirty2
 
-test_expect_success 'git mv should overwrite symlink to a file' '
+test_expect_success SYMLINKS 'git mv should overwrite symlink to a file' '
 
 	rm -fr .git &&
 	git init &&
@@ -225,7 +225,7 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 
 rm -f moved symlink
 
-test_expect_success 'git mv should overwrite file with a symlink' '
+test_expect_success SYMLINKS 'git mv should overwrite file with a symlink' '
 
 	rm -fr .git &&
 	git init &&
diff --git a/t/t9131-git-svn-empty-symlink.sh b/t/t9131-git-svn-empty-symlink.sh
index 8f35e29..9a24a65 100755
--- a/t/t9131-git-svn-empty-symlink.sh
+++ b/t/t9131-git-svn-empty-symlink.sh
@@ -88,7 +88,7 @@ test_expect_success 'enable broken symlink workaround' \
 test_expect_success '"bar" is an empty file' 'test -f x/bar && ! test -s x/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd x && git svn rebase)'
-test_expect_success '"bar" becomes a symlink' 'test -L x/bar'
+test_expect_success SYMLINKS '"bar" becomes a symlink' 'test -L x/bar'
 
 
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" y'
diff --git a/t/t9132-git-svn-broken-symlink.sh b/t/t9132-git-svn-broken-symlink.sh
index b8de59e..6c4c90b 100755
--- a/t/t9132-git-svn-broken-symlink.sh
+++ b/t/t9132-git-svn-broken-symlink.sh
@@ -85,7 +85,7 @@ EOF
 
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" x'
 
-test_expect_success '"bar" is a symlink that points to "asdf"' '
+test_expect_success SYMLINKS '"bar" is a symlink that points to "asdf"' '
 	test -L x/bar &&
 	(cd x && test xasdf = x"`git cat-file blob HEAD:bar`")
 '
@@ -94,7 +94,7 @@ test_expect_success 'get "bar" => symlink fix from svn' '
 	(cd x && git svn rebase)
 '
 
-test_expect_success '"bar" remains a proper symlink' '
+test_expect_success SYMLINKS '"bar" remains a proper symlink' '
 	test -L x/bar &&
 	(cd x && test xdoink = x"`git cat-file blob HEAD:bar`")
 '
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index dce06bc..9ec5030 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -246,7 +246,7 @@ test_expect_success \
 	 gitweb_run "p=.git;a=commitdiff"'
 test_debug 'cat gitweb.log'
 
-test_expect_success \
+test_expect_success SYMLINKS \
 	'commitdiff(0): file to symlink' \
 	'rm renamed_file &&
 	 ln -s file renamed_file &&
@@ -308,7 +308,7 @@ test_debug 'cat gitweb.log'
 # ----------------------------------------------------------------------
 # commitdiff testing (taken from t4114-apply-typechange.sh)
 
-test_expect_success 'setup typechange commits' '
+test_expect_success SYMLINKS 'setup typechange commits' '
 	echo "hello world" > foo &&
 	echo "hi planet" > bar &&
 	git update-index --add foo bar &&
@@ -418,7 +418,12 @@ test_expect_success \
 	 git mv 04-rename-from 04-rename-to &&
 	 echo "Changed" >> 04-rename-to &&
 	 test_chmod +x 05-mode-change &&
-	 rm -f 06-file-or-symlink && ln -s 01-change 06-file-or-symlink &&
+	 rm -f 06-file-or-symlink &&
+	 if test_have_prereq SYMLINKS; then
+		ln -s 01-change 06-file-or-symlink
+	 else
+		printf %s 01-change > 06-file-or-symlink
+	 fi &&
 	 echo "Changed and have mode changed" > 07-change-mode-change	&&
 	 test_chmod +x 07-change-mode-change &&
 	 git commit -a -m "Large commit" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3c65cfe..5337e89 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -689,3 +689,7 @@ case $(uname -s) in
 	}
 	;;
 esac
+
+# test whether the filesystem supports symbolic links
+ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
+rm -f y
-- 
1.6.2.1.224.g2225f
