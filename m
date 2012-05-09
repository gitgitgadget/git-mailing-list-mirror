From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 06/19] bash prompt: return early from __git_ps1() when not in
	a git repository
Date: Wed,  9 May 2012 02:44:37 +0200
Message-ID: <1336524290-30023-7-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:46:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv36-00056b-7c
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab2EIAqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:46:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:62604 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab2EIAqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:46:05 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Mcu17-1SjJQt3JKr-00I99X; Wed, 09 May 2012 02:45:59 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:4sRfoxmjyH88BiFJPZJE+cTrm6riDHcXTGaxDKwbz0W
 kiw+k7gOkx5081b93A5K2kMT7RRYNO2pYYHiToXOvH0BPDljaN
 msvaOkdoL6iYLzHEUhJoO/MBaedvOEM0uQeCf6KEVGG1UIeSvI
 DFf0qyYNuUlHwqsDMNVRoN07YvxnJfMvqa03Q9DdO2xgs+k0dx
 xrY9h40SFgXl2Sqbz0tfOxUaFyOmxNqLgY6vdTiKvybyY6yujs
 a51Oeq2Vs+gUJh96uGqa6Fj9iJacVtI8mzxMmOozR3khisLt0U
 2MysJcO6tCR80ULivAtDUQIWUtr68P1AuWW+AsqC+mfRqQVz4c
 idw4VQFwd39GErDQJNndrWDIbk290T+ZCU98x6dp4MhKRFFySe
 gsrNBnoKa7UNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197441>

=2E.. to gain one level of indentation for the bulk of the function.

(The patch looks quite unreadable, you'd better check it with 'git
diff -w'.)

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 154 +++++++++++++++++--------=
--------
 1 file changed, 78 insertions(+), 76 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index cd6a5f12..eaa3df9d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -217,94 +217,96 @@ __git_ps1_show_upstream ()
 __git_ps1 ()
 {
 	local g=3D"$(__gitdir)"
-	if [ -n "$g" ]; then
-		local r=3D""
-		local b=3D""
-		if [ -f "$g/rebase-merge/interactive" ]; then
-			r=3D"|REBASE-i"
-			b=3D"$(cat "$g/rebase-merge/head-name")"
-		elif [ -d "$g/rebase-merge" ]; then
-			r=3D"|REBASE-m"
-			b=3D"$(cat "$g/rebase-merge/head-name")"
-		else
-			if [ -d "$g/rebase-apply" ]; then
-				if [ -f "$g/rebase-apply/rebasing" ]; then
-					r=3D"|REBASE"
-				elif [ -f "$g/rebase-apply/applying" ]; then
-					r=3D"|AM"
-				else
-					r=3D"|AM/REBASE"
-				fi
-			elif [ -f "$g/MERGE_HEAD" ]; then
-				r=3D"|MERGING"
-			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
-				r=3D"|CHERRY-PICKING"
-			elif [ -f "$g/BISECT_LOG" ]; then
-				r=3D"|BISECTING"
-			fi
+	if [ -z "$g" ]; then
+		return
+	fi
=20
-			b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
-
-				b=3D"$(
-				case "${GIT_PS1_DESCRIBE_STYLE-}" in
-				(contains)
-					git describe --contains HEAD ;;
-				(branch)
-					git describe --contains --all HEAD ;;
-				(describe)
-					git describe HEAD ;;
-				(* | default)
-					git describe --tags --exact-match HEAD ;;
-				esac 2>/dev/null)" ||
-
-				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-				return
-				b=3D"($b)"
-			}
+	local r=3D""
+	local b=3D""
+	if [ -f "$g/rebase-merge/interactive" ]; then
+		r=3D"|REBASE-i"
+		b=3D"$(cat "$g/rebase-merge/head-name")"
+	elif [ -d "$g/rebase-merge" ]; then
+		r=3D"|REBASE-m"
+		b=3D"$(cat "$g/rebase-merge/head-name")"
+	else
+		if [ -d "$g/rebase-apply" ]; then
+			if [ -f "$g/rebase-apply/rebasing" ]; then
+				r=3D"|REBASE"
+			elif [ -f "$g/rebase-apply/applying" ]; then
+				r=3D"|AM"
+			else
+				r=3D"|AM/REBASE"
+			fi
+		elif [ -f "$g/MERGE_HEAD" ]; then
+			r=3D"|MERGING"
+		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
+			r=3D"|CHERRY-PICKING"
+		elif [ -f "$g/BISECT_LOG" ]; then
+			r=3D"|BISECTING"
 		fi
=20
-		local w=3D""
-		local i=3D""
-		local s=3D""
-		local u=3D""
-		local c=3D""
-		local p=3D""
+		b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
+
+			b=3D"$(
+			case "${GIT_PS1_DESCRIBE_STYLE-}" in
+			(contains)
+				git describe --contains HEAD ;;
+			(branch)
+				git describe --contains --all HEAD ;;
+			(describe)
+				git describe HEAD ;;
+			(* | default)
+				git describe --tags --exact-match HEAD ;;
+			esac 2>/dev/null)" ||
+
+			b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
+			return
+			b=3D"($b)"
+		}
+	fi
=20
-		if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]=
; then
-			if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)"=
 ]; then
-				c=3D"BARE:"
-			else
-				b=3D"GIT_DIR!"
-			fi
-		elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null=
)" ]; then
-			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
-				if [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]; th=
en
-					git diff --no-ext-diff --quiet --exit-code || w=3D"*"
-					if git rev-parse --quiet --verify HEAD >/dev/null; then
-						git diff-index --cached --quiet HEAD -- || i=3D"+"
-					else
-						i=3D"#"
-					fi
-				fi
-			fi
-			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-				git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
-			fi
+	local w=3D""
+	local i=3D""
+	local s=3D""
+	local u=3D""
+	local c=3D""
+	local p=3D""
=20
-			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-					u=3D"%"
+	if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ];=
 then
+		if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)" =
]; then
+			c=3D"BARE:"
+		else
+			b=3D"GIT_DIR!"
+		fi
+	elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null)=
" ]; then
+		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
+			if [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]; the=
n
+				git diff --no-ext-diff --quiet --exit-code || w=3D"*"
+				if git rev-parse --quiet --verify HEAD >/dev/null; then
+					git diff-index --cached --quiet HEAD -- || i=3D"+"
+				else
+					i=3D"#"
 				fi
 			fi
+		fi
+		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
+			git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
+		fi
=20
-			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
-				__git_ps1_show_upstream
+		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
+			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
+				u=3D"%"
 			fi
 		fi
=20
-		local f=3D"$w$i$s$u"
-		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
+			__git_ps1_show_upstream
+		fi
 	fi
+
+	local f=3D"$w$i$s$u"
+	printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
 }
=20
 __gitcomp_1 ()
--=20
1.7.10.1.541.gb1be298
