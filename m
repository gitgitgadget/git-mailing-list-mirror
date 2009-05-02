From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/6] Add diff.RawText to index a file content for later compares
Date: Fri,  1 May 2009 19:08:45 -0700
Message-ID: <1241230127-28279-5-git-send-email-spearce@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org>
 <1241230127-28279-2-git-send-email-spearce@spearce.org>
 <1241230127-28279-3-git-send-email-spearce@spearce.org>
 <1241230127-28279-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	"Johannes E. Schindelin" <johannes.schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 02 04:09:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04fu-0003zI-NV
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 04:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZEBCJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 22:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbZEBCJV
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 22:09:21 -0400
Received: from george.spearce.org ([209.20.77.23]:48674 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZEBCJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 22:09:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2809E3807F; Sat,  2 May 2009 02:09:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D524B38080;
	Sat,  2 May 2009 02:08:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
In-Reply-To: <1241230127-28279-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118123>

From: Johannes E. Schindelin <johannes.schindelin@gmx.de>

The RawText class converts a byte[] into an indexed map of file
lines, assuming the source content is a UNIX formatted text file.
This fits in line with Git's usage of libxdiff, where typically
the file content is treated as a UNIX formatted text file, unless
binary content was previously detected in the file stream.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/diff/RawTextTest.java     |   93 +++++++++++
 .../src/org/spearce/jgit/diff/RawText.java         |  172 ++++++++++++++++++++
 .../src/org/spearce/jgit/diff/Sequence.java        |   78 +++++++++
 3 files changed, 343 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/RawTextTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/Sequence.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/diff/RawTextTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/RawTextTest.java
new file mode 100644
index 0000000..a7c621e
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/RawTextTest.java
@@ -0,0 +1,93 @@
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
+package org.spearce.jgit.diff;
+
+import java.io.ByteArrayOutputStream;
+import java.io.IOException;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.util.RawParseUtils;
+
+public class RawTextTest extends TestCase {
+	public void testEmpty() {
+		final RawText r = new RawText(new byte[0]);
+		assertEquals(0, r.size());
+	}
+
+	public void testEquals() {
+		final RawText a = new RawText(Constants.encodeASCII("foo-a\nfoo-b\n"));
+		final RawText b = new RawText(Constants.encodeASCII("foo-b\nfoo-c\n"));
+
+		assertEquals(2, a.size());
+		assertEquals(2, b.size());
+
+		// foo-a != foo-b
+		assertFalse(a.equals(0, b, 0));
+		assertFalse(b.equals(0, a, 0));
+
+		// foo-b == foo-b
+		assertTrue(a.equals(1, b, 0));
+		assertTrue(b.equals(0, a, 1));
+	}
+
+	public void testWriteLine1() throws IOException {
+		final RawText a = new RawText(Constants.encodeASCII("foo-a\nfoo-b\n"));
+		final ByteArrayOutputStream o = new ByteArrayOutputStream();
+		a.writeLine(o, 0);
+		final byte[] r = o.toByteArray();
+		assertEquals("foo-a", RawParseUtils.decode(r));
+	}
+
+	public void testWriteLine2() throws IOException {
+		final RawText a = new RawText(Constants.encodeASCII("foo-a\nfoo-b"));
+		final ByteArrayOutputStream o = new ByteArrayOutputStream();
+		a.writeLine(o, 1);
+		final byte[] r = o.toByteArray();
+		assertEquals("foo-b", RawParseUtils.decode(r));
+	}
+
+	public void testWriteLine3() throws IOException {
+		final RawText a = new RawText(Constants.encodeASCII("a\n\nb\n"));
+		final ByteArrayOutputStream o = new ByteArrayOutputStream();
+		a.writeLine(o, 1);
+		final byte[] r = o.toByteArray();
+		assertEquals("", RawParseUtils.decode(r));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java b/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
new file mode 100644
index 0000000..1d10082
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
@@ -0,0 +1,172 @@
+/*
+ * Copyright (C) 2008, Johannes E. Schindelin <johannes.schindelin@gmx.de>
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
+package org.spearce.jgit.diff;
+
+import java.io.IOException;
+import java.io.OutputStream;
+
+import org.spearce.jgit.util.IntList;
+import org.spearce.jgit.util.RawParseUtils;
+
+/**
+ * A Sequence supporting UNIX formatted text in byte[] format.
+ * <p>
+ * Elements of the sequence are the lines of the file, as delimited by the UNIX
+ * newline character ('\n'). The file content is treated as 8 bit binary text,
+ * with no assumptions or requirements on character encoding.
+ * <p>
+ * Note that the first line of the file is element 0, as defined by the Sequence
+ * interface API. Traditionally in a text editor a patch file the first line is
+ * line number 1. Callers may need to subtract 1 prior to invoking methods if
+ * they are converting from "line number" to "element index".
+ */
+public class RawText implements Sequence {
+	/** The file content for this sequence. */
+	protected final byte[] content;
+
+	/** Map of line number to starting position within {@link #content}. */
+	protected final IntList lines;
+
+	/** Hash code for each line, for fast equality elimination. */
+	protected final IntList hashes;
+
+	/**
+	 * Create a new sequence from an existing content byte array.
+	 * <p>
+	 * The entire array (indexes 0 through length-1) is used as the content.
+	 * 
+	 * @param input
+	 *            the content array. The array is never modified, so passing
+	 *            through cached arrays is safe.
+	 */
+	public RawText(final byte[] input) {
+		content = input;
+		lines = RawParseUtils.lineMap(content, 0, content.length);
+		hashes = computeHashes();
+	}
+
+	public int size() {
+		// The line map is always 2 entries larger than the number of lines in
+		// the file. Index 0 is padded out/unused. The last index is the total
+		// length of the buffer, and acts as a sentinel.
+		//
+		return lines.size() - 2;
+	}
+
+	public boolean equals(final int i, final Sequence other, final int j) {
+		return equals(this, i + 1, (RawText) other, j + 1);
+	}
+
+	private static boolean equals(final RawText a, final int ai,
+			final RawText b, final int bi) {
+		if (a.hashes.get(ai) != b.hashes.get(bi))
+			return false;
+
+		int as = a.lines.get(ai);
+		int bs = b.lines.get(bi);
+		final int ae = a.lines.get(ai + 1);
+		final int be = b.lines.get(bi + 1);
+
+		if (ae - as != be - bs)
+			return false;
+
+		while (as < ae) {
+			if (a.content[as++] != b.content[bs++])
+				return false;
+		}
+		return true;
+	}
+
+	/**
+	 * Write a specific line to the output stream, without its trailing LF.
+	 * <p>
+	 * The specified line is copied as-is, with no character encoding
+	 * translation performed.
+	 * <p>
+	 * If the specified line ends with an LF ('\n'), the LF is <b>not</b>
+	 * copied. It is up to the caller to write the LF, if desired, between
+	 * output lines.
+	 * 
+	 * @param out
+	 *            stream to copy the line data onto.
+	 * @param i
+	 *            index of the line to extract. Note this is 0-based, so line
+	 *            number 1 is actually index 0.
+	 * @throws IOException
+	 *             the stream write operation failed.
+	 */
+	public void writeLine(final OutputStream out, final int i)
+			throws IOException {
+		final int start = lines.get(i + 1);
+		int end = lines.get(i + 2);
+		if (content[end - 1] == '\n')
+			end--;
+		out.write(content, start, end - start);
+	}
+
+	private IntList computeHashes() {
+		final IntList r = new IntList(lines.size());
+		r.add(0);
+		for (int lno = 1; lno < lines.size() - 1; lno++) {
+			final int ptr = lines.get(lno);
+			final int end = lines.get(lno + 1);
+			r.add(hashLine(content, ptr, end));
+		}
+		r.add(0);
+		return r;
+	}
+
+	/**
+	 * Compute a hash code for a single line.
+	 * 
+	 * @param raw
+	 *            the raw file content.
+	 * @param ptr
+	 *            first byte of the content line to hash.
+	 * @param end
+	 *            1 past the last byte of the content line.
+	 * @return hash code for the region <code>[ptr, end)</code> of raw.
+	 */
+	protected int hashLine(final byte[] raw, int ptr, final int end) {
+		int hash = 5381;
+		for (; ptr < end; ptr++)
+			hash = (hash << 5) ^ (raw[ptr] & 0xff);
+		return hash;
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/Sequence.java b/org.spearce.jgit/src/org/spearce/jgit/diff/Sequence.java
new file mode 100644
index 0000000..8e754e0
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/Sequence.java
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2008, Johannes E. Schindelin <johannes.schindelin@gmx.de>
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
+package org.spearce.jgit.diff;
+
+/**
+ * Arbitrary sequence of elements with fast comparison support.
+ * <p>
+ * A sequence of elements is defined to contain elements in the index range
+ * <code>[0, {@link #size()})</code>, like a standard Java List implementation.
+ * Unlike a List, the members of the sequence are not directly obtainable, but
+ * element equality can be tested if two Sequences are the same implementation.
+ * <p>
+ * An implementation may chose to implement the equals semantic as necessary,
+ * including fuzzy matching rules such as ignoring insignificant sub-elements,
+ * e.g. ignoring whitespace differences in text.
+ * <p>
+ * Implementations of Sequence are primarily intended for use in content
+ * difference detection algorithms, to produce an {@link EditList} of
+ * {@link Edit} instances describing how two Sequence instances differ.
+ */
+public interface Sequence {
+	/** @return total number of items in the sequence. */
+	public int size();
+
+	/**
+	 * Determine if the i-th member is equal to the j-th member.
+	 * <p>
+	 * Implementations must ensure <code>equals(thisIdx,other,otherIdx)</code>
+	 * returns the same as <code>other.equals(otherIdx,this,thisIdx)</code>.
+	 * 
+	 * @param thisIdx
+	 *            index within <code>this</code> sequence; must be in the range
+	 *            <code>[ 0, this.size() )</code>.
+	 * @param other
+	 *            another sequence; must be the same implementation class, that
+	 *            is <code>this.getClass() == other.getClass()</code>.
+	 * @param otherIdx
+	 *            index within <code>other</code> sequence; must be in the range
+	 *            <code>[ 0, other.size() )</code>.
+	 * @return true if the elements are equal; false if they are not equal.
+	 */
+	public boolean equals(int thisIdx, Sequence other, int otherIdx);
+}
\ No newline at end of file
-- 
1.6.3.rc3.212.g8c698
