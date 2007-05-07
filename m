From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 07/10] Cache pack index fully
Date: Mon, 07 May 2007 23:29:51 +0200
Message-ID: <20070507212950.21546.30080.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAmr-00043f-Sd
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966813AbXEGVaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966816AbXEGVaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:30:25 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12269 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966813AbXEGVaV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:30:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DF9A2800783;
	Mon,  7 May 2007 23:24:14 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24816-03; Mon,  7 May 2007 23:24:13 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id ABC7D802676;
	Mon,  7 May 2007 23:24:13 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 49DA5294E9;
	Mon,  7 May 2007 23:30:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id WMUshanSmAJ8; Mon,  7 May 2007 23:30:03 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 33C0F294E7;
	Mon,  7 May 2007 23:29:51 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46489>

Navigating the pack index for every lookup takes time, mostly
because it takes resources from the memory mapping for getting
the actual objects.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../jgit/lib/DeltaRefPackedObjectLoader.java       |    3 
 .../src/org/spearce/jgit/lib/ObjectId.java         |   17 ++
 .../src/org/spearce/jgit/lib/ObjectIdMap.java      |  145 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/PackFile.java         |   87 ++++++------
 .../src/org/spearce/jgit/lib/Repository.java       |   17 +-
 .../tst/org/spearce/jgit/lib/ObjectIdMapTest.java  |  170 +++++++++++++++++++++++
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    2 
 7 files changed, 377 insertions(+), 64 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
index 2719738..90c01ea 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/DeltaRefPackedObjectLoader.java
@@ -15,8 +15,7 @@ class DeltaRefPackedObjectLoader extends DeltaPackedObjectLoader {
 	}
 
 	protected ObjectLoader getBaseLoader() throws IOException {
-		final ObjectLoader or = pack.get(deltaBase,
-				new byte[Constants.OBJECT_ID_LENGTH]);
+		final ObjectLoader or = pack.get(deltaBase);
 		if (or == null)
 			throw new MissingObjectException(deltaBase, "delta base");
 		return or;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index fea0d91..f99c303 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -83,10 +83,20 @@ public class ObjectId implements Comparable {
 		return new ObjectId(id);
 	}
 
-	private static int compare(final byte[] a, final byte[] b) {
-		if (a==b)
-			return 0;
+	public int compareTo(byte[] b, long pos) {
 		for (int k = 0; k < Constants.OBJECT_ID_LENGTH; k++) {
+			final int ak = id[k] & 0xff;
+			final int bk = b[k + (int)pos] & 0xff;
+			if (ak < bk)
+				return -1;
+			else if (ak > bk)
+				return 1;
+		}
+		return 0;
+	}
+
+	private static int compare(final byte[] a, final byte[] b) {
+		for (int k = 0 ; k < Constants.OBJECT_ID_LENGTH; k++) {
 			final int ak = a[k] & 0xff;
 			final int bk = b[k] & 0xff;
 			if (ak < bk)
@@ -218,4 +228,5 @@ public class ObjectId implements Comparable {
 		}
 		return new String(s,0);
 	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
new file mode 100644
index 0000000..c397a0d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
@@ -0,0 +1,145 @@
+/*
+ *  Copyright (C) 2006  Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.jgit.lib;
+
+import java.lang.reflect.InvocationTargetException;
+import java.lang.reflect.Method;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.HashSet;
+import java.util.Iterator;
+import java.util.List;
+import java.util.Map;
+import java.util.Set;
+import java.util.TreeMap;
+
+/** Very much like a map, but specialized
+ *  to partition the data on the first byte
+ *  of the key. This is MUCH faster. See test
+ *  class for how these numbers were derived.
+ *  
+ *	TreeMap=            2968
+ *	HashMap=            1689
+ *	Partitioned TreeMap=1499
+ *	Partitioned HashMap=1782
+ *
+ *  Inspiration from Git pack file format which uses this technique.
+ *  
+ */
+public class ObjectIdMap implements Map {
+
+	Map[] level0 = new Map[256];
+	
+	public ObjectIdMap() {
+		this(new TreeMap());
+	}
+
+	public ObjectIdMap(Map sample) {
+		try {
+			Method m=sample.getClass().getMethod("clone", null);
+			for (int i=0; i<256; ++i) {
+				level0[i] = (Map)m.invoke(sample, null);
+			}
+		} catch (IllegalAccessException e) {
+			throw new IllegalArgumentException(e);
+		} catch (IllegalArgumentException e) {
+			throw new IllegalArgumentException(e);
+		} catch (InvocationTargetException e) {
+			throw new IllegalArgumentException(e);
+		} catch (SecurityException e) {
+			throw new IllegalArgumentException(e);
+		} catch (NoSuchMethodException e) {
+			throw new IllegalArgumentException(e);
+		}
+	}
+	
+	public void clear() {
+		for (int i=0; i<256; ++i)
+			level0[i].clear();
+	}
+
+	public boolean containsKey(Object key) {
+		return submap(key).containsKey(key);
+	}
+
+	private final Map submap(Object key) {
+		return level0[((ObjectId)key).getFirstByte()];
+	}
+
+	public boolean containsValue(Object value) {
+		for (int i=0; i<256; ++i)
+			if (level0[i].containsValue(value))
+				return true;
+		return false;
+	}
+
+	public Set entrySet() {
+		Set ret = new HashSet();
+		for (int i=0; i<256; ++i)
+			ret.addAll(level0[i].entrySet());
+		return ret;
+	}
+
+	public Object get(Object key) {
+		return submap(key).get(key);
+	}
+
+	public boolean isEmpty() {
+		for (int i=0; i<256; ++i)
+			if (!level0[i].isEmpty())
+				return false;
+		return true;
+	}
+
+	public Set keySet() {
+		Set ret = new HashSet();
+		for (int i=0; i<256; ++i)
+			ret.addAll(level0[i].keySet());
+		return ret;
+	}
+
+	public Object put(Object key, Object value) {
+		return submap(key).put(key, value);
+	}
+
+	public void putAll(Map arg0) {
+		for (Iterator i=arg0.keySet().iterator(); i.hasNext(); ) {
+			Object k=i.next();
+			Object v=arg0.get(k);
+			put(k,v);
+		}
+	}
+
+	public Object remove(Object key) {
+		return submap(key).remove(key);
+	}
+
+	public int size() {
+		int ret=0;
+		for (int i=0; i<256; ++i)
+			ret += level0[i].size();
+		return ret;
+	}
+
+	public Collection values() {
+		List ret=new ArrayList(size());
+		for (int i=0; i<256; ++i)
+			ret.addAll(level0[i].values());
+		return ret;
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index d33aa97..fa206fd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -32,8 +32,7 @@ public class PackFile {
 	private final WindowedFile pack;
 
 	private final WindowedFile idx;
-
-	private final long[] idxHeader;
+	private byte[][] idxdata;
 
 	private long objectCnt;
 
@@ -52,10 +51,9 @@ public class PackFile {
 					.substring(0, dot)
 					+ ".idx");
 			// FIXME window size and mmap type should be configurable
-			idx = new WindowedFile(repo.getWindowCache(), idxFile,
-					64 * 1024 * 1024, true);
+			idx = new WindowedFile(new WindowCache(8*1024*1024,1), idxFile, 8*1024*1024, true);
 			try {
-				idxHeader = readIndexHeader();
+				readIndexHeader();
 			} catch (IOException ioe) {
 				try {
 					idx.close();
@@ -75,7 +73,7 @@ public class PackFile {
 	}
 
 	ObjectLoader resolveBase(final long ofs) throws IOException {
-		return reader(ofs, new byte[Constants.OBJECT_ID_LENGTH]);
+		return reader(ofs);
 	}
 
 	/**
@@ -87,19 +85,10 @@ public class PackFile {
 	 * 
 	 * @param id
 	 *            the object to look for. Must not be null.
-	 * @param tmp
-	 *            a temporary buffer loaned to this pack for use during the
-	 *            search. This buffer must be at least
-	 *            {@link Constants#OBJECT_ID_LENGTH} bytes in size. The buffer
-	 *            will be overwritten during the search, but is unused upon
-	 *            return.
 	 * @return true if the object is in this pack; false otherwise.
-	 * @throws IOException
-	 *             there was an error reading data from the pack's index file.
 	 */
-	public boolean hasObject(final ObjectId id, final byte[] tmp)
-			throws IOException {
-		return findOffset(id, tmp) != -1;
+	public boolean hasObject(final ObjectId id) {
+		return findOffset(id) != -1;
 	}
 
 	/**
@@ -116,25 +105,17 @@ public class PackFile {
 	 * 
 	 * @param id
 	 *            the object to obtain from the pack. Must not be null.
-	 * @param tmp
-	 *            a temporary buffer loaned to this pack for use during the
-	 *            search, and given to the returned loader if the object is
-	 *            found. This buffer must be at least
-	 *            {@link Constants#OBJECT_ID_LENGTH} bytes in size. The buffer
-	 *            will be overwritten during the search. The buffer will be
-	 *            given to the loader if a loader is returned. If null is
-	 *            returned the caller may reuse the buffer.
 	 * @return the object loader for the requested object if it is contained in
 	 *         this pack; null if the object was not found.
 	 * @throws IOException
 	 *             the pack file or the index could not be read.
 	 */
-	public PackedObjectLoader get(final ObjectId id, final byte[] tmp)
+	public PackedObjectLoader get(final ObjectId id)
 			throws IOException {
-		final long offset = findOffset(id, tmp);
+		final long offset = findOffset(id);
 		if (offset == -1)
 			return null;
-		final PackedObjectLoader objReader = reader(offset, tmp);
+		final PackedObjectLoader objReader = reader(offset);
 		objReader.setId(id);
 		return objReader;
 	}
@@ -173,22 +154,35 @@ public class PackFile {
 		objectCnt = pack.readUInt32(position, intbuf);
 	}
 
-	private long[] readIndexHeader() throws CorruptObjectException, IOException {
+	private void readIndexHeader() throws CorruptObjectException, IOException {
 		if (idx.length() != (IDX_HDR_LEN + (24 * objectCnt) + (2 * Constants.OBJECT_ID_LENGTH)))
 			throw new CorruptObjectException("Invalid pack index");
 
-		final long[] idxHeader = new long[256];
+		final long[] idxHeader = new long[256]; // really unsigned 32-bit...
 		final byte[] intbuf = new byte[4];
 		for (int k = 0; k < idxHeader.length; k++)
 			idxHeader[k] = idx.readUInt32(k * 4, intbuf);
-		return idxHeader;
+		idxdata = new byte[idxHeader.length][];
+		for (int k = 0; k < idxHeader.length; k++) {
+			int n;
+			if (k == 0) {
+				n = (int)(idxHeader[k]);
+			} else {
+				n = (int)(idxHeader[k]-idxHeader[k-1]);
+			}
+			if (n > 0) {
+				idxdata[k] = new byte[n * (Constants.OBJECT_ID_LENGTH + 4)];
+				int off = (int) ((k == 0) ? 0 : idxHeader[k-1] * (Constants.OBJECT_ID_LENGTH + 4));
+				idx.read(off + IDX_HDR_LEN, idxdata[k]);
+			}
+		}
 	}
 
-	private PackedObjectLoader reader(final long objOffset, final byte[] ib)
+	private PackedObjectLoader reader(final long objOffset)
 			throws IOException {
 		long pos = objOffset;
 		int p = 0;
-
+		final byte[] ib = new byte[Constants.OBJECT_ID_LENGTH];
 		pack.readFully(pos, ib);
 		int c = ib[p++] & 0xff;
 		final int typeCode = (c >> 4) & 7;
@@ -239,23 +233,26 @@ public class PackFile {
 		return new WholePackedObjectLoader(this, pos, type, (int) size);
 	}
 
-	private long findOffset(final ObjectId objId, final byte[] tmpid)
-			throws IOException {
+	private long findOffset(final ObjectId objId) {
 		final int levelOne = objId.getFirstByte();
-		long high = idxHeader[levelOne];
-		long low = levelOne == 0 ? 0 : idxHeader[levelOne - 1];
-
+		byte[] data = idxdata[levelOne];
+		if (data == null)
+			return -1;
+		long high = data.length / (4 + Constants.OBJECT_ID_LENGTH);
+		long low = 0;
 		do {
 			final long mid = (low + high) / 2;
-			final long pos = IDX_HDR_LEN
-					+ ((4 + Constants.OBJECT_ID_LENGTH) * mid) + 4;
-			idx.readFully(pos, tmpid);
-			final int cmp = objId.compareTo(tmpid);
+			final long pos = ((4 + Constants.OBJECT_ID_LENGTH) * mid) + 4;
+			final int cmp = objId.compareTo(data, pos);
 			if (cmp < 0)
 				high = mid;
-			else if (cmp == 0)
-				return idx.readUInt32(pos - 4, tmpid);
-			else
+			else if (cmp == 0) {
+				int b0 = data[(int)pos-4] & 0xff;
+				int b1 = data[(int)pos-3] & 0xff;
+				int b2 = data[(int)pos-2] & 0xff;
+				int b3 = data[(int)pos-1] & 0xff;
+				return (((long)b0) << 24) | ( b1 << 16 ) | ( b2 << 8 ) | (b3); 
+			} else
 				low = mid + 1;
 		} while (low < high);
 		return -1;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 0f2a900..482f41d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -152,17 +152,9 @@ public class Repository {
 	public boolean hasObject(final ObjectId objectId) {
 		int k = packs.length;
 		if (k > 0) {
-			final byte[] tmp = new byte[Constants.OBJECT_ID_LENGTH];
 			do {
-				try {
-					if (packs[--k].hasObject(objectId, tmp))
-						return true;
-				} catch (IOException ioe) {
-					// This shouldn't happen unless the pack was corrupted
-					// after we opened it. We'll ignore the error as though
-					// the object does not exist in this pack.
-					//
-				}
+				if (packs[--k].hasObject(objectId))
+					return true;
 			} while (k > 0);
 		}
 		return toFile(objectId).isFile();
@@ -171,10 +163,9 @@ public class Repository {
 	public ObjectLoader openObject(final ObjectId id) throws IOException {
 		int k = packs.length;
 		if (k > 0) {
-			final byte[] tmp = new byte[Constants.OBJECT_ID_LENGTH];
 			do {
 				try {
-					final ObjectLoader ol = packs[--k].get(id, tmp);
+					final ObjectLoader ol = packs[--k].get(id);
 					if (ol != null)
 						return ol;
 				} catch (IOException ioe) {
@@ -185,7 +176,7 @@ public class Repository {
 					// time to collect and try once more.
 					try {
 						System.gc();
-						final ObjectLoader ol = packs[k].get(id, tmp);
+						final ObjectLoader ol = packs[k].get(id);
 						if (ol != null)
 							return ol;
 					} catch (IOException ioe2) {
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/ObjectIdMapTest.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/ObjectIdMapTest.java
new file mode 100644
index 0000000..f98c6f7
--- /dev/null
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/ObjectIdMapTest.java
@@ -0,0 +1,170 @@
+/*
+ *  Copyright (C) 2006  Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.jgit.lib;
+
+import java.util.Comparator;
+import java.util.HashMap;
+import java.util.Map;
+import java.util.TreeMap;
+
+import junit.framework.TestCase;
+import junit.textui.TestRunner;
+
+public class ObjectIdMapTest extends TestCase {
+
+	ObjectId[] ids = new ObjectId[1000000];
+	
+	protected void setUp() throws Exception {
+		int b=0;
+		for (int i=0; i<ids.length; ++i) {
+			byte[] data = new byte[Constants.OBJECT_ID_LENGTH];
+			for (int j=0; j<Constants.OBJECT_ID_LENGTH; ++j)
+				data[j] = (byte) (b++^0xEE);
+			ids[i] = new ObjectId(data);
+		}
+	}
+
+	protected void tearDown() throws Exception {
+		ids = null; // avoid out of memory
+	}
+
+	public void testBoth() {
+		long d1=0;
+		long d2=0;
+		long d3=0;
+		long d4=0;
+		long d5=0;
+		long d6=0;
+
+		for (int j=0; j<64; ++j) {
+			int x = 
+				((j & 1)!=0  ? 1 : 0) |
+				((j & 2)!=0  ? 2 : 0) |
+				((j & 4)!=0  ? 16 : 0) |
+				((j & 8)!=0  ? 32 : 0) |
+				((j & 16)!=0 ? 4 : 0) |
+				((j & 32)!=0 ? 8 : 0);
+
+			if ((x&1) == 0) {
+				long t0 = System.currentTimeMillis();
+				
+				Map treeMap = new TreeMap();
+				for (int i=0; i<ids.length; ++i)
+					treeMap.put(ids[i],ids[i]);
+		
+				long t1 = System.currentTimeMillis();
+				d1 += t1-t0;
+			}
+			if ((x&2) == 0) {
+				long t0 = System.currentTimeMillis();
+				Map hashMap = new HashMap();
+				for (int i=0; i<ids.length; ++i)
+					hashMap.put(ids[i],ids[i]);
+				long t1 = System.currentTimeMillis();
+				d2 += t1-t0;
+			}
+			
+			if ((x&4) == 0) {
+				long t0= System.currentTimeMillis();
+	
+				Map levelMapWithTree = new ObjectIdMap(new TreeMap());
+				for (int i=0; i<ids.length; ++i)
+					levelMapWithTree.put(ids[i],ids[i]);
+	
+				long t1 = System.currentTimeMillis();
+				d3 += t1-t0;
+			}
+			
+			if ((x&8) == 0) {
+				long t0 = System.currentTimeMillis();
+				Map levelMapWithHash = new ObjectIdMap(new HashMap());
+				for (int i=0; i<ids.length; ++i)
+					levelMapWithHash.put(ids[i],ids[i]);
+		
+				long t1 = System.currentTimeMillis();
+	
+				d4 += t1-t0;
+			}
+
+			if ((x&16) == 0) {
+				long t0= System.currentTimeMillis();
+	
+				Map levelMapWithTreeAndSpecialCompare = new ObjectIdMap(new TreeMap(new Comparator() {
+				
+					public int compare(Object arg0, Object arg1) {
+						byte[] b0=((ObjectId)arg0).getBytes();
+						byte[] b1=((ObjectId)arg1).getBytes();
+						for (int i=1; i<Constants.OBJECT_ID_LENGTH; ++i) {
+							int a=b0[i]&0xff;
+							int b=b1[i]&0xff;
+							int c=a-b;
+							if (c!=0)
+								return c;
+						}
+						return 0;
+					}
+				
+				}));
+				for (int i=0; i<ids.length; ++i)
+					levelMapWithTreeAndSpecialCompare.put(ids[i],ids[i]);
+	
+				long t1 = System.currentTimeMillis();
+				d5 += t1-t0;
+			}
+			
+			if ((j&32) == 0) {
+				long t0= System.currentTimeMillis();
+	
+				Map levelMapWithTreeAndSpecialCompare = new ObjectIdMap(new TreeMap(new Comparator() {
+				
+					public int compare(Object arg0, Object arg1) {
+						return ((Comparable)arg0).compareTo(arg1);
+					}
+				
+				}));
+				for (int i=0; i<ids.length; ++i)
+					levelMapWithTreeAndSpecialCompare.put(ids[i],ids[i]);
+	
+				long t1 = System.currentTimeMillis();
+				d6 += t1-t0;
+			}
+		}
+		
+		System.out.println("TreeMap                              ="+d1);
+		System.out.println("HashMap                              ="+d2);
+		System.out.println("Partitioned TreeMap ObjectId.compare ="+d3);
+		System.out.println("Partitioned HashMap                  ="+d4);
+		System.out.println("Partitioned TreeMap enhanced compare ="+d5);
+		System.out.println("Partitioned TreeMap dummy    compare ="+d6);
+		assertEquals(d5*10/10000, d2*8/10000); // d5 is ~20% better
+	}
+
+	public void testFunc() {
+		Map treeMap = new TreeMap();
+		for (int i=0; i<ids.length/100; ++i)
+			treeMap.put(ids[i],ids[i]);
+		Map levelMapWithTree = new ObjectIdMap(new TreeMap());
+		for (int i=0; i<ids.length/100; ++i)
+			levelMapWithTree.put(ids[i],ids[i]);
+		
+		assertEquals(treeMap, levelMapWithTree);
+	}
+
+	public static void main(String[] args) {
+		TestRunner.run(ObjectIdMapTest.class);
+	}
+}
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0004_PackReader.java
index 24f6b03..118415d 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0004_PackReader.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0004_PackReader.java
@@ -30,7 +30,7 @@ public class T0004_PackReader extends RepositoryTestCase {
 
 		id = new ObjectId("902d5476fa249b7abc9d84c611577a81381f0327");
 		pr = new PackFile(db, TEST_PACK);
-		or = pr.get(id, new byte[Constants.OBJECT_ID_LENGTH]);
+		or = pr.get(id);
 		assertNotNull(or);
 		assertEquals(id, or.getId());
 		assertEquals(Constants.TYPE_TREE, or.getType());
