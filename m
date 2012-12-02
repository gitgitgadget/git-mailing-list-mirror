From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t9402: sed -i is not portable
Date: Sun, 2 Dec 2012 13:22:44 +0100
Message-ID: <201212021322.45418.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org, mmogilvi_git@miniinfo.net
X-From: git-owner@vger.kernel.org Sun Dec 02 13:23:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf8Zj-0005RL-8v
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 13:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab2LBMWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 07:22:54 -0500
Received: from mout.web.de ([212.227.15.3]:50232 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2LBMWx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2012 07:22:53 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MgfXb-1TsZFV3Aoh-00NQyY; Sun, 02 Dec 2012 13:22:51 +0100
X-Provags-ID: V02:K0:UPfBQnkzHKkcQtN7169nZRp+IOA8tuvnc+yJpTkouLW
 iQt31VnEKzyZ/EThYxrRUXUZTsRtJhYVSYTsSETaJP6A21Etnt
 V4KzveDVj/BTg4ddK042tvjn4gQMgVQpG+Ob+Bl9+a16iEhE8L
 mHx3Tponf2J2svEIAMaq0TP7WoAwy1xQIQXS1rgtDovE7BBhgf
 d1fOvijWhJgaKsgS3RWug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211011>

On some systems sed allows the usage of e.g.
sed -i -e "s/line1/line2/" afile
to edit the file "in place".
Other systems don't allow that: one observed behaviour is that
sed -i -e "s/line1/line2/" afile
creates a backup file called afile-e, which breaks the test.
As sed -i is not part of POSIX, avoid it.

Use test_cmp, makes the test easier to debug.
Chain all shell commands with && to detect all kinds of failure.
While at it, Use TAB to indent.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Note: this should go on top of pu

 t/t9402-git-cvsserver-refs.sh | 764 +++++++++++++++++++++-------------=
--------
 1 file changed, 383 insertions(+), 381 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index 858ef0f..39c6b01 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -10,59 +10,58 @@ tags, branches and other git refspecs'
 #########
=20
 check_start_tree() {
-    rm -f "$WORKDIR/check.list"
-    echo "start $1" >> "${WORKDIR}/check.log"
+		rm -f "$WORKDIR/check.list"
+		echo "start $1" >> "${WORKDIR}/check.log"
 }
=20
 check_file() {
-    sandbox=3D"$1"
-    file=3D"$2"
-    ver=3D"$3"
-    GIT_DIR=3D$SERVERDIR git show "${ver}:${file}" \
+		sandbox=3D"$1"
+		file=3D"$2"
+		ver=3D"$3"
+		GIT_DIR=3D$SERVERDIR git show "${ver}:${file}" \
 	> "$WORKDIR/check.got" 2> "$WORKDIR/check.stderr"
-    test_cmp "$WORKDIR/check.got" "$sandbox/$file"
-    stat=3D$?
-    echo "check_file $sandbox $file $ver : $stat" >> "$WORKDIR/check.l=
og"
-    echo "$file" >> "$WORKDIR/check.list"
-    return $stat
+		test_cmp "$WORKDIR/check.got" "$sandbox/$file"
+		stat=3D$?
+		echo "check_file $sandbox $file $ver : $stat" >> "$WORKDIR/check.log=
"
+		echo "$file" >> "$WORKDIR/check.list"
+		return $stat
 }
=20
 check_end_tree() {
-    sandbox=3D"$1"
-    expectCount=3D$(wc -l < "$WORKDIR/check.list")
-    cvsCount=3D$(find "$sandbox" -name CVS -prune -o -type f -print | =
wc -l)
-    test x"$cvsCount" =3D x"$expectCount"
-    stat=3D$?
-    echo "check_end $sandbox : $stat cvs=3D$cvsCount expect=3D$expectC=
ount" \
-	>> "$WORKDIR/check.log"
-    return $stat
+		sandbox=3D"$1" &&
+		wc -l < "$WORKDIR/check.list" > expected &&
+		find "$sandbox" -type f | grep -v "/CVS" > "$WORKDIR/check.cvsCount"=
 &&
+		wc -l < "$WORKDIR/check.cvsCount" >actual &&
+		test_cmp expected actual &&
+		rm expected actual &&
+		sort < "$WORKDIR/check.list" > expected &&
+		sort < "$WORKDIR/check.cvsCount" | sed -e "s%cvswork/%%" >actual &&
+		test_cmp expected actual &&
+		rm expected actual
 }
=20
 check_end_full_tree() {
-    sandbox=3D"$1"
-    ver=3D"$2"
-    expectCount=3D$(wc -l < "$WORKDIR/check.list")
-    cvsCount=3D$(find "$sandbox" -name CVS -prune -o -type f -print | =
wc -l)
-    gitCount=3D$(git ls-tree -r "$2" | wc -l)
-    test x"$cvsCount" =3D x"$expectCount" -a x"$gitCount" =3D x"$expec=
tCount"
-    stat=3D$?
-    echo "check_end $sandbox : $stat cvs=3D$cvsCount git=3D$gitCount e=
xpect=3D$expectCount" \
-	>> "$WORKDIR/check.log"
-    return $stat
+		sandbox=3D"$1" &&
+		sort < "$WORKDIR/check.list" >expected &&
+		find "$sandbox" -name CVS -prune -o -type f -print | sed -e "s%$sand=
box/%%" | sort >act1 &&
+		test_cmp expected act1 &&
+		git ls-tree -r "$2" | sed -e "s/^.*blob [0-9a-fA-F]*[	 ]*//" | sort =
> act2 &&
+		test_cmp expected act2 &&
+		rm expected act1 act2
 }
=20
 #########
=20
 check_diff() {
-    diffFile=3D"$1"
-    vOld=3D"$2"
-    vNew=3D"$3"
-    rm -rf diffSandbox
-    git clone -q -n . diffSandbox &&
-    ( cd diffSandbox &&
-      git checkout "$vOld" &&
-      git apply -p0 --index <"../$diffFile" &&
-      git diff --exit-code "$vNew" ) > check_diff_apply.out 2>&1
+		diffFile=3D"$1"
+		vOld=3D"$2"
+		vNew=3D"$3"
+		rm -rf diffSandbox
+		git clone -q -n . diffSandbox &&
+		( cd diffSandbox &&
+			git checkout "$vOld" &&
+			git apply -p0 --index <"../$diffFile" &&
+			git diff --exit-code "$vNew" ) > check_diff_apply.out 2>&1
 }
=20
 #########
@@ -70,17 +69,17 @@ check_diff() {
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    skip_all=3D'skipping git-cvsserver tests, cvs not found'
-    test_done
+		skip_all=3D'skipping git-cvsserver tests, cvs not found'
+		test_done
 fi
 if ! test_have_prereq PERL
 then
-    skip_all=3D'skipping git-cvsserver tests, perl not available'
-    test_done
+		skip_all=3D'skipping git-cvsserver tests, perl not available'
+		test_done
 fi
 "$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
-    skip_all=3D'skipping git-cvsserver tests, Perl SQLite interface un=
available'
-    test_done
+		skip_all=3D'skipping git-cvsserver tests, Perl SQLite interface unav=
ailable'
+		test_done
 }
=20
 unset GIT_DIR GIT_CONFIG
@@ -94,465 +93,468 @@ export CVSROOT CVS_SERVER
=20
 rm -rf "$CVSWORK" "$SERVERDIR"
 test_expect_success 'setup v1, b1' '
-    echo "Simple text file" > textfile.c &&
-    echo "t2" > t2 &&
-    mkdir adir &&
-    echo "adir/afile line1" > adir/afile &&
-    echo "adir/afile line2" >> adir/afile &&
-    echo "adir/afile line3" >> adir/afile &&
-    echo "adir/afile line4" >> adir/afile &&
-    echo "adir/a2file" >> adir/a2file &&
-    mkdir adir/bdir &&
-    echo "adir/bdir/bfile line 1" > adir/bdir/bfile &&
-    echo "adir/bdir/bfile line 2" >> adir/bdir/bfile &&
-    echo "adir/bdir/b2file" > adir/bdir/b2file &&
-    git add textfile.c t2 adir &&
-    git commit -q -m "First Commit (v1)" &&
-    git tag v1 &&
-    git branch b1 &&
-    git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &=
&
-    GIT_DIR=3D"$SERVERDIR" git config --bool gitcvs.enabled true &&
-    GIT_DIR=3D"$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcv=
s.log"
+		echo "Simple text file" > textfile.c &&
+		echo "t2" > t2 &&
+		mkdir adir &&
+		echo "adir/afile line1" > adir/afile &&
+		echo "adir/afile line2" >> adir/afile &&
+		echo "adir/afile line3" >> adir/afile &&
+		echo "adir/afile line4" >> adir/afile &&
+		echo "adir/a2file" >> adir/a2file &&
+		mkdir adir/bdir &&
+		echo "adir/bdir/bfile line 1" > adir/bdir/bfile &&
+		echo "adir/bdir/bfile line 2" >> adir/bdir/bfile &&
+		echo "adir/bdir/b2file" > adir/bdir/b2file &&
+		git add textfile.c t2 adir &&
+		git commit -q -m "First Commit (v1)" &&
+		git tag v1 &&
+		git branch b1 &&
+		git clone -q --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
+		GIT_DIR=3D"$SERVERDIR" git config --bool gitcvs.enabled true &&
+		GIT_DIR=3D"$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.=
log"
 '
=20
 rm -rf cvswork
 test_expect_success 'cvs co v1' '
-    cvs -f -Q co -r v1 -d cvswork master >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_tree cvswork
+		cvs -f -Q co -r v1 -d cvswork master >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_tree cvswork
 '
=20
 rm -rf cvswork
 test_expect_success 'cvs co b1' '
-    cvs -f co -r b1 -d cvswork master >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_tree cvswork
+		cvs -f co -r b1 -d cvswork master >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_tree cvswork
 '
=20
 test_expect_success 'cvs co b1 [cvswork3]' '
-    cvs -f co -r b1 -d cvswork3 master >cvs.log 2>&1 &&
-    check_start_tree cvswork3 &&
-    check_file cvswork3 textfile.c v1 &&
-    check_file cvswork3 t2 v1 &&
-    check_file cvswork3 adir/afile v1 &&
-    check_file cvswork3 adir/a2file v1 &&
-    check_file cvswork3 adir/bdir/bfile v1 &&
-    check_file cvswork3 adir/bdir/b2file v1 &&
-    check_end_full_tree cvswork3 v1
+		cvs -f co -r b1 -d cvswork3 master >cvs.log 2>&1 &&
+		check_start_tree cvswork3 &&
+		check_file cvswork3 textfile.c v1 &&
+		check_file cvswork3 t2 v1 &&
+		check_file cvswork3 adir/afile v1 &&
+		check_file cvswork3 adir/a2file v1 &&
+		check_file cvswork3 adir/bdir/bfile v1 &&
+		check_file cvswork3 adir/bdir/b2file v1 &&
+		check_end_full_tree cvswork3 v1
 '
=20
 test_expect_success 'edit cvswork3 and save diff' '
-    ( cd cvswork3 &&
-      sed -i -e "s/line1/line1 - data/" adir/afile &&
-      echo "afile5" > adir/afile5 &&
-      rm t2 &&
-      cvs -f add adir/afile5 &&
-      cvs -f rm t2 &&
-      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvswork3edit.diff"
-    )
+		( cd cvswork3 &&
+			sed -e "s/line1/line1 - data/" adir/afile >adir/afileNEW &&
+			mv -f adir/afileNEW adir/afile &&
+			echo "afile5" > adir/afile5 &&
+			rm t2 &&
+			cvs -f add adir/afile5 &&
+			cvs -f rm t2 &&
+			test_must_fail cvs -f diff -N -u >"$WORKDIR/cvswork3edit.diff"
+		)
 '
=20
 test_expect_success 'setup v1.2 on b1' '
-    git checkout b1 &&
-    echo "new v1.2" > t3 &&
-    rm t2 &&
-    sed -i -e "s/line3/line3 - more data/" adir/afile &&
-    rm adir/a2file &&
-    echo "a3file" >> adir/a3file &&
-    echo "bfile line 3" >> adir/bdir/bfile &&
-    rm adir/bdir/b2file &&
-    echo "b3file" > adir/bdir/b3file &&
-    mkdir cdir &&
-    echo "cdir/cfile" > cdir/cfile &&
-    git add -A cdir adir t3 t2 &&
-    git commit -q -m 'v1.2' &&
-    git tag v1.2 &&
-    git push --tags gitcvs.git b1:b1
+		git checkout b1 &&
+		echo "new v1.2" > t3 &&
+		rm t2 &&
+		sed -e "s/line3/line3 - more data/" adir/afile >adir/afileNEW &&
+		mv -f adir/afileNEW adir/afile &&
+		rm adir/a2file &&
+		echo "a3file" >> adir/a3file &&
+		echo "bfile line 3" >> adir/bdir/bfile &&
+		rm adir/bdir/b2file &&
+		echo "b3file" > adir/bdir/b3file &&
+		mkdir cdir &&
+		echo "cdir/cfile" > cdir/cfile &&
+		git add -A cdir adir t3 t2 &&
+		git commit -q -m 'v1.2' &&
+		git tag v1.2 &&
+		git push --tags gitcvs.git b1:b1
 '
=20
 test_expect_success 'cvs -f up (on b1 adir)' '
-    ( cd cvswork/adir &&
-      cvs -f up -d ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1.2 &&
-    check_file cvswork adir/a3file v1.2 &&
-    check_file cvswork adir/bdir/bfile v1.2 &&
-    check_file cvswork adir/bdir/b3file v1.2 &&
-    check_end_tree cvswork
+		( cd cvswork/adir &&
+			cvs -f up -d ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1.2 &&
+		check_file cvswork adir/a3file v1.2 &&
+		check_file cvswork adir/bdir/bfile v1.2 &&
+		check_file cvswork adir/bdir/b3file v1.2 &&
+		check_end_tree cvswork
 '
=20
 test_expect_success 'cvs up (on b1 /)' '
-    ( cd cvswork &&
-      cvs -f up -d ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1.2 &&
-    check_file cvswork t3 v1.2 &&
-    check_file cvswork adir/afile v1.2 &&
-    check_file cvswork adir/a3file v1.2 &&
-    check_file cvswork adir/bdir/bfile v1.2 &&
-    check_file cvswork adir/bdir/b3file v1.2 &&
-    check_file cvswork cdir/cfile v1.2 &&
-    check_end_tree cvswork
+		( cd cvswork &&
+			cvs -f up -d ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1.2 &&
+		check_file cvswork t3 v1.2 &&
+		check_file cvswork adir/afile v1.2 &&
+		check_file cvswork adir/a3file v1.2 &&
+		check_file cvswork adir/bdir/bfile v1.2 &&
+		check_file cvswork adir/bdir/b3file v1.2 &&
+		check_file cvswork cdir/cfile v1.2 &&
+		check_end_tree cvswork
 '
=20
 # Make sure "CVS/Tag" files didn't get messed up:
 test_expect_success 'cvs up (on b1 /) (again; check CVS/Tag files)' '
-    ( cd cvswork &&
-      cvs -f up -d ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1.2 &&
-    check_file cvswork t3 v1.2 &&
-    check_file cvswork adir/afile v1.2 &&
-    check_file cvswork adir/a3file v1.2 &&
-    check_file cvswork adir/bdir/bfile v1.2 &&
-    check_file cvswork adir/bdir/b3file v1.2 &&
-    check_file cvswork cdir/cfile v1.2 &&
-    check_end_tree cvswork
+		( cd cvswork &&
+			cvs -f up -d ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1.2 &&
+		check_file cvswork t3 v1.2 &&
+		check_file cvswork adir/afile v1.2 &&
+		check_file cvswork adir/a3file v1.2 &&
+		check_file cvswork adir/bdir/bfile v1.2 &&
+		check_file cvswork adir/bdir/b3file v1.2 &&
+		check_file cvswork cdir/cfile v1.2 &&
+		check_end_tree cvswork
 '
=20
 # update to another version:
 test_expect_success 'cvs up -r v1' '
-    ( cd cvswork &&
-      cvs -f up -r v1 ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_tree cvswork
+		( cd cvswork &&
+			cvs -f up -r v1 ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_tree cvswork
 '
=20
 test_expect_success 'cvs up' '
-    ( cd cvswork &&
-      cvs -f up ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_tree cvswork
+		( cd cvswork &&
+			cvs -f up ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_tree cvswork
 '
=20
 test_expect_success 'cvs up (again; check CVS/Tag files)' '
-    ( cd cvswork &&
-      cvs -f up -d ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_tree cvswork
+		( cd cvswork &&
+			cvs -f up -d ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_tree cvswork
 '
=20
 test_expect_success 'setup simple b2' '
-    git branch b2 v1 &&
-    git push --tags gitcvs.git b2:b2
+		git branch b2 v1 &&
+		git push --tags gitcvs.git b2:b2
 '
=20
 test_expect_success 'cvs co b2 [into cvswork2]' '
-    cvs -f co -r b2 -d cvswork2 master >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_tree cvswork
+		cvs -f co -r b2 -d cvswork2 master >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_tree cvswork
 '
=20
 test_expect_success 'root dir edit [cvswork2]' '
-    ( cd cvswork2 &&
-      echo "Line 2" >> textfile.c &&
-      test_must_fail cvs -f diff -u >"$WORKDIR/cvsEdit1.diff" &&
-      cvs -f commit -m "edit textfile.c" textfile.c
-    ) >cvsEdit1.log 2>&1
+		( cd cvswork2 &&
+			echo "Line 2" >> textfile.c &&
+			test_must_fail cvs -f diff -u >"$WORKDIR/cvsEdit1.diff" &&
+			cvs -f commit -m "edit textfile.c" textfile.c
+		) >cvsEdit1.log 2>&1
 '
=20
 test_expect_success 'root dir rm file [cvswork2]' '
-    ( cd cvswork2 &&
-      cvs -f rm -f t2 &&
-      cvs -f diff -u > ../cvsEdit2-empty.diff &&
-      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsEdit2-N.diff" &&
-      cvs -f commit -m "rm t2"
-    ) > cvsEdit2.log 2>&1
+		( cd cvswork2 &&
+			cvs -f rm -f t2 &&
+			cvs -f diff -u > ../cvsEdit2-empty.diff &&
+			test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsEdit2-N.diff" &&
+			cvs -f commit -m "rm t2"
+		) > cvsEdit2.log 2>&1
 '
=20
 test_expect_success 'subdir edit/add/rm files [cvswork2' '
-    ( cd cvswork2 &&
-      sed -i -e "s/line 1/line 1 (v2)/" adir/bdir/bfile &&
-      rm adir/bdir/b2file &&
-      cd adir &&
-      cvs -f rm bdir/b2file &&
-      echo "4th file" > bdir/b4file &&
-      cvs -f add bdir/b4file &&
-      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsEdit3.diff" &&
-      git fetch gitcvs.git b2:b2 &&
-      ( cd .. &&
+		( cd cvswork2 &&
+			sed -e "s/line 1/line 1 (v2)/" adir/bdir/bfile >adir/bdir/bfileNEW =
&&
+			mv -f adir/bdir/bfileNEW adir/bdir/bfile &&
+			rm adir/bdir/b2file &&
+			cd adir &&
+			cvs -f rm bdir/b2file &&
+			echo "4th file" > bdir/b4file &&
+			cvs -f add bdir/b4file &&
+			test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsEdit3.diff" &&
+			git fetch gitcvs.git b2:b2 &&
+			( cd .. &&
 	test_must_fail cvs -f diff -u -N -r v1.2 >"$WORKDIR/cvsEdit3-v1.2.dif=
f" &&
 	test_must_fail cvs -f diff -u -N -r v1.2 -r v1 >"$WORKDIR/cvsEdit3-v1=
=2E2-v1.diff"
-      ) &&
-      cvs -f commit -m "various add/rm/edit"
-    ) >cvs.log 2>&1
+			) &&
+			cvs -f commit -m "various add/rm/edit"
+		) >cvs.log 2>&1
 '
=20
 test_expect_success 'validate result of edits [cvswork2]' '
-    git fetch gitcvs.git b2:b2 &&
-    git tag v2 b2 &&
-    git push --tags gitcvs.git b2:b2 &&
-    check_start_tree cvswork2 &&
-    check_file cvswork2 textfile.c v2 &&
-    check_file cvswork2 adir/afile v2 &&
-    check_file cvswork2 adir/a2file v2 &&
-    check_file cvswork2 adir/bdir/bfile v2 &&
-    check_file cvswork2 adir/bdir/b4file v2 &&
-    check_end_full_tree cvswork2 v2
+		git fetch gitcvs.git b2:b2 &&
+		git tag v2 b2 &&
+		git push --tags gitcvs.git b2:b2 &&
+		check_start_tree cvswork2 &&
+		check_file cvswork2 textfile.c v2 &&
+		check_file cvswork2 adir/afile v2 &&
+		check_file cvswork2 adir/a2file v2 &&
+		check_file cvswork2 adir/bdir/bfile v2 &&
+		check_file cvswork2 adir/bdir/b4file v2 &&
+		check_end_full_tree cvswork2 v2
 '
=20
 test_expect_success 'validate basic diffs saved during above cvswork2 =
edits' '
-    test $(grep Index: cvsEdit1.diff | wc -l) =3D 1 &&
-    test ! -s cvsEdit2-empty.diff &&
-    test $(grep Index: cvsEdit2-N.diff | wc -l) =3D 1 &&
-    test $(grep Index: cvsEdit3.diff | wc -l) =3D 3 &&
-    rm -rf diffSandbox &&
-    git clone -q -n . diffSandbox &&
-    ( cd diffSandbox &&
-      git checkout v1 &&
-      git apply -p0 --index <"$WORKDIR/cvsEdit1.diff" &&
-      git apply -p0 --index <"$WORKDIR/cvsEdit2-N.diff" &&
-      git apply -p0 --directory=3Dadir --index <"$WORKDIR/cvsEdit3.dif=
f" &&
-      git diff --exit-code v2 ) >"check_diff_apply.out" 2>&1
+		test $(grep Index: cvsEdit1.diff | wc -l) =3D 1 &&
+		test ! -s cvsEdit2-empty.diff &&
+		test $(grep Index: cvsEdit2-N.diff | wc -l) =3D 1 &&
+		test $(grep Index: cvsEdit3.diff | wc -l) =3D 3 &&
+		rm -rf diffSandbox &&
+		git clone -q -n . diffSandbox &&
+		( cd diffSandbox &&
+			git checkout v1 &&
+			git apply -p0 --index <"$WORKDIR/cvsEdit1.diff" &&
+			git apply -p0 --index <"$WORKDIR/cvsEdit2-N.diff" &&
+			git apply -p0 --directory=3Dadir --index <"$WORKDIR/cvsEdit3.diff" =
&&
+			git diff --exit-code v2 ) >"check_diff_apply.out" 2>&1
 '
=20
 test_expect_success 'validate v1.2 diff saved during last cvswork2 edi=
t' '
-    test $(grep Index: cvsEdit3-v1.2.diff | wc -l) =3D 9 &&
-    check_diff cvsEdit3-v1.2.diff v1.2 v2
+		test $(grep Index: cvsEdit3-v1.2.diff | wc -l) =3D 9 &&
+		check_diff cvsEdit3-v1.2.diff v1.2 v2
 '
=20
 test_expect_success 'validate v1.2 v1 diff saved during last cvswork2 =
edit' '
-    test $(grep Index: cvsEdit3-v1.2-v1.diff | wc -l) =3D 9 &&
-    check_diff cvsEdit3-v1.2-v1.diff v1.2 v1
+		test $(grep Index: cvsEdit3-v1.2-v1.diff | wc -l) =3D 9 &&
+		check_diff cvsEdit3-v1.2-v1.diff v1.2 v1
 '
=20
 test_expect_success 'cvs up [cvswork2]' '
-    ( cd cvswork2 &&
-      cvs -f up ) >cvs.log 2>&1 &&
-    check_start_tree cvswork2 &&
-    check_file cvswork2 textfile.c v2 &&
-    check_file cvswork2 adir/afile v2 &&
-    check_file cvswork2 adir/a2file v2 &&
-    check_file cvswork2 adir/bdir/bfile v2 &&
-    check_file cvswork2 adir/bdir/b4file v2 &&
-    check_end_full_tree cvswork2 v2
+		( cd cvswork2 &&
+			cvs -f up ) >cvs.log 2>&1 &&
+		check_start_tree cvswork2 &&
+		check_file cvswork2 textfile.c v2 &&
+		check_file cvswork2 adir/afile v2 &&
+		check_file cvswork2 adir/a2file v2 &&
+		check_file cvswork2 adir/bdir/bfile v2 &&
+		check_file cvswork2 adir/bdir/b4file v2 &&
+		check_end_full_tree cvswork2 v2
 '
=20
 test_expect_success 'cvs up -r b2 [back to cvswork]' '
-    ( cd cvswork &&
-      cvs -f up -r b2 ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v2 &&
-    check_file cvswork adir/afile v2 &&
-    check_file cvswork adir/a2file v2 &&
-    check_file cvswork adir/bdir/bfile v2 &&
-    check_file cvswork adir/bdir/b4file v2 &&
-    check_end_full_tree cvswork v2
+		( cd cvswork &&
+			cvs -f up -r b2 ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v2 &&
+		check_file cvswork adir/afile v2 &&
+		check_file cvswork adir/a2file v2 &&
+		check_file cvswork adir/bdir/bfile v2 &&
+		check_file cvswork adir/bdir/b4file v2 &&
+		check_end_full_tree cvswork v2
 '
=20
 test_expect_success 'cvs up -r b1' '
-    ( cd cvswork &&
-      cvs -f up -r b1 ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1.2 &&
-    check_file cvswork t3 v1.2 &&
-    check_file cvswork adir/afile v1.2 &&
-    check_file cvswork adir/a3file v1.2 &&
-    check_file cvswork adir/bdir/bfile v1.2 &&
-    check_file cvswork adir/bdir/b3file v1.2 &&
-    check_file cvswork cdir/cfile v1.2 &&
-    check_end_full_tree cvswork v1.2
+		( cd cvswork &&
+			cvs -f up -r b1 ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1.2 &&
+		check_file cvswork t3 v1.2 &&
+		check_file cvswork adir/afile v1.2 &&
+		check_file cvswork adir/a3file v1.2 &&
+		check_file cvswork adir/bdir/bfile v1.2 &&
+		check_file cvswork adir/bdir/b3file v1.2 &&
+		check_file cvswork cdir/cfile v1.2 &&
+		check_end_full_tree cvswork v1.2
 '
=20
 test_expect_success 'cvs up -A' '
-    ( cd cvswork &&
-      cvs -f up -A ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_full_tree cvswork v1
+		( cd cvswork &&
+			cvs -f up -A ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_full_tree cvswork v1
 '
=20
 test_expect_success 'cvs up (check CVS/Tag files)' '
-    ( cd cvswork &&
-      cvs -f up ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_full_tree cvswork v1
+		( cd cvswork &&
+			cvs -f up ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_full_tree cvswork v1
 '
=20
 # This is not really legal CVS, but it seems to work anyway:
 test_expect_success 'cvs up -r heads/b1' '
-    ( cd cvswork &&
-      cvs -f up -r heads/b1 ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1.2 &&
-    check_file cvswork t3 v1.2 &&
-    check_file cvswork adir/afile v1.2 &&
-    check_file cvswork adir/a3file v1.2 &&
-    check_file cvswork adir/bdir/bfile v1.2 &&
-    check_file cvswork adir/bdir/b3file v1.2 &&
-    check_file cvswork cdir/cfile v1.2 &&
-    check_end_full_tree cvswork v1.2
+		( cd cvswork &&
+			cvs -f up -r heads/b1 ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1.2 &&
+		check_file cvswork t3 v1.2 &&
+		check_file cvswork adir/afile v1.2 &&
+		check_file cvswork adir/a3file v1.2 &&
+		check_file cvswork adir/bdir/bfile v1.2 &&
+		check_file cvswork adir/bdir/b3file v1.2 &&
+		check_file cvswork cdir/cfile v1.2 &&
+		check_end_full_tree cvswork v1.2
 '
=20
 # But this should work even if CVS client checks -r more carefully:
 test_expect_success 'cvs up -r heads_-s-b2 (cvsserver escape mechanism=
)' '
-    ( cd cvswork &&
-      cvs -f up -r heads_-s-b2 ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v2 &&
-    check_file cvswork adir/afile v2 &&
-    check_file cvswork adir/a2file v2 &&
-    check_file cvswork adir/bdir/bfile v2 &&
-    check_file cvswork adir/bdir/b4file v2 &&
-    check_end_full_tree cvswork v2
+		( cd cvswork &&
+			cvs -f up -r heads_-s-b2 ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v2 &&
+		check_file cvswork adir/afile v2 &&
+		check_file cvswork adir/a2file v2 &&
+		check_file cvswork adir/bdir/bfile v2 &&
+		check_file cvswork adir/bdir/b4file v2 &&
+		check_end_full_tree cvswork v2
 '
=20
 v1hash=3D$(git rev-parse v1)
 test_expect_success 'cvs up -r $(git rev-parse v1)' '
-    test -n "$v1hash" &&
-    ( cd cvswork &&
-      cvs -f up -r "$v1hash" ) >cvs.log 2>&1 &&
-    check_start_tree cvswork &&
-    check_file cvswork textfile.c v1 &&
-    check_file cvswork t2 v1 &&
-    check_file cvswork adir/afile v1 &&
-    check_file cvswork adir/a2file v1 &&
-    check_file cvswork adir/bdir/bfile v1 &&
-    check_file cvswork adir/bdir/b2file v1 &&
-    check_end_full_tree cvswork v1
+		test -n "$v1hash" &&
+		( cd cvswork &&
+			cvs -f up -r "$v1hash" ) >cvs.log 2>&1 &&
+		check_start_tree cvswork &&
+		check_file cvswork textfile.c v1 &&
+		check_file cvswork t2 v1 &&
+		check_file cvswork adir/afile v1 &&
+		check_file cvswork adir/a2file v1 &&
+		check_file cvswork adir/bdir/bfile v1 &&
+		check_file cvswork adir/bdir/b2file v1 &&
+		check_end_full_tree cvswork v1
 '
=20
 test_expect_success 'cvs diff -r v1 -u' '
-    ( cd cvswork &&
-      cvs -f diff -r v1 -u ) >cvsDiff.out 2>cvs.log &&
-    test ! -s cvsDiff.out &&
-    test ! -s cvs.log
+		( cd cvswork &&
+			cvs -f diff -r v1 -u ) >cvsDiff.out 2>cvs.log &&
+		test ! -s cvsDiff.out &&
+		test ! -s cvs.log
 '
=20
 test_expect_success 'cvs diff -N -r v2 -u' '
-    ( cd cvswork &&
-      test_must_fail cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log =
&&
-    test ! -s cvs.log &&
-    test -s cvsDiff.out &&
-    check_diff cvsDiff.out v2 v1 > check_diff.out 2>&1
+		( cd cvswork &&
+			test_must_fail cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log &&
+		test ! -s cvs.log &&
+		test -s cvsDiff.out &&
+		check_diff cvsDiff.out v2 v1 > check_diff.out 2>&1
 '
=20
 test_expect_success 'cvs diff -N -r v2 -r v1.2' '
-    ( cd cvswork &&
-      test_must_fail cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>=
cvs.log &&
-    test ! -s cvs.log &&
-    test -s cvsDiff.out &&
-    check_diff cvsDiff.out v2 v1.2 > check_diff.out 2>&1
+		( cd cvswork &&
+			test_must_fail cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>cvs=
=2Elog &&
+		test ! -s cvs.log &&
+		test -s cvsDiff.out &&
+		check_diff cvsDiff.out v2 v1.2 > check_diff.out 2>&1
 '
=20
 test_expect_success 'apply early [cvswork3] diff to b3' '
-    git clone -q . gitwork3 &&
-    ( cd gitwork3 &&
-      git checkout -b b3 v1 &&
-      git apply -p0 --index <"$WORKDIR/cvswork3edit.diff" &&
-      git commit -m "cvswork3 edits applied" ) &&
-    git fetch gitwork3 b3:b3 &&
-    git tag v3 b3
+		git clone -q . gitwork3 &&
+		( cd gitwork3 &&
+			git checkout -b b3 v1 &&
+			git apply -p0 --index <"$WORKDIR/cvswork3edit.diff" &&
+			git commit -m "cvswork3 edits applied" ) &&
+		git fetch gitwork3 b3:b3 &&
+		git tag v3 b3
 '
=20
 test_expect_success 'check [cvswork3] diff' '
-    ( cd cvswork3 &&
-      test_must_fail cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>cvs=
=2Elog &&
-    test ! -s cvs.log &&
-    test -s cvsDiff.out &&
-    test $(grep Index: cvsDiff.out | wc -l) =3D 3 &&
-    test_cmp cvsDiff.out cvswork3edit.diff &&
-    check_diff cvsDiff.out v1 v3 > check_diff.out 2>&1
+		( cd cvswork3 &&
+			test_must_fail cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>cvs.lo=
g &&
+		test ! -s cvs.log &&
+		test -s cvsDiff.out &&
+		test $(grep Index: cvsDiff.out | wc -l) =3D 3 &&
+		test_cmp cvsDiff.out cvswork3edit.diff &&
+		check_diff cvsDiff.out v1 v3 > check_diff.out 2>&1
 '
=20
 test_expect_success 'merge early [cvswork3] b3 with b1' '
-    ( cd gitwork3 &&
-      git merge "message" HEAD b1 )
-    git fetch gitwork3 b3:b3 &&
-    git tag v3merged b3 &&
-    git push --tags gitcvs.git b3:b3
+		( cd gitwork3 &&
+			git merge "message" HEAD b1 )
+		git fetch gitwork3 b3:b3 &&
+		git tag v3merged b3 &&
+		git push --tags gitcvs.git b3:b3
 '
=20
 # This test would fail if cvsserver properly created a ".#afile"* file
 # for the merge.
 # TODO: Validate that the .# file was saved properly, and then
-#   delete/ignore it when checking the tree.
+#		delete/ignore it when checking the tree.
 test_expect_success 'cvs up dirty [cvswork3]' '
-    ( cd cvswork3 &&
-      cvs -f up &&
-      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsDiff.out" ) >cvs.=
log 2>&1 &&
-    test -s cvsDiff.out &&
-    test $(grep Index: cvsDiff.out | wc -l) =3D 2
-    check_start_tree cvswork3 &&
-    check_file cvswork3 textfile.c v3merged &&
-    check_file cvswork3 t3 v3merged &&
-    check_file cvswork3 adir/afile v3merged &&
-    check_file cvswork3 adir/a3file v3merged &&
-    check_file cvswork3 adir/afile5 v3merged &&
-    check_file cvswork3 adir/bdir/bfile v3merged &&
-    check_file cvswork3 adir/bdir/b3file v3merged &&
-    check_file cvswork3 cdir/cfile v3merged &&
-    check_end_full_tree cvswork3 v3merged
+		( cd cvswork3 &&
+			cvs -f up &&
+			test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsDiff.out" ) >cvs.log=
 2>&1 &&
+		test -s cvsDiff.out &&
+		test $(grep Index: cvsDiff.out | wc -l) =3D 2
+		check_start_tree cvswork3 &&
+		check_file cvswork3 textfile.c v3merged &&
+		check_file cvswork3 t3 v3merged &&
+		check_file cvswork3 adir/afile v3merged &&
+		check_file cvswork3 adir/a3file v3merged &&
+		check_file cvswork3 adir/afile5 v3merged &&
+		check_file cvswork3 adir/bdir/bfile v3merged &&
+		check_file cvswork3 adir/bdir/b3file v3merged &&
+		check_file cvswork3 cdir/cfile v3merged &&
+		check_end_full_tree cvswork3 v3merged
 '
=20
 # TODO: test cvs status
=20
 test_expect_success 'cvs commit [cvswork3' '
-    ( cd cvswork3 &&
-      cvs -f commit -m "dirty sandbox after auto-merge"
-    ) > cvs.log 2>&1 &&
-    check_start_tree cvswork3 &&
-    check_file cvswork3 textfile.c v3merged &&
-    check_file cvswork3 t3 v3merged &&
-    check_file cvswork3 adir/afile v3merged &&
-    check_file cvswork3 adir/a3file v3merged &&
-    check_file cvswork3 adir/afile5 v3merged &&
-    check_file cvswork3 adir/bdir/bfile v3merged &&
-    check_file cvswork3 adir/bdir/b3file v3merged &&
-    check_file cvswork3 cdir/cfile v3merged &&
-    check_end_full_tree cvswork3 v3merged &&
-    git fetch gitcvs.git b3:b4 &&
-    git tag v4.1 b4 &&
-    git diff --exit-code v4.1 v3merged > check_diff_apply.out 2>&1
+		( cd cvswork3 &&
+			cvs -f commit -m "dirty sandbox after auto-merge"
+		) > cvs.log 2>&1 &&
+		check_start_tree cvswork3 &&
+		check_file cvswork3 textfile.c v3merged &&
+		check_file cvswork3 t3 v3merged &&
+		check_file cvswork3 adir/afile v3merged &&
+		check_file cvswork3 adir/a3file v3merged &&
+		check_file cvswork3 adir/afile5 v3merged &&
+		check_file cvswork3 adir/bdir/bfile v3merged &&
+		check_file cvswork3 adir/bdir/b3file v3merged &&
+		check_file cvswork3 cdir/cfile v3merged &&
+		check_end_full_tree cvswork3 v3merged &&
+		git fetch gitcvs.git b3:b4 &&
+		git tag v4.1 b4 &&
+		git diff --exit-code v4.1 v3merged > check_diff_apply.out 2>&1
 '
=20
 test_done
--=20
1.8.0.197.g5a90748
