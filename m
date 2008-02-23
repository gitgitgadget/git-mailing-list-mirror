From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 06/10] Use the proper comparison algorithm
Date: Sun, 24 Feb 2008 00:50:39 +0100
Message-ID: <1203810643-28819-7-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-5-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-6-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AR-0001IU-7y
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbYBWXv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbYBWXv0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:26 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11221 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754589AbYBWXu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:50:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 82BE180280B;
	Sun, 24 Feb 2008 00:50:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t+KanhHUR5L5; Sun, 24 Feb 2008 00:50:57 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B054B80281F;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 0B91A293B0; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74889>

We must walk in Git sort order.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/IndexTreeWalker.java  |   31 +------------------
 1 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
index 93d5bb2..c17cea1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexTreeWalker.java
@@ -288,38 +288,11 @@ public class IndexTreeWalker {
 	}
 
 	static int compare(TreeEntry t, Entry i) {
-		if (t.getFullName().equals(i.getName())) {
-			if (t instanceof Tree)
-				return 1;
-			return 0;
-		}
-		return t.getFullName().compareTo(i.getName());
+		return Tree.compareNames(t.getFullNameUTF8(), i.getNameUTF8(), TreeEntry.lastChar(t), TreeEntry.lastChar(i)); 
 	}
 	
 	static int compare(TreeEntry t1, TreeEntry t2) {
-		if (t1.getName().equals(t2.getName())) {
-			if (t1 instanceof Tree && t2 instanceof Tree)
-				return 0;
-			if (t1 instanceof Tree)
-				return 1;
-			if (t2 instanceof Tree)
-				return -1;
-			return 0;
-		}
-		return t1.getName().compareTo(t2.getName());
+		return Tree.compareNames(t1.getNameUTF8(), t2.getNameUTF8(), TreeEntry.lastChar(t1), TreeEntry.lastChar(t2)); 
 	}
 	
-	static int compare(byte[] name1, byte[] name2) {
-		for (int i = 0; i < name1.length && i < name2.length; i++) {
-			if (name1[i] < name2[i])
-				return -1;
-			if (name1[i] > name2[i])
-				return 1;
-		}
-		if (name1.length < name2.length)
-			return -1;
-		if (name2.length < name1.length)
-			return 1;
-		return 0;
-	}
 }
-- 
1.5.4.2
