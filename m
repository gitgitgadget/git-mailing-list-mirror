From: Petr Baudis <pasky@suse.cz>
Subject: [RFC][PATCH] Cogito support for simple subprojects
Date: Sun, 15 Jan 2006 16:07:21 +0100
Message-ID: <20060115150721.GE28365@pasky.or.cz>
References: <43C52B1F.8020706@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 16:06:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ey9T4-0001Ge-1k
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 16:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWAOPG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 10:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWAOPG2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 10:06:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:8070 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932072AbWAOPG1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 10:06:27 -0500
Received: (qmail 7192 invoked by uid 2001); 15 Jan 2006 16:07:21 +0100
To: Simon Richter <Simon.Richter@hogyros.de>
Content-Disposition: inline
In-Reply-To: <43C52B1F.8020706@hogyros.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14698>

  Hello,

  I've tried to take a different approach - KISS and don't make the
subprojects part of the git-tracked tree but a thing purely local to
your particular checkout. Subprojects are simply listed in
.git/subprojects and various commands are called recursively on them.

  - No auto-cloning of subprojects is possible.
  - Switching between branches and merging is troublesome in case the
    required subprojects arrangement changes inbetween. Now, this is
    a matter of taste - I don't see this as a huge problem since you
    can make special provisions for that and this should be going to be
    so rare that it's not worth optimizing for in my eyes.
  + It's simple.
  + It's flexible. You can have _optional_ subprojects - IIRC e.g.
    mplayer can use ffmpeg if it's checked out as a subproject but
    will use own copy if it's not there. You can clone subprojects
    based e.g. on selected features before compilation. If you do so,
    your GIT won't bother you with uncommitted local changes, and you
    will not have to filter this out from any other changes you are
    going to commit.

  The main goal of this is simply to be able to check out bunch of
stuff to subdirectories and make cg-update update all of it, without
any special scripts. ;-)

  This patch is just trivial proof-of-concept thing which makes only
cg-update and cg-fetch aware of the subprojects; many commands still
need to be taught about subprojects but some don't - I currently don't
think a recursive cg-merge is a particularily good idea, for one.
I think the good default is to make all read-only commands by default
recursive and all modifying commands by default non-recursive. (And
it might be useful to be able to mark some subprojects read-only.)

  How to create a subproject? Simply cg-clone inside a working copy,
it will register it automagically. So far there are no tools to further
maintain the subprojects, though, therefore a mv or rm needs to be
followed by an appropriate modification of parent .git/subprojects.


  This is not committed yet - I'm curious about your opinions.

diff --git a/TODO b/TODO
index 0658b39..29daf30 100644
--- a/TODO
+++ b/TODO
@@ -90,23 +90,13 @@ cg-*patch should be pre-1.0.)
 
 * cg-Xfetchprogress showing smooth progress for packfiles
 
+* Enhance subprojects notion
+	So far the subprojects support is trivial and prone to user error.
+	E.g. cg-add should check if it doesn't poke into a subproject,
+	cg-status should list subprojects, etc.
 
-Post 1.0:
-
-* Subprojects
-	Support a GIT project inside a GIT project:
 
-		x/.git
-		x/foo/bar/.git
-		x/foo/bar/baz/.git
-		x/quux/zot/.git
-
-	That means cg-update working recursively and cg-add'n'stuff
-	checking if there isn't another .git along the path of its
-	argument.
-
-	Needs more thought, especially wrt. fetching and merging
-	recursive semantics.
+Post 1.0:
 
 * Comfortable cg-log
 	Probably make it a real terminal application, not just less
diff --git a/cg-Xlib b/cg-Xlib
index 46a8a73..6e6265e 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -197,6 +197,10 @@ list_untracked_files()
 		if [ -f "$EXCLUDEFILE" ]; then
 			EXCLUDE[${#EXCLUDE[@]}]="--exclude-from=$EXCLUDEFILE"
 		fi
+		EXCLUDEFILE="$_git/subprojects"
+		if [ -f "$EXCLUDEFILE" ]; then
+			EXCLUDE[${#EXCLUDE[@]}]="--exclude-from=$EXCLUDEFILE"
+		fi
 		# This is just for compatibility (2005-09-16).
 		# To be removed later.
 		EXCLUDEFILE="$_git/exclude"
@@ -209,6 +213,29 @@ list_untracked_files()
 	git-ls-files -z --others "${EXCLUDE[@]}"
 }
 
+# Usage: subprojects_recurse ACTIONNAME COMMAND...
+# Run command recursively on subprojects, displaying warning using the
+# ACTIONNAME string in case any of them failed.
+subprojects_recurse()
+{
+	[ -s "$_git/subprojects" ] || return 0
+	local failures=0 subprj= actionname="$1" s=
+	local Actionname="$(echo "$actionname" | perl -pe '$_=ucfirst')"
+	shift
+	while IFS= read -r subprj; do
+		echo "Running $actionname in $subprj..." >&2
+		if ( cd "$subprj" && "$@" ); then
+			echo "$Actionname in $subprj succeeded." >&2
+		else
+			echo "$Actionname in $subprj failed!" >&2
+			failures=$(($failures+1))
+		fi
+	done <"$_git/subprojects"
+	local s=; if [ $failures -gt 1 ]; then s=s; fi
+	[ $failures -gt 0 ] && echo "Warning: $failures subproject $actionname$s failed" >&2
+	return $failures
+}
+
 # Usage: showdate SECONDS TIMEZONE [FORMAT]
 # Display date nicely based on how GIT stores it.
 # Save the date to $_showdate
diff --git a/cg-clone b/cg-clone
index f86a548..dfb6dc8 100755
--- a/cg-clone
+++ b/cg-clone
@@ -11,6 +11,15 @@
 # parameter is omitted, the basename of the source repository is used as the
 # destination.
 #
+# If you are cloning inside another working tree, you are automatically
+# establishing a subproject - that means that when you will update the
+# parent project, this project will be auto-updated as well, and in the
+# future, certain other operations may also recurse to subprojects. Use the
+# -P option to prevent this from becoming a subproject. Also please note
+# that the subprojects support is preliminary and subject to change. If you
+# remove the subproject later, you must also remove the corresponding entry
+# in '.git/subprojects' for now.
+#
 # OPTIONS
 # -------
 # -l::	Symlink the object database when cloning locally
@@ -24,20 +33,28 @@
 #	Note that you MUST NOT prune repository containing a symlink
 #	or being symlinked to.
 #
+# -P::	Prevent this from becoming a subproject
+#	If this option is passed, cg-clone will never create a subproject
+#	even if called inside working tree of another project.
+#
 # -s::	Clone into the current directory
 #	Clone in the current directory instead of creating a new one.
 #	Specifying both -s and a destination directory makes no sense.
+#	This also implies -P.
 
-USAGE="cg-clone [-l] [-s] LOCATION [DESTDIR]"
+USAGE="cg-clone [-l] [-P] [-s] LOCATION [DESTDIR]"
 _git_repo_unneeded=1
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
 same_dir=
 symlink=
+may_subproject=1
 while optparse; do
 	if optparse -l; then
 		symlink=1
+	elif optparse -P; then
+		may_subproject=
 	elif optparse -s; then
 		same_dir=1
 	else
@@ -65,7 +82,13 @@ else
 	location="$location"
 fi
 
+parentprj=
+parentpath=
 if [ ! "$same_dir" ]; then
+	if [ "$may_subproject" ]; then
+		parentprj="$(git-rev-parse --git-dir 2>/dev/null)"
+		parentpath="$(git-rev-parse --show-prefix 2>/dev/null)$dir"
+	fi
 	[ -e "$dir" ] && die "$dir/ already exists"
 	mkdir "$dir" || exit $?
 	cd "$dir" || exit $?
@@ -94,4 +117,14 @@ cp "$_git/refs/heads/origin" "$_git/refs
 	git-update-index --refresh ||
 	exit 1
 
+if [ "$parentprj" ]; then
+	cd ..
+	parentroot="${parentprj%.git}"
+	if [ -z "$parentroot" ]; then
+		parentroot="$(pwd)"
+	fi
+	echo "Registering as a subproject of $parentroot..."
+	echo "$parentpath" >>"$parentprj"/subprojects
+fi
+
 echo "Cloned to $dir/ (origin $location available as branch \"origin\")"
diff --git a/cg-fetch b/cg-fetch
index c3dfb81..9d44d9f 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -28,6 +28,10 @@
 # -f:: Force the complete fetch even if the heads are the same.
 #	Force the complete fetch even if the heads are the same.
 #
+# -R:: Do not recurse to subprojects
+#	Do not recursively fetch the subprojects (see the `cg-clone`
+#	documentation for more information).
+#
 # -v:: Enable verbosity
 #	Display more verbose output - most notably list all the files
 #	touched by the fetched changes.
@@ -53,7 +57,7 @@
 #	won't unpack the transferred pack.
 
 
-USAGE="cg-fetch [-f] [-v] [BRANCH_NAME]"
+USAGE="cg-fetch [-f] [-R] [-v] [BRANCH_NAME]"
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 deprecated_alias cg-fetch cg-pull
@@ -234,12 +238,15 @@ fetch_tags()
 
 
 recovery=
+recurse=1
 verbose=
 while optparse; do
 	if optparse -f; then
 		# When forcing, let the fetch tools make more extensive
 		# walk over the dependency tree with --recover.
 		recovery=--recover
+	elif optparse -R; then
+		recurse=
 	elif optparse -v; then
 		verbose=1
 	else
@@ -248,9 +255,10 @@ while optparse; do
 done
 
 name="${ARGS[0]}"
-
 [ "$name" ] || { [ -s "$_git/branches/origin" ] && name=origin; }
+[ "$recurse" ] && subprojects_recurse "fetch" cg-fetch $recovery $verbose "$name"
 [ "$name" ] || die "where to fetch from?"
+
 uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"
 
 rembranch=
diff --git a/cg-update b/cg-update
index 1d6e0a0..1b21338 100755
--- a/cg-update
+++ b/cg-update
@@ -25,23 +25,30 @@
 # -f:: Force the complete fetch even if the heads are the same.
 #	Force the complete fetch even if the heads are the same.
 #
+# -R:: Do not recurse to subprojects
+#	Do not recursively update the subprojects (see the `cg-clone`
+#	documentation for more information).
+#
 # --squash:: Use "squash" merge to record pending commits as a single merge commit
 #	"Squash" merge - condense all the to-be-merged commits to a single
 #	merge commit. This is not to be used lightly; see the cg-merge
 #	documenation for further details.
 
-USAGE="cg-update [-f] [--squash] [BRANCH_NAME]"
+USAGE="cg-update [-f] [-R] [--squash] [BRANCH_NAME]"
 _git_requires_root=1
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
 force=
 squash=
+recurse=1
 while optparse; do
 	if optparse -f; then
 		force=-f
 	elif optparse --squash; then
 		squash=--squash
+	elif optparse -R; then
+		recurse=
 	else
 		optfail
 	fi
@@ -49,13 +56,14 @@ done
 
 name="${ARGS[0]}"
 [ "$name" ] || { [ -s "$_git/branches/origin" ] && name=origin; }
+[ "$recurse" ] && subprojects_recurse "update" cg-update $force $squash "$name"
 [ "$name" ] || die "where to update from?"
 
 # cg-merge can do better decision about fast-forwarding if it sees this.
 [ -s "$_git/refs/heads/$name" ] && export _cg_orig_head="$(cat "$_git/refs/heads/$name")"
 
 if [ -s "$_git/branches/$name" ]; then
-	cg-fetch $force "$name" || exit 1
+	cg-fetch -R $force "$name" || exit 1
 else
 	echo "Updating from a local branch."
 fi
diff --git a/t/t9215-update-recursive.sh b/t/t9215-update-recursive.sh
new file mode 100755
index 0000000..d0e27a4
--- /dev/null
+++ b/t/t9215-update-recursive.sh
@@ -0,0 +1,54 @@
+#!/usr/bin/env bash
+#
+# Copyright (c) 2005 Petr Baudis
+#
+test_description="Tests recursive cg-update functionality
+
+Create a subproject and then try to cg-update."
+
+. ./test-lib.sh
+
+mkdir prj1
+echo file >prj1/file
+test_expect_success 'initialize project 1' \
+	"(cd prj1 && cg-init -I && cg-add file && cg-commit -C -m\"Initial commit\")"
+
+mkdir prj2
+echo file >prj2/FILE
+test_expect_success 'initialize project 2' \
+	"(cd prj2 && cg-init -I && cg-add FILE && cg-commit -C -m\"Initial commit\")"
+
+test_expect_success 'clone project 1' \
+	"cg-clone prj1 clone"
+test_expect_success 'clone project 2 as subproject of project 1' \
+	"(cd clone && cg-clone ../prj2)"
+
+test_expect_success 'commit to project 1' \
+	"(cd prj1 && echo foo >>file && cg-commit -m\"Commit in project 1\")"
+test_expect_success 'commit to project 2' \
+	"(cd prj2 && echo bar >>FILE && cg-commit -m\"Commit in project 2\")"
+
+test_expect_success 'non-recursive update' \
+	"(cd clone && cg-update -R)"
+test_expect_success 'check if the prj1 head was updated in clone' \
+	"(cmp prj1/.git/refs/heads/master clone/.git/refs/heads/master)"
+test_expect_success 'check if the prj1 working copy was updated in clone' \
+	"(cmp prj1/file clone/file)"
+test_expect_failure 'check if the prj2 head was not updated in clone' \
+	"(cmp prj2/.git/refs/heads/master clone/prj2/.git/refs/heads/origin)"
+
+test_expect_success 'commit to project 1' \
+	"(cd prj1 && echo baz >>file && cg-commit -m\"Commit in project 1\")"
+
+test_expect_success 'recursive update' \
+	"(cd clone && cg-update)"
+test_expect_success 'check if the prj1 head was updated in clone' \
+	"(cmp prj1/.git/refs/heads/master clone/.git/refs/heads/master)"
+test_expect_success 'check if the prj1 working copy was updated in clone' \
+	"(cmp prj1/file clone/file)"
+test_expect_success 'check if the prj2 head was updated in clone' \
+	"(cmp prj2/.git/refs/heads/master clone/prj2/.git/refs/heads/master)"
+test_expect_success 'check if the prj2 working copy was updated in clone' \
+	"(cmp prj2/FILE clone/prj2/FILE)"
+
+test_done


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
