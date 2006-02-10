From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH 1/3] Call extended-semantics commands through variables.
Date: Fri, 10 Feb 2006 15:35:06 -0800
Message-ID: <1091.1139614506@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sat Feb 11 00:35:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7hnF-0007FZ-Is
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 00:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWBJXfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 18:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWBJXfK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 18:35:10 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:49570 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932246AbWBJXfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 18:35:08 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1ANZ7xZ001099
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 15:35:07 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1ANZ7AH001098
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 15:35:07 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15903>

In some places, git shell scripts rely on semantics for
xargs, find, and cpio that do not exist in all versions
of those commands.  Both xargs and find rely on -0 for
handling multi-word names, and for some reason the cpio
calls do not work with pkgsrc's default cpio.

Replacing all such calls with calls through variables
allows more portability.  Also, the variables can point
to debugging scripts that log arguments, outputs, etc.

The variables are just XARGS, FIND, and CPIO.  No GIT_
was appended so a user can set those once for all scripts
that may use them (e.g. configure).  A follow-on patch
will modify the Makefile to allow installation-specific
defaults.

Tested on Solaris 8 with those arguments pointing at
GNU tools as well as some Linux versions.  (The AIX
machine I use is down for maintenance right now.)

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 git-add.sh           |    3 ++-
 git-clone.sh         |   10 ++++++----
 git-count-objects.sh |    8 +++++---
 git-grep.sh          |    3 ++-
 git-ls-remote.sh     |    4 +++-
 git-merge.sh         |    5 +++--
 git-prune.sh         |    5 +++--
 git-push.sh          |    5 +++--
 git-repack.sh        |    3 ++-
 9 files changed, 29 insertions(+), 17 deletions(-)

846024657d04675a762fd9edaba3c0612f616a41
diff --git a/git-add.sh b/git-add.sh
index f719b4b..bd79b4f 100755
--- a/git-add.sh
+++ b/git-add.sh
@@ -3,6 +3,7 @@
 USAGE='[-n] [-v] <file>...'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
+: ${XARGS:=xargs}
 
 show_only=
 verbose=
@@ -35,7 +36,7 @@ else
 fi |
 case "$show_only" in
 true)
-	xargs -0 echo ;;
+	${XARGS} -0 echo ;;
 *)
 	git-update-index --add $verbose -z --stdin ;;
 esac
diff --git a/git-clone.sh b/git-clone.sh
index 47f3ec9..2c9b45e 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -7,6 +7,8 @@
 
 # See git-sh-setup why.
 unset CDPATH
+: ${FIND:=find}
+: ${CPIO:=cpio}
 
 usage() {
 	echo >&2 "Usage: $0 [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
@@ -141,19 +143,19 @@ yes,yes)
 	no)
 	    # See if we can hardlink and drop "l" if not.
 	    sample_file=$(cd "$repo" && \
-			  find objects -type f -print | sed -e 1q)
+			  ${FIND} objects -type f -print | sed -e 1q)
 
 	    # objects directory should not be empty since we are cloning!
 	    test -f "$repo/$sample_file" || exit
 
 	    l=
-	    if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
+	    if ln "$repo/$sample_file" "$DIR/objects/sample" 2>/dev/null
 	    then
 		    l=l
 	    fi &&
 	    rm -f "$GIT_DIR/objects/sample" &&
 	    cd "$repo" &&
-	    find objects -depth -print | cpio -puamd$l "$GIT_DIR/" || exit 1
+	    ${FIND} objects -depth -print | ${CPIO} -puamd$l "$GIT_DIR/" || exit 1
 	    ;;
 	yes)
 	    mkdir -p "$GIT_DIR/objects/info"
@@ -234,7 +236,7 @@ then
 		"URL: $repo
 Pull: $head_points_at:$origin" &&
 		git-update-ref "refs/heads/$origin" $(git-rev-parse HEAD) &&
-		(cd "$GIT_DIR" && find "refs/heads" -type f -print) |
+		(cd "$GIT_DIR" && ${FIND} "refs/heads" -type f -print) |
 		while read ref
 		do
 			head=`expr "$ref" : 'refs/heads/\(.*\)'` &&
diff --git a/git-count-objects.sh b/git-count-objects.sh
index 40c58ef..5a4550c 100755
--- a/git-count-objects.sh
+++ b/git-count-objects.sh
@@ -4,6 +4,8 @@
 #
 
 GIT_DIR=`git-rev-parse --git-dir` || exit $?
+: ${FIND:=find}
+: ${XARGS:=xargs}
 
 dc </dev/null 2>/dev/null || {
 	# This is not a real DC at all -- it just knows how
@@ -20,12 +22,12 @@ dc </dev/null 2>/dev/null || {
 	}
 }
 
-echo $(find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null | wc -l) objects, \
+echo $(${GIT_FIND} "$GIT_DIR/objects"/?? -type f -print 2>/dev/null | wc -l) objects, \
 $({
     echo 0
     # "no-such" is to help Darwin folks by not using xargs -r.
-    find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null |
-    xargs du -k "$GIT_DIR/objects/no-such" 2>/dev/null |
+    ${FIND} "$GIT_DIR/objects"/?? -type f -print 2>/dev/null |
+    ${XARGS} du -k "$GIT_DIR/objects/no-such" 2>/dev/null |
     sed -e 's/[ 	].*/ +/'
     echo p
 } | dc) kilobytes
diff --git a/git-grep.sh b/git-grep.sh
index ad4f2fe..a58ab37 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -6,6 +6,7 @@
 USAGE='[<option>...] [-e] <pattern> [<path>...]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
+: ${XARGS:=xargs}
 
 got_pattern () {
 	if [ -z "$no_more_patterns" ]
@@ -59,4 +60,4 @@ done
 	usage
 }
 git-ls-files -z "${git_flags[@]}" -- "$@" |
-	xargs -0 grep "${flags[@]}" -e "$pattern" --
+	${XARGS} -0 grep "${flags[@]}" -e "$pattern" --
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 2c9a588..340bde0 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 #
 
+: ${FIND:=find}
+
 usage () {
     echo >&2 "usage: $0 [--heads] [--tags] [-u|--upload-pack <upload-pack>]"
     echo >&2 "          <repository> <refs>..."
@@ -63,7 +65,7 @@ rsync://* )
 		echo "failed	slurping"
 		exit
 	}
-	(cd $tmpdir && find refs -type f) |
+	(cd $tmpdir && ${FIND} refs -type f) |
 	while read path
 	do
 		cat "$tmpdir/$path" | tr -d '\012'
diff --git a/git-merge.sh b/git-merge.sh
index dc17baf..c9b03c8 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -6,6 +6,7 @@
 
 USAGE='[-n] [--no-commit] [-s <strategy>]... <merge-message> <head> <remote>+'
 . git-sh-setup
+: ${CPIO:=cpio}
 
 LF='
 '
@@ -22,14 +23,14 @@ dropsave() {
 savestate() {
 	# Stash away any local modifications.
 	git-diff-index -z --name-only $head |
-	cpio -0 -o >"$GIT_DIR/MERGE_SAVE"
+	${CPIO} -0 -o >"$GIT_DIR/MERGE_SAVE"
 }
 
 restorestate() {
         if test -f "$GIT_DIR/MERGE_SAVE"
 	then
 		git reset --hard $head
-		cpio -iuv <"$GIT_DIR/MERGE_SAVE"
+		${CPIO} -iuv <"$GIT_DIR/MERGE_SAVE"
 		git-update-index --refresh >/dev/null
 	fi
 }
diff --git a/git-prune.sh b/git-prune.sh
index c5a5d29..781393f 100755
--- a/git-prune.sh
+++ b/git-prune.sh
@@ -2,6 +2,7 @@
 
 USAGE='[-n] [--] [<head>...]'
 . git-sh-setup
+: ${XARGS:=xargs}
 
 dryrun=
 echo=
@@ -27,7 +28,7 @@ sed -ne '/unreachable /{
     s|\(..\)|\1/|p
 }' | {
 	cd "$GIT_OBJECT_DIRECTORY" || exit
-	xargs $echo rm -f
+	${XARGS} $echo rm -f
 	rmdir 2>/dev/null [0-9a-f][0-9a-f]
 }
 
@@ -37,7 +38,7 @@ if redundant=$(git-pack-redundant --all 
 then
 	if test "" = "$dryrun"
 	then
-		echo "$redundant" | xargs rm -f
+		echo "$redundant" | ${XARGS} rm -f
 	else
 		echo rm -f "$redundant"
 	fi
diff --git a/git-push.sh b/git-push.sh
index 706db99..1a6c96d 100755
--- a/git-push.sh
+++ b/git-push.sh
@@ -2,6 +2,7 @@
 
 USAGE='[--all] [--tags] [--force] <repository> [<refspec>...]'
 . git-sh-setup
+: ${FIND:=find}
 
 # Parse out parameters and then stop at remote, so that we can
 # translate it using .git/branches information
@@ -46,9 +47,9 @@ case "$has_all" in
 '')
 	case "$do_tags,$#" in
 	yes,1)
-		set x $(cd "$GIT_DIR/refs" && find tags -type f -print) ;;
+		set x $(cd "$GIT_DIR/refs" && ${FIND} tags -type f -print) ;;
 	yes,*)
-		set x $(cd "$GIT_DIR/refs" && find tags -type f -print) \
+		set x $(cd "$GIT_DIR/refs" && ${FIND} tags -type f -print) \
 		    $(get_remote_refs_for_push "$@") ;;
 	,*)
 		set x $(get_remote_refs_for_push "$@") ;;
diff --git a/git-repack.sh b/git-repack.sh
index 1fafb6e..56a33a7 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -5,6 +5,7 @@
 
 USAGE='[-a] [-d] [-l] [-n]'
 . git-sh-setup
+: ${FIND:=find}
 	
 no_update_info= all_into_one= remove_redundant= local=
 while case "$#" in 0) break ;; esac
@@ -36,7 +37,7 @@ case ",$all_into_one," in
 
 	# Redundancy check in all-into-one case is trivial.
 	existing=`cd "$PACKDIR" && \
-	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
+	    ${FIND} . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
 if [ "$local" ]; then
-- 
1.1.6.g0d39d
