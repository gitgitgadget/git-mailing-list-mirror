From: Jiang Xin <worldhello.net@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20test=3A=20some=20testcases=20failed=20if=20cwd=20is=20on=20a=20symlink?=
Date: Tue, 24 Jul 2012 16:00:01 +0800
Message-ID: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 10:00:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sta2a-0001Vh-Gz
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 10:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab2GXIAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jul 2012 04:00:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36187 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084Ab2GXIAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 04:00:17 -0400
Received: by pbbrp8 with SMTP id rp8so12284655pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Dved189v1uHuHF7SFCl55jybFjyN5deeBJCJ6xwwHfk=;
        b=azO6xGsIr91bhsJhzYBsHaSVIJOlyA38H3RrCdVaWkkcjnK6hsHhuXIs+5giL/uQOV
         oNWOMpVH2GIKVpJKkz8IqfFRCSzkiJWoRCnuAsbdnjB0LfoD+oZEq2EsgREQKq3h9qq0
         06mWyn2s6Sn+u5qit5FvcZ+RmSl1DsDnU4n6CoerbntadlP4u79TDFC2B8G8HqJXKzyn
         g13ktiyGQ8cOyYUkIpUvNvYalYs0z2AYA53DCma+8t7NedvyhvMVPEm363eykQlGVSM5
         0+RyIKZuMB2nuZRM4unHkhCEetcTSVHY6qWoEXM2Qhz3Xq6A5bNGlDEIwiLOxJ3tOuxS
         k0pA==
Received: by 10.68.224.225 with SMTP id rf1mr42586812pbc.55.1343116816703;
        Tue, 24 Jul 2012 01:00:16 -0700 (PDT)
Received: from jx.bj.ossxp.com.bj.ossxp.com ([123.116.228.123])
        by mx.google.com with ESMTPS id qd10sm11676626pbb.38.2012.07.24.01.00.12
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 01:00:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202020>

Run command 'git rev-parse --git-dir' under subdir will return realpath
of '.git' directory. Some test scripts compare this realpath against
"$TRASH_DIRECTORY", they are not equal if current working directory is
on a symlink.

In this fix, get realpath of "$TRASH_DIRECTORY", store it in
"$TRASH_REALPATH" variable, and use it when necessary.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t4035-diff-quiet.sh  |  8 +++++---
 t/t9903-bash-prompt.sh | 13 +++++++------
 2 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9=EF=BC=8C=E6=8F=
=92=E5=85=A5 12 =E8=A1=8C(+)=EF=BC=8C=E5=88=A0=E9=99=A4 9 =E8=A1=8C(-)

diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 23141..5855 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -4,6 +4,8 @@ test_description=3D'Return value of diffs'
=20
 . ./test-lib.sh
=20
+TRASH_REALPATH=3D"$(cd "$TRASH_DIRECTORY"; pwd -P)"
+
 test_expect_success 'setup' '
 	echo 1 >a &&
 	git add . &&
@@ -102,7 +104,7 @@ test_expect_success 'git diff, one file outside rep=
o' '
=20
 test_expect_success 'git diff, both files outside repo' '
 	(
-		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY/test-outside" &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_REALPATH/test-outside" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd test-outside/non/git &&
 		test_expect_code 0 git diff --quiet a matching-file &&
@@ -120,7 +122,7 @@ test_expect_success 'git diff --ignore-space-at-eol=
, one file outside repo' '
=20
 test_expect_success 'git diff --ignore-space-at-eol, both files outsid=
e repo' '
 	(
-		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY/test-outside" &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_REALPATH/test-outside" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd test-outside/non/git &&
 		test_expect_code 0 git diff --quiet --ignore-space-at-eol a trailing=
-space &&
@@ -139,7 +141,7 @@ test_expect_success 'git diff --ignore-all-space, o=
ne file outside repo' '
=20
 test_expect_success 'git diff --ignore-all-space, both files outside r=
epo' '
 	(
-		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY/test-outside" &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_REALPATH/test-outside" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd test-outside/non/git &&
 		test_expect_code 0 git diff --quiet --ignore-all-space a trailing-sp=
ace &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index f17c1f..275bc 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -10,6 +10,7 @@ test_description=3D'test git-specific bash prompt fun=
ctions'
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
=20
 actual=3D"$TRASH_DIRECTORY/actual"
+TRASH_REALPATH=3D"$(cd "$TRASH_DIRECTORY"; pwd -P)"
=20
 test_expect_success 'setup for prompt tests' '
 	mkdir -p subdir/subsubdir &&
@@ -59,7 +60,7 @@ test_expect_success 'gitdir - .git directory in cwd' =
'
 '
=20
 test_expect_success 'gitdir - .git directory in parent' '
-	echo "$TRASH_DIRECTORY/.git" > expected &&
+	echo "$TRASH_REALPATH/.git" > expected &&
 	(
 		cd subdir/subsubdir &&
 		__gitdir > "$actual"
@@ -77,7 +78,7 @@ test_expect_success 'gitdir - cwd is a .git directory=
' '
 '
=20
 test_expect_success 'gitdir - parent is a .git directory' '
-	echo "$TRASH_DIRECTORY/.git" > expected &&
+	echo "$TRASH_REALPATH/.git" > expected &&
 	(
 		cd .git/refs/heads &&
 		__gitdir > "$actual"
@@ -115,7 +116,7 @@ test_expect_success 'gitdir - non-existing $GIT_DIR=
' '
 '
=20
 test_expect_success 'gitdir - gitfile in cwd' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_REALPATH/otherrepo/.git" > expected &&
 	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
@@ -126,7 +127,7 @@ test_expect_success 'gitdir - gitfile in cwd' '
 '
=20
 test_expect_success 'gitdir - gitfile in parent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_REALPATH/otherrepo/.git" > expected &&
 	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
@@ -137,7 +138,7 @@ test_expect_success 'gitdir - gitfile in parent' '
 '
=20
 test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks'=
 '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_REALPATH/otherrepo/.git" > expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
 	ln -s otherrepo/dir link &&
@@ -152,7 +153,7 @@ test_expect_success SYMLINKS 'gitdir - resulting pa=
th avoids symlinks' '
 test_expect_success 'gitdir - not a git repository' '
 	(
 		cd subdir/subsubdir &&
-		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_REALPATH" &&
 		export GIT_CEILING_DIRECTORIES &&
 		test_must_fail __gitdir
 	)
--=20
1.7.12.rc0.16.gf4916ac
