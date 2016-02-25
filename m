From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 13/21] rev-parse: add '--absolute-git-dir' option
Date: Thu, 25 Feb 2016 23:50:42 +0100
Message-ID: <1456440650-32623-14-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:53:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4mt-0006kt-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbcBYWxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:53:31 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35828 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWxb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:53:31 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4mj-0007uU-0G; Thu, 25 Feb 2016 23:53:26 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440806.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287462>

Some scripts can benefit from not having to deal with the possibility
of relative paths to the repository, but the output of 'git rev-parse
--git-dir' can be a relative path.  Case in point: supporting 'git -C
<path>' in our Bash completion script turned out to be considerably
more difficult, error prone and required more subshells and git
processes when we had to cope with a relative path to the .git
directory.

Help these use cases and teach 'git rev-parse' a new
'--absolute-git-dir' option which always outputs a canonicalized
absolute path to the .git directory, regardless of whether the path is
discovered automatically or is specified via $GIT_DIR or 'git
--git-dir=3D<path>'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-rev-parse.txt |  4 ++++
 builtin/rev-parse.c             | 29 +++++++++++++++++++++--------
 t/t1500-rev-parse.sh            | 17 ++++++++++-------
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index b6c6326cdc7b..fb06e3118570 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -216,6 +216,10 @@ If `$GIT_DIR` is not defined and the current direc=
tory
 is not detected to lie in a Git repository or work tree
 print a message to stderr and exit with nonzero status.
=20
+--absolute-git-dir::
+	Like `--git-dir`, but its output is always the canonicalized
+	absolute path.
+
 --git-common-dir::
 	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
=20
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index cf8487b3b95f..90a4dd6032c0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -744,17 +744,30 @@ int cmd_rev_parse(int argc, const char **argv, co=
nst char *prefix)
 				putchar('\n');
 				continue;
 			}
-			if (!strcmp(arg, "--git-dir")) {
+			if (!strcmp(arg, "--git-dir") ||
+			    !strcmp(arg, "--absolute-git-dir")) {
 				const char *gitdir =3D getenv(GIT_DIR_ENVIRONMENT);
 				char *cwd;
 				int len;
-				if (gitdir) {
-					puts(gitdir);
-					continue;
-				}
-				if (!prefix) {
-					puts(".git");
-					continue;
+				if (arg[2] =3D=3D 'g') {	/* --git-dir */
+					if (gitdir) {
+						puts(gitdir);
+						continue;
+					}
+					if (!prefix) {
+						puts(".git");
+						continue;
+					}
+				} else {		/* --absolute-git-dir */
+					if (!gitdir && !prefix)
+						gitdir =3D ".git";
+					if (gitdir) {
+						char absolute_path[PATH_MAX];
+						if (!realpath(gitdir, absolute_path))
+							die_errno(_("unable to get absolute path"));
+						puts(absolute_path);
+						continue;
+					}
 				}
 				cwd =3D xgetcwd();
 				len =3D strlen(cwd);
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee07779d64..617fcd821309 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -31,23 +31,26 @@ test_rev_parse() {
 	"test '$1' =3D \"\$(git rev-parse --git-dir)\""
 	shift
 	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: absolute-git-dir" \
+	"verbose test '$1' =3D \"\$(git rev-parse --absolute-git-dir)\""
 }
=20
-# label is-bare is-inside-git is-inside-work prefix git-dir
+# label is-bare is-inside-git is-inside-work prefix git-dir absolute-g=
it-dir
=20
 ROOT=3D$(pwd)
=20
-test_rev_parse toplevel false false true '' .git
+test_rev_parse toplevel false false true '' .git "$ROOT/.git"
=20
 cd .git || exit 1
-test_rev_parse .git/ false true false '' .
+test_rev_parse .git/ false true false '' . "$ROOT/.git"
 cd objects || exit 1
-test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
+test_rev_parse .git/objects/ false true false '' "$ROOT/.git" "$ROOT/.=
git"
 cd ../.. || exit 1
=20
 mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
+test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git" "$R=
OOT/.git"
 cd ../.. || exit 1
=20
 git config core.bare true
@@ -63,7 +66,7 @@ GIT_CONFIG=3D"$(pwd)"/../.git/config
 export GIT_DIR GIT_CONFIG
=20
 git config core.bare false
-test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D false' false false tr=
ue ''
+test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D false' false false tr=
ue '' "../.git" "$ROOT/.git"
=20
 git config core.bare true
 test_rev_parse 'GIT_DIR=3D../.git, core.bare =3D true' true false fals=
e ''
@@ -76,7 +79,7 @@ GIT_DIR=3D../repo.git
 GIT_CONFIG=3D"$(pwd)"/../repo.git/config
=20
 git config core.bare false
-test_rev_parse 'GIT_DIR=3D../repo.git, core.bare =3D false' false fals=
e true ''
+test_rev_parse 'GIT_DIR=3D../repo.git, core.bare =3D false' false fals=
e true '' "../repo.git" "$ROOT/repo.git"
=20
 git config core.bare true
 test_rev_parse 'GIT_DIR=3D../repo.git, core.bare =3D true' true false =
false ''
--=20
2.7.2.410.g92cb358
