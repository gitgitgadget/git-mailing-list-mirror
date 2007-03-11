From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 05/10] Cache commits
Date: Sun, 11 Mar 2007 19:15:42 +0100
Message-ID: <20070311181542.18012.36508.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYg-0006IS-1N
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933942AbXCKSOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933945AbXCKSOB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:14:01 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1613 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933942AbXCKSOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:14:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 013098033A7;
	Sun, 11 Mar 2007 19:08:44 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26266-01; Sun, 11 Mar 2007 19:08:44 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 8F7DF802841;
	Sun, 11 Mar 2007 19:08:44 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B6B4E291DB;
	Sun, 11 Mar 2007 19:15:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id rqIPK3+FJfPX; Sun, 11 Mar 2007 19:15:47 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B69CC28D45;
	Sun, 11 Mar 2007 19:15:42 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41955>

This uses more memory, but by having a WeakMap we allow the
garbage collector to claim the memory if needed. This speeds
up the history panel enormously, so that having the history
pane connected to the selected resource is not a performance
problem (except the first time the history of a resource in
a projects is shown).

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Repository.java       |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 781ad90..f7c470d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -25,6 +25,8 @@ import java.io.FileWriter;
 import java.io.IOException;
 import java.util.ArrayList;
 import java.util.Collection;
+import java.util.Map;
+import java.util.WeakHashMap;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.ObjectWritingException;
@@ -45,6 +47,8 @@ public class Repository {
 
 	private WindowCache windows;
 
+	private Map cache = new WeakHashMap(30000); 
+
 	public Repository(final File d) throws IOException {
 		gitDir = d.getAbsoluteFile();
 		objectsDir = new File(gitDir, "objects");
@@ -185,12 +189,19 @@ public class Repository {
 	}
 
 	public Commit mapCommit(final ObjectId id) throws IOException {
+		Commit ret = (Commit)cache.get(id);
+		if (ret != null)
+			return ret;
+
 		final ObjectLoader or = openObject(id);
 		if (or == null)
 			return null;
 		final byte[] raw = or.getBytes();
-		if (Constants.TYPE_COMMIT.equals(or.getType()))
-			return new Commit(this, id, raw);
+		if (Constants.TYPE_COMMIT.equals(or.getType())) {
+			ret = new Commit(this, id, raw);
+			cache.put(id, ret);
+			return ret;
+		}
 		throw new IncorrectObjectTypeException(id, Constants.TYPE_COMMIT);
 	}
 
