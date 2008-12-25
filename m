From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/23] Make mmap mode more reliable by forcing GC at the correct spot
Date: Wed, 24 Dec 2008 18:11:06 -0800
Message-ID: <1230171079-17156-11-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjL-00029A-PI
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYLYCLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYLYCLo
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:44 -0500
Received: from george.spearce.org ([209.20.77.23]:59416 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYLYCL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:26 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 485E338260; Thu, 25 Dec 2008 02:11:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 188F338221;
	Thu, 25 Dec 2008 02:11:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103878>

ObjectLoaders can defer the bulk of their data access to the
getCachedBytes() method invocation, rather than at the time
of their construction.  That means there's code paths into
the mmap allocator which aren't protected by the "try GC and
try again" within openObject, resulting in some random crashes
due to mmap failures.

The right place to check for mmap failure and retry is within
WindowedFile.loadWindow, where we actually invoke the mmap call.
If the call fails, we need can immediately retry it, and if it
fails again, we can temporarily degrade to the byte[] variant
until the JVM is able to evict and GC enough space.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   27 +-----------
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   43 ++++++++++++++-----
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 02f8103..e1c4049 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -290,30 +290,9 @@ public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId id)
 		int k = packs.length;
 		if (k > 0) {
 			do {
-				try {
-					final ObjectLoader ol = packs[--k].get(curs, id);
-					if (ol != null)
-						return ol;
-				} catch (IOException ioe) {
-					// This shouldn't happen unless the pack was corrupted
-					// after we opened it or the VM runs out of memory. This is
-					// a know problem with memory mapped I/O in java and have
-					// been noticed with JDK < 1.6. Tell the gc that now is a good
-					// time to collect and try once more.
-					try {
-						curs.release();
-						System.gc();
-						final ObjectLoader ol = packs[k].get(curs, id);
-						if (ol != null)
-							return ol;
-					} catch (IOException ioe2) {
-						ioe2.printStackTrace();
-						ioe.printStackTrace();
-						// Still fails.. that's BAD, maybe the pack has
-						// been corrupted after all, or the gc didn't manage
-						// to release enough previously mmaped areas.
-					}
-				}
+				final ObjectLoader ol = packs[--k].get(curs, id);
+				if (ol != null)
+					return ol;
 			} while (k > 0);
 		}
 		try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index f640c42..dd94f24 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -299,22 +299,41 @@ void cacheClose() {
 	}
 
 	void loadWindow(final WindowCursor curs, final int windowId,
-			final long pos, final int windowSize) throws IOException {
+			final long pos, final int size) throws IOException {
 		if (WindowCache.mmap) {
-			final MappedByteBuffer map = fd.getChannel().map(MapMode.READ_ONLY,
-					pos, windowSize);
-			if (map.hasArray()) {
-				final byte[] b = map.array();
-				curs.window = new ByteArrayWindow(this, pos, windowId, b);
-				curs.handle = b;
-			} else {
-				curs.window = new ByteBufferWindow(this, pos, windowId, map);
-				curs.handle = map;
+			MappedByteBuffer map;
+			try {
+				map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
+			} catch (IOException e) {
+				// The most likely reason this failed is the JVM has run out
+				// of virtual memory. We need to discard quickly, and try to
+				// force the GC to finalize and release any existing mappings.
+				try {
+					curs.release();
+					System.gc();
+					System.runFinalization();
+					map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
+				} catch (IOException ioe2) {
+					// Temporarily disable mmap and do buffered disk IO.
+					//
+					map = null;
+					System.err.println("warning: mmap failure: "+ioe2);
+				}
+			}
+			if (map != null) {
+				if (map.hasArray()) {
+					final byte[] b = map.array();
+					curs.window = new ByteArrayWindow(this, pos, windowId, b);
+					curs.handle = b;
+				} else {
+					curs.window = new ByteBufferWindow(this, pos, windowId, map);
+					curs.handle = map;
+				}
+				return;
 			}
-			return;
 		}
 
-		final byte[] b = new byte[windowSize];
+		final byte[] b = new byte[size];
 		synchronized (fd) {
 			fd.seek(pos);
 			fd.readFully(b);
-- 
1.6.1.rc4.301.g5497a
