From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Add more checkout tests
Date: Sun, 9 Dec 2007 22:05:34 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712092204200.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 10 04:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Yxz-0006SG-3i
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 04:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXLJDFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 22:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbXLJDFg
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 22:05:36 -0500
Received: from iabervon.org ([66.92.72.58]:35747 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbXLJDFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 22:05:35 -0500
Received: (qmail 13586 invoked by uid 1000); 10 Dec 2007 03:05:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2007 03:05:34 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67672>

If you have local changes that don't conflict with the
branch-switching changes, these should be kept, not cause errors even
without -m, and be reported afterwards in name-status format.

With -m, the changes carried across should be listed as well. And, for 
now, include the merge-recursive output from this process.

Also test the detatched head message in at least one case.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 t/t7201-co.sh |   46 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 55558ab..3cf0cf1 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -20,6 +20,8 @@ Test switching across them.
 
 . ./test-lib.sh
 
+test_tick
+
 fill () {
 	for i
 	do
@@ -30,9 +32,10 @@ fill () {
 
 test_expect_success setup '
 
+	fill x y z > same &&
 	fill 1 2 3 4 5 6 7 8 >one &&
 	fill a b c d e >two &&
-	git add one two &&
+	git add same one two &&
 	git commit -m "Initial A one, A two" &&
 
 	git checkout -b renamer &&
@@ -74,16 +77,44 @@ test_expect_success "checkout with dirty tree without -m" '
 
 '
 
+test_expect_success "checkout with unrelated dirty tree without -m" '
+
+	git checkout -f master &&
+	fill 0 1 2 3 4 5 6 7 8 >same &&
+	cp same kept
+	git checkout side >messages && 
+	git diff same kept
+	(cat > messages.expect <<EOF
+M	same
+EOF
+) &&
+	touch messages.expect &&
+	git diff messages.expect messages
+'
+
 test_expect_success "checkout -m with dirty tree" '
 
 	git checkout -f master &&
 	git clean -f &&
 
 	fill 0 1 2 3 4 5 6 7 8 >one &&
-	git checkout -m side &&
+	git checkout -m side > messages &&
 
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
+	(cat >expect.messages <<EOF
+Merging side with local
+Merging:
+ab76817 Side M one, D two, A three
+virtual local
+found 1 common ancestor(s):
+7329388 Initial A one, A two
+Auto-merged one
+M	one
+EOF
+) &&
+	git diff expect.messages messages &&
+
 	fill "M	one" "A	three" "D	two" >expect.master &&
 	git diff --name-status master >current.master &&
 	diff expect.master current.master &&
@@ -145,7 +176,16 @@ test_expect_success 'checkout -m with merge conflict' '
 test_expect_success 'checkout to detach HEAD' '
 
 	git checkout -f renamer && git clean -f &&
-	git checkout renamer^ &&
+	git checkout renamer^ 2>messages &&
+	(cat >messages.expect <<EOF
+Note: moving to "renamer^" which isn'"'"'t a local branch
+If you want to create a new branch from this checkout, you may do so
+(now or later) by using -b with the checkout command again. Example:
+  git checkout -b <new_branch_name>
+HEAD is now at 7329388... Initial A one, A two
+EOF
+) &&
+	git diff messages.expect messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
-- 
1.5.3.6.886.gb204
