From: Steffen Prohaska <prohaska@zib.de>
Subject: [RFC 1/4] Add diff-diff, which compares the diffs of two commits
Date: Sat, 15 Dec 2007 17:51:42 +0100
Message-ID: <1197737505128-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 17:52:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3aFK-0000ng-PF
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 17:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbXLOQvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 11:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbXLOQvx
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 11:51:53 -0500
Received: from mailer.zib.de ([130.73.108.11]:44315 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144AbXLOQvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 11:51:48 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBFGpjeu006055
	for <git@vger.kernel.org>; Sat, 15 Dec 2007 17:51:46 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBFGpj9C029051;
	Sat, 15 Dec 2007 17:51:45 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68396>

The following patch series adds experimental diff-diff support.
It adds a very basic command line version and experimental gitk
support for displaying the differences between the patches
associated with two commits.

"git diff-diff commit1 commit2" displays the differences between
the changes introduced by commit1 and commit2.  This is displayed
as a unified diff between the two patches.

In gitk you can select one commit, right click on a second
commit, and select "Diff Diff selected -> this" to display the
changes between the patches for the two commits.  Highlighting
of the result could certainly be improved.  But it is already
kind of helpful.

This can, for example, be used to compare a first version of a
patch with an improved version of the same patch.  In this case
it is helpful to display the difference between the patches (not
the files changed).  If you commented on the first version, you
may just want to check if the original author improved the patch
according to your comments.

At this point, I'm only seeking comments about the general direction.
The patches should not be applied to git.git.

 - Do you think something like this would be helpful?
 - Are similar approaches already available?
 - How do you use git to support code review; besides discussing
   patches on mailing lists?

    Steffen

---
 Makefile         |    3 ++-
 git-diff-diff.sh |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)
 create mode 100755 git-diff-diff.sh

diff --git a/Makefile b/Makefile
index b9fe40b..2e015ad 100644
--- a/Makefile
+++ b/Makefile
@@ -227,7 +227,8 @@ SCRIPT_SH = \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
 	git-stash.sh \
-	git-browse--help.sh
+	git-browse--help.sh \
+	git-diff-diff.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/git-diff-diff.sh b/git-diff-diff.sh
new file mode 100755
index 0000000..aa402b2
--- /dev/null
+++ b/git-diff-diff.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git-diff-diff <commit> <commit>
+--
+"
+
+. git-sh-setup
+require_work_tree
+
+[ $# = 3 ] || usage
+
+from=$(git rev-parse --verify $2) || exit
+to=$(git rev-parse --verify $3) || exit
+
+git show $from >.git-commit-$from
+git show $to >.git-commit-$to
+
+diff -u .git-commit-$from .git-commit-$to
+
+rm .git-commit-$from .git-commit-$to
-- 
1.5.4.rc0.37.geff3a-dirty
