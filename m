From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH] git-p4: Fix regression in p4Where method.
Date: Tue, 09 Dec 2008 16:41:50 +0100
Message-ID: <1228837310-1340-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 16:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA4jy-0005VU-BK
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 16:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbYLIPlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 10:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbYLIPlz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 10:41:55 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:59654 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYLIPly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 10:41:54 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KBM004CK8XR4I60@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 09 Dec 2008 16:41:51 +0100 (CET)
Received: from exchange.qsystems.no ([213.187.171.142])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KBM008PA8XRVE80@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 09 Dec 2008 16:41:51 +0100 (CET)
Received: from pingvin.heads.no ([192.168.223.6]) by exchange.qsystems.no with
 Microsoft SMTPSVC(6.0.3790.3959); Tue, 09 Dec 2008 16:45:31 +0100
Received: by pingvin.heads.no (Postfix, from userid 1001)	id 9676B3182C8; Tue,
 09 Dec 2008 16:41:50 +0100 (CET)
X-Mailer: git-send-email 1.6.0.90.g436ed
X-OriginalArrivalTime: 09 Dec 2008 15:45:31.0578 (UTC)
 FILETIME=[2ACED1A0:01C95A15]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102636>

Unfortunately, I introduced a bug in commit 7f705dc36 (git-p4: Fix bug in
p4Where method). This happens because sometimes the result from
"p4 where <somepath>" doesn't contain a "depotFile" key, but instead a
"data" key that needs further parsing. This commit should ensure that both
of these cases are checked.

Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index ee504e9..a85a7b2 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -249,9 +249,16 @@ def p4Where(depotPath):
     outputList = p4CmdList("where %s" % depotPath)
     output = None
     for entry in outputList:
-        if entry["depotFile"] == depotPath:
-            output = entry
-            break
+        if "depotFile" in entry:
+            if entry["depotFile"] == depotPath:
+                output = entry
+                break
+        elif "data" in entry:
+            data = entry.get("data")
+            space = data.find(" ")
+            if data[:space] == depotPath:
+                output = entry
+                break
     if output == None:
         return ""
     if output["code"] == "error":
-- 
1.6.0.2.1172.ga5ed0
