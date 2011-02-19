From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 4/8] git-p4: accommodate new move/delete type in p4
Date: Sat, 19 Feb 2011 08:17:57 -0500
Message-ID: <1298121481-7005-5-git-send-email-pw@padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqmho-0001Jr-Qj
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab1BSNSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:32 -0500
Received: from honk.padd.com ([74.3.171.149]:51188 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233Ab1BSNST (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:19 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 0D5A620C8;
	Sat, 19 Feb 2011 05:18:16 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id EA55131ADB; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298121481-7005-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167276>

Change 562d53f (2010-11-21) recognized the new move/delete type
for git-p4 sync, but it can also show up in an initial clone and
labels output.  Instead of replicating this in three places,
hoist the definition somewhere global.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Acked-By: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d2ba215..db19b17 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -834,6 +834,8 @@ class P4Submit(Command):
         return True
 
 class P4Sync(Command):
+    delete_actions = ( "delete", "move/delete", "purge" )
+
     def __init__(self):
         Command.__init__(self)
         self.options = [
@@ -1038,10 +1040,10 @@ class P4Sync(Command):
 
             if includeFile:
                 filesForCommit.append(f)
-                if f['action'] not in ('delete', 'move/delete', 'purge'):
-                    filesToRead.append(f)
-                else:
+                if f['action'] in self.delete_actions:
                     filesToDelete.append(f)
+                else:
+                    filesToRead.append(f)
 
         # deleted files...
         for f in filesToDelete:
@@ -1127,7 +1129,7 @@ class P4Sync(Command):
 
                 cleanedFiles = {}
                 for info in files:
-                    if info["action"] in ("delete", "purge"):
+                    if info["action"] in self.delete_actions:
                         continue
                     cleanedFiles[info["depotFile"]] = info["rev"]
 
@@ -1453,7 +1455,7 @@ class P4Sync(Command):
             if change > newestRevision:
                 newestRevision = change
 
-            if info["action"] in ("delete", "purge"):
+            if info["action"] in self.delete_actions:
                 # don't increase the file cnt, otherwise details["depotFile123"] will have gaps!
                 #fileCnt = fileCnt + 1
                 continue
-- 
1.7.4.1
