From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 2/9] user-manual: Reorganize the reroll sections,
 adding 'git rebase -i'
Date: Sun, 17 Feb 2013 19:15:54 -0500
Message-ID: <31c45d95acaf062428f171c33c4c164d80b4becb.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:17:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EQ7-0000ml-0o
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab3BRAQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:31 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:44899 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3BRAQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:29 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE00JKM3EV2080@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:08 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 39670885654; Sun,
 17 Feb 2013 19:16:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146567; bh=5CQOqwBk+beQn/JGycJRFM4UbOCHctENbcgkcKq+7t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=LPvCk12WJiWCU4pxjWy5iAJmwLiq1QhsyqlWpJjglTM1/qh2LZhxk8/mpPQ5Twndx
 RuWzOhzYqp/t12Ytrt5E6sHjGEJ8wDe0IleY9majtZSlW9qrMn3qxb6knTPmssYV3O
 Uo4UJZv14r9HxOURFAqHasNdWz1t4nZAKi3wcwy8=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216415>

From: "W. Trevor King" <wking@tremily.us>

I think this interface is often more convenient than extended cherry
picking or using 'git format-patch'.  In fact, I removed the
cherry-pick section entirely.  The entry-level suggestions for
rerolling are now:

1. git commit --amend
2. git format-patch origin
   git reset --hard origin
   ...edit and reorder patches...
   git am *.patch
3. git rebase -i origin

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 110 ++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 47 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a060eb6..dbffd0a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2538,6 +2538,12 @@ return mywork to the state it had before you started the rebase:
 $ git rebase --abort
 -------------------------------------------------
 
+If you need to reorder or edit a number of commits in a branch, it may
+be easier to use `git rebase -i`, which allows you to reorder and
+squash commits, as well as marking them for individual editing during
+the rebase.  See <<interactive-rebase>> for details, and
+<<reordering-patch-series>> for alternatives.
+
 [[rewriting-one-commit]]
 Rewriting a single commit
 -------------------------
@@ -2552,71 +2558,81 @@ $ git commit --amend
 which will replace the old commit by a new commit incorporating your
 changes, giving you a chance to edit the old commit message first.
 
-You can also use a combination of this and linkgit:git-rebase[1] to
-replace a commit further back in your history and recreate the
-intervening changes on top of it.  First, tag the problematic commit
-with
-
--------------------------------------------------
-$ git tag bad mywork~5
--------------------------------------------------
-
-(Either gitk or `git log` may be useful for finding the commit.)
+[[reordering-patch-series]]
+Reordering or selecting from a patch series
+-------------------------------------------
 
-Then check out that commit, edit it, and rebase the rest of the series
-on top of it (note that we could check out the commit on a temporary
-branch, but instead we're using a <<detached-head,detached head>>):
+Sometimes you want to edit a commit deeper in your history.  One
+approach is to use `git format-patch` to create a series of patches,
+then reset the state to before the patches:
 
 -------------------------------------------------
-$ git checkout bad
-$ # make changes here and update the index
-$ git commit --amend
-$ git rebase --onto HEAD bad mywork
+$ git format-patch origin
+$ git reset --hard origin
 -------------------------------------------------
 
-When you're done, you'll be left with mywork checked out, with the top
-patches on mywork reapplied on top of your modified commit.  You can
-then clean up with
+Then modify, reorder, or eliminate patches as preferred before applying
+them again with linkgit:git-am[1]:
 
 -------------------------------------------------
-$ git tag -d bad
+$ git am *.patch
 -------------------------------------------------
 
-Note that the immutable nature of Git history means that you haven't really
-"modified" existing commits; instead, you have replaced the old commits with
-new commits having new object names.
+[[interactive-rebase]]
+Using interactive rebases
+-------------------------
 
-[[reordering-patch-series]]
-Reordering or selecting from a patch series
--------------------------------------------
+You can also edit a patch series with an interactive rebase.  This is
+the same as <<reordering-patch-series,reordering a patch series using
+`format-patch`>>, so use whichever interface you like best.
 
-Given one existing commit, the linkgit:git-cherry-pick[1] command
-allows you to apply the change introduced by that commit and create a
-new commit that records it.  So, for example, if "mywork" points to a
-series of patches on top of "origin", you might do something like:
+Rebase your current HEAD on the last commit you want to retain as-is.
+For example, if you want to reorder the last 5 commits, use:
 
 -------------------------------------------------
-$ git checkout -b mywork-new origin
-$ gitk origin..mywork &
+$ git rebase -i HEAD~5
 -------------------------------------------------
 
-and browse through the list of patches in the mywork branch using gitk,
-applying them (possibly in a different order) to mywork-new using
-cherry-pick, and possibly modifying them as you go using `git commit --amend`.
-The linkgit:git-gui[1] command may also help as it allows you to
-individually select diff hunks for inclusion in the index (by
-right-clicking on the diff hunk and choosing "Stage Hunk for Commit").
-
-Another technique is to use `git format-patch` to create a series of
-patches, then reset the state to before the patches:
+This will open your editor with a list of the commits you're rebasing
 
 -------------------------------------------------
-$ git format-patch origin
-$ git reset --hard origin
--------------------------------------------------
+pick deadbee The oneline of this commit
+pick fa1afe1 The oneline of the next commit
+...
 
-Then modify, reorder, or eliminate patches as preferred before applying
-them again with linkgit:git-am[1].
+# Rebase c0ffeee..deadbee onto c0ffeee
+#
+# Commands:
+#  p, pick = use commit
+#  r, reword = use commit, but edit the commit message
+#  e, edit = use commit, but stop for amending
+#  s, squash = use commit, but meld into previous commit
+#  f, fixup = like "squash", but discard this commit's log message
+#  x, exec = run command (the rest of the line) using shell
+#
+# These lines can be re-ordered; they are executed from top to bottom.
+#
+# If you remove a line here THAT COMMIT WILL BE LOST.
+#
+# However, if you remove everything, the rebase will be aborted.
+#
+# Note that empty commits are commented out
+-------------------------------------------------
+
+As explained in the comments, you can reorder commits, squash them
+together, edit commit messages, etc. by editing the list.  Once you
+are satisfied, save the list and close your editor, and the rebase
+will begin.
+
+The rebase will stop when `pick` has been replaced with `edit` or when
+a command fails due to merge errors. When you are done editing and/or
+resolving conflicts you can continue with `git rebase --continue`.  If
+you decide that things are getting too hairy, you can always bail out
+with `git rebase --abort`.  Even after the rebase is complete, you can
+still recover the original branch by using the <<reflogs,reflog>>.
+
+For a more detailed discussion of the procedure and additional tips,
+see the "INTERACTIVE MODE" section of linkgit:git-rebase[1].
 
 [[patch-series-tools]]
 Other tools
-- 
1.8.1.336.g94702dd
