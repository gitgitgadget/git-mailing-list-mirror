From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 15/21] Specialized byte array output stream for large files
Date: Sun, 29 Jun 2008 03:59:25 -0400
Message-ID: <1214726371-93520-16-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
 <1214726371-93520-8-git-send-email-spearce@spearce.org>
 <1214726371-93520-9-git-send-email-spearce@spearce.org>
 <1214726371-93520-10-git-send-email-spearce@spearce.org>
 <1214726371-93520-11-git-send-email-spearce@spearce.org>
 <1214726371-93520-12-git-send-email-spearce@spearce.org>
 <1214726371-93520-13-git-send-email-spearce@spearce.org>
 <1214726371-93520-14-git-send-email-spearce@spearce.org>
 <1214726371-93520-15-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrq-0000I1-Pr
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbYF2IBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYF2IBG
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:01:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36839 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbYF2IA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpd-0004Ok-KL; Sun, 29 Jun 2008 04:00:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 16AD320FBAE; Sun, 29 Jun 2008 04:00:22 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 9231220FBD8;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-15-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86777>

Some transports may require that we know the total byte count (and
perhaps MD5 checksum) of a pack file before we can send it to the
transport during a push operation.  Materializing the pack locally
prior to transfer can be somewhat costly, but may be able to be in
core for very small packs.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |  260 ++++++++++++++++++++
 1 files changed, 260 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
new file mode 100644
index 0000000..72bdbb1
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
@@ -0,0 +1,260 @@
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
+package org.spearce.jgit.util;
+
+import java.io.BufferedOutputStream;
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.io.OutputStream;
+import java.util.ArrayList;
+
+import org.spearce.jgit.lib.NullProgressMonitor;
+import org.spearce.jgit.lib.ProgressMonitor;
+
+/**
+ * A fully buffered output stream using local disk storage for large data.
+ * <p>
+ * Initially this output stream buffers to memory, like ByteArrayOutputStream
+ * might do, but it shifts to using an on disk temporary file if the output gets
+ * too large.
+ * <p>
+ * The content of this buffered stream may be sent to another OutputStream only
+ * after this stream has been properly closed by {@link #close()}.
+ */
+public class TemporaryBuffer extends OutputStream {
+	private static final int DEFAULT_IN_CORE_LIMIT = 1024 * 1024;
+
+	/** Chain of data, if we are still completely in-core; otherwise null. */
+	private ArrayList<Block> blocks;
+
+	/**
+	 * Maximum number of bytes we will permit storing in memory.
+	 * <p>
+	 * When this limit is reached the data will be shifted to a file on disk,
+	 * preventing the JVM heap from growing out of control.
+	 */
+	private int inCoreLimit;
+
+	/**
+	 * Location of our temporary file if we are on disk; otherwise null.
+	 * <p>
+	 * If we exceeded the {@link #inCoreLimit} we nulled out {@link #blocks} and
+	 * created this file instead. All output goes here through {@link #diskOut}.
+	 */
+	private File onDiskFile;
+
+	/** If writing to {@link #onDiskFile} this is a buffered stream to it. */
+	private OutputStream diskOut;
+
+	/** Create a new empty temporary buffer. */
+	public TemporaryBuffer() {
+		inCoreLimit = DEFAULT_IN_CORE_LIMIT;
+		blocks = new ArrayList<Block>(inCoreLimit / Block.SZ);
+		blocks.add(new Block());
+	}
+
+	@Override
+	public void write(final int b) throws IOException {
+		if (blocks == null) {
+			diskOut.write(b);
+			return;
+		}
+
+		Block s = last();
+		if (s.isFull()) {
+			if (reachedInCoreLimit()) {
+				diskOut.write(b);
+				return;
+			}
+
+			s = new Block();
+			blocks.add(s);
+		}
+		s.buffer[s.count++] = (byte) b;
+	}
+
+	@Override
+	public void write(final byte[] b, int off, int len) throws IOException {
+		if (blocks != null) {
+			while (len > 0) {
+				Block s = last();
+				if (s.isFull()) {
+					if (reachedInCoreLimit())
+						break;
+
+					s = new Block();
+					blocks.add(s);
+				}
+
+				final int n = Math.min(Block.SZ - s.count, len);
+				System.arraycopy(b, off, s.buffer, s.count, n);
+				s.count += n;
+				len -= n;
+				off += n;
+			}
+		}
+
+		if (len > 0)
+			diskOut.write(b, off, len);
+	}
+
+	private Block last() {
+		return blocks.get(blocks.size() - 1);
+	}
+
+	private boolean reachedInCoreLimit() throws IOException {
+		if (blocks.size() * Block.SZ < inCoreLimit)
+			return false;
+
+		onDiskFile = File.createTempFile("jgit_", ".buffer");
+		diskOut = new FileOutputStream(onDiskFile);
+
+		final Block last = blocks.remove(blocks.size() - 1);
+		for (final Block b : blocks)
+			diskOut.write(b.buffer, 0, b.count);
+		blocks = null;
+
+		diskOut = new BufferedOutputStream(diskOut, Block.SZ);
+		diskOut.write(last.buffer, 0, last.count);
+		return true;
+	}
+
+	public void close() throws IOException {
+		if (diskOut != null) {
+			try {
+				diskOut.close();
+			} finally {
+				diskOut = null;
+			}
+		}
+	}
+
+	/**
+	 * Obtain the length (in bytes) of the buffer.
+	 * <p>
+	 * The length is only accurate after {@link #close()} has been invoked.
+	 * 
+	 * @return total length of the buffer, in bytes.
+	 */
+	public long length() {
+		if (onDiskFile != null)
+			return onDiskFile.length();
+
+		final Block last = last();
+		return ((long) blocks.size()) * Block.SZ - (Block.SZ - last.count);
+	}
+
+	/**
+	 * Send this buffer to an output stream.
+	 * <p>
+	 * This method may only be invoked after {@link #close()} has completed
+	 * normally, to ensure all data is completely transferred.
+	 * 
+	 * @param os
+	 *            stream to send this buffer's complete content to.
+	 * @param pm
+	 *            if not null progress updates are sent here. Caller should
+	 *            initialize the task and the number of work units to
+	 *            <code>{@link #length()}/1024</code>.
+	 * @throws IOException
+	 *             an error occurred reading from a temporary file on the local
+	 *             system, or writing to the output stream.
+	 */
+	public void writeTo(final OutputStream os, ProgressMonitor pm)
+			throws IOException {
+		if (pm == null)
+			pm = new NullProgressMonitor();
+		if (blocks != null) {
+			// Everything is in core so we can stream directly to the output.
+			//
+			for (final Block b : blocks) {
+				os.write(b.buffer, 0, b.count);
+				pm.update(b.count / 1024);
+			}
+		} else {
+			// Reopen the temporary file and copy the contents.
+			//
+			final FileInputStream in = new FileInputStream(onDiskFile);
+			try {
+				int cnt;
+				final byte[] buf = new byte[Block.SZ];
+				while ((cnt = in.read(buf)) >= 0) {
+					os.write(buf, 0, cnt);
+					pm.update(cnt / 1024);
+				}
+			} finally {
+				in.close();
+			}
+		}
+	}
+
+	/** Clear this buffer so it has no data, and cannot be used again. */
+	public void destroy() {
+		blocks = null;
+
+		if (diskOut != null) {
+			try {
+				diskOut.close();
+			} catch (IOException err) {
+				// We shouldn't encounter an error closing the file.
+			} finally {
+				diskOut = null;
+			}
+		}
+
+		if (onDiskFile != null) {
+			if (!onDiskFile.delete())
+				onDiskFile.deleteOnExit();
+			onDiskFile = null;
+		}
+	}
+
+	private static class Block {
+		static final int SZ = 8 * 1024;
+
+		final byte[] buffer = new byte[SZ];
+
+		int count;
+
+		boolean isFull() {
+			return count == SZ;
+		}
+	}
+}
-- 
1.5.6.74.g8a5e
