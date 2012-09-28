From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 18/21] git p4: avoid shell when invoking git rev-list
Date: Fri, 28 Sep 2012 08:04:22 -0400
Message-ID: <1348833865-6093-19-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:10:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZP0-0004CS-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757590Ab2I1MKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:10:34 -0400
Received: from honk.padd.com ([74.3.171.149]:58382 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab2I1MKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:10:33 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 1A70E5AF2;
	Fri, 28 Sep 2012 05:10:30 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 964AF31413; Fri, 28 Sep 2012 08:10:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206576>

Invoke git rev-list directly, avoiding the shell, in
P4Submit and P4Sync.  The overhead of starting extra
processes is significant in cygwin; this speeds things
up on that platform.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a92d84f..9c33af4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1538,7 +1538,7 @@ class P4Submit(Command, P4UserMap):
         self.check()
 
         commits = []
-        for line in read_pipe_lines("git rev-list --no-merges %s..%s" % (self.origin, self.master)):
+        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (self.origin, self.master)]):
             commits.append(line.strip())
         commits.reverse()
 
@@ -2558,7 +2558,8 @@ class P4Sync(Command, P4UserMap):
 
     def searchParent(self, parent, branch, target):
         parentFound = False
-        for blob in read_pipe_lines(["git", "rev-list", "--reverse", "--no-merges", parent]):
+        for blob in read_pipe_lines(["git", "rev-list", "--reverse",
+                                     "--no-merges", parent]):
             blob = blob.strip()
             if len(read_pipe(["git", "diff-tree", blob, target])) == 0:
                 parentFound = True
-- 
1.7.12.1.403.g28165e1
