From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 12/23] Change ByteArrayWindow to read content outside of WindowCache's lock
Date: Wed, 24 Dec 2008 18:11:08 -0800
Message-ID: <1230171079-17156-13-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
 <1230171079-17156-6-git-send-email-spearce@spearce.org>
 <1230171079-17156-7-git-send-email-spearce@spearce.org>
 <1230171079-17156-8-git-send-email-spearce@spearce.org>
 <1230171079-17156-9-git-send-email-spearce@spearce.org>
 <1230171079-17156-10-git-send-email-spearce@spearce.org>
 <1230171079-17156-11-git-send-email-spearce@spearce.org>
 <1230171079-17156-12-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjN-00029A-49
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbYLYCLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbYLYCLs
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:48 -0500
Received: from george.spearce.org ([209.20.77.23]:59414 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbYLYCL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:28 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id B1481382A4; Thu, 25 Dec 2008 02:11:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B484138210;
	Thu, 25 Dec 2008 02:11:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103875>

This improves the concurrency limit of WindowCache by allowing the
individual windows to be paged in outside of the cache lock.  By
moving it out multiple threads can read in different windows of
the same (or different) pack files concurrently, but we still do
only one read per window.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |   17 +++++++++++++++++
 .../src/org/spearce/jgit/lib/WindowCache.java      |    2 +-
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   15 +++++++--------
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
index cea71be..b32d4f8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
@@ -38,6 +38,8 @@
 
 package org.spearce.jgit.lib;
 
+import java.io.IOException;
+import java.nio.ByteBuffer;
 import java.util.zip.DataFormatException;
 import java.util.zip.Inflater;
 
@@ -45,6 +47,8 @@
  * A {@link ByteWindow} with an underlying byte array for storage.
  */
 final class ByteArrayWindow extends ByteWindow<byte[]> {
+	boolean loaded;
+
 	/**
 	 * Constructor for ByteWindow.
 	 * 
@@ -64,6 +68,7 @@ ByteArrayWindow(final WindowedFile o, final long p, final int d,
 	}
 
 	int copy(final byte[] array, final int p, final byte[] b, final int o, int n) {
+		ensureLoaded(array);
 		n = Math.min(array.length - p, n);
 		System.arraycopy(array, p, b, o, n);
 		return n;
@@ -71,6 +76,7 @@ int copy(final byte[] array, final int p, final byte[] b, final int o, int n) {
 
 	int inflate(final byte[] array, final int pos, final byte[] b, int o,
 			final Inflater inf) throws DataFormatException {
+		ensureLoaded(array);
 		while (!inf.finished()) {
 			if (inf.needsInput()) {
 				inf.setInput(array, pos, array.length - pos);
@@ -82,4 +88,15 @@ int inflate(final byte[] array, final int pos, final byte[] b, int o,
 			o += inf.inflate(b, o, b.length - o);
 		return o;
 	}
+
+	private synchronized void ensureLoaded(final byte[] array) {
+		if (!loaded) {
+			try {
+				provider.fd.getChannel().read(ByteBuffer.wrap(array), start);
+			} catch (IOException e) {
+				throw new RuntimeException("Cannot fault in window", e);
+			}
+			loaded = true;
+		}
+	}
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index f478f04..649567b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -270,7 +270,7 @@ public static synchronized final void get(final WindowCursor curs,
 		releaseMemory();
 		runClearedWindowQueue();
 
-		wp.loadWindow(curs, id, id << windowSizeShift, wsz);
+		wp.allocWindow(curs, id, id << windowSizeShift, wsz);
 		final ByteWindow<?> e = curs.window;
 		e.chainNext = cache[idx];
 		cache[idx] = e;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 9c5cf1e..7626693 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -73,7 +73,7 @@
 
 	final int hash;
 
-	private RandomAccessFile fd;
+	RandomAccessFile fd;
 
 	private long length;
 
@@ -298,8 +298,8 @@ void cacheClose() {
 		fd = null;
 	}
 
-	void loadWindow(final WindowCursor curs, final int windowId,
-			final long pos, final int size) throws IOException {
+	void allocWindow(final WindowCursor curs, final int windowId,
+			final long pos, final int size) {
 		if (WindowCache.mmap) {
 			MappedByteBuffer map;
 			try {
@@ -323,7 +323,10 @@ void loadWindow(final WindowCursor curs, final int windowId,
 			if (map != null) {
 				if (map.hasArray()) {
 					final byte[] b = map.array();
-					curs.window = new ByteArrayWindow(this, pos, windowId, b);
+					final ByteArrayWindow w;
+					w = new ByteArrayWindow(this, pos, windowId, b);
+					w.loaded = true;
+					curs.window = w;
 					curs.handle = b;
 				} else {
 					curs.window = new ByteBufferWindow(this, pos, windowId, map);
@@ -334,10 +337,6 @@ void loadWindow(final WindowCursor curs, final int windowId,
 		}
 
 		final byte[] b = new byte[size];
-		synchronized (fd) {
-			fd.seek(pos);
-			fd.readFully(b);
-		}
 		curs.window = new ByteArrayWindow(this, pos, windowId, b);
 		curs.handle = b;
 	}
-- 
1.6.1.rc4.301.g5497a
