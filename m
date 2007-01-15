From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use merge-recursive in git-revert/git-cherry-pick
Date: Sun, 14 Jan 2007 22:00:02 -0800
Message-ID: <7vk5zoesnx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 15 20:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vhx-0006Y8-II
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:21 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V91-0003eK-EC
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXAOGAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 01:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbXAOGAF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 01:00:05 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62147 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbXAOGAE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 01:00:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070115060003.CLEQ3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Mon, 15 Jan 2007 01:00:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id BJ0K1W00Q1kojtg0000000; Mon, 15 Jan 2007 01:00:19 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36866>

This makes revert and cherry-pick to use merge-recursive, to
allow them to notice renames.  A pair of test scripts
demonstrate that an old change before a rename happened can be
applied (reverted) after a rename with cherry-pick (with revert).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-revert.sh                 |   29 ++++++++-----------
 t/t3501-revert-cherry-pick.sh |   62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/git-revert.sh b/git-revert.sh
index 71cbcbc..c74af99 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -151,32 +151,27 @@ esac >.msg
 # and $prev on top of us (when reverting), or the change between
 # $prev and $commit on top of us (when cherry-picking or replaying).
 
-echo >&2 "First trying simple merge strategy to $me."
-git-read-tree -m -u --aggressive $base $head $next &&
+git-merge-recursive $base -- $head $next &&
 result=$(git-write-tree 2>/dev/null) || {
-    echo >&2 "Simple $me fails; trying Automatic $me."
-    git-merge-index -o git-merge-one-file -a || {
-	    mv -f .msg "$GIT_DIR/MERGE_MSG"
-	    {
-		echo '
+	mv -f .msg "$GIT_DIR/MERGE_MSG"
+	{
+	    echo '
 Conflicts:
 '
 		git ls-files --unmerged |
 		sed -e 's/^[^	]*	/	/' |
 		uniq
-	    } >>"$GIT_DIR/MERGE_MSG"
-	    echo >&2 "Automatic $me failed.  After resolving the conflicts,"
-	    echo >&2 "mark the corrected paths with 'git-add <paths>'"
-	    echo >&2 "and commit the result."
-	    case "$me" in
-	    cherry-pick)
+	} >>"$GIT_DIR/MERGE_MSG"
+	echo >&2 "Automatic $me failed.  After resolving the conflicts,"
+	echo >&2 "mark the corrected paths with 'git-add <paths>'"
+	echo >&2 "and commit the result."
+	case "$me" in
+	cherry-pick)
 		echo >&2 "You may choose to use the following when making"
 		echo >&2 "the commit:"
 		echo >&2 "$set_author_env"
-	    esac
-	    exit 1
-    }
-    result=$(git-write-tree) || exit
+	esac
+	exit 1
 }
 echo >&2 "Finished one $me."
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
new file mode 100755
index 0000000..552af1c
--- /dev/null
+++ b/t/t3501-revert-cherry-pick.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='test cherry-pick and revert with renames
+
+  --
+   + rename2: renames oops to opos
+  +  rename1: renames oops to spoo
+  +  added:   adds extra line to oops
+  ++ initial: has lines in oops
+
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	for l in a b c d e f g h i j k l m n o
+	do
+		echo $l$l$l$l$l$l$l$l$l
+	done >oops &&
+
+	test_tick &&
+	git add oops &&
+	git commit -m initial &&
+	git tag initial &&
+
+	test_tick &&
+	echo "Add extra line at the end" >>oops &&
+	git commit -a -m added &&
+	git tag added &&
+
+	test_tick &&
+	git mv oops spoo &&
+	git commit -m rename1 &&
+	git tag rename1 &&
+
+	test_tick &&
+	git checkout -b side initial &&
+	git mv oops opos &&
+	git commit -m rename2 &&
+	git tag rename2
+'
+
+test_expect_success 'cherry-pick after renaming branch' '
+
+	git checkout rename2 &&
+	EDITOR=: VISUAL=: git cherry-pick added &&
+	test -f opos &&
+	grep "Add extra line at the end" opos
+
+'
+
+test_expect_success 'revert after renaming branch' '
+
+	git checkout rename1 &&
+	EDITOR=: VISUAL=: git revert added &&
+	test -f spoo &&
+	! grep "Add extra line at the end" spoo
+
+'
+
+test_done
-- 
1.5.0.rc1.gf4b6c
