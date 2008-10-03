From: Petr Baudis <pasky@suse.cz>
Subject: [FYI][PATCH] Execute testsuite on existing Git installation
Date: Fri, 3 Oct 2008 15:13:15 +0200
Message-ID: <20081003131314.GS10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 15:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlkUH-0001vi-Gm
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 15:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYJCNNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 09:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbYJCNNT
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 09:13:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45572 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbYJCNNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 09:13:17 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 16679393B2FB; Fri,  3 Oct 2008 15:13:15 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97425>

When I joined here, one of the first tasks I had was to "verify if the
existing system-wide Git installation works fine on the local Linux
setup (of unknown qualities)". I couldn't think of anything better than
to run the Git testsuite, but using the system-wide Git instead of
locally compiled one.

This extremely dirty patch achieves this; patch testsuite of Git version
corresponding to the system-wide installation, of course. You will still
need to make the test helpers.

I don't have any real interest on developing this further or tidying it
up, but I have thought that someone might find this useful to just use
or push forward, so here it goes.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 5d3bd9d..f3c78dc 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -47,7 +47,7 @@ rawsvnrepo="$svnrepo"
 svnrepo="file://$svnrepo"
 
 poke() {
-	test-chmtime +1 "$1"
+	~/git-repo/test-chmtime +1 "$1"
 }
 
 for d in \
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 690f80a..606ed99 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -21,11 +21,13 @@ modification *should* take notice and update the test vectors here.
 ################################################################
 # It appears that people try to run tests without building...
 
-../git >/dev/null
-if test $? != 1
-then
-	echo >&2 'You do not seem to have built git yet.'
-	exit 1
+if false; then
+	../git >/dev/null
+	if test $? != 1
+	then
+		echo >&2 'You do not seem to have built git yet.'
+		exit 1
+	fi
 fi
 
 . ./test-lib.sh
@@ -301,14 +303,14 @@ test_expect_success 'absolute path works as expected' '
 	mkdir third &&
 	dir="$(cd .git; pwd -P)" &&
 	dir2=third/../second/other/.git &&
-	test "$dir" = "$(test-absolute-path $dir2)" &&
+	test "$dir" = "$(~/git-repo/test-absolute-path $dir2)" &&
 	file="$dir"/index &&
-	test "$file" = "$(test-absolute-path $dir2/index)" &&
+	test "$file" = "$(~/git-repo/test-absolute-path $dir2/index)" &&
 	basename=blub &&
-	test "$dir/$basename" = "$(cd .git && test-absolute-path "$basename")" &&
+	test "$dir/$basename" = "$(cd .git && ~/git-repo/test-absolute-path "$basename")" &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first; pwd -P)"/file &&
-	test "$sym" = "$(test-absolute-path "$dir2/syml")"
+	test "$sym" = "$(~/git-repo/test-absolute-path "$dir2/syml")"
 '
 
 test_expect_success 'very long name in the index handled sanely' '
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 6309aed..7d13c3f 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -39,7 +39,7 @@ Standard options
 EOF
 
 test_expect_success 'test help' '
-	test_must_fail test-parse-options -h > output 2> output.err &&
+	test_must_fail ~/git-repo/test-parse-options -h > output 2> output.err &&
 	test ! -s output &&
 	test_cmp expect.err output.err
 '
@@ -55,7 +55,7 @@ dry run: yes
 EOF
 
 test_expect_success 'short options' '
-	test-parse-options -s123 -b -i 1729 -b -vv -n > output 2> output.err &&
+	~/git-repo/test-parse-options -s123 -b -i 1729 -b -vv -n > output 2> output.err &&
 	test_cmp expect output &&
 	test ! -s output.err
 '
@@ -71,7 +71,7 @@ dry run: no
 EOF
 
 test_expect_success 'long options' '
-	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
+	~/git-repo/test-parse-options --boolean --integer 1729 --boolean --string2=321 \
 		--verbose --verbose --no-dry-run --abbrev=10 \
 		> output 2> output.err &&
 	test ! -s output.err &&
@@ -92,7 +92,7 @@ arg 02: --boolean
 EOF
 
 test_expect_success 'intermingled arguments' '
-	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
+	~/git-repo/test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
 		> output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
@@ -109,19 +109,19 @@ dry run: no
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
-	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
+	~/git-repo/test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
-	test-parse-options --int=2 > output 2> output.err &&
+	~/git-repo/test-parse-options --int=2 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'ambiguously abbreviated option' '
-	test-parse-options --strin 123;
+	~/git-repo/test-parse-options --strin 123;
 	test $? = 129
 '
 
@@ -136,7 +136,7 @@ dry run: no
 EOF
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	test-parse-options --st 123 > output 2> output.err &&
+	~/git-repo/test-parse-options --st 123 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
@@ -146,7 +146,7 @@ error: did you mean \`--boolean\` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -boolean > output 2> output.err &&
+	test_must_fail ~/git-repo/test-parse-options -boolean > output 2> output.err &&
 	test ! -s output &&
 	test_cmp typo.err output.err
 '
@@ -163,7 +163,7 @@ arg 00: --quux
 EOF
 
 test_expect_success 'keep some options as arguments' '
-	test-parse-options --quux > output 2> output.err &&
+	~/git-repo/test-parse-options --quux > output 2> output.err &&
         test ! -s output.err &&
         test_cmp expect output
 '
@@ -180,7 +180,7 @@ arg 00: foo
 EOF
 
 test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
-	test-parse-options -t "1970-01-01 00:00:01 +0000" --default-string \
+	~/git-repo/test-parse-options -t "1970-01-01 00:00:01 +0000" --default-string \
 		foo -q > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
@@ -198,7 +198,7 @@ dry run: no
 EOF
 
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
-	test-parse-options --length=four -b -4 > output 2> output.err &&
+	~/git-repo/test-parse-options --length=four -b -4 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
@@ -208,7 +208,7 @@ Callback: "not set", 1
 EOF
 
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-parse-options --no-length > output 2> output.err &&
+	test_must_fail ~/git-repo/test-parse-options --no-length > output 2> output.err &&
 	test_cmp expect output &&
 	test_cmp expect.err output.err
 '
@@ -224,7 +224,7 @@ dry run: no
 EOF
 
 test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
+	~/git-repo/test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
 '
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 85d7e3e..2e869f4 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -149,16 +149,16 @@ just_over_15_days_ago=$((-1-15*86400))
 almost_60_days_ago=$((60-60*86400))
 just_over_60_days_ago=$((-1-60*86400))
 
-test-chmtime =$almost_60_days_ago $rr/preimage
-test-chmtime =$almost_15_days_ago $rr2/preimage
+~/git-repo/test-chmtime =$almost_60_days_ago $rr/preimage
+~/git-repo/test-chmtime =$almost_15_days_ago $rr2/preimage
 
 test_expect_success 'garbage collection (part1)' 'git rerere gc'
 
 test_expect_success 'young records still live' \
 	"test -f $rr/preimage && test -f $rr2/preimage"
 
-test-chmtime =$just_over_60_days_ago $rr/preimage
-test-chmtime =$just_over_15_days_ago $rr2/preimage
+~/git-repo/test-chmtime =$just_over_60_days_ago $rr/preimage
+~/git-repo/test-chmtime =$just_over_15_days_ago $rr2/preimage
 
 test_expect_success 'garbage collection (part2)' 'git rerere gc'
 
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 073ac0c..89177ab 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -12,7 +12,7 @@ test_expect_success \
      for i in a b c
      do
          echo $i >$i &&
-         test-genrandom "$i" 32768 >>$i &&
+         ~/git-repo/test-genrandom "$i" 32768 >>$i &&
          git update-index --add $i || return 1
      done &&
      echo d >d && cat c >>d && git update-index --add d &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 09fd917..a38c0c2 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -15,11 +15,11 @@ test_expect_success \
      do
 		 i=`printf '%03i' $i`
          echo $i >file_$i &&
-         test-genrandom "$i" 8192 >>file_$i &&
+         ~/git-repo/test-genrandom "$i" 8192 >>file_$i &&
          git update-index --add file_$i &&
 		 i=`expr $i + 1` || return 1
      done &&
-     { echo 101 && test-genrandom 100 8192; } >file_101 &&
+     { echo 101 && ~/git-repo/test-genrandom 100 8192; } >file_101 &&
      git update-index --add file_101 &&
      tree=`git write-tree` &&
      commit=`git commit-tree $tree </dev/null` && {
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 9fd9d07..6084172 100644
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -21,7 +21,7 @@ test_expect_success 'prune stale packs' '
 	orig_pack=$(echo .git/objects/pack/*.pack) &&
 	: > .git/objects/tmp_1.pack &&
 	: > .git/objects/tmp_2.pack &&
-	test-chmtime -86501 .git/objects/tmp_1.pack &&
+	~/git-repo/test-chmtime -86501 .git/objects/tmp_1.pack &&
 	git prune --expire 1.day &&
 	test -f $orig_pack &&
 	test -f .git/objects/tmp_2.pack &&
@@ -39,7 +39,7 @@ test_expect_success 'prune --expire' '
 	git prune --expire=1.hour.ago &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
-	test-chmtime -86500 $BLOB_FILE &&
+	~/git-repo/test-chmtime -86500 $BLOB_FILE &&
 	git prune --expire 1.day &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
 	! test -f $BLOB_FILE
@@ -53,11 +53,11 @@ test_expect_success 'gc: implicit prune --expire' '
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
-	test-chmtime -$((86400*14-30)) $BLOB_FILE &&
+	~/git-repo/test-chmtime -$((86400*14-30)) $BLOB_FILE &&
 	git gc &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
-	test-chmtime -$((86400*14+1)) $BLOB_FILE &&
+	~/git-repo/test-chmtime -$((86400*14+1)) $BLOB_FILE &&
 	git gc &&
 	test $before = $(git count-objects | sed "s/ .*//") &&
 	! test -f $BLOB_FILE
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c861141..38e6a59 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -345,7 +345,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init "--template=$GIT_EXEC_PATH/templates/blt/" >/dev/null 2>&1 ||
+	"git" init >/dev/null 2>&1 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
@@ -387,20 +387,25 @@ test_done () {
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
-PATH=$(pwd)/..:$PATH
-GIT_EXEC_PATH=$(pwd)/..
-GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
-unset GIT_CONFIG
-unset GIT_CONFIG_LOCAL
-GIT_CONFIG_NOSYSTEM=1
-GIT_CONFIG_NOGLOBAL=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
-
-GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
-export GITPERLLIB
-test -d ../templates/blt || {
-	error "You haven't built things yet, have you?"
-}
+if false; then
+	PATH=$(pwd)/..:$PATH
+	GIT_EXEC_PATH=$(pwd)/..
+	GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
+
+	GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
+	export GITPERLLIB
+	test -d ../templates/blt || {
+		error "You haven't built things yet, have you?"
+	}
+
+	. ../GIT-BUILD-OPTIONS
+fi
+
+	unset GIT_CONFIG
+	unset GIT_CONFIG_LOCAL
+	GIT_CONFIG_NOSYSTEM=1
+	GIT_CONFIG_NOGLOBAL=1
+	export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
 
 if ! test -x ../test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
@@ -408,8 +413,6 @@ if ! test -x ../test-chmtime; then
 	exit 1
 fi
 
-. ../GIT-BUILD-OPTIONS
-
 # Test repository
 test="trash directory"
 rm -fr "$test" || {
