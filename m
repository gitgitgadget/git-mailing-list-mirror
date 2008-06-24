From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/10] Rename ObjectEntry to PackedObjectInfo
Date: Mon, 23 Jun 2008 22:10:01 -0400
Message-ID: <1214273408-70793-4-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
 <1214273408-70793-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0U-0005iO-Py
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbYFXCKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbYFXCKb
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49752 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbYFXCKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxz4-0001NT-Qp; Mon, 23 Jun 2008 22:10:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id A450720FBCA; Mon, 23 Jun 2008 22:10:24 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 0808320FBCE;
	Mon, 23 Jun 2008 22:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-3-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85971>

Technically this class contains information about a packed object,
data which is necessary to access it or to create the index record
to support random access to the object's information.  Calling it
just ObjectEntry is no longer a very sufficient name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/IndexPack.java  |   26 ++++----
 .../org/spearce/jgit/transport/ObjectEntry.java    |   59 --------------------
 .../spearce/jgit/transport/PackedObjectInfo.java   |   59 ++++++++++++++++++++
 3 files changed, 72 insertions(+), 72 deletions(-)
 delete mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 19a4b7b..ad4bcae 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -129,7 +129,7 @@ public class IndexPack {
 
 	private long objectCount;
 
-	private ObjectEntry[] entries;
+	private PackedObjectInfo[] entries;
 
 	private int deltaCount;
 
@@ -208,7 +208,7 @@ public class IndexPack {
 			try {
 				readPackHeader();
 
-				entries = new ObjectEntry[(int) objectCount];
+				entries = new PackedObjectInfo[(int) objectCount];
 				baseById = new ObjectIdMap<ArrayList<UnresolvedDelta>>();
 				baseByPos = new HashMap<Long, ArrayList<UnresolvedDelta>>();
 
@@ -280,14 +280,14 @@ public class IndexPack {
 		progress.endTask();
 	}
 
-	private void resolveDeltas(final ObjectEntry oe) throws IOException {
+	private void resolveDeltas(final PackedObjectInfo oe) throws IOException {
 		if (baseById.containsKey(oe)
 				|| baseByPos.containsKey(new Long(oe.getOffset())))
 			resolveDeltas(oe.getOffset(), Constants.OBJ_BAD, null, oe);
 	}
 
 	private void resolveDeltas(final long pos, int type, byte[] data,
-			ObjectEntry oe) throws IOException {
+			PackedObjectInfo oe) throws IOException {
 		position(pos);
 		int c = readFromFile();
 		final int typeCode = (c >> 4) & 7;
@@ -331,7 +331,7 @@ public class IndexPack {
 			objectDigest.update((byte) 0);
 			objectDigest.update(data);
 			tempObjectId.fromRaw(objectDigest.digest(), 0);
-			oe = new ObjectEntry(pos, tempObjectId);
+			oe = new PackedObjectInfo(pos, tempObjectId);
 			entries[entryCount++] = oe;
 		}
 
@@ -339,7 +339,7 @@ public class IndexPack {
 	}
 
 	private void resolveChildDeltas(final long pos, int type, byte[] data,
-			ObjectEntry oe) throws IOException {
+			PackedObjectInfo oe) throws IOException {
 		final ArrayList<UnresolvedDelta> a = baseById.remove(oe);
 		final ArrayList<UnresolvedDelta> b = baseByPos.remove(new Long(pos));
 		int ai = 0, bi = 0;
@@ -374,9 +374,9 @@ public class IndexPack {
 			final ObjectLoader ldr = repo.openObject(baseId);
 			final byte[] data = ldr.getBytes();
 			final int typeCode = ldr.getType();
-			final ObjectEntry oe;
+			final PackedObjectInfo oe;
 
-			oe = new ObjectEntry(end, baseId);
+			oe = new PackedObjectInfo(end, baseId);
 			entries[entryCount++] = oe;
 			packOut.seek(end);
 			writeWhole(def, typeCode, data);
@@ -432,9 +432,9 @@ public class IndexPack {
 	}
 
 	private void growEntries() {
-		final ObjectEntry[] ne;
+		final PackedObjectInfo[] ne;
 
-		ne = new ObjectEntry[(int) objectCount + baseById.size()];
+		ne = new PackedObjectInfo[(int) objectCount + baseById.size()];
 		System.arraycopy(entries, 0, ne, 0, entryCount);
 		entries = ne;
 	}
@@ -458,7 +458,7 @@ public class IndexPack {
 				d.update(rawoe, 0, 4);
 			}
 			for (int i = 0; i < entryCount; i++) {
-				final ObjectEntry oe = entries[i];
+				final PackedObjectInfo oe = entries[i];
 				if (oe.getOffset() >>> 1 > Integer.MAX_VALUE)
 					throw new IOException("Pack too large for index version 1");
 				NB.encodeInt32(rawoe, 0, (int) oe.getOffset());
@@ -578,7 +578,7 @@ public class IndexPack {
 		objectDigest.update((byte) 0);
 		inflateFromInput(true);
 		tempObjectId.fromRaw(objectDigest.digest(), 0);
-		entries[entryCount++] = new ObjectEntry(pos, tempObjectId);
+		entries[entryCount++] = new PackedObjectInfo(pos, tempObjectId);
 	}
 
 	// Current position of {@link #bOffset} within the entire file.
@@ -739,7 +739,7 @@ public class IndexPack {
 		final MessageDigest d = Constants.newMessageDigest();
 		final byte[] oeBytes = new byte[Constants.OBJECT_ID_LENGTH];
 		for (int i = 0; i < entryCount; i++) {
-			final ObjectEntry oe = entries[i];
+			final PackedObjectInfo oe = entries[i];
 			oe.copyRawTo(oeBytes, 0);
 			d.update(oeBytes);
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java
deleted file mode 100644
index 10a8f4d..0000000
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ObjectEntry.java
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- *
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or
- * without modification, are permitted provided that the following
- * conditions are met:
- *
- * - Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- * - Redistributions in binary form must reproduce the above
- *   copyright notice, this list of conditions and the following
- *   disclaimer in the documentation and/or other materials provided
- *   with the distribution.
- *
- * - Neither the name of the Git Development Community nor the
- *   names of its contributors may be used to endorse or promote
- *   products derived from this software without specific prior
- *   written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
- * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
- * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-package org.spearce.jgit.transport;
-
-import org.spearce.jgit.lib.AnyObjectId;
-import org.spearce.jgit.lib.ObjectId;
-
-class ObjectEntry extends ObjectId {
-	private long offset;
-
-	ObjectEntry(final long headerOffset, final AnyObjectId id) {
-		super(id);
-		offset = headerOffset;
-	}
-
-	/**
-	 * @return offset in pack when object has been already written, or -1 if it
-	 *         has not been written yet
-	 */
-	long getOffset() {
-		return offset;
-	}
-}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
new file mode 100644
index 0000000..eaedee9
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+package org.spearce.jgit.transport;
+
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.ObjectId;
+
+class PackedObjectInfo extends ObjectId {
+	private long offset;
+
+	PackedObjectInfo(final long headerOffset, final AnyObjectId id) {
+		super(id);
+		offset = headerOffset;
+	}
+
+	/**
+	 * @return offset in pack when object has been already written, or -1 if it
+	 *         has not been written yet
+	 */
+	long getOffset() {
+		return offset;
+	}
+}
-- 
1.5.6.74.g8a5e
