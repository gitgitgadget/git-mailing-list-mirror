From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 15/19] mingw: work around pwd issues in the tests
Date: Sun, 24 Jan 2016 16:45:18 +0100 (CET)
Message-ID: <a58158d32cd9c1c2603dfc84458dea7e52d6ac0e.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-778626412-1453650318=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMr2-0001Qm-ML
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbcAXPpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:54938 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbcAXPpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:21 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MCLQ1-1aEo9935bl-00953S; Sun, 24 Jan 2016 16:45:18
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:PTk40rjTOjsrz8wOAAI658EJFm0IWXKyYw7qCD9VP9p+i2JVWvt
 keMTVzUNHVqEJgX2fh9gLxHtE5Gaj9dhB9iMBC+Yh1FBWiqWkka3tcoJNJH/5Pcoy9vnNIJ
 K6SIcK+ke3OsXPfRdArzncCs8T8t9xNLQw2EvNUHXczCXMWLrYrzgpRF2jk3H9KpbnM6JW9
 KYpcl9gxoipXzaCGsdpLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jVWfwMl1HG0=:NrIfkPBJRmMgg+hMko644H
 m7E1W3VzqArgs+B7WZxyisaPm3AmTbDEebFMb06mUnVosbWukMrBRhTImmM+gAEYJIJqRdKDF
 savnE9rHci+CXr5YgDeIHwzrQktumo/PKT221DeX3U7psJfdjSU0oAxDMVFQBWZWeONpIyGP+
 LI6YUm/HuMeQ8U7eOdM7B3KDB88EVNmw5wFhNFXaHENF23aKkc4icJgJVJANGtVLFPFvSc30V
 lD8OmsA5ozI/Qlrus0qdP1ztTw4YS8sua7yreYikXb11sC2X2gYEpVTyOvGJhyvbfjHK673h5
 b+ZhmzXFoJysbBYmTFTuBdpBR8DXeNzlkg15fLE5QSCcoERrbP+x68lrnMNGorwH/GYb4yJIg
 OvprCyrAcl0ye5BLTlnetY2+X+8CVwiMbMKCRF+j+8B5dIr70K/3sKpJZHtDFD6Q2yOvVabRC
 Co0SUeTh7y5L4VtA7a3MQAL9JB8R63QZFjRDsOiD/wuYCKAXyTYR/fndXd5kYw2fYmwQbAOod
 IuoBJCMhk4I7iBSj6npCbqBdBPA6OmIhxbTAF+P4vwMN9eVsiy3RB+7niSBNi2js09oWiA35c
 yc4+W6Fhca8sPk7B6nv7rz5AAB9v6cnEeeiYYhGEtW/91NMGRiDNIe2FYKux1HUaUzQDSOpwD
 c/uAL4XtRZyvVRgAp6enZuavMUYttCoxRkI/JtczT0s8PksuK7BkGtASJlzRXlrpkwlx/nOux
 /xxCDSJmY5KnuQw8H+5KKBvA1gFMt5lyEYRRaQBJhYEGvNqatH4YI4pwUTKBSJ4zUz31PHkV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284679>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-778626412-1453650318=:2964
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE

In Git for Windows' SDK, the tests are run using a Bash that relies on
the POSIX emulation layer MSYS2 (itself a friendly fork of Cygwin). As
such, paths in tests can be POSIX paths. As soon as those paths are
passed to git.exe (which does *not* use the POSIX emulation layer),
those paths are converted into Windows paths, though. This happens
for command-line parameters, but not when reading, say, config variables.

To help with that, the `pwd` command is overridden to return the Windows
path of the current working directory when testing Git on Windows.

However, when talking to anything using the POSIX emulation layer, it is
really much better to use POSIX paths because Windows paths contain a
colon after the drive letter that will easily be mistaken for the common
separator in path lists.

So let's just use the $PWD variable when the POSIX path is needed.

This lets t7800-difftool.sh, t9400-git-cvsserver-server.sh,
t9402-git-cvsserver-refs.sh and t9401-git-cvsserver-crlf.sh pass in Git
for Windows' SDK.

Note: the cvsserver tests require not only the `cvs` package (install
it into Git for Windows' SDK via `pacman -S cvs`) but also the Perl
SQLite bindings (install them into Git for Windows' SDK via
`cpan DBD::SQLite`).

This patch is based on earlier work by =B8=B6=B4=A9=BF=A4 and Karsten Blees=
=2E

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh             | 14 +++++++-------
 t/t9400-git-cvsserver-server.sh |  6 +++---
 t/t9401-git-cvsserver-crlf.sh   |  6 +++---
 t/t9402-git-cvsserver-refs.sh   |  6 +++---
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ec8bc8c..4e713f7 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -430,11 +430,11 @@ EOF
 test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without u=
nstaged changes' '
 =09cat >expect <<-EOF &&
 =09file
-=09$(pwd)/file
+=09$PWD/file
 =09file2
-=09$(pwd)/file2
+=09$PWD/file2
 =09sub/sub
-=09$(pwd)/sub/sub
+=09$PWD/sub/sub
 =09EOF
 =09git difftool --dir-diff --symlink \
 =09=09--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
@@ -448,14 +448,14 @@ EOF
 run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change=
' '
 =09test_when_finished git reset --hard &&
 =09echo "orig content" >file &&
-=09git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
+=09git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
 =09echo "new content" >expect &&
 =09test_cmp expect file
 '
=20
 run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged cha=
nge' '
 =09test_when_finished git reset --hard &&
-=09git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
+=09git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
 =09echo "new content" >expect &&
 =09test_cmp expect file
 '
@@ -466,7 +466,7 @@ EOF
=20
 test_expect_success PERL 'difftool --no-symlinks does not overwrite workin=
g tree file ' '
 =09echo "orig content" >file &&
-=09git difftool --dir-diff --no-symlinks --extcmd "$(pwd)/modify-file" bra=
nch &&
+=09git difftool --dir-diff --no-symlinks --extcmd "$PWD/modify-file" branc=
h &&
 =09echo "new content" >expect &&
 =09test_cmp expect file
 '
@@ -482,7 +482,7 @@ test_expect_success PERL 'difftool --no-symlinks detect=
s conflict ' '
 =09=09TMPDIR=3D$TRASH_DIRECTORY &&
 =09=09export TMPDIR &&
 =09=09echo "orig content" >file &&
-=09=09test_must_fail git difftool --dir-diff --no-symlinks --extcmd "$(pwd=
)/modify-both-files" branch &&
+=09=09test_must_fail git difftool --dir-diff --no-symlinks --extcmd "$PWD/=
modify-both-files" branch &&
 =09=09echo "wt content" >expect &&
 =09=09test_cmp expect file &&
 =09=09echo "tmp content" >expect &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server=
=2Esh
index 6146c3f..d708cbf 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -25,11 +25,11 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     test_done
 }
=20
-WORKDIR=3D$(pwd)
-SERVERDIR=3D$(pwd)/gitcvs.git
+WORKDIR=3D$PWD
+SERVERDIR=3D$PWD/gitcvs.git
 git_config=3D"$SERVERDIR/config"
 CVSROOT=3D":fork:$SERVERDIR"
-CVSWORK=3D"$(pwd)/cvswork"
+CVSWORK=3D"$PWD/cvswork"
 CVS_SERVER=3Dgit-cvsserver
 export CVSROOT CVS_SERVER
=20
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 5a4ed28..f324b9f 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -74,11 +74,11 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
 }
=20
 unset GIT_DIR GIT_CONFIG
-WORKDIR=3D$(pwd)
-SERVERDIR=3D$(pwd)/gitcvs.git
+WORKDIR=3D$PWD
+SERVERDIR=3D$PWD/gitcvs.git
 git_config=3D"$SERVERDIR/config"
 CVSROOT=3D":fork:$SERVERDIR"
-CVSWORK=3D"$(pwd)/cvswork"
+CVSWORK=3D"$PWD/cvswork"
 CVS_SERVER=3Dgit-cvsserver
 export CVSROOT CVS_SERVER
=20
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index d00df08..6d2d3c8 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -82,11 +82,11 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
 }
=20
 unset GIT_DIR GIT_CONFIG
-WORKDIR=3D$(pwd)
-SERVERDIR=3D$(pwd)/gitcvs.git
+WORKDIR=3D$PWD
+SERVERDIR=3D$PWD/gitcvs.git
 git_config=3D"$SERVERDIR/config"
 CVSROOT=3D":fork:$SERVERDIR"
-CVSWORK=3D"$(pwd)/cvswork"
+CVSWORK=3D"$PWD/cvswork"
 CVS_SERVER=3Dgit-cvsserver
 export CVSROOT CVS_SERVER
=20
--=20
2.7.0.windows.1.7.g55a05c8


--8323329-778626412-1453650318=:2964--
