From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 17/21] completion: don't use __gitdir() for git commands
Date: Thu, 25 Feb 2016 23:50:46 +0100
Message-ID: <1456440650-32623-18-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:54:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4nP-00075S-J1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbcBYWyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:54:03 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35864 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWyB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:54:01 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4nE-0007uU-Ap; Thu, 25 Feb 2016 23:53:57 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440838.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287466>

Several completion functions contain the following pattern to run git
commands respecting the path to the repository specified on the
command line:

  git --git-dir=3D"$(__gitdir)" <cmd> <options>

This imposes the overhead of fork()ing a subshell for the command
substitution and potentially fork()+exec()ing 'git rev-parse' inside
__gitdir().

Now, if neither '--gitdir=3D<path>' nor '-C <path>' options are
specified on the command line, then those git commands are perfectly
capable to discover the repository on their own.  If either one or
both of those options are specified on the command line, then, again,
the git commands could discover the repository, if we pass them all of
those options from the command line.

This means we don't have to run __gitdir() at all for git commands and
can spare its fork()+exec() overhead.

Use Bash parameter expansions to check the $__git_dir variable and
$__git_C_args array and to assemble the appropriate '--git-dir=3D<path>=
'
and '-C <path>' options if either one or both are present on the
command line.  These parameter expansions are, however, rather long,
so instead of changing all git executions and make already long lines
even longer, encapsulate running git with '--git-dir=3D<path> -C <path>=
'
options into the new __git() wrapper function.

There's one tricky case, though: in __git_refs() local refs are listed
with 'git for-each-ref', where "local" is not necessarily the
repository we are currently in, but it might mean a remote repository
in the filesystem (e.g. listing refs for 'git fetch /some/other/repo
<TAB>').  Use one-shot variable assignment to override $__git_dir with
the path of the repository where the refs should come from.  Although
one-shot variable assignments in front of shell functions are to be
avoided in our scripts in general, in the Bash completion script we
can do that safely.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 58 ++++++++++++++++++--------=
--------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 9ffea9580ff7..c496f4026fc8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -61,6 +61,14 @@ __gitdir ()
 	fi
 }
=20
+# Runs git with all the options given as argument, respecting any
+# '--git-dir=3D<path>' and '-C <path>' options present on the command =
line
+__git ()
+{
+	git ${__git_C_args:+"${__git_C_args[@]}"} \
+		${__git_dir:+--git-dir=3D"$__git_dir"} "$@"
+}
+
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
@@ -287,13 +295,11 @@ __gitcomp_file ()
 # argument, and using the options specified in the second argument.
 __git_ls_files_helper ()
 {
-	local dir=3D"$(__gitdir)"
-
 	if [ "$2" =3D=3D "--committable" ]; then
-		git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir=3D"$dir" -C "$1"=
 diff-index --name-only --relative HEAD
+		__git -C "$1" diff-index --name-only --relative HEAD
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
-		git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir=3D"$dir" -C "$1"=
 ls-files --exclude-standard $2
+		__git -C "$1" ls-files --exclude-standard $2
 	fi 2>/dev/null
 }
=20
@@ -323,8 +329,7 @@ __git_heads ()
 {
 	local dir=3D"$(__gitdir)"
 	if [ -d "$dir" ]; then
-		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
-			refs/heads
+		__git for-each-ref --format=3D'%(refname:short)' refs/heads
 		return
 	fi
 }
@@ -333,8 +338,7 @@ __git_tags ()
 {
 	local dir=3D"$(__gitdir)"
 	if [ -d "$dir" ]; then
-		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
-			refs/tags
+		__git for-each-ref --format=3D'%(refname:short)' refs/tags
 		return
 	fi
 }
@@ -387,14 +391,14 @@ __git_refs ()
 			refs=3D"refs/tags refs/heads refs/remotes"
 			;;
 		esac
-		git --git-dir=3D"$dir" for-each-ref --format=3D"%($format)" \
+		__git_dir=3D"$dir" __git for-each-ref --format=3D"%($format)" \
 			$refs
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			local ref entry
-			git --git-dir=3D"$dir" for-each-ref --shell --format=3D"ref=3D%(ref=
name:short)" \
+			__git for-each-ref --shell --format=3D"ref=3D%(refname:short)" \
 				"refs/remotes/" | \
 			while read -r entry; do
 				eval "$entry"
@@ -408,7 +412,7 @@ __git_refs ()
 	fi
 	case "$cur" in
 	refs|refs/*)
-		git --git-dir=3D"$dir" ls-remote "$remote" "$cur*" 2>/dev/null | \
+		__git ls-remote "$remote" "$cur*" 2>/dev/null | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -419,10 +423,10 @@ __git_refs ()
 	*)
 		if [ "$named_remote" =3D y ]; then
 			echo "HEAD"
-			git --git-dir=3D"$dir" for-each-ref --format=3D"%(refname:short)" -=
- \
+			__git for-each-ref --format=3D"%(refname:short)" -- \
 				"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
 		else
-			git --git-dir=3D"$dir" ls-remote "$remote" HEAD \
+			__git ls-remote "$remote" HEAD \
 				'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' 2>/dev/null |
 			while read -r hash i; do
 				case "$i" in
@@ -449,7 +453,7 @@ __git_refs2 ()
 __git_refs_remotes ()
 {
 	local i hash
-	git --git-dir=3D"$(__gitdir)" ls-remote "$1" 'refs/heads/*' 2>/dev/nu=
ll | \
+	__git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
 	while read -r hash i; do
 		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
@@ -459,7 +463,7 @@ __git_remotes ()
 {
 	local d=3D"$(__gitdir)"
 	test -d "$d/remotes" && ls -1 "$d/remotes"
-	git --git-dir=3D"$d" remote
+	__git remote
 }
=20
 # Returns true if $1 matches the name of a configured remote, false ot=
herwise.
@@ -525,7 +529,7 @@ __git_complete_revlist_file ()
 		*)   pfx=3D"$ref:$pfx" ;;
 		esac
=20
-		__gitcomp_nl "$(git ${__git_C_args:+"${__git_C_args[@]}"} --git-dir=3D=
"$(__gitdir)" ls-tree "$ls" 2>/dev/null \
+		__gitcomp_nl "$(__git ls-tree "$ls" 2>/dev/null \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -803,7 +807,7 @@ __git_compute_porcelain_commands ()
 __git_get_config_variables ()
 {
 	local section=3D"$1" i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --name-only --get-reg=
exp "^$section\..*" 2>/dev/null); do
+	for i in $(__git config --name-only --get-regexp "^$section\..*" 2>/d=
ev/null); do
 		echo "${i#$section.}"
 	done
 }
@@ -821,8 +825,7 @@ __git_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
-		config --get "alias.$1" 2>/dev/null)
+	local word cmdline=3D$(__git config --get "alias.$1" 2>/dev/null)
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
@@ -1192,7 +1195,7 @@ _git_commit ()
 		return
 	esac
=20
-	if git --git-dir=3D"$(__gitdir)" rev-parse --verify --quiet HEAD >/de=
v/null; then
+	if __git rev-parse --verify --quiet HEAD >/dev/null; then
 		__git_complete_index_file "--committable"
 	else
 		# This is the first commit
@@ -1778,7 +1781,7 @@ _git_send_email ()
 	case "$prev" in
 	--to|--cc|--bcc|--from)
 		__gitcomp "
-		$(git --git-dir=3D"$(__gitdir)" send-email --dump-aliases 2>/dev/nul=
l)
+		$(__git send-email --dump-aliases 2>/dev/null)
 		"
 		return
 		;;
@@ -1810,7 +1813,7 @@ _git_send_email ()
 		;;
 	--to=3D*|--cc=3D*|--bcc=3D*|--from=3D*)
 		__gitcomp "
-		$(git --git-dir=3D"$(__gitdir)" send-email --dump-aliases 2>/dev/nul=
l)
+		$(__git send-email --dump-aliases 2>/dev/null)
 		" "" "${cur#--*=3D}"
 		return
 		;;
@@ -1855,7 +1858,7 @@ __git_config_get_set_variables ()
 		c=3D$((--c))
 	done
=20
-	git --git-dir=3D"$(__gitdir)" config $config_file --name-only --list =
2>/dev/null
+	__git config $config_file --name-only --list 2>/dev/null
 }
=20
 _git_config ()
@@ -1890,9 +1893,8 @@ _git_config ()
 	remote.*.push)
 		local remote=3D"${prev#remote.}"
 		remote=3D"${remote%.push}"
-		__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" \
-			for-each-ref --format=3D'%(refname):%(refname)' \
-			refs/heads)"
+		__gitcomp_nl "$(__git for-each-ref
+			--format=3D'%(refname):%(refname)' refs/heads)"
 		return
 		;;
 	pull.twohead|pull.octopus)
@@ -2475,12 +2477,12 @@ _git_stash ()
 			if [ $cword -eq 3 ]; then
 				__gitcomp_nl "$(__git_refs)";
 			else
-				__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" stash list \
+				__gitcomp_nl "$(__git stash list \
 						| sed -n -e 's/:.*//p')"
 			fi
 			;;
 		show,*|apply,*|drop,*|pop,*)
-			__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" stash list \
+			__gitcomp_nl "$(__git stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
 		*)
--=20
2.7.2.410.g92cb358
