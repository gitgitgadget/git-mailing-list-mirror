From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/4] Add writeRef method and make writeSymref public.
Date: Sun, 22 Apr 2007 23:36:09 +0200
Message-ID: <20070422213608.26396.16129.stgit@lathund.dewire.com>
References: <20070422212907.26396.12810.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 22 23:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfjjg-0008I4-5X
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 23:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXDVVgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 17:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXDVVgk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 17:36:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14885 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbXDVVgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 17:36:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 10F9F8028A0;
	Sun, 22 Apr 2007 23:30:47 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25797-01; Sun, 22 Apr 2007 23:30:46 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id AA644802892;
	Sun, 22 Apr 2007 23:30:46 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id E5321297FD;
	Sun, 22 Apr 2007 23:36:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id uYeQuosQKFJb; Sun, 22 Apr 2007 23:36:20 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 71AC129825;
	Sun, 22 Apr 2007 23:36:09 +0200 (CEST)
In-Reply-To: <20070422212907.26396.12810.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45279>

The writeRef method is for creating tags and branches. writeSymref
is for creating symbols like HEAD.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/Repository.java       |   31 ++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index b4d6473..0f2a900 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -349,7 +349,36 @@ public class Repository {
 		}
 	}
 
-	private void writeSymref(final String name, final String target)
+    public void writeRef(String name, ObjectId id) throws IOException {
+		File f = new File(gitDir, name);
+		File t = File.createTempFile("ref", null, gitDir);
+		FileWriter w = new FileWriter(t);
+		try {
+			w.write(id.toString());
+			w.write('\n');
+			w.close();
+			w = null;
+			if (!t.renameTo(f)) {
+				f.getParentFile().mkdirs();
+				if (!t.renameTo(f)) {
+					f.delete();
+					if (!t.renameTo(f)) {
+						t.delete();
+						throw new ObjectWritingException("Unable to"
+								+ " write ref " + name + " to point to "
+								+ id.toString());
+					}
+				}
+			}
+		} finally {
+			if (w != null) {
+				w.close();
+				t.delete();
+			}
+		}
+	}
+
+    public void writeSymref(final String name, final String target)
 			throws IOException {
 		final File s = new File(gitDir, name);
 		final File t = File.createTempFile("srf", null, gitDir);
