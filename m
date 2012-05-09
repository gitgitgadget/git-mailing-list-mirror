From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 04/19] completion: respect $GIT_DIR
Date: Wed,  9 May 2012 02:44:35 +0200
Message-ID: <1336524290-30023-5-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:45:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv2S-0004ur-NM
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab2EIApq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:45:46 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:62662 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223Ab2EIApp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:45:45 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LzDcL-1S5Wic2n0z-0150ET; Wed, 09 May 2012 02:45:43 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:iaMH/H9ILrxbY/l6CrubDt1Ur8phBm1J3EcHaySWOVr
 IuAzIqgpY8R0QCJ3P05fvf1Wk8QI1u4qD6U0M/lwcrnqyPvVfm
 KgrB6XMVom/9tDJULgNPPbPNOSStyN8cakqgSLZDfnJcor5a8V
 nF0ykGYHkI3wdFbFccWdqw+oOAgoVPCt6HD4RDDDXNEjvuZwUm
 GzvdMXkAzRtCf3k92A1hO/X3P9tNKhw3d2ChV6b3suyIidUoQl
 5elAS4XHGcjGNEN0aFF/Dhode9/JlMq/j/CkN0nFx3nMojYy4w
 DsoJKNPLJJsK06BTqBU4lKu2ZVHfNvgWhahdowiiKJfH2ScRdl
 NV83FyWsLuOu27poe3HMKUsIXYAHbNxKIXqT1hCaZKlifJVJt9
 St5IqEn1Jqx6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197436>

The __gitdir() helper function finds out the path of the git
repository by running 'git rev-parse --git-dir'.  However, it has a
shortcut first to avoid the overhead of running a git command in a
subshell when the current directory is at the top of the work tree,
i.e. when it contains a '.git' subdirectory.

If the 'GIT_DIR' environment variable is set then it specifies the
path to the git repository, and the autodetection of the '.git'
directory is not necessary.  However, $GIT_DIR is only taken into
acocunt by 'git rev-parse --git-dir', and the check for the '.git'
subdirectory is performed first, so it wins over the path given in
$GIT_DIR.

There are several completion (helper) functions that depend on
__gitdir(), and when the above case triggers the completion script
will do weird things, like offering refs, aliases, or stashes from a
different repository, or displaying wrong or broken prompt, etc.

So check first whether $GIT_DIR is set, and only proceed with checking
the '.git' directory in the current directory if it isn't.  'git
rev-parse' would also check whether the path in $GIT_DIR is a proper
'.git' directory, i.e. 'HEAD', 'refs/', and 'objects/' are present and
accessible, but we don't have to be that thorough for the bash prompt.
And we've lived with an equally permissive check for '.git' in the
current working directory for years anyway.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |  3 +++
 t/t9903-bash-prompt.sh                 | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f17abccb..ab26bdc8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -77,6 +77,9 @@ __gitdir ()
 	if [ -z "${1-}" ]; then
 		if [ -n "${__git_dir-}" ]; then
 			echo "$__git_dir"
+		elif [ -n "${GIT_DIR-}" ]; then
+			test -d "${GIT_DIR-}" || return 1
+			echo "$GIT_DIR"
 		elif [ -d .git ]; then
 			echo .git
 		else
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index a6c9ce94..96468ceb 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -85,7 +85,7 @@ test_expect_success 'gitdir - parent is a .git direct=
ory' '
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
+test_expect_success 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
 	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
 	(
 		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
@@ -106,6 +106,14 @@ test_expect_success 'gitdir - $GIT_DIR set while .=
git directory in parent' '
 	test_cmp expected "$actual"
 '
=20
+test_expect_success 'gitdir - non-existing $GIT_DIR' '
+	(
+		GIT_DIR=3D"$TRASH_DIRECTORY/non-existing" &&
+		export GIT_DIR &&
+		test_must_fail __gitdir
+	)
+'
+
 test_expect_success 'gitdir - gitfile in cwd' '
 	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
 	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
--=20
1.7.10.1.541.gb1be298
