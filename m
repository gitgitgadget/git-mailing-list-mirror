From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 16/23] Defer parsing of the ObjectId while walking a PackIndex Iterator
Date: Wed, 24 Dec 2008 18:11:12 -0800
Message-ID: <1230171079-17156-17-git-send-email-spearce@spearce.org>
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
 <1230171079-17156-13-git-send-email-spearce@spearce.org>
 <1230171079-17156-14-git-send-email-spearce@spearce.org>
 <1230171079-17156-15-git-send-email-spearce@spearce.org>
 <1230171079-17156-16-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:14:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjT-00029A-Uz
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYLYCMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYLYCMO
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:12:14 -0500
Received: from george.spearce.org ([209.20.77.23]:59416 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbYLYCLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:30 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id EE28438222; Thu, 25 Dec 2008 02:11:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D197B38211;
	Thu, 25 Dec 2008 02:11:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-16-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103888>

This is a slight performance improvement for the PackReverseIndex
construction.  The only code that really cares about the ObjectId
from a PackIndex entry is test cases.  By avoiding construction
we can save some CPU time during the several passes we do to make
the reverse index data structure within PackWriter.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/PackIndexTest.java    |    4 +-
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    2 +-
 .../src/org/spearce/jgit/lib/PackIndex.java        |   48 +++++++++++--------
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   20 +++++---
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   27 +++++++----
 5 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
index 8ab380e..7163718 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
@@ -134,10 +134,10 @@ assertEquals("c59759f143fb1fe21c197981df75a7ee00290799", iter.next()
 	 */
 	public void testCompareEntriesOffsetsWithFindOffsets() {
 		for (MutableEntry me : smallIdx) {
-			assertEquals(smallIdx.findOffset(me), me.getOffset());
+			assertEquals(smallIdx.findOffset(me.toObjectId()), me.getOffset());
 		}
 		for (MutableEntry me : denseIdx) {
-			assertEquals(denseIdx.findOffset(me), me.getOffset());
+			assertEquals(denseIdx.findOffset(me.toObjectId()), me.getOffset());
 		}
 	}
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 3c02955..ec138a0 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -487,7 +487,7 @@ public int compare(MutableEntry o1, MutableEntry o2) {
 
 		int i = 0;
 		for (MutableEntry me : entries) {
-			assertEquals(objectsOrder[i++], me.copy());
+			assertEquals(objectsOrder[i++].toObjectId(), me.toObjectId());
 		}
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 5fb41b1..5b7a62d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -239,15 +239,10 @@ abstract long findCRC32(AnyObjectId objId) throws MissingObjectException,
 	 * in pack (both mutable).
 	 * 
 	 */
-	public static class MutableEntry extends MutableObjectId {
-		private long offset;
+	public static class MutableEntry {
+		protected final MutableObjectId idBuffer = new MutableObjectId();
 
-		/**
-		 * Empty constructor. Object fields should be filled in later.
-		 */
-		public MutableEntry() {
-			super();
-		}
+		long offset;
 
 		/**
 		 * Returns offset for this index object entry
@@ -258,30 +253,43 @@ public long getOffset() {
 			return offset;
 		}
 
-		void setOffset(long offset) {
-			this.offset = offset;
+		/** @return hex string describing the object id of this entry. */
+		public String name() {
+			ensureId();
+			return idBuffer.name();
 		}
 
-		private MutableEntry(MutableEntry src) {
-			super(src);
-			this.offset = src.offset;
+		/** @return a copy of the object id. */
+		public ObjectId toObjectId() {
+			ensureId();
+			return idBuffer.toObjectId();
 		}
 
-		/**
-		 * Returns mutable copy of this mutable entry.
-		 * 
-		 * @return copy of this mutable entry
-		 */
+		/** @return a complete copy of this entry, that won't modify */
 		public MutableEntry cloneEntry() {
-			return new MutableEntry(this);
+			final MutableEntry r = new MutableEntry();
+			ensureId();
+			r.idBuffer.w1 = idBuffer.w1;
+			r.idBuffer.w2 = idBuffer.w2;
+			r.idBuffer.w3 = idBuffer.w3;
+			r.idBuffer.w4 = idBuffer.w4;
+			r.idBuffer.w5 = idBuffer.w5;
+			r.offset = offset;
+			return r;
+		}
+		
+		protected void ensureId() {
+			// Override in implementations.
 		}
 	}
 
 	protected abstract class EntriesIterator implements Iterator<MutableEntry> {
-		protected MutableEntry objectId = new MutableEntry();
+		protected final MutableEntry entry = initEntry();
 
 		protected long returnedNumber = 0;
 
+		protected abstract MutableEntry initEntry();
+
 		public boolean hasNext() {
 			return returnedNumber < getObjectCount();
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
index 02465f6..90b5f6f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
@@ -162,21 +162,27 @@ boolean hasCRC32Support() {
 
 		private int levelTwo;
 
+		@Override
+		protected MutableEntry initEntry() {
+			return new MutableEntry() {
+				protected void ensureId() {
+					idBuffer.fromRaw(idxdata[levelOne], levelTwo
+							- Constants.OBJECT_ID_LENGTH);
+				}
+			};
+		}
+
 		public MutableEntry next() {
 			for (; levelOne < idxdata.length; levelOne++) {
 				if (idxdata[levelOne] == null)
 					continue;
-
 				if (levelTwo < idxdata[levelOne].length) {
-					long offset = NB.decodeUInt32(idxdata[levelOne], levelTwo);
-					objectId.setOffset(offset);
-					objectId.fromRaw(idxdata[levelOne], levelTwo + 4);
+					entry.offset = NB.decodeUInt32(idxdata[levelOne], levelTwo);
 					levelTwo += Constants.OBJECT_ID_LENGTH + 4;
 					returnedNumber++;
-					return objectId;
-				} else {
-					levelTwo = 0;
+					return entry;
 				}
+				levelTwo = 0;
 			}
 			throw new NoSuchElementException();
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
index cc3ad65..48a5206 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
@@ -234,25 +234,32 @@ else if (cmp == 0) {
 
 		private int levelTwo;
 
+		@Override
+		protected MutableEntry initEntry() {
+			return new MutableEntry() {
+				protected void ensureId() {
+					idBuffer.fromRaw(names[levelOne], levelTwo
+							- Constants.OBJECT_ID_LENGTH / 4);
+				}
+			};
+		}
+
 		public MutableEntry next() {
 			for (; levelOne < names.length; levelOne++) {
 				if (levelTwo < names[levelOne].length) {
-					objectId.fromRaw(names[levelOne], levelTwo);
-					int arrayIdx = levelTwo / (Constants.OBJECT_ID_LENGTH / 4)
-							* 4;
-					long offset = NB.decodeUInt32(offset32[levelOne], arrayIdx);
+					int idx = levelTwo / (Constants.OBJECT_ID_LENGTH / 4) * 4;
+					long offset = NB.decodeUInt32(offset32[levelOne], idx);
 					if ((offset & IS_O64) != 0) {
-						arrayIdx = (8 * (int) (offset & ~IS_O64));
-						offset = NB.decodeUInt64(offset64, arrayIdx);
+						idx = (8 * (int) (offset & ~IS_O64));
+						offset = NB.decodeUInt64(offset64, idx);
 					}
-					objectId.setOffset(offset);
+					entry.offset = offset;
 
 					levelTwo += Constants.OBJECT_ID_LENGTH / 4;
 					returnedNumber++;
-					return objectId;
-				} else {
-					levelTwo = 0;
+					return entry;
 				}
+				levelTwo = 0;
 			}
 			throw new NoSuchElementException();
 		}
-- 
1.6.1.rc4.301.g5497a
