From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 09/10] Hash ObjectId faster.
Date: Sun, 11 Mar 2007 19:16:03 +0100
Message-ID: <20070311181603.18012.78635.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYy-0006Qd-4a
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933947AbXCKSOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933949AbXCKSOX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:14:23 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1636 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933947AbXCKSOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:14:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B4CE8802841;
	Sun, 11 Mar 2007 19:09:07 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26264-04; Sun, 11 Mar 2007 19:09:07 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 702C3800199;
	Sun, 11 Mar 2007 19:09:07 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 99B6C291D6;
	Sun, 11 Mar 2007 19:16:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 65LXviCE3wcY; Sun, 11 Mar 2007 19:16:11 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id DC02A28D45;
	Sun, 11 Mar 2007 19:16:03 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41958>

ObjectId's are well distributed so we can grab the first four bytes
as the hash code. The assumption makes hashing faster.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/ObjectId.java         |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index 9e62424..45e23e6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -163,12 +163,13 @@ public class ObjectId implements Comparable {
 	}
 
 	public int hashCode() {
-		int r = 0;
-		for (int k = id.length - 1; k >= 0; k--) {
-			r *= 31;
-			r += id[k];
-		}
-		return r;
+		// Object Id' are well distributed so grab the first four bytes
+		int b0 = id[0] & 0xff;
+		int b1 = id[1] & 0xff;
+		int b2 = id[2] & 0xff;
+		int b3 = id[3] & 0xff;
+		int h = (b0 << 24) | (b1 << 16) | (b2 << 8) | b3;
+		return h;
 	}
 
 	public boolean equals(final ObjectId o) {
