From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v4] user-manual: Add section "Why bisecting merge commits can be harder ..."
Date: Sat, 10 Nov 2007 14:49:54 +0100
Message-ID: <1194702594213-git-send-email-prohaska@zib.de>
References: <B622E814-D7D1-4DC8-A724-666BA0A1220F@zib.de>
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 14:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqqjc-000606-D1
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 14:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbXKJNuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 08:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbXKJNuh
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 08:50:37 -0500
Received: from mailer.zib.de ([130.73.108.11]:59846 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbXKJNug (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 08:50:36 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAADnsQS016413;
	Sat, 10 Nov 2007 14:49:55 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAADnsMY008243;
	Sat, 10 Nov 2007 14:49:54 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <B622E814-D7D1-4DC8-A724-666BA0A1220F@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64348>

This commit adds a discussion of the challenge of bisecting
merge commits to the user manual.  The original author is
Junio C Hamano <gitster@pobox.com>, who posted the text to
the mailing list <http://marc.info/?l=git&m=119403257315527&w=2>.
His email was adapted for the manual.

The discussion is added to "Rewriting history and maintainig
patch series".  The text added requires good understanding of
merging and rebasing.  Therefore it should not be placed too
early in the manual.  Right after the section on "Problems with
rewriting history", the discussion of bisect gives another reason
for linearizing as much of the history as possible.

The text includes suggestions and fixes by
Ralf Wildenhues <Ralf.Wildenhues@gmx.de> and
Benoit Sigoure <tsuna@lrde.epita.fr>.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/user-manual.txt |   98 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)

Since PATCH v3: I moved the section to chapter 5. It's not longer in a separate
section titled "Advance Topics".  I split the paragraph on merge C and
reordered some sentences.  I took part the paragraph on "experienced users"
from Junio's last email.

Junio, you can take ownership of the commit when applying -- if you like.  Most
of the text was written by you. Just mention me as the editor in the commit
message.

    Steffen

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d99adc6..8ddc19f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2554,6 +2554,104 @@ branches into their own work.
 For true distributed development that supports proper merging,
 published branches should never be rewritten.
 
+[[bisect-merges]]
+Why bisecting merge commits can be harder than bisecting linear history
+-----------------------------------------------------------------------
+
+This section discusses how gitlink:git-bisect[1] plays
+with differently shaped histories.  The text is based upon
+an email by Junio C. Hamano to the git mailing list
+(link:http://marc.info/?l=git&m=119403257315527&w=2[link:http://marc.info/?l=git&m=119403257315527&w=2]).
+It was adapted for the user manual.
+
+Using gitlink:git-bisect[1] on a history with merges can be
+challenging.  Bisecting through merges is not a technical
+problem. The real problem is what to do when the culprit turns
+out to be a merge commit.  How to spot what really is wrong, and
+figure out how to fix it.  The problem is not for the tool but
+for the human, and it is real.
+
+Imagine this history:
+
+................................................
+      ---Z---o---X---...---o---A---C---D
+          \                       /
+           o---o---Y---...---o---B
+................................................
+
+Suppose that on the upper development line, the meaning of one
+of the functions that existed at Z was changed at commit X.  The
+commits from Z leading to A change both the function's
+implementation and all calling sites that existed at Z, as well
+as new calling sites they add, to be consistent.  There is no
+bug at A.
+
+Suppose that in the meantime the lower development line somebody
+added a new calling site for that function at commit Y.  The
+commits from Z leading to B all assume the old semantics of that
+function and the callers and the callee are consistent with each
+other.  There is no bug at B, either.
+
+Suppose further that the two development lines were merged at C
+and there was no textual conflict with this three way merge.
+The result merged cleanly.
+
+Now, during bisect you find that the merge C is broken.  You
+started to bisect, because you found D is bad and you know Z was
+good.  The breakage is understandable, as at C, the new calling
+site of the function added by the lower branch is not converted
+to the new semantics, while all the other calling sites that
+already existed at Z would have been converted by the merge.  The
+new calling site has semantic adjustment needed, but you do not
+know that yet.
+
+You need to find out what is the cause of the breakage by looking
+at the merge commit C and the history leading to it.  How would
+you do that?
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
+On the other hand, if you did not merge at C but rebased the
+history between Z to B on top of A, you would have get this
+linear history:
+
+................................................................
+    ---Z---o---X--...---o---A---o---o---Y*--...---o---B*--D*
+................................................................
+
+Bisecting between Z and D* would hit a single culprit commit Y*
+instead.  This tends to be easier to understand why it is broken.
+
+For this reason, many experienced git users, even when they are
+working on an otherwise merge-heavy project, keep the histories
+linear by rebasing their work on top of public upstreams before
+publishing.
+
+But if you already made a merge C instead of rebasing, all
+is not lost.  In the illustrated case, you can easily rebase
+one parent branch on top of the other after the fact, just
+to understand the history and to make the history more
+easily to bisect.  Even though the published history should
+not be rewound without consent with others in the project,
+nobody gets hurt if you rebased to create alternate history
+privately.  After understanding the breakage and coming up
+with a fix on top of D*, you can discard that rebased
+history, and apply the same fix on top of D, as D* and D
+should have the identical trees.
+
 [[advanced-branch-management]]
 Advanced branch management
 ==========================
-- 
1.5.3.5.578.g886d
