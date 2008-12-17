From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2 v2] Add getScriptText functions to obtain the
	plain-text version of a patch
Date: Wed, 17 Dec 2008 12:13:26 -0800
Message-ID: <20081217201326.GI32487@spearce.org>
References: <1229136146-15359-1-git-send-email-spearce@spearce.org> <1229136146-15359-2-git-send-email-spearce@spearce.org> <200812131202.07717.robin.rosenberg.lists@dewire.com> <200812132226.47815.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:15:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD2n9-0007yz-BL
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 21:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYLQUN3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2008 15:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbYLQUN3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 15:13:29 -0500
Received: from george.spearce.org ([209.20.77.23]:46390 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbYLQUN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 15:13:27 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 40A6F38200; Wed, 17 Dec 2008 20:13:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812132226.47815.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103381>

The conversion from byte[] to String is performed one file at a time,
in case the patch is a character encoding conversion patch for the
file.  For simplicity we currently assume UTF-8 still as the default
encoding for any content, but eventually we should support using the
=2Egitattributes encoding property when performing this conversion.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
  > > For usefulness we must be able to pass the encoding from outside,=
=20
  > > e.g. the encoding Eclipse uses, which often is not UTF-8-
  >=20
  > It's even worse. You should probably do the encoding guess on the w=
hole
  > patch, or per file and not per line so make success possible at all=
=2E Reading
  > and writing as ISO-8859-1 will always work as that is just padding =
every
  > byte with NUL on reading and dropping it on writing. I.e. if your c=
onvert
  > to char at all...

  So this patch does the "whole file" thing.  But there is a
  fast-path in getScriptText to try and bypass the multiple copies
  we have to make in order to shovel the entire file into the
  CharsetDecoder just to read the patch.  It isn't common to see
  a character set conversion patch, so the fast case of decoding
  the whole patch text at once should happen most of the time.

 .../jgit/patch/testGetText_BothISO88591.patch      |   21 +++
 .../spearce/jgit/patch/testGetText_Convert.patch   |   21 +++
 .../spearce/jgit/patch/testGetText_DiffCc.patch    |   13 ++
 .../spearce/jgit/patch/testGetText_NoBinary.patch  |    4 +
 .../tst/org/spearce/jgit/patch/GetTextTest.java    |  142 ++++++++++++=
++++++++
 .../org/spearce/jgit/patch/CombinedFileHeader.java |   27 ++++
 .../org/spearce/jgit/patch/CombinedHunkHeader.java |  127 ++++++++++++=
+++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |  116 ++++++++++++=
++++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |   86 ++++++++++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   57 ++++++++-
 10 files changed, 611 insertions(+), 3 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/pat=
ch/testGetText_BothISO88591.patch
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/pat=
ch/testGetText_Convert.patch
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/pat=
ch/testGetText_DiffCc.patch
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/pat=
ch/testGetText_NoBinary.patch
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/Ge=
tTextTest.java

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/test=
GetText_BothISO88591.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce=
/jgit/patch/testGetText_BothISO88591.patch
new file mode 100644
index 0000000..8224fcc
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testGetText=
_BothISO88591.patch
@@ -0,0 +1,21 @@
+diff --git a/X b/X
+index 014ef30..8c80a36 100644
+--- a/X
++++ b/X
+@@ -1,7 +1,7 @@
+ a
+ b
+ c
+-=EF=BF=BDngstr=EF=BF=BDm
++line 4 =EF=BF=BDngstr=EF=BF=BDm
+ d
+ e
+ f
+@@ -13,6 +13,6 @@ k
+ l
+ m
+ n
+-=EF=BF=BDngstr=EF=BF=BDm
++=EF=BF=BDngstr=EF=BF=BDm; line 16
+ o
+ p
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/test=
GetText_Convert.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit=
/patch/testGetText_Convert.patch
new file mode 100644
index 0000000..a43fef5
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testGetText=
_Convert.patch
@@ -0,0 +1,21 @@
+diff --git a/X b/X
+index 014ef30..209db0d 100644
+--- a/X
++++ b/X
+@@ -1,7 +1,7 @@
+ a
+ b
+ c
+-=EF=BF=BDngstr=EF=BF=BDm
++=C3=85ngstr=C3=B6m
+ d
+ e
+ f
+@@ -13,6 +13,6 @@ k
+ l
+ m
+ n
+-=EF=BF=BDngstr=EF=BF=BDm
++=C3=85ngstr=C3=B6m
+ o
+ p
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/test=
GetText_DiffCc.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/=
patch/testGetText_DiffCc.patch
new file mode 100644
index 0000000..3f74a52
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testGetText=
_DiffCc.patch
@@ -0,0 +1,13 @@
+diff --cc X
+index bdfc9f4,209db0d..474bd69
+--- a/X
++++ b/X
+@@@ -1,7 -1,7 +1,7 @@@
+  a
+--b
+  c
+ +test =EF=BF=BDngstr=EF=BF=BDm
++ =C3=85ngstr=C3=B6m
+  d
+  e
+  f
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/test=
GetText_NoBinary.patch b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgi=
t/patch/testGetText_NoBinary.patch
new file mode 100644
index 0000000..e4968dc
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/patch/testGetText=
_NoBinary.patch
@@ -0,0 +1,4 @@
+diff --git a/org.spearce.egit.ui/icons/toolbar/fetchd.png b/org.spearc=
e.egit.ui/icons/toolbar/fetchd.png
+new file mode 100644
+index 0000000..4433c54
+Binary files /dev/null and b/org.spearce.egit.ui/icons/toolbar/fetchd.=
png differ
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/GetTextTe=
st.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/GetTextTest.=
java
new file mode 100644
index 0000000..04810be
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/GetTextTest.java
@@ -0,0 +1,142 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.patch;
+
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.InputStreamReader;
+import java.nio.charset.Charset;
+
+import junit.framework.TestCase;
+
+public class GetTextTest extends TestCase {
+	public void testGetText_BothISO88591() throws IOException {
+		final Charset cs =3D Charset.forName("ISO-8859-1");
+		final Patch p =3D parseTestPatchFile();
+		assertTrue(p.getErrors().isEmpty());
+		assertEquals(1, p.getFiles().size());
+		final FileHeader fh =3D p.getFiles().get(0);
+		assertEquals(2, fh.getHunks().size());
+		assertEquals(readTestPatchFile(cs), fh.getScriptText(cs, cs));
+	}
+
+	public void testGetText_NoBinary() throws IOException {
+		final Charset cs =3D Charset.forName("ISO-8859-1");
+		final Patch p =3D parseTestPatchFile();
+		assertTrue(p.getErrors().isEmpty());
+		assertEquals(1, p.getFiles().size());
+		final FileHeader fh =3D p.getFiles().get(0);
+		assertEquals(0, fh.getHunks().size());
+		assertEquals(readTestPatchFile(cs), fh.getScriptText(cs, cs));
+	}
+
+	public void testGetText_Convert() throws IOException {
+		final Charset csOld =3D Charset.forName("ISO-8859-1");
+		final Charset csNew =3D Charset.forName("UTF-8");
+		final Patch p =3D parseTestPatchFile();
+		assertTrue(p.getErrors().isEmpty());
+		assertEquals(1, p.getFiles().size());
+		final FileHeader fh =3D p.getFiles().get(0);
+		assertEquals(2, fh.getHunks().size());
+
+		// Read the original file as ISO-8859-1 and fix up the one place
+		// where we changed the character encoding. That makes the exp
+		// string match what we really expect to get back.
+		//
+		String exp =3D readTestPatchFile(csOld);
+		exp =3D exp.replace("\303\205ngstr\303\266m", "\u00c5ngstr\u00f6m");
+
+		assertEquals(exp, fh.getScriptText(csOld, csNew));
+	}
+
+	public void testGetText_DiffCc() throws IOException {
+		final Charset csOld =3D Charset.forName("ISO-8859-1");
+		final Charset csNew =3D Charset.forName("UTF-8");
+		final Patch p =3D parseTestPatchFile();
+		assertTrue(p.getErrors().isEmpty());
+		assertEquals(1, p.getFiles().size());
+		final CombinedFileHeader fh =3D (CombinedFileHeader) p.getFiles().ge=
t(0);
+		assertEquals(1, fh.getHunks().size());
+
+		// Read the original file as ISO-8859-1 and fix up the one place
+		// where we changed the character encoding. That makes the exp
+		// string match what we really expect to get back.
+		//
+		String exp =3D readTestPatchFile(csOld);
+		exp =3D exp.replace("\303\205ngstr\303\266m", "\u00c5ngstr\u00f6m");
+
+		assertEquals(exp, fh
+				.getScriptText(new Charset[] { csNew, csOld, csNew }));
+	}
+
+	private Patch parseTestPatchFile() throws IOException {
+		final String patchFile =3D getName() + ".patch";
+		final InputStream in =3D getClass().getResourceAsStream(patchFile);
+		if (in =3D=3D null) {
+			fail("No " + patchFile + " test vector");
+			return null; // Never happens
+		}
+		try {
+			final Patch p =3D new Patch();
+			p.parse(in);
+			return p;
+		} finally {
+			in.close();
+		}
+	}
+
+	private String readTestPatchFile(final Charset cs) throws IOException=
 {
+		final String patchFile =3D getName() + ".patch";
+		final InputStream in =3D getClass().getResourceAsStream(patchFile);
+		if (in =3D=3D null) {
+			fail("No " + patchFile + " test vector");
+			return null; // Never happens
+		}
+		try {
+			final InputStreamReader r =3D new InputStreamReader(in, cs);
+			char[] tmp =3D new char[2048];
+			final StringBuilder s =3D new StringBuilder();
+			int n;
+			while ((n =3D r.read(tmp)) > 0)
+				s.append(tmp, 0, n);
+			return s.toString();
+		} finally {
+			in.close();
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHe=
ader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHea=
der.java
index 3ccc418..a27e0f8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHeader.ja=
va
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedFileHeader.ja=
va
@@ -41,7 +41,9 @@
 import static org.spearce.jgit.util.RawParseUtils.match;
 import static org.spearce.jgit.util.RawParseUtils.nextLF;
=20
+import java.nio.charset.Charset;
 import java.util.ArrayList;
+import java.util.Arrays;
 import java.util.List;
=20
 import org.spearce.jgit.lib.AbbreviatedObjectId;
@@ -111,6 +113,31 @@ public AbbreviatedObjectId getOldId(final int nthP=
arent) {
 		return oldIds[nthParent];
 	}
=20
+	@Override
+	public String getScriptText(final Charset ocs, final Charset ncs) {
+		final Charset[] cs =3D new Charset[getParentCount() + 1];
+		Arrays.fill(cs, ocs);
+		cs[getParentCount()] =3D ncs;
+		return getScriptText(cs);
+	}
+
+	/**
+	 * Convert the patch script for this file into a string.
+	 *=20
+	 * @param charsetGuess
+	 *            optional array to suggest the character set to use when
+	 *            decoding each file's line. If supplied the array must h=
ave a
+	 *            length of <code>{@link #getParentCount()} + 1</code>
+	 *            representing the old revision character sets and the ne=
w
+	 *            revision character set.
+	 * @return the patch script, as a Unicode string.
+	 */
+	@Override
+	public String getScriptText(final Charset[] charsetGuess) {
+		return super.getScriptText(charsetGuess);
+	}
+
+	@Override
 	int parseGitHeaders(int ptr, final int end) {
 		while (ptr < end) {
 			final int eol =3D nextLF(buf, ptr);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHe=
ader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHea=
der.java
index 3e5c465..83ea681 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.ja=
va
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/CombinedHunkHeader.ja=
va
@@ -40,6 +40,9 @@
 import static org.spearce.jgit.util.RawParseUtils.nextLF;
 import static org.spearce.jgit.util.RawParseUtils.parseBase10;
=20
+import java.io.IOException;
+import java.io.OutputStream;
+
 import org.spearce.jgit.lib.AbbreviatedObjectId;
 import org.spearce.jgit.util.MutableInteger;
=20
@@ -188,4 +191,128 @@ int parseBody(final Patch script, final int end) =
{
=20
 		return c;
 	}
+
+	@Override
+	void extractFileLines(final OutputStream[] out) throws IOException {
+		final byte[] buf =3D file.buf;
+		int ptr =3D startOffset;
+		int eol =3D nextLF(buf, ptr);
+		if (endOffset <=3D eol)
+			return;
+
+		// Treat the hunk header as though it were from the ancestor,
+		// as it may have a function header appearing after it which
+		// was copied out of the ancestor file.
+		//
+		out[0].write(buf, ptr, eol - ptr);
+
+		SCAN: for (ptr =3D eol; ptr < endOffset; ptr =3D eol) {
+			eol =3D nextLF(buf, ptr);
+
+			if (eol - ptr < old.length + 1) {
+				// Line isn't long enough to mention the state of each
+				// ancestor. It must be the end of the hunk.
+				break SCAN;
+			}
+
+			switch (buf[ptr]) {
+			case ' ':
+			case '-':
+			case '+':
+				break;
+
+			default:
+				// Line can't possibly be part of this hunk; the first
+				// ancestor information isn't recognizable.
+				//
+				break SCAN;
+			}
+
+			int delcnt =3D 0;
+			for (int ancestor =3D 0; ancestor < old.length; ancestor++) {
+				switch (buf[ptr + ancestor]) {
+				case '-':
+					delcnt++;
+					out[ancestor].write(buf, ptr, eol - ptr);
+					continue;
+
+				case ' ':
+					out[ancestor].write(buf, ptr, eol - ptr);
+					continue;
+
+				case '+':
+					continue;
+
+				default:
+					break SCAN;
+				}
+			}
+			if (delcnt < old.length) {
+				// This line appears in the new file if it wasn't deleted
+				// relative to all ancestors.
+				//
+				out[old.length].write(buf, ptr, eol - ptr);
+			}
+		}
+	}
+
+	void extractFileLines(final StringBuilder sb, final String[] text,
+			final int[] offsets) {
+		final byte[] buf =3D file.buf;
+		int ptr =3D startOffset;
+		int eol =3D nextLF(buf, ptr);
+		if (endOffset <=3D eol)
+			return;
+		copyLine(sb, text, offsets, 0);
+		SCAN: for (ptr =3D eol; ptr < endOffset; ptr =3D eol) {
+			eol =3D nextLF(buf, ptr);
+
+			if (eol - ptr < old.length + 1) {
+				// Line isn't long enough to mention the state of each
+				// ancestor. It must be the end of the hunk.
+				break SCAN;
+			}
+
+			switch (buf[ptr]) {
+			case ' ':
+			case '-':
+			case '+':
+				break;
+
+			default:
+				// Line can't possibly be part of this hunk; the first
+				// ancestor information isn't recognizable.
+				//
+				break SCAN;
+			}
+
+			boolean copied =3D false;
+			for (int ancestor =3D 0; ancestor < old.length; ancestor++) {
+				switch (buf[ptr + ancestor]) {
+				case ' ':
+				case '-':
+					if (copied)
+						skipLine(text, offsets, ancestor);
+					else {
+						copyLine(sb, text, offsets, ancestor);
+						copied =3D true;
+					}
+					continue;
+
+				case '+':
+					continue;
+
+				default:
+					break SCAN;
+				}
+			}
+			if (!copied) {
+				// If none of the ancestors caused the copy then this line
+				// must be new across the board, so it only appears in the
+				// text of the new file.
+				//
+				copyLine(sb, text, offsets, old.length);
+			}
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.jav=
a b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index c91f80e..66c785f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -39,10 +39,15 @@
=20
 import static org.spearce.jgit.lib.Constants.encodeASCII;
 import static org.spearce.jgit.util.RawParseUtils.decode;
+import static org.spearce.jgit.util.RawParseUtils.decodeNoFallback;
+import static org.spearce.jgit.util.RawParseUtils.extractBinaryString;
 import static org.spearce.jgit.util.RawParseUtils.match;
 import static org.spearce.jgit.util.RawParseUtils.nextLF;
 import static org.spearce.jgit.util.RawParseUtils.parseBase10;
=20
+import java.io.IOException;
+import java.nio.charset.CharacterCodingException;
+import java.nio.charset.Charset;
 import java.util.ArrayList;
 import java.util.Collections;
 import java.util.List;
@@ -51,6 +56,8 @@
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.util.QuotedString;
+import org.spearce.jgit.util.RawParseUtils;
+import org.spearce.jgit.util.TemporaryBuffer;
=20
 /** Patch header describing an action for a single file path. */
 public class FileHeader {
@@ -189,6 +196,115 @@ public int getEndOffset() {
 	}
=20
 	/**
+	 * Convert the patch script for this file into a string.
+	 * <p>
+	 * The default character encoding ({@link Constants#CHARSET}) is assu=
med for
+	 * both the old and new files.
+	 *=20
+	 * @return the patch script, as a Unicode string.
+	 */
+	public String getScriptText() {
+		return getScriptText(null, null);
+	}
+
+	/**
+	 * Convert the patch script for this file into a string.
+	 *=20
+	 * @param oldCharset
+	 *            hint character set to decode the old lines with.
+	 * @param newCharset
+	 *            hint character set to decode the new lines with.
+	 * @return the patch script, as a Unicode string.
+	 */
+	public String getScriptText(Charset oldCharset, Charset newCharset) {
+		return getScriptText(new Charset[] { oldCharset, newCharset });
+	}
+
+	protected String getScriptText(Charset[] charsetGuess) {
+		if (getHunks().isEmpty()) {
+			// If we have no hunks then we can safely assume the entire
+			// patch is a binary style patch, or a meta-data only style
+			// patch. Either way the encoding of the headers should be
+			// strictly 7-bit US-ASCII and the body is either 7-bit ASCII
+			// (due to the base 85 encoding used for a BinaryHunk) or is
+			// arbitrary noise we have chosen to ignore and not understand
+			// (e.g. the message "Binary files ... differ").
+			//
+			return extractBinaryString(buf, startOffset, endOffset);
+		}
+
+		if (charsetGuess !=3D null && charsetGuess.length !=3D getParentCoun=
t() + 1)
+			throw new IllegalArgumentException("Expected "
+					+ (getParentCount() + 1) + " character encoding guesses");
+
+		if (trySimpleConversion(charsetGuess)) {
+			Charset cs =3D charsetGuess !=3D null ? charsetGuess[0] : null;
+			if (cs =3D=3D null)
+				cs =3D Constants.CHARSET;
+			try {
+				return decodeNoFallback(cs, buf, startOffset, endOffset);
+			} catch (CharacterCodingException cee) {
+				// Try the much slower, more-memory intensive version which
+				// can handle a character set conversion patch.
+			}
+		}
+
+		final StringBuilder r =3D new StringBuilder(endOffset - startOffset)=
;
+
+		// Always treat the headers as US-ASCII; Git file names are encoded
+		// in a C style escape if any character has the high-bit set.
+		//
+		final int hdrEnd =3D getHunks().get(0).getStartOffset();
+		for (int ptr =3D startOffset; ptr < hdrEnd;) {
+			final int eol =3D Math.min(hdrEnd, nextLF(buf, ptr));
+			r.append(extractBinaryString(buf, ptr, eol));
+			ptr =3D eol;
+		}
+
+		final String[] files =3D extractFileLines(charsetGuess);
+		final int[] offsets =3D new int[files.length];
+		for (final HunkHeader h : getHunks())
+			h.extractFileLines(r, files, offsets);
+		return r.toString();
+	}
+
+	private static boolean trySimpleConversion(final Charset[] charsetGue=
ss) {
+		if (charsetGuess =3D=3D null)
+			return true;
+		for (int i =3D 1; i < charsetGuess.length; i++) {
+			if (charsetGuess[i] !=3D charsetGuess[0])
+				return false;
+		}
+		return true;
+	}
+
+	private String[] extractFileLines(final Charset[] csGuess) {
+		final TemporaryBuffer[] tmp =3D new TemporaryBuffer[getParentCount()=
 + 1];
+		try {
+			for (int i =3D 0; i < tmp.length; i++)
+				tmp[i] =3D new TemporaryBuffer();
+			for (final HunkHeader h : getHunks())
+				h.extractFileLines(tmp);
+
+			final String[] r =3D new String[tmp.length];
+			for (int i =3D 0; i < tmp.length; i++) {
+				Charset cs =3D csGuess !=3D null ? csGuess[i] : null;
+				if (cs =3D=3D null)
+					cs =3D Constants.CHARSET;
+				r[i] =3D RawParseUtils.decode(cs, tmp[i].toByteArray());
+			}
+			return r;
+		} catch (IOException ioe) {
+			throw new RuntimeException("Cannot convert script to text", ioe);
+		} finally {
+			for (final TemporaryBuffer b : tmp) {
+				if (b !=3D null)
+					b.destroy();
+			}
+		}
+	}
+
+	/**
 	 * Get the old name associated with this file.
 	 * <p>
 	 * The meaning of the old name can differ depending on the semantic m=
eaning
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.jav=
a b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index 12c670d..fc30311 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -41,6 +41,9 @@
 import static org.spearce.jgit.util.RawParseUtils.nextLF;
 import static org.spearce.jgit.util.RawParseUtils.parseBase10;
=20
+import java.io.IOException;
+import java.io.OutputStream;
+
 import org.spearce.jgit.lib.AbbreviatedObjectId;
 import org.spearce.jgit.util.MutableInteger;
=20
@@ -240,4 +243,87 @@ int parseBody(final Patch script, final int end) {
=20
 		return c;
 	}
+
+	void extractFileLines(final OutputStream[] out) throws IOException {
+		final byte[] buf =3D file.buf;
+		int ptr =3D startOffset;
+		int eol =3D nextLF(buf, ptr);
+		if (endOffset <=3D eol)
+			return;
+
+		// Treat the hunk header as though it were from the ancestor,
+		// as it may have a function header appearing after it which
+		// was copied out of the ancestor file.
+		//
+		out[0].write(buf, ptr, eol - ptr);
+
+		SCAN: for (ptr =3D eol; ptr < endOffset; ptr =3D eol) {
+			eol =3D nextLF(buf, ptr);
+			switch (buf[ptr]) {
+			case ' ':
+			case '\n':
+			case '\\':
+				out[0].write(buf, ptr, eol - ptr);
+				out[1].write(buf, ptr, eol - ptr);
+				break;
+			case '-':
+				out[0].write(buf, ptr, eol - ptr);
+				break;
+			case '+':
+				out[1].write(buf, ptr, eol - ptr);
+				break;
+			default:
+				break SCAN;
+			}
+		}
+	}
+
+	void extractFileLines(final StringBuilder sb, final String[] text,
+			final int[] offsets) {
+		final byte[] buf =3D file.buf;
+		int ptr =3D startOffset;
+		int eol =3D nextLF(buf, ptr);
+		if (endOffset <=3D eol)
+			return;
+		copyLine(sb, text, offsets, 0);
+		SCAN: for (ptr =3D eol; ptr < endOffset; ptr =3D eol) {
+			eol =3D nextLF(buf, ptr);
+			switch (buf[ptr]) {
+			case ' ':
+			case '\n':
+			case '\\':
+				copyLine(sb, text, offsets, 0);
+				skipLine(text, offsets, 1);
+				break;
+			case '-':
+				copyLine(sb, text, offsets, 0);
+				break;
+			case '+':
+				copyLine(sb, text, offsets, 1);
+				break;
+			default:
+				break SCAN;
+			}
+		}
+	}
+
+	protected void copyLine(final StringBuilder sb, final String[] text,
+			final int[] offsets, final int fileIdx) {
+		final String s =3D text[fileIdx];
+		final int start =3D offsets[fileIdx];
+		int end =3D s.indexOf('\n', start);
+		if (end < 0)
+			end =3D s.length();
+		else
+			end++;
+		sb.append(s, start, end);
+		offsets[fileIdx] =3D end;
+	}
+
+	protected void skipLine(final String[] text, final int[] offsets,
+			final int fileIdx) {
+		final String s =3D text[fileIdx];
+		final int end =3D s.indexOf('\n', offsets[fileIdx]);
+		offsets[fileIdx] =3D end < 0 ? s.length() : end + 1;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.j=
ava b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 55a3001..ff89e9e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -472,6 +472,40 @@ public static String decode(final Charset cs, fina=
l byte[] buffer) {
 	 */
 	public static String decode(final Charset cs, final byte[] buffer,
 			final int start, final int end) {
+		try {
+			return decodeNoFallback(cs, buffer, start, end);
+		} catch (CharacterCodingException e) {
+			// Fall back to an ISO-8859-1 style encoding. At least all of
+			// the bytes will be present in the output.
+			//
+			return extractBinaryString(buffer, start, end);
+		}
+	}
+
+	/**
+	 * Decode a region of the buffer under the specified character set if
+	 * possible.
+	 *=20
+	 * If the byte stream cannot be decoded that way, the platform defaul=
t is
+	 * tried and if that too fails, an exception is thrown.
+	 *=20
+	 * @param cs
+	 *            character set to use when decoding the buffer.
+	 * @param buffer
+	 *            buffer to pull raw bytes from.
+	 * @param start
+	 *            first position within the buffer to take data from.
+	 * @param end
+	 *            one position past the last location within the buffer t=
o take
+	 *            data from.
+	 * @return a string representation of the range <code>[start,end)</co=
de>,
+	 *         after decoding the region through the specified character =
set.
+	 * @throws CharacterCodingException
+	 *             the input is not in any of the tested character sets.
+	 */
+	public static String decodeNoFallback(final Charset cs,
+			final byte[] buffer, final int start, final int end)
+			throws CharacterCodingException {
 		final ByteBuffer b =3D ByteBuffer.wrap(buffer, start, end - start);
 		b.mark();
=20
@@ -508,9 +542,26 @@ public static String decode(final Charset cs, fina=
l byte[] buffer,
 			}
 		}
=20
-		// Fall back to an ISO-8859-1 style encoding. At least all of
-		// the bytes will be present in the output.
-		//
+		throw new CharacterCodingException();
+	}
+
+	/**
+	 * Decode a region of the buffer under the ISO-8859-1 encoding.
+	 *=20
+	 * Each byte is treated as a single character in the 8859-1 character
+	 * encoding, performing a raw binary->char conversion.
+	 *=20
+	 * @param buffer
+	 *            buffer to pull raw bytes from.
+	 * @param start
+	 *            first position within the buffer to take data from.
+	 * @param end
+	 *            one position past the last location within the buffer t=
o take
+	 *            data from.
+	 * @return a string representation of the range <code>[start,end)</co=
de>.
+	 */
+	public static String extractBinaryString(final byte[] buffer,
+			final int start, final int end) {
 		final StringBuilder r =3D new StringBuilder(end - start);
 		for (int i =3D start; i < end; i++)
 			r.append((char) (buffer[i] & 0xff));
--=20
1.6.1.rc3.302.gb14d9

--=20
Shawn.
