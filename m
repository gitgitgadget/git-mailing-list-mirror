From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/8] cogito: Fix all users of the old *-id scripts.
Date: Mon, 19 Sep 2005 22:13:11 -0400
Message-ID: <1127182391.31115.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:13:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXdG-0004kz-DE
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVITCNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVITCNP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:13:15 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:34219 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964839AbVITCNO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:13:14 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXdB-00065G-Gy
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:13:13 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXd9-0001h9-Pw
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:13:11 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8953>

Fix all users of the old *-id scripts.

Use cg-object-id instead.

diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -123,12 +123,12 @@ COMMIT_ID, FROM_ID, TO_ID, BASE_COMMIT::
 	- empty string, 'this' or 'HEAD' (current HEAD)
 	- branch name (as registered with $(man 1 cg-branch-add))
 	- tag name (as registered with $(man 1 cg-tag))
 	- date string (as recognized by the 'date' tool)
 	- shortcut object hash (shorted unambiguous hash lead)
-	- commit object hash (as returned by 'cg-commit-id')
-	- tree object hash (as returned by 'cg-tree-id')
+	- commit object hash (as returned by 'cg-object-id')
+	- tree object hash (as returned by 'cg-object-id -t')
 
 TAG_NAME::
 	Indicates a free form tag name.
 
 OBJECT_TYPE::
diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -15,12 +15,12 @@
 . ${COGITO_LIB}cg-Xlib || exit 1
 
 id="$1"
 
 if [ "${id:(-1):1}" = "^" ]; then
-	# cg-parent-id
-	id=$(cg-commit-id "${id%^}") || exit 1
+	# find parent
+	id=$(cg-object-id "${id%^}") || exit 1
 	git-cat-file commit "$id" | awk '/^parent/{print $2," "};/^$/{exit}' || exit 1
 	exit
 fi
 
 if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
diff --git a/cg-admin-cat b/cg-admin-cat
--- a/cg-admin-cat
+++ b/cg-admin-cat
@@ -34,11 +34,11 @@ while optparse; do
 	fi
 done
 
 [ "$ARGS" ] || usage
 
-id=$(cg-tree-id "$rev") || exit 1
+id=$(cg-object-id -t "$rev") || exit 1
 
 git-ls-tree "$id" "${ARGS[@]}" |
 	while read -r mode type sha name
 	do
 		case "$type" in
diff --git a/cg-admin-ls b/cg-admin-ls
--- a/cg-admin-ls
+++ b/cg-admin-ls
@@ -40,8 +40,8 @@ while optparse; do
 	else
 		optfail
 	fi
 done
 
-id=$(cg-tree-id $tree_id) || exit 1
+id=$(cg-object-id -t $tree_id) || exit 1
 
 git-ls-tree "$id" "${ARGS[@]}"
diff --git a/cg-admin-uncommit b/cg-admin-uncommit
--- a/cg-admin-uncommit
+++ b/cg-admin-uncommit
@@ -43,17 +43,17 @@ while optparse; do
 		optfail
 	fi
 done
 
 
-base=$(cg-commit-id) || exit 1
+base=$(cg-object-id) || exit 1
 
-commit=$(cg-commit-id "$1") || exit 1
+commit=$(cg-object-id "$1") || exit 1
 git-rev-list $base | grep -q $commit || \
 	die "$commit: not an ancestor of HEAD"
 
-parent=$(cg-parent-id "$commit") || exit 1
+parent=$(cg-object-id -p "$commit") || exit 1
 [ "$parent" ] || die "cannot rewind behind the initial commit"
 
 
 echo "Rewinding $base (HEAD) -> $parent" >&2
 
diff --git a/cg-branch-add b/cg-branch-add
--- a/cg-branch-add
+++ b/cg-branch-add
@@ -31,11 +31,11 @@
 # $GIT_DIR/branches/BRANCH_NAME::
 #	Contains the source location of the remote branch.
 #
 # $GIT_DIR/refs/heads/BRANCH_NAME::
 # 	Contains pointer to the latest commit in a branch. It can be more
-#	conveniently retrieved using `cg-commit-id BRANCH_NAME`.
+#	conveniently retrieved using `cg-object-id BRANCH_NAME`.
 #
 # EXAMPLE USAGE
 # -------------
 # Let's say you have a repository at `git+ssh://host/path/repo.git` and you
 # want to fetch its 'testing' branch to your local repository. In that case
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -156,11 +156,11 @@ while optparse; do
 	elif optparse -f; then
 		force=1
 	elif optparse -m=; then
 		msgs[${#msgs[@]}]="$OPTARG"
 	elif optparse -c=; then
-		copy_commit="$(cg-commit-id "$OPTARG")"
+		copy_commit="$(cg-object-id "$OPTARG")"
 	else
 		optfail
 	fi
 done
 
@@ -388,11 +388,11 @@ if [ -s "$_git/HEAD" ]; then
 fi
 
 treeid=$(git-write-tree ${missingok})
 [ "$treeid" ] || die "git-write-tree failed"
 if [ ! "$force" ] && [ ! "$merging" ] && [ "$oldhead" ] &&
-   [ "$treeid" = "$(cg-tree-id)" ]; then
+   [ "$treeid" = "$(cg-object-id -t)" ]; then
 	echo "Refusing to make an empty commit - the tree was not modified" >&2
 	echo "since the previous commit. If you really want to make the" >&2
 	echo "commit, pass cg-commit the -f argument." >&2
 	exit 2;
 fi
diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -125,19 +125,19 @@ while optparse; do
 done
 
 if [ "$parent" ]; then
 	id2="$id1"
 	id="$id2"; [ "$id" = " " ] && id=""
-	id1=$(cg-parent-id "$id" | head -n 1) || exit 1
+	id1=$(cg-object-id -p "$id" | head -n 1) || exit 1
 	[ "$id1" ] || exit 1
 fi
 
 if [ "$mergebase" ]; then
 	[ "$id1" != " " ] || id1="HEAD"
 	[ "$id2" != " " ] || id2="origin"
-	id1=$(cg-commit-id "$id1") || exit 1
-	id2=$(cg-commit-id "$id2") || exit 1
+	id1=$(cg-object-id "$id1") || exit 1
+	id2=$(cg-object-id "$id2") || exit 1
 	id1=$(git-merge-base $id1 $id2) || exit 1
 fi
 
 
 filter=$(mktemp -t gitdiff.XXXXXX)
@@ -146,13 +146,13 @@ for file in "${ARGS[@]}"; do
 	echo "${_git_relpath}$file" >>$filter
 done
 
 if [ "$id2" = " " ]; then
 	if [ "$id1" != " " ]; then
-		tree=$(cg-tree-id "$id1") || exit 1
+		tree=$(cg-object-id -t "$id1") || exit 1
 	else
-		tree=$(cg-tree-id) || exit 1
+		tree=$(cg-object-id -t) || exit 1
 	fi
 
 	# Ensure to only diff modified files
 	git-update-index --refresh >/dev/null
 
@@ -166,12 +166,12 @@ if [ "$id2" = " " ]; then
 	[ "$ret" ] && die "no files matched"
 	exit $ret
 fi
 
 
-id1=$(cg-tree-id "$id1") || exit 1
-id2=$(cg-tree-id "$id2") || exit 1
+id1=$(cg-object-id -t "$id1") || exit 1
+id2=$(cg-object-id -t "$id2") || exit 1
 
 [ "$id1" = "$id2" ] && exit 0
 
 cat $filter | path_xargs git-diff-tree -r -p $id1 $id2 | colorize | pager
 
diff --git a/cg-export b/cg-export
--- a/cg-export
+++ b/cg-export
@@ -15,16 +15,16 @@ _git_requires_root=1
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
 if [ "$1" = "-r" ]; then
 	shift
-	# We do not resolve to cg-tree-id since git-tar-tree can utilize some commit
+	# We do not resolve to tree id since git-tar-tree can utilize some commit
 	# information.
-	id="$(cg-commit-id "$1" 2>/dev/null)" || id="$1"
+	id="$(cg-object-id "$1" 2>/dev/null)" || id="$1"
 	shift
 else
-	id="$(cg-commit-id)"
+	id="$(cg-object-id)"
 fi
 
 dest=$1
 
 ([ "$dest" ] && [ "$id" ]) || usage
@@ -50,11 +50,11 @@ case $dest in
 		esac
 		;;
 	*)
 		mkdir -p $dest || die "cannot create $dest"
 		export GIT_INDEX_FILE="$dest/.git-index"
-		id="$(cg-tree-id "$id")"
+		id="$(cg-object-id -t "$id")"
 		git-read-tree $id
 		git-checkout-index "--prefix=$dest/" -a
 		rm $GIT_INDEX_FILE
 	;;
 esac
diff --git a/cg-fetch b/cg-fetch
--- a/cg-fetch
+++ b/cg-fetch
@@ -392,13 +392,13 @@ if [ ! "$orig_head" ]; then
 	echo "New branch: $new_head"
 
 elif [ "$orig_head" != "$new_head" ]; then
 	echo "Tree change: $orig_head:$new_head"
 	if [ "$verbose" ] ; then
-		git-diff-tree -r $(cg-tree-id $orig_head) $(cg-tree-id $new_head)
+		git-diff-tree -r $(cg-object-id -t $orig_head) $(cg-object-id -t $new_head)
 	else
-		git-diff-tree -r $(cg-tree-id $orig_head) $(cg-tree-id $new_head) | awk '{ print $5" "$6 }'
+		git-diff-tree -r $(cg-object-id -t $orig_head) $(cg-object-id -t $new_head) | awk '{ print $5" "$6 }'
 	fi
 else
 	echo "Up to date."
 	exit
 fi
diff --git a/cg-help b/cg-help
--- a/cg-help
+++ b/cg-help
@@ -101,11 +101,11 @@ These expressions can be used interchang
 	empty string, "this" or "HEAD" (current HEAD)
 	branch name (as registered with cg-branch-add)
 	tag name (as registered with cg-tag)
 	date string (as recognized by the date tool)
 	shortcut hash (shorted unambiguous hash lead)
-	commit object hash (as returned by cg-commit-id)
+	commit object hash (as returned by cg-object-id)
 	tree object hash (accepted only by some commands)
 
 For details on individual commands, do e.g.:
 	cg-help cg-log
 	cg-log --help
diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -283,18 +283,18 @@ done
 
 
 if [ "$mergebase" ]; then
 	[ "$log_start" ] || log_start="HEAD"
 	[ "$log_end" ] || log_end="origin"
-	id1=$(cg-commit-id "$log_start") || exit 1
-	id2=$(cg-commit-id "$log_end") || exit 1
+	id1=$(cg-object-id "$log_start") || exit 1
+	id2=$(cg-object-id "$log_end") || exit 1
 	log_start=$(git-merge-base $id1 $id2) || exit 1
 fi
 
-id1="$(cg-commit-id "$log_start")" || exit 1
+id1="$(cg-object-id "$log_start")" || exit 1
 if [ "$log_end" ]; then
-	id2="$(cg-commit-id "$log_end")" || exit 1
+	id2="$(cg-object-id "$log_end")" || exit 1
 	revls="git-rev-list --pretty=raw $id2 ^$id1"
 else
 	revls="git-rev-list --pretty=raw $id1"
 fi
 
diff --git a/cg-merge b/cg-merge
--- a/cg-merge
+++ b/cg-merge
@@ -74,29 +74,29 @@ posthook()
 		$_git/hooks/merge-post "$branchname" "$base" "$head" "$branch" "$@"
 	fi
 }
 
 
-head=$(cg-commit-id) || exit 1
+head=$(cg-object-id) || exit 1
 
 
 careful=
 base=
 while optparse; do
 	if optparse -c; then
 		careful=1
 	elif optparse -b=; then
-		base=$(cg-commit-id "$OPTARG") || exit 1
+		base=$(cg-object-id "$OPTARG") || exit 1
 	else
 		optfail
 	fi
 done
 
 branchname="${ARGS[0]}"
 [ "$branchname" ] || { [ -s $_git/refs/heads/origin ] && branchname=origin; }
 [ "$branchname" ] || die "what to merge?"
-branch=$(cg-commit-id "$branchname") || exit 1
+branch=$(cg-object-id "$branchname") || exit 1
 
 [ "$base" ] || base=$(git-merge-base "$head" "$branch")
 [ "$base" ] || die "unable to automatically determine merge base"
 
 
@@ -133,11 +133,11 @@ echo "Merging $base -> $branch" >&2
 echo -e "\tto $head..." >&2
 
 
 prehook tree
 
-if ! git-read-tree -u -m $(cg-tree-id $base) $(cg-tree-id $head) $(cg-tree-id $branch); then
+if ! git-read-tree -u -m $(cg-object-id -t $base) $(cg-object-id -t $head) $(cg-object-id -t $branch); then
 	echo "cg-merge: git-read-tree failed (merge likely blocked by local changes)" >&2
 	posthook tree localchanges
 	exit 1
 fi
 
diff --git a/cg-mkpatch b/cg-mkpatch
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -127,18 +127,18 @@ while optparse; do
 done
 
 if [ "$mergebase" ]; then
 	[ "$log_start" ] || log_start="HEAD"
 	[ "$log_end" ] || log_end="origin"
-	id1=$(cg-commit-id "$log_start") || exit 1
-	id2=$(cg-commit-id "$log_end") || exit 1
+	id1=$(cg-object-id "$log_start") || exit 1
+	id2=$(cg-object-id "$log_end") || exit 1
 	log_start=$(git-merge-base $id1 $id2) || exit 1
 fi
 
 if [ "$log_end" ]; then
-	id1=$(cg-commit-id "$log_start") || exit 1
-	id2=$(cg-commit-id "$log_end") || exit 1
+	id1=$(cg-object-id "$log_start") || exit 1
+	id2=$(cg-object-id "$log_end") || exit 1
 
 	if [ "$outdir" ]; then
 		mkdir -p "$outdir" || die "cannot create patch directory"
 		pnum=001
 	fi
@@ -169,8 +169,8 @@ if [ "$log_end" ]; then
 		fi
 	done
 
 else
 	[ "$outdir" ] && die "-d makes sense only for patch series"
-	id=$(cg-commit-id "$log_start") || exit 1
+	id=$(cg-object-id "$log_start") || exit 1
 	showpatch $id
 fi
diff --git a/cg-seek b/cg-seek
--- a/cg-seek
+++ b/cg-seek
@@ -27,20 +27,20 @@ _git_requires_root=1
 dstcommit=$1
 
 
 [ -s $_git/blocked ] && grep -vq '^seeked from ' $_git/blocked && die "action blocked: $(cat $_git/blocked)"
 
-curcommit=$(cg-commit-id) || exit 1
+curcommit=$(cg-object-id) || exit 1
 
 if [ "$dstcommit" ] && [ "$dstcommit" != "$_git_head" ]; then
 	seek_mode=away
 else
 	seek_mode=back
-	dstcommit=$(cg-commit-id "$_git_head") || exit 1
+	dstcommit=$(cg-object-id "$_git_head") || exit 1
 fi
 
-dstcommit=$(cg-commit-id "$dstcommit") || exit 1
+dstcommit=$(cg-object-id "$dstcommit") || exit 1
 if [ "$curcommit" != "$dstcommit" ]; then
 	tree_timewarp --no-head-update "along" "please rollback" $curcommit $dstcommit
 fi
 
 if [ "$seek_mode" = "away" ]; then
diff --git a/cg-upload b/cg-upload
--- a/cg-upload
+++ b/cg-upload
@@ -43,18 +43,18 @@ elif echo "$uri" | grep -q ":"; then
 	die "uploading over rsync not supported"
 else
 	remgit="$uri"; [ -d "$remgit/.git" ] && remgit="$remgit/.git"
 	if is_same_repo "$_git_objects" "$remgit/objects"; then
 		remid="$(cat "$remgit"/refs/heads/$rembranch)" || die "$remgit: no branch $master"
-		if [ "$remid" != "$(git-merge-base "$remid" "$(cg-commit-id)")" ]; then
+		if [ "$remid" != "$(git-merge-base "$remid" "$(cg-object-id)")" ]; then
 			echo "ERROR: Remote '$rembranch' has some changes you don't have in your '$_git_head'" >&2
 			echo "Try to cg-update from it first, then upload." >&2
 			exit 1
 		fi
 
-		[ -x "$remgit/hooks/update" ] && "$remgit/hooks/update" "$rembranch" "$remid" "$(cg-commit-id)"
-		cg-commit-id >"$remgit"/refs/heads/$rembranch
+		[ -x "$remgit/hooks/update" ] && "$remgit/hooks/update" "$rembranch" "$remid" "$(cg-object-id)"
+		cg-object-id >"$remgit"/refs/heads/$rembranch
 		[ -x "$remgit/hooks/post-update" ] && "$remgit/hooks/post-update" "$rembranch"
 	else
 		git-send-pack "$uri" $_git_head$sprembranch
 	fi
 fi
diff --git a/contrib/gitfeedmaillist.sh b/contrib/gitfeedmaillist.sh
--- a/contrib/gitfeedmaillist.sh
+++ b/contrib/gitfeedmaillist.sh
@@ -111,26 +111,26 @@ EOF
 			i=$(($i+1))
 		done
 	done
 }
 
-base=$(cg-commit-id $1)
+base=$(cg-object-id $1)
 
 if [ -z $2 ]; then
     lastmail=`cat .git/tags/MailDone`
 else
-    lastmail=$(cg-commit-id $2)
+    lastmail=$(cg-object-id $2)
 fi
 
 #if [ -z $3 ]; then
 #    tagname=`ls -rt .git/tags | grep -v MailDone | tail -1`
 #    release=`cat .git/tags/$tagname`
 #else
 #    release=$(gitXnormid.sh -c $3)
 #fi    
 
-base=$(cg-commit-id $1) || exit 1
+base=$(cg-object-id $1) || exit 1
 
 
 if [ "$base" != "$lastmail" ]; then
     # List the commits at which we should stop following the tree, because
     # we've come back to commits which were already in $lastmail.


-- 
Regards,
Pavel Roskin
