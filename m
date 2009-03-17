From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/4] Refactor WindowCache.reconfigure() to take a configuration object
Date: Mon, 16 Mar 2009 18:16:07 -0700
Message-ID: <1237252570-8596-2-git-send-email-spearce@spearce.org>
References: <1237252570-8596-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 02:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjNwH-0003eC-3t
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 02:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758637AbZCQBQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 21:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757837AbZCQBQQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 21:16:16 -0400
Received: from george.spearce.org ([209.20.77.23]:47496 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbZCQBQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 21:16:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A439438262; Tue, 17 Mar 2009 01:16:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 958FD38221;
	Tue, 17 Mar 2009 01:16:11 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.286.g8173
In-Reply-To: <1237252570-8596-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113411>

This makes it safer for applications to be calling reconfigure()
should we ever add more controllable parameters to cache.  It may
also leave the door open for more common option handling, such as
reading from ~/.gitconfig in a standard way across applications
built upon JGit.  We could also add sanity check functions to the
new configuration object, allowing applications to inquire about
the validity before installing it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    8 +-
 .../org/spearce/jgit/lib/UnpackedObjectCache.java  |    7 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |   54 +++++---
 .../org/spearce/jgit/lib/WindowCacheConfig.java    |  134 ++++++++++++++++++++
 4 files changed, 178 insertions(+), 25 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 4e56b38..5d8c056 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -113,8 +113,12 @@ public String getProperty(String key) {
 	 * Configure JGit before setting up test repositories.
 	 */
 	protected void configure() {
-		packedGitMMAP = "true".equals(System.getProperty("jgit.junit.usemmmap"));
-		WindowCache.reconfigure(128*1024, 8192, packedGitMMAP, 8192);
+		final WindowCacheConfig c = new WindowCacheConfig();
+		c.setPackedGitLimit(128 * WindowCacheConfig.KB);
+		c.setPackedGitWindowSize(8 * WindowCacheConfig.KB);
+		c.setPackedGitMMAP("true".equals(System.getProperty("jgit.junit.usemmmap")));
+		c.setDeltaBaseCacheLimit(8 * WindowCacheConfig.KB);
+		WindowCache.reconfigure(c);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
index 677b3a7..13861bf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
@@ -42,8 +42,6 @@
 class UnpackedObjectCache {
 	private static final int CACHE_SZ = 1024;
 
-	private static final int MB = 1024 * 1024;
-
 	private static final SoftReference<Entry> DEAD;
 
 	private static int hash(final long position) {
@@ -62,14 +60,15 @@ private static int hash(final long position) {
 
 	static {
 		DEAD = new SoftReference<Entry>(null);
-		maxByteCount = 10 * MB;
+		maxByteCount = new WindowCacheConfig().getDeltaBaseCacheLimit();
 
 		cache = new Slot[CACHE_SZ];
 		for (int i = 0; i < CACHE_SZ; i++)
 			cache[i] = new Slot();
 	}
 
-	static synchronized void reconfigure(final int dbLimit) {
+	static synchronized void reconfigure(final WindowCacheConfig cfg) {
+		final int dbLimit = cfg.getDeltaBaseCacheLimit();
 		if (maxByteCount != dbLimit) {
 			maxByteCount = dbLimit;
 			releaseMemory();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 6a650cb..ba1124a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -46,10 +46,6 @@
  * the other windowed file access classes.
  */
 public class WindowCache {
-	private static final int KB = 1024;
-
-	private static final int MB = 1024 * KB;
-
 	private static final int bits(int newSize) {
 		if (newSize < 4096)
 			throw new IllegalArgumentException("Invalid window size");
@@ -77,10 +73,11 @@ private static final int bits(int newSize) {
 	private static int openByteCount;
 
 	static {
-		maxByteCount = 10 * MB;
-		windowSizeShift = bits(8 * KB);
+		final WindowCacheConfig c = new WindowCacheConfig();
+		maxByteCount = c.getPackedGitLimit();
+		windowSizeShift = bits(c.getPackedGitWindowSize());
 		windowSize = 1 << windowSizeShift;
-		mmap = false;
+		mmap = c.isPackedGitMMAP();
 		cache = new ByteWindow[cacheTableSize()];
 		clearedWindowQueue = new ReferenceQueue<Object>();
 	}
@@ -104,34 +101,53 @@ private static int cacheTableSize() {
 	 *            true to enable use of mmap when creating windows.
 	 * @param deltaBaseCacheLimit
 	 *            number of bytes to hold in the delta base cache.
+	 * @deprecated Use {@link WindowCacheConfig} instead.
 	 */
 	public static void reconfigure(final int packedGitLimit,
 			final int packedGitWindowSize, final boolean packedGitMMAP,
 			final int deltaBaseCacheLimit) {
-		reconfigureImpl(packedGitLimit, packedGitWindowSize, packedGitMMAP);
-		UnpackedObjectCache.reconfigure(deltaBaseCacheLimit);
+		final WindowCacheConfig c = new WindowCacheConfig();
+		c.setPackedGitLimit(packedGitLimit);
+		c.setPackedGitWindowSize(packedGitWindowSize);
+		c.setPackedGitMMAP(packedGitMMAP);
+		c.setDeltaBaseCacheLimit(deltaBaseCacheLimit);
+		reconfigure(c);
+	}
+
+	/**
+	 * Modify the configuration of the window cache.
+	 * <p>
+	 * The new configuration is applied immediately. If the new limits are
+	 * smaller than what what is currently cached, older entries will be purged
+	 * as soon as possible to allow the cache to meet the new limit.
+	 *
+	 * @param cfg
+	 *            the new window cache configuration.
+	 */
+	public static void reconfigure(final WindowCacheConfig cfg) {
+		reconfigureImpl(cfg);
+		UnpackedObjectCache.reconfigure(cfg);
 	}
 
-	private static synchronized void reconfigureImpl(final int packedGitLimit,
-			final int packedGitWindowSize, final boolean packedGitMMAP) {
+	private static synchronized void reconfigureImpl(final WindowCacheConfig cfg) {
 		boolean prune = false;
 		boolean evictAll = false;
 
-		if (maxByteCount < packedGitLimit) {
-			maxByteCount = packedGitLimit;
-		} else if (maxByteCount > packedGitLimit) {
-			maxByteCount = packedGitLimit;
+		if (maxByteCount < cfg.getPackedGitLimit()) {
+			maxByteCount = cfg.getPackedGitLimit();
+		} else if (maxByteCount > cfg.getPackedGitLimit()) {
+			maxByteCount = cfg.getPackedGitLimit();
 			prune = true;
 		}
 
-		if (bits(packedGitWindowSize) != windowSizeShift) {
-			windowSizeShift = bits(packedGitWindowSize);
+		if (bits(cfg.getPackedGitWindowSize()) != windowSizeShift) {
+			windowSizeShift = bits(cfg.getPackedGitWindowSize());
 			windowSize = 1 << windowSizeShift;
 			evictAll = true;
 		}
 
-		if (mmap != packedGitMMAP) {
-			mmap = packedGitMMAP;
+		if (mmap != cfg.isPackedGitMMAP()) {
+			mmap = cfg.isPackedGitMMAP();
 			evictAll = true;
 		}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
new file mode 100644
index 0000000..b4c4638
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCacheConfig.java
@@ -0,0 +1,134 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.lib;
+
+/** Configuration parameters for {@link WindowCache}. */
+public class WindowCacheConfig {
+	/** 1024 (number of bytes in one kibibyte/kilobyte) */
+	public static final int KB = 1024;
+
+	/** 1024 {@link #KB} (number of bytes in one mebibyte/megabyte) */
+	public static final int MB = 1024 * KB;
+
+	private int packedGitLimit;
+
+	private int packedGitWindowSize;
+
+	private boolean packedGitMMAP;
+
+	private int deltaBaseCacheLimit;
+
+	/** Create a default configuration. */
+	public WindowCacheConfig() {
+		packedGitLimit = 10 * MB;
+		packedGitWindowSize = 8 * KB;
+		packedGitMMAP = false;
+		deltaBaseCacheLimit = 10 * MB;
+	}
+
+	/**
+	 * @return maximum number bytes of heap memory to dedicate to caching pack
+	 *         file data. <b>Default is 10 MB.</b>
+	 */
+	public int getPackedGitLimit() {
+		return packedGitLimit;
+	}
+
+	/**
+	 * @param newLimit
+	 *            maximum number bytes of heap memory to dedicate to caching
+	 *            pack file data.
+	 */
+	public void setPackedGitLimit(final int newLimit) {
+		packedGitLimit = newLimit;
+	}
+
+	/**
+	 * @return size in bytes of a single window mapped or read in from the pack
+	 *         file. <b>Default is 8 KB.</b>
+	 */
+	public int getPackedGitWindowSize() {
+		return packedGitWindowSize;
+	}
+
+	/**
+	 * @param newSize
+	 *            size in bytes of a single window read in from the pack file.
+	 */
+	public void setPackedGitWindowSize(final int newSize) {
+		packedGitWindowSize = newSize;
+	}
+
+	/**
+	 * @return true enables use of Java NIO virtual memory mapping for windows;
+	 *         false reads entire window into a byte[] with standard read calls.
+	 *         <b>Default false.</b>
+	 */
+	public boolean isPackedGitMMAP() {
+		return packedGitMMAP;
+	}
+
+	/**
+	 * @param usemmap
+	 *            true enables use of Java NIO virtual memory mapping for
+	 *            windows; false reads entire window into a byte[] with standard
+	 *            read calls.
+	 */
+	public void setPackedGitMMAP(final boolean usemmap) {
+		packedGitMMAP = usemmap;
+	}
+
+	/**
+	 * @return maximum number of bytes to cache in {@link UnpackedObjectCache}
+	 *         for inflated, recently accessed objects, without delta chains.
+	 *         <b>Default 10 MB.</b>
+	 */
+	public int getDeltaBaseCacheLimit() {
+		return deltaBaseCacheLimit;
+	}
+
+	/**
+	 * @param newLimit
+	 *            maximum number of bytes to cache in
+	 *            {@link UnpackedObjectCache} for inflated, recently accessed
+	 *            objects, without delta chains.
+	 */
+	public void setDeltaBaseCacheLimit(final int newLimit) {
+		deltaBaseCacheLimit = newLimit;
+	}
+}
-- 
1.6.2.1.286.g8173
