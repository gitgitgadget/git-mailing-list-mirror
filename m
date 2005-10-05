From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fall back to three-way merge when applying a patch.
Date: Tue, 04 Oct 2005 17:46:05 -0700
Message-ID: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 02:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMxQc-0000jN-Ao
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 02:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVJEAqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 20:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVJEAqf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 20:46:35 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52133 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965053AbVJEAqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 20:46:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005004556.GWPD29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Oct 2005 20:45:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9694>

After git-apply fails, attempt to find a base tree that the patch
cleanly applies to, and do a three-way merge using that base tree into
the current index.

When the fall-back merge fails, the working tree can be resolved the
same way as you would normally hand resolve a conflicting merge.
When making commit, use .dotest/final-commit as the log message
template.  Or you could just choose to 'git-checkout-index -f -a'
to revert the failed merge.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I will be placing this in the proposed updates branch.
   Hopefully this would alleviate the complaints from people who
   find the "no fuzz" policy of git-apply is too strict.

   The change is helped if the patch sender uses the updated
   git-format-patch that records which tree the patch is
   supposed to cleanly apply to, but that is not strictly
   necessary; it tries to find a tree that patch applies to from
   the recent commits itself.

 git-applypatch.sh |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 1 deletions(-)

applies-to: 9eec9ff9326032bca405a12a265918725edf4ac7
fb533c6562481dfbc4719f740aa0d85e2a45700c
diff --git a/git-applypatch.sh b/git-applypatch.sh
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -105,7 +105,67 @@ git-apply --index "$PATCHFILE" || {
 	# Here if we know which revision the patch applies to,
 	# we create a temporary working tree and index, apply the
 	# patch, and attempt 3-way merge with the resulting tree.
-	exit 1
+
+	O_OBJECT=`cd "$GIT_OBJECT_DIRECTORY" && pwd`
+	rm -fr .patch-merge-*
+
+	(
+		N=10
+
+		# if the patch records the base tree...
+		sed -ne '
+			/^diff /q
+			/^applies-to: \([0-9a-f]*\)$/{
+				s//\1/p
+				q
+			}
+		' "$PATCHFILE"
+
+		# or hoping the patch is against our recent commits...
+		git-rev-list --max-count=$N HEAD
+
+		# or hoping the patch is against known tags...
+		git-ls-remote --tags .
+	) |
+	while read base junk
+	do
+		# Try it if we have it as a tree.
+		git-cat-file tree "$base" >/dev/null 2>&1 || continue
+
+		rm -fr .patch-merge-tmp-* &&
+		mkdir .patch-merge-tmp-dir || break
+		(
+			cd .patch-merge-tmp-dir &&
+			GIT_INDEX_FILE=../.patch-merge-tmp-index &&
+			GIT_OBJECT_DIRECTORY="$O_OBJECT" &&
+			export GIT_INDEX_FILE GIT_OBJECT_DIRECTORY &&
+			git-read-tree "$base" &&
+			git-apply --index &&
+			mv ../.patch-merge-tmp-index ../.patch-merge-index &&
+			echo "$base" >../.patch-merge-base
+		) <"$PATCHFILE"  2>/dev/null && break
+	done
+
+	test -f .patch-merge-index &&
+	his_tree=$(GIT_INDEX_FILE=.patch-merge-index git-write-tree) &&
+	orig_tree=$(cat .patch-merge-base) &&
+	rm -fr .patch-merge-* || exit 1
+
+	echo Falling back to patching base and 3-way merge using $orig_tree...
+
+	# This is not so wrong.  Depending on which base we picked,
+	# orig_tree may be wildly different from ours, but his_tree
+	# has the same set of wildly different changes in parts the
+	# patch did not touch, so resolve ends up cancelling them,
+	# saying that we reverted all those changes.
+
+	if git-merge-resolve $orig_tree -- HEAD $his_tree
+	then
+		echo Done.
+	else
+		echo Failed to merge in the changes.
+		exit 1
+	fi
 }
 
 if test -x "$GIT_DIR"/hooks/pre-applypatch
---
0.99.8.GIT
