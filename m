From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Tue, 06 Mar 2007 00:07:28 -0500
Message-ID: <E1HORtY-0000zK-8B@candygram.thunk.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 06:07:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HORtg-0006K9-S2
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 06:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbXCFFHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 00:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbXCFFHe
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 00:07:34 -0500
Received: from thunk.org ([69.25.196.29]:39837 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbXCFFHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 00:07:33 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HORzA-0008H4-28; Tue, 06 Mar 2007 00:13:16 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HORtY-0000zK-8B; Tue, 06 Mar 2007 00:07:28 -0500
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41537>

The git-mergetool program can be used to automatically run an appropriate
merge resolution program to resolve merge conflicts.  It will automatically
run one of kdiff3, tkdiff, meld, xxdiff, or emacs emerge programs.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 .gitignore                      |    1 +
 Documentation/config.txt        |    5 +
 Documentation/git-mergetool.txt |   46 +++++++++
 Makefile                        |    2 +-
 git-mergetool.sh                |  208 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 261 insertions(+), 1 deletions(-)
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
index 5408dd6..0a72e41 100644
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
index 0000000..8cc00fb
--- /dev/null
+++ b/Documentation/git-mergetool.txt
@@ -0,0 +1,46 @@
+git-mergetool(1)
+================
+
+NAME
+----
+git-mergetool - Forward-port local commits to the updated upstream head
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
index a221bdc..502f660 100644
--- a/Makefile
+++ b/Makefile
@@ -177,7 +177,7 @@ SCRIPT_SH = \
 	git-clean.sh git-clone.sh git-commit.sh \
 	git-fetch.sh git-gc.sh \
 	git-ls-remote.sh \
-	git-merge-one-file.sh git-parse-remote.sh \
+	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-revert.sh git-sh-setup.sh \
diff --git a/git-mergetool.sh b/git-mergetool.sh
new file mode 100755
index 0000000..b961719
--- /dev/null
+++ b/git-mergetool.sh
@@ -0,0 +1,208 @@
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
+usage () {
+    echo "Usage: git mergetool [--tool=tool] [file to merge] ..."
+    exit 1
+}
+
+merge_file () {
+	path="$1"
+
+	if test ! -f "$path" ; then
+		echo "$path: file not found"
+		exit 1
+	fi
+
+	f=`git-ls-files -u "$path"`
+	if test -z "$f" ; then
+		echo "$path: file does not need merging"
+		exit 1
+	fi
+
+	BACKUP="$path.BACKUP.$$"
+	LOCAL="$path.LOCAL.$$"
+	REMOTE="$path.REMOTE.$$"
+	BASE="$path.BASE.$$"
+
+	mv "$path" "$BACKUP"
+	cp "$BACKUP" "$path"
+
+	git cat-file blob ":1:$path" > "$BASE"
+	git cat-file blob ":2:$path" > "$LOCAL"
+	git cat-file blob ":3:$path" > "$REMOTE"
+
+	case "$merge_tool" in
+	    kdiff3)
+		(kdiff3 --auto --L1 "$path (Base)" -L2 "$path (Local)" --L3 "$path (Remote)" \
+		    "$BASE" "$LOCAL" "$REMOTE" -o "$path" > /dev/null 2>&1)
+		status=$?
+		if test "$status" -eq 0; then
+		    rm "$BACKUP"
+		fi
+		;;
+	    tkdiff)
+		tkdiff "$LOCAL" "$REMOTE" -a "$BASE" -o "$path"
+		status=$?
+		if test "$status" -eq 0; then
+		    mv "$BACKUP" "$path.orig"
+		fi
+		;;
+	    meld)
+	        touch "$BACKUP"
+		meld "$LOCAL" "$path" "$REMOTE"
+		if test "$path" -nt "$BACKUP" ; then 
+			status=0;
+		else
+			while true; do
+			        echo "$path seems unchanged."
+			        echo -n "Was the merge successful? [y/n] "
+			        read answer < /dev/tty
+			        case "$answer" in
+			        	y*|Y*) status=0; break ;;
+					n*|N*) status=1; break ;;
+				esac
+			done
+		fi
+		if test "$status" -eq 0; then
+		    mv "$BACKUP" "$path.orig"
+		fi
+		;;
+	    xxdiff)
+	    	touch "$BACKUP"
+		xxdiff -X --show-merged-pane \
+		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
+		    -R 'Accel.Search: "Ctrl+F"' \
+		    -R 'Accel.SearchForward: "Ctrl-G"' \
+		    --merged-file "$path" "$LOCAL" "$BASE" "$REMOTE"
+		if test "$path" -nt "$BACKUP" ; then 
+			status=0;
+		else
+			while true; do
+			        echo "$path seems unchanged."
+			        echo -n "Was the merge successful? [y/n] "
+			        read answer < /dev/tty
+			        case "$answer" in
+			        	y*|Y*) status=0; break ;;
+					n*|N*) status=1; break ;;
+				esac
+			done
+		fi
+		if test "$status" -eq 0; then
+		    mv "$BACKUP" "$path.orig"
+		fi
+	        ;;
+	    emerge)
+		emacs -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$path"
+		status=$?
+		if test "$status" -eq 0; then
+		    mv "$BACKUP" "$path.orig"
+		fi
+		;;
+	esac
+	rm -f "$LOCAL" "$REMOTE" "$BASE"
+	if test "$status" -ne 0; then
+		echo "merge of $path failed" 1>&2
+		mv "$BACKUP" "$path"
+		exit 1
+	fi
+	git add "$path"
+}
+
+while case $# in 0) break ;; esac
+do
+	case "$1" in
+	-t|--tool*)
+		case "$#,$1" in
+		*,*=*)
+			merge_tool=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+			;;
+		1,*)
+			usage ;;
+		*)
+			merge_tool="$2"
+			shift ;;
+		esac
+		;;
+	--)
+		break
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+	shift
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
+	files=`git ls-files -u --abbrev=8 | colrm 1 24 | sort -u`
+	if test -z "$files" ; then
+		echo "No files need merging"
+		exit 0
+	fi
+	echo Merging the files: $files
+	git ls-files -u --abbrev=8 | colrm 1 24 | sort -u | while read i
+	do
+		merge_file "$i" < /dev/tty > /dev/tty
+	done
+else
+	while test $# -gt 0; do
+		merge_file "$1"
+		shift
+	done
+fi
+exit 0 
-- 
1.5.0.2.312.g5ced-dirty
