From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 10/14] git p4: rearrange self.initialParent use
Date: Mon, 14 Jan 2013 19:47:04 -0500
Message-ID: <1358210828-2369-11-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:50:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuujt-0002x1-0p
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000Ab3AOAud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:50:33 -0500
Received: from honk.padd.com ([74.3.171.149]:40003 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756964Ab3AOAuc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:50:32 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id D73C02F3F;
	Mon, 14 Jan 2013 16:50:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6394C28EC2; Mon, 14 Jan 2013 19:50:29 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213561>

This was set in a couple of places, both of which were very
far away from its use.  Move it a bit closer to importChanges(),
and add some comments.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 5dcb527..9b07ddd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2689,6 +2689,7 @@ class P4Sync(Command, P4UserMap):
                     files = self.extractFilesFromCommit(description)
                     self.commit(description, files, self.branch,
                                 self.initialParent)
+                    # only needed once, to connect to the previous commit
                     self.initialParent = ""
             except IOError:
                 print self.gitError.read()
@@ -2754,7 +2755,6 @@ class P4Sync(Command, P4UserMap):
     def run(self, args):
         self.depotPaths = []
         self.changeRange = ""
-        self.initialParent = ""
         self.previousDepotPaths = []
         self.hasOrigin = False
 
@@ -2842,8 +2842,6 @@ class P4Sync(Command, P4UserMap):
             if p4Change > 0:
                 self.depotPaths = sorted(self.previousDepotPaths)
                 self.changeRange = "@%s,#head" % p4Change
-                if not self.detectBranches:
-                    self.initialParent = parseRevision(self.branch)
                 if not self.silent and not self.detectBranches:
                     print "Performing incremental import into %s git branch" % self.branch
 
@@ -2988,6 +2986,14 @@ class P4Sync(Command, P4UserMap):
 
                 self.updatedBranches = set()
 
+                if not self.detectBranches:
+                    if args:
+                        # start a new branch
+                        self.initialParent = ""
+                    else:
+                        # build on a previous revision
+                        self.initialParent = parseRevision(self.branch)
+
                 self.importChanges(changes)
 
                 if not self.silent:
-- 
1.8.1.350.gdbf6fd0
