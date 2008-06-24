From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 05/10] Refactor pack index writing to a common API
Date: Mon, 23 Jun 2008 22:10:03 -0400
Message-ID: <1214273408-70793-6-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
 <1214273408-70793-3-git-send-email-spearce@spearce.org>
 <1214273408-70793-4-git-send-email-spearce@spearce.org>
 <1214273408-70793-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0W-0005iO-8i
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbYFXCKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752930AbYFXCKj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49768 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbYFXCKh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxzB-0001OB-12; Mon, 23 Jun 2008 22:10:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id D820820FBCA; Mon, 23 Jun 2008 22:10:30 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 197BD20FBD0;
	Mon, 23 Jun 2008 22:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-5-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85973>

To repack a repository or to push a pack file over a dumb transport
we need to create a .idx file to match the .pack.  This means
the index writing features of transport.IndexPack are needed by
PackWriter, and/or dumb protocol transports.

This refactoring creates a PackIndexWriter class structure that
mirrors the PackIndex (reader) structure we already have in place
for PackIndexV1 and PackIndexV2.

At present only PackIndexV1 is supported as we do not have access
to the CRC data necessary to write PackIndexV2 style files.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackIndexWriter.java  |  243 ++++++++++++++++++++
 .../org/spearce/jgit/lib/PackIndexWriterV1.java    |   78 +++++++
 .../src/org/spearce/jgit/transport/IndexPack.java  |   37 +---
 3 files changed, 330 insertions(+), 28 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV1.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
new file mode 100644
index 0000000..473e6cf
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
@@ -0,0 +1,243 @@
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
+package org.spearce.jgit.lib;
+
+import java.io.BufferedOutputStream;
+import java.io.IOException;
+import java.io.OutputStream;
+import java.security.DigestOutputStream;
+import java.util.List;
+
+import org.spearce.jgit.transport.PackedObjectInfo;
+import org.spearce.jgit.util.NB;
+
+/**
+ * Creates a table of contents to support random access by {@link PackFile}.
+ * <p>
+ * Pack index files (the <code>.idx</code> suffix in a pack file pair)
+ * provides random access to any object in the pack by associating an ObjectId
+ * to the byte offset within the pack where the object's data can be read.
+ */
+public abstract class PackIndexWriter {
+	/**
+	 * Create a new writer for the oldest (most widely understood) format.
+	 * <p>
+	 * This method selects an index format that can accurate describe the
+	 * supplied objects and that will be the most compatible format with older
+	 * Git implementations.
+	 * <p>
+	 * Index version 1 is widely recognized by all Git implementations, but
+	 * index version 2 (and later) is not as well recognized as it was
+	 * introduced more than a year later. Index version 1 can only be used if
+	 * the resulting pack file is under 4 gigabytes in size; packs larger than
+	 * that limit must use index version 2.
+	 * 
+	 * @param dst
+	 *            the stream the index data will be written to. If not already
+	 *            buffered it will be automatically wrapped in a buffered
+	 *            stream. Callers are always responsible for closing the stream.
+	 * @param objs
+	 *            the objects the caller needs to store in the index. Entries
+	 *            will be examined until a format can be conclusively selected.
+	 * @return a new writer to output an index file of the requested format to
+	 *         the supplied stream.
+	 * @throws IllegalArgumentException
+	 *             no recognized pack index version can support the supplied
+	 *             objects. This is likely a bug in the implementation.
+	 */
+	@SuppressWarnings("fallthrough")
+	public static PackIndexWriter createOldestPossible(final OutputStream dst,
+			final List<PackedObjectInfo> objs) {
+		int version = 1;
+		LOOP: for (final PackedObjectInfo oe : objs) {
+			switch (version) {
+			case 1:
+				if (PackIndexWriterV1.canStore(oe))
+					continue;
+				version = 2;
+			case 2:
+				break LOOP;
+			}
+		}
+		return createVersion(dst, version);
+	}
+
+	/**
+	 * Create a new writer instance for a specific index format version.
+	 * 
+	 * @param dst
+	 *            the stream the index data will be written to. If not already
+	 *            buffered it will be automatically wrapped in a buffered
+	 *            stream. Callers are always responsible for closing the stream.
+	 * @param version
+	 *            index format version number required by the caller. Exactly
+	 *            this formatted version will be written.
+	 * @return a new writer to output an index file of the requested format to
+	 *         the supplied stream.
+	 * @throws IllegalArgumentException
+	 *             the version requested is not supported by this
+	 *             implementation.
+	 */
+	public static PackIndexWriter createVersion(final OutputStream dst,
+			final int version) {
+		switch (version) {
+		case 1:
+			return new PackIndexWriterV1(dst);
+		default:
+			throw new IllegalArgumentException(
+					"Unsupported pack index version " + version);
+		}
+	}
+
+	/** The index data stream we are responsible for creating. */
+	protected final DigestOutputStream out;
+
+	/** A temporary buffer for use during IO to {link #out}. */
+	protected final byte[] tmp;
+
+	/** The entries this writer must pack. */
+	protected List<PackedObjectInfo> entries;
+
+	/** SHA-1 checksum for the entire pack data. */
+	protected byte[] packChecksum;
+
+	/**
+	 * Create a new writer instance.
+	 * 
+	 * @param dst
+	 *            the stream this instance outputs to. If not already buffered
+	 *            it will be automatically wrapped in a buffered stream.
+	 */
+	protected PackIndexWriter(final OutputStream dst) {
+		out = new DigestOutputStream(dst instanceof BufferedOutputStream ? dst
+				: new BufferedOutputStream(dst), Constants.newMessageDigest());
+		tmp = new byte[4 + Constants.OBJECT_ID_LENGTH];
+	}
+
+	/**
+	 * Write all object entries to the index stream.
+	 * <p>
+	 * After writing the stream passed to the factory is flushed but remains
+	 * open. Callers are always responsible for closing the output stream.
+	 * 
+	 * @param toStore
+	 *            sorted list of objects to store in the index. The caller must
+	 *            have previously sorted the list using {@link PackedObjectInfo}'s
+	 *            native {@link Comparable} implementation.
+	 * @param packDataChecksum
+	 *            checksum signature of the entire pack data content. This is
+	 *            traditionally the last 20 bytes of the pack file's own stream.
+	 * @throws IOException
+	 *             an error occurred while writing to the output stream, or this
+	 *             index format cannot store the object data supplied.
+	 */
+	public void write(final List<PackedObjectInfo> toStore,
+			final byte[] packDataChecksum) throws IOException {
+		entries = toStore;
+		packChecksum = packDataChecksum;
+		writeImpl();
+		out.flush();
+	}
+
+	/**
+	 * Writes the index file to {@link #out}.
+	 * <p>
+	 * Implementations should go something like:
+	 * 
+	 * <pre>
+	 * writeFanOutTable();
+	 * for (final PackedObjectInfo po : entries)
+	 * 	writeOneEntry(po);
+	 * writeChecksumFooter();
+	 * </pre>
+	 * 
+	 * <p>
+	 * Where the logic for <code>writeOneEntry</code> is specific to the index
+	 * format in use. Additional headers/footers may be used if necessary and
+	 * the {@link #entries} collection may be iterated over more than once if
+	 * necessary. Implementors therefore have complete control over the data.
+	 * 
+	 * @throws IOException
+	 *             an error occurred while writing to the output stream, or this
+	 *             index format cannot store the object data supplied.
+	 */
+	protected abstract void writeImpl() throws IOException;
+
+	/**
+	 * Output the standard 256 entry first-level fan-out table.
+	 * <p>
+	 * The fan-out table is 4 KB in size, holding 256 32-bit unsigned integer
+	 * counts. Each count represents the number of objects within this index
+	 * whose {@link ObjectId#getFirstByte()} matches the count's position in the
+	 * fan-out table.
+	 * 
+	 * @throws IOException
+	 *             an error occurred while writing to the output stream.
+	 */
+	protected void writeFanOutTable() throws IOException {
+		final int[] fanout = new int[256];
+		for (final PackedObjectInfo po : entries)
+			fanout[po.getFirstByte() & 0xff]++;
+		for (int i = 1; i < 256; i++)
+			fanout[i] += fanout[i - 1];
+		for (final int n : fanout) {
+			NB.encodeInt32(tmp, 0, n);
+			out.write(tmp, 0, 4);
+		}
+	}
+
+	/**
+	 * Output the standard two-checksum index footer.
+	 * <p>
+	 * The standard footer contains two checksums (20 byte SHA-1 values):
+	 * <ol>
+	 * <li>Pack data checksum - taken from the last 20 bytes of the pack file.</li>
+	 * <li>Index data checksum - checksum of all index bytes written, including
+	 * the pack data checksum above.</li>
+	 * </ol>
+	 * 
+	 * @throws IOException
+	 *             an error occurred while writing to the output stream.
+	 */
+	protected void writeChecksumFooter() throws IOException {
+		out.write(packChecksum);
+		out.on(false);
+		out.write(out.getMessageDigest().digest());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV1.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV1.java
new file mode 100644
index 0000000..b790a28
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV1.java
@@ -0,0 +1,78 @@
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
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+import java.io.OutputStream;
+
+import org.spearce.jgit.transport.PackedObjectInfo;
+import org.spearce.jgit.util.NB;
+
+/**
+ * Creates the version 1 (old style) pack table of contents files.
+ * 
+ * @see PackIndexWriter
+ * @see PackIndexV1
+ */
+class PackIndexWriterV1 extends PackIndexWriter {
+	static boolean canStore(final PackedObjectInfo oe) {
+		// We are limited to 4 GB per pack as offset is 32 bit unsigned int.
+		//
+		return oe.getOffset() >>> 1 < Integer.MAX_VALUE;
+	}
+
+	PackIndexWriterV1(final OutputStream dst) {
+		super(dst);
+	}
+
+	@Override
+	protected void writeImpl() throws IOException {
+		writeFanOutTable();
+
+		for (final PackedObjectInfo oe : entries) {
+			if (!canStore(oe))
+				throw new IOException("Pack too large for index version 1");
+			NB.encodeInt32(tmp, 0, (int) oe.getOffset());
+			oe.copyRawTo(tmp, 4);
+			out.write(tmp);
+		}
+
+		writeChecksumFooter();
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index ad4bcae..60e0bce 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -38,7 +38,6 @@
 
 package org.spearce.jgit.transport;
 
-import java.io.BufferedOutputStream;
 import java.io.EOFException;
 import java.io.File;
 import java.io.FileOutputStream;
@@ -49,6 +48,7 @@ import java.security.MessageDigest;
 import java.util.ArrayList;
 import java.util.Arrays;
 import java.util.HashMap;
+import java.util.List;
 import java.util.zip.DataFormatException;
 import java.util.zip.Deflater;
 import java.util.zip.Inflater;
@@ -61,6 +61,7 @@ import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectIdMap;
 import org.spearce.jgit.lib.ObjectLoader;
+import org.spearce.jgit.lib.PackIndexWriter;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.util.NB;
@@ -441,34 +442,14 @@ public class IndexPack {
 
 	private void writeIdx() throws IOException {
 		Arrays.sort(entries, 0, entryCount);
-		final int[] fanout = new int[256];
-		for (int i = 0; i < entryCount; i++)
-			fanout[entries[i].getFirstByte() & 0xff]++;
-		for (int i = 1; i < 256; i++)
-			fanout[i] += fanout[i - 1];
-
-		final BufferedOutputStream os = new BufferedOutputStream(
-				new FileOutputStream(dstIdx), BUFFER_SIZE);
+		List<PackedObjectInfo> list = Arrays.asList(entries);
+		if (entryCount < entries.length)
+			list = list.subList(0, entryCount);
+
+		final FileOutputStream os = new FileOutputStream(dstIdx);
 		try {
-			final byte[] rawoe = new byte[4 + Constants.OBJECT_ID_LENGTH];
-			final MessageDigest d = Constants.newMessageDigest();
-			for (int i = 0; i < 256; i++) {
-				NB.encodeInt32(rawoe, 0, fanout[i]);
-				os.write(rawoe, 0, 4);
-				d.update(rawoe, 0, 4);
-			}
-			for (int i = 0; i < entryCount; i++) {
-				final PackedObjectInfo oe = entries[i];
-				if (oe.getOffset() >>> 1 > Integer.MAX_VALUE)
-					throw new IOException("Pack too large for index version 1");
-				NB.encodeInt32(rawoe, 0, (int) oe.getOffset());
-				oe.copyRawTo(rawoe, 4);
-				os.write(rawoe);
-				d.update(rawoe);
-			}
-			os.write(packcsum);
-			d.update(packcsum);
-			os.write(d.digest());
+			PackIndexWriter.createOldestPossible(os, list)
+					.write(list, packcsum);
 		} finally {
 			os.close();
 		}
-- 
1.5.6.74.g8a5e
