From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Allow core.packedGitLimit to exceed "2 g"
Date: Fri, 12 Jun 2009 16:23:06 -0700
Message-ID: <1244848986-10526-2-git-send-email-spearce@spearce.org>
References: <1244848986-10526-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:23:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFG5f-0000eu-2B
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbZFLXXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbZFLXXH
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:23:07 -0400
Received: from george.spearce.org ([209.20.77.23]:52470 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZFLXXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:23:05 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 37D9F381FE; Fri, 12 Jun 2009 23:23:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B0A22381FD;
	Fri, 12 Jun 2009 23:23:06 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <1244848986-10526-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121469>

A 64 bit JVM might actually be able to dedicate more than 2 GiB of
memory to the window cache, and on a busy server, this may be an
ideal configuration since JGit can't always reliably use mmap.  By
treating the limit as a long we increase our range to 2^63, which
is far beyond what any JVM heap would be able to actually support.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |   13 +++++++------
 .../org/spearce/jgit/lib/WindowCacheConfig.java    |    8 ++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 0c60853..b6a35ad 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -41,6 +41,7 @@
 import java.io.IOException;
 import java.lang.ref.ReferenceQueue;
 import java.util.concurrent.atomic.AtomicInteger;
+import java.util.concurrent.atomic.AtomicLong;
 
 /**
  * Caches slices of a {@link PackFile} in memory for faster read access.
@@ -140,7 +141,7 @@ static final void purge(final PackFile pack) {
 
 	private final int maxFiles;
 
-	private final int maxBytes;
+	private final long maxBytes;
 
 	private final boolean mmap;
 
@@ -150,7 +151,7 @@ static final void purge(final PackFile pack) {
 
 	private final AtomicInteger openFiles;
 
-	private final AtomicInteger openBytes;
+	private final AtomicLong openBytes;
 
 	private WindowCache(final WindowCacheConfig cfg) {
 		super(tableSize(cfg), lockCount(cfg));
@@ -161,7 +162,7 @@ private WindowCache(final WindowCacheConfig cfg) {
 		windowSize = 1 << windowSizeShift;
 
 		openFiles = new AtomicInteger();
-		openBytes = new AtomicInteger();
+		openBytes = new AtomicLong();
 
 		if (maxFiles < 1)
 			throw new IllegalArgumentException("Open files must be >= 1");
@@ -173,7 +174,7 @@ int getOpenFiles() {
 		return openFiles.get();
 	}
 
-	int getOpenBytes() {
+	long getOpenBytes() {
 		return openBytes.get();
 	}
 
@@ -233,12 +234,12 @@ private long toStart(final long offset) {
 
 	private static int tableSize(final WindowCacheConfig cfg) {
 		final int wsz = cfg.getPackedGitWindowSize();
-		final int limit = cfg.getPackedGitLimit();
+		final long limit = cfg.getPackedGitLimit();
 		if (wsz <= 0)
 			throw new IllegalArgumentException("Invalid window size");
 		if (limit < wsz)
 			throw new IllegalArgumentException("Window size must be < limit");
-		return 5 * (limit / wsz) / 2;
+		return (int) Math.min(5 * (limit / wsz) / 2, 2000000000);
 	}
 
 	private static int lockCount(final WindowCacheConfig cfg) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
index ea28164..97edd3a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
@@ -47,7 +47,7 @@
 
 	private int packedGitOpenFiles;
 
-	private int packedGitLimit;
+	private long packedGitLimit;
 
 	private int packedGitWindowSize;
 
@@ -85,7 +85,7 @@ public void setPackedGitOpenFiles(final int fdLimit) {
 	 * @return maximum number bytes of heap memory to dedicate to caching pack
 	 *         file data. <b>Default is 10 MB.</b>
 	 */
-	public int getPackedGitLimit() {
+	public long getPackedGitLimit() {
 		return packedGitLimit;
 	}
 
@@ -94,7 +94,7 @@ public int getPackedGitLimit() {
 	 *            maximum number bytes of heap memory to dedicate to caching
 	 *            pack file data.
 	 */
-	public void setPackedGitLimit(final int newLimit) {
+	public void setPackedGitLimit(final long newLimit) {
 		packedGitLimit = newLimit;
 	}
 
@@ -162,7 +162,7 @@ public void setDeltaBaseCacheLimit(final int newLimit) {
 	 */
 	public void fromConfig(final RepositoryConfig rc) {
 		setPackedGitOpenFiles(rc.getInt("core", null, "packedgitopenfiles", getPackedGitOpenFiles()));
-		setPackedGitLimit(rc.getInt("core", null, "packedgitlimit", getPackedGitLimit()));
+		setPackedGitLimit(rc.getLong("core", null, "packedgitlimit", getPackedGitLimit()));
 		setPackedGitWindowSize(rc.getInt("core", null, "packedgitwindowsize", getPackedGitWindowSize()));
 		setPackedGitMMAP(rc.getBoolean("core", null, "packedgitmmap", isPackedGitMMAP()));
 		setDeltaBaseCacheLimit(rc.getInt("core", null, "deltabasecachelimit", getDeltaBaseCacheLimit()));
-- 
1.6.3.2.367.gf0de
