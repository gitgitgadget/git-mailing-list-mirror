From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 16/19] bash prompt: display stash and upstream state even
	inside the repository
Date: Wed,  9 May 2012 02:44:47 +0200
Message-ID: <1336524290-30023-17-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv44-0005WQ-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab2EIArc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:47:32 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:61347 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab2EIArc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:47:32 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LqrfL-1RxEwH0M55-00eStf; Wed, 09 May 2012 02:47:26 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:HY7EXMV3aVk6rydxbX2BdojZPgShdiXFwE7JDqj7/6T
 N0UWJ+UxQC3r2KKrylNhxYtJzYSzTbrdsvqpJdLkkKjPUUk7y3
 nw2JNeKaummL1JA57rUwQz22ka/viiz16dOrnqpsFDADMVAIyO
 wkLQhlOqANPCLtjsyaTxsxhWt3dRrmU6B+nzdc9V6TAn5lnjW5
 k6R7dDFvZy/sbIxtg2LgJrcGWmY5P2Jirbsym7+m+EZci49hy/
 RcqhapaAoothnRISzpuCTpkXePpNgfjMjp6CZy1g8H02cXzo64
 CbCawLvF3tNmA1cHvxHTPbqfv/zNEWdyQdfPZpM1dspgv2uTXW
 cPbPwFjjTjF9uLx8IDZ6fGzVEbV6LtrV8IuamkjJoEdQBTyDLG
 z3anY2cYQPCvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197448>

Besides the current branch name or detached head info __git_ps1() can
also display some status indicators in the prompt.  The first such
indicator was for changes in the work tree in 738a94a9 (bash: offer to
show (un)staged changes, 2009-02-03), and was only checked/displayed
when inside the work tree.  Later other indicators were added in
2414b45c (Show presence of stashed changes in bash prompt.,
2009-06-02), 397f7c63 (Show the presence of untracked files in the
bash prompt., 2009-07-22), and 6d158cba (bash completion: Support
"divergence from upstream" messages in __git_ps1, 2010-06-17).  All of
these just followed suit and were checked only when inside the work
tree, i.e. after checking the results of the '$(git rev-parse
--is-inside-work-tree)' command substitution, imposing the overhead of
fork()ing a subshell and fork()+exec()ing a git process.

However, the presence of stashes and the divergence from upstream is
not a property of the work tree but a property of the repository, and
the implementation of their indicators doesn't actually require a work
tree.  Therefore, we can display these two indicators even inside the
repository.  Not that it's very useful to see the stash status while
poking around deep inside the .git directory, but this way users
enabling only the stash indicator won't pay the additional performance
penalty of the check for the work tree.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 20 +++++++++-----------
 t/t9903-bash-prompt.sh                 |  4 ++--
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2346962d..64207e3c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -334,9 +334,7 @@ __git_ps1 ()
 			b=3D"GIT_DIR!"
 		fi
 	elif [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" \
-			-o -n "${GIT_PS1_SHOWSTASHSTATE-}" \
-			-o -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" \
-			-n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+			-o -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
 		if [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null)"=
 ]; then
 			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
 				if [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]; th=
en
@@ -349,22 +347,22 @@ __git_ps1 ()
 				fi
 			fi
=20
-			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$=
"
-			fi
-
 			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
 				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
 					u=3D"%"
 				fi
 			fi
-
-			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-				__git_ps1_show_upstream
-			fi
 		fi
 	fi
=20
+	if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
+	        git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
+	fi
+
+	if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+		__git_ps1_show_upstream
+	fi
+
 	local f=3D"$w$i$s$u"
 	printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
 }
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index ffa22d39..a43d402a 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -542,8 +542,8 @@ test_expect_success 'prompt - stash status indicato=
r - stash' '
 	test_cmp expected "$actual"
 '
=20
-test_expect_success 'prompt - stash status indicator - not shown insid=
e .git directory' '
-	printf " (GIT_DIR!)" > expected &&
+test_expect_success 'prompt - stash status indicator - stash while ins=
ide .git directory' '
+	printf " (GIT_DIR! $)" > expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
--=20
1.7.10.1.541.gb1be298
