From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: commit when continuing after "edit"
Date: Mon, 24 Sep 2007 01:29:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709240121080.28395@racer.site>
References: <20070923224502.GB7249@potapov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 02:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbqR-0004rj-AY
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 02:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbXIXAad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 20:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbXIXAac
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 20:30:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:57929 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752950AbXIXAab (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 20:30:31 -0400
Received: (qmail invoked by alias); 24 Sep 2007 00:30:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 24 Sep 2007 02:30:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ASylCvbMAvxBXxF4EHL4c3UTzHiCCqAcSGxMXzJ
	ko8TtHBgmnCYLw
X-X-Sender: gene099@racer.site
In-Reply-To: <20070923224502.GB7249@potapov>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59009>


When doing an "edit" on a commit, editing and git-adding some files,
"git rebase -i" complained about a missing "author-script".  The idea was 
that the user would call "git commit --amend" herself.

But we can be nice and do that for the user.

To do this, rebase -i stores the author script and message whenever 
writing out a patch, and it remembers to do an "amend" by creating the 
file "amend" in "$DOTEST".

Noticed by Dmitry Potapov.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 24 Sep 2007, Dmitry Potapov wrote:

	> I have tried to use git-rebase --interactive today, and run into 
	> a strange error message saying:
	> 
	> /usr/bin/git-rebase--interactive: \
	>	line 333: $GIT_DIR/.dotest-merge/author-script: \
	>		No such file or directory

	Could you please apply this patch and try if the issue is gone?

	The patch looks a bit strange, because some code moved from 
	die_with_patch() to make_patch(), and the diff makes it look like 
	the end of the function moved instead.

	Funnily enough we discussed human readable diffs briefly on #git
	today, but I think even the best diff algorithms could not catch 
	that.

 git-rebase--interactive.sh    |   12 ++++++++----
 t/t3404-rebase-interactive.sh |   14 +++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8258b7a..e4cf282 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -79,13 +79,13 @@ mark_action_done () {
 make_patch () {
 	parent_sha1=$(git rev-parse --verify "$1"^ 2> /dev/null)
 	git diff "$parent_sha1".."$1" > "$DOTEST"/patch
-}
-
-die_with_patch () {
 	test -f "$DOTEST"/message ||
 		git cat-file commit $sha1 | sed "1,/^$/d" > "$DOTEST"/message
 	test -f "$DOTEST"/author-script ||
 		get_author_ident_from_commit $sha1 > "$DOTEST"/author-script
+}
+
+die_with_patch () {
 	make_patch "$1"
 	die "$2"
 }
@@ -214,6 +214,7 @@ peek_next_command () {
 do_next () {
 	test -f "$DOTEST"/message && rm "$DOTEST"/message
 	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
+	test -f "$DOTEST"/amend && rm "$DOTEST"/amend
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	\#|'')
@@ -233,6 +234,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
+		: > "$DOTEST"/amend
 		warn
 		warn "You can amend the commit now, with"
 		warn
@@ -332,7 +334,9 @@ do
 		git update-index --refresh &&
 		git diff-files --quiet &&
 		! git diff-index --cached --quiet HEAD &&
-		. "$DOTEST"/author-script &&
+		. "$DOTEST"/author-script && {
+			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
+		} &&
 		export GIT_AUTHOR_NAME GIT_AUTHOR_NAME GIT_AUTHOR_DATE &&
 		git commit -F "$DOTEST"/message -e
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 718c9c1..1af73a4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -80,7 +80,7 @@ cat "$1".tmp
 action=pick
 for line in $FAKE_LINES; do
 	case $line in
-	squash)
+	squash|edit)
 		action="$line";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
@@ -297,4 +297,16 @@ test_expect_success 'ignore patch if in upstream' '
 	test $HEAD = $(git rev-parse HEAD^)
 '
 
+test_expect_success '--continue tries to commit, even for "edit"' '
+	parent=$(git rev-parse HEAD^) &&
+	test_tick &&
+	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+	echo edited > file7 &&
+	git add file7 &&
+	FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue &&
+	test edited = $(git show HEAD:file7) &&
+	git show HEAD | grep chouette &&
+	test $parent = $(git rev-parse HEAD^)
+'
+
 test_done
-- 
1.5.3.2.1039.g855b8
