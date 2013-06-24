From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 10/16] bash prompt: combine 'git rev-parse' executions in
 the main code path
Date: Mon, 24 Jun 2013 18:39:20 +0200
Message-ID: <1372091966-19315-11-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:44:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9sL-0003c5-Kg
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab3FXQoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:44:18 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:62470 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3FXQoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:44:16 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0M1CM0-1TyEtz2OMa-00tVEU; Mon, 24 Jun 2013 18:44:15 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:dFj95zuOJAZ2pBOT5L+HtS8MpWcd2ZuN55ZW995XkC2
 t0YG1rrdaUJeWv2j12wL8S6/5le1rGeNX6a/EySvMWHclHgj36
 XSTiFb7r979OhapzjrhTI+XXgqihj+hOGhmF/qZOctA+0Okxs6
 49LdUPHqvthX+zSNH3jB9JVBJZFn04SEIQCPK2BVev30/U7nrW
 P5ZHZz3nssin49/k81wu9yrGjpadUviMKNOnR/xe6QE2NYrEA2
 Jhhs9N9sV65oqu5MB7ES+L+OsKmWy0LWGikD5uW2AUfC3ukZat
 tbxK4q/oSdMmWBExR/tyJSCffBlYLOSDS1mVlShsHItZ9sCdfC
 FdaFVe+P9laJjzBatEAYDN+6QBS81QDohLzw7VkISS921BayH5
 cBczwYxuUD2BQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228862>

There are a couple of '$(git rev-parse --<opt>)' command substitutions
in __git_ps1() and three of them are executed in the main code path:

 - the first to get the path to the .git directory ('--git-dir'),
 - the second to check whether we're inside the .git directory
   ('--is-inside-git-dir'),
 - and the last, depending on the results of the second, either
   * to check whether it's a bare repo ('--is-bare-repository'), or
   * to check whether inside a work tree ('--is-inside-work-tree').

Naturally, this imposes the overhead of fork()ing three subshells and
fork()+exec()ing three git commands.

Combine these four 'git rev-parse' queries into a single one and use
bash parameter expansions to parse the combined output, i.e. to
separate the path to the .git directory from the true/false of
'--is-inside-git-dir', etc.  This way we can eliminate two of the
three subshells and git commands.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index c2050b69..7d226251 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -311,8 +311,9 @@ __git_ps1 ()
 		;;
 	esac
=20
-	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
-	if [ -z "$g" ]; then
+	local repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
+		--is-bare-repository --is-inside-work-tree 2>/dev/null)"
+	if [ -z "$repo_info" ]; then
 		if [ $pcmode =3D yes ]; then
 			#In PC mode PS1 always needs to be set
 			PS1=3D"$ps1pc_start$ps1pc_end"
@@ -320,6 +321,13 @@ __git_ps1 ()
 		return
 	fi
=20
+	local inside_worktree=3D"${repo_info##*$'\n'}"
+	repo_info=3D"${repo_info%$'\n'*}"
+	local bare_repo=3D"${repo_info##*$'\n'}"
+	repo_info=3D"${repo_info%$'\n'*}"
+	local inside_gitdir=3D"${repo_info##*$'\n'}"
+	local g=3D"${repo_info%$'\n'*}"
+
 	local r=3D""
 	local b=3D""
 	local step=3D""
@@ -402,13 +410,13 @@ __git_ps1 ()
 	local c=3D""
 	local p=3D""
=20
-	if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ];=
 then
-		if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)" =
]; then
+	if [ "true" =3D "$inside_gitdir" ]; then
+		if [ "true" =3D "$bare_repo" ]; then
 			c=3D"BARE:"
 		else
 			b=3D"GIT_DIR!"
 		fi
-	elif [ "true" =3D "$(git rev-parse --is-inside-work-tree 2>/dev/null)=
" ]; then
+	elif [ "true" =3D "$inside_worktree" ]; then
 		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
 		   [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]
 		then
--=20
1.8.3.1.599.g4459181
