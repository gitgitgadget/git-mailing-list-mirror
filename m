From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 1/2] git p4: refactor diffOpts calculation
Date: Thu, 12 Jul 2012 19:28:59 -0400
Message-ID: <1342135740-30290-2-git-send-email-pw@padd.com>
References: <1342135740-30290-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 01:29:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpSp9-0004dS-5b
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 01:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161941Ab2GLX30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 19:29:26 -0400
Received: from honk.padd.com ([74.3.171.149]:43163 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161924Ab2GLX3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 19:29:23 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id AC84020E5;
	Thu, 12 Jul 2012 16:29:22 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7540D31563; Thu, 12 Jul 2012 19:29:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.131.g9e48292
In-Reply-To: <1342135740-30290-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201390>

From: Gary Gibbons <ggibbons@perforce.com>

P4Submit.applyCommit()

To avoid recalculating the same diffOpts for each commit, move it
out of applyCommit() and into the top-level run().  Also fix a bug
in that code which interpreted the value of detectRenames as a
string rather than as a boolean.

[pw: fix documentation, rearrange code a bit]

Signed-off-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt | 10 ++++++----
 git-p4.py                | 52 +++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index fe1f49b..8228f33 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -255,7 +255,7 @@ These options can be used to modify 'git p4 submit' behavior.
 	p4.  By default, this is the most recent p4 commit reachable
 	from 'HEAD'.
 
--M[<n>]::
+-M::
 	Detect renames.  See linkgit:git-diff[1].  Renames will be
 	represented in p4 using explicit 'move' operations.  There
 	is no corresponding option to detect copies, but there are
@@ -465,13 +465,15 @@ git-p4.useClientSpec::
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
-	Detect renames.  See linkgit:git-diff[1].
+	Detect renames.  See linkgit:git-diff[1].  This can be true,
+	false, or a score as expected by 'git diff -M'.
 
 git-p4.detectCopies::
-	Detect copies.  See linkgit:git-diff[1].
+	Detect copies.  See linkgit:git-diff[1].  This can be true,
+	false, or a score as expected by 'git diff -C'.
 
 git-p4.detectCopiesHarder::
-	Detect copies harder.  See linkgit:git-diff[1].
+	Detect copies harder.  See linkgit:git-diff[1].  A boolean.
 
 git-p4.preserveUser::
 	On submit, re-author changes to reflect the git author,
diff --git a/git-p4.py b/git-p4.py
index f895a24..5fe509f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1046,27 +1046,8 @@ class P4Submit(Command, P4UserMap):
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
-        if not self.detectRenames:
-            # If not explicitly set check the config variable
-            self.detectRenames = gitConfig("git-p4.detectRenames")
-
-        if self.detectRenames.lower() == "false" or self.detectRenames == "":
-            diffOpts = ""
-        elif self.detectRenames.lower() == "true":
-            diffOpts = "-M"
-        else:
-            diffOpts = "-M%s" % self.detectRenames
-
-        detectCopies = gitConfig("git-p4.detectCopies")
-        if detectCopies.lower() == "true":
-            diffOpts += " -C"
-        elif detectCopies != "" and detectCopies.lower() != "false":
-            diffOpts += " -C%s" % detectCopies
 
-        if gitConfig("git-p4.detectCopiesHarder", "--bool") == "true":
-            diffOpts += " --find-copies-harder"
-
-        diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
+        diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
         editedFiles = set()
@@ -1433,6 +1414,37 @@ class P4Submit(Command, P4UserMap):
         if self.preserveUser:
             self.checkValidP4Users(commits)
 
+        #
+        # Build up a set of options to be passed to diff when
+        # submitting each commit to p4.
+        #
+        if self.detectRenames:
+            # command-line -M arg
+            self.diffOpts = "-M"
+        else:
+            # If not explicitly set check the config variable
+            detectRenames = gitConfig("git-p4.detectRenames")
+
+            if detectRenames.lower() == "false" or detectRenames == "":
+                self.diffOpts = ""
+            elif detectRenames.lower() == "true":
+                self.diffOpts = "-M"
+            else:
+                self.diffOpts = "-M%s" % detectRenames
+
+        # no command-line arg for -C or --find-copies-harder, just
+        # config variables
+        detectCopies = gitConfig("git-p4.detectCopies")
+        if detectCopies.lower() == "false" or detectCopies == "":
+            pass
+        elif detectCopies.lower() == "true":
+            self.diffOpts += " -C"
+        else:
+            self.diffOpts += " -C%s" % detectCopies
+
+        if gitConfig("git-p4.detectCopiesHarder", "--bool") == "true":
+            self.diffOpts += " --find-copies-harder"
+
         while len(commits) > 0:
             commit = commits[0]
             commits = commits[1:]
-- 
1.7.11.1.72.g3344471
