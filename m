From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Remove git-applypatch
Date: Thu, 24 May 2007 19:33:09 -0700
Message-ID: <7vr6p5tyxm.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070520001012.5051.38142.stgit@rover>
	<7vejl719vf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 25 04:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPcA-00050q-Gx
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbXEYCdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbXEYCdM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:33:12 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51935 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbXEYCdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:33:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525023309.FXXB19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 24 May 2007 22:33:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3EZ91X00C1kojtg0000000; Thu, 24 May 2007 22:33:10 -0400
In-Reply-To: <7vejl719vf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 23 May 2007 14:57:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48336>

The previous one removed git-applymbox, which was the sole user
of this tool.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 .gitignore                       |    1 -
 Documentation/SubmittingPatches  |    4 +-
 Documentation/cmd-list.perl      |    1 -
 Documentation/git-am.txt         |    2 +-
 Documentation/git-applypatch.txt |   53 ----------
 Documentation/git-mailinfo.txt   |    2 +-
 Documentation/hooks.txt          |   13 +--
 Makefile                         |    2 +-
 git-applypatch.sh                |  212 --------------------------------------
 9 files changed, 10 insertions(+), 280 deletions(-)
 delete mode 100644 Documentation/git-applypatch.txt
 delete mode 100755 git-applypatch.sh

diff --git a/.gitignore b/.gitignore
index 76c0e1b..b4e72f5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,7 +7,6 @@ git-add--interactive
 git-am
 git-annotate
 git-apply
-git-applypatch
 git-archimport
 git-archive
 git-bisect
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b94d9a8..b5f2ecd 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -239,7 +239,7 @@ One test you could do yourself if your MUA is set up correctly is:
     $ git fetch http://kernel.org/pub/scm/git/git.git master:test-apply
     $ git checkout test-apply
     $ git reset --hard
-    $ git applymbox a.patch
+    $ git am a.patch
 
 If it does not apply correctly, there can be various reasons.
 
@@ -247,7 +247,7 @@ If it does not apply correctly, there can be various reasons.
   does not have much to do with your MUA.  Please rebase the
   patch appropriately.
 
-* Your MUA corrupted your patch; applymbox would complain that
+* Your MUA corrupted your patch; "am" would complain that
   the patch does not apply.  Look at .dotest/ subdirectory and
   see what 'patch' file contains and check for the common
   corruption patterns mentioned above.
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 0bca346..645e437 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -72,7 +72,6 @@ __DATA__
 git-add                                 mainporcelain
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
-git-applypatch                          purehelpers
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 049e46f..7658fbd 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -145,7 +145,7 @@ names.
 
 SEE ALSO
 --------
-gitlink:git-applypatch[1], gitlink:git-apply[1].
+gitlink:git-apply[1].
 
 
 Author
diff --git a/Documentation/git-applypatch.txt b/Documentation/git-applypatch.txt
deleted file mode 100644
index 451434a..0000000
--- a/Documentation/git-applypatch.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-git-applypatch(1)
-=================
-
-NAME
-----
-git-applypatch - Apply one patch extracted from an e-mail
-
-
-SYNOPSIS
---------
-'git-applypatch' <msg> <patch> <info> [<signoff>]
-
-DESCRIPTION
------------
-This is usually not what an end user wants to run directly.  See
-gitlink:git-am[1] instead.
-
-Takes three files <msg>, <patch>, and <info> prepared from an
-e-mail message by 'git-mailinfo', and creates a commit.  It is
-usually not necessary to use this command directly.
-
-This command can run `applypatch-msg`, `pre-applypatch`, and
-`post-applypatch` hooks.  See link:hooks.html[hooks] for more
-information.
-
-
-OPTIONS
--------
-<msg>::
-	Commit log message (sans the first line, which comes
-	from e-mail Subject stored in <info>).
-
-<patch>::
-	The patch to apply.
-
-<info>::
-	Author and subject information extracted from e-mail,
-	used on "author" line and as the first line of the
-	commit log message.
-
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org>
-
-Documentation
---------------
-Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
-
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 8eadceb..1695695 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Reading a single e-mail message from the standard input, and
 writes the commit log message in <msg> file, and the patches in
 <patch> file.  The author name, e-mail and e-mail subject are
-written out to the standard output to be used by git-applypatch
+written out to the standard output to be used by git-am
 to create a commit.  It is usually not necessary to use this
 command directly.  See gitlink:git-am[1] instead.
 
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index aad1744..6836477 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -12,11 +12,10 @@ This document describes the currently defined hooks.
 applypatch-msg
 --------------
 
-This hook is invoked by `git-applypatch` script, which is
-typically invoked by `git-am`.  It takes a single
+This hook is invoked by `git-am` script.  It takes a single
 parameter, the name of the file that holds the proposed commit
 log message.  Exiting with non-zero status causes
-`git-applypatch` to abort before applying the patch.
+`git-am` to abort before applying the patch.
 
 The hook is allowed to edit the message file in place, and can
 be used to normalize the message into some project standard
@@ -29,8 +28,7 @@ The default 'applypatch-msg' hook, when enabled, runs the
 pre-applypatch
 --------------
 
-This hook is invoked by `git-applypatch` script, which is
-typically invoked by `git-am`.  It takes no parameter,
+This hook is invoked by `git-am`.  It takes no parameter,
 and is invoked after the patch is applied, but before a commit
 is made.  Exiting with non-zero status causes the working tree
 after application of the patch not committed.
@@ -44,12 +42,11 @@ The default 'pre-applypatch' hook, when enabled, runs the
 post-applypatch
 ---------------
 
-This hook is invoked by `git-applypatch` script, which is
-typically invoked by `git-am`.  It takes no parameter,
+This hook is invoked by `git-am`.  It takes no parameter,
 and is invoked after the patch is applied and a commit is made.
 
 This hook is meant primarily for notification, and cannot affect
-the outcome of `git-applypatch`.
+the outcome of `git-am`.
 
 pre-commit
 ----------
diff --git a/Makefile b/Makefile
index 870179b..4e63a69 100644
--- a/Makefile
+++ b/Makefile
@@ -206,7 +206,7 @@ SCRIPT_SH = \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-sh-setup.sh \
 	git-tag.sh git-verify-tag.sh \
-	git-applypatch.sh git-am.sh \
+	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
 	git-lost-found.sh git-quiltimport.sh
diff --git a/git-applypatch.sh b/git-applypatch.sh
deleted file mode 100755
index 8df2aee..0000000
--- a/git-applypatch.sh
+++ /dev/null
@@ -1,212 +0,0 @@
-#!/bin/sh
-##
-## applypatch takes four file arguments, and uses those to
-## apply the unpacked patch (surprise surprise) that they
-## represent to the current tree.
-##
-## The arguments are:
-##	$1 - file with commit message
-##	$2 - file with the actual patch
-##	$3 - "info" file with Author, email and subject
-##	$4 - optional file containing signoff to add
-##
-
-USAGE='<msg> <patch> <info> [<signoff>]'
-. git-sh-setup
-
-case "$#" in 3|4) ;; *) usage ;; esac
-
-final=.dotest/final-commit
-##
-## If this file exists, we ask before applying
-##
-query_apply=.dotest/.query_apply
-
-## We do not munge the first line of the commit message too much
-## if this file exists.
-keep_subject=.dotest/.keep_subject
-
-## We do not attempt the 3-way merge fallback unless this file exists.
-fall_back_3way=.dotest/.3way
-
-MSGFILE=$1
-PATCHFILE=$2
-INFO=$3
-SIGNOFF=$4
-EDIT=${VISUAL:-${EDITOR:-vi}}
-
-export GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$INFO")"
-export GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$INFO")"
-export GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$INFO")"
-export SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$INFO")"
-
-if test '' != "$SIGNOFF"
-then
-	if test -f "$SIGNOFF"
-	then
-		SIGNOFF=`cat "$SIGNOFF"` || exit
-	elif case "$SIGNOFF" in yes | true | me | please) : ;; *) false ;; esac
-	then
-		SIGNOFF=`git-var GIT_COMMITTER_IDENT | sed -e '
-				s/>.*/>/
-				s/^/Signed-off-by: /'
-		`
-	else
-		SIGNOFF=
-	fi
-	if test '' != "$SIGNOFF"
-	then
-		LAST_SIGNED_OFF_BY=`
-			sed -ne '/^Signed-off-by: /p' "$MSGFILE" |
-			tail -n 1
-		`
-		test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF" || {
-		    test '' = "$LAST_SIGNED_OFF_BY" && echo
-		    echo "$SIGNOFF"
-		} >>"$MSGFILE"
-	fi
-fi
-
-patch_header=
-test -f "$keep_subject" || patch_header='[PATCH] '
-
-{
-	echo "$patch_header$SUBJECT"
-	if test -s "$MSGFILE"
-	then
-		echo
-		cat "$MSGFILE"
-	fi
-} >"$final"
-
-interactive=yes
-test -f "$query_apply" || interactive=no
-
-while [ "$interactive" = yes ]; do
-	echo "Commit Body is:"
-	echo "--------------------------"
-	cat "$final"
-	echo "--------------------------"
-	printf "Apply? [y]es/[n]o/[e]dit/[a]ccept all "
-	read reply
-	case "$reply" in
-		y|Y) interactive=no;;
-		n|N) exit 2;;	# special value to tell dotest to keep going
-		e|E) "$EDIT" "$final";;
-		a|A) rm -f "$query_apply"
-		     interactive=no ;;
-	esac
-done
-
-if test -x "$GIT_DIR"/hooks/applypatch-msg
-then
-	"$GIT_DIR"/hooks/applypatch-msg "$final" || exit
-fi
-
-echo
-echo Applying "'$SUBJECT'"
-echo
-
-git-apply --index "$PATCHFILE" || {
-
-	# git-apply exits with status 1 when the patch does not apply,
-	# but it die()s with other failures, most notably upon corrupt
-	# patch.  In the latter case, there is no point to try applying
-	# it to another tree and do 3-way merge.
-	test $? = 1 || exit 1
-
-	test -f "$fall_back_3way" || exit 1
-
-	# Here if we know which revision the patch applies to,
-	# we create a temporary working tree and index, apply the
-	# patch, and attempt 3-way merge with the resulting tree.
-
-	O_OBJECT=`cd "$GIT_OBJECT_DIRECTORY" && pwd`
-	rm -fr .patch-merge-*
-
-	if git-apply -z --index-info "$PATCHFILE" \
-		>.patch-merge-index-info 2>/dev/null &&
-		GIT_INDEX_FILE=.patch-merge-tmp-index \
-		git-update-index -z --index-info <.patch-merge-index-info &&
-		GIT_INDEX_FILE=.patch-merge-tmp-index \
-		git-write-tree >.patch-merge-tmp-base &&
-		(
-			mkdir .patch-merge-tmp-dir &&
-			cd .patch-merge-tmp-dir &&
-			GIT_INDEX_FILE="../.patch-merge-tmp-index" \
-			GIT_OBJECT_DIRECTORY="$O_OBJECT" \
-			git-apply $binary --index
-		) <"$PATCHFILE"
-	then
-		echo Using index info to reconstruct a base tree...
-		mv .patch-merge-tmp-base .patch-merge-base
-		mv .patch-merge-tmp-index .patch-merge-index
-	else
-	(
-		N=10
-
-		# Otherwise, try nearby trees that can be used to apply the
-		# patch.
-		git-rev-list --max-count=$N HEAD
-
-		# or hoping the patch is against known tags...
-		git-ls-remote --tags .
-	) |
-	    while read base junk
-	    do
-		# Try it if we have it as a tree.
-		git-cat-file tree "$base" >/dev/null 2>&1 || continue
-
-		rm -fr .patch-merge-tmp-* &&
-		mkdir .patch-merge-tmp-dir || break
-		(
-			cd .patch-merge-tmp-dir &&
-			GIT_INDEX_FILE=../.patch-merge-tmp-index &&
-			GIT_OBJECT_DIRECTORY="$O_OBJECT" &&
-			export GIT_INDEX_FILE GIT_OBJECT_DIRECTORY &&
-			git-read-tree "$base" &&
-			git-apply --index &&
-			mv ../.patch-merge-tmp-index ../.patch-merge-index &&
-			echo "$base" >../.patch-merge-base
-		) <"$PATCHFILE"  2>/dev/null && break
-	    done
-	fi
-
-	test -f .patch-merge-index &&
-	his_tree=$(GIT_INDEX_FILE=.patch-merge-index git-write-tree) &&
-	orig_tree=$(cat .patch-merge-base) &&
-	rm -fr .patch-merge-* || exit 1
-
-	echo Falling back to patching base and 3-way merge using $orig_tree...
-
-	# This is not so wrong.  Depending on which base we picked,
-	# orig_tree may be wildly different from ours, but his_tree
-	# has the same set of wildly different changes in parts the
-	# patch did not touch, so resolve ends up canceling them,
-	# saying that we reverted all those changes.
-
-	if git-merge-resolve $orig_tree -- HEAD $his_tree
-	then
-		echo Done.
-	else
-		echo Failed to merge in the changes.
-		exit 1
-	fi
-}
-
-if test -x "$GIT_DIR"/hooks/pre-applypatch
-then
-	"$GIT_DIR"/hooks/pre-applypatch || exit
-fi
-
-tree=$(git-write-tree) || exit 1
-echo Wrote tree $tree
-parent=$(git-rev-parse --verify HEAD) &&
-commit=$(git-commit-tree $tree -p $parent <"$final") || exit 1
-echo Committed: $commit
-git-update-ref -m "applypatch: $SUBJECT" HEAD $commit $parent || exit
-
-if test -x "$GIT_DIR"/hooks/post-applypatch
-then
-	"$GIT_DIR"/hooks/post-applypatch
-fi
-- 
1.5.2.70.g17b3ac
