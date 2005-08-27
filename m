From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Remove git-apply-patch-script.
Date: Fri, 26 Aug 2005 18:19:07 -0700
Message-ID: <7v4q9c89dg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 27 03:19:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8pMK-0003hT-Ro
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 03:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVH0BTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 21:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbVH0BTL
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 21:19:11 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13231 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965197AbVH0BTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 21:19:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827011909.NKTH8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 21:19:09 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7831>

Now the rebase is rewritten to use git cherry-pick, there is no user
for that ancient script.  I've checked Cogito and StGIT to make sure
they do not use it.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-apply-patch-script.txt           |   32 ----
 Documentation/git.txt                              |    3 
 .../howto/rebase-from-internal-branch.txt          |    2 
 Makefile                                           |    2 
 git-apply-patch-script                             |  144 --------------------
 git-cherry                                         |   14 --
 6 files changed, 4 insertions(+), 193 deletions(-)
 delete mode 100644 Documentation/git-apply-patch-script.txt
 delete mode 100755 git-apply-patch-script

ad3f5eb30999095f276f8d4664f3e7884296c797
diff --git a/Documentation/git-apply-patch-script.txt b/Documentation/git-apply-patch-script.txt
deleted file mode 100644
--- a/Documentation/git-apply-patch-script.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-git-apply-patch-script(1)
-=========================
-v0.99.4, May 2005
-
-NAME
-----
-git-apply-patch-script - Sample script to apply the diffs from git-diff-*
-
-
-SYNOPSIS
---------
-'git-apply-patch-script'
-
-DESCRIPTION
------------
-This is a sample script to be used via the 'GIT_EXTERNAL_DIFF'
-environment variable to apply the differences that the "git-diff-*"
-family of commands report to the current work tree.
-
-
-Author
-------
-Written by Junio C Hamano <junkio@cox.net>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the link:git.html[git] suite
-
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -242,9 +242,6 @@ Ancillary Commands
 ------------------
 Manipulators:
 
-link:git-apply-patch-script.html[git-apply-patch-script]::
-	Sample script to apply the diffs from git-diff-*
-
 link:git-convert-cache.html[git-convert-cache]::
 	Converts old-style GIT repository
 
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -38,7 +38,7 @@ ancestry graph looked like this:
 So I started from master, made a bunch of edits, and committed:
 
     $ git checkout master
-    $ cd Documentation; ed git.txt git-apply-patch-script.txt ...
+    $ cd Documentation; ed git.txt ...
     $ cd ..; git add Documentation/*.txt
     $ git commit -s -v
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -57,7 +57,7 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powe
 
 
 
-SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
+SCRIPTS=git git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
 	git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script git-diff-script \
diff --git a/git-apply-patch-script b/git-apply-patch-script
deleted file mode 100755
--- a/git-apply-patch-script
+++ /dev/null
@@ -1,144 +0,0 @@
-#!/bin/sh
-# Copyright (C) 2005 Junio C Hamano
-#
-# Applying diff between two trees to the work tree can be
-# done with the following single command:
-#
-# GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p $tree1 $tree2
-#
-
-case "$#" in
-1)
-    echo >&2 "cannot handle unmerged diff on path $1."
-    exit 1 ;;
-8 | 9)
-    echo >&2 "cannot handle rename diff between $1 and $8 yet."
-    exit 1 ;;
-esac
-name="$1" tmp1="$2" hex1="$3" mode1="$4" tmp2="$5" hex2="$6" mode2="$7"
-
-type1=f
-case "$mode1" in
-*120???) type1=l  ;;
-*1007??) mode1=+x ;;
-*1006??) mode1=-x ;;
-.)       type1=-  ;; 
-esac
-
-type2=f
-case "$mode2" in
-*120???) type2=l  ;;
-*1007??) mode2=+x ;;
-*1006??) mode2=-x ;;
-.)       type2=-  ;; 
-esac
-
-case "$type1,$type2" in
-
--,?)
-    dir=$(dirname "$name")
-    case "$dir" in '' | .) ;; *) mkdir -p "$dir" ;; esac || {
-	echo >&2 "cannot create leading path for $name."
-	exit 1
-    }
-    if test -e "$name"
-    then
-	echo >&2 "path $name to be created already exists."
-	exit 1
-    fi
-    case "$type2" in
-    f)
-        # creating a regular file
-	cat "$tmp2" >"$name" || {
-	    echo >&2 "cannot create a regular file $name."
-	    exit 1
-	} 
-	case "$mode2" in
-	+x)
-	    echo >&2 "created a regular file $name with mode +x."
-	    chmod "$mode2" "$name"
-	    ;;
-	-x)
-	    echo >&2 "created a regular file $name."
-            ;;
-        esac
-	;;
-    l)
-        # creating a symlink
-        ln -s "$(cat "$tmp2")" "$name" || {
-	    echo >&2 "cannot create a symbolic link $name."
-	    exit 1
-	}
-	echo >&2 "created a symbolic link $name."
-        ;;
-    *)
-        echo >&2 "do not know how to create $name of type $type2."
-	exit 1
-    esac
-    git-update-cache --add -- "$name" ;;
-
-?,-)
-    rm -f "$name" || {
-	echo >&2 "cannot remove $name"
-	exit 1
-    }
-    echo >&2 "deleted $name."
-    git-update-cache --remove -- "$name" ;;
-
-l,f|f,l)
-    echo >&2 "cannot change a regular file $name and a symbolic link $name."
-    exit 1 ;;
-
-l,l)
-    # symlink to symlink
-    current=$(readlink "$name") || {
-	echo >&2 "cannot read the target of the symbolic link $name."
-	exit 1
-    }
-    original=$(cat "$tmp1")
-    next=$(cat "$tmp2")
-    test "$original" != "$current" || {
-	echo >&2 "cannot apply symbolic link target change ($original->$next) to $name which points to $current."
-	exit 1
-    }
-    if test "$next" != "$current"
-    then
-	rm -f "$name" && ln -s "$next" "$name" || {
-	    echo >&2 "cannot create symbolic link $name."
-	    exit 1
-	}
-	echo >&2 "changed symbolic target of $name."
-        git-update-cache -- "$name"
-    fi ;;
-
-f,f)
-    # changed
-    test -e "$name" || {
-	echo >&2 "regular file $name to be patched does not exist."
-	exit 1
-    }
-    dir=$(dirname "$name")
-    case "$dir" in '' | .) ;; *) mkdir -p "$dir";; esac || {
-	echo >&2 "cannot create leading path for $name."
-	exit 1
-    }
-    tmp=.git-apply-patch-$$
-    trap "rm -f $tmp-*" 0 1 2 3 15
-
-    # Be careful, in case "$tmp2" is borrowed path from the work tree
-    # we are looking at...
-    diff -u -L "a/$name" -L "b/$name" "$tmp1" "$tmp2" >$tmp-patch
-
-    # This will say "patching ..." so we do not say anything outselves.
-    patch -p1 <$tmp-patch || exit
-    rm -f $tmp-patch
-    case "$mode1,$mode2" in
-    "$mode2,$mode1") ;;
-    *)
-	chmod "$mode2" "$name"
-	echo >&2 "changed mode from $mode1 to $mode2."
-	;;
-    esac
-    git-update-cache -- "$name"
-
-esac
diff --git a/git-cherry b/git-cherry
--- a/git-cherry
+++ b/git-cherry
@@ -15,18 +15,8 @@ usage="usage: $0 "'[-v] <upstream> [<hea
 Each commit between the fork-point and <head> is examined, and
 compared against the change each commit between the fork-point and
 <upstream> introduces.  If the change does not seem to be in the
-upstream, it is shown on the standard output.
-
-The output is intended to be used as:
-
-    OLD_HEAD=$(git-rev-parse HEAD)
-    git-rev-parse upstream >${GIT_DIR-.}/HEAD
-    git-cherry upstream $OLD_HEAD |
-    while read commit
-    do
-        GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p "$commit" &&
-	git-commit-script -C "$commit"
-    done
+upstream, it is shown on the standard output with prefix "+".  Otherwise
+it is shown with prefix "-".
 '
 
 case "$1" in -v) verbose=t; shift ;; esac 
