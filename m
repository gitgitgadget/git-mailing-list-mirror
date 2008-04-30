From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-bisect.sh: don't accidentally override existing branch
	"bisect"
Date: Wed, 30 Apr 2008 16:46:13 +0000
Message-ID: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:47:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrFSa-0005yb-FT
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 18:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937AbYD3QqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 12:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756860AbYD3QqR
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 12:46:17 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59867 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756645AbYD3QqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 12:46:16 -0400
Received: (qmail 28315 invoked by uid 1000); 30 Apr 2008 16:46:13 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80846>

If a branch named "bisect" or "new-bisect" already was created in the
repo by other means than git bisect, doing a git bisect used to override
the branch without a warning.  Now if the branch "bisect" or
"new-bisect" already exists, and it was not created by git bisect itself,
git bisect start fails with an appropriate error message.  Additionally,
if checking out a new bisect state fails due to a merge problem, git
bisect cleans up the temporary branch "new-bisect".

The accidental override has been noticed by Andres Salomon, reported
through
 http://bugs.debian.org/478647

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-bisect.txt |    2 +-
 git-bisect.sh                |   20 ++++++++++++++------
 t/t6030-bisect-porcelain.sh  |   18 ++++++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 698ffde..1c7e38d 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -85,7 +85,7 @@ Oh, and then after you want to reset to the original head, do a
 $ git bisect reset
 ------------------------------------------------
 
-to get back to the master branch, instead of being in one of the
+to get back to the original branch, instead of being in one of the
 bisection branches ("git bisect start" will do that for you too,
 actually: it will reset the bisection state, and before it does that
 it checks that you're not using some old bisection branch).
diff --git a/git-bisect.sh b/git-bisect.sh
index d8d9bfd..48d81d5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -69,14 +69,19 @@ bisect_start() {
 	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref -q HEAD) ||
 	head=$(GIT_DIR="$GIT_DIR" git rev-parse --verify HEAD) ||
 	die "Bad HEAD - I need a HEAD"
+	#
+	# Check that we either already have BISECT_START, or that the
+	# branches bisect, new-bisect don't exist, to not override them.
+	#
+	test -s "$GIT_DIR/BISECT_START" ||
+		if git show-ref bisect > /dev/null ||
+		    git show-ref new-bisect > /dev/null; then
+			die 'The branches "bisect" and "new-bisect" must not exist.'
+		fi
 	start_head=''
 	case "$head" in
 	refs/heads/bisect)
-		if [ -s "$GIT_DIR/BISECT_START" ]; then
-		    branch=`cat "$GIT_DIR/BISECT_START"`
-		else
-		    branch=master
-		fi
+		branch=`cat "$GIT_DIR/BISECT_START"`
 		git checkout $branch || exit
 		;;
 	refs/heads/*|$_x40)
@@ -329,7 +334,10 @@ bisect_next() {
 
 	echo "Bisecting: $bisect_nr revisions left to test after this"
 	git branch -f new-bisect "$bisect_rev"
-	git checkout -q new-bisect || exit
+	git checkout -q new-bisect || {
+		git branch -d new-bisect
+		exit
+	}
 	git branch -M new-bisect bisect
 	git show-branch "$bisect_rev"
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5e3e544..05f1e15 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -284,6 +284,24 @@ test_expect_success 'bisect starting with a detached HEAD' '
 
 '
 
+test_expect_success 'bisect refuses to start if branch bisect exists' '
+	git bisect reset &&
+	git branch bisect &&
+	test_must_fail git bisect start &&
+	git branch -d bisect &&
+	git checkout -b bisect &&
+	test_must_fail git bisect start &&
+	git checkout master &&
+	git branch -d bisect
+'
+
+test_expect_success 'bisect refuses to start if branch new-bisect exists' '
+	git bisect reset &&
+	git branch new-bisect &&
+	test_must_fail git bisect start &&
+	git branch -d new-bisect
+'
+
 #
 #
 test_done
-- 
1.5.5.1
