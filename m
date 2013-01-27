From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 18/21] git p4: avoid shell when invoking git rev-list
Date: Sat, 26 Jan 2013 22:11:21 -0500
Message-ID: <1359256284-5660-19-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:18:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIki-00074o-Hf
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab3A0DRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:17:32 -0500
Received: from honk.padd.com ([74.3.171.149]:44478 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755551Ab3A0DRb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:17:31 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 9FEDA2F3F;
	Sat, 26 Jan 2013 19:17:30 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0421622838; Sat, 26 Jan 2013 22:17:24 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214669>

Invoke git rev-list directly, avoiding the shell, in
P4Submit and P4Sync.  The overhead of starting extra
processes is significant in cygwin; this speeds things
up on that platform.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c43d044..c8ae83d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1606,7 +1606,7 @@ class P4Submit(Command, P4UserMap):
         self.check()
 
         commits = []
-        for line in read_pipe_lines("git rev-list --no-merges %s..%s" % (self.origin, self.master)):
+        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (self.origin, self.master)]):
             commits.append(line.strip())
         commits.reverse()
 
@@ -2644,7 +2644,8 @@ class P4Sync(Command, P4UserMap):
 
     def searchParent(self, parent, branch, target):
         parentFound = False
-        for blob in read_pipe_lines(["git", "rev-list", "--reverse", "--no-merges", parent]):
+        for blob in read_pipe_lines(["git", "rev-list", "--reverse",
+                                     "--no-merges", parent]):
             blob = blob.strip()
             if len(read_pipe(["git", "diff-tree", blob, target])) == 0:
                 parentFound = True
-- 
1.8.1.1.460.g6fa8886
