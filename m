From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] Documentation: new upstream rebase recovery section in git-rebase
Date: Sat, 13 Sep 2008 18:11:00 +0200
Message-ID: <1221322263-25291-2-git-send-email-trast@student.ethz.ch>
References: <7v8wtwk4yp.fsf@gitster.siamese.dyndns.org>
 <1221322263-25291-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 18:12:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeXjV-0001Zh-Bi
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 18:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYIMQLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 12:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYIMQLP
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 12:11:15 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:42895 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbYIMQLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 12:11:12 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 18:11:08 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 18:11:09 +0200
X-Mailer: git-send-email 1.6.0.2.408.g3709
In-Reply-To: <1221322263-25291-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Sep 2008 16:11:09.0292 (UTC) FILETIME=[556B1AC0:01C915BB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95805>

Documents how to recover if the upstream that you pull from has
rebased the branches you depend your work on.  Hopefully this can also
serve as a warning to potential rebasers.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

See the series leader for discussion.

 Documentation/git-rebase.txt |  129 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 59c1b02..a2f686c 100644
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
@@ -396,6 +395,126 @@ consistent (they compile, pass the testsuite, etc.) you should use
 after each commit, test, and amend the commit if fixes are necessary.
 
 
+RECOVERING FROM UPSTREAM REBASE
+-------------------------------
+
+Rebasing (or any other form of rewriting) a branch that others have
+based work on is a bad idea: anyone downstream of it is forced to
+manually fix their history.  This section explains how to do the fix
+from the downstream's point of view.  The real fix, however, would be
+to avoid rebasing the upstream in the first place.
+
+To illustrate, suppose you are in a situation where someone develops a
+'subsystem' branch, and you are working on a 'topic' that is dependent
+on this 'subsystem'.  You might end up with a history like the
+following:
+
+------------
+    o---o---o---o---o---o---o---o---o  master
+	 \
+	  o---o---o---o---o  subsystem
+			   \
+			    *---*---*  topic
+------------
+
+If 'subsystem' is rebased against 'master', the following happens:
+
+------------
+    o---o---o---o---o---o---o---o  master
+	 \			 \
+	  o---o---o---o---o	  o'--o'--o'--o'--o'  subsystem
+			   \
+			    *---*---*  topic
+------------
+
+If you now continue development as usual, and eventually merge 'topic'
+to 'subsystem', the commits will remain duplicated forever:
+
+------------
+    o---o---o---o---o---o---o---o  master
+	 \			 \
+	  o---o---o---o---o	  o'--o'--o'--o'--o'--M	 subsystem
+			   \			     /
+			    *---*---*-..........-*--*  topic
+------------
+
+Such duplicates are generally frowned upon because they clutter up
+history, making it harder to follow.  To clean things up, you need to
+transplant the commits on 'topic' to the new 'subsystem' tip, i.e.,
+rebase 'topic'.  This becomes a ripple effect: anyone downstream from
+'topic' is forced to rebase too, and so on!
+
+There are two kinds of fixes, discussed in the following subsections:
+
+Easy case: The changes are literally the same.::
+
+	This happens if the 'subsystem' rebase was a simple rebase and
+	had no conflicts.
+
+Hard case: The changes are not the same.::
+
+	This happens if the 'subsystem' rebase had conflicts, or used
+	`\--interactive` to omit, edit, or squash commits; or if the
+	upstream used one of `commit \--amend`, `reset`, or
+	`filter-branch`.
+
+
+The easy case
+~~~~~~~~~~~~~
+
+Only works if the changes (patch IDs based on the diff contents) on
+'subsystem' are literally the same before and after the rebase.
+
+In that case, the fix is easy because 'git-rebase' knows to skip
+changes that are already present in the new upstream.  So if you say
+(assuming you're on 'topic')
+------------
+    git rebase subsystem
+------------
+you will end up with the fixed history
+------------
+    o---o---o---o---o---o---o---o  master
+				 \
+				  o'--o'--o'--o'--o'  subsystem
+						   \
+						    *---*---*  topic
+------------
+
+
+The hard case
+~~~~~~~~~~~~~
+
+Things get more complicated if the 'subsystem' changes do not exactly
+correspond to the pre-rebase ones.
+
+NOTE: While an "easy case recovery" sometimes appears to be successful
+      even in the hard case, it may have unintended consequences.  For
+      example, a commit that was removed via `git rebase
+      \--interactive` will be **resurrected**!
+
+The idea is to manually tell 'git-rebase' "where the old 'subsystem'
+ended and your 'topic' began", that is, what the old merge-base
+between them was.  You will have to find a way to name the last commit
+of the old 'subsystem', for example:
+
+* With the 'subsystem' reflog: after 'git-fetch', the old tip of
+  'subsystem' is at `subsystem@\{1}`.  Subsequent fetches will
+  increase the number.  (See linkgit:git-reflog[1].)
+
+* Relative to the tip of 'topic': knowing that your 'topic' has three
+  commits, the old tip of 'subsystem' must be `topic~3`.
+
+You can then transplant the old `subsystem..topic` to the new tip by
+saying (for the reflog case, and assuming you are on 'topic' already):
+------------
+    git rebase --onto subsystem subsystem@{1}
+------------
+
+The ripple effect of a "hard case" recovery is especially bad:
+'everyone' downstream from 'topic' will now have to perform a "hard
+case" recovery too!
+
+
 Authors
 ------
 Written by Junio C Hamano <gitster@pobox.com> and
-- 
1.6.0.2.408.g3709
