From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] Documentation: new upstream rebase recovery section in git-rebase
Date: Thu, 11 Sep 2008 17:38:44 +0200
Message-ID: <1221147525-5589-2-git-send-email-trast@student.ethz.ch>
References: <200809030738.09589.trast@student.ethz.ch>
 <1221147525-5589-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 17:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdoHe-0005YK-58
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 17:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbYIKPi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 11:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755495AbYIKPi5
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 11:38:57 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24730 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755453AbYIKPiy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 11:38:54 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 17:38:51 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Sep 2008 17:38:50 +0200
X-Mailer: git-send-email 1.6.0.1.470.g200b
In-Reply-To: <1221147525-5589-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Sep 2008 15:38:50.0986 (UTC) FILETIME=[7D4594A0:01C91424]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95612>

Documents how to recover if the upstream that you pull from has
rebased the branches you depend your work on.  Hopefully this can also
serve as a warning to potential rebasers.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rebase.txt |  103 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 59c1b02..ba5255d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -257,11 +257,10 @@ include::merge-strategies.txt[]
 
 NOTES
 -----
-When you rebase a branch, you are changing its history in a way that
-will cause problems for anyone who already has a copy of the branch
-in their repository and tries to pull updates from you.  You should
-understand the implications of using 'git-rebase' on a repository that
-you share.
+
+You should understand the implications of using 'git-rebase' on a
+repository that you share.  See also RECOVERING FROM UPSTREAM REBASE
+below.
 
 When the git-rebase command is run, it will first execute a "pre-rebase"
 hook if one exists.  You can use this hook to do sanity checks and
@@ -396,6 +395,100 @@ consistent (they compile, pass the testsuite, etc.) you should use
 after each commit, test, and amend the commit if fixes are necessary.
 
 
+RECOVERING FROM UPSTREAM REBASE
+-------------------------------
+
+This section briefly explains the problems that arise from rebasing or
+rewriting published branches, and shows how to recover.  As you will
+see, the process is rather tedious, so we emphasize again: 'Avoid
+rewriting published history.'  This goes for `rebase`, `commit
+--amend`, `reset HEAD^` and `filter-branch` alike.
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
+If 'subsystem' is rebased against master, the following happens:
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
+on 'subsystem'.  Luckily, 'git-rebase' knows to skip commits that are
+textually the same as commits in the upstream.  So if you say
+(assuming you're on 'topic')
+------------
+    git rebase subsystem
+------------
+you will end up with the fixed history
+------------
+    o---o---o---o---o  master
+		     \
+		      o'--o'--o'--o'--o'  subsystem
+					\
+					 *'--*'--*'  topic
+------------
+
+This becomes a ripple effect to anyone downstream of the first rebase:
+anyone downstream from 'topic' now needs to rebase too, and so on.
+
+Things get more complicated if your upstream used `git rebase
+--interactive` (or `commit --amend` or `reset --hard HEAD^`).  Label
+the example history as follows:
+
+------------
+    o---o---o---o---o  master
+	 \
+	  A---B---C---D---E  subsystem
+			   \
+			    X---Y---Z  topic
+------------
+
+Now suppose the 'subsystem' maintainer decides to clean up his history
+with an interactive rebase.  He edits commits A and D (marked with a
+`*`), decides to remove D entirely and moves B to the front.  This
+results in
+
+------------
+    o---o---o---o---o  master
+	|	     \
+	|	      A*--C*--E'--B'  subsystem
+	\
+	 A---B---C---D---E---X---Y---Z	topic
+------------
+
+'git-rebase' can still tell that E'=E and B'=B, so a plain `git rebase
+subsystem` would not duplicate those commits.  However, it would
+**resurrect** D (which may succeed silently!) and try to apply the
+original versions of A and C (probably resulting in conflicts).
+
+To fix this, you have to manually transplant your own part of the
+history to the new branch head.  Looking at `git log`, you should be
+able to determine that three commits on 'topic' are yours.  Again
+assuming you are already on 'topic', you can do
+------------
+    git rebase --onto subsystem HEAD~3
+------------
+to put things right.  Of course, this again ripples onwards:
+'everyone' downstream from 'subsystem' will have to 'manually' rebase
+all their work!
+
+
 Authors
 ------
 Written by Junio C Hamano <gitster@pobox.com> and
-- 
1.6.0.1.470.g200b
