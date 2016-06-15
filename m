From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 19/20] cvsserver: add t9402 to test branch and tag refs
Date: Sat, 13 Oct 2012 23:42:32 -0600
Message-ID: <1350193353-19210-20-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDO-0006s7-QR
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab2JNF6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:05 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:37047 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751688Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id Atve1k0011Y3wxoA6ty2Aw; Sun, 14 Oct 2012 05:58:02 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta15.emeryville.ca.mail.comcast.net with comcast
	id Att11k00H2wKXRC8btt1sz; Sun, 14 Oct 2012 05:53:02 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 8A1931E9601E; Sat, 13 Oct 2012 23:43:20 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207628>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 t/t9402-git-cvsserver-refs.sh | 558 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 558 insertions(+)
 create mode 100755 t/t9402-git-cvsserver-refs.sh

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
new file mode 100755
index 0000000..a256faa
--- /dev/null
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -0,0 +1,558 @@
+#!/bin/sh
+
+test_description='git-cvsserver and git refspecs
+
+tests ability for git-cvsserver to switch between and compare
+tags, branches and other git refspecs'
+
+. ./test-lib.sh
+
+#########
+
+check_start_tree() {
+    rm -f "$WORKDIR/check.list"
+    echo "start $1" >> "${WORKDIR}/check.log"
+}
+
+check_file() {
+    sandbox="$1"
+    file="$2"
+    ver="$3"
+    GIT_DIR=$SERVERDIR git show "${ver}:${file}" \
+        > "$WORKDIR/check.got" 2> "$WORKDIR/check.stderr"
+    test_cmp "$WORKDIR/check.got" "$sandbox/$file"
+    stat=$?
+    echo "check_file $sandbox $file $ver : $stat" >> "$WORKDIR/check.log"
+    echo "$file" >> "$WORKDIR/check.list"
+    return $stat
+}
+
+check_end_tree() {
+    sandbox="$1"
+    expectCount=$(wc -l < "$WORKDIR/check.list")
+    cvsCount=$(find "$sandbox" -name CVS -prune -o -type f -print | wc -l)
+    test x"$cvsCount" = x"$expectCount"
+    stat=$?
+    echo "check_end $sandbox : $stat cvs=$cvsCount expect=$expectCount" \
+        >> "$WORKDIR/check.log"
+    return $stat
+}
+
+check_end_full_tree() {
+    sandbox="$1"
+    ver="$2"
+    expectCount=$(wc -l < "$WORKDIR/check.list")
+    cvsCount=$(find "$sandbox" -name CVS -prune -o -type f -print | wc -l)
+    gitCount=$(git ls-tree -r "$2" | wc -l)
+    test x"$cvsCount" = x"$expectCount" -a x"$gitCount" = x"$expectCount"
+    stat=$?
+    echo "check_end $sandbox : $stat cvs=$cvsCount git=$gitCount expect=$expectCount" \
+        >> "$WORKDIR/check.log"
+    return $stat
+}
+
+#########
+
+check_diff() {
+    diffFile="$1"
+    vOld="$2"
+    vNew="$3"
+    rm -rf diffSandbox
+    git clone -q -n . diffSandbox &&
+    ( cd diffSandbox &&
+      git checkout "$vOld" &&
+      git apply -p0 --index <"../$diffFile" &&
+      git diff --exit-code "$vNew" ) > check_diff_apply.out 2>&1
+}
+
+#########
+
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+    skip_all='skipping git-cvsserver tests, cvs not found'
+    test_done
+fi
+if ! test_have_prereq PERL
+then
+    skip_all='skipping git-cvsserver tests, perl not available'
+    test_done
+fi
+"$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+    skip_all='skipping git-cvsserver tests, Perl SQLite interface unavailable'
+    test_done
+}
+
+unset GIT_DIR GIT_CONFIG
+WORKDIR=$(pwd)
+SERVERDIR=$(pwd)/gitcvs.git
+git_config="$SERVERDIR/config"
+CVSROOT=":fork:$SERVERDIR"
+CVSWORK="$(pwd)/cvswork"
+CVS_SERVER=git-cvsserver
+export CVSROOT CVS_SERVER
+
+rm -rf "$CVSWORK" "$SERVERDIR"
+test_expect_success 'setup v1, b1' '
+    echo "Simple text file" > textfile.c &&
+    echo "t2" > t2 &&
+    mkdir adir &&
+    echo "adir/afile line1" > adir/afile &&
+    echo "adir/afile line2" >> adir/afile &&
+    echo "adir/afile line3" >> adir/afile &&
+    echo "adir/afile line4" >> adir/afile &&
+    echo "adir/a2file" >> adir/a2file &&
+    mkdir adir/bdir &&
+    echo "adir/bdir/bfile line 1" > adir/bdir/bfile &&
+    echo "adir/bdir/bfile line 2" >> adir/bdir/bfile &&
+    echo "adir/bdir/b2file" > adir/bdir/b2file &&
+    git add textfile.c t2 adir &&
+    git commit -q -m "First Commit (v1)" &&
+    git tag v1 &&
+    git branch b1 &&
+    git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+    GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+    GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log"
+'
+
+rm -rf cvswork
+test_expect_success 'cvs co v1' '
+    cvs -f -Q co -r v1 -d cvswork master >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_tree cvswork
+'
+
+rm -rf cvswork
+test_expect_success 'cvs co b1' '
+    cvs -f co -r b1 -d cvswork master >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_tree cvswork
+'
+
+test_expect_success 'cvs co b1 [cvswork3]' '
+    cvs -f co -r b1 -d cvswork3 master >cvs.log 2>&1 &&
+    check_start_tree cvswork3 &&
+    check_file cvswork3 textfile.c v1 &&
+    check_file cvswork3 t2 v1 &&
+    check_file cvswork3 adir/afile v1 &&
+    check_file cvswork3 adir/a2file v1 &&
+    check_file cvswork3 adir/bdir/bfile v1 &&
+    check_file cvswork3 adir/bdir/b2file v1 &&
+    check_end_full_tree cvswork3 v1
+'
+
+test_expect_success 'edit cvswork3 and save diff' '
+    ( cd cvswork3 &&
+      sed -i -e "s/line1/line1 - data/" adir/afile &&
+      echo "afile5" > adir/afile5 &&
+      rm t2 &&
+      cvs -f add adir/afile5 &&
+      cvs -f rm t2 &&
+      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvswork3edit.diff"
+    )
+'
+
+test_expect_success 'setup v1.2 on b1' '
+    git checkout b1 &&
+    echo "new v1.2" > t3 &&
+    rm t2 &&
+    sed -i -e "s/line3/line3 - more data/" adir/afile &&
+    rm adir/a2file &&
+    echo "a3file" >> adir/a3file &&
+    echo "bfile line 3" >> adir/bdir/bfile &&
+    rm adir/bdir/b2file &&
+    echo "b3file" > adir/bdir/b3file &&
+    mkdir cdir &&
+    echo "cdir/cfile" > cdir/cfile &&
+    git add -A cdir adir t3 t2 &&
+    git commit -q -m 'v1.2' &&
+    git tag v1.2 &&
+    git push --tags gitcvs.git b1:b1
+'
+
+test_expect_success 'cvs -f up (on b1 adir)' '
+    ( cd cvswork/adir &&
+      cvs -f up -d ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1.2 &&
+    check_file cvswork adir/a3file v1.2 &&
+    check_file cvswork adir/bdir/bfile v1.2 &&
+    check_file cvswork adir/bdir/b3file v1.2 &&
+    check_end_tree cvswork
+'
+
+test_expect_success 'cvs up (on b1 /)' '
+    ( cd cvswork &&
+      cvs -f up -d ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1.2 &&
+    check_file cvswork t3 v1.2 &&
+    check_file cvswork adir/afile v1.2 &&
+    check_file cvswork adir/a3file v1.2 &&
+    check_file cvswork adir/bdir/bfile v1.2 &&
+    check_file cvswork adir/bdir/b3file v1.2 &&
+    check_file cvswork cdir/cfile v1.2 &&
+    check_end_tree cvswork
+'
+
+# Make sure "CVS/Tag" files didn't get messed up:
+test_expect_success 'cvs up (on b1 /) (again; check CVS/Tag files)' '
+    ( cd cvswork &&
+      cvs -f up -d ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1.2 &&
+    check_file cvswork t3 v1.2 &&
+    check_file cvswork adir/afile v1.2 &&
+    check_file cvswork adir/a3file v1.2 &&
+    check_file cvswork adir/bdir/bfile v1.2 &&
+    check_file cvswork adir/bdir/b3file v1.2 &&
+    check_file cvswork cdir/cfile v1.2 &&
+    check_end_tree cvswork
+'
+
+# update to another version:
+test_expect_success 'cvs up -r v1' '
+    ( cd cvswork &&
+      cvs -f up -r v1 ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_tree cvswork
+'
+
+test_expect_success 'cvs up' '
+    ( cd cvswork &&
+      cvs -f up ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_tree cvswork
+'
+
+test_expect_success 'cvs up (again; check CVS/Tag files)' '
+    ( cd cvswork &&
+      cvs -f up -d ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_tree cvswork
+'
+
+test_expect_success 'setup simple b2' '
+    git branch b2 v1 &&
+    git push --tags gitcvs.git b2:b2
+'
+
+test_expect_success 'cvs co b2 [into cvswork2]' '
+    cvs -f co -r b2 -d cvswork2 master >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_tree cvswork
+'
+
+test_expect_success 'root dir edit [cvswork2]' '
+    ( cd cvswork2 &&
+      echo "Line 2" >> textfile.c &&
+      test_must_fail cvs -f diff -u >"$WORKDIR/cvsEdit1.diff" &&
+      cvs -f commit -m "edit textfile.c" textfile.c
+    ) >cvsEdit1.log 2>&1
+'
+
+test_expect_success 'root dir rm file [cvswork2]' '
+    ( cd cvswork2 &&
+      cvs -f rm -f t2 &&
+      cvs -f diff -u > ../cvsEdit2-empty.diff &&
+      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsEdit2-N.diff" &&
+      cvs -f commit -m "rm t2"
+    ) > cvsEdit2.log 2>&1
+'
+
+test_expect_success 'subdir edit/add/rm files [cvswork2' '
+    ( cd cvswork2 &&
+      sed -i -e "s/line 1/line 1 (v2)/" adir/bdir/bfile &&
+      rm adir/bdir/b2file &&
+      cd adir &&
+      cvs -f rm bdir/b2file &&
+      echo "4th file" > bdir/b4file &&
+      cvs -f add bdir/b4file &&
+      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsEdit3.diff" &&
+      git fetch gitcvs.git b2:b2 &&
+      ( cd .. &&
+        test_must_fail cvs -f diff -u -N -r v1.2 >"$WORKDIR/cvsEdit3-v1.2.diff" &&
+        test_must_fail cvs -f diff -u -N -r v1.2 -r v1 >"$WORKDIR/cvsEdit3-v1.2-v1.diff"
+      ) &&
+      cvs -f commit -m "various add/rm/edit"
+    ) >cvs.log 2>&1
+'
+
+test_expect_success 'validate result of edits [cvswork2]' '
+    git fetch gitcvs.git b2:b2 &&
+    git tag v2 b2 &&
+    git push --tags gitcvs.git b2:b2 &&
+    check_start_tree cvswork2 &&
+    check_file cvswork2 textfile.c v2 &&
+    check_file cvswork2 adir/afile v2 &&
+    check_file cvswork2 adir/a2file v2 &&
+    check_file cvswork2 adir/bdir/bfile v2 &&
+    check_file cvswork2 adir/bdir/b4file v2 &&
+    check_end_full_tree cvswork2 v2
+'
+
+test_expect_success 'validate basic diffs saved during above cvswork2 edits' '
+    test $(grep Index: cvsEdit1.diff | wc -l) = 1 &&
+    test ! -s cvsEdit2-empty.diff &&
+    test $(grep Index: cvsEdit2-N.diff | wc -l) = 1 &&
+    test $(grep Index: cvsEdit3.diff | wc -l) = 3 &&
+    rm -rf diffSandbox &&
+    git clone -q -n . diffSandbox &&
+    ( cd diffSandbox &&
+      git checkout v1 &&
+      git apply -p0 --index <"$WORKDIR/cvsEdit1.diff" &&
+      git apply -p0 --index <"$WORKDIR/cvsEdit2-N.diff" &&
+      git apply -p0 --directory=adir --index <"$WORKDIR/cvsEdit3.diff" &&
+      git diff --exit-code v2 ) >"check_diff_apply.out" 2>&1
+'
+
+test_expect_success 'validate v1.2 diff saved during last cvswork2 edit' '
+    test $(grep Index: cvsEdit3-v1.2.diff | wc -l) = 9 &&
+    check_diff cvsEdit3-v1.2.diff v1.2 v2
+'
+
+test_expect_success 'validate v1.2 v1 diff saved during last cvswork2 edit' '
+    test $(grep Index: cvsEdit3-v1.2-v1.diff | wc -l) = 9 &&
+    check_diff cvsEdit3-v1.2-v1.diff v1.2 v1
+'
+
+test_expect_success 'cvs up [cvswork2]' '
+    ( cd cvswork2 &&
+      cvs -f up ) >cvs.log 2>&1 &&
+    check_start_tree cvswork2 &&
+    check_file cvswork2 textfile.c v2 &&
+    check_file cvswork2 adir/afile v2 &&
+    check_file cvswork2 adir/a2file v2 &&
+    check_file cvswork2 adir/bdir/bfile v2 &&
+    check_file cvswork2 adir/bdir/b4file v2 &&
+    check_end_full_tree cvswork2 v2
+'
+
+test_expect_success 'cvs up -r b2 [back to cvswork]' '
+    ( cd cvswork &&
+      cvs -f up -r b2 ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v2 &&
+    check_file cvswork adir/afile v2 &&
+    check_file cvswork adir/a2file v2 &&
+    check_file cvswork adir/bdir/bfile v2 &&
+    check_file cvswork adir/bdir/b4file v2 &&
+    check_end_full_tree cvswork v2
+'
+
+test_expect_success 'cvs up -r b1' '
+    ( cd cvswork &&
+      cvs -f up -r b1 ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1.2 &&
+    check_file cvswork t3 v1.2 &&
+    check_file cvswork adir/afile v1.2 &&
+    check_file cvswork adir/a3file v1.2 &&
+    check_file cvswork adir/bdir/bfile v1.2 &&
+    check_file cvswork adir/bdir/b3file v1.2 &&
+    check_file cvswork cdir/cfile v1.2 &&
+    check_end_full_tree cvswork v1.2
+'
+
+test_expect_success 'cvs up -A' '
+    ( cd cvswork &&
+      cvs -f up -A ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_full_tree cvswork v1
+'
+
+test_expect_success 'cvs up (check CVS/Tag files)' '
+    ( cd cvswork &&
+      cvs -f up ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_full_tree cvswork v1
+'
+
+# This is not really legal CVS, but it seems to work anyway:
+test_expect_success 'cvs up -r heads/b1' '
+    ( cd cvswork &&
+      cvs -f up -r heads/b1 ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1.2 &&
+    check_file cvswork t3 v1.2 &&
+    check_file cvswork adir/afile v1.2 &&
+    check_file cvswork adir/a3file v1.2 &&
+    check_file cvswork adir/bdir/bfile v1.2 &&
+    check_file cvswork adir/bdir/b3file v1.2 &&
+    check_file cvswork cdir/cfile v1.2 &&
+    check_end_full_tree cvswork v1.2
+'
+
+# But this should work even if CVS client checks -r more carefully:
+test_expect_success 'cvs up -r heads_-s-b2 (cvsserver escape mechanism)' '
+    ( cd cvswork &&
+      cvs -f up -r heads_-s-b2 ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v2 &&
+    check_file cvswork adir/afile v2 &&
+    check_file cvswork adir/a2file v2 &&
+    check_file cvswork adir/bdir/bfile v2 &&
+    check_file cvswork adir/bdir/b4file v2 &&
+    check_end_full_tree cvswork v2
+'
+
+v1hash=$(git rev-parse v1)
+test_expect_success 'cvs up -r $(git rev-parse v1)' '
+    test -n "$v1hash" &&
+    ( cd cvswork &&
+      cvs -f up -r "$v1hash" ) >cvs.log 2>&1 &&
+    check_start_tree cvswork &&
+    check_file cvswork textfile.c v1 &&
+    check_file cvswork t2 v1 &&
+    check_file cvswork adir/afile v1 &&
+    check_file cvswork adir/a2file v1 &&
+    check_file cvswork adir/bdir/bfile v1 &&
+    check_file cvswork adir/bdir/b2file v1 &&
+    check_end_full_tree cvswork v1
+'
+
+test_expect_success 'cvs diff -r v1 -u' '
+    ( cd cvswork &&
+      cvs -f diff -r v1 -u ) >cvsDiff.out 2>cvs.log &&
+    test ! -s cvsDiff.out &&
+    test ! -s cvs.log
+'
+
+test_expect_success 'cvs diff -N -r v2 -u' '
+    ( cd cvswork &&
+      test_must_fail cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log &&
+    test ! -s cvs.log &&
+    test -s cvsDiff.out &&
+    check_diff cvsDiff.out v2 v1 > check_diff.out 2>&1
+'
+
+test_expect_success 'cvs diff -N -r v2 -r v1.2' '
+    ( cd cvswork &&
+      test_must_fail cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>cvs.log &&
+    test ! -s cvs.log &&
+    test -s cvsDiff.out &&
+    check_diff cvsDiff.out v2 v1.2 > check_diff.out 2>&1
+'
+
+test_expect_success 'apply early [cvswork3] diff to b3' '
+    git clone -q . gitwork3 &&
+    ( cd gitwork3 &&
+      git checkout -b b3 v1 &&
+      git apply -p0 --index <"$WORKDIR/cvswork3edit.diff" &&
+      git commit -m "cvswork3 edits applied" ) &&
+    git fetch gitwork3 b3:b3 &&
+    git tag v3 b3
+'
+
+test_expect_success 'check [cvswork3] diff' '
+    ( cd cvswork3 &&
+      test_must_fail cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>cvs.log &&
+    test ! -s cvs.log &&
+    test -s cvsDiff.out &&
+    test $(grep Index: cvsDiff.out | wc -l) = 3 &&
+    test_cmp cvsDiff.out cvswork3edit.diff &&
+    check_diff cvsDiff.out v1 v3 > check_diff.out 2>&1
+'
+
+test_expect_success 'merge early [cvswork3] b3 with b1' '
+    ( cd gitwork3 &&
+      git merge "message" HEAD b1 )
+    git fetch gitwork3 b3:b3 &&
+    git tag v3merged b3 &&
+    git push --tags gitcvs.git b3:b3
+'
+
+# This test would fail if cvsserver properly created a ".#afile"* file
+# for the merge.
+# TODO: Validate that the .# file was saved properly, and then
+#   delete/ignore it when checking the tree.
+test_expect_success 'cvs up dirty [cvswork3]' '
+    ( cd cvswork3 &&
+      cvs -f up &&
+      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsDiff.out" ) >cvs.log 2>&1 &&
+    test -s cvsDiff.out &&
+    test $(grep Index: cvsDiff.out | wc -l) = 2
+    check_start_tree cvswork3 &&
+    check_file cvswork3 textfile.c v3merged &&
+    check_file cvswork3 t3 v3merged &&
+    check_file cvswork3 adir/afile v3merged &&
+    check_file cvswork3 adir/a3file v3merged &&
+    check_file cvswork3 adir/afile5 v3merged &&
+    check_file cvswork3 adir/bdir/bfile v3merged &&
+    check_file cvswork3 adir/bdir/b3file v3merged &&
+    check_file cvswork3 cdir/cfile v3merged &&
+    check_end_full_tree cvswork3 v3merged
+'
+
+# TODO: test cvs status
+
+test_expect_success 'cvs commit [cvswork3' '
+    ( cd cvswork3 &&
+      cvs -f commit -m "dirty sandbox after auto-merge"
+    ) > cvs.log 2>&1 &&
+    check_start_tree cvswork3 &&
+    check_file cvswork3 textfile.c v3merged &&
+    check_file cvswork3 t3 v3merged &&
+    check_file cvswork3 adir/afile v3merged &&
+    check_file cvswork3 adir/a3file v3merged &&
+    check_file cvswork3 adir/afile5 v3merged &&
+    check_file cvswork3 adir/bdir/bfile v3merged &&
+    check_file cvswork3 adir/bdir/b3file v3merged &&
+    check_file cvswork3 cdir/cfile v3merged &&
+    check_end_full_tree cvswork3 v3merged &&
+    git fetch gitcvs.git b3:b4 &&
+    git tag v4.1 b4 &&
+    git diff --exit-code v4.1 v3merged > check_diff_apply.out 2>&1
+'
+
+test_done
-- 
1.7.10.2.484.gcd07cc5
