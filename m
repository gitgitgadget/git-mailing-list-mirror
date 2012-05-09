From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 13/19] bash prompt: check whether inside the worktree only
	when necessary
Date: Wed,  9 May 2012 02:44:44 +0200
Message-ID: <1336524290-30023-14-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv3h-0005Kb-KL
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536Ab2EIArI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:47:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:65391 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab2EIArH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:47:07 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MDTqb-1SM5720Rmn-00HS4T; Wed, 09 May 2012 02:47:01 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:wVhsr11rHODZRCsIiaH105xXEqlO6J0XXW6NzuMDTe1
 k7Kpft68xQQAfNmtDeIQ3unN4tFp6VinEc61rEGW1tArOLd0lO
 bRA+fhV6zPmDYcjz82hTc0Kri9aKIkw2T8Mi6z6o+dyPFRHYzU
 i5dZaG38hHIAZTYcDLBHhLgcDAPQdBXAuBMXfmCdx58haoVHuu
 hA6Ccnga+Nhw1rPk6Ql0/nB6/3EkMfP89lQnP81w26vRNMZePR
 pAMrby2HP85V6vFnjayzO+U8ewZcrgYpf21UjxDBaC9YqyOuXW
 UggTimub4vC+yt1qo/oUyzfSLeHdzHY3y3jts66F2L8sDqLtbl
 v2mEHZlgjO8hv9dxmHZCzVy6ZzxJKBit/J1G8aGsH9viktJ1VH
 KJuE2yHA1PQNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197445>

Besides the current branch name or detached head info __git_ps1() can
also display status indicators in the prompt for changes in the work
tree, stashes, untracked files, and divergence from upstream.  These
are only displayed when enabled by specific environment variables and
when we are in a work tree.  The latter condition is checked by the
'$(git rev-parse --is-inside-work-tree)' command substitution,
impossing the overhead of fork()ing a subshell and fork()+exec()ing a
git process.

However, the check for the work tree preceeds the check of the
environment variables enabling status indicators, so it's evaluated
even when all these indicators are disabled.

Check upfront whether any of these indicators are enabled, i.e. a
corresponding environment variable is set, to spare the unnecessary
fork()+exec() overhead when all of them are disabled.

(Ideally we could check whether we are in a work tree using only bash
builtins, like we did in the previous commit for .git directory, but
the path of the work tree can be specified by the 'core.worktree'
config variable, and running 'git config' to get its value would be
just as expensive.)

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 42 +++++++++++++++++++-------=
--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 72f7d0ed..64b96f13 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -333,29 +333,35 @@ __git_ps1 ()
 		else
 			b=3D"GIT_DIR!"
 		fi
-	elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null)=
" ]; then
-		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
-			if [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]; the=
n
-				git diff --no-ext-diff --quiet --exit-code || w=3D"*"
-				if git rev-parse --quiet --verify HEAD >/dev/null; then
-					git diff-index --cached --quiet HEAD -- || i=3D"+"
-				else
-					i=3D"#"
+	elif [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" \
+			-o -n "${GIT_PS1_SHOWSTASHSTATE-}" \
+			-o -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" \
+			-n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+		if [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null)"=
 ]; then
+			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
+				if [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]; th=
en
+					git diff --no-ext-diff --quiet --exit-code || w=3D"*"
+					if git rev-parse --quiet --verify HEAD >/dev/null; then
+						git diff-index --cached --quiet HEAD -- || i=3D"+"
+					else
+						i=3D"#"
+					fi
 				fi
 			fi
-		fi
-		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-			git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
-		fi
=20
-		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-				u=3D"%"
+			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
+			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$=
"
 			fi
-		fi
=20
-		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-			__git_ps1_show_upstream
+			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
+				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
+					u=3D"%"
+				fi
+			fi
+
+			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+				__git_ps1_show_upstream
+			fi
 		fi
 	fi
=20
--=20
1.7.10.1.541.gb1be298
