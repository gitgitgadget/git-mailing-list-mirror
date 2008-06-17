From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 05/20] Reverse pack index implementation: PackReverseIndex
Date: Mon, 16 Jun 2008 22:02:42 -0400
Message-ID: <20080617020242.GW11793@spearce.org>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com> <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com> <20080616040635.GU11793@spearce.org> <48569460.4000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 04:04:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8QYS-0007oH-Or
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 04:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYFQCCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 22:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbYFQCCy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 22:02:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37294 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYFQCCw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 22:02:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K8QWp-0006pw-Oq; Mon, 16 Jun 2008 22:02:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A0B8320FBAE; Mon, 16 Jun 2008 22:02:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48569460.4000401@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85258>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Shawn O. Pearce wrote:
> >Marek Zawirski <marek.zawirski@gmail.com> wrote:
> >>Let us quickly find ObjectId or next object for specified offset in a
> >>pack, in O(log n) time.
...
> >This could be smaller if it was an array of indexes into the index,
> >rather than the ObjectId itself.  Thus we need only 1 int per object
> >and not 5 ints per object.
> 
> Hmm, that's smart.
> I can change array of names to second level indices, but I think that in 
> such a case PackReverseIndex should be an inner class of PackIndex and 
> some refactor/additional assumptions at PackIndex may be needed. What do 
> you think?

So I coded this up today. It can either squash to this patch I
am replying to, or maybe follow-on in the series.

The advantage of this change is we use the minimum amount of memory
possible to build the reverse index.  The disadvantage is the
construction of the reverse index now runs in O(N + 2 * (N log N)),
where the prior version was O(N + N log N), ignoring all GC costs.

We could be doing worse here, but I suspect the additional running
time is better than the memory usage from cloning every MutableEntry
during traversal.  GC costs are not free.

With this patch ObjectId lookup is still constant time, though
we do perform a binary search on a 256 element array.  log 256 is
still a constant, even though it is not 1. :-)

We support up to 2^32 objects per index, which is the limit of the
file format, however we only support the first 2 billion objects
being in the first 2 GB of the pack file.  Given that each object
needs _at least_ two bytes of data the first 2 billion objects will
easily require the first 4 GB of the pack file, pushing us into the
offsets64 table.  Which is then itself limited to 2 billion objects.
So our real limit here is we cannot have more than 2 billion objects
requiring 64 bit offsets.  But PackIndexV2 only supports (2**31-1)/8
such 64 bit offsets so we'll blow that out long before we blow the
PackReverseIndex limits.

Yes, PackIndexV2 is currently limited by its implementation and
not by what the file format would permit.


--8<--
Improved PackReverseIndex

---
 .../src/org/spearce/jgit/lib/PackIndex.java        |   57 ++++++++++++++
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   38 +++++++++-
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   33 ++++++++-
 .../src/org/spearce/jgit/lib/PackReverseIndex.java |   82 +++++++++++---------
 4 files changed, 170 insertions(+), 40 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 3935d4f..6debf3b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -140,6 +140,63 @@ public abstract class PackIndex implements Iterable<PackIndex.MutableEntry> {
 	abstract long getObjectCount();
 
 	/**
+	 * Obtain the total number of objects needing 64 bit offsets.
+	 * 
+	 * @return number of objects in this index using a 64 bit offset; that is an
+	 *         object positioned after the 2 GB position within the file.
+	 */
+	abstract long getOffset64Count();
+
+	/**
+	 * Get ObjectId for the n-th object entry returned by {@link #iterator()}.
+	 * <p>
+	 * This method is a constant-time replacement for the following loop:
+	 * 
+	 * <pre>
+	 * Iterator&lt;MutableEntry&gt; eItr = index.iterator();
+	 * int curPosition = 0;
+	 * while (eItr.hasNext() &amp;&amp; curPosition++ &lt; nthPosition)
+	 * 	eItr.next();
+	 * ObjectId result = eItr.next().toObjectId();
+	 * </pre>
+	 * 
+	 * @param nthPosition
+	 *            position within the traversal of {@link #iterator()} that the
+	 *            caller needs the object for. The first returned
+	 *            {@link MutableEntry} is 0, the second is 1, etc.
+	 * @return the ObjectId for the corresponding entry.
+	 */
+	abstract ObjectId getObjectId(long nthPosition);
+
+	/**
+	 * Get ObjectId for the n-th object entry returned by {@link #iterator()}.
+	 * <p>
+	 * This method is a constant-time replacement for the following loop:
+	 * 
+	 * <pre>
+	 * Iterator&lt;MutableEntry&gt; eItr = index.iterator();
+	 * int curPosition = 0;
+	 * while (eItr.hasNext() &amp;&amp; curPosition++ &lt; nthPosition)
+	 * 	eItr.next();
+	 * ObjectId result = eItr.next().toObjectId();
+	 * </pre>
+	 * 
+	 * @param nthPosition
+	 *            unsigned 32 bit position within the traversal of
+	 *            {@link #iterator()} that the caller needs the object for. The
+	 *            first returned {@link MutableEntry} is 0, the second is 1,
+	 *            etc. Positions past 2**31-1 are negative, but still valid.
+	 * @return the ObjectId for the corresponding entry.
+	 */
+	final ObjectId getObjectId(final int nthPosition) {
+		if (nthPosition >= 0)
+			return getObjectId((long) nthPosition);
+		final int u31 = nthPosition >>> 1;
+		final int one = nthPosition & 1;
+		return getObjectId(((long) u31) << 1 | one);
+	}
+
+	/**
 	 * Locate the file offset position for the requested object.
 	 * 
 	 * @param objId
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
index b8d9de3..b58dfdf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
@@ -40,6 +40,7 @@ package org.spearce.jgit.lib;
 
 import java.io.IOException;
 import java.io.InputStream;
+import java.util.Arrays;
 import java.util.Iterator;
 import java.util.NoSuchElementException;
 
@@ -49,6 +50,8 @@ import org.spearce.jgit.util.NB;
 class PackIndexV1 extends PackIndex {
 	private static final int IDX_HDR_LEN = 256 * 4;
 
+	private final long[] idxHeader;
+
 	private byte[][] idxdata;
 
 	private long objectCnt;
@@ -59,7 +62,7 @@ class PackIndexV1 extends PackIndex {
 		System.arraycopy(hdr, 0, fanoutTable, 0, hdr.length);
 		NB.readFully(fd, fanoutTable, hdr.length, IDX_HDR_LEN - hdr.length);
 
-		final long[] idxHeader = new long[256]; // really unsigned 32-bit...
+		idxHeader = new long[256]; // really unsigned 32-bit...
 		for (int k = 0; k < idxHeader.length; k++)
 			idxHeader[k] = NB.decodeUInt32(fanoutTable, k * 4);
 		idxdata = new byte[idxHeader.length][];
@@ -82,6 +85,39 @@ class PackIndexV1 extends PackIndex {
 		return objectCnt;
 	}
 
+	@Override
+	long getOffset64Count() {
+		long n64 = 0;
+		for (final MutableEntry e : this) {
+			if (e.getOffset() >= Integer.MAX_VALUE)
+				n64++;
+		}
+		return n64;
+	}
+
+	@Override
+	ObjectId getObjectId(final long nthPosition) {
+		int levelOne = Arrays.binarySearch(idxHeader, nthPosition + 1);
+		long base;
+		if (levelOne >= 0) {
+			// If we hit the bucket exactly the item is in the bucket, or
+			// any bucket before it which has the same object count.
+			//
+			base = idxHeader[levelOne];
+			while (levelOne > 0 && base == idxHeader[levelOne - 1])
+				levelOne--;
+		} else {
+			// The item is in the bucket we would insert it into.
+			//
+			levelOne = -(levelOne + 1);
+		}
+
+		base = levelOne > 0 ? idxHeader[levelOne - 1] : 0;
+		final int p = (int) (nthPosition - base);
+		final int dataIdx = ((4 + Constants.OBJECT_ID_LENGTH) * p) + 4;
+		return ObjectId.fromRaw(idxdata[levelOne], dataIdx);
+	}
+
 	long findOffset(final AnyObjectId objId) {
 		final int levelOne = objId.getFirstByte();
 		byte[] data = idxdata[levelOne];
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
index ae70f11..8b2c6d6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
@@ -40,6 +40,7 @@ package org.spearce.jgit.lib;
 import java.io.EOFException;
 import java.io.IOException;
 import java.io.InputStream;
+import java.util.Arrays;
 import java.util.Iterator;
 import java.util.NoSuchElementException;
 
@@ -57,6 +58,8 @@ class PackIndexV2 extends PackIndex {
 
 	private long objectCnt;
 
+	private final long[] fanoutTable;
+
 	/** 256 arrays of contiguous object names. */
 	private int[][] names;
 
@@ -69,7 +72,7 @@ class PackIndexV2 extends PackIndex {
 	PackIndexV2(final InputStream fd) throws IOException {
 		final byte[] fanoutRaw = new byte[4 * FANOUT];
 		NB.readFully(fd, fanoutRaw, 0, fanoutRaw.length);
-		final long[] fanoutTable = new long[FANOUT];
+		fanoutTable = new long[FANOUT];
 		for (int k = 0; k < FANOUT; k++)
 			fanoutTable[k] = NB.decodeUInt32(fanoutRaw, k * 4);
 		objectCnt = fanoutTable[FANOUT - 1];
@@ -151,6 +154,34 @@ class PackIndexV2 extends PackIndex {
 	}
 
 	@Override
+	long getOffset64Count() {
+		return offset64.length / 8;
+	}
+
+	@Override
+	ObjectId getObjectId(final long nthPosition) {
+		int levelOne = Arrays.binarySearch(fanoutTable, nthPosition + 1);
+		long base;
+		if (levelOne >= 0) {
+			// If we hit the bucket exactly the item is in the bucket, or
+			// any bucket before it which has the same object count.
+			//
+			base = fanoutTable[levelOne];
+			while (levelOne > 0 && base == fanoutTable[levelOne - 1])
+				levelOne--;
+		} else {
+			// The item is in the bucket we would insert it into.
+			//
+			levelOne = -(levelOne + 1);
+		}
+
+		base = levelOne > 0 ? fanoutTable[levelOne - 1] : 0;
+		final int p = (int) (nthPosition - base);
+		final int p4 = p << 2;
+		return ObjectId.fromRaw(names[levelOne], p4 + p); // p * 5
+	}
+
+	@Override
 	long findOffset(final AnyObjectId objId) {
 		final int levelOne = objId.getFirstByte();
 		final int[] data = names[levelOne];
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java
index 3dede88..bac7477 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackReverseIndex.java
@@ -38,7 +38,6 @@
 package org.spearce.jgit.lib;
 
 import java.util.Arrays;
-import java.util.Comparator;
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.lib.PackIndex.MutableEntry;
@@ -54,6 +53,9 @@ import org.spearce.jgit.lib.PackIndex.MutableEntry;
  * @see PackFile
  */
 class PackReverseIndex {
+	/** Index we were created from, and that has our ObjectId data. */
+	private final PackIndex index;
+
 	/**
 	 * (offset31, truly) Offsets accommodating in 31 bits.
 	 */
@@ -64,48 +66,55 @@ class PackReverseIndex {
 	 */
 	private final long offsets64[];
 
-	/**
-	 * Object ids corresponding to {@link #offsets32} and {@link #offsets64}.
-	 */
-	private final int names[];
+	/** Position of the corresponding {@link #offsets32} in {@link #index}. */
+	private final int nth32[];
+
+	/** Position of the corresponding {@link #offsets64} in {@link #index}. */
+	private final int nth64[];
 
 	/**
 	 * Create reverse index from straight/forward pack index, by indexing all
 	 * its entries.
 	 * 
-	 * @param index
+	 * @param packIndex
 	 *            forward index - entries to (reverse) index.
 	 */
-	PackReverseIndex(final PackIndex index) {
-		final long count = index.getObjectCount();
-		if (count > Integer.MAX_VALUE)
+	PackReverseIndex(final PackIndex packIndex) {
+		index = packIndex;
+
+		final long cnt = index.getObjectCount();
+		final long n64 = index.getOffset64Count();
+		final long n32 = cnt - n64;
+		if (n32 > Integer.MAX_VALUE || n64 > Integer.MAX_VALUE
+				|| cnt > 0xffffffffL)
 			throw new IllegalArgumentException(
-					"Huge indexes (> 2^31 entries) are not supported by jgit, yet");
-
-		final MutableEntry entries[] = new MutableEntry[(int) count];
-		int i = 0;
-		int count32 = 0;
-		for (MutableEntry me : index) {
-			entries[i++] = me.cloneEntry();
-			if (me.getOffset() <= Integer.MAX_VALUE)
-				count32++;
+					"Huge indexes are not supported by jgit, yet");
+
+		offsets32 = new int[(int) n32];
+		offsets64 = new long[(int) n64];
+		nth32 = new int[offsets32.length];
+		nth64 = new int[offsets64.length];
+
+		int i32 = 0;
+		int i64 = 0;
+		for (final MutableEntry me : index) {
+			final long o = me.getOffset();
+			if (o < Integer.MAX_VALUE)
+				offsets32[i32++] = (int) o;
+			else
+				offsets64[i64++] = o;
 		}
-		Arrays.sort(entries, new Comparator<MutableEntry>() {
-			public int compare(MutableEntry o1, MutableEntry o2) {
-				return Long.signum(o1.getOffset() - o2.getOffset());
-			}
-		});
-
-		names = new int[entries.length * Constants.OBJECT_ID_LENGTH / 4];
-		offsets32 = new int[count32];
-		offsets64 = new long[entries.length - count32];
-		for (int j = 0, j32 = 0; j < entries.length; j++) {
-			final long offset = entries[j].getOffset();
-			if (offset <= Integer.MAX_VALUE)
-				offsets32[j32++] = (int) offset;
+
+		Arrays.sort(offsets32);
+		Arrays.sort(offsets64);
+
+		int nth = 0;
+		for (final MutableEntry me : index) {
+			final long o = me.getOffset();
+			if (o < Integer.MAX_VALUE)
+				nth32[Arrays.binarySearch(offsets32, (int) o)] = nth++;
 			else
-				offsets64[j - j32] = offset;
-			entries[j].copyRawTo(names, j * Constants.OBJECT_ID_LENGTH / 4);
+				nth64[Arrays.binarySearch(offsets64, o)] = nth++;
 		}
 	}
 
@@ -122,15 +131,12 @@ class PackReverseIndex {
 			final int i32 = Arrays.binarySearch(offsets32, (int) offset);
 			if (i32 < 0)
 				return null;
-			final int iNames = i32 * Constants.OBJECT_ID_LENGTH / 4;
-			return ObjectId.fromRaw(names, iNames);
+			return index.getObjectId(nth32[i32]);
 		} else {
 			final int i64 = Arrays.binarySearch(offsets64, offset);
 			if (i64 < 0)
 				return null;
-			final int iNames = (i64 + offsets32.length)
-					* Constants.OBJECT_ID_LENGTH / 4;
-			return ObjectId.fromRaw(names, iNames);
+			return index.getObjectId(nth64[i64]);
 		}
 	}
 
-- 
1.5.6.rc2.181.gbb495


-- 
Shawn.
