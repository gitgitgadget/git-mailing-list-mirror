From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/10] Add support for writing pack index v2 files
Date: Mon, 23 Jun 2008 22:10:07 -0400
Message-ID: <1214273408-70793-10-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
 <1214273408-70793-3-git-send-email-spearce@spearce.org>
 <1214273408-70793-4-git-send-email-spearce@spearce.org>
 <1214273408-70793-5-git-send-email-spearce@spearce.org>
 <1214273408-70793-6-git-send-email-spearce@spearce.org>
 <1214273408-70793-7-git-send-email-spearce@spearce.org>
 <1214273408-70793-8-git-send-email-spearce@spearce.org>
 <1214273408-70793-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0Z-0005iO-I2
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbYFXCKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbYFXCKu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49787 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYFXCKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxzM-0001PJ-PC; Mon, 23 Jun 2008 22:10:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 7199720FBAE; Mon, 23 Jun 2008 22:10:43 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 2D98820FBD2;
	Mon, 23 Jun 2008 22:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-9-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85978>

The v2 format is more robust for delta reuse as it has a CRC
element that covers the entire packed representation, permitting
more efficient delta-reuse during packing.  It also can address
objects in pack files larger than 4 GB, making it a better format
for the future.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackIndexWriter.java  |   21 ++++
 .../org/spearce/jgit/lib/PackIndexWriterV2.java    |  101 ++++++++++++++++++++
 .../src/org/spearce/jgit/pgm/IndexPack.java        |    4 +
 .../src/org/spearce/jgit/transport/IndexPack.java  |   22 ++++-
 4 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV2.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
index c9b27d2..2d9d822 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
@@ -122,6 +122,8 @@ public abstract class PackIndexWriter {
 		switch (version) {
 		case 1:
 			return new PackIndexWriterV1(dst);
+		case 2:
+			return new PackIndexWriterV2(dst);
 		default:
 			throw new IllegalArgumentException(
 					"Unsupported pack index version " + version);
@@ -203,6 +205,25 @@ public abstract class PackIndexWriter {
 	protected abstract void writeImpl() throws IOException;
 
 	/**
+	 * Output the version 2 (and later) TOC header, with version number.
+	 * <p>
+	 * Post version 1 all index files start with a TOC header that makes the
+	 * file an invalid version 1 file, and then includes the version number.
+	 * This header is necessary to recognize a version 1 from a version 2
+	 * formatted index.
+	 * 
+	 * @param version
+	 *            version number of this index format being written.
+	 * @throws IOException
+	 *             an error occurred while writing to the output stream.
+	 */
+	protected void writeTOC(final int version) throws IOException {
+		out.write(TOC);
+		NB.encodeInt32(tmp, 0, version);
+		out.write(tmp, 0, 4);
+	}
+
+	/**
 	 * Output the standard 256 entry first-level fan-out table.
 	 * <p>
 	 * The fan-out table is 4 KB in size, holding 256 32-bit unsigned integer
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV2.java
new file mode 100644
index 0000000..8fa4d1a
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriterV2.java
@@ -0,0 +1,101 @@
+/*
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
+ * Creates the version 2 pack table of contents files.
+ * 
+ * @see PackIndexWriter
+ * @see PackIndexV2
+ */
+class PackIndexWriterV2 extends PackIndexWriter {
+	PackIndexWriterV2(final OutputStream dst) {
+		super(dst);
+	}
+
+	@Override
+	protected void writeImpl() throws IOException {
+		writeTOC(2);
+		writeFanOutTable();
+		writeObjectNames();
+		writeCRCs();
+		writeOffset32();
+		writeOffset64();
+		writeChecksumFooter();
+	}
+
+	private void writeObjectNames() throws IOException {
+		for (final PackedObjectInfo oe : entries)
+			oe.copyRawTo(out);
+	}
+
+	private void writeCRCs() throws IOException {
+		for (final PackedObjectInfo oe : entries) {
+			NB.encodeInt32(tmp, 0, oe.getCRC());
+			out.write(tmp, 0, 4);
+		}
+	}
+
+	private void writeOffset32() throws IOException {
+		int o64 = 0;
+		for (final PackedObjectInfo oe : entries) {
+			final long o = oe.getOffset();
+			if (o < Integer.MAX_VALUE)
+				NB.encodeInt32(tmp, 0, (int) o);
+			else
+				NB.encodeInt32(tmp, 0, (1 << 31) | o64++);
+			out.write(tmp, 0, 4);
+		}
+	}
+
+	private void writeOffset64() throws IOException {
+		for (final PackedObjectInfo oe : entries) {
+			final long o = oe.getOffset();
+			if (o > Integer.MAX_VALUE) {
+				NB.encodeInt64(tmp, 0, o);
+				out.write(tmp, 0, 8);
+			}
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/IndexPack.java
index 5a82a35..60926c1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/IndexPack.java
@@ -47,10 +47,13 @@ class IndexPack extends TextBuiltin {
 	void execute(final String[] args) throws Exception {
 		boolean fixThin = false;
 		int argi = 0;
+		int version = 0;
 		for (; argi < args.length; argi++) {
 			final String a = args[argi];
 			if ("--fix-thin".equals(a))
 				fixThin = true;
+			else if (a.startsWith("--index-version="))
+				version = Integer.parseInt(a.substring(a.indexOf('=') + 1));
 			else if ("--".equals(a)) {
 				argi++;
 				break;
@@ -69,6 +72,7 @@ class IndexPack extends TextBuiltin {
 		in = new BufferedInputStream(System.in);
 		ip = new org.spearce.jgit.transport.IndexPack(db, in, base);
 		ip.setFixThin(fixThin);
+		ip.setIndexVersion(version);
 		ip.index(new TextProgressMonitor());
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 047f0dc..06ef7cc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -125,6 +125,8 @@ public class IndexPack {
 
 	private boolean fixThin;
 
+	private int outputVersion;
+
 	private final File dstPack;
 
 	private final File dstIdx;
@@ -185,6 +187,18 @@ public class IndexPack {
 	}
 
 	/**
+	 * Set the pack index file format version this instance will create.
+	 * 
+	 * @param version
+	 *            the version to write. The special version 0 designates the
+	 *            oldest (most compatible) format available for the objects.
+	 * @see PackIndexWriter
+	 */
+	public void setIndexVersion(final int version) {
+		outputVersion = version;
+	}
+
+	/**
 	 * Configure this index pack instance to make a thin pack complete.
 	 * <p>
 	 * Thin packs are sometimes used during network transfers to allow a delta
@@ -466,8 +480,12 @@ public class IndexPack {
 
 		final FileOutputStream os = new FileOutputStream(dstIdx);
 		try {
-			PackIndexWriter.createOldestPossible(os, list)
-					.write(list, packcsum);
+			final PackIndexWriter iw;
+			if (outputVersion <= 0)
+				iw = PackIndexWriter.createOldestPossible(os, list);
+			else
+				iw = PackIndexWriter.createVersion(os, outputVersion);
+			iw.write(list, packcsum);
 		} finally {
 			os.close();
 		}
-- 
1.5.6.74.g8a5e
