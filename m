From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] filter-branch: introduce convenience function "skip_commit"
Date: Fri, 31 Aug 2007 20:06:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312005420.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 31 21:06:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRBpH-0008Nn-Ky
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 21:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965527AbXHaTGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbXHaTGf
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 15:06:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:32817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932648AbXHaTGe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 15:06:34 -0400
Received: (qmail invoked by alias); 31 Aug 2007 19:06:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 31 Aug 2007 21:06:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/J7W1YrKTJURnvYvOjjuNAHjeVW1hfqD5abTECG0
	sg0LQOQKvpNS87
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57196>


With this function, a commit filter can leave out unwanted commits
(such as temporary commits).  It does _not_ undo the changeset
corresponding to that commit, but it _skips_ the revision.  IOW
its ancestors' tree objects remain the same.

If you like to commit early and often, but want to filter out all
intermediate commits, marked by "@@@" in the commit message, you can
now do this with

	git filter-branch --commit-filter '
		if git cat-file commit $GIT_COMMIT | grep '@@@' > /dev/null;
		then
			skip_commit "$@";
		else
			git commit-tree "$@";
		fi' newbranch

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Same comment as for 1/2 applies here, too...

 Documentation/git-filter-branch.txt |   34 +++++++++++++++++++++++++++-------
 git-filter-branch.sh                |   14 ++++++++++++++
 t/t7003-filter-branch.sh            |    8 +-------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 456d52b..29bb8ce 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -112,6 +112,11 @@ OPTIONS
 As a special extension, the commit filter may emit multiple
 commit ids; in that case, ancestors of the original commit will
 have all of them as parents.
++
+You can use the 'map' convenience function in this filter, and other
+convenience functions, too.  For example, calling 'skip_commit "$@"'
+will leave out the current commit (but not its changes! If you want
+that, use gitlink:git-rebase[1] instead).
 
 --tag-name-filter <command>::
 	This is the filter for rewriting tag names. When passed,
@@ -209,24 +214,39 @@ To remove commits authored by "Darl McBribe" from the history:
 git filter-branch --commit-filter '
 	if [ "$GIT_AUTHOR_NAME" = "Darl McBribe" ];
 	then
-		shift;
-		while [ -n "$1" ];
-		do
-			shift;
-			echo "$1";
-			shift;
-		done;
+		skip_commit "$@";
 	else
 		git commit-tree "$@";
 	fi' HEAD
 ------------------------------------------------------------------------------
 
+Note that the changes introduced by the commits, and not reverted by
+subsequent commits, will still be in the rewritten branch. If you want
+to throw out _changes_ together with the commits, you should use the
+interactive mode of gitlink:git-rebase[1].
+
+The function 'skip_commits' is defined as follows:
+
+--------------------------
+skip_commit()
+{
+	shift;
+	while [ -n "$1" ];
+	do
+		shift;
+		map "$1";
+		shift;
+	done;
+}
+--------------------------
+
 The shift magic first throws away the tree id and then the -p
 parameters.  Note that this handles merges properly! In case Darl
 committed a merge between P1 and P2, it will be propagated properly
 and all children of the merge will become merge commits with P1,P2
 as their parents instead of the merge commit.
 
+
 To restrict rewriting to only part of the history, specify a revision
 range in addition to the new branch name.  The new branch name will
 point to the top-most revision that a 'git rev-list' of this range
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3b041d8..a4b6577 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -23,6 +23,20 @@ map()
 	fi
 }
 
+# if you run 'skip_commit "$@"' in a commit filter, it will print
+# the (mapped) parents, effectively skipping the commit.
+
+skip_commit()
+{
+	shift;
+	while [ -n "$1" ];
+	do
+		shift;
+		map "$1";
+		shift;
+	done;
+}
+
 # override die(): this version puts in an extra line break, so that
 # the progress is still visible
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index c79853d..e935b20 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -138,13 +138,7 @@ test_expect_success "remove a certain author's commits" '
 	git-filter-branch -f --commit-filter "\
 		if [ \"\$GIT_AUTHOR_NAME\" = \"B V Uips\" ];\
 		then\
-			shift;\
-			while [ -n \"\$1\" ];\
-			do\
-				shift;\
-				echo \"\$1\";\
-				shift;\
-			done;\
+			skip_commit \"\$@\";
 		else\
 			git commit-tree \"\$@\";\
 		fi" removed-author &&
-- 
1.5.3.rc7.18.gc9b59
