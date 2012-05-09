From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 08/19] completion: use $__git_dir instead of $(__gitdir)
Date: Wed,  9 May 2012 02:44:39 +0200
Message-ID: <1336524290-30023-9-git-send-email-szeder@ira.uka.de>
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
	id 1SRv36-00056b-U8
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259Ab2EIAqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:46:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56553 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab2EIAqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:46:13 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LpAm0-1Ry3vz3tO0-00eoEd; Wed, 09 May 2012 02:46:12 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:ve45E4asjEbXF45czRbwn3TWv7vztP7qH2/bwCSyy0q
 /SVkT4fmyGWxZFG6ss/JeVFfqwjH4R5ogH/lO0ylZElozBRj6L
 /VaaPVZsnpg8pgOs8ovl/dtWbBz5/jm+XwXXW23WkEbt+S/gHi
 DzeC287JxtlX1KHVFCXS/RmZIYr3QQdZBxPIBTUEfWYdQEoOZz
 oubCuhCRm7T416tzqajelaMzcPw/MWA/o2A3TuZh2PSIHdkqbx
 oR91hJLu0BlkYG1sGz6qNlxBAzA+cy41tRcfoIb4gfmHe+Z9r2
 R5wLaeQGjFKY+mILaoV7XDSmNnjs8u7LmUMxkTaP5foKSdlk44
 Ca5tP5Hw4wVz4oLvisr3Ab/YamuXo1WcDa68Sq4tvBjIzgAaYT
 xdUBv5BykvD+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197440>

The previous commit changed __gitdir() to store the repository path in
the $__git_dir variable.  Now we change all call sites to just call
__gitdir() directly and then use $__git_dir instead of doing
'dir=3D"$(__gitdir)"' command substitution, thereby sparing the overhea=
d
of fork()ing a subshell.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 106 ++++++++++++++++++-------=
--------
 1 file changed, 58 insertions(+), 48 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 85b933f2..5c8d4aea 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -219,33 +219,33 @@ __git_ps1_show_upstream ()
 __git_ps1 ()
 {
 	local __git_dir=3D""
-	local g=3D"$(__gitdir)"
-	if [ -z "$g" ]; then
+	__gitdir >/dev/null
+	if [ -z "$__git_dir" ]; then
 		return
 	fi
=20
 	local r=3D""
 	local b=3D""
-	if [ -f "$g/rebase-merge/interactive" ]; then
+	if [ -f "$__git_dir/rebase-merge/interactive" ]; then
 		r=3D"|REBASE-i"
-		b=3D"$(cat "$g/rebase-merge/head-name")"
-	elif [ -d "$g/rebase-merge" ]; then
+		b=3D"$(cat "$__git_dir/rebase-merge/head-name")"
+	elif [ -d "$__git_dir/rebase-merge" ]; then
 		r=3D"|REBASE-m"
-		b=3D"$(cat "$g/rebase-merge/head-name")"
+		b=3D"$(cat "$__git_dir/rebase-merge/head-name")"
 	else
-		if [ -d "$g/rebase-apply" ]; then
-			if [ -f "$g/rebase-apply/rebasing" ]; then
+		if [ -d "$__git_dir/rebase-apply" ]; then
+			if [ -f "$__git_dir/rebase-apply/rebasing" ]; then
 				r=3D"|REBASE"
-			elif [ -f "$g/rebase-apply/applying" ]; then
+			elif [ -f "$__git_dir/rebase-apply/applying" ]; then
 				r=3D"|AM"
 			else
 				r=3D"|AM/REBASE"
 			fi
-		elif [ -f "$g/MERGE_HEAD" ]; then
+		elif [ -f "$__git_dir/MERGE_HEAD" ]; then
 			r=3D"|MERGING"
-		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
+		elif [ -f "$__git_dir/CHERRY_PICK_HEAD" ]; then
 			r=3D"|CHERRY-PICKING"
-		elif [ -f "$g/BISECT_LOG" ]; then
+		elif [ -f "$__git_dir/BISECT_LOG" ]; then
 			r=3D"|BISECTING"
 		fi
=20
@@ -263,7 +263,7 @@ __git_ps1 ()
 				git describe --tags --exact-match HEAD ;;
 			esac 2>/dev/null)" ||
=20
-			b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
+			b=3D"$(cut -c1-7 "$__git_dir/HEAD" 2>/dev/null)..." ||
 			return
 			b=3D"($b)"
 		}
@@ -522,9 +522,9 @@ __gitcomp_nl ()
=20
 __git_heads ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -d "$dir" ]; then
-		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
+	__gitdir "${1-}" >/dev/null
+	if [ -d "$__git_dir" ]; then
+		git --git-dir=3D"$__git_dir" for-each-ref --format=3D'%(refname:shor=
t)' \
 			refs/heads
 		return
 	fi
@@ -532,9 +532,9 @@ __git_heads ()
=20
 __git_tags ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -d "$dir" ]; then
-		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
+	__gitdir "${1-}" >/dev/null
+	if [ -d "$__git_dir" ]; then
+		git --git-dir=3D"$__git_dir" for-each-ref --format=3D'%(refname:shor=
t)' \
 			refs/tags
 		return
 	fi
@@ -545,9 +545,10 @@ __git_tags ()
 # by checkout for tracking branches
 __git_refs ()
 {
-	local i hash dir=3D"$(__gitdir "${1-}")" track=3D"${2-}"
+	local i hash track=3D"${2-}"
 	local format refs
-	if [ -d "$dir" ]; then
+	__gitdir "${1-}" >/dev/null
+	if [ -d "$__git_dir" ]; then
 		case "$cur" in
 		refs|refs/*)
 			format=3D"refname"
@@ -556,20 +557,20 @@ __git_refs ()
 			;;
 		*)
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
-				if [ -e "$dir/$i" ]; then echo $i; fi
+				if [ -e "$__git_dir/$i" ]; then echo $i; fi
 			done
 			format=3D"refname:short"
 			refs=3D"refs/tags refs/heads refs/remotes"
 			;;
 		esac
-		git --git-dir=3D"$dir" for-each-ref --format=3D"%($format)" \
+		git --git-dir=3D"$__git_dir" for-each-ref --format=3D"%($format)" \
 			$refs
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			local ref entry
-			git --git-dir=3D"$dir" for-each-ref --shell --format=3D"ref=3D%(ref=
name:short)" \
+			git --git-dir=3D"$__git_dir" for-each-ref --shell --format=3D"ref=3D=
%(refname:short)" \
 				"refs/remotes/" | \
 			while read -r entry; do
 				eval "$entry"
@@ -583,7 +584,7 @@ __git_refs ()
 	fi
 	case "$cur" in
 	refs|refs/*)
-		git ls-remote "$dir" "$cur*" 2>/dev/null | \
+		git ls-remote "$__git_dir" "$cur*" 2>/dev/null | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -592,7 +593,7 @@ __git_refs ()
 		done
 		;;
 	*)
-		git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 're=
fs/remotes/*' 2>/dev/null | \
+		git ls-remote "$__git_dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/=
*' 'refs/remotes/*' 2>/dev/null | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -625,9 +626,10 @@ __git_refs_remotes ()
=20
 __git_remotes ()
 {
-	local i IFS=3D$'\n' d=3D"$(__gitdir)"
-	test -d "$d/remotes" && ls -1 "$d/remotes"
-	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.url'=
 2>/dev/null); do
+	local i IFS=3D$'\n'
+	__gitdir >/dev/null
+	test -d "$__git_dir/remotes" && ls -1 "$__git_dir/remotes"
+	for i in $(git --git-dir=3D"$__git_dir" config --get-regexp 'remote\.=
=2E*\.url' 2>/dev/null); do
 		i=3D"${i#remote.}"
 		echo "${i/.url*/}"
 	done
@@ -685,8 +687,9 @@ __git_complete_revlist_file ()
 		esac
=20
 		local IFS=3D$'\n'
+		__gitdir >/dev/null
 		COMPREPLY=3D($(compgen -P "$pfx" \
-			-W "$(git --git-dir=3D"$(__gitdir)" ls-tree "$ls" \
+			-W "$(git --git-dir=3D"$__git_dir" ls-tree "$ls" \
 				| sed '/^100... blob /{
 				           s,^.*	,,
 				           s,$, ,
@@ -936,7 +939,8 @@ __git_compute_porcelain_commands ()
 __git_pretty_aliases ()
 {
 	local i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "pretty\=
=2E.*" 2>/dev/null); do
+	__gitdir >/dev/null
+	for i in $(git --git-dir=3D"$__git_dir" config --get-regexp "pretty\.=
=2E*" 2>/dev/null); do
 		case "$i" in
 		pretty.*)
 			i=3D"${i#pretty.}"
@@ -949,7 +953,8 @@ __git_pretty_aliases ()
 __git_aliases ()
 {
 	local i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "alias\.=
=2E*" 2>/dev/null); do
+	__gitdir >/dev/null
+	for i in $(git --git-dir=3D"$__git_dir" config --get-regexp "alias\..=
*" 2>/dev/null); do
 		case "$i" in
 		alias.*)
 			i=3D"${i#alias.}"
@@ -962,7 +967,8 @@ __git_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
+	__gitdir >/dev/null
+	local word cmdline=3D$(git --git-dir=3D"$__git_dir" \
 		config --get "alias.$1")
 	for word in $cmdline; do
 		case "$word" in
@@ -1013,8 +1019,8 @@ __git_whitespacelist=3D"nowarn warn error error-a=
ll fix"
=20
 _git_am ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ]; then
+	__gitdir >/dev/null
+	if [ -d "$__git_dir"/rebase-apply ]; then
 		__gitcomp "--skip --continue --resolved --abort"
 		return
 	fi
@@ -1099,7 +1105,8 @@ _git_bisect ()
 	local subcommands=3D"start bad good skip reset visualize replay log r=
un"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
-		if [ -f "$(__gitdir)"/BISECT_START ]; then
+		__gitdir >/dev/null
+		if [ -f "$__git_dir"/BISECT_START ]; then
 			__gitcomp "$subcommands"
 		else
 			__gitcomp "replay start"
@@ -1559,9 +1566,9 @@ _git_log ()
 {
 	__git_has_doubledash && return
=20
-	local g=3D"$(__gitdir)"
+	__gitdir >/dev/null
 	local merge=3D""
-	if [ -f "$g/MERGE_HEAD" ]; then
+	if [ -f "$__git_dir/MERGE_HEAD" ]; then
 		merge=3D"--merge"
 	fi
 	case "$cur" in
@@ -1745,8 +1752,8 @@ _git_push ()
=20
 _git_rebase ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+	__gitdir >/dev/null
+	if [ -d "$__git_dir"/rebase-apply ] || [ -d "$__git_dir"/rebase-merge=
 ]; then
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
@@ -1845,7 +1852,8 @@ __git_config_get_set_variables ()
 		c=3D$((--c))
 	done
=20
-	git --git-dir=3D"$(__gitdir)" config $config_file --list 2>/dev/null =
|
+	__gitdir >/dev/null
+	git --git-dir=3D"$__git_dir" config $config_file --list 2>/dev/null |
 	while read -r line
 	do
 		case "$line" in
@@ -1880,7 +1888,8 @@ _git_config ()
 	remote.*.push)
 		local remote=3D"${prev#remote.}"
 		remote=3D"${remote%.push}"
-		__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" \
+		__gitdir >/dev/null
+		__gitcomp_nl "$(git --git-dir=3D"$__git_dir" \
 			for-each-ref --format=3D'%(refname):%(refname)' \
 			refs/heads)"
 		return
@@ -2304,7 +2313,8 @@ _git_remote ()
 		;;
 	update)
 		local i c=3D'' IFS=3D$'\n'
-		for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "remote=
s\..*" 2>/dev/null); do
+		__gitdir >/dev/null
+		for i in $(git --git-dir=3D"$__git_dir" config --get-regexp "remotes=
\..*" 2>/dev/null); do
 			i=3D"${i#remotes.}"
 			c=3D"$c ${i/ */}"
 		done
@@ -2441,7 +2451,8 @@ _git_stash ()
 			COMPREPLY=3D()
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
-			__gitcomp_nl "$(git --git-dir=3D"$(__gitdir)" stash list \
+			__gitdir >/dev/null
+			__gitcomp_nl "$(git --git-dir=3D"$__git_dir" stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
 		*)
@@ -2693,10 +2704,9 @@ _gitk ()
=20
 	__git_has_doubledash && return
=20
-	local __git_dir=3D""
-	local g=3D"$(__gitdir)"
-	local merge=3D""
-	if [ -f "$g/MERGE_HEAD" ]; then
+	local __git_dir=3D"" merge=3D""
+	__gitdir >/dev/null
+	if [ -f "$__git_dir/MERGE_HEAD" ]; then
 		merge=3D"--merge"
 	fi
 	case "$cur" in
--=20
1.7.10.1.541.gb1be298
