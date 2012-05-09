From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 02/19] tests: add tests for the bash prompt functions
 in the completion script
Date: Wed, 09 May 2012 10:07:03 +0200
Message-ID: <4FAA25A7.4020300@viscovery.net>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de> <1336524290-30023-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 10:07:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS1vk-0004mO-QF
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 10:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921Ab2EIIHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 04:07:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26580 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751027Ab2EIIHG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 04:07:06 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SS1vL-0001Ev-Nd; Wed, 09 May 2012 10:07:04 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6DDC41660F;
	Wed,  9 May 2012 10:07:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1336524290-30023-3-git-send-email-szeder@ira.uka.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197457>

Am 5/9/2012 2:44, schrieb SZEDER G=C3=A1bor:
> The tests cover the discovery of the '.git' directory in the
> __gitdir() function in different scenarios, and the prompt itself,
> i.e. branch name, detached heads, operations (rebase, merge,
> cherry-pick, bisect), and status indicators (dirty, stash, untracked
> files; but not the upstream status).

The following patch contains fixups are needed to pass the tests at
this point plus a few more changes.

--- >8 ---
=46rom: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] fixup! tests: add tests for the bash prompt functions =
in the
 completion script

- $TRASH_DIRECTORY is /c/dir style path, but git produces c:/dir style
  paths. Use $(pwd), which is short for $(pwd -W) that produces the
  latter, to assemble expected test data and paths read by git.

- As long as GIT_DIR is only exported for use by git and not used by
  the completion functions, the move to $(pwd) is only cosmetic and
  for consistency.

- Insert a #!/bin/sh in the shell script to ensure the test will pass
  should git-rebase ever be ported to C.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9903-bash-prompt.sh |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index a6c9ce9..3880c56 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -32,9 +32,9 @@ test_expect_success 'setup for prompt tests' '
 '
=20
 test_expect_success 'gitdir - from command line (through $__git_dir)' =
'
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$(pwd)/otherrepo/.git" > expected &&
 	(
-		__git_dir=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		__git_dir=3D"$(pwd)/otherrepo/.git" &&
 		__gitdir > "$actual"
 	) &&
 	test_cmp expected "$actual"
@@ -59,7 +59,7 @@ test_expect_success 'gitdir - .git directory in cwd' =
'
 '
=20
 test_expect_success 'gitdir - .git directory in parent' '
-	echo "$TRASH_DIRECTORY/.git" > expected &&
+	echo "$(pwd)/.git" > expected &&
 	(
 		cd subdir/subsubdir &&
 		__gitdir > "$actual"
@@ -77,7 +77,7 @@ test_expect_success 'gitdir - cwd is a .git directory=
' '
 '
=20
 test_expect_success 'gitdir - parent is a .git directory' '
-	echo "$TRASH_DIRECTORY/.git" > expected &&
+	echo "$(pwd)/.git" > expected &&
 	(
 		cd .git/refs/heads &&
 		__gitdir > "$actual"
@@ -86,9 +86,9 @@ test_expect_success 'gitdir - parent is a .git direct=
ory' '
 '
=20
 test_expect_failure 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$(pwd)/otherrepo/.git" > expected &&
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		GIT_DIR=3D"$(pwd)/otherrepo/.git" &&
 		export GIT_DIR &&
 		__gitdir > "$actual"
 	) &&
@@ -96,9 +96,9 @@ test_expect_failure 'gitdir - $GIT_DIR set while .git=
 directory in cwd' '
 '
=20
 test_expect_success 'gitdir - $GIT_DIR set while .git directory in par=
ent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$(pwd)/otherrepo/.git" > expected &&
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
+		GIT_DIR=3D"$(pwd)/otherrepo/.git" &&
 		export GIT_DIR &&
 		cd subdir &&
 		__gitdir > "$actual"
@@ -107,8 +107,8 @@ test_expect_success 'gitdir - $GIT_DIR set while .g=
it directory in parent' '
 '
=20
 test_expect_success 'gitdir - gitfile in cwd' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	echo "$(pwd)/otherrepo/.git" > expected &&
+	echo "gitdir: $(pwd)/otherrepo/.git" > subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
@@ -118,8 +118,8 @@ test_expect_success 'gitdir - gitfile in cwd' '
 '
=20
 test_expect_success 'gitdir - gitfile in parent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	echo "$(pwd)/otherrepo/.git" > expected &&
+	echo "gitdir: $(pwd)/otherrepo/.git" > subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
@@ -129,7 +129,7 @@ test_expect_success 'gitdir - gitfile in parent' '
 '
=20
 test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks'=
 '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$(pwd)/otherrepo/.git" > expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
 	ln -s otherrepo/dir link &&
@@ -238,11 +238,12 @@ test_expect_success 'prompt - interactive rebase'=
 '
 	printf " (b1|REBASE-i)" > expected
 	echo "#!$SHELL_PATH" >fake_editor.sh &&
 	cat >>fake_editor.sh <<\EOF &&
+#!/bin/sh
 echo "edit $(git log -1 --format=3D"%h")" > "$1"
 EOF
 	test_when_finished "rm -f fake_editor.sh" &&
 	chmod a+x fake_editor.sh &&
-	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
+	test_set_editor "$(pwd)/fake_editor.sh" &&
 	git checkout b1 &&
 	test_when_finished "git checkout master" &&
 	git rebase -i HEAD^ &&
--=20
1.7.10.1.1689.gacdfbde
