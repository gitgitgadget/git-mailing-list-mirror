From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/6] Add diff.Edit to describe an edit region within a file
Date: Fri,  1 May 2009 19:08:43 -0700
Message-ID: <1241230127-28279-3-git-send-email-spearce@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org>
 <1241230127-28279-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	"Johannes E. Schindelin" <johannes.schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 02 04:09:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04fN-0003rn-61
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 04:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbZEBCJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 22:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZEBCJQ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 22:09:16 -0400
Received: from george.spearce.org ([209.20.77.23]:48666 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZEBCJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 22:09:10 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 756BA3807D; Sat,  2 May 2009 02:09:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1DC7A3807E;
	Sat,  2 May 2009 02:08:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
In-Reply-To: <1241230127-28279-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118120>

From: Johannes E. Schindelin <johannes.schindelin@gmx.de>

This type represents a difference region detected between two files.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/diff/EditTest.java        |  139 ++++++++++++++
 .../src/org/spearce/jgit/diff/Edit.java            |  189 ++++++++++++++++++++
 2 files changed, 328 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/Edit.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditTest.java
new file mode 100644
index 0000000..8f9b0e3
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditTest.java
@@ -0,0 +1,139 @@
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
+import junit.framework.TestCase;
+
+public class EditTest extends TestCase {
+	public void testCreate() {
+		final Edit e = new Edit(1, 2, 3, 4);
+		assertEquals(1, e.getBeginA());
+		assertEquals(2, e.getEndA());
+		assertEquals(3, e.getBeginB());
+		assertEquals(4, e.getEndB());
+	}
+
+	public void testCreateEmpty() {
+		final Edit e = new Edit(1, 3);
+		assertEquals(1, e.getBeginA());
+		assertEquals(1, e.getEndA());
+		assertEquals(3, e.getBeginB());
+		assertEquals(3, e.getEndB());
+	}
+
+	public void testSwap() {
+		final Edit e = new Edit(1, 2, 3, 4);
+		e.swap();
+		assertEquals(3, e.getBeginA());
+		assertEquals(4, e.getEndA());
+		assertEquals(1, e.getBeginB());
+		assertEquals(2, e.getEndB());
+	}
+
+	public void testType_Insert() {
+		final Edit e = new Edit(1, 1, 1, 2);
+		assertSame(Edit.Type.INSERT, e.getType());
+	}
+
+	public void testType_Delete() {
+		final Edit e = new Edit(1, 2, 1, 1);
+		assertSame(Edit.Type.DELETE, e.getType());
+	}
+
+	public void testType_Replace() {
+		final Edit e = new Edit(1, 2, 1, 4);
+		assertSame(Edit.Type.REPLACE, e.getType());
+	}
+
+	public void testType_Empty() {
+		assertSame(Edit.Type.EMPTY, new Edit(1, 1, 2, 2).getType());
+		assertSame(Edit.Type.EMPTY, new Edit(1, 2).getType());
+	}
+
+	public void testToString() {
+		final Edit e = new Edit(1, 2, 1, 4);
+		assertEquals("REPLACE(1-2,1-4)", e.toString());
+	}
+
+	public void testEquals1() {
+		final Edit e1 = new Edit(1, 2, 3, 4);
+		final Edit e2 = new Edit(1, 2, 3, 4);
+
+		assertTrue(e1.equals(e1));
+		assertTrue(e1.equals(e2));
+		assertTrue(e2.equals(e1));
+		assertEquals(e1.hashCode(), e2.hashCode());
+		assertFalse(e1.equals(""));
+	}
+
+	public void testNotEquals1() {
+		assertFalse(new Edit(1, 2, 3, 4).equals(new Edit(0, 2, 3, 4)));
+	}
+
+	public void testNotEquals2() {
+		assertFalse(new Edit(1, 2, 3, 4).equals(new Edit(1, 0, 3, 4)));
+	}
+
+	public void testNotEquals3() {
+		assertFalse(new Edit(1, 2, 3, 4).equals(new Edit(1, 2, 0, 4)));
+	}
+
+	public void testNotEquals4() {
+		assertFalse(new Edit(1, 2, 3, 4).equals(new Edit(1, 2, 3, 0)));
+	}
+
+	public void testExtendA() {
+		final Edit e = new Edit(1, 2, 1, 1);
+
+		e.extendA();
+		assertEquals(new Edit(1, 3, 1, 1), e);
+
+		e.extendA();
+		assertEquals(new Edit(1, 4, 1, 1), e);
+	}
+
+	public void testExtendB() {
+		final Edit e = new Edit(1, 2, 1, 1);
+
+		e.extendB();
+		assertEquals(new Edit(1, 2, 1, 2), e);
+
+		e.extendB();
+		assertEquals(new Edit(1, 2, 1, 3), e);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/Edit.java b/org.spearce.jgit/src/org/spearce/jgit/diff/Edit.java
new file mode 100644
index 0000000..460e2c4
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/Edit.java
@@ -0,0 +1,189 @@
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
+ * A modified region detected between two versions of roughly the same content.
+ * <p>
+ * An edit covers the modified region only. It does not cover a common region.
+ * <p>
+ * Regions should be specified using 0 based notation, so add 1 to the start and
+ * end marks for line numbers in a file.
+ * <p>
+ * An edit where <code>beginA == endA && beginB < endB</code> is an insert edit,
+ * that is sequence B inserted the elements in region
+ * <code>[beginB, endB)</code> at <code>beginA</code>.
+ * <p>
+ * An edit where <code>beginA < endA && beginB == endB</code> is a delete edit,
+ * that is sequence B has removed the elements between
+ * <code>[beginA, endA)</code>.
+ * <p>
+ * An edit where <code>beginA < endA && beginB < endB</code> is a replace edit,
+ * that is sequence B has replaced the range of elements between
+ * <code>[beginA, endA)</code> with those found in <code>[beginB, endB)</code>.
+ */
+public class Edit {
+	/** Type of edit */
+	public static enum Type {
+		/** Sequence B has inserted the region. */
+		INSERT,
+
+		/** Sequence B has removed the region. */
+		DELETE,
+
+		/** Sequence B has replaced the region with different content. */
+		REPLACE,
+
+		/** Sequence A and B have zero length, describing nothing. */
+		EMPTY;
+	}
+
+	int beginA;
+
+	int endA;
+
+	int beginB;
+
+	int endB;
+
+	/**
+	 * Create a new empty edit.
+	 * 
+	 * @param as
+	 *            beginA: start and end of region in sequence A; 0 based.
+	 * @param bs
+	 *            beginB: start and end of region in sequence B; 0 based.
+	 */
+	public Edit(final int as, final int bs) {
+		this(as, as, bs, bs);
+	}
+
+	/**
+	 * Create a new edit.
+	 * 
+	 * @param as
+	 *            beginA: start of region in sequence A; 0 based.
+	 * @param ae
+	 *            endA: end of region in sequence A; must be >= as.
+	 * @param bs
+	 *            beginB: start of region in sequence B; 0 based.
+	 * @param be
+	 *            endB: end of region in sequence B; must be >= bs.
+	 */
+	public Edit(final int as, final int ae, final int bs, final int be) {
+		beginA = as;
+		endA = ae;
+
+		beginB = bs;
+		endB = be;
+	}
+
+	/** @return the type of this region */
+	public final Type getType() {
+		if (beginA == endA && beginB < endB)
+			return Type.INSERT;
+		if (beginA < endA && beginB == endB)
+			return Type.DELETE;
+		if (beginA == endA && beginB == endB)
+			return Type.EMPTY;
+		return Type.REPLACE;
+	}
+
+	/** @return start point in sequence A. */
+	public final int getBeginA() {
+		return beginA;
+	}
+
+	/** @return end point in sequence A. */
+	public final int getEndA() {
+		return endA;
+	}
+
+	/** @return start point in sequence B. */
+	public final int getBeginB() {
+		return beginB;
+	}
+
+	/** @return end point in sequence B. */
+	public final int getEndB() {
+		return endB;
+	}
+
+	/** Increase {@link #getEndA()} by 1. */
+	public void extendA() {
+		endA++;
+	}
+
+	/** Increase {@link #getEndB()} by 1. */
+	public void extendB() {
+		endB++;
+	}
+
+	/** Swap A and B, so the edit goes the other direction. */
+	public void swap() {
+		final int sBegin = beginA;
+		final int sEnd = endA;
+
+		beginA = beginB;
+		endA = endB;
+
+		beginB = sBegin;
+		endB = sEnd;
+	}
+
+	@Override
+	public int hashCode() {
+		return beginA ^ endA;
+	}
+
+	@Override
+	public boolean equals(final Object o) {
+		if (o instanceof Edit) {
+			final Edit e = (Edit) o;
+			return this.beginA == e.beginA && this.endA == e.endA
+					&& this.beginB == e.beginB && this.endB == e.endB;
+		}
+		return false;
+	}
+
+	@Override
+	public String toString() {
+		final Type t = getType();
+		return t + "(" + beginA + "-" + endA + "," + beginB + "-" + endB + ")";
+	}
+}
-- 
1.6.3.rc3.212.g8c698
