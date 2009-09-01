From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH (RESEND) 3/3] Fix DirCache.findEntry to work on an empty cache
Date: Tue,  1 Sep 2009 16:16:50 -0700
Message-ID: <1251847010-9992-3-git-send-email-spearce@spearce.org>
References: <1251847010-9992-1-git-send-email-spearce@spearce.org>
 <1251847010-9992-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 01:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Micb1-0003vt-2b
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 01:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbZIAXQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbZIAXQv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 19:16:51 -0400
Received: from george.spearce.org ([209.20.77.23]:40841 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbZIAXQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 19:16:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 18DE338221; Tue,  1 Sep 2009 23:16:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2FBED3821F;
	Tue,  1 Sep 2009 23:16:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.1.341.gf2a44
In-Reply-To: <1251847010-9992-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127567>

If the cache has no entries, we want to return -1 rather than throw
ArrayIndexOutOfBoundsException.  This binary search loop was stolen
from some other code which contained a test before the loop to see if
the collection was empty or not, but we failed to include that here.

Flipping the loop around to a standard while loop ensures we test
the condition properly first.

Signed-off-by: Shawn O. Pearce <sop@google.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/dircache/DirCacheBasicTest.java   |    6 ++++++
 .../src/org/spearce/jgit/dircache/DirCache.java    |    6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
index b3097ac..4d737c0 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheBasicTest.java
@@ -39,6 +39,7 @@
 
 import java.io.File;
 
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.RepositoryTestCase;
 
 public class DirCacheBasicTest extends RepositoryTestCase {
@@ -182,4 +183,9 @@ public void testBuildThenClear() throws Exception {
 		assertEquals(0, dc.getEntryCount());
 	}
 
+	public void testFindOnEmpty() throws Exception {
+		final DirCache dc = DirCache.newInCore();
+		final byte[] path = Constants.encode("a");
+		assertEquals(-1, dc.findEntry(path, path.length));
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index bfb7925..9f0810a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -583,8 +583,6 @@ public void unlock() {
 	 *         information. If < 0 the entry does not exist in the index.
 	 */
 	public int findEntry(final String path) {
-		if (entryCnt == 0)
-			return -1;
 		final byte[] p = Constants.encode(path);
 		return findEntry(p, p.length);
 	}
@@ -592,7 +590,7 @@ public int findEntry(final String path) {
 	int findEntry(final byte[] p, final int pLen) {
 		int low = 0;
 		int high = entryCnt;
-		do {
+		while (low < high) {
 			int mid = (low + high) >>> 1;
 			final int cmp = cmp(p, pLen, sortedEntries[mid]);
 			if (cmp < 0)
@@ -603,7 +601,7 @@ else if (cmp == 0) {
 				return mid;
 			} else
 				low = mid + 1;
-		} while (low < high);
+		}
 		return -(low + 1);
 	}
 
-- 
1.6.4.1.341.gf2a44
