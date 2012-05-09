From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 10/19] completion: use bash builtins to search for repository
Date: Wed,  9 May 2012 02:44:41 +0200
Message-ID: <1336524290-30023-11-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:46:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv3I-00059j-Qe
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846Ab2EIAqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:46:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60463 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab2EIAqm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:46:42 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Lkkvg-1RtgE40f7k-00aQZ6; Wed, 09 May 2012 02:46:36 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:K2LgIFw6/AcerUJwtcJFsbn+K1CmoLCdrQx7RfkbsXP
 /bT6uJuc5Aa7PKLo1AsDOF6tNCKpkV7xc8D7/SPFdH06ZaVCkx
 hDBXoK1LgUI13cWSxmc4fkh320aqR4sij2hSXHTf0Vskd8liLp
 6vh6TXGAqYT635GFBxvMGu7cx0BEblpSWqMuCfDLZOtWciOj0m
 NeSNe029qq9KJ27k87h/KfwuaNvTfxPY/gLWCUQqhU2Hxgf96h
 JFTHVCS/I8bVl8T8sIzarhoNWD5VbaY3lfaUTSc3irX0efp5AN
 HqpGut2i1I2h+auAhwNZC8iZAqHAlrm/Gtp9Cog3RuD62LQ3MO
 Aoy0tyg7020pichWY8aY+v+6/d5g/VGwtKdsyTpEblHLWeNo4J
 hfrZnZu/mIlWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197442>

When not at the top of the work tree or when no path is specified by
'git --git-dir=3D...' or $GIT_DIR, the __gitdir() helper function finds
out the physical path to the '.git' directory by running the '$(git
rev-parse --git-dir)' command substitution.  fork()ing a subshell and
fork()+exec()ing a git command take some time; during the same amount
of time we can stat a lot of files and directories using bash
builtins, likely finding the '.git' directory faster.

This patch extends __gitdir() to search for a '.git' directory using
only bash builtins.  Like the existing check for '.git' in the current
working directory or the previously added check for $GIT_DIR, this
search is not that thorough either, as it doesn't check whether the
found '.git' directory or the directory pointed to by a gitfile is a
valid '.git' repository.

Since git doesn't search for a .git directory beyond filesystem
boundaries and beyond paths specified in $GIT_CEILING_DIRECTORIES, the
search in __gitdir() should not do that either.  However, bash doesn't
provide builtins to check that two paths are on the same filesystem,
so we can't limit the search cheaply to one filesystem.  Therefore,
__gitdir() will only use bash builtins when neither of these limits
are active, i.e. $GIT_DISCOVERY_ACROSS_FILESYSTEM is set and
$GIT_CEILING_DIRECTORIES is empty, otherwise it will fall back on
executing 'git rev-parse'.  $GIT_CEILING_DIRECTORIES is empty by
default, but users have to set $GIT_DISCOVERY_ACROSS_FILESYSTEM
explicitly to enable this optimisation, when they find its
consequences acceptable.

Of course, stat()ing in C is much faster than in bash, so there is a
point when bash builtins will be slower than '$(git rev-parse
--git-dir)' despite all the fork()s+exec() overhead.  On MinGW this
overhead is considerable, and the builtins version is faster even at a
depth of 50 directories.  On Linux the builtins version is only faster
for paths less than 10 directories deeper than the toplevel; with my
usage patterns that covers 99.9% of the prompts displayed.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 30 ++++++++++++
 t/t9903-bash-prompt.sh                 | 83 ++++++++++++++++++++++++++=
++++++++
 2 files changed, 113 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bd7d39e3..dd69e56e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -89,13 +89,43 @@ fi
 __gitdir ()
 {
 	if [ -z "${1-}" ]; then
+		local gitfile
+
 		if [ -n "${__git_dir-}" ]; then
 			:
 		elif [ -n "${GIT_DIR-}" ]; then
 			test -d "${GIT_DIR-}" || return 1
 			__git_dir=3D"$GIT_DIR"
+		elif [ -f .git ]; then
+			read gitfile <.git 2>/dev/null || return 1
+			__git_dir=3D"${gitfile#gitdir: }"
 		elif [ -d .git ]; then
 			__git_dir=3D.git
+		elif [ -d refs ] && [ -r HEAD ] && \
+				[ -d "${GIT_OBJECT_DIRECTORY:-objects}" ]; then
+			__git_dir=3D.
+		elif [ -n "${GIT_DISCOVERY_ACROSS_FILESYSTEM-}" -a \
+				-z "${GIT_CEILING_DIRECTORIES-}" ]; then
+			local p
+			__git_pwd_p p
+			while true; do
+				p=3D"${p%/*}"
+				if [ -f "$p/.git" ]; then
+					read gitfile <"$p/.git" 2>/dev/null || return 1
+					__git_dir=3D"${gitfile#gitdir: }"
+					break
+				elif [ -d "$p/.git" ]; then
+					__git_dir=3D"$p/.git"
+					break
+				elif [ -d "$p/refs" ] && [ -r "$p/HEAD" ] && \
+						[ -d "${GIT_OBJECT_DIRECTORY:-$p/objects}" ]; then
+					__git_dir=3D"${p:-/}"
+					break
+				fi
+				if [ -z "$p" ]; then
+					return 1
+				fi
+			done
 		else
 			__git_dir=3D"$(git rev-parse --git-dir 2>/dev/null)" || return 1
 		fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 3d722b25..ffa22d39 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -105,6 +105,18 @@ test_expect_success 'gitdir - .git directory in pa=
rent' '
 	test_cmp expected "$actual_var"
 '
=20
+test_expect_success 'gitdir - .git directory in parent - with builtins=
' '
+	echo "$TRASH_DIRECTORY/.git" > expected &&
+	(
+		GIT_DISCOVERY_ACROSS_FILESYSTEM=3Dtrue &&
+		cd subdir/subsubdir &&
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
+'
+
 test_expect_success 'gitdir - cwd is a .git directory' '
 	echo "." > expected &&
 	(
@@ -116,6 +128,20 @@ test_expect_success 'gitdir - cwd is a .git direct=
ory' '
 	test_cmp expected "$actual_var"
 '
=20
+test_expect_success 'gitdir - cwd is a .git directory - GIT_OBJECT_DIR=
ECTORY' '
+	echo "." > expected &&
+	mv .git/objects _objects &&
+	test_when_finished "mv _objects .git/objects" &&
+	(
+		GIT_OBJECT_DIRECTORY=3D"$TRASH_DIRECTORY/_objects" &&
+		cd .git &&
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
+'
+
 test_expect_success 'gitdir - parent is a .git directory' '
 	echo "$TRASH_DIRECTORY/.git" > expected &&
 	(
@@ -127,6 +153,33 @@ test_expect_success 'gitdir - parent is a .git dir=
ectory' '
 	test_cmp expected "$actual_var"
 '
=20
+test_expect_success 'gitdir - parent is a .git directory - with builti=
ns' '
+	echo "$TRASH_DIRECTORY/.git" > expected &&
+	(
+		GIT_DISCOVERY_ACROSS_FILESYSTEM=3Dtrue &&
+		cd .git/refs/heads &&
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
+'
+
+test_expect_success 'gitdir - parent is a .git directory - with builti=
ns and GIT_OBJECT_DIRECTORY' '
+	echo "$TRASH_DIRECTORY/.git" > expected &&
+	mv .git/objects _objects &&
+	test_when_finished "mv _objects .git/objects" &&
+	(
+		GIT_OBJECT_DIRECTORY=3D"$TRASH_DIRECTORY/_objects" &&
+		GIT_DISCOVERY_ACROSS_FILESYSTEM=3Dtrue &&
+		cd .git/refs/heads &&
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
+'
+
 test_expect_success 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
 	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
 	(
@@ -187,6 +240,20 @@ test_expect_success 'gitdir - gitfile in parent' '
 	test_cmp expected "$actual_var"
 '
=20
+test_expect_success 'gitdir - gitfile in parent - with builtins' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	test_when_finished "rm -f subdir/.git" &&
+	(
+		GIT_DISCOVERY_ACROSS_FILESYSTEM=3Dtrue &&
+		cd subdir/subsubdir &&
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
+'
+
 test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks'=
 '
 	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
 	mkdir otherrepo/dir &&
@@ -202,6 +269,22 @@ test_expect_success SYMLINKS 'gitdir - resulting p=
ath avoids symlinks' '
 	test_cmp expected "$actual_var"
 '
=20
+test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks =
- with builtins' '
+	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	mkdir otherrepo/dir &&
+	test_when_finished "rm -rf otherrepo/dir" &&
+	ln -s otherrepo/dir link &&
+	test_when_finished "rm -f link" &&
+	(
+		GIT_DISCOVERY_ACROSS_FILESYSTEM=3Dtrue &&
+		cd link &&
+		__gitdir > "$actual" &&
+		echo "$__git_dir" > "$actual_var"
+	) &&
+	test_cmp expected "$actual" &&
+	test_cmp expected "$actual_var"
+'
+
 test_expect_success 'gitdir - not a git repository' '
 	(
 		cd subdir/subsubdir &&
--=20
1.7.10.1.541.gb1be298
