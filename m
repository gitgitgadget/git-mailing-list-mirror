From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] sh-setup: make require_clean_work_tree() work on orphan branches
Date: Tue, 24 Nov 2015 15:45:45 +0100
Message-ID: <1448376345-27339-2-git-send-email-szeder@ira.uka.de>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 15:46:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ErP-0005O7-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 15:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbbKXOqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 09:46:21 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57119 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319AbbKXOqV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2015 09:46:21 -0500
Received: from x4db01475.dyn.telefonica.de ([77.176.20.117] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a1ErI-0007BA-D2; Tue, 24 Nov 2015 15:46:17 +0100
X-Mailer: git-send-email 2.6.3.418.gc3b7987
In-Reply-To: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1448376378.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281617>

git-sh-setup's require_clean_work_tree() always exits with error on an
orphan branch, even when the index and worktree are both clean.  The
reason is that require_clean_work_tree() starts off with verifying
HEAD, to make sure that it can safely pass HEAD to 'git diff-index'
later when it comes to checking the cleanness of the index, and errors
out finding the invalid HEAD of the orphan branch.

There are scripts requiring a clean worktree that should work on an
orphan branch as well, and those should be able to use this function
instead of duplicating its functionality and nice error reporting in a
way that handles orphan branches.

=46ixing this is easy: the index should be compared to the empty tree
while on an orphan branch, and to HEAD otherwise.

However, just fixing require_clean_work_tree() this way is also
dangerous, because scripts must take care to work properly on orphan
branches.  Currently a script calling require_clean_work_tree() would
exit on a clean orphan branch, but with the simple fix it would
continue executing and who knows what the consequences might be if
the script is not prepared for orphan branches.

Let scripts tell git-sh-setup that they are capable of dealing with
orphan branches by setting the ORPHAN_OK variable, similar to how the
ability to run in a subdirectory must be signalled by setting
SUBDIRECTORY_OK.  Only if ORPHAN_OK is set while on an orphan branch
will require_clean_work_tree() go on and compare the index and
worktree to the empty tree, otherwise it will exit with error even
when the index and worktree are clean, i.e the default exit behavior
doesn't change.

Also provide an error message in the orphan branch/invalid HEAD case
that is consistent in style with the function's other error messages
instead of the error message coming straight from 'git rev-parse
--verify'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-sh-setup.txt     |  3 ++-
 git-sh-setup.sh                    | 16 ++++++++++++++--
 t/t2301-require-clean-work-tree.sh | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setu=
p.txt
index 4f67c4cde6..bccaa2488f 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -25,7 +25,8 @@ Before sourcing it, your script should set up a few v=
ariables;
 `USAGE` (and `LONG_USAGE`, if any) is used to define message
 given by `usage()` shell function.  `SUBDIRECTORY_OK` can be set
 if the script can run from a subdirectory of the working tree
-(some commands do not).
+(some commands do not).  `ORPHAN_OK` can be set if the script can
+work on orphan branches.
=20
 The scriptlet sets `GIT_DIR` and `GIT_OBJECT_DIRECTORY` shell
 variables, but does *not* export them to the environment.
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4691fbcb64..f45b69386e 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -200,7 +200,19 @@ require_work_tree () {
 }
=20
 require_clean_work_tree () {
-	git rev-parse --verify HEAD >/dev/null || exit 1
+	if git rev-parse --verify HEAD >/dev/null 2>/dev/null
+	then
+		compare_to=3DHEAD
+	else
+		if [ -z "$ORPHAN_OK" ]
+		then
+			echo >&2 "Cannot $1: Your current branch does not have any commits =
yet."
+			exit 1
+		else
+			# SHA1 of an empty tree
+			compare_to=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
+		fi
+	fi
 	git update-index -q --ignore-submodules --refresh
 	err=3D0
=20
@@ -210,7 +222,7 @@ require_clean_work_tree () {
 		err=3D1
 	fi
=20
-	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
+	if ! git diff-index --cached --quiet --ignore-submodules $compare_to =
--
 	then
 		if [ $err =3D 0 ]
 		then
diff --git a/t/t2301-require-clean-work-tree.sh b/t/t2301-require-clean=
-work-tree.sh
index 1bb41b59a5..6d0957981e 100755
--- a/t/t2301-require-clean-work-tree.sh
+++ b/t/t2301-require-clean-work-tree.sh
@@ -60,4 +60,33 @@ test_expect_success 'error on dirty index and work t=
ree while on orphan branch'
 	test_must_fail run_require_clean_work_tree
 '
=20
+test_expect_success 'ORPHAN_OK - success on clean index and worktree w=
hile on orphan branch' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	git reset --hard &&
+	(
+		ORPHAN_OK=3DYes &&
+		run_require_clean_work_tree
+	)
+'
+
+test_expect_success 'ORPHAN_OK - error on dirty index while on orphan =
branch' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	(
+		ORPHAN_OK=3DYes &&
+		test_must_fail run_require_clean_work_tree
+	)
+'
+
+test_expect_success 'ORPHAN_OK - error on dirty index and worktree whi=
le on orphan branch' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	echo dirty >file &&
+	(
+		ORPHAN_OK=3DYes &&
+		test_must_fail run_require_clean_work_tree
+	)
+'
+
 test_done
--=20
2.6.3.418.gc3b7987
