From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 06/13] bash prompt: run 'git rev-parse --git-dir' directly
 instead of __gitdir()
Date: Tue, 18 Jun 2013 04:16:59 +0200
Message-ID: <1371521826-3225-7-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolUo-0006cu-4F
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933Ab3FRCSD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:18:03 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52337 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab3FRCSA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:18:00 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Lwqt6-1UHcad2lYG-016sLE; Tue, 18 Jun 2013 04:17:59 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:2HARgp/THTdxsF35ejRGlXoc3Z0MgJ9C2fzJ2CMcSJf
 fJPc35uBJSAR6e24v3v5M99imhId1kBewo8d5s0RRoK3lN6MU6
 +DpwQoQY8f0o+fEFzJrf07XyPZukHIFQGDlwOPv9V+rnKjwERU
 lCbVkPGSWFIITX5wEpCxWY1WQZ44jgb8nl7ag4fXF91dB0E8Wz
 t6JuIVM8ty/F5BxuKZUSmNBR6m8QO8aqT0ezlrKxOT+wJGSCZQ
 yN1x85f0HBkzTKt5cemKDbuuSuoKD7voroI/xF6YFBFcyUraVG
 ATEPLfLFNyPXDUcr4OFi8j2IQPLCAAzLcoSpZY3E1Sab3D+Lv8
 cOqxWwCBWYEwMPiKo+6phkLW1rusACj+4tRN8nIE2wKwWC6Z3C
 oZ39gxuFFZPjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228139>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

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
performance benefit will far outweight the loss of those few shortcuts
in __gitdir().  Furthermore, since __gitdir() is not needed anymore
for the prompt, remove it from the prompt script finally eliminating
its duplication between the prompt and completion scripts.  Also
remove the comment from the completion script warning about this code
duplication.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |  2 --
 contrib/completion/git-prompt.sh       | 28 ++------------------------=
--
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 56c52c66..e0c8d6a1 100644
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
index 96b496cc..0fc1d317 100644
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
@@ -335,8 +311,8 @@ __git_ps1 ()
 		;;
 	esac
=20
-	local g=3D"$(__gitdir)"
-	if [ -z "$g" ]; then
+	local g=3D
+	if ! g=3D"$(git rev-parse --git-dir 2>/dev/null)"; then
 		if [ $pcmode =3D yes ]; then
 			#In PC mode PS1 always needs to be set
 			PS1=3D"$ps1pc_start$ps1pc_end"
--=20
1.8.3.1.487.g8f4672d
