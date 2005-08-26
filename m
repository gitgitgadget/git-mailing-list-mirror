From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Redo "revert" using three-way merge machinery.
Date: Fri, 26 Aug 2005 01:04:42 -0700
Message-ID: <7v8xypgm3p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 26 10:34:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8ZCh-00032i-Il
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 10:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVHZIEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 04:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVHZIEo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 04:04:44 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:11235 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965054AbVHZIEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 04:04:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826080442.HDXJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 04:04:42 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7781>

The reverse patch application using "git apply" sometimes is too
rigid.  Since the user would get used to resolving conflicting merges
by hand during the normal merge experience, using the same machinery
would be more helpful rather than just giving up.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-revert-script |   75 ++++++++++++++++++++++++++++++-----------------------
 1 files changed, 42 insertions(+), 33 deletions(-)

186bb385d806bf08b5a81888230ad7a96aec50c7
diff --git a/git-revert-script b/git-revert-script
--- a/git-revert-script
+++ b/git-revert-script
@@ -2,38 +2,47 @@
 . git-sh-setup-script || die "Not a git archive"
 
 # We want a clean tree and clean index to be able to revert.
-dirty=`git-diff-cache --name-only --cached HEAD`
-case "$dirty" in '') dirty=`git-diff-cache --name-only HEAD` ;; esac
-case "$dirty" in
-'') ;;
-*)
-	echo >&2 "Modified:"
-	echo "$dirty" | sed >&2 -e 's/^/	/'
-	die "Your working tree is dirty; cannot revert a previous patch." ;;
-esac
+check_clean_tree || die "Cannot run revert from a dirty tree."
 
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
+head=$(git-rev-parse --verify HEAD) ||
+	die "You do not have a valid HEAD"
+prev=$(git-rev-parse --verify "$commit^1" 2>/dev/null) ||
+	die "Cannot revert a root commit"
+git-rev-parse --verify "$commit^2" >/dev/null 2>&1 &&
+	die "Cannot revert a multi-parent commit."
+
+# "commit" is an existing commit.  We would want to apply
+# the difference it introduces since its first parent "prev"
+# on top of the current HEAD.
+
+{
+	git-rev-list --pretty=oneline --max-count=1 $commit |
+	sed -e '
+		s/^[^ ]* /Revert "/
+		s/$/"/'
+	echo
+	echo "This reverts $commit commit."
+	test "$rev" = "$commit" ||
+	echo "(original 'git revert' arguments: $@)"
+} >.revertmsg
+
+# This three way merge is an interesting one.  We have come from
+# $commit to $head, and would want to apply the change between $commit
+# and $prev to us.
+git-read-tree -m -u $commit $head $prev &&
+result=$(git-write-tree 2>/dev/null) || {
+    echo >&2 "Simple revert fails; trying automated revert."
+    git-merge-cache -o git-merge-one-file-script -a || {
+	    echo >&2 "Automated revert failed.  After fixing it up,"
+	    echo >&2 "you can use \"git commit -F .revertmsg\""
+	    exit 1
+    }
+    result=$(git-write-tree) || exit
+}
+
+git commit -F .revertmsg
+rm -f .revertmsg
+
