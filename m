From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] user-manual: add advanced topic "bisecting merges"
Date: Sun,  4 Nov 2007 10:16:13 +0100
Message-ID: <11941677732664-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 10:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IobeD-0003un-4J
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbXKDJTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 04:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbXKDJTq
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:19:46 -0500
Received: from mailer.zib.de ([130.73.108.11]:64305 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143AbXKDJTo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 04:19:44 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA49GDao019881
	for <git@vger.kernel.org>; Sun, 4 Nov 2007 10:19:42 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA49GDFW001408;
	Sun, 4 Nov 2007 10:16:13 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63367>

This commits adds a discussion of the challenge of bisecting
merge commits to the user manual. The text is slightly
adapted from a mail by Junio C Hamano <gitster@pobox.com>
to the mailing list
<http://marc.info/?l=git&m=119403257315527&w=2>.

The discussion is added to "Exploring git history" in a
sub-section titled "Advanced topics". The discussion requires
detailed knowledge about git. It is assumed that the reader will
skip advanced topics on first reading. At least the text suggest
to do so.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/user-manual.txt |   89 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

Junio's discussion was enlightening for me. I think it's a good idea to add
such discussions to the user manual. It was not obvious to me where to place
the discussion in the current structure of the manual. So I added "Advanced
topics".

Is a sub-section "Advanced topics" a good idea? Any better suggestions?

    Steffen

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d99adc6..480e7c1 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -934,6 +934,95 @@ Figuring out why this works is left as an exercise to the (advanced)
 student.  The gitlink:git-log[1], gitlink:git-diff-tree[1], and
 gitlink:git-hash-object[1] man pages may prove helpful.
 
+[[history-advanced-topics]]
+Advanced topics
+---------------
+This section covers advanced topics that typically require more
+knowledge about git than the manual presented to this point.
+
+You may want to skip the section at first reading, and come back
+later when you have a better understanding of git.
+
+[[bisect-merges]]
+Why bisecting merge commits can be harder than bisecting linear history
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The following text is based upon an email by Junio C. Hamano to
+the git mailing list
+(link:http://marc.info/?l=git&m=119403257315527&w=2[link:http://marc.info/?l=git&m=119403257315527&w=2]).
+It was slightly adapted for this manual.
+
+Bisecting merges can be challenging due to the complexity of
+changes introduced at a merge.  Bisecting through merges is not a
+technical problem. The real problem is what to do when the
+culprit turns out to be a merge commit.  How to spot what really
+is wrong, and figure out how to fix.  The problem is not for the
+tool but for the human, and it is real.
+
+Imagine this history.
+
+................................................
+      ---Z---o---X---...---o---A---C---D
+          \                       /
+           o---o---Y---...---o---B
+................................................
+
+Suppose that on the upper development line, the meaning of one
+of the functions existed at Z was changed at commit X.  The
+commits from Z leading to A change both the function's
+implementation and all calling sites that existed at Z, as well
+as new calling sites they add, to be consistent.  There is no
+bug at A.
+
+Suppose in the meantime the lower development line somebody
+added a new calling site for that function at commit Y.  The
+commits from Z leading to B all assume the old semantics of that
+function and the callers and the callee are consistent with each
+other.  There is no bug at B, either.
+
+You merge to create C.  There is no textual conflict with this
+three way merge, and the result merges cleanly.  You bisect
+this, because you found D is bad and you know Z was good.  Your
+bisect will find that C (merge) is broken.  Understandably so,
+as at C, the new calling site of the function added by the lower
+branch is not converted to the new semantics, while all the
+other calling sites that already existed at Z would have been
+converted by the merge.  The new calling site has semantic
+adjustment needed, but you do not know that yet.  You need to
+find out that is the cause of the breakage by looking at the
+merge commit C and the history leading to it.
+
+How would you do that?
+
+Both "git diff A C" and "git diff B C" would be an enormous patch.
+Each of them essentially shows the whole change on each branch
+since they diverged.  The developers may have well behaved to
+create good commits that follow the "commit small, commit often,
+commit well contained units" mantra, and each individual commit
+leading from Z to A and from Z to B may be easy to review and
+understand, but looking at these small and easily reviewable
+steps alone would not let you spot the breakage.  You need to
+have a global picture of what the upper branch did (and
+among many, one of them is to change the semantics of that
+particular function) and look first at the huge "diff A C"
+(which shows the change the lower branch introduces), and see if
+that huge change is consistent with what have been done between
+Z and A.
+
+If you linearlize the history by rebasing the lower branch on
+top of upper, instead of merging, the bug becomes much easier to
+find and understand.  Your history would instead be:
+
+................................................................
+    ---Z---o---X--...---o---A---o---o---Y*--...---o---B*--D*
+................................................................
+
+and there is a single commit Y* between A and B* that introduced
+the new calling site that still uses the old semantics of the
+function, even though that was already modified at X. "git show
+Y*" will be a much smaller patch than "git diff A C" and it is
+much easier to deal with.
+
+
 [[Developing-with-git]]
 Developing with git
 ===================
-- 
1.5.3.4.464.ge1bc2
