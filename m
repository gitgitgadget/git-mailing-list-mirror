From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 07/16] bash prompt: run 'git rev-parse --git-dir' directly
 instead of __gitdir()
Date: Mon, 24 Jun 2013 18:39:17 +0200
Message-ID: <1372091966-19315-8-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:44:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9s7-0003Oy-9Y
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab3FXQn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:43:56 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:52533 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab3FXQnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:43:55 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0Lx0hB-1UBf2p1481-017AIF; Mon, 24 Jun 2013 18:43:46 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:up2W1grxeSeA6blgcUPnIXG/Q1lbE1eCO5bwix9Dl3s
 Tkhu5c0Q+dE9uZpXrPAUbUMLzZklmxCsHGqBBWbYGbsF+JMgqT
 01pLd7tl9E13fIYakY8gmcYZdn8pJrBbOf0crwZZLzciA2nTaB
 Tyr3H69PPT0gcRUBhixXJsAl/a2TBVNsdD0jgQGfz9IywnQNf+
 qRjj778t9HvbqCUCY5wEKLFQ/RJhVLlVsMYiujsgk3DZC2KjGG
 T14oAORuqq9EBgf53exwClGaPfeb+0lgOPWNV3olkXkr0NwMn9
 tLmDOcG/INrh13jNJwziMAsCjHwYdZa8rV0tYi/ZJVKljSFGQC
 1/C/ojJkyQpgJ93eX912Jk/gYIuoKTgMBHnVGPBK/zjJyAY9NO
 vHTFtjIoXmr1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228859>

__git_ps1() finds out the path to the repository by using the
__gitdir() helper function.  __gitdir() is basically just a wrapper
around 'git rev-parse --git-dir', extended with support for
recognizing a remote repository given as argument, to use the path
given on the command line, and with a few shortcuts to recognize a git
repository in cwd or at $GIT_DIR quickly without actually running 'git
rev-parse'.  However, the former two is only necessary for the
completion script but makes no sense for the bash prompt, while the
latter shortcuts are performance optimizations __git_ps1() can do
without (they just avoid the overhead of fork()+exec()ing a git
process).

Run 'git rev-parse --git-dir' directly in __git_ps1(), because it will
allow this patch series to combine several $(git rev-parse ...)
command substitutions in the main code path, and the overall
performance benefit will far outweigh the loss of those few shortcuts
in __gitdir().  Furthermore, since __gitdir() is not needed anymore
for the prompt, remove it from the prompt script finally eliminating
its duplication between the prompt and completion scripts.  Also
remove the comment from the completion script warning about this code
duplication.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |  2 --
 contrib/completion/git-prompt.sh       | 26 +-------------------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6c3bafee..ebc40d48 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -33,8 +33,6 @@ esac
 # returns location of .git repo
 __gitdir ()
 {
-	# Note: this function is duplicated in git-prompt.sh
-	# When updating it, make sure you update the other one to match.
 	if [ -z "${1-}" ]; then
 		if [ -n "${__git_dir-}" ]; then
 			echo "$__git_dir"
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index a915b04c..0563dea8 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -80,30 +80,6 @@
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
 # the colored output of "git status -sb".
=20
-# __gitdir accepts 0 or 1 arguments (i.e., location)
-# returns location of .git repo
-__gitdir ()
-{
-	# Note: this function is duplicated in git-completion.bash
-	# When updating it, make sure you update the other one to match.
-	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
-			echo "$__git_dir"
-		elif [ -n "${GIT_DIR-}" ]; then
-			test -d "${GIT_DIR-}" || return 1
-			echo "$GIT_DIR"
-		elif [ -d .git ]; then
-			echo .git
-		else
-			git rev-parse --git-dir 2>/dev/null
-		fi
-	elif [ -d "$1/.git" ]; then
-		echo "$1/.git"
-	else
-		echo "$1"
-	fi
-}
-
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
@@ -335,7 +311,7 @@ __git_ps1 ()
 		;;
 	esac
=20
-	local g=3D"$(__gitdir)"
+	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
 	if [ -z "$g" ]; then
 		if [ $pcmode =3D yes ]; then
 			#In PC mode PS1 always needs to be set
--=20
1.8.3.1.599.g4459181
