From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/23] Rewrite WindowCache to use a hash table
Date: Wed, 24 Dec 2008 18:11:07 -0800
Message-ID: <1230171079-17156-12-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjM-00029A-Ei
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYLYCLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbYLYCLq
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:46 -0500
Received: from george.spearce.org ([209.20.77.23]:59420 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbYLYCL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:27 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 30D17382A6; Thu, 25 Dec 2008 02:11:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5CFC938265;
	Thu, 25 Dec 2008 02:11:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103879>

This shaved 10s off my linux-2.6 "jgit rev-list --objects" test.
We're also getting slightly better cache hit ratios, approaching
95% during commit access and 80% during tree access on the same
repository.  Its a significant win.

The cache is also a bit better about memory usage.  We now make
sure the byte[] or ByteBuffer handle is cleared out of the soft
reference when we push the reference into the queue manually. A
small change, but it makes a marked difference with the overall
JVM memory usage.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ByteWindow.java       |   10 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |  323 ++++++++++++--------
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    2 +-
 3 files changed, 199 insertions(+), 136 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
index 1f6beb8..8d37de7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
@@ -56,14 +56,20 @@
  *            type of object reference used to manage the window data.
  */
 abstract class ByteWindow<T> extends SoftReference<T> {
+	boolean sizeActive = true;
+
+	ByteWindow<?> chainNext;
+
+	ByteWindow<?> lruPrev;
+
+	ByteWindow<?> lruNext;
+
 	final WindowedFile provider;
 
 	final int id;
 
 	final int size;
 
-	int lastAccessed;
-
 	final long start;
 
 	final long end;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index f617845..f478f04 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Google Inc.
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
  *
  * All rights reserved.
@@ -41,11 +41,7 @@
 import java.io.IOException;
 import java.lang.ref.ReferenceQueue;
 
-/**
- * The WindowCache manages reusable <code>Windows</code> and inflaters used by
- * the other windowed file access classes.
- */
-public class WindowCache {
+class WindowCache {
 	private static final int KB = 1024;
 
 	private static final int MB = 1024 * KB;
@@ -68,23 +64,51 @@ private static final int bits(int newSize) {
 
 	static final ReferenceQueue<?> clearedWindowQueue;
 
-	private static ByteWindow[] windows;
+	private static ByteWindow[] cache;
+
+	private static ByteWindow lruHead;
 
-	private static int openWindowCount;
+	private static ByteWindow lruTail;
 
 	private static int openByteCount;
 
-	private static int accessClock;
+	private static int hits;
+
+	private static int reqs;
+
+	private static int opens;
+
+	private static int closes;
 
 	static {
 		maxByteCount = 10 * MB;
 		windowSizeShift = bits(8 * KB);
 		windowSize = 1 << windowSizeShift;
 		mmap = false;
-		windows = new ByteWindow[maxByteCount / windowSize];
+		cache = new ByteWindow[cacheTableSize()];
 		clearedWindowQueue = new ReferenceQueue<Object>();
 	}
 
+	static synchronized String statString() {
+		int maxChain = 0, tot = 0;
+		for (ByteWindow<?> e : cache) {
+			int n = 0;
+			for (; e != null; e = e.chainNext) {
+				n++;
+				tot++;
+			}
+			maxChain = Math.max(maxChain, n);
+		}
+		return "WindowCache[ hits: " + (hits * 100 / reqs) + "%"
+				+ "; windows: " + tot + " maxChain: " + maxChain + "; kb:"
+				+ (openByteCount / KB) + "; cache: " + cache.length + " fds: "
+				+ (opens - closes) + "," + opens + "," + closes + " ]";
+	}
+
+	private static int cacheTableSize() {
+		return 5 * (maxByteCount / windowSize) / 2;
+	}
+
 	/**
 	 * Modify the configuration of the window cache.
 	 * <p>
@@ -135,27 +159,36 @@ private static synchronized void reconfigureImpl(final int packedGitLimit,
 			// We have to throw away every window we have. None
 			// of them are suitable for the new configuration.
 			//
-			for (int i = 0; i < openWindowCount; i++) {
-				final ByteWindow win = windows[i];
-				if (--win.provider.openCount == 0)
-					win.provider.cacheClose();
-				windows[i] = null;
+			for (ByteWindow<?> e : cache) {
+				for (; e != null; e = e.chainNext)
+					clear(e);
+			}
+			runClearedWindowQueue();
+			cache = new ByteWindow[cacheTableSize()];
+
+		} else {
+			if (prune) {
+				// We should decrease our memory usage.
+				//
+				releaseMemory();
+				runClearedWindowQueue();
 			}
-			windows = new ByteWindow[maxByteCount / windowSize];
-			openWindowCount = 0;
-			openByteCount = 0;
-		} else if (prune) {
-			// Our memory limit was decreased so we should try
-			// to drop windows to ensure we meet the new lower
-			// limit we were just given.
-			//
-			final int wincnt = maxByteCount / windowSize;
-			releaseMemory(wincnt, null, 0, 0);
 
-			if (wincnt != windows.length) {
-				final ByteWindow[] n = new ByteWindow[wincnt];
-				System.arraycopy(windows, 0, n, 0, openWindowCount);
-				windows = n;
+			if (cache.length != cacheTableSize()) {
+				// The cache table should be resized.
+				// Rehash every entry.
+				//
+				final ByteWindow[] priorTable = cache;
+
+				cache = new ByteWindow[cacheTableSize()];
+				for (ByteWindow<?> e : priorTable) {
+					for (ByteWindow<?> n; e != null; e = n) {
+						n = e.chainNext;
+						final int idx = hash(e.provider, e.id);
+						e.chainNext = cache[idx];
+						cache[idx] = e;
+					}
+				}
 			}
 		}
 	}
@@ -178,19 +211,27 @@ private static synchronized void reconfigureImpl(final int packedGitLimit,
 	 */
 	public static synchronized final void get(final WindowCursor curs,
 			final WindowedFile wp, final long position) throws IOException {
+		reqs++;
 		final int id = (int) (position >> windowSizeShift);
-		int idx = binarySearch(wp, id);
-		if (0 <= idx) {
-			final ByteWindow<?> w = windows[idx];
-			if ((curs.handle = w.get()) != null) {
-				w.lastAccessed = ++accessClock;
-				curs.window = w;
-				return;
+		final int idx = hash(wp, id);
+		for (ByteWindow<?> e = cache[idx]; e != null; e = e.chainNext) {
+			if (e.provider == wp && e.id == id) {
+				if ((curs.handle = e.get()) != null) {
+					curs.window = e;
+					makeMostRecent(e);
+					hits++;
+					return;
+				}
+
+				clear(e);
+				break;
 			}
 		}
 
-		if (++wp.openCount == 1) {
+		if (wp.openCount == 0) {
 			try {
+				opens++;
+				wp.openCount = 1;
 				wp.cacheOpen();
 			} catch (IOException ioe) {
 				wp.openCount = 0;
@@ -201,106 +242,55 @@ public static synchronized final void get(final WindowCursor curs,
 			} catch (Error ioe) {
 				wp.openCount = 0;
 				throw ioe;
+			} finally {
+				wp.openCount--;
 			}
 
 			// The cacheOpen may have mapped the window we are trying to
 			// map ourselves. Retrying the search ensures that does not
 			// happen to us.
 			//
-			idx = binarySearch(wp, id);
-			if (0 <= idx) {
-				final ByteWindow<?> w = windows[idx];
-				if ((curs.handle = w.get()) != null) {
-					w.lastAccessed = ++accessClock;
-					curs.window = w;
-					return;
+			for (ByteWindow<?> e = cache[idx]; e != null; e = e.chainNext) {
+				if (e.provider == wp && e.id == id) {
+					if ((curs.handle = e.get()) != null) {
+						curs.window = e;
+						makeMostRecent(e);
+						return;
+					}
+
+					clear(e);
+					break;
 				}
 			}
 		}
 
-		idx = -(idx + 1);
-		final int wSz = windowSize(wp, id);
-		idx = releaseMemory(windows.length, wp, idx, wSz);
-
-		if (idx < 0)
-			idx = 0;
-		final int toMove = openWindowCount - idx;
-		if (toMove > 0)
-			System.arraycopy(windows, idx, windows, idx + 1, toMove);
-		wp.loadWindow(curs, id, id << windowSizeShift, wSz);
-		windows[idx] = curs.window;
-		openWindowCount++;
-		openByteCount += curs.window.size;
+		final int wsz = windowSize(wp, id);
+		wp.openCount++;
+		openByteCount += wsz;
+		releaseMemory();
+		runClearedWindowQueue();
+
+		wp.loadWindow(curs, id, id << windowSizeShift, wsz);
+		final ByteWindow<?> e = curs.window;
+		e.chainNext = cache[idx];
+		cache[idx] = e;
+		insertLRU(e);
 	}
 
-	private static int releaseMemory(final int maxWindowCount,
-			final WindowedFile willRead, int insertionIndex, final int willAdd) {
-		for (;;) {
-			final ByteWindow<?> w = (ByteWindow<?>) clearedWindowQueue.poll();
-			if (w == null)
-				break;
-			final int oldest = binarySearch(w.provider, w.id);
-			if (oldest < 0 || windows[oldest] != w)
-				continue; // Must have been evicted by our other controls.
-
-			final WindowedFile p = w.provider;
-			if (--p.openCount == 0 && p != willRead)
-				p.cacheClose();
-
-			openByteCount -= w.size;
-			final int toMove = openWindowCount - oldest - 1;
-			if (toMove > 0)
-				System.arraycopy(windows, oldest + 1, windows, oldest, toMove);
-			windows[--openWindowCount] = null;
-			if (oldest < insertionIndex)
-				insertionIndex--;
-		}
-
-		while (openWindowCount >= maxWindowCount
-				|| (openWindowCount > 0 && openByteCount + willAdd > maxByteCount)) {
-			int oldest = 0;
-			for (int k = openWindowCount - 1; k > 0; k--) {
-				if (windows[k].lastAccessed < windows[oldest].lastAccessed)
-					oldest = k;
-			}
-
-			final ByteWindow w = windows[oldest];
-			final WindowedFile p = w.provider;
-			if (--p.openCount == 0 && p != willRead)
-				p.cacheClose();
-
-			openByteCount -= w.size;
-			final int toMove = openWindowCount - oldest - 1;
-			if (toMove > 0)
-				System.arraycopy(windows, oldest + 1, windows, oldest, toMove);
-			windows[--openWindowCount] = null;
-			w.enqueue();
-			if (oldest < insertionIndex)
-				insertionIndex--;
+	private static void makeMostRecent(ByteWindow<?> e) {
+		if (lruHead != e) {
+			unlinkLRU(e);
+			insertLRU(e);
 		}
-
-		return insertionIndex;
 	}
 
-	private static final int binarySearch(final WindowedFile sprov,
-			final int sid) {
-		if (openWindowCount == 0)
-			return -1;
-		final int shc = sprov.hash;
-		int high = openWindowCount;
-		int low = 0;
-		do {
-			final int mid = (low + high) / 2;
-			final ByteWindow mw = windows[mid];
-			if (mw.provider == sprov && mw.id == sid)
-				return mid;
-			final int mhc = mw.provider.hash;
-			if (mhc < shc || (shc == mhc && mw.id < sid))
-				low = mid + 1;
-			else
-				high = mid;
-		} while (low < high);
-		return -(low + 1);
+	private static void releaseMemory() {
+		ByteWindow<?> e = lruTail;
+		while (openByteCount > maxByteCount && e != null) {
+			final ByteWindow<?> p = e.lruPrev;
+			clear(e);
+			e = p;
+		}
 	}
 
 	/**
@@ -316,22 +306,89 @@ private static final int binarySearch(final WindowedFile sprov,
 	 *            cache.
 	 */
 	public static synchronized final void purge(final WindowedFile wp) {
-		int d = 0;
-		for (int s = 0; s < openWindowCount; s++) {
-			final ByteWindow win = windows[s];
-			if (win.provider != wp)
-				windows[d++] = win;
-			else
-				openByteCount -= win.size;
+		for (ByteWindow e : cache) {
+			for (; e != null; e = e.chainNext) {
+				if (e.provider == wp)
+					clear(e);
+			}
+		}
+		runClearedWindowQueue();
+	}
+
+	private static void runClearedWindowQueue() {
+		ByteWindow<?> e;
+		while ((e = (ByteWindow) clearedWindowQueue.poll()) != null) {
+			unlinkSize(e);
+			unlinkLRU(e);
+			unlinkCache(e);
+			e.chainNext = null;
+			e.lruNext = null;
+			e.lruPrev = null;
 		}
-		openWindowCount = d;
+	}
+
+	private static void clear(final ByteWindow<?> e) {
+		unlinkSize(e);
+		e.clear();
+		e.enqueue();
+	}
 
-		if (wp.openCount > 0) {
-			wp.openCount = 0;
-			wp.cacheClose();
+	private static void unlinkSize(final ByteWindow<?> e) {
+		if (e.sizeActive) {
+			if (--e.provider.openCount == 0) {
+				closes++;
+				e.provider.cacheClose();
+			}
+			openByteCount -= e.size;
+			e.sizeActive = false;
 		}
 	}
 
+	private static void unlinkCache(final ByteWindow dead) {
+		final int idx = hash(dead.provider, dead.id);
+		ByteWindow<?> e = cache[idx], p = null, n;
+		for (; e != null; p = e, e = n) {
+			n = e.chainNext;
+			if (e == dead) {
+				if (p == null)
+					cache[idx] = n;
+				else
+					p.chainNext = n;
+				break;
+			}
+		}
+	}
+
+	private static void unlinkLRU(final ByteWindow e) {
+		final ByteWindow<?> prev = e.lruPrev;
+		final ByteWindow<?> next = e.lruNext;
+
+		if (prev != null)
+			prev.lruNext = next;
+		else
+			lruHead = next;
+
+		if (next != null)
+			next.lruPrev = prev;
+		else
+			lruTail = prev;
+	}
+
+	private static void insertLRU(final ByteWindow<?> e) {
+		final ByteWindow h = lruHead;
+		e.lruPrev = null;
+		e.lruNext = h;
+		if (h != null)
+			h.lruPrev = e;
+		else
+			lruTail = e;
+		lruHead = e;
+	}
+
+	private static int hash(final WindowedFile wp, final int id) {
+		return ((wp.hash + id) >>> 1) % cache.length;
+	}
+
 	private static int windowSize(final WindowedFile file, final int id) {
 		final long len = file.length();
 		final long pos = id << windowSizeShift;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index dd94f24..9c5cf1e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -88,7 +88,7 @@
 	 */
 	public WindowedFile(final File file) {
 		fPath = file;
-		hash = System.identityHashCode(this);
+		hash = System.identityHashCode(this) * 31;
 		length = Long.MAX_VALUE;
 	}
 
-- 
1.6.1.rc4.301.g5497a
