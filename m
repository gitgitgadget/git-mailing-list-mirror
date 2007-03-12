From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH,RFC] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Mon, 12 Mar 2007 02:00:53 -0400
Message-ID: <E1HQdaX-00025N-3s@candygram.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 07:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQdbJ-0007L5-73
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 07:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbXCLGBD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 02:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbXCLGBD
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 02:01:03 -0400
Received: from THUNK.ORG ([69.25.196.29]:49458 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965149AbXCLGBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 02:01:01 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HQdgK-0003LJ-Va; Mon, 12 Mar 2007 02:06:53 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HQdaX-00025N-3s; Mon, 12 Mar 2007 02:00:53 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42009>


OK, here's my second attempt at a git-mergetool subcommand.

Major differences from last time, besides addressing the comments made
by Junio, is that the git-mergetool now handles various scnearios where
the conflicts are caused by files changing to/from symlinks, and where
the symlink was changed to two different destinations in the local and
remote branches.

I'm not sure the UI and feature set is completely right[1], but I think
we're getting to the point where I need people to try it out and give me
comments about what works and doesn't work for them.

[1] Should I allow the user the opportunity to see the diff between the
base and local/remote revision?  If so, how do I expose that function to
the customer?

---
The git-mergetool program can be used to automatically run an appropriate
merge resolution program to resolve merge conflicts.  It will automatically
run one of kdiff3, tkdiff, meld, xxdiff, or emacs emerge programs.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 .gitignore                      |    1 +
 Documentation/config.txt        |    5 +
 Documentation/git-mergetool.txt |   46 ++++++
 Makefile                        |    2 +-
 git-mergetool.sh                |  317 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 370 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-mergetool.txt
 create mode 100755 git-mergetool.sh

diff --git a/.gitignore b/.gitignore
index 0eaba0a..27797d1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@ git-merge-ours
 git-merge-recursive
 git-merge-resolve
 git-merge-stupid
+git-mergetool
 git-mktag
 git-mktree
 git-name-rev
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5408dd6..aaae9ac 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -453,6 +453,11 @@ merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
 
+merge.tool::
+	Controls which merge resolution program is used by
+	gitlink:git-mergetool[l].  Valid values are: "kdiff3", "tkdiff",
+	"meld", "xxdiff", "emerge"
+
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
 	strategy.  Level 0 outputs nothing except a final error
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
new file mode 100644
index 0000000..ae69a0e
--- /dev/null
+++ b/Documentation/git-mergetool.txt
@@ -0,0 +1,46 @@
+git-mergetool(1)
+================
+
+NAME
+----
+git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
+
+SYNOPSIS
+--------
+'git-mergetool' [--tool=<tool>] [<file>]...
+
+DESCRIPTION
+-----------
+
+Use 'git mergetool' to run one of several merge utilities to resolve
+merge conflicts.  It is typically run after gitlink:git-merge[1].
+
+If one or more <file> parameters are given, the merge tool program will
+be run to resolve differences on each file.  If no <file> names are
+specified, 'git mergetool' will run the merge tool program on every file
+with merge conflicts.
+
+OPTIONS
+-------
+-t or --tool=<tool>::
+	Use the merge resolution program specified by <tool>.
+	Valid merge tools are:
+	kdiff3, tkdiff, meld, xxdiff, and emerge.
+
+	If a merge resolution program is not specified, 'git mergetool'
+	will use the configuration variable merge.tool.  If the
+	configuration variable merge.tool is not set, 'git mergetool'
+	will pick a suitable default.
+
+Author
+------
+Written by Theodore Y Ts'o <tytso@mit.edu>
+
+Documentation
+--------------
+Documentation by Theodore Y Ts'o.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index 084b7fe..8fb5230 100644
--- a/Makefile
+++ b/Makefile
@@ -179,7 +179,7 @@ SCRIPT_SH = \
 	git-clean.sh git-clone.sh git-commit.sh \
 	git-fetch.sh git-gc.sh \
 	git-ls-remote.sh \
-	git-merge-one-file.sh git-parse-remote.sh \
+	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-sh-setup.sh \
diff --git a/git-mergetool.sh b/git-mergetool.sh
new file mode 100755
index 0000000..e75f934
--- /dev/null
+++ b/git-mergetool.sh
@@ -0,0 +1,317 @@
+#!/bin/sh
+#
+# This program resolves merge conflicts in git
+#
+# Copyright (c) 2006 Theodore Y. Ts'o
+#
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Linus Torvalds.
+#
+
+USAGE='[--tool=tool] [file to merge] ...'
+SUBDIRECTORY_OK=Yes
+. git-sh-setup
+require_work_tree
+
+# Returns true if the mode reflects a symlink
+function is_symlink () {
+    test "$1" = 120000
+}
+
+function describe_file () {
+    mode="$1"
+    branch="$2"
+    file="$3"
+
+    echo -n "    "
+    if test -z "$mode"; then
+	echo -n "'$path' was deleted"
+    elif is_symlink "$mode" ; then
+	echo -n "'$path' is a symlink containing '"
+	cat "$file"
+	echo -n "'"
+    else
+	if test -z "$base_mode"; then
+	    echo -n "'$path' was created"
+	else
+	    echo -n "'$path' was modified"
+	fi
+    fi
+    echo " in the $branch branch"
+}
+
+
+resolve_symlink_merge () {
+    while /bin/true; do
+	echo -n "Use (r)emote or (l)ocal, or (a)bort? "
+	read ans
+	case "$ans" in
+	    [lL]*)
+		git-checkout-index -f --stage=2 -- "$path"
+		git-add -- "$path"
+		rm -f -- "$LOCAL" "$REMOTE" "$BASE"
+		mv -- "$BACKUP" "$path.orig"
+		return
+		;;
+	   [rR]*)
+		git-checkout-index -f --stage=3 -- "$path"
+		git-add -- "$path"
+		rm -f -- "$LOCAL" "$REMOTE" "$BASE"
+		mv -- "$BACKUP" "$path.orig"
+		return
+		;;
+	    [qQ]*)
+		exit 1
+		;;
+	    esac
+	done
+}
+
+resolve_deleted_merge () {
+    while /bin/true; do
+	echo -n "Use (m)odified or (d)eleted file, or (a)bort? "
+	read ans
+	case "$ans" in
+	    [mM]*)
+		git-add -- "$path"
+		rm -f -- "$LOCAL" "$REMOTE" "$BASE"
+		mv -- "$BACKUP" "$path.orig"
+		return
+		;;
+	   [dD]*)
+		git-rm -- "$path"
+		rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
+		return
+		;;
+	    [qQ]*)
+		exit 1
+		;;
+	    esac
+	done
+}
+
+merge_file () {
+    path="$1"
+
+    if test ! -f "$path" ; then
+	echo "$path: file not found"
+	exit 1
+    fi
+
+    f=`git-ls-files -u -- "$path"`
+    if test -z "$f" ; then
+	echo "$path: file does not need merging"
+	exit 1
+    fi
+
+    BACKUP="$path.BACKUP.$$"
+    LOCAL="$path.LOCAL.$$"
+    REMOTE="$path.REMOTE.$$"
+    BASE="$path.BASE.$$"
+
+    mv -- "$path" "$BACKUP"
+    cp -- "$BACKUP" "$path"
+
+    base_mode=`git ls-files -u -- "$path" | awk '{if ($3==1) print $1;}'`
+    local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
+    remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
+
+#    echo "base_mode is '$base_mode'"
+#    echo "local_mode is '$local_mode'"
+#    echo "remote_mode is '$remote_mode'"
+
+    git cat-file blob ":1:$path" > "$BASE" 2>/dev/null
+    git cat-file blob ":2:$path" > "$LOCAL" 2>/dev/null
+    git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null
+
+    if test -z "$local_mode" -o -z "$remote_mode"; then
+	echo "Deleted merge conflict for $path:"
+	describe_file "$local_mode" "local" "$LOCAL"
+	describe_file "$remote_mode" "remote" "$REMOTE"
+	resolve_deleted_merge
+	return
+    fi
+
+    if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
+	echo "Symlink merge conflict for $path:"
+	describe_file "$local_mode" "local" "$LOCAL"
+	describe_file "$remote_mode" "remote" "$REMOTE"
+	resolve_symlink_merge
+	return
+    fi
+
+    echo "Normal merge conflict for $path:"
+    describe_file "$local_mode" "local" "$LOCAL"
+    describe_file "$remote_mode" "remote" "$REMOTE"
+    echo -n "Hit return to start merge resolution tool ($merge_tool): "
+    read ans
+
+    case "$merge_tool" in
+	kdiff3)
+	    (kdiff3 --auto --L1 "$path (Base)" -L2 "$path (Local)" --L3 "$path (Remote)" \
+		"$BASE" "$LOCAL" "$REMOTE" -o "$path" > /dev/null 2>&1)
+	    status=$?
+	    if test "$status" -eq 0; then
+		rm "$BACKUP"
+	    fi
+	    ;;
+	tkdiff)
+	    tkdiff "$LOCAL" "$REMOTE" -a "$BASE" -o "$path"
+	    status=$?
+	    if test "$status" -eq 0; then
+		mv "$BACKUP" "$path.orig"
+	    fi
+	    ;;
+	meld)
+	    touch "$BACKUP"
+	    meld "$LOCAL" "$path" "$REMOTE"
+	    if test "$path" -nt "$BACKUP" ; then
+		status=0;
+	    else
+		while true; do
+		    echo "$path seems unchanged."
+		    echo -n "Was the merge successful? [y/n] "
+		    read answer < /dev/tty
+		    case "$answer" in
+			y*|Y*) status=0; break ;;
+			n*|N*) status=1; break ;;
+		    esac
+		done
+	    fi
+	    if test "$status" -eq 0; then
+		mv "$BACKUP" "$path.orig"
+	    fi
+	    ;;
+	xxdiff)
+	    touch "$BACKUP"
+	    xxdiff -X --show-merged-pane \
+		-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+		-R 'Accel.Search: "Ctrl+F"' \
+		-R 'Accel.SearchForward: "Ctrl-G"' \
+		--merged-file "$path" "$LOCAL" "$BASE" "$REMOTE"
+	    if test "$path" -nt "$BACKUP" ; then
+		status=0;
+	    else
+		while true; do
+		    echo "$path seems unchanged."
+		    echo -n "Was the merge successful? [y/n] "
+		    read answer < /dev/tty
+		    case "$answer" in
+			y*|Y*) status=0; break ;;
+			n*|N*) status=1; break ;;
+		    esac
+		done
+	    fi
+	    if test "$status" -eq 0; then
+		mv "$BACKUP" "$path.orig"
+	    fi
+	    ;;
+	emerge)
+	    emacs -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$path"
+	    status=$?
+	    if test "$status" -eq 0; then
+		mv -- "$BACKUP" "$path.orig"
+	    fi
+	    ;;
+    esac
+    rm -f "$LOCAL" "$REMOTE" "$BASE"
+    if test "$status" -ne 0; then
+	echo "merge of $path failed" 1>&2
+	mv -- "$BACKUP" "$path"
+	exit 1
+    fi
+    git add -- "$path"
+}
+
+while case $# in 0) break ;; esac
+do
+    case "$1" in
+	-t|--tool*)
+	    case "$#,$1" in
+		*,*=*)
+		    merge_tool=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    ;;
+		1,*)
+		    usage ;;
+		*)
+		    merge_tool="$2"
+		    shift ;;
+	    esac
+	    ;;
+	--)
+	    break
+	    ;;
+	-*)
+	    usage
+	    ;;
+	*)
+	    break
+	    ;;
+    esac
+    shift
+done
+
+if test -z "$merge_tool"; then
+    merge_tool=`git-config merge.tool`
+    if test $merge_tool = kdiff3 -o $merge_tool = tkdiff -o \
+	$merge_tool = xxdiff -o $merge_tool = meld ; then
+	unset merge_tool
+    fi
+fi
+
+if test -z "$merge_tool" ; then
+    if type kdiff3 >/dev/null 2>&1 && test -n "$DISPLAY"; then
+	merge_tool="kdiff3";
+    elif type tkdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
+    	merge_tool=tkdiff
+    elif type xxdiff >/dev/null 2>&1 && test -n "$DISPLAY"; then
+    	merge_tool=xxdiff
+    elif type meld >/dev/null 2>&1 && test -n "$DISPLAY"; then
+        merge_tool=meld
+    elif type emacs >/dev/null 2>&1; then
+        merge_tool=emerge
+    else
+	echo "No available merge tools available."
+	exit 1
+    fi
+fi
+
+case "$merge_tool" in
+    kdiff3|tkdiff|meld|xxdiff)
+    	if ! type "$merge_tool" > /dev/null 2>&1; then
+	    echo "The merge tool $merge_tool is not available"
+	    exit 1
+	fi
+	;;
+    emerge)
+    	if ! type "emacs" > /dev/null 2>&1; then
+	    echo "Emacs is not available"
+	    exit 1
+	fi
+	;;
+    *)
+    	echo "Unknown merge tool: $merge_tool"
+	exit 1
+	;;
+esac
+
+if test $# -eq 0 ; then
+	files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
+	if test -z "$files" ; then
+		echo "No files need merging"
+		exit 0
+	fi
+	echo Merging the files: $files
+	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u | while read i
+	do
+		echo ""
+		merge_file "$i" < /dev/tty > /dev/tty
+	done
+else
+	while test $# -gt 0; do
+		echo ""
+		merge_file "$1"
+		shift
+	done
+fi
+exit 0
-- 
1.5.0.3.272.gb515-dirty
