From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Suppress use of unsafe idiomatic use of && in cg-Xlib
Date: Wed, 10 May 2006 00:32:33 +0200
Message-ID: <20060509223233.20814.86977.stgit@gandelf.nowhere.earth>
References: <20060509222738.20814.57282.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 00:29:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdahZ-0003hK-De
	for gcvg-git@gmane.org; Wed, 10 May 2006 00:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWEIW3H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 18:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWEIW3G
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 18:29:06 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:28557 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751274AbWEIW3F (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 18:29:05 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 3177E221D8;
	Wed, 10 May 2006 00:29:04 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FdasI-0007GO-FG; Wed, 10 May 2006 00:40:14 +0200
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060509222738.20814.57282.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19858>


This is a necessary step to make any cogito script "set -e"-safe.

Also fixes similar issues in cg-admin-rewritehist and turn "set -e" on
there.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 cg-Xlib              |   82 ++++++++++++++++++++++++++------------------------
 cg-admin-rewritehist |    8 +++--
 2 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
index 31f93d2..ff2b895 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -26,7 +26,7 @@ warn()
 	fi
 
 	echo "Warning: $@" >&2
-	[ "$beep" ] && echo -ne "\a" >&2
+	[ -z "$beep" ] || echo -ne "\a" >&2
 }
 
 die()
@@ -177,7 +177,7 @@ showdate()
 {
 	local secs=$1 tzhours=${2:0:3} tzmins=${2:0:1}${2:3} format="$3"
 	# bash doesn't like leading zeros
-	[ "${tzhours:1:1}" = 0 ] && tzhours=${2:0:1}${2:2:1}
+	[ "${tzhours:1:1}" != 0 ] || tzhours=${2:0:1}${2:2:1}
 	secs=$(($secs + $tzhours * 3600 + $tzmins * 60))
 	[ "$format" ] || format="+%a, %d %b %Y %H:%M:%S $2"
 	if [ "$has_gnudate" ]; then
@@ -221,7 +221,7 @@ colorify_diffcolors="$colorify_diffcolor
 colorify_setup()
 {
 	local C="$1"
-	[ -n "$CG_COLORS" ] && C="$C:$CG_COLORS"
+	[ -z "$CG_COLORS" ] || C="$C:$CG_COLORS"
 
 	C=${C//=/=\'$'\e'[}
 	C=col${C//:/m\'; col}m\'
@@ -261,7 +261,7 @@ column_width()
 	done | sort -nr | head -n 1 |
 	(
 		read maxlen;
-		[ ${maxlen:-0} -gt $maxwidth ] && maxlen=$maxwidth;
+		[ ${maxlen:-0} -le $maxwidth ] || maxlen=$maxwidth;
 		echo ${maxlen:-0}
 	)
 }
@@ -283,7 +283,7 @@ columns_print()
 		else
 			fmt="$fmt%-${width}s"
 		fi
-		[ "$tab" ] && fmt="$fmt\t";
+		[ -z "$tab" ] || fmt="$fmt\t";
 	done
 	printf "$fmt\n" "${cols[@]}"
 }
@@ -321,7 +321,7 @@ pick_id()
 	'
 	LANG=C LC_ALL=C sed -ne "$pick_id_script"
 	# Ensure non-empty id name.
-	echo "[ -z \"\$GIT_${uid}_NAME\" ] && export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
+	echo "[ -n \"\$GIT_${uid}_NAME\" ] || export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
 }
 
 pick_author()
@@ -355,16 +355,16 @@ while IFS= read -r inp; do
 	done
 	path[${#path[@]}]="$inp"
 	for (( i=0; $i < ${#path[@]}; i++ )); do
-		[ "${path[$i]}" = "." ] && continue
+		[ "${path[$i]}" != "." ] || continue
 		if [ "${path[$i]}" = ".." ]; then
-			[ "${#path2[@]}" -gt 0 ] && unset path2[$((${#path2[@]} - 1))]
+			[ "${#path2[@]}" -le 0 ] || unset path2[$((${#path2[@]} - 1))]
 			continue
 		fi
 		path2[${#path2[@]}]="${path[$i]}"
 	done
 	for (( i=0; $i < ${#path2[@]}; i++ )); do
 		echo -n "${path2[$i]}"
-		[ $i -lt $((${#path2[@]} - 1)) ] && echo -n /
+		[ $i -ge $((${#path2[@]} - 1)) ] || echo -n /
 	done
 	echo
 done
@@ -400,7 +400,7 @@ #              only the dirname/ will be
 # EXTRAEXCLUDE: extra exclude pattern
 list_untracked_files()
 {
-	[ "$_git_no_wc" ] && die "INTERNAL ERROR: list_untracked_files() outside a working copy"
+	[ -z "$_git_no_wc" ] || die "INTERNAL ERROR: list_untracked_files() outside a working copy"
 	excludeflag="$1"; shift
 	squashflag="$1"; shift
 	EXCLUDE=()
@@ -443,7 +443,7 @@ list_untracked_files()
 		fi
 	fi
 	local listdirs=
-	[ "$squashflag" = "squashdirs" ] && listdirs=--directory
+	[ "$squashflag" != "squashdirs" ] || listdirs=--directory
 	git-ls-files -z --others $listdirs "${EXCLUDE[@]}"
 }
 
@@ -512,8 +512,8 @@ editor()
 	actionkey="$1"; shift
 
 	${EDITOR:-vi} "$LOGMSG2"
-	[ "$force" ] && return 0
-	[ "$LOGMSG2" -nt "$LOGMSG" ] && return 0
+	[ -z "$force" ] || return 0
+	[ "$LOGMSG" -nt "$LOGMSG2" ] || return 0
 
 	echo "Log message unchanged or not specified" >&2
 	while true; do
@@ -538,7 +538,7 @@ # the working copy (if ROLLBACK_BOOL) an
 # Returns false in case of local modifications (but only if ROLLBACK_ROLL).
 tree_timewarp()
 {
-	[ "$_git_no_wc" ] && die "INTERNAL ERROR: tree_timewarp() outside a working copy"
+	[ -z "$_git_no_wc" ] || die "INTERNAL ERROR: tree_timewarp() outside a working copy"
 	local no_head_update=
 	if [ "$1" = "--no-head-update" ]; then
 		no_head_update=1
@@ -550,14 +550,14 @@ tree_timewarp()
 	local branch="$1"; shift
 	local localmods=0
 
-	[ -s "$_git/merging" ] && die "merge in progress - cancel it by cg-reset first"
+	[ ! -s "$_git/merging" ] || die "merge in progress - cancel it by cg-reset first"
 
 	if [ -n "$rollback" ]; then
 		local patchfile="$(mktemp -t gituncommit.XXXXXX)"
 		cg-diff -r "$base" >"$patchfile"
-		[ -s "$patchfile" ] &&
+		[ ! -s "$patchfile" ] ||
 			warn "uncommitted local changes, trying to bring them $dirstr"
-		[ -s "$patchfile" ] && localmods=1
+		[ ! -s "$patchfile" ] || localmods=1
 
 		git-read-tree -m "$branch" || die "$branch: bad commit"
 		[ "$no_head_update" ] || git-update-ref HEAD "$branch" || :
@@ -589,9 +589,9 @@ conservative_merge_base()
 	_cg_base_conservative=
 	for (( safecounter=0; $safecounter < 1000; safecounter++ )) ; do
 		baselist=($(git-merge-base --all "${baselist[@]}")) || return 1
-		[ "${#baselist[@]}" -le "1" ] && break
+		[ "${#baselist[@]}" -gt "1" ] || break
 	done
-	[ $safecounter -gt 0 ] && _cg_base_conservative=$safecounter
+	[ $safecounter -le 0 ] || _cg_base_conservative=$safecounter
 	_cg_baselist=("${baselist[@]}")
 }
 
@@ -603,7 +603,7 @@ # Never use it. If you do, accompany it 
 # it safe to use it.
 update_index()
 {
-	[ "$_git_no_wc" ] && die "INTERNAL ERROR: update_index() outside a working copy"
+	[ -z "$_git_no_wc" ] || die "INTERNAL ERROR: update_index() outside a working copy"
 	git-update-index --refresh | sed 's/needs update$/locally modified/'
 }
 
@@ -620,14 +620,14 @@ is_same_repo()
 	# second side...
 	if [ ! -w "$dir1" -o ! -w "$dir2" ]; then
 		# ...except in readonly setups.
-		[ "$(readlink -f "$dir1")" = "$(readlink -f "$dir2")" ] && diff=0
+		[ "$(readlink -f "$dir1")" != "$(readlink -f "$dir2")" ] || diff=0
 	else
 		n=$$
 		while [ -e "$dir1/.,,lnstest-$n" -o -e "$dir2/.,,lnstest-$n" ]; do
 			n=$((n+1))
 		done
 		touch "$dir1/.,,lnstest-$n"
-		[ -e "$dir2/.,,lnstest-$n" ] && diff=0
+		[ ! -e "$dir2/.,,lnstest-$n" ] || diff=0
 		rm "$dir1/.,,lnstest-$n"
 	fi
 	return $diff
@@ -679,7 +679,7 @@ deprecated_alias()
 	cmd="${0##*/}"
 	propername="$1"; shift
 	for a in "$@"; do
-		[ "$cmd" = "$a" ] && \
+		[ "$cmd" != "$a" ] || \
 			warn "'$a' is a deprecated alias, please use '$propername' instead"
 	done
 }
@@ -709,7 +709,7 @@ print_help()
 	echo
 	echo "Options:"
 	maxlen="$(sed -n 's/^# \(-.*\)::[^A-Za-z0-9].*/\1/p' < "$_cg_cmd" | column_width)"
-	[ $maxlen -lt 11 ] && maxlen=11 # --long-help
+	[ $maxlen -ge 11 ] || maxlen=11 # --long-help
 	_cg_fmt="  %-20s %s\n"
 	sed -n 's/# \(-.*\)::[^A-Za-z0-9]\(.*\)/\1\n\2/p' < "$_cg_cmd" | while read line; do
 		case "$line" in
@@ -727,7 +727,7 @@ print_help()
 }
 
 for option in "$@"; do
-	[ x"$option" = x-- ] && break
+	[ x"$option" != x-- ] || break
 	if [ x"$option" = x"-h" ] || [ x"$option" = x"--help" ]; then
 		print_help short "${_cg_cmd##cg-}"
 	elif [ x"$option" = x"--long-help" ]; then
@@ -777,8 +777,8 @@ optparse()
 		--)	optshift; return 1 ;;
 		-*)	return 0 ;;
 		*)	while (( ++ARGPOS < ${#ARGS[@]} )); do
-				[[ "${ARGS[$ARGPOS]}" == -- ]] && return 1
-				[[ "${ARGS[$ARGPOS]}" == -* ]] && return 0
+				[[ "${ARGS[$ARGPOS]}" != -- ]] || return 1
+				[[ "${ARGS[$ARGPOS]}" != -* ]] || return 0
 			done;
 			return 1 ;;
 		esac
@@ -786,22 +786,26 @@ optparse()
 
 	CUROPT="${ARGS[$ARGPOS]}"
 	local match="${1%=}" minmatch="${2:-1}" opt="$CUROPT" o="$CUROPT" val
-	[[ "$1" == *= ]] && val="$match"
+	[[ "$1" != *= ]] || val="$match"
 	case "$match" in
 	--*)
-		[ "$val" ] && o="${o%%=*}"
+		[ -z "$val" ] || o="${o%%=*}"
 		[ ${#o} -ge $((2 + $minmatch)) -a \
 			"${match:0:${#o}}" = "$o" ] || return 1
-		[[ -n "$val" && "$opt" == *=?* ]] \
-			&& ARGS[$ARGPOS]="${opt#*=}" \
-			|| optshift "$val" ;;
+		if [[ -n "$val" && "$opt" == *=?* ]]; then
+			ARGS[$ARGPOS]="${opt#*=}"
+		else
+			optshift "$val"
+		fi ;;
 	-?)
 		[[ "$o" == $match* ]] || return 1
 		[[ "$o" != -?-* || -n "$val" ]] || optfail
 		ARGS[$ARGPOS]=${o#$match}
-		[ -n "${ARGS[$ARGPOS]}" ] \
-			&& { [ -n "$val" ] || ARGS[$ARGPOS]=-"${ARGS[$ARGPOS]}"; } \
-			|| optshift "$val" ;;
+		if [ -n "${ARGS[$ARGPOS]}" ]; then
+			[ -n "$val" ] || ARGS[$ARGPOS]=-"${ARGS[$ARGPOS]}";
+		else
+			optshift "$val"
+		fi ;;
 	*)
 		die "optparse cannot handle $1" ;;
 	esac
@@ -846,7 +850,7 @@ check_tool()
 			fi
 		done
 		IFS="$save_IFS"
-		[ "$hasname" ] && break
+		[ -z "$hasname" ] || break
 	done 2>/dev/null
 }
 
@@ -882,7 +886,7 @@ if [ ! "$_git_repo_unneeded" ]; then
 		_git=.
 		export GIT_DIR=.
 	fi
-	[ "$GIT_DIR" = . ] && _git_no_wc=1
+	[ "$GIT_DIR" != . ] || _git_no_wc=1
 	if [ ! -d "$_git" ]; then
 		echo "There is no GIT repository here ($_git not found)" >&2
 		exit 1
@@ -894,8 +898,8 @@ if [ ! "$_git_repo_unneeded" ]; then
 		exit 1
 	fi
 	_git_head=master
-	[ -s "$_git/HEAD" ] && { _git_head="$(git-symbolic-ref HEAD)"; _git_head="${_git_head#refs/heads/}"; }
-	[ -s "$_git/head-name" ] && _git_head="$(cat "$_git/head-name")"
+	[ ! -s "$_git/HEAD" ] || { _git_head="$(git-symbolic-ref HEAD)"; _git_head="${_git_head#refs/heads/}"; }
+	[ ! -s "$_git/head-name" ] || _git_head="$(cat "$_git/head-name")"
 fi
 
 # Check if the script requires to be called from the workdir root.
diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
index 9fa4c2a..958a8ab 100755
--- a/cg-admin-rewritehist
+++ b/cg-admin-rewritehist
@@ -133,6 +133,8 @@ # as their parents instead of the merge 
 
 # Testsuite: TODO
 
+set -e
+
 USAGE="cg-admin-rewritehist [-d TEMPDIR] [-r STARTREV]... [FILTERS] DESTBRANCH"
 _git_wc_unneeded=1
 _git_requires_root=1
@@ -169,10 +171,10 @@ done
 
 dstbranch="${ARGS[0]}"
 [ -n "$dstbranch" ] || die "missing branch name"
-[ -s "$_git/refs/heads/$dstbranch" ] && die "branch $dstbranch already exists"
-[ -s "$_git/branches/$dstbranch" ] && die "branch $dstbranch is already a remote branch"
+[ ! -s "$_git/refs/heads/$dstbranch" ] || die "branch $dstbranch already exists"
+[ ! -s "$_git/branches/$dstbranch" ] || die "branch $dstbranch is already a remote branch"
 
-[ -e "$tempdir" ] && die "$tempdir already exists, please remove it"
+[ ! -e "$tempdir" ] || die "$tempdir already exists, please remove it"
 mkdir -p "$tempdir/t"
 cd "$tempdir/t"
 
