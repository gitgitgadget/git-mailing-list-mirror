From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: ignore patches that are in upstream already
Date: Wed, 1 Aug 2007 15:59:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011505010.14781@racer.site>
References: <46B06E56.2040206@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 17:00:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGFgS-0003YY-2y
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 17:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbXHAPAB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 11:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbXHAPAB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 11:00:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:52752 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932232AbXHAPAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 11:00:00 -0400
Received: (qmail invoked by alias); 01 Aug 2007 14:59:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 01 Aug 2007 16:59:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OeiwgJQOObhDY7XxXWjKt4yQ98NARgA59TSFj60
	ymW68f7o16oFg9
X-X-Sender: gene099@racer.site
In-Reply-To: <46B06E56.2040206@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54442>


Non-interactive rebase had this already, exploiting format-patch's option
--ignore-if-in-upstream.  We replicate the same behaviour here with
--cherry-pick.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 1 Aug 2007, Mark Levedahl wrote:

	> git rebase -i does not correctly ignore commits in the local 
	> branch that are also in upstream. For example, create a branch 
	> that is two commits back from upstream, add one of those on to 
	> the local branch
	> 
	> upstream=83b3df7d58
	> git checkout -f $upstream
	> git checkout -b foo $upstream~2
	> git cherry-pick $upstream~1
	> git rebase -i  $upstream
	> 
	> "git rebase -i" happily presents commit "$upstream~1" in the 
	> list to be applied to upstream. This of course results in a 
	> conflict. Should the user simply delete the offending commit 
	> from the presented list, git rebase -i then refuses to do 
	> anything, saying "Nothing to do."
	> 
	> Bare "git rebase" handles this case correctly (essentially fast 
	> forwards the branch to upstream.

	Right.

 git-rebase--interactive.sh    |    5 +++--
 t/t3404-rebase-interactive.sh |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 061cd0a..d3addd4 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -463,8 +463,9 @@ do
 #
 EOF
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse $UPSTREAM..$HEAD | \
-			sed "s/^/pick /" >> "$TODO"
+			--abbrev=7 --reverse --left-right --cherry-pick \
+			$UPSTREAM...$HEAD | \
+			sed -n "s/^>/pick /p" >> "$TODO"
 
 		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
 			die_abort "Nothing to do"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 817f614..dc436d7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -68,6 +68,9 @@ test "\$1" = .git/COMMIT_EDITMSG && {
 	test -z "\$FAKE_COMMIT_AMEND" || echo "\$FAKE_COMMIT_AMEND" >> "\$1"
 	exit
 }
+test -z "\$EXPECT_COUNT" ||
+	test "\$EXPECT_COUNT" = \$(grep -ve "^#" -e "^$" < "\$1" | wc -l) ||
+	exit
 test -z "\$FAKE_LINES" && exit
 grep -v "^#" < "\$1" > "\$1".tmp
 rm "\$1"
@@ -251,4 +254,16 @@ test_expect_success 'interrupted squash works as expected' '
 	test $one = $(git rev-parse HEAD~2)
 '
 
+test_expect_success 'ignore patch if in upstream' '
+	HEAD=$(git rev-parse HEAD) &&
+	git checkout -b has-cherry-picked HEAD^ &&
+	echo unrelated > file7 &&
+	git add file7 &&
+	test_tick &&
+	git commit -m "unrelated change" &&
+	git cherry-pick $HEAD &&
+	EXPECT_COUNT=1 git rebase -i $HEAD &&
+	test $HEAD = $(git rev-parse HEAD^)
+'
+
 test_done
-- 
1.5.3.rc3.112.gf60b6
