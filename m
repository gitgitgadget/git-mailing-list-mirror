From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH] Fix sort order in GitIndex and mark it as deprecated
Date: Tue, 23 Jun 2009 23:45:23 +0200
Message-ID: <1245793523-28787-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Jun 23 23:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJDok-00022S-Sp
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 23:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758529AbZFWVp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 17:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758217AbZFWVp3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 17:45:29 -0400
Received: from mail.dewire.com ([83.140.172.130]:1993 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755861AbZFWVp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 17:45:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E42B514927A3;
	Tue, 23 Jun 2009 23:45:25 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsH8IZ9GNFHS; Tue, 23 Jun 2009 23:45:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 2EE9D8026FE;
	Tue, 23 Jun 2009 23:45:25 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122112>

We were using signed comparisons for ordering entries here which is so
terribly wrong and sometimes breaks when using non-ascii characters.

Due to other mechanisms this went undetected when committing from JGit,
because the order in trees were usually corrected, but updating the index
from JGit (using GitIndex) and committing from e.g. C Git breaks.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/GitIndex.java         |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

This put GitIndex even higher on the kill list, but as always doing
half fixes saves time in the short run.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 21b495a..2ac8ebb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -60,6 +60,7 @@
 import java.util.Stack;
 import java.util.TreeMap;
 
+import org.spearce.jgit.dircache.DirCache;
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.util.FS;
@@ -85,6 +86,8 @@
  *
  * An index can also contain a tree cache which we ignore for now. We drop the
  * tree cache when writing the index.
+ * 
+ * @deprecated Use {@link DirCache} instead.
  */
 public class GitIndex {
 
@@ -110,7 +113,7 @@
 	private Map<byte[], Entry> entries = new TreeMap<byte[], Entry>(new Comparator<byte[]>() {
 		public int compare(byte[] o1, byte[] o2) {
 			for (int i = 0; i < o1.length && i < o2.length; ++i) {
-				int c = o1[i] - o2[i];
+				int c = (o1[i] & 0xff) - (o2[i] & 0xff);
 				if (c != 0)
 					return c;
 			}
-- 
1.6.3.2.199.g7340d
