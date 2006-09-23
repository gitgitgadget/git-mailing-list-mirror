From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Kill git-resolve.sh
Date: Sat, 23 Sep 2006 21:55:30 +0200
Message-ID: <20060923195530.5570.23774.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 21:55:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRDb7-0004lH-Cx
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWIWTzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWIWTzc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:55:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58336 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751510AbWIWTzc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 15:55:32 -0400
Received: (qmail 5580 invoked from network); 23 Sep 2006 21:55:30 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 23 Sep 2006 21:55:30 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27622>

Seriously, is anyone still using this thing? It's collecting dust and
blocking the name for something potentially useful like a tool for
user-friendly marking of resolved conflicts or resolving index conflicts.

We've loved you when Git was young, now thank you and please go away. ;-)

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 .gitignore                    |    1 
 Documentation/git-resolve.txt |   36 --------------
 Documentation/git.txt         |    3 -
 Makefile                      |    2 -
 git-resolve.sh                |  108 -----------------------------------------
 5 files changed, 1 insertions(+), 149 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0ffe14a..f89bbc6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -92,7 +92,6 @@ git-repo-config
 git-request-pull
 git-rerere
 git-reset
-git-resolve
 git-rev-list
 git-rev-parse
 git-revert
diff --git a/Documentation/git-resolve.txt b/Documentation/git-resolve.txt
deleted file mode 100644
index 4e57c2b..0000000
--- a/Documentation/git-resolve.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-git-resolve(1)
-==============
-
-NAME
-----
-git-resolve - Merge two commits
-
-
-SYNOPSIS
---------
-'git-resolve' <current> <merged> <message>
-
-DESCRIPTION
------------
-Given two commits and a merge message, merge the <merged> commit
-into <current> commit, with the commit log message <message>.
-
-When <current> is a descendant of <merged>, or <current> is an
-ancestor of <merged>, no new commit is created and the <message>
-is ignored.  The former is informally called "already up to
-date", and the latter is often called "fast forward".
-
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org> and
-Dan Holmsand <holmsand@gmail.com>.
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
-
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 744c38d..a2efd17 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -336,9 +336,6 @@ gitlink:git-rerere[1]::
 gitlink:git-reset[1]::
 	Reset current HEAD to the specified state.
 
-gitlink:git-resolve[1]::
-	Merge two commits.
-
 gitlink:git-revert[1]::
 	Revert an existing commit.
 
diff --git a/Makefile b/Makefile
index 58848e4..6a7c408 100644
--- a/Makefile
+++ b/Makefile
@@ -169,7 +169,7 @@ SCRIPT_SH = \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
-	git-resolve.sh git-revert.sh git-sh-setup.sh \
+	git-revert.sh git-sh-setup.sh \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
diff --git a/git-resolve.sh b/git-resolve.sh
deleted file mode 100755
index a7bc680..0000000
--- a/git-resolve.sh
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Linus Torvalds
-#
-# Resolve two trees.
-#
-
-USAGE='<head> <remote> <merge-message>'
-. git-sh-setup
-
-dropheads() {
-	rm -f -- "$GIT_DIR/MERGE_HEAD" \
-		"$GIT_DIR/LAST_MERGE" || exit 1
-}
-
-head=$(git-rev-parse --verify "$1"^0) &&
-merge=$(git-rev-parse --verify "$2"^0) &&
-merge_name="$2" &&
-merge_msg="$3" || usage
-
-#
-# The remote name is just used for the message,
-# but we do want it.
-#
-if [ -z "$head" -o -z "$merge" -o -z "$merge_msg" ]; then
-	usage
-fi
-
-dropheads
-echo $head > "$GIT_DIR"/ORIG_HEAD
-echo $merge > "$GIT_DIR"/LAST_MERGE
-
-common=$(git-merge-base $head $merge)
-if [ -z "$common" ]; then
-	die "Unable to find common commit between" $merge $head
-fi
-
-case "$common" in
-"$merge")
-	echo "Already up-to-date. Yeeah!"
-	dropheads
-	exit 0
-	;;
-"$head")
-	echo "Updating from $head to $merge"
-	git-read-tree -u -m $head $merge || exit 1
-	git-update-ref -m "resolve $merge_name: Fast forward" \
-		HEAD "$merge" "$head"
-	git-diff-tree -p $head $merge | git-apply --stat
-	dropheads
-	exit 0
-	;;
-esac
-
-# We are going to make a new commit.
-git var GIT_COMMITTER_IDENT >/dev/null || exit
-
-# Find an optimum merge base if there are more than one candidates.
-LF='
-'
-common=$(git-merge-base -a $head $merge)
-case "$common" in
-?*"$LF"?*)
-	echo "Trying to find the optimum merge base."
-	G=.tmp-index$$
-	best=
-	best_cnt=-1
-	for c in $common
-	do
-		rm -f $G
-		GIT_INDEX_FILE=$G git-read-tree -m $c $head $merge \
-			2>/dev/null || continue
-		# Count the paths that are unmerged.
-		cnt=`GIT_INDEX_FILE=$G git-ls-files --unmerged | wc -l`
-		if test $best_cnt -le 0 -o $cnt -le $best_cnt
-		then
-			best=$c
-			best_cnt=$cnt
-			if test "$best_cnt" -eq 0
-			then
-				# Cannot do any better than all trivial merge.
-				break
-			fi
-		fi
-	done
-	rm -f $G
-	common="$best"
-esac
-
-echo "Trying to merge $merge into $head using $common."
-git-update-index --refresh 2>/dev/null
-git-read-tree -u -m $common $head $merge || exit 1
-result_tree=$(git-write-tree  2> /dev/null)
-if [ $? -ne 0 ]; then
-	echo "Simple merge failed, trying Automatic merge"
-	git-merge-index -o git-merge-one-file -a
-	if [ $? -ne 0 ]; then
-		echo $merge > "$GIT_DIR"/MERGE_HEAD
-		die "Automatic merge failed, fix up by hand"
-	fi
-	result_tree=$(git-write-tree) || exit 1
-fi
-result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree -p $head -p $merge)
-echo "Committed merge $result_commit"
-git-update-ref -m "resolve $merge_name: In-index merge" \
-	HEAD "$result_commit" "$head"
-git-diff-tree -p $head $result_commit | git-apply --stat
-dropheads
