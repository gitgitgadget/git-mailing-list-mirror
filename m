From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH amend] git-bisect.sh: don't accidentally override existing
	branch "bisect"
Date: Mon, 5 May 2008 07:43:00 +0000
Message-ID: <20080505074300.5555.qmail@11d6801606c1fe.315fe32.mid.smarden.org>
References: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org> <200804302330.18354.chriscool@tuxfamily.org> <20080502085620.3361.qmail@17e811992e6d42.315fe32.mid.smarden.org> <200805031042.32190.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 05 09:43:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsvMY-0002VQ-Oh
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 09:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbYEEHnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 03:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbYEEHnG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 03:43:06 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:41067 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753548AbYEEHnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 03:43:05 -0400
Received: (qmail 5556 invoked by uid 1000); 5 May 2008 07:43:00 -0000
Content-Disposition: inline
In-Reply-To: <200805031042.32190.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

On Sat, May 03, 2008 at 10:42:31AM +0200, Christian Couder wrote:
> Le vendredi 2 mai 2008, Gerrit Pape a ?crit :
> > -   git branch -f new-bisect "$bisect_rev"
> > -   git checkout -q new-bisect || exit
> > +   git branch -D new-bisect
> 
> Doesn't this output an error if the branch "new-bisect" does not
> exists ?

It does, thanks.  Another amend, direct stderr to /dev/null.


 Documentation/git-bisect.txt |    2 +-
 git-bisect.sh                |   19 ++++++++++++-------
 t/t6030-bisect-porcelain.sh  |   18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 8 deletions(-)

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
index d8d9bfd..b5171c9 100755
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
+		if git show-ref --verify -q refs/heads/bisect ||
+		    git show-ref --verify -q refs/heads/new-bisect; then
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
@@ -328,8 +333,8 @@ bisect_next() {
 	exit_if_skipped_commits "$bisect_rev"
 
 	echo "Bisecting: $bisect_nr revisions left to test after this"
-	git branch -f new-bisect "$bisect_rev"
-	git checkout -q new-bisect || exit
+	git branch -D new-bisect 2> /dev/null
+	git checkout -q -b new-bisect "$bisect_rev" || exit
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
