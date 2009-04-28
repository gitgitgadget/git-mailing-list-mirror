From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT RFC PATCH 2/2] Rewrite WindowCache to be easier to follow and maintain
Date: Mon, 27 Apr 2009 19:26:12 -0700
Message-ID: <1240885572-1755-2-git-send-email-spearce@spearce.org>
References: <1240885572-1755-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 04:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyd1w-0008Ct-Rq
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 04:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158AbZD1C0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 22:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbZD1C0U
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 22:26:20 -0400
Received: from george.spearce.org ([209.20.77.23]:45133 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbZD1C0R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 22:26:17 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D72B338215; Tue, 28 Apr 2009 02:26:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9F0DB38211;
	Tue, 28 Apr 2009 02:26:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240885572-1755-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117743>

The integration of WindowCache, ByteWindow, PackFile and WindowCursor
was a spaghetti of code that was impossible for even the original
author (me) to follow.  Due to the way the responsibility for the
PackFile's open RandomAccessFile "fd" was distributed between these
four classes I could no longer prove to myself that the fd wouldn't
be closed while it was being accessed by another thread.

This rewrite generalizes most of the cache logic into a new class,
OffsetCache.  The hope is that we can later reuse this code to make a
rewrite of UnpackedObjectCache, which uses similiar caching rules as
the WindowCache, but applies a different hash function.  That rewrite
is deferred to another change, but is anticipated by this one.

The new OffsetCache class uses the Java 5 atomic APIs to create a
much more concurrent hash table than we had before.  We can now
perform no-miss reads without taking any locks.  Reads that do
miss acquire a lock in order to prevent concurrent threads from
performing duplicate work loading the same window from disk,
however concurrent reads of different windows is still permitted.

Due to the more concurrent nature of the OffsetCache, it is now
possible for the cache to temporarily overshoot its resource limits.
This is a small temporary overshoot that is roughly bounded by the
number of concurrent threads operating against the same cache.

The API of the ByteWindow subclasses is now simplified by removing
the base class of SoftReference.  It was a horrible idea to pass
the byte[] or MappedByteBuffer down through the call stack when the
implementation knew what type it should be operating on.  We now
instead use a more traditional OO pattern of allowing the subclass
to directly specify its referent.

Responsibility for the RandomAccessFile "fd" within PackFile is now
strictly within PackFile.  Two open reference counts track how the
callers are using the fd, ensuring that the fd remains open, so long
as the caller has made the appropriate begin*() invocation prior
to data access.  One counter, beginWindowCache() is exclusively
for the ByteWindows created by WindowCache.  Another counter,
beginCopyRawData(), is exclusively for PackWriter's need to lock
the PackFile open while it performs object reuse.

To keep the code simple a WindowCache.reconfigure() now discards the
entire current cache, and creates a new one.  That invalidates every
open file, and every open ByteWindow, and forces them to load again.

reconfigure is no longer a thread safe operation, as there is no easy
way to lock out other threads while the cache change is taking place.
I don't think cache reconfigurations occur frequently enough in
application code that we can justify the additional overhead required
by a multi-reader/single-writer lock around every cache access.
Instead, the Javadoc is updated to warn application authors against
changing this on the fly.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I'm tossing this out there for tonight.  Please don't apply until
 I give a final yay or nay.

 I think the code is easier to follow once this patch is applied
 due to the scope of responsibilities being restored back to their
 proper OO-theory suggested classes.  The re-write of WindowCache
 is horrible to read as a diff, sorry.

 At present, it passes all of the unit tests.  It passes my minimal
 concurrent clone test.  At first glance, it runs within the same
 performance bounds as the prior code on a single thread clone test.

 I have not yet done any performance tests with more than one
 concurrent clone client.  I don't yet have hard performance test
 results to give you to back up my claims that its no worse in
 single thread usage, or that it should perform better in server
 environments.

 I'm going to burn this in tonight for about 12 hours by pounding
 a whole bunch of clients against it.  If that load test goes well
 tomorrow morning, I'll try to work up more concrete performance
 test data to at least show we're no worse off than before in that
 department, and ask you to apply it.

 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |    4 -
 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |   57 +--
 .../src/org/spearce/jgit/lib/ByteBufferWindow.java |   41 +-
 .../src/org/spearce/jgit/lib/ByteWindow.java       |   91 +---
 .../src/org/spearce/jgit/lib/OffsetCache.java      |  522 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |  123 +++--
 .../org/spearce/jgit/lib/PackedObjectLoader.java   |    4 +-
 .../src/org/spearce/jgit/lib/WindowCache.java      |  408 ++++------------
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   42 +-
 9 files changed, 763 insertions(+), 529 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
index b56e0f4..fa6345e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
@@ -170,10 +170,6 @@ public void testObjectMovedToNewPack2()
 
 	private static void whackCache() {
 		final WindowCacheConfig config = new WindowCacheConfig();
-
-		config.setPackedGitOpenFiles(0);
-		WindowCache.reconfigure(config);
-
 		config.setPackedGitOpenFiles(1);
 		WindowCache.reconfigure(config);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
index 5dc3d28..6b96b10 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
@@ -38,41 +38,29 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.IOException;
-import java.nio.ByteBuffer;
 import java.util.zip.DataFormatException;
 import java.util.zip.Inflater;
 
 /**
  * A {@link ByteWindow} with an underlying byte array for storage.
  */
-final class ByteArrayWindow extends ByteWindow<byte[]> {
-	boolean loaded;
+final class ByteArrayWindow extends ByteWindow {
+	private final byte[] array;
 
-	/**
-	 * Constructor for ByteWindow.
-	 * 
-	 * @param o
-	 *            the PackFile providing data access
-	 * @param p
-	 *            the file offset.
-	 * @param d
-	 *            an id provided by the PackFile. See
-	 *            {@link WindowCache#get(WindowCursor, PackFile, long)}.
-	 * @param b
-	 *            byte array for storage
-	 */
-	ByteArrayWindow(final PackFile o, final long p, final int d, final byte[] b) {
-		super(o, p, d, b, b.length);
+	ByteArrayWindow(final PackFile pack, final long o, final byte[] b) {
+		super(pack, o, b.length);
+		array = b;
 	}
 
-	int copy(final byte[] array, final int p, final byte[] b, final int o, int n) {
+	@Override
+	protected int copy(final int p, final byte[] b, final int o, int n) {
 		n = Math.min(array.length - p, n);
 		System.arraycopy(array, p, b, o, n);
 		return n;
 	}
 
-	int inflate(final byte[] array, final int pos, final byte[] b, int o,
+	@Override
+	protected int inflate(final int pos, final byte[] b, int o,
 			final Inflater inf) throws DataFormatException {
 		while (!inf.finished()) {
 			if (inf.needsInput()) {
@@ -86,7 +74,8 @@ int inflate(final byte[] array, final int pos, final byte[] b, int o,
 		return o;
 	}
 
-	void inflateVerify(final byte[] array, final int pos, final Inflater inf)
+	@Override
+	protected void inflateVerify(final int pos, final Inflater inf)
 			throws DataFormatException {
 		while (!inf.finished()) {
 			if (inf.needsInput()) {
@@ -98,26 +87,4 @@ void inflateVerify(final byte[] array, final int pos, final Inflater inf)
 		while (!inf.finished() && !inf.needsInput())
 			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
 	}
-
-	void ensureLoaded(final byte[] array) {
-		boolean release = false;
-		try {
-			synchronized (this) {
-				if (!loaded) {
-					release = true;
-					try {
-						provider.fd.getChannel().read(ByteBuffer.wrap(array),
-								start);
-					} catch (IOException e) {
-						throw new RuntimeException("Cannot fault in window", e);
-					}
-					loaded = true;
-				}
-			}
-		} finally {
-			if (release) {
-				WindowCache.markLoaded(this);
-			}
-		}
-	}
-}
\ No newline at end of file
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
index 01956fd..f9de9b4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
@@ -47,24 +47,16 @@
  *
  * @see ByteWindow
  */
-final class ByteBufferWindow extends ByteWindow<ByteBuffer> {
-	/**
-	 * Constructor.
-	 *
-	 * @See ByteWindow
-	 *
-	 * @param o The PackFile
-	 * @param p the file offset.
-	 * @param d Window id
-	 * @param b ByteBuffer storage
-	 */
-	ByteBufferWindow(final PackFile o, final long p, final int d,
-			final ByteBuffer b) {
-		super(o, p, d, b, b.capacity());
+final class ByteBufferWindow extends ByteWindow {
+	private final ByteBuffer buffer;
+
+	ByteBufferWindow(final PackFile pack, final long o, final ByteBuffer b) {
+		super(pack, o, b.capacity());
+		buffer = b;
 	}
 
-	final int copy(final ByteBuffer buffer, final int p, final byte[] b,
-			final int o, int n) {
+	@Override
+	protected int copy(final int p, final byte[] b, final int o, int n) {
 		final ByteBuffer s = buffer.slice();
 		s.position(p);
 		n = Math.min(s.remaining(), n);
@@ -72,9 +64,9 @@ final int copy(final ByteBuffer buffer, final int p, final byte[] b,
 		return n;
 	}
 
-	int inflate(final ByteBuffer buffer, final int pos, final byte[] b, int o,
-			final Inflater inf)
-			throws DataFormatException {
+	@Override
+	protected int inflate(final int pos, final byte[] b, int o,
+			final Inflater inf) throws DataFormatException {
 		final byte[] tmp = new byte[512];
 		final ByteBuffer s = buffer.slice();
 		s.position(pos);
@@ -91,8 +83,9 @@ int inflate(final ByteBuffer buffer, final int pos, final byte[] b, int o,
 		return o;
 	}
 
-	void inflateVerify(final ByteBuffer buffer, final int pos,
-			final Inflater inf) throws DataFormatException {
+	@Override
+	protected void inflateVerify(final int pos, final Inflater inf)
+			throws DataFormatException {
 		final byte[] tmp = new byte[512];
 		final ByteBuffer s = buffer.slice();
 		s.position(pos);
@@ -107,8 +100,4 @@ void inflateVerify(final ByteBuffer buffer, final int pos,
 		while (!inf.finished() && !inf.needsInput())
 			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
 	}
-
-	void ensureLoaded(final ByteBuffer ref) {
-		// Do nothing.
-	}
-}
\ No newline at end of file
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
index 0d01fca..e0bda2d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
@@ -38,8 +38,6 @@
 
 package org.spearce.jgit.lib;
 
-import java.lang.ref.ReferenceQueue;
-import java.lang.ref.SoftReference;
 import java.util.zip.DataFormatException;
 import java.util.zip.Inflater;
 
@@ -51,64 +49,31 @@
  * is very low and has paged part of this process out to disk. Therefore copying
  * bytes from a window is very inexpensive.
  * </p>
- * 
- * @param <T>
- *            type of object reference used to manage the window data.
  */
-abstract class ByteWindow<T> extends SoftReference<T> {
-	boolean sizeActive = true;
+abstract class ByteWindow {
+	protected final PackFile pack;
 
-	ByteWindow<?> chainNext;
+	protected final long start;
 
-	ByteWindow<?> lruPrev;
+	protected final long end;
 
-	ByteWindow<?> lruNext;
-
-	final PackFile provider;
-
-	final int id;
-
-	final int size;
-
-	final long start;
-
-	final long end;
+	protected ByteWindow(final PackFile p, final long s, final int n) {
+		pack = p;
+		start = s;
+		end = start + n;
+	}
 
-	/**
-	 * Constructor for ByteWindow.
-	 * 
-	 * @param o
-	 *            the PackFile providing data access
-	 * @param pos
-	 *            the position in the file the data comes from.
-	 * @param d
-	 *            an id provided by the PackFile. See
-	 *            {@link WindowCache#get(WindowCursor, PackFile, long)}.
-	 * @param ref
-	 *            the object value required to perform data access.
-	 * @param sz
-	 *            the total number of bytes in this window.
-	 */
-	@SuppressWarnings("unchecked")
-	ByteWindow(final PackFile o, final long pos, final int d, final T ref,
-			final int sz) {
-		super(ref, (ReferenceQueue<T>) WindowCache.clearedWindowQueue);
-		provider = o;
-		size = sz;
-		id = d;
-		start = pos;
-		end = start + size;
+	final int size() {
+		return (int) (end - start);
 	}
 
 	final boolean contains(final PackFile neededFile, final long neededPos) {
-		return provider == neededFile && start <= neededPos && neededPos < end;
+		return pack == neededFile && start <= neededPos && neededPos < end;
 	}
 
 	/**
 	 * Copy bytes from the window to a caller supplied buffer.
 	 * 
-	 * @param ref
-	 *            the object value required to perform data access.
 	 * @param pos
 	 *            offset within the file to start copying from.
 	 * @param dstbuf
@@ -123,15 +88,13 @@ final boolean contains(final PackFile neededFile, final long neededPos) {
 	 *         <code>cnt</code> if <code>cnt</code> exceeded the number of
 	 *         bytes available.
 	 */
-	final int copy(T ref, long pos, byte[] dstbuf, int dstoff, int cnt) {
-		return copy(ref, (int) (pos - start), dstbuf, dstoff, cnt);
+	final int copy(long pos, byte[] dstbuf, int dstoff, int cnt) {
+		return copy((int) (pos - start), dstbuf, dstoff, cnt);
 	}
 
 	/**
 	 * Copy bytes from the window to a caller supplied buffer.
 	 * 
-	 * @param ref
-	 *            the object value required to perform data access.
 	 * @param pos
 	 *            offset within the window to start copying from.
 	 * @param dstbuf
@@ -146,15 +109,13 @@ final int copy(T ref, long pos, byte[] dstbuf, int dstoff, int cnt) {
 	 *         <code>cnt</code> if <code>cnt</code> exceeded the number of
 	 *         bytes available.
 	 */
-	abstract int copy(T ref, int pos, byte[] dstbuf, int dstoff, int cnt);
+	protected abstract int copy(int pos, byte[] dstbuf, int dstoff, int cnt);
 
 	/**
 	 * Pump bytes into the supplied inflater as input.
 	 * 
-	 * @param ref
-	 *            the object value required to perform data access.
 	 * @param pos
-	 *            offset within the window to start supplying input from.
+	 *            offset within the file to start supplying input from.
 	 * @param dstbuf
 	 *            destination buffer the inflater should output decompressed
 	 *            data to.
@@ -174,16 +135,14 @@ final int copy(T ref, long pos, byte[] dstbuf, int dstoff, int cnt) {
 	 *             the inflater encountered an invalid chunk of data. Data
 	 *             stream corruption is likely.
 	 */
-	final int inflate(T ref, long pos, byte[] dstbuf, int dstoff, Inflater inf)
+	final int inflate(long pos, byte[] dstbuf, int dstoff, Inflater inf)
 			throws DataFormatException {
-		return inflate(ref, (int) (pos - start), dstbuf, dstoff, inf);
+		return inflate((int) (pos - start), dstbuf, dstoff, inf);
 	}
 
 	/**
 	 * Pump bytes into the supplied inflater as input.
 	 * 
-	 * @param ref
-	 *            the object value required to perform data access.
 	 * @param pos
 	 *            offset within the window to start supplying input from.
 	 * @param dstbuf
@@ -205,18 +164,16 @@ final int inflate(T ref, long pos, byte[] dstbuf, int dstoff, Inflater inf)
 	 *             the inflater encountered an invalid chunk of data. Data
 	 *             stream corruption is likely.
 	 */
-	abstract int inflate(T ref, int pos, byte[] dstbuf, int dstoff, Inflater inf)
-			throws DataFormatException;
+	protected abstract int inflate(int pos, byte[] dstbuf, int dstoff,
+			Inflater inf) throws DataFormatException;
 
 	protected static final byte[] verifyGarbageBuffer = new byte[2048];
 
-	final void inflateVerify(T ref, long pos, Inflater inf)
+	final void inflateVerify(final long pos, final Inflater inf)
 			throws DataFormatException {
-		inflateVerify(ref, (int) (pos - start), inf);
+		inflateVerify((int) (pos - start), inf);
 	}
 
-	abstract void inflateVerify(T ref, int pos, Inflater inf)
+	protected abstract void inflateVerify(int pos, Inflater inf)
 			throws DataFormatException;
-
-	abstract void ensureLoaded(T ref);
-}
\ No newline at end of file
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
new file mode 100644
index 0000000..170c5d2
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
@@ -0,0 +1,522 @@
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
+import java.io.IOException;
+import java.lang.ref.ReferenceQueue;
+import java.lang.ref.SoftReference;
+import java.util.Random;
+import java.util.concurrent.atomic.AtomicLong;
+import java.util.concurrent.atomic.AtomicReferenceArray;
+import java.util.concurrent.locks.ReentrantLock;
+
+/**
+ * Least frequently used cache for objects specified by PackFile positions.
+ * <p>
+ * This cache maps a <code>({@link PackFile},position)</code> tuple to an Object.
+ * <p>
+ * This cache is suitable for objects that are "relative expensive" to compute
+ * from the underlying PackFile, given some known position in that file.
+ * <p>
+ * Whenever a cache miss occurs, {@link #load(PackFile, long)} is invoked by
+ * exactly one thread for the given <code>(PackFile,position)</code> key tuple.
+ * This is ensured by an array of locks, with the tuple hashed to a lock
+ * instance.
+ * <p>
+ * During a miss, older entries are evicted from the cache so long as
+ * {@link #isFull()} returns true.
+ * <p>
+ * Its too expensive during object access to be 100% accurate with a least
+ * recently used (LRU) algorithm. Strictly ordering every read is a lot of
+ * overhead that typically doesn't yield a corresponding benefit to the
+ * application.
+ * <p>
+ * This cache implements a loose LRU policy by randomly picking a window
+ * comprised of roughly 10% of the cache, and evicting the oldest accessed entry
+ * within that window.
+ * <p>
+ * Entities created by the cache are held under SoftReferences, permitting the
+ * Java runtime's garbage collector to evict entries when heap memory gets low.
+ * Most JREs implement a loose least recently used algorithm for this eviction.
+ * <p>
+ * The internal hash table does not expand at runtime, instead it is fixed in
+ * size at cache creation time. The internal lock table used to gate load
+ * invocations is also fixed in size.
+ * <p>
+ * The key tuple is passed through to methods as a pair of parameters rather
+ * than as a single Object, thus reducing the transient memory allocations of
+ * callers. It is more efficient to avoid the allocation, as we can't be 100%
+ * sure that a JIT would be able to stack-allocate a key tuple.
+ * <p>
+ * This cache has an implementation rule such that:
+ * <ul>
+ * <li>{@link #load(PackFile, long)} is invoked by at most one thread at a time
+ * for a given <code>(PackFile,position)</code> tuple.</li>
+ * <li>For every <code>load()</code> invocation there is exactly one
+ * {@link #createRef(PackFile, long, Object)} invocation to wrap a SoftReference
+ * around the cached entity.</li>
+ * <li>For every Reference created by <code>createRef()</code> there will be
+ * exactly one call to {@link #clear(Ref)} to cleanup any resources associated
+ * with the (now expired) cached entity.</li>
+ * </ul>
+ * <p>
+ * Therefore, it is safe to perform resource accounting increments during the
+ * {@link #load(PackFile, long)} or {@link #createRef(PackFile, long, Object)}
+ * methods, and matching decrements during {@link #clear(Ref)}. Implementors may
+ * need to override {@link #createRef(PackFile, long, Object)} in order to embed
+ * additional accounting information into an implementation specific
+ * {@link OffsetCache.Ref} subclass, as the cached entity may have already been
+ * evicted by the JRE's garbage collector.
+ * <p>
+ * To maintain higher concurrency workloads, during eviction only one thread
+ * performs the eviction work, while other threads can continue to insert new
+ * objects in parallel. This means that the cache can be temporarily over limit,
+ * especially if the nominated eviction thread is being starved relative to the
+ * other threads.
+ * 
+ * @param <V>
+ *            type of value stored in the cache.
+ * @param <R>
+ *            type of {@link OffsetCache.Ref} subclass used by the cache.
+ */
+abstract class OffsetCache<V, R extends OffsetCache.Ref<V>> {
+	private static final Random rng = new Random();
+
+	/** ReferenceQueue that {@link #createRef(PackFile, long, Object)} must use. */
+	protected final ReferenceQueue<V> queue;
+
+	/** Number of entries in {@link #table}. */
+	private final int tableSize;
+
+	/** Access clock for loose LRU. */
+	private final AtomicLong clock;
+
+	/** Hash bucket directory; entries are chained below. */
+	private final AtomicReferenceArray<Entry<V>> table;
+
+	/** Locks to prevent concurrent loads for same (PackFile,position). */
+	private final Lock[] locks;
+
+	/** Lock to elect the eviction thread after a load occurs. */
+	private final ReentrantLock evictLock;
+
+	/** Number of {@link #table} buckets to scan for an eviction window. */
+	private final int evictBatch;
+
+	/**
+	 * Create a new cache with a fixed size entry table and lock table.
+	 * 
+	 * @param tSize
+	 *            number of entries in the entry hash table.
+	 * @param lockCount
+	 *            number of entries in the lock table. This is the maximum
+	 *            concurrency rate for creation of new objects through
+	 *            {@link #load(PackFile, long)} invocations.
+	 */
+	OffsetCache(final int tSize, final int lockCount) {
+		if (tSize < 1)
+			throw new IllegalArgumentException("tSize must be >= 1");
+		if (lockCount < 1)
+			throw new IllegalArgumentException("lockCount must be >= 1");
+
+		queue = new ReferenceQueue<V>();
+		tableSize = tSize;
+		clock = new AtomicLong(1);
+		table = new AtomicReferenceArray<Entry<V>>(tableSize);
+		locks = new Lock[lockCount];
+		for (int i = 0; i < locks.length; i++)
+			locks[i] = new Lock();
+		evictLock = new ReentrantLock();
+
+		int eb = (int) (tableSize * .1);
+		if (64 < eb)
+			eb = 64;
+		else if (eb < 4)
+			eb = 4;
+		if (tableSize < eb)
+			eb = tableSize;
+		evictBatch = eb;
+	}
+
+	/**
+	 * Lookup a cached object, creating and loading it if it doesn't exist.
+	 * 
+	 * @param pack
+	 *            the pack that "contains" the cached object.
+	 * @param position
+	 *            offset within <code>pack</code> of the object.
+	 * @return the object reference.
+	 * @throws IOException
+	 *             the object reference was not in the cache and could not be
+	 *             obtained by {@link #load(PackFile, long)}.
+	 */
+	V getOrLoad(final PackFile pack, final long position) throws IOException {
+		final int slot = slot(pack, position);
+		final Entry<V> e1 = table.get(slot);
+		V v = scan(e1, pack, position);
+		if (v != null)
+			return v;
+
+		synchronized (lock(pack, position)) {
+			Entry<V> e2 = table.get(slot);
+			if (e2 != e1) {
+				v = scan(e2, pack, position);
+				if (v != null)
+					return v;
+			}
+
+			v = load(pack, position);
+			final Ref<V> ref = createRef(pack, position, v);
+			hit(ref);
+			for (;;) {
+				final Entry<V> n = new Entry<V>(clean(e2), ref);
+				if (table.compareAndSet(slot, e2, n))
+					break;
+				e2 = table.get(slot);
+			}
+		}
+
+		if (evictLock.tryLock()) {
+			try {
+				gc();
+				evict();
+			} finally {
+				evictLock.unlock();
+			}
+		}
+
+		return v;
+	}
+
+	private V scan(Entry<V> n, final PackFile pack, final long position) {
+		for (; n != null; n = n.next) {
+			final Ref<V> r = n.ref;
+			if (r.pack == pack && r.position == position) {
+				final V v = r.get();
+				if (v != null) {
+					hit(r);
+					return v;
+				}
+				n.dead = true;
+				break;
+			}
+		}
+		return null;
+	}
+
+	private void hit(final Ref<V> r) {
+		// We don't need to be 100% accurate here. Its sufficient that at least
+		// one thread performs the increment. Any other concurrent access at
+		// exactly the same time can simply use the same clock value.
+		//
+		// Consequently we attempt the set, but we don't try to recover should
+		// it fail. This is why we don't use getAndIncrement() here.
+		//
+		final long c = clock.get();
+		clock.compareAndSet(c, c + 1);
+		r.lastAccess = c;
+	}
+
+	private void evict() {
+		final int start = rng.nextInt(tableSize);
+		int ptr = start;
+		while (isFull()) {
+			Entry<V> old = null;
+			int slot = 0;
+			for (int b = evictBatch - 1; b >= 0; b--) {
+				if (tableSize <= ptr)
+					ptr = 0;
+				for (Entry<V> e = table.get(ptr); e != null; e = e.next) {
+					if (e.dead)
+						continue;
+					if (old == null || e.ref.lastAccess < old.ref.lastAccess) {
+						old = e;
+						slot = ptr;
+					}
+				}
+				if (++ptr == start)
+					return;
+			}
+			if (old != null) {
+				old.kill();
+				gc();
+				final Entry<V> e1 = table.get(slot);
+				table.compareAndSet(slot, e1, clean(e1));
+			}
+		}
+	}
+
+	/**
+	 * Clear every entry from the cache.
+	 *<p>
+	 * This is a last-ditch effort to clear out the cache, such as before it
+	 * gets replaced by another cache that is configured differently. This
+	 * method tries to force every cached entry through {@link #clear(Ref)} to
+	 * ensure that resources are correctly accounted for and cleaned up by the
+	 * subclass. A concurrent reader loading entries while this method is
+	 * running may cause resource accounting failures.
+	 */
+	void removeAll() {
+		for (int s = 0; s < tableSize; s++) {
+			Entry<V> e1;
+			do {
+				e1 = table.get(s);
+				for (Entry<V> e = e1; e != null; e = e.next)
+					e.kill();
+			} while (!table.compareAndSet(s, e1, null));
+		}
+		gc();
+	}
+
+	/**
+	 * Clear all entries related to a single file.
+	 * <p>
+	 * Typically this method is invoked during {@link PackFile#close()}, when we
+	 * know the pack is never going to be useful to us again (for example, it no
+	 * longer exists on disk). A concurrent reader loading an entry from this
+	 * same pack may cause the pack to become stuck in the cache anyway.
+	 * 
+	 * @param pack
+	 *            the file to purge all entries of.
+	 */
+	void removeAll(final PackFile pack) {
+		for (int s = 0; s < tableSize; s++) {
+			final Entry<V> e1 = table.get(s);
+			boolean hasDead = false;
+			for (Entry<V> e = e1; e != null; e = e.next) {
+				if (e.ref.pack == pack) {
+					e.kill();
+					hasDead = true;
+				} else if (e.dead)
+					hasDead = true;
+			}
+			if (hasDead)
+				table.compareAndSet(s, e1, clean(e1));
+		}
+		gc();
+	}
+
+	/**
+	 * Materialize an object that doesn't yet exist in the cache.
+	 * <p>
+	 * This method is invoked by {@link #getOrLoad(PackFile, long)} when the
+	 * specified entity does not yet exist in the cache. Internal locking
+	 * ensures that at most one thread can call this method for each unique
+	 * <code>(pack,position)</code>, but multiple threads can call this method
+	 * concurrently for different <code>(pack,position)</code> tuples.
+	 * 
+	 * @param pack
+	 *            the file to materialize the entry from.
+	 * @param position
+	 *            offset within the file of the entry.
+	 * @return the materialized object. Must never be null.
+	 * @throws IOException
+	 *             the method was unable to materialize the object for this
+	 *             input pair. The usual reasons would be file corruption, file
+	 *             not found, out of file descriptors, etc.
+	 */
+	protected abstract V load(PackFile pack, long position) throws IOException;
+
+	/**
+	 * Construct a Ref (SoftReference) around a cached entity.
+	 * <p>
+	 * Implementing this is only necessary if the subclass is performing
+	 * resource accounting during {@link #load(PackFile, long)} and
+	 * {@link #clear(Ref)} requires some information to update the accounting.
+	 * <p>
+	 * Implementors <b>MUST</b> ensure that the returned reference uses the
+	 * {@link #queue} ReferenceQueue, otherwise {@link #clear(Ref)} will not be
+	 * invoked at the proper time.
+	 * 
+	 * @param pack
+	 *            the file to materialize the entry from.
+	 * @param position
+	 *            offset within the file of the entry.
+	 * @param v
+	 *            the object returned by {@link #load(PackFile, long)}.
+	 * @return a soft reference subclass wrapped around <code>v</code>.
+	 */
+	@SuppressWarnings("unchecked")
+	protected R createRef(final PackFile pack, final long position, final V v) {
+		return (R) new Ref<V>(pack, position, v, queue);
+	}
+
+	/**
+	 * Update accounting information now that an object has left the cache.
+	 * <p>
+	 * This method is invoked exactly once for the combined
+	 * {@link #load(PackFile, long)} and
+	 * {@link #createRef(PackFile, long, Object)} invocation pair that was used
+	 * to construct and insert an object into the cache.
+	 * 
+	 * @param ref
+	 *            the reference wrapped around the object. Implementations must
+	 *            be prepared for <code>ref.get()</code> to return null.
+	 */
+	protected void clear(final R ref) {
+		// Do nothing by default.
+	}
+
+	/**
+	 * Determine if the cache is full and requires eviction of entries.
+	 * <p>
+	 * By default this method returns false. Implementors may override to
+	 * consult with the accounting updated by {@link #load(PackFile, long)},
+	 * {@link #createRef(PackFile, long, Object)} and {@link #clear(Ref)}.
+	 * 
+	 * @return true if the cache is still over-limit and requires eviction of
+	 *         more entries.
+	 */
+	protected boolean isFull() {
+		return false;
+	}
+
+	@SuppressWarnings("unchecked")
+	private void gc() {
+		R r;
+		while ((r = (R) queue.poll()) != null) {
+			// Sun's Java 5 and 6 implementation have a bug where a Reference
+			// can be enqueued and dequeued twice on the same reference queue
+			// due to a race condition within ReferenceQueue.enqueue(Reference).
+			//
+			// We CANNOT permit a Reference to come through us twice, as it will
+			// skew the resource counters we maintain. Our canClear() check here
+			// provides a way to skip the redundant dequeues, if any.
+			//
+			if (r.canClear())
+				clear(r);
+		}
+	}
+
+	/**
+	 * Compute the hash code value for a <code>(PackFile,position)</code> tuple.
+	 * <p>
+	 * By default: <code>(packHash + (int) (position >>> 4)) >>> 1</code>.
+	 * Implementors may override with a more suitable hash (for example, a
+	 * larger right shift on the position).
+	 * 
+	 * @param packHash
+	 *            hash code for the file being accessed.
+	 * @param position
+	 *            position within the file being accessed.
+	 * @return a reasonable hash code mixing the two values.
+	 */
+	protected int hash(final int packHash, final long position) {
+		return (packHash + (int) (position >>> 4)) >>> 1;
+	}
+
+	private int slot(final PackFile pack, final long position) {
+		return hash(pack.hash, position) % tableSize;
+	}
+
+	private Lock lock(final PackFile pack, final long position) {
+		return locks[hash(pack.hash, position) % locks.length];
+	}
+
+	private static <V> Entry<V> clean(Entry<V> top) {
+		while (top != null && top.dead) {
+			top.ref.enqueue();
+			top = top.next;
+		}
+		if (top == null)
+			return null;
+		final Entry<V> n = clean(top.next);
+		return n == top.next ? top : new Entry<V>(n, top.ref);
+	}
+
+	private static class Entry<V> {
+		/** Next entry in the hash table's chain list. */
+		final Entry<V> next;
+
+		/** The referenced object. */
+		final Ref<V> ref;
+
+		/**
+		 * Marked true when ref.get() returns null and the ref is dead.
+		 * <p>
+		 * A true here indicates that the ref is no longer accessible, and that
+		 * we therefore need to eventually purge this Entry object out of the
+		 * bucket's chain.
+		 */
+		volatile boolean dead;
+
+		Entry(final Entry<V> n, final Ref<V> r) {
+			next = n;
+			ref = r;
+		}
+
+		final void kill() {
+			dead = true;
+			ref.enqueue();
+		}
+	}
+
+	/**
+	 * A soft reference wrapped around a cached object.
+	 * 
+	 * @param <V>
+	 *            type of the cached object.
+	 */
+	protected static class Ref<V> extends SoftReference<V> {
+		final PackFile pack;
+
+		final long position;
+
+		long lastAccess;
+
+		private boolean cleared;
+
+		protected Ref(final PackFile pack, final long position, final V v,
+				final ReferenceQueue<V> queue) {
+			super(v, queue);
+			this.pack = pack;
+			this.position = position;
+		}
+
+		final synchronized boolean canClear() {
+			if (cleared)
+				return false;
+			cleared = true;
+			return true;
+		}
+	}
+
+	private static final class Lock {
+		// Used only for its implicit monitor.
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 360442f..b107dfe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -77,12 +77,13 @@ public int compare(final PackFile a, final PackFile b) {
 
 	final int hash;
 
-	RandomAccessFile fd;
+	private RandomAccessFile fd;
 
 	long length;
 
-	/** Total number of windows actively in the associated cache. */
-	int openCount;
+	private int activeWindows;
+
+	private int activeCopyRawData;
 
 	private int packLastModified;
 
@@ -310,27 +311,57 @@ private void copyToStream(long position, final byte[] buf, long cnt,
 		}
 	}
 
-	void cacheOpen() throws IOException {
-		fd = new RandomAccessFile(packFile, "r");
-		length = fd.length();
+	synchronized void beginCopyRawData() throws IOException {
+		if (++activeCopyRawData == 1 && activeWindows == 0)
+			doOpen();
+	}
+
+	synchronized void endCopyRawData() {
+		if (--activeCopyRawData == 0 && activeWindows == 0)
+			doClose();
+	}
+
+	synchronized boolean beginWindowCache() throws IOException {
+		if (++activeWindows == 1) {
+			if (activeCopyRawData == 0)
+				doOpen();
+			return true;
+		}
+		return false;
+	}
+
+	synchronized boolean endWindowCache() {
+		final boolean r = --activeWindows == 0;
+		if (r && activeCopyRawData == 0)
+			doClose();
+		return r;
+	}
+
+	private void doOpen() throws IOException {
 		try {
+			fd = new RandomAccessFile(packFile, "r");
+			length = fd.length();
 			onOpenPack();
 		} catch (IOException ioe) {
-			invalid = true;
-			cacheClose();
+			openFail();
 			throw ioe;
 		} catch (RuntimeException re) {
-			invalid = true;
-			cacheClose();
+			openFail();
 			throw re;
 		} catch (Error re) {
-			invalid = true;
-			cacheClose();
+			openFail();
 			throw re;
 		}
 	}
 
-	void cacheClose() {
+	private void openFail() {
+		activeWindows = 0;
+		activeCopyRawData = 0;
+		invalid = true;
+		doClose();
+	}
+
+	private void doClose() {
 		if (fd != null) {
 			try {
 				fd.close();
@@ -343,48 +374,34 @@ void cacheClose() {
 		}
 	}
 
-	void allocWindow(final WindowCursor curs, final int windowId,
-			final long pos, final int size) {
-		if (WindowCache.mmap) {
-			MappedByteBuffer map;
-			try {
-				map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
-			} catch (IOException e) {
-				// The most likely reason this failed is the JVM has run out
-				// of virtual memory. We need to discard quickly, and try to
-				// force the GC to finalize and release any existing mappings.
-				try {
-					curs.release();
-					System.gc();
-					System.runFinalization();
-					map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
-				} catch (IOException ioe2) {
-					// Temporarily disable mmap and do buffered disk IO.
-					//
-					map = null;
-					System.err.println("warning: mmap failure: "+ioe2);
-				}
-			}
-			if (map != null) {
-				if (map.hasArray()) {
-					final byte[] b = map.array();
-					final ByteArrayWindow w;
-					w = new ByteArrayWindow(this, pos, windowId, b);
-					w.loaded = true;
-					curs.window = w;
-					curs.handle = b;
-				} else {
-					curs.window = new ByteBufferWindow(this, pos, windowId, map);
-					curs.handle = map;
-				}
-				return;
-			}
+	ByteArrayWindow read(final long pos, int size) throws IOException {
+		if (length < pos + size)
+			size = (int) (length - pos);
+		final byte[] buf = new byte[size];
+		NB.readFully(fd.getChannel(), pos, buf, 0, size);
+		return new ByteArrayWindow(this, pos, buf);
+	}
+
+	ByteWindow mmap(final long pos, int size) throws IOException {
+		if (length < pos + size)
+			size = (int) (length - pos);
+
+		MappedByteBuffer map;
+		try {
+			map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
+		} catch (IOException ioe1) {
+			// The most likely reason this failed is the JVM has run out
+			// of virtual memory. We need to discard quickly, and try to
+			// force the GC to finalize and release any existing mappings.
+			//
+			System.gc();
+			System.runFinalization();
+			map = fd.getChannel().map(MapMode.READ_ONLY, pos, size);
 		}
 
-		final byte[] b = new byte[size];
-		curs.window = new ByteArrayWindow(this, pos, windowId, b);
-		curs.handle = b;
-		openCount++; // Until the window loads, we must stay open.
+		if (map.hasArray())
+			return new ByteArrayWindow(this, pos, map.array());
+		return new ByteBufferWindow(this, pos, map);
 	}
 
 	private void onOpenPack() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
index d49562a..0c3e783 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackedObjectLoader.java
@@ -126,7 +126,7 @@ public final long getDataOffset() {
 	 *             deleted, and the object has moved to another pack file.
 	 */
 	public void beginCopyRawData() throws IOException {
-		WindowCache.pin(pack);
+		pack.beginCopyRawData();
 	}
 
 	/**
@@ -154,7 +154,7 @@ public void copyRawData(OutputStream out, byte buf[], WindowCursor curs)
 
 	/** Release resources after {@link #beginCopyRawData()}. */
 	public void endCopyRawData() {
-		WindowCache.unpin(pack);
+		pack.endCopyRawData();
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 51d149c..3eb1204 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -40,12 +40,17 @@
 
 import java.io.IOException;
 import java.lang.ref.ReferenceQueue;
+import java.util.concurrent.atomic.AtomicInteger;
 
 /**
- * The WindowCache manages reusable <code>Windows</code> and inflaters used by
- * the other windowed file access classes.
+ * Caches slices of a {@link PackFile} in memory for faster read access.
+ * <p>
+ * The WindowCache serves as a Java based "buffer cache", loading segments of a
+ * PackFile into the JVM heap prior to use. As JGit often wants to do reads of
+ * only tiny slices of a file, the WindowCache tries to smooth out these tiny
+ * reads into larger block-sized IO operations.
  */
-public class WindowCache {
+public class WindowCache extends OffsetCache<ByteWindow, WindowCache.WindowRef> {
 	private static final int bits(int newSize) {
 		if (newSize < 4096)
 			throw new IllegalArgumentException("Invalid window size");
@@ -54,41 +59,10 @@ private static final int bits(int newSize) {
 		return Integer.numberOfTrailingZeros(newSize);
 	}
 
-	private static int maxFileCount;
-
-	private static int maxByteCount;
-
-	private static int windowSize;
-
-	private static int windowSizeShift;
-
-	static boolean mmap;
-
-	static final ReferenceQueue<?> clearedWindowQueue;
-
-	private static ByteWindow[] cache;
-
-	private static ByteWindow lruHead;
-
-	private static ByteWindow lruTail;
-
-	private static int openFileCount;
-
-	private static int openByteCount;
+	private static volatile WindowCache cache;
 
 	static {
-		final WindowCacheConfig c = new WindowCacheConfig();
-		maxFileCount = c.getPackedGitOpenFiles();
-		maxByteCount = c.getPackedGitLimit();
-		windowSizeShift = bits(c.getPackedGitWindowSize());
-		windowSize = 1 << windowSizeShift;
-		mmap = c.isPackedGitMMAP();
-		cache = new ByteWindow[cacheTableSize()];
-		clearedWindowQueue = new ReferenceQueue<Object>();
-	}
-
-	private static int cacheTableSize() {
-		return 5 * (maxByteCount / windowSize) / 2;
+		reconfigure(new WindowCacheConfig());
 	}
 
 	/**
@@ -125,325 +99,133 @@ public static void reconfigure(final int packedGitLimit,
 	 * The new configuration is applied immediately. If the new limits are
 	 * smaller than what what is currently cached, older entries will be purged
 	 * as soon as possible to allow the cache to meet the new limit.
+	 * <p>
+	 * Applying a new configuration while repositories are being accessed may
+	 * cause files to become stuck open until the Java garbage collector can
+	 * eventually finalize their streams. Applications are encouraged to set the
+	 * cache only when concurrent access is impossible, or highly improbable.
 	 *
 	 * @param cfg
 	 *            the new window cache configuration.
 	 */
 	public static void reconfigure(final WindowCacheConfig cfg) {
-		reconfigureImpl(cfg);
+		final WindowCache c = cache;
+		if (c != null)
+			c.removeAll();
+		cache = new WindowCache(cfg);
 		UnpackedObjectCache.reconfigure(cfg);
 	}
 
-	private static synchronized void reconfigureImpl(final WindowCacheConfig cfg) {
-		boolean prune = false;
-		boolean evictAll = false;
-
-		if (maxFileCount < cfg.getPackedGitOpenFiles())
-			maxFileCount = cfg.getPackedGitOpenFiles();
-		else if (maxFileCount > cfg.getPackedGitOpenFiles()) {
-			maxFileCount = cfg.getPackedGitOpenFiles();
-			prune = true;
-		}
-
-		if (maxByteCount < cfg.getPackedGitLimit()) {
-			maxByteCount = cfg.getPackedGitLimit();
-		} else if (maxByteCount > cfg.getPackedGitLimit()) {
-			maxByteCount = cfg.getPackedGitLimit();
-			prune = true;
-		}
-
-		if (bits(cfg.getPackedGitWindowSize()) != windowSizeShift) {
-			windowSizeShift = bits(cfg.getPackedGitWindowSize());
-			windowSize = 1 << windowSizeShift;
-			evictAll = true;
-		}
-
-		if (mmap != cfg.isPackedGitMMAP()) {
-			mmap = cfg.isPackedGitMMAP();
-			evictAll = true;
-		}
-
-		if (evictAll) {
-			// We have to throw away every window we have. None
-			// of them are suitable for the new configuration.
-			//
-			for (ByteWindow<?> e : cache) {
-				for (; e != null; e = e.chainNext)
-					clear(e);
-			}
-			runClearedWindowQueue();
-			cache = new ByteWindow[cacheTableSize()];
-
-		} else {
-			if (prune) {
-				// We should decrease our memory usage.
-				//
-				releaseMemory();
-				runClearedWindowQueue();
-			}
-
-			if (cache.length != cacheTableSize()) {
-				// The cache table should be resized.
-				// Rehash every entry.
-				//
-				final ByteWindow[] priorTable = cache;
-
-				cache = new ByteWindow[cacheTableSize()];
-				for (ByteWindow<?> e : priorTable) {
-					for (ByteWindow<?> n; e != null; e = n) {
-						n = e.chainNext;
-						final int idx = hash(e.provider, e.id);
-						e.chainNext = cache[idx];
-						cache[idx] = e;
-					}
-				}
-			}
-		}
-	}
-
-	/**
-	 * Get a specific window.
-	 * 
-	 * @param curs
-	 *            an active cursor object to maintain the window reference while
-	 *            the caller needs it.
-	 * @param wp
-	 *            the provider of the window. If the window is not currently in
-	 *            the cache then the provider will be asked to load it.
-	 * @param position
-	 *            offset (in bytes) within the file that the caller needs access
-	 *            to.
-	 * @throws IOException
-	 *             the window was not found in the cache and the given provider
-	 *             was unable to load the window on demand.
-	 */
-	public static final void get(final WindowCursor curs, final PackFile wp,
-			final long position) throws IOException {
-		getImpl(curs, wp, position);
-		curs.window.ensureLoaded(curs.handle);
-	}
-
-	static synchronized final void pin(final PackFile wp) throws IOException {
-		if (++wp.openCount == 1) {
-			openFile(wp);
-		}
+	static final ByteWindow get(final PackFile pack, final long offset)
+			throws IOException {
+		final WindowCache c = cache;
+		return c.getOrLoad(pack, c.toStart(offset));
 	}
 
-	static synchronized final void unpin(final PackFile wp) {
-		if (--wp.openCount == 0) {
-			openFileCount--;
-			wp.cacheClose();
-		}
+	static final void purge(final PackFile pack) {
+		cache.removeAll(pack);
 	}
 
-	private static synchronized final void getImpl(final WindowCursor curs,
-			final PackFile wp, final long position) throws IOException {
-		final int id = (int) (position >> windowSizeShift);
-		final int idx = hash(wp, id);
-		for (ByteWindow<?> e = cache[idx]; e != null; e = e.chainNext) {
-			if (e.provider == wp && e.id == id) {
-				if ((curs.handle = e.get()) != null) {
-					curs.window = e;
-					makeMostRecent(e);
-					return;
-				}
+	private final int maxFiles;
 
-				clear(e);
-				break;
-			}
-		}
+	private final int maxBytes;
 
-		if (wp.openCount == 0) {
-			openFile(wp);
+	private final boolean mmap;
 
-			// The cacheOpen may have mapped the window we are trying to
-			// map ourselves. Retrying the search ensures that does not
-			// happen to us.
-			//
-			for (ByteWindow<?> e = cache[idx]; e != null; e = e.chainNext) {
-				if (e.provider == wp && e.id == id) {
-					if ((curs.handle = e.get()) != null) {
-						curs.window = e;
-						makeMostRecent(e);
-						return;
-					}
+	private final int windowSizeShift;
 
-					clear(e);
-					break;
-				}
-			}
-		}
+	private final int windowSize;
 
-		final int wsz = windowSize(wp, id);
-		wp.openCount++;
-		openByteCount += wsz;
-		releaseMemory();
-		runClearedWindowQueue();
+	private final AtomicInteger openFiles;
 
-		wp.allocWindow(curs, id, (position >>> windowSizeShift) << windowSizeShift, wsz);
-		final ByteWindow<?> e = curs.window;
-		e.chainNext = cache[idx];
-		cache[idx] = e;
-		insertLRU(e);
-	}
+	private final AtomicInteger openBytes;
 
-	private static void openFile(final PackFile wp) throws IOException {
-		try {
-			openFileCount++;
-			releaseMemory();
-			runClearedWindowQueue();
-			wp.openCount = 1;
-			wp.cacheOpen();
-		} catch (IOException ioe) {
-			openFileCount--;
-			wp.openCount = 0;
-			throw ioe;
-		} catch (RuntimeException ioe) {
-			openFileCount--;
-			wp.openCount = 0;
-			throw ioe;
-		} catch (Error ioe) {
-			openFileCount--;
-			wp.openCount = 0;
-			throw ioe;
-		} finally {
-			wp.openCount--;
-		}
-	}
+	private WindowCache(final WindowCacheConfig cfg) {
+		super(tableSize(cfg), lockCount(cfg));
+		maxFiles = cfg.getPackedGitOpenFiles();
+		maxBytes = cfg.getPackedGitLimit();
+		mmap = cfg.isPackedGitMMAP();
+		windowSizeShift = bits(cfg.getPackedGitWindowSize());
+		windowSize = 1 << windowSizeShift;
 
-	static synchronized void markLoaded(final ByteWindow w) {
-		if (--w.provider.openCount == 0) {
-			openFileCount--;
-			w.provider.cacheClose();
-		}
-	}
+		openFiles = new AtomicInteger();
+		openBytes = new AtomicInteger();
 
-	private static void makeMostRecent(ByteWindow<?> e) {
-		if (lruHead != e) {
-			unlinkLRU(e);
-			insertLRU(e);
-		}
+		if (maxFiles < 1)
+			throw new IllegalArgumentException();
+		if (maxBytes < windowSize)
+			throw new IllegalArgumentException();
 	}
 
-	private static void releaseMemory() {
-		ByteWindow<?> e = lruTail;
-		while (isOverLimit() && e != null) {
-			final ByteWindow<?> p = e.lruPrev;
-			clear(e);
-			e = p;
-		}
-	}
-
-	private static boolean isOverLimit() {
-		return openByteCount > maxByteCount || openFileCount > maxFileCount;
+	@Override
+	protected int hash(final int packHash, final long off) {
+		return (packHash + (int) (off >>> windowSizeShift)) >>> 1;
 	}
 
-	/**
-	 * Remove all windows associated with a specific provider.
-	 * <p>
-	 * Providers should invoke this method as part of their cleanup/close
-	 * routines, ensuring that the window cache releases all windows that cannot
-	 * ever be requested again.
-	 * </p>
-	 * 
-	 * @param wp
-	 *            the window provider whose windows should be removed from the
-	 *            cache.
-	 */
-	public static synchronized final void purge(final PackFile wp) {
-		for (ByteWindow e : cache) {
-			for (; e != null; e = e.chainNext) {
-				if (e.provider == wp)
-					clear(e);
-			}
+	@Override
+	protected ByteWindow load(final PackFile pack, final long offset)
+			throws IOException {
+		if (pack.beginWindowCache())
+			openFiles.incrementAndGet();
+		try {
+			if (mmap)
+				return pack.mmap(offset, windowSize);
+			return pack.read(offset, windowSize);
+		} catch (IOException e) {
+			close(pack);
+			throw e;
+		} catch (RuntimeException e) {
+			close(pack);
+			throw e;
+		} catch (Error e) {
+			close(pack);
+			throw e;
 		}
-		runClearedWindowQueue();
 	}
 
-	private static void runClearedWindowQueue() {
-		ByteWindow<?> e;
-		while ((e = (ByteWindow) clearedWindowQueue.poll()) != null) {
-			unlinkSize(e);
-			unlinkLRU(e);
-			unlinkCache(e);
-			e.chainNext = null;
-			e.lruNext = null;
-			e.lruPrev = null;
-		}
+	@Override
+	protected WindowRef createRef(final PackFile p, final long o,
+			final ByteWindow v) {
+		final WindowRef ref = new WindowRef(p, o, v, queue);
+		openBytes.addAndGet(ref.size);
+		return ref;
 	}
 
-	private static void clear(final ByteWindow<?> e) {
-		unlinkSize(e);
-		e.clear();
-		e.enqueue();
+	@Override
+	protected void clear(final WindowRef ref) {
+		openBytes.addAndGet(-ref.size);
+		close(ref.pack);
 	}
 
-	private static void unlinkSize(final ByteWindow<?> e) {
-		if (e.sizeActive) {
-			if (--e.provider.openCount == 0) {
-				openFileCount--;
-				e.provider.cacheClose();
-			}
-			openByteCount -= e.size;
-			e.sizeActive = false;
-		}
+	private void close(final PackFile pack) {
+		if (pack.endWindowCache())
+			openFiles.decrementAndGet();
 	}
 
-	private static void unlinkCache(final ByteWindow dead) {
-		final int idx = hash(dead.provider, dead.id);
-		ByteWindow<?> e = cache[idx], p = null, n;
-		for (; e != null; p = e, e = n) {
-			n = e.chainNext;
-			if (e == dead) {
-				if (p == null)
-					cache[idx] = n;
-				else
-					p.chainNext = n;
-				break;
-			}
-		}
+	@Override
+	protected boolean isFull() {
+		return maxFiles < openFiles.get() || maxBytes < openBytes.get();
 	}
 
-	private static void unlinkLRU(final ByteWindow e) {
-		final ByteWindow<?> prev = e.lruPrev;
-		final ByteWindow<?> next = e.lruNext;
-
-		if (prev != null)
-			prev.lruNext = next;
-		else
-			lruHead = next;
-
-		if (next != null)
-			next.lruPrev = prev;
-		else
-			lruTail = prev;
+	private long toStart(final long offset) {
+		return (offset >>> windowSizeShift) << windowSizeShift;
 	}
 
-	private static void insertLRU(final ByteWindow<?> e) {
-		final ByteWindow h = lruHead;
-		e.lruPrev = null;
-		e.lruNext = h;
-		if (h != null)
-			h.lruPrev = e;
-		else
-			lruTail = e;
-		lruHead = e;
+	private static int tableSize(final WindowCacheConfig cfg) {
+		return 5 * (cfg.getPackedGitLimit() / cfg.getPackedGitWindowSize()) / 2;
 	}
 
-	private static int hash(final PackFile wp, final int id) {
-		// wp.hash was already "stirred up" a bit by * 31 when
-		// it was created. Its reasonable to just add here.
-		//
-		return ((wp.hash + id) >>> 1) % cache.length;
+	private static int lockCount(final WindowCacheConfig cfg) {
+		return Math.max(cfg.getPackedGitOpenFiles(), 32);
 	}
 
-	private static int windowSize(final PackFile file, final int id) {
-		final long len = file.length;
-		final long pos = id << windowSizeShift;
-		return len < pos + windowSize ? (int) (len - pos) : windowSize;
-	}
+	static class WindowRef extends OffsetCache.Ref<ByteWindow> {
+		final int size;
 
-	private WindowCache() {
-		throw new UnsupportedOperationException();
+		WindowRef(final PackFile pack, final long position, final ByteWindow v,
+				final ReferenceQueue<ByteWindow> queue) {
+			super(pack, position, v, queue);
+			size = v.size();
+		}
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
index fb9d348..0723a78 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCursor.java
@@ -48,14 +48,12 @@
 
 	private Inflater inf;
 
-	ByteWindow window;
-
-	Object handle;
+	private ByteWindow window;
 
 	/**
 	 * Copy bytes from the window to a caller supplied buffer.
 	 * 
-	 * @param provider
+	 * @param pack
 	 *            the file the desired window is stored within.
 	 * @param position
 	 *            position within the file to read from.
@@ -74,13 +72,13 @@
 	 *             this cursor does not match the provider or id and the proper
 	 *             window could not be acquired through the provider's cache.
 	 */
-	int copy(final PackFile provider, long position, final byte[] dstbuf,
+	int copy(final PackFile pack, long position, final byte[] dstbuf,
 			int dstoff, final int cnt) throws IOException {
-		final long length = provider.length;
+		final long length = pack.length;
 		int need = cnt;
 		while (need > 0 && position < length) {
-			pin(provider, position);
-			final int r = window.copy(handle, position, dstbuf, dstoff, need);
+			pin(pack, position);
+			final int r = window.copy(position, dstbuf, dstoff, need);
 			position += r;
 			dstoff += r;
 			need -= r;
@@ -91,7 +89,7 @@ int copy(final PackFile provider, long position, final byte[] dstbuf,
 	/**
 	 * Pump bytes into the supplied inflater as input.
 	 * 
-	 * @param provider
+	 * @param pack
 	 *            the file the desired window is stored within.
 	 * @param position
 	 *            position within the file to read from.
@@ -109,47 +107,53 @@ int copy(final PackFile provider, long position, final byte[] dstbuf,
 	 *             the inflater encountered an invalid chunk of data. Data
 	 *             stream corruption is likely.
 	 */
-	int inflate(final PackFile provider, long position, final byte[] dstbuf,
+	int inflate(final PackFile pack, long position, final byte[] dstbuf,
 			int dstoff) throws IOException, DataFormatException {
 		if (inf == null)
 			inf = InflaterCache.get();
 		else
 			inf.reset();
 		for (;;) {
-			pin(provider, position);
-			dstoff = window.inflate(handle, position, dstbuf, dstoff, inf);
+			pin(pack, position);
+			dstoff = window.inflate(position, dstbuf, dstoff, inf);
 			if (inf.finished())
 				return dstoff;
 			position = window.end;
 		}
 	}
 
-	void inflateVerify(final PackFile provider, long position)
+	void inflateVerify(final PackFile pack, long position)
 			throws IOException, DataFormatException {
 		if (inf == null)
 			inf = InflaterCache.get();
 		else
 			inf.reset();
 		for (;;) {
-			pin(provider, position);
-			window.inflateVerify(handle, position, inf);
+			pin(pack, position);
+			window.inflateVerify(position, inf);
 			if (inf.finished())
 				return;
 			position = window.end;
 		}
 	}
 
-	private void pin(final PackFile provider, final long position)
+	private void pin(final PackFile pack, final long position)
 			throws IOException {
 		final ByteWindow w = window;
-		if (w == null || !w.contains(provider, position))
-			WindowCache.get(this, provider, position);
+		if (w == null || !w.contains(pack, position)) {
+			// If memory is low, we may need what is in our window field to
+			// be cleaned up by the GC during the get for the next window.
+			// So we always clear it, even though we are just going to set
+			// it again.
+			//
+			window = null;
+			window = WindowCache.get(pack, position);
+		}
 	}
 
 	/** Release the current window cursor. */
 	public void release() {
 		window = null;
-		handle = null;
 		try {
 			InflaterCache.release(inf);
 		} finally {
-- 
1.6.3.rc1.205.g37f8
