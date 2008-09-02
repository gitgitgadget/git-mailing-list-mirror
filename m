From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] Documentation: new upstream rebase recovery section in git-rebase
Date: Tue,  2 Sep 2008 22:18:41 +0200
Message-ID: <1220386721-10215-1-git-send-email-trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 22:20:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KacM5-0001wy-LB
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbYIBUSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbYIBUSw
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:18:52 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:54801 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbYIBUSv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:18:51 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Sep 2008 22:18:49 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Sep 2008 22:18:48 +0200
X-Mailer: git-send-email 1.6.0.1.302.g47141
X-OriginalArrivalTime: 02 Sep 2008 20:18:48.0584 (UTC) FILETIME=[1BB3E080:01C90D39]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94701>

Documents how to recover if the upstream that you pull from has
rebased the branches you depend your work on.  Hopefully this can also
serve as a warning to potential rebasers.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I've always found the "warning" on the git-rebase manpage (it's not
even marked as a warning!) a bit weak.

So this is an attempt to solve two problems in one go.  It should be
precise enough to help users understand and recover, but scary enough
to prevent them from doing such rebases in the first place.

I flagged it as RFC because I'd appreciate some feedback:

- Are the warnings too repetitive?  I fear that if we sound too
  protective, users won't listen.

- Is it perhaps too verbose, or in the wrong place?  I did not want to
  detract from the feature descriptions that the manpage should first
  and foremost contain.  Chances that a user will "accidentally" read
  the section at this position and length seem fairly low however.

I've also edited it a fair bit, so chances are that mistakes have
snuck in.

If you like the general direction of this, I'll also make a patch that
points at this section from other rewriting manpages.

- Thomas


 Documentation/git-rebase.txt |   79 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 59c1b02..5e1dc30 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -257,11 +257,12 @@ include::merge-strategies.txt[]
 
 NOTES
 -----
-When you rebase a branch, you are changing its history in a way that
-will cause problems for anyone who already has a copy of the branch
-in their repository and tries to pull updates from you.  You should
+
+As a rule of thumb, rebasing anything that you have published already
+is a bad idea.  It causes problems for people who already have a copy
+of your branch, and are trying to pull updates from you.  You should
 understand the implications of using 'git-rebase' on a repository that
-you share.
+you share.  See also HELP, MY UPSTREAM HAS REBASED! below.
 
 When the git-rebase command is run, it will first execute a "pre-rebase"
 hook if one exists.  You can use this hook to do sanity checks and
@@ -396,6 +397,76 @@ consistent (they compile, pass the testsuite, etc.) you should use
 after each commit, test, and amend the commit if fixes are necessary.
 
 
+HELP, MY UPSTREAM HAS REBASED!
+------------------------------
+
+This section briefly explains the problems that arise from rebasing
+published branches, and shows how to recover.  The process is rather
+tedious, so we emphasize again: 'Avoid rebasing published branches.'
+(The same warning goes for other history rewriting too, for example,
+`git commit --amend` and 'git-filter-branch'.)
+
+To illustrate, suppose you are in a situation where someone develops a
+'subsystem' branch, and you are working on a 'topic' that is dependent
+on this 'subsystem'.  You might end up with a history like the
+following:
+
+------------
+    o---o---o---o---o  master
+	 \
+	  o---o---o---o---o  subsystem
+			   \
+			    *---*---*  topic
+------------
+
+In a push/pull workflow, the maintainer of 'subsystem' would use `git
+merge master` to grab updates from upstream, and you can use the
+analogous `git merge subsystem`.
+
+If 'subsystem' is instead **rebased** against master, the following
+happens:
+
+------------
+    o---o---o---o---o  master
+	|	     \
+	|	      o'--o'--o'--o'--o'  subsystem
+	\
+	 o---o---o---o---o---*---*---*	topic
+------------
+
+Note that while we have marked your own commits with a '*', there is
+nothing that distinguishes them from the commits that previously were
+on 'subsystem'.  You can easily verify this with, for example, `git
+log subsystem..topic` -- which returned only your own commits in the
+scenario of the first graph above, but now has all the commits of the
+old 'subsystem' too!  Furthermore, a potential merge of 'topic' into
+'subsystem' is liable to cause unnecessary conflicts due to the
+duplicated changes.
+
+To recover from this, you need to find the original branch point
+manually, and rebase your topic against the new 'subsystem'.  Since in
+the graph, there are 3 commits that were your own, you can do
+------------
+    git rebase --onto subsystem HEAD~3 topic
+------------
+and end up with the fixed history
+------------
+    o---o---o---o---o  master
+		     \
+		      o'--o'--o'--o'--o'  subsystem
+					\
+					 *'--*'--*'  topic
+------------
+
+`git pull --rebase` (see linkgit:git-pull[1]) can be used to automate
+this process, but only if you use it instead of fetching, so that it
+can use the old upstream head to determine the previous branch point.
+
+The rewriting becomes a ripple effect to developers downstream from
+you (if any): since you now have rebased 'topic', they will have to
+manually rebase their own work to reflect this!
+
+
 Authors
 ------
 Written by Junio C Hamano <gitster@pobox.com> and
-- 
1.6.0.1.302.g47141
