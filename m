From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/11] Replace inefficient new Long(long) constructor to silence FindBugs
Date: Wed, 29 Apr 2009 11:54:41 -0700
Message-ID: <1241031288-23437-5-git-send-email-spearce@spearce.org>
References: <1241031288-23437-1-git-send-email-spearce@spearce.org>
 <1241031288-23437-2-git-send-email-spearce@spearce.org>
 <1241031288-23437-3-git-send-email-spearce@spearce.org>
 <1241031288-23437-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, Yann Simon <yann.simon.fr@gmail.com>,
	Matthias Sohn <matthias.sohn@sap.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwn-0003Rz-BB
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbZD2SzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755589AbZD2Sy5
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:54:57 -0400
Received: from george.spearce.org ([209.20.77.23]:32883 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbZD2Syw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:52 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 331EA38076; Wed, 29 Apr 2009 18:54:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6FBC538064;
	Wed, 29 Apr 2009 18:54:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.199.g24398
In-Reply-To: <1241031288-23437-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117924>

FindBugs keeps warning us that new Long(long) is inefficient because
it doesn't permit using cached values in the -128..127 range.

http://thread.gmane.org/gmane.comp.version-control.git/113738/focus=113785
> Why I box with new Long() over Long.valueOf():
>
>  The standard only requires -128..127 to be cached.  A JRE can
>  cache value outside of this range if it chooses, but long has a
>  huge range, its unlikely to cache much beyond this required region.
>
>  Most pack files are in the 10 MB...100+ MB range.  Most objects
>  take more than 100 bytes in a pack, even compressed delta encoded.
>  Thus any object after the first is going to have its offset outside
>  of the cached range.
>
>  In other words, why waste the CPU cycles on the "cached range
>  bounds check" when I'm always going to fail and allocate.  I might
>  as well just allocate
>
>  These sections of code are rather performance critical for the
>  indexing phase of a pack receive, on either side of a connection.
>  I need to shave even more instructions out of the critical paths,
>  as its not fast enough as-is.  Using new Long() is quicker than
>  using Long.valueOf(), so new Long() it is.

We now use a custom Map implementation which supports primitive long
as the hash key, rather than requiring boxing for java.util.HashMap.
This removes the issue FindBugs was identifying.

This version performs slightly better than before.
index-pack on linux-2.6:

  parent commit:  2m58.611s
  this commit  :  2m57.068s

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Yann Simon <yann.simon.fr@gmail.com>
CC: Matthias Sohn <matthias.sohn@sap.com>
---

 Unchanged.
 
 .../src/org/spearce/jgit/transport/IndexPack.java  |   12 +-
 .../src/org/spearce/jgit/transport/LongMap.java    |  152 ++++++++++++++++++++
 2 files changed, 157 insertions(+), 7 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/LongMap.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index e0e4855..59fdeae 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -47,7 +47,6 @@
 import java.security.MessageDigest;
 import java.util.ArrayList;
 import java.util.Arrays;
-import java.util.HashMap;
 import java.util.List;
 import java.util.zip.CRC32;
 import java.util.zip.DataFormatException;
@@ -163,7 +162,7 @@ public static IndexPack create(final Repository db, final InputStream is)
 
 	private ObjectIdMap<ArrayList<UnresolvedDelta>> baseById;
 
-	private HashMap<Long, ArrayList<UnresolvedDelta>> baseByPos;
+	private LongMap<ArrayList<UnresolvedDelta>> baseByPos;
 
 	private byte[] objectData;
 
@@ -303,7 +302,7 @@ public void index(final ProgressMonitor progress) throws IOException {
 
 				entries = new PackedObjectInfo[(int) objectCount];
 				baseById = new ObjectIdMap<ArrayList<UnresolvedDelta>>();
-				baseByPos = new HashMap<Long, ArrayList<UnresolvedDelta>>();
+				baseByPos = new LongMap<ArrayList<UnresolvedDelta>>();
 
 				progress.beginTask(PROGRESS_DOWNLOAD, (int) objectCount);
 				for (int done = 0; done < objectCount; done++) {
@@ -382,8 +381,7 @@ private void resolveDeltas(final ProgressMonitor progress)
 
 	private void resolveDeltas(final PackedObjectInfo oe) throws IOException {
 		final int oldCRC = oe.getCRC();
-		if (baseById.containsKey(oe)
-				|| baseByPos.containsKey(new Long(oe.getOffset())))
+		if (baseById.containsKey(oe) || baseByPos.containsKey(oe.getOffset()))
 			resolveDeltas(oe.getOffset(), oldCRC, Constants.OBJ_BAD, null, oe);
 	}
 
@@ -448,7 +446,7 @@ private void resolveDeltas(final long pos, final int oldCRC, int type,
 	private void resolveChildDeltas(final long pos, int type, byte[] data,
 			PackedObjectInfo oe) throws IOException {
 		final ArrayList<UnresolvedDelta> a = baseById.remove(oe);
-		final ArrayList<UnresolvedDelta> b = baseByPos.remove(new Long(pos));
+		final ArrayList<UnresolvedDelta> b = baseByPos.remove(pos);
 		int ai = 0, bi = 0;
 		if (a != null && b != null) {
 			while (ai < a.size() && bi < b.size()) {
@@ -679,7 +677,7 @@ private void indexOneObject() throws IOException {
 				ofs <<= 7;
 				ofs += (c & 127);
 			}
-			final Long base = new Long(pos - ofs);
+			final long base = pos - ofs;
 			ArrayList<UnresolvedDelta> r = baseByPos.get(base);
 			if (r == null) {
 				r = new ArrayList<UnresolvedDelta>(8);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/LongMap.java b/org.spearce.jgit/src/org/spearce/jgit/transport/LongMap.java
new file mode 100644
index 0000000..ac41f56
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/LongMap.java
@@ -0,0 +1,152 @@
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
+package org.spearce.jgit.transport;
+
+/**
+ * Simple Map<long,Object> helper for {@link IndexPack}.
+ *
+ * @param <V>
+ *            type of the value instance.
+ */
+final class LongMap<V> {
+	private static final float LOAD_FACTOR = 0.75f;
+
+	private Node<V>[] table;
+
+	/** Number of entries currently in the map. */
+	private int size;
+
+	/** Next {@link #size} to trigger a {@link #grow()}. */
+	private int growAt;
+
+	LongMap() {
+		table = createArray(64);
+		growAt = (int) (table.length * LOAD_FACTOR);
+	}
+
+	boolean containsKey(final long key) {
+		return get(key) != null;
+	}
+
+	V get(final long key) {
+		for (Node<V> n = table[index(key)]; n != null; n = n.next) {
+			if (n.key == key)
+				return n.value;
+		}
+		return null;
+	}
+
+	V remove(final long key) {
+		Node<V> n = table[index(key)];
+		Node<V> prior = null;
+		while (n != null) {
+			if (n.key == key) {
+				if (prior == null)
+					table[index(key)] = n.next;
+				else
+					prior.next = n.next;
+				size--;
+				return n.value;
+			}
+			prior = n;
+			n = n.next;
+		}
+		return null;
+	}
+
+	V put(final long key, final V value) {
+		for (Node<V> n = table[index(key)]; n != null; n = n.next) {
+			if (n.key == key) {
+				final V o = n.value;
+				n.value = value;
+				return o;
+			}
+		}
+
+		if (++size == growAt)
+			grow();
+		insert(new Node<V>(key, value));
+		return null;
+	}
+
+	private void insert(final Node<V> n) {
+		final int idx = index(n.key);
+		n.next = table[idx];
+		table[idx] = n;
+	}
+
+	private void grow() {
+		final Node<V>[] oldTable = table;
+		final int oldSize = table.length;
+
+		table = createArray(oldSize << 1);
+		growAt = (int) (table.length * LOAD_FACTOR);
+		for (int i = 0; i < oldSize; i++) {
+			Node<V> e = oldTable[i];
+			while (e != null) {
+				final Node<V> n = e.next;
+				insert(e);
+				e = n;
+			}
+		}
+	}
+
+	private final int index(final long key) {
+		int h = ((int) key) >>> 1;
+		h ^= (h >>> 20) ^ (h >>> 12);
+		return h & (table.length - 1);
+	}
+
+	@SuppressWarnings("unchecked")
+	private static final <V> Node<V>[] createArray(final int sz) {
+		return new Node[sz];
+	}
+
+	private static class Node<V> {
+		final long key;
+
+		V value;
+
+		Node<V> next;
+
+		Node(final long k, final V v) {
+			key = k;
+			value = v;
+		}
+	}
+}
-- 
1.6.3.rc3.199.g24398
