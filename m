From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH] git-p4: Fix bug in p4Where method.
Date: Thu, 04 Dec 2008 14:37:33 +0100
Message-ID: <1228397853-15921-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: "Junio C. Hamano" <gitster@pobox.com>,
	Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 15:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8FM2-00051G-Jl
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 15:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbYLDOhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 09:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbYLDOhl
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 09:37:41 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:58346 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbYLDOhk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 09:37:40 -0500
X-Greylist: delayed 3604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Dec 2008 09:37:40 EST
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KBC00FB0TUL71E0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 04 Dec 2008 14:37:33 +0100 (CET)
Received: from exchange.qsystems.no ([213.187.171.142])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KBC00F0ITULBAB0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 04 Dec 2008 14:37:33 +0100 (CET)
Received: from pingvin.heads.no ([192.168.223.6]) by exchange.qsystems.no with
 Microsoft SMTPSVC(6.0.3790.3959); Thu, 04 Dec 2008 14:41:09 +0100
Received: by pingvin.heads.no (Postfix, from userid 1001)	id 8F9393182C8; Thu,
 04 Dec 2008 14:37:33 +0100 (CET)
X-Mailer: git-send-email 1.6.0.90.g436ed
X-OriginalArrivalTime: 04 Dec 2008 13:41:09.0375 (UTC)
 FILETIME=[F6EC40F0:01C95615]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102340>

When running:

p4 where //depot/SomePath/...

The result can in some situations look like:

//depot/SomePath/... //client/SomePath/... /home/user/p4root/SomePath/...
-//depot/SomePath/UndesiredSubdir/... //client/SomePath/UndesiredSubdir/... /home/user/p4root/SomePath/UndesiredSubdir/...

This depends on the users Client view. The current p4Where method will now
return /home/user/p4root/SomePath/UndesiredSubdir/... which is not what we
want. This patch loops through the results from "p4 where", and picks the one
where the depotFile exactly matches the given depotPath (//depot/SomePath/...
in this example).

Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 46136d4..7ade777 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -245,7 +245,15 @@ def p4Cmd(cmd):
 def p4Where(depotPath):
     if not depotPath.endswith("/"):
         depotPath += "/"
-    output = p4Cmd("where %s..." % depotPath)
+    depotPath = depotPath + "..."
+    outputList = p4CmdList("where %s" % depotPath)
+    output = None
+    for entry in outputList:
+        if entry["depotFile"] == depotPath:
+            output = entry
+            break
+    if output == None:
+        return ""
     if output["code"] == "error":
         return ""
     clientPath = ""
-- 
1.6.0.2.1172.ga5ed0
