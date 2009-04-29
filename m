From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/11] Change IndexPack to use ObjectIdSubclassMap instead of ObjectIdMap
Date: Wed, 29 Apr 2009 11:54:42 -0700
Message-ID: <1241031288-23437-6-git-send-email-spearce@spearce.org>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
 <1241031288-23437-2-git-send-email-spearce@spearce.org>
 <1241031288-23437-3-git-send-email-spearce@spearce.org>
 <1241031288-23437-4-git-send-email-spearce@spearce.org>
 <1241031288-23437-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:56:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEww-0003Rz-DX
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbZD2SzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758053AbZD2SzH
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:55:07 -0400
Received: from george.spearce.org ([209.20.77.23]:32878 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbZD2Syw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:52 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 097D238078; Wed, 29 Apr 2009 18:54:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D6D3738069;
	Wed, 29 Apr 2009 18:54:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
In-Reply-To: <1241031288-23437-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117920>

The ObjectIdSubclassMap performs slightly better on average than the
ObjectIdMap, and uses a lot less memory as we don't need to allocate
a tree node per tracked object.

This reduces the memory footprint of IndexPack, by storing a linked
list of the UnresolvedDelta objects directly in each map, which is
slightly smaller than using an ArrayList inside of a TreeMap.

Performance is marginally faster, but we now can declare ObjectIdMap
to be fully deprecated and start removing it from the library.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Unchanged.

 .../org/spearce/jgit/lib/ObjectIdSubclassMap.java  |   31 +++++-
 .../src/org/spearce/jgit/transport/IndexPack.java  |  123 +++++++++++++-------
 2 files changed, 109 insertions(+), 45 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
index 2a13204..bdacec4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdSubclassMap.java
@@ -37,6 +37,8 @@
 
 package org.spearce.jgit.lib;
 
+import java.util.Iterator;
+
 /**
  * Fast, efficient map specifically for {@link ObjectId} subclasses.
  * <p>
@@ -51,7 +53,7 @@
  * @param <V>
  *            type of subclass of ObjectId that will be stored in the map.
  */
-public class ObjectIdSubclassMap<V extends ObjectId> {
+public class ObjectIdSubclassMap<V extends ObjectId> implements Iterable<V> {
 	private int size;
 
 	private V[] obj_hash;
@@ -114,6 +116,33 @@ public int size() {
 		return size;
 	}
 
+	public Iterator<V> iterator() {
+		return new Iterator<V>() {
+			private int found;
+
+			private int i;
+
+			public boolean hasNext() {
+				return found < size;
+			}
+
+			public V next() {
+				while (i < obj_hash.length) {
+					final V v = obj_hash[i++];
+					if (v != null) {
+						found++;
+						return v;
+					}
+				}
+				throw new IllegalStateException();
+			}
+
+			public void remove() {
+				throw new UnsupportedOperationException();
+			}
+		};
+	}
+
 	private final int index(final AnyObjectId id) {
 		return (id.w1 >>> 1) % obj_hash.length;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 59fdeae..eecad9c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -62,7 +62,7 @@
 import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectChecker;
 import org.spearce.jgit.lib.ObjectId;
-import org.spearce.jgit.lib.ObjectIdMap;
+import org.spearce.jgit.lib.ObjectIdSubclassMap;
 import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.PackIndexWriter;
 import org.spearce.jgit.lib.ProgressMonitor;
@@ -160,9 +160,9 @@ public static IndexPack create(final Repository db, final InputStream is)
 
 	private final CRC32 crc = new CRC32();
 
-	private ObjectIdMap<ArrayList<UnresolvedDelta>> baseById;
+	private ObjectIdSubclassMap<DeltaChain> baseById;
 
-	private LongMap<ArrayList<UnresolvedDelta>> baseByPos;
+	private LongMap<UnresolvedDelta> baseByPos;
 
 	private byte[] objectData;
 
@@ -301,8 +301,8 @@ public void index(final ProgressMonitor progress) throws IOException {
 				readPackHeader();
 
 				entries = new PackedObjectInfo[(int) objectCount];
-				baseById = new ObjectIdMap<ArrayList<UnresolvedDelta>>();
-				baseByPos = new LongMap<ArrayList<UnresolvedDelta>>();
+				baseById = new ObjectIdSubclassMap<DeltaChain>();
+				baseByPos = new LongMap<UnresolvedDelta>();
 
 				progress.beginTask(PROGRESS_DOWNLOAD, (int) objectCount);
 				for (int done = 0; done < objectCount; done++) {
@@ -381,7 +381,7 @@ private void resolveDeltas(final ProgressMonitor progress)
 
 	private void resolveDeltas(final PackedObjectInfo oe) throws IOException {
 		final int oldCRC = oe.getCRC();
-		if (baseById.containsKey(oe) || baseByPos.containsKey(oe.getOffset()))
+		if (baseById.get(oe) != null || baseByPos.containsKey(oe.getOffset()))
 			resolveDeltas(oe.getOffset(), oldCRC, Constants.OBJ_BAD, null, oe);
 	}
 
@@ -443,34 +443,45 @@ private void resolveDeltas(final long pos, final int oldCRC, int type,
 		resolveChildDeltas(pos, type, data, oe);
 	}
 
+	private UnresolvedDelta removeBaseById(final AnyObjectId id){
+		final DeltaChain d = baseById.get(id);
+		return d != null ? d.remove() : null;
+	}
+
+	private static UnresolvedDelta reverse(UnresolvedDelta c) {
+		UnresolvedDelta tail = null;
+		while (c != null) {
+			final UnresolvedDelta n = c.next;
+			c.next = tail;
+			tail = c;
+			c = n;
+		}
+		return tail;
+	}
+
 	private void resolveChildDeltas(final long pos, int type, byte[] data,
 			PackedObjectInfo oe) throws IOException {
-		final ArrayList<UnresolvedDelta> a = baseById.remove(oe);
-		final ArrayList<UnresolvedDelta> b = baseByPos.remove(pos);
-		int ai = 0, bi = 0;
-		if (a != null && b != null) {
-			while (ai < a.size() && bi < b.size()) {
-				final UnresolvedDelta ad = a.get(ai);
-				final UnresolvedDelta bd = b.get(bi);
-				if (ad.position < bd.position) {
-					resolveDeltas(ad.position, ad.crc, type, data, null);
-					ai++;
-				} else {
-					resolveDeltas(bd.position, bd.crc, type, data, null);
-					bi++;
-				}
+		UnresolvedDelta a = reverse(removeBaseById(oe));
+		UnresolvedDelta b = reverse(baseByPos.remove(pos));
+		while (a != null && b != null) {
+			if (a.position < b.position) {
+				resolveDeltas(a.position, a.crc, type, data, null);
+				a = a.next;
+			} else {
+				resolveDeltas(b.position, b.crc, type, data, null);
+				b = b.next;
 			}
 		}
-		if (a != null)
-			while (ai < a.size()) {
-				final UnresolvedDelta ad = a.get(ai++);
-				resolveDeltas(ad.position, ad.crc, type, data, null);
-			}
-		if (b != null)
-			while (bi < b.size()) {
-				final UnresolvedDelta bd = b.get(bi++);
-				resolveDeltas(bd.position, bd.crc, type, data, null);
-			}
+		resolveChildDeltaChain(type, data, a);
+		resolveChildDeltaChain(type, data, b);
+	}
+
+	private void resolveChildDeltaChain(final int type, final byte[] data,
+			UnresolvedDelta a) throws IOException {
+		while (a != null) {
+			resolveDeltas(a.position, a.crc, type, data, null);
+			a = a.next;
+		}
 	}
 
 	private void fixThinPack(final ProgressMonitor progress) throws IOException {
@@ -479,11 +490,16 @@ private void fixThinPack(final ProgressMonitor progress) throws IOException {
 		packDigest.reset();
 		originalEOF = packOut.length() - 20;
 		final Deflater def = new Deflater(Deflater.DEFAULT_COMPRESSION, false);
+		final List<DeltaChain> missing = new ArrayList<DeltaChain>(64);
 		long end = originalEOF;
-		for (final ObjectId baseId : new ArrayList<ObjectId>(baseById.keySet())) {
+		for (final DeltaChain baseId : baseById) {
+			if (baseId.head == null)
+				continue;
 			final ObjectLoader ldr = repo.openObject(readCurs, baseId);
-			if (ldr == null)
+			if (ldr == null) {
+				missing.add(baseId);
 				continue;
+			}
 			final byte[] data = ldr.getBytes();
 			final int typeCode = ldr.getType();
 			final PackedObjectInfo oe;
@@ -501,9 +517,9 @@ private void fixThinPack(final ProgressMonitor progress) throws IOException {
 		}
 		def.end();
 
-		if (!baseById.isEmpty()) {
-			final ObjectId need = baseById.keySet().iterator().next();
-			throw new MissingObjectException(need, "delta base");
+		for (final DeltaChain base : missing) {
+			if (base.head != null)
+				throw new MissingObjectException(base, "delta base");
 		}
 
 		fixHeaderFooter(packcsum, packDigest.digest());
@@ -678,13 +694,10 @@ private void indexOneObject() throws IOException {
 				ofs += (c & 127);
 			}
 			final long base = pos - ofs;
-			ArrayList<UnresolvedDelta> r = baseByPos.get(base);
-			if (r == null) {
-				r = new ArrayList<UnresolvedDelta>(8);
-				baseByPos.put(base, r);
-			}
+			final UnresolvedDelta n;
 			skipInflateFromInput(sz);
-			r.add(new UnresolvedDelta(pos, (int) crc.getValue()));
+			n = new UnresolvedDelta(pos, (int) crc.getValue());
+			n.next = baseByPos.put(base, n);
 			deltaCount++;
 			break;
 		}
@@ -693,10 +706,10 @@ private void indexOneObject() throws IOException {
 			crc.update(buf, c, 20);
 			final ObjectId base = ObjectId.fromRaw(buf, c);
 			use(20);
-			ArrayList<UnresolvedDelta> r = baseById.get(base);
+			DeltaChain r = baseById.get(base);
 			if (r == null) {
-				r = new ArrayList<UnresolvedDelta>(8);
-				baseById.put(base, r);
+				r = new DeltaChain(base);
+				baseById.add(r);
 			}
 			skipInflateFromInput(sz);
 			r.add(new UnresolvedDelta(pos, (int) crc.getValue()));
@@ -937,11 +950,33 @@ private static CorruptObjectException corrupt(final DataFormatException dfe) {
 				+ dfe.getMessage());
 	}
 
+	private static class DeltaChain extends ObjectId {
+		UnresolvedDelta head;
+
+		DeltaChain(final AnyObjectId id) {
+			super(id);
+		}
+
+		UnresolvedDelta remove() {
+			final UnresolvedDelta r = head;
+			if (r != null)
+				head = null;
+			return r;
+		}
+
+		void add(final UnresolvedDelta d) {
+			d.next = head;
+			head = d;
+		}
+	}
+
 	private static class UnresolvedDelta {
 		final long position;
 
 		final int crc;
 
+		UnresolvedDelta next;
+
 		UnresolvedDelta(final long headerOffset, final int crc32) {
 			position = headerOffset;
 			crc = crc32;
-- 
1.6.3.rc3.199.g24398
