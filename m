From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/23] Improve hit performance on the UnpackedObjectCache
Date: Wed, 24 Dec 2008 18:10:57 -0800
Message-ID: <1230171079-17156-2-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjE-00029A-Ov
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYLYCLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYLYCLW
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:22 -0500
Received: from george.spearce.org ([209.20.77.23]:59403 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbYLYCLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:22 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4322A38200; Thu, 25 Dec 2008 02:11:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5B91138200;
	Thu, 25 Dec 2008 02:11:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103872>

If the JVM cleared one of our SoftReferences we "leaked" the space in
the cache that the entry occupied.  Over time this meant we lost room
in the cache and didn't have a way to recover that when we replaced
the evicted entry.

The hash function was also too complex for the hit ratio we were
getting.  The old function on one of my linux-2.6 clones was giving
us <7% hit ratio; this new function is a little simpler to compute
and is getting ~11%.  Increasing the size of the hash table helps
matters considerably.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/UnpackedObjectCache.java  |   21 +++++++++----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
index ee6a680..677b3a7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UnpackedObjectCache.java
@@ -40,17 +40,14 @@
 import java.lang.ref.SoftReference;
 
 class UnpackedObjectCache {
-	private static final int CACHE_SZ = 256;
+	private static final int CACHE_SZ = 1024;
 
 	private static final int MB = 1024 * 1024;
 
 	private static final SoftReference<Entry> DEAD;
 
-	private static int hash(final WindowedFile pack, final long position) {
-		int h = pack.hash + (int) position;
-		h += h >>> 16;
-		h += h >>> 8;
-		return h & (CACHE_SZ - 1);
+	private static int hash(final long position) {
+		return (((int) position) << 22) >>> 22;
 	}
 
 	private static int maxByteCount;
@@ -80,7 +77,7 @@ static synchronized void reconfigure(final int dbLimit) {
 	}
 
 	static synchronized Entry get(final WindowedFile pack, final long position) {
-		final Slot e = cache[hash(pack, position)];
+		final Slot e = cache[hash(position)];
 		if (e.provider == pack && e.position == position) {
 			final Entry buf = e.data.get();
 			if (buf != null) {
@@ -96,7 +93,7 @@ static synchronized void store(final WindowedFile pack,
 		if (data.length > maxByteCount)
 			return; // Too large to cache.
 
-		final Slot e = cache[hash(pack, position)];
+		final Slot e = cache[hash(position)];
 		clearEntry(e);
 
 		openByteCount += data.length;
@@ -104,6 +101,7 @@ static synchronized void store(final WindowedFile pack,
 
 		e.provider = pack;
 		e.position = position;
+		e.sz = data.length;
 		e.data = new SoftReference<Entry>(new Entry(data, objectType));
 		moveToHead(e);
 	}
@@ -155,11 +153,10 @@ private static void unlink(final Slot e) {
 	}
 
 	private static void clearEntry(final Slot e) {
-		final Entry old = e.data.get();
-		if (old != null)
-			openByteCount -= old.data.length;
+		openByteCount -= e.sz;
 		e.provider = null;
 		e.data = DEAD;
+		e.sz = 0;
 	}
 
 	private UnpackedObjectCache() {
@@ -186,6 +183,8 @@ Entry(final byte[] aData, final int aType) {
 
 		long position;
 
+		int sz;
+
 		SoftReference<Entry> data = DEAD;
 	}
 }
-- 
1.6.1.rc4.301.g5497a
