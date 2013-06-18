From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 10/13] bash prompt: combine 'git rev-parse' executions
Date: Tue, 18 Jun 2013 04:17:03 +0200
Message-ID: <1371521826-3225-11-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolVH-0007Y3-0y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab3FRCSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:18:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52170 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab3FRCSd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:18:33 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0Lx7w9-1UHLSt1hkn-016iLo; Tue, 18 Jun 2013 04:18:26 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:eF1f+2N8gn7+5Tfl7LbILwcP75cAG4x32QRoPsIpnm0
 og4RVAkXwMEqA6HMDIaWrh2+v3XU51MVfCrzMaQBnanz2q7+DU
 gT20rgOKBgTiNm8+ucRO+s42tpB/xpIZ97WTS3FFwiOuH8xKlL
 sF78WjPtIKx5bMNAk75SqT+scsUyhFfeM+GItb+dt3f9YainuC
 r/6zrqbVRFU1AypVnzxJ+rnfzM6gP8DTEhegcC+5fanKnoUvGF
 Y+tK9oWKzy1jXLrYU9cm4kaCwfsB0O1wknQLGaNTyb402yvNPb
 Me0uh9Cj0+fo6Sk6sUzgk26U5+HlbNpf37kv6SzcxpBxSkkCQN
 eeDTi3rcGcRGPNNjqz69QoIC/ExUKDuZjBvqeyFxo1gtlVoW1c
 tVW3YtboWT5KA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228144>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

>From the four '$(git rev-parse --<opt>)' command substitutions
__git_ps1() executes three in its main code path:

 - the first to get the path to the .git directory ('--git-dir'),
 - the second to check whether we're inside the .git directory
   ('--is-inside-git-dir'),
 - and the last, depending on the results of the second, either
   * to check whether it's a bare repo ('--is-bare-repository'), or
   * to check whether inside a work tree ('--is-inside-work-tree').

Naturally, this imposes the overhead of fork()ing three subshells and
fork()+exec()ing three git commands.

Combine these four 'git rev-parse' queries into one and use bash
parameter expansions to parse the combined output, i.e. to separate
the path to the .git directory from the true/false of
'--is-inside-git-dir', etc.  This way we can eliminate two of the
three subshells and git commands.

The whole series speeds up the bash prompt on Windows/MSysGit
considerably.  Here are some timing results in two scenarios, repeated
10 times:

At the top of the work tree, before:

    $ time for i in {0..9} ; do prompt=3D"$(__git_ps1)" ; done

    real    0m1.716s
    user    0m0.301s
    sys     0m0.772s

  After:

    real    0m0.686s
    user    0m0.075s
    sys     0m0.287s

In a subdirectory, during rebase, stash status indicator enabled,
before:

    real    0m3.557s
    user    0m0.495s
    sys     0m1.767s

  After:

    real    0m0.702s
    user    0m0.045s
    sys     0m0.409s

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 10ec6902..b73cebf7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -311,8 +311,9 @@ __git_ps1 ()
 		;;
 	esac
=20
-	local g=3D
-	if ! g=3D"$(git rev-parse --git-dir 2>/dev/null)"; then
+	local repo_info=3D
+	if ! repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
+		--is-bare-repository --is-inside-work-tree 2>/dev/null)"; then
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
@@ -396,13 +404,13 @@ __git_ps1 ()
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
1.8.3.1.487.g8f4672d
