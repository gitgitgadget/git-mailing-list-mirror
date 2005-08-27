From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Redo "revert" using three-way merge machinery.
Date: Fri, 26 Aug 2005 18:18:56 -0700
Message-ID: <7vll2o89dr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 27 03:19:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8pLY-0003aG-UG
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 03:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbVH0BS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 21:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVH0BS7
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 21:18:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54439 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965194AbVH0BS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 21:18:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827011858.PGUR19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 21:18:58 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7833>

The reverse patch application using "git apply" sometimes is too
rigid.  Since the user would get used to resolving conflicting merges
by hand during the normal merge experience, using the same machinery
would be more helpful rather than just giving up.

Cherry-picking and reverting are essentially the same operation.
You pick one commit, and apply the difference that commit introduces
to its own commit ancestry chain to the current tree.  Revert applies
the diff in reverse while cherry-pick applies it forward.  They share
the same logic, just different messages and merge direction.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I've reorganized some patches and merged a couple into one.
 * An earlier version of this patch was already sent to the
 * list, but this is a rework.

 Makefile            |    1 
 git-revert-script   |  185 +++++++++++++++++++++++++++++++++++++++++++--------
 git-sh-setup-script |   11 +++
 3 files changed, 167 insertions(+), 30 deletions(-)

0fa9fd414efbf73f1394b983d0f643b60d383ce0
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -215,6 +215,7 @@ check:
 install: $(PROG) $(SCRIPTS)
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(DESTDIR)$(bindir)
+	$(INSTALL) git-revert-script $(DESTDIR)$(bindir)/git-cherry-pick-script
 	$(MAKE) -C templates install
 	$(MAKE) -C tools install
 
diff --git a/git-revert-script b/git-revert-script
--- a/git-revert-script
+++ b/git-revert-script
@@ -1,37 +1,162 @@
 #!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+# Copyright (c) 2005 Junio C Hamano
+#
 . git-sh-setup-script || die "Not a git archive"
 
-# We want a clean tree and clean index to be able to revert.
-status=$(git status)
-case "$status" in
-'nothing to commit') ;;
+case "$0" in
+*-revert-* )
+	me=revert ;;
+*-cherry-pick-* )
+	me=cherry-pick ;;
+esac
+
+usage () {
+	case "$me" in
+	cherry-pick)
+		die "usage git $me [-n] [-r] <commit-ish>"
+		;;
+	revert)
+		die "usage git $me [-n] <commit-ish>"
+		;;
+	esac
+}
+
+no_commit= replay=
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	-n|--n|--no|--no-|--no-c|--no-co|--no-com|--no-comm|\
+	    --no-commi|--no-commit)
+		no_commit=t
+		;;
+	-r|--r|--re|--rep|--repl|--repla|--replay)
+		replay=t
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
+test "$me,$replay" = "revert,t" && usage
+
+case "$no_commit" in
+t)
+	# We do not intend to commit immediately.  We just want to
+	# merge the differences in.
+	head=$(git-write-tree) ||
+		die "Your index file is unmerged."
+	;;
 *)
-	echo "$status"
-	die "Your working tree is dirty; cannot revert a previous patch." ;;
+	check_clean_tree || die "Cannot run $me from a dirty tree."
+	head=$(git-rev-parse --verify HEAD) ||
+		die "You do not have a valid HEAD"
+	;;
 esac
 
 rev=$(git-rev-parse --verify "$@") &&
-commit=$(git-rev-parse --verify "$rev^0") || exit
-if git-diff-tree -R -M -p $commit | git-apply --index &&
-   msg=$(git-rev-list --pretty=oneline --max-count=1 $commit)
-then
-        {
-                echo "$msg" | sed -e '
-			s/^[^ ]* /Revert "/
-			s/$/"/'
-                echo
-                echo "This reverts $commit commit."
-                test "$rev" = "$commit" ||
-                echo "(original 'git revert' arguments: $@)"
-        } | git commit -F -
-else
-        # Now why did it fail?
-        parents=`git-cat-file commit "$commit" 2>/dev/null |
-                sed -ne '/^$/q;/^parent /p' |
-                wc -l`
-        case $parents in
-        0) die "Cannot revert the root commit nor non commit-ish." ;;
-        1) die "The patch does not apply." ;;
-        *) die "Cannot revert a merge commit." ;;
-        esac
-fi
+commit=$(git-rev-parse --verify "$rev^0") ||
+	die "Not a single commit $@"
+prev=$(git-rev-parse --verify "$commit^1" 2>/dev/null) ||
+	die "Cannot run $me a root commit"
+git-rev-parse --verify "$commit^2" >/dev/null 2>&1 &&
+	die "Cannot run $me a multi-parent commit."
+
+# "commit" is an existing commit.  We would want to apply
+# the difference it introduces since its first parent "prev"
+# on top of the current HEAD if we are cherry-pick.  Or the
+# reverse of it if we are revert.
+
+case "$me" in
+revert)
+	git-rev-list --pretty=oneline --max-count=1 $commit |
+	sed -e '
+		s/^[^ ]* /Revert "/
+		s/$/"/'
+	echo
+	echo "This reverts $commit commit."
+	test "$rev" = "$commit" ||
+	echo "(original 'git revert' arguments: $@)"
+	base=$commit next=$prev
+	;;
+
+cherry-pick)
+	pick_author_script='
+	/^author /{
+		h
+		s/^author \([^<]*\) <[^>]*> .*$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
+
+		g
+		s/^author [^<]* <\([^>]*\)> .*$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
+
+		g
+		s/^author [^<]* <[^>]*> \(.*\)$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
+
+		q
+	}'
+	set_author_env=`git-cat-file commit "$commit" |
+	sed -ne "$pick_author_script"`
+	eval "$set_author_env"
+	export GIT_AUTHOR_NAME
+	export GIT_AUTHOR_EMAIL
+	export GIT_AUTHOR_DATE
+
+	git-cat-file commit $commit | sed -e '1,/^$/d'
+	case "$replay" in
+	'')
+		echo "(cherry picked from $commit commit)"
+		test "$rev" = "$commit" ||
+		echo "(original 'git cherry-pick' arguments: $@)"
+		;;
+	esac
+	base=$prev next=$commit
+	;;
+
+esac >.msg
+
+# This three way merge is an interesting one.  We are at
+# $head, and would want to apply the change between $commit
+# and $prev on top of us (when reverting), or the change between
+# $prev and $commit on top of us (when cherry-picking or replaying).
+
+git-read-tree -m -u $base $head $next &&
+result=$(git-write-tree 2>/dev/null) || {
+    echo >&2 "Simple $me fails; trying Automatic $me."
+    git-merge-cache -o git-merge-one-file-script -a || {
+	    echo >&2 "Automatic $me failed.  After fixing it up,"
+	    echo >&2 "you can use \"git commit -F .msg\""
+	    case "$me" in
+	    cherry-pick)
+		echo >&2 "You may choose to use the following when making"
+		echo >&2 "the commit:"
+		echo >&2 "$set_author_env"
+	    esac
+	    exit 1
+    }
+    result=$(git-write-tree) || exit
+}
+
+# If we are cherry-pick, and if the merge did not result in
+# hand-editing, we will hit this commit and inherit the original
+# author date and name.
+# If we are revert, or if our cherry-pick results in a hand merge,
+# we had better say that the current user is responsible for that.
+
+case "$no_commit" in
+'')
+	git commit -F .msg
+	rm -f .msg
+	;;
+esac
diff --git a/git-sh-setup-script b/git-sh-setup-script
--- a/git-sh-setup-script
+++ b/git-sh-setup-script
@@ -11,6 +11,17 @@ die() {
 	exit 1
 }
 
+check_clean_tree() {
+    dirty1_=`git-update-cache -q --refresh` && {
+    dirty2_=`git-diff-cache --name-only --cached HEAD`
+    case "$dirty2_" in '') : ;; *) (exit 1) ;; esac
+    } || {
+	echo >&2 "$dirty1_"
+	echo "$dirty2_" | sed >&2 -e 's/^/modified: /'
+	(exit 1)
+    }
+}
+
 [ -d "$GIT_DIR" ] &&
 [ -d "$GIT_DIR/refs" ] &&
 [ -d "$GIT_OBJECT_DIRECTORY" ] &&
