From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 1/3] user-manual: Reorganize the reroll sections,
 adding 'git rebase -i'
Date: Tue, 19 Feb 2013 05:05:00 -0500
Message-ID: <e9f8a25c05f9cfe89c6bcbefb69f40cd629f9925.1361267945.git.wking@tremily.us>
References: <20130219093429.GA4024@odin.tremily.us>
 <cover.1361267945.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:05:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7k5D-0004sb-0u
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758645Ab3BSKFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:05:25 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:49863 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758297Ab3BSKFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:05:21 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00IC3PCL0O80@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 04:05:10 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 459B28ABA07; Tue,
 19 Feb 2013 05:05:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361268309; bh=B74fqY/o/pb0ODjoSm563y/99sj+9NiqL6qB5ouYHhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=kXrtiGFbL4aUsaz2j91v9spYd2MNV+f1KX7hciCF5HgN3Q8A3+4REQpNQCrc9+VU2
 03Ve9hF8hDN1Yus+NVQ3QWEyMMCytC2+8ti50IMbrj9sm99S4WK+VOx3JRy3MM+c9x
 Io+2g5ycYnF29Hx5Rx028IEBY3Ztv9UXsfWybtPk=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361267945.git.wking@tremily.us>
In-reply-to: <cover.1361267945.git.wking@tremily.us>
References: <cover.1361267945.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216594>

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
 Documentation/user-manual.txt | 115 +++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 46 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 52c8523..a4dbd9e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2556,6 +2556,12 @@ return mywork to the state it had before you started the rebase:
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
@@ -2569,72 +2575,89 @@ $ git commit --amend
 
 which will replace the old commit by a new commit incorporating your
 changes, giving you a chance to edit the old commit message first.
+This is useful for fixing typos in your last commit, or for adjusting
+the patch contents of a poorly staged commit.
 
-You can also use a combination of this and linkgit:git-rebase[1] to
-replace a commit further back in your history and recreate the
-intervening changes on top of it.  First, tag the problematic commit
-with
-
--------------------------------------------------
-$ git tag bad mywork~5
--------------------------------------------------
+If you need to amend commits from deeper in your history, you should
+use <<interactive-rebase,interactive rebase's `edit` instruction>>.
 
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
+Then modify, reorder, or eliminate patches as needed before applying
+them again with linkgit:git-am[1]:
 
 -------------------------------------------------
-$ git tag -d bad
+$ git am *.patch
 -------------------------------------------------
 
-Note that the immutable nature of git history means that you haven't really
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
+This will open your editor with a list of steps to be taken to perform
+your rebase.
 
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
+The rebase will stop where `pick` has been replaced with `edit` or
+when a step in the list fails to mechanically resolve conflicts and
+needs your help.  When you are done editing and/or resolving conflicts
+you can continue with `git rebase --continue`.  If you decide that
+things are getting too hairy, you can always bail out with `git rebase
+--abort`.  Even after the rebase is complete, you can still recover
+the original branch by using the <<reflogs,reflog>>.
+
+For a more detailed discussion of the procedure and additional tips,
+see the "INTERACTIVE MODE" section of linkgit:git-rebase[1].
 
 [[patch-series-tools]]
 Other tools
-- 
1.8.1.336.g94702dd
