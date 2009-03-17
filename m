From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/4] Cap the number of open files in the WindowCache
Date: Mon, 16 Mar 2009 18:16:09 -0700
Message-ID: <1237252570-8596-4-git-send-email-spearce@spearce.org>
References: <1237252570-8596-1-git-send-email-spearce@spearce.org>
 <1237252570-8596-2-git-send-email-spearce@spearce.org>
 <1237252570-8596-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 02:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjNwJ-0003eC-Kq
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 02:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759613AbZCQBQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 21:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756531AbZCQBQX
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 21:16:23 -0400
Received: from george.spearce.org ([209.20.77.23]:47502 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837AbZCQBQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 21:16:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9453F38239; Tue, 17 Mar 2009 01:16:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5199238222;
	Tue, 17 Mar 2009 01:16:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237252570-8596-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113414>

The default WindowCache configuration is:

  packedGitLimit:      10 MB
  packedGitWindowSize:  8 KB

10 MB / 8 KB allows up to 1280 windows permitted in the WindowCache
at any given time.  If every window came from a unique pack file, we
need 1280 file descriptors just for the resources in the WindowCache.
For most applications this is way beyond the hard limit configured
for the host JVM, causing java.io.IOException("Too many open files")
from possibly any part of JGit or the host application.

Specifically, I ran into this problem in Gerrit Code Review, where we
commonly see hundreds of very small pack files spread over hundreds
of Git repositories, all accessed from a persistent JVM that is also
hosting an SSH daemon and a web server.  The aggressive caching of
windows in the WindowCache and of Repository objects in Gerrit's
own RepositoryCache caused us to retain far too many tiny pack files.

We now set the limit at 128 open files, assuming this is a reasonable
limit for most applications using the library.  Git repositories tend
to be in the handful of packs/repository (e.g. <10 packs/repository)
and applications using JGit tend to access only a handful of Git
repositories at a time (e.g. <10 repositories/JVM).

If we detect a file open failure while opening a pack we halve
the number of permitted open files and try again, until we reach
a lower bound of 16 open files.  Needing to go lower may indicate
a file descriptor leak in the host application.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |   65 +++++++++++++++-----
 .../org/spearce/jgit/lib/WindowCacheConfig.java    |   20 ++++++
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index ba1124a..13912a7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -54,6 +54,8 @@ private static final int bits(int newSize) {
 		return Integer.numberOfTrailingZeros(newSize);
 	}
 
+	private static int maxFileCount;
+
 	private static int maxByteCount;
 
 	private static int windowSize;
@@ -70,10 +72,13 @@ private static final int bits(int newSize) {
 
 	private static ByteWindow lruTail;
 
+	private static int openFileCount;
+
 	private static int openByteCount;
 
 	static {
 		final WindowCacheConfig c = new WindowCacheConfig();
+		maxFileCount = c.getPackedGitOpenFiles();
 		maxByteCount = c.getPackedGitLimit();
 		windowSizeShift = bits(c.getPackedGitWindowSize());
 		windowSize = 1 << windowSizeShift;
@@ -133,6 +138,13 @@ private static synchronized void reconfigureImpl(final WindowCacheConfig cfg) {
 		boolean prune = false;
 		boolean evictAll = false;
 
+		if (maxFileCount < cfg.getPackedGitOpenFiles())
+			maxFileCount = cfg.getPackedGitOpenFiles();
+		else if (maxFileCount > cfg.getPackedGitOpenFiles()) {
+			maxFileCount = cfg.getPackedGitOpenFiles();
+			prune = true;
+		}
+
 		if (maxByteCount < cfg.getPackedGitLimit()) {
 			maxByteCount = cfg.getPackedGitLimit();
 		} else if (maxByteCount > cfg.getPackedGitLimit()) {
@@ -229,20 +241,37 @@ private static synchronized final void getImpl(final WindowCursor curs,
 		}
 
 		if (wp.openCount == 0) {
-			try {
-				wp.openCount = 1;
-				wp.cacheOpen();
-			} catch (IOException ioe) {
-				wp.openCount = 0;
-				throw ioe;
-			} catch (RuntimeException ioe) {
-				wp.openCount = 0;
-				throw ioe;
-			} catch (Error ioe) {
-				wp.openCount = 0;
-				throw ioe;
-			} finally {
-				wp.openCount--;
+			TRY_OPEN: for (;;) {
+				try {
+					openFileCount++;
+					releaseMemory();
+					runClearedWindowQueue();
+					wp.openCount = 1;
+					wp.cacheOpen();
+					break;
+				} catch (IOException ioe) {
+					openFileCount--;
+					if ("Too many open files".equals(ioe.getMessage())
+							&& maxFileCount > 16) {
+						// We may be able to recover by halving our limit
+						// and trying again.
+						//
+						maxFileCount = Math.max(16, maxFileCount >> 2);
+						continue TRY_OPEN;
+					}
+					wp.openCount = 0;
+					throw ioe;
+				} catch (RuntimeException ioe) {
+					openFileCount--;
+					wp.openCount = 0;
+					throw ioe;
+				} catch (Error ioe) {
+					openFileCount--;
+					wp.openCount = 0;
+					throw ioe;
+				} finally {
+					wp.openCount--;
+				}
 			}
 
 			// The cacheOpen may have mapped the window we are trying to
@@ -278,6 +307,7 @@ private static synchronized final void getImpl(final WindowCursor curs,
 
 	static synchronized void markLoaded(final ByteWindow w) {
 		if (--w.provider.openCount == 0) {
+			openFileCount--;
 			w.provider.cacheClose();
 		}
 	}
@@ -291,13 +321,17 @@ private static void makeMostRecent(ByteWindow<?> e) {
 
 	private static void releaseMemory() {
 		ByteWindow<?> e = lruTail;
-		while (openByteCount > maxByteCount && e != null) {
+		while (isOverLimit() && e != null) {
 			final ByteWindow<?> p = e.lruPrev;
 			clear(e);
 			e = p;
 		}
 	}
 
+	private static boolean isOverLimit() {
+		return openByteCount > maxByteCount || openFileCount > maxFileCount;
+	}
+
 	/**
 	 * Remove all windows associated with a specific provider.
 	 * <p>
@@ -341,6 +375,7 @@ private static void clear(final ByteWindow<?> e) {
 	private static void unlinkSize(final ByteWindow<?> e) {
 		if (e.sizeActive) {
 			if (--e.provider.openCount == 0) {
+				openFileCount--;
 				e.provider.cacheClose();
 			}
 			openByteCount -= e.size;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
index b4c4638..d906a7c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
@@ -45,6 +45,8 @@
 	/** 1024 {@link #KB} (number of bytes in one mebibyte/megabyte) */
 	public static final int MB = 1024 * KB;
 
+	private int packedGitOpenFiles;
+
 	private int packedGitLimit;
 
 	private int packedGitWindowSize;
@@ -55,6 +57,7 @@
 
 	/** Create a default configuration. */
 	public WindowCacheConfig() {
+		packedGitOpenFiles = 128;
 		packedGitLimit = 10 * MB;
 		packedGitWindowSize = 8 * KB;
 		packedGitMMAP = false;
@@ -62,6 +65,23 @@ public WindowCacheConfig() {
 	}
 
 	/**
+	 * @return maximum number of streams to open at a time. Open packs count
+	 *         against the process limits. <b>Default is 128.</b>
+	 */
+	public int getPackedGitOpenFiles() {
+		return packedGitOpenFiles;
+	}
+
+	/**
+	 * @param fdLimit
+	 *            maximum number of streams to open at a time. Open packs count
+	 *            against the process limits
+	 */
+	public void setPackedGitOpenFiles(final int fdLimit) {
+		packedGitOpenFiles = fdLimit;
+	}
+
+	/**
 	 * @return maximum number bytes of heap memory to dedicate to caching pack
 	 *         file data. <b>Default is 10 MB.</b>
 	 */
-- 
1.6.2.1.286.g8173
