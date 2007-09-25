From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/5] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 16:42:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251642290.28395@racer.site>
References: <Pine.LNX.4.64.0709251640360.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 25 17:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaCZj-0002BO-4c
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 17:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbXIYPnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 11:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbXIYPnl
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 11:43:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:48224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753719AbXIYPnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 11:43:40 -0400
Received: (qmail invoked by alias); 25 Sep 2007 15:43:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 25 Sep 2007 17:43:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199kWwvxlB9IRL+0R1GiM2ywrwo0m3913s4HBv/Qx
	6/cfrChT7osWov
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709251640360.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59139>


When doing an "edit" on a commit, editing and git-adding some files,
"git rebase -i" complained about a missing "author-script".  The idea was
that the user would call "git commit --amend" herself.

But we can be nice and do that for the user.

Noticed by Dmitry Potapov.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    |   17 +++++++++++------
 t/t3404-rebase-interactive.sh |   14 +++++++++++++-
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d2983d1..58f6f28 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -77,15 +77,16 @@ mark_action_done () {
 }
 
 make_patch () {
-	parent_sha1=$(git rev-parse --verify "$1"^ 2> /dev/null)
+	parent_sha1=$(git rev-parse --verify "$1"^) ||
+		die "Cannot get patch for $1^"
 	git diff "$parent_sha1".."$1" > "$DOTEST"/patch
+	test -f "$DOTEST"/message ||
+		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
+	test -f "$DOTEST"/author-script ||
+		get_author_ident_from_commit "$1" > "$DOTEST"/author-script
 }
 
 die_with_patch () {
-	test -f "$DOTEST"/message ||
-		git cat-file commit $sha1 | sed "1,/^$/d" > "$DOTEST"/message
-	test -f "$DOTEST"/author-script ||
-		get_author_ident_from_commit $sha1 > "$DOTEST"/author-script
 	make_patch "$1"
 	die "$2"
 }
@@ -214,6 +215,7 @@ peek_next_command () {
 do_next () {
 	test -f "$DOTEST"/message && rm "$DOTEST"/message
 	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
+	test -f "$DOTEST"/amend && rm "$DOTEST"/amend
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	\#|'')
@@ -233,6 +235,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
+		: > "$DOTEST"/amend
 		warn
 		warn "You can amend the commit now, with"
 		warn
@@ -332,7 +335,9 @@ do
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
1.5.3.2.1057.gf4dc1
