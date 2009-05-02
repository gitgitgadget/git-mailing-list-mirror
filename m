From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/6] Add diff.EditList to provide for a list of Edit instances
Date: Fri,  1 May 2009 19:08:44 -0700
Message-ID: <1241230127-28279-4-git-send-email-spearce@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org>
 <1241230127-28279-2-git-send-email-spearce@spearce.org>
 <1241230127-28279-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 02 04:09:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04fO-0003rn-JD
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 04:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbZEBCJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 22:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZEBCJS
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 22:09:18 -0400
Received: from george.spearce.org ([209.20.77.23]:48670 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbZEBCJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 22:09:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3466F3807E; Sat,  2 May 2009 02:09:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 844BB3807F;
	Sat,  2 May 2009 02:08:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
In-Reply-To: <1241230127-28279-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118121>

Often a file difference involves more than one modified region, in
which case we need more than one Edit instance to describe the full
change that was made.

List<Edit> could be used with any generic List implementation, but
we may want to offer additional API functionality that is Edit list
specific, so I'm creating a specialized List implementation for it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/diff/EditListTest.java    |  121 ++++++++++++++++++++
 .../src/org/spearce/jgit/diff/EditList.java        |   93 +++++++++++++++
 2 files changed, 214 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditListTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/EditList.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditListTest.java
new file mode 100644
index 0000000..54d5007
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/EditListTest.java
@@ -0,0 +1,121 @@
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
+import java.util.Iterator;
+
+import junit.framework.TestCase;
+
+public class EditListTest extends TestCase {
+	public void testEmpty() {
+		final EditList l = new EditList();
+		assertEquals(0, l.size());
+		assertTrue(l.isEmpty());
+		assertEquals("EditList[]", l.toString());
+
+		assertTrue(l.equals(l));
+		assertTrue(l.equals(new EditList()));
+		assertFalse(l.equals(""));
+		assertEquals(l.hashCode(), new EditList().hashCode());
+	}
+
+	public void testAddOne() {
+		final Edit e = new Edit(1, 2, 1, 1);
+		final EditList l = new EditList();
+		l.add(e);
+		assertEquals(1, l.size());
+		assertFalse(l.isEmpty());
+		assertSame(e, l.get(0));
+		assertSame(e, l.iterator().next());
+
+		assertTrue(l.equals(l));
+		assertFalse(l.equals(new EditList()));
+
+		final EditList l2 = new EditList();
+		l2.add(e);
+		assertTrue(l.equals(l2));
+		assertTrue(l2.equals(l));
+		assertEquals(l.hashCode(), l2.hashCode());
+	}
+
+	public void testAddTwo() {
+		final Edit e1 = new Edit(1, 2, 1, 1);
+		final Edit e2 = new Edit(8, 8, 8, 12);
+		final EditList l = new EditList();
+		l.add(e1);
+		l.add(e2);
+		assertEquals(2, l.size());
+		assertSame(e1, l.get(0));
+		assertSame(e2, l.get(1));
+
+		final Iterator<Edit> i = l.iterator();
+		assertSame(e1, i.next());
+		assertSame(e2, i.next());
+
+		assertTrue(l.equals(l));
+		assertFalse(l.equals(new EditList()));
+
+		final EditList l2 = new EditList();
+		l2.add(e1);
+		l2.add(e2);
+		assertTrue(l.equals(l2));
+		assertTrue(l2.equals(l));
+		assertEquals(l.hashCode(), l2.hashCode());
+	}
+
+	public void testSet() {
+		final Edit e1 = new Edit(1, 2, 1, 1);
+		final Edit e2 = new Edit(3, 4, 3, 3);
+		final EditList l = new EditList();
+		l.add(e1);
+		assertSame(e1, l.get(0));
+		assertSame(e1, l.set(0, e2));
+		assertSame(e2, l.get(0));
+	}
+
+	public void testRemove() {
+		final Edit e1 = new Edit(1, 2, 1, 1);
+		final Edit e2 = new Edit(8, 8, 8, 12);
+		final EditList l = new EditList();
+		l.add(e1);
+		l.add(e2);
+		l.remove(e1);
+		assertEquals(1, l.size());
+		assertSame(e2, l.get(0));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/EditList.java b/org.spearce.jgit/src/org/spearce/jgit/diff/EditList.java
new file mode 100644
index 0000000..0ccf366
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/EditList.java
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
+import java.util.AbstractList;
+import java.util.ArrayList;
+
+/** Specialized list of {@link Edit}s in a document. */
+public class EditList extends AbstractList<Edit> {
+	private final ArrayList<Edit> container;
+
+	/** Create a new, empty edit list. */
+	public EditList() {
+		container = new ArrayList<Edit>();
+	}
+
+	@Override
+	public int size() {
+		return container.size();
+	}
+
+	@Override
+	public Edit get(final int index) {
+		return container.get(index);
+	}
+
+	@Override
+	public Edit set(final int index, final Edit element) {
+		return container.set(index, element);
+	}
+
+	@Override
+	public void add(final int index, final Edit element) {
+		container.add(index, element);
+	}
+
+	@Override
+	public Edit remove(final int index) {
+		return container.remove(index);
+	}
+
+	@Override
+	public int hashCode() {
+		return container.hashCode();
+	}
+
+	@Override
+	public boolean equals(final Object o) {
+		if (o instanceof EditList)
+			return container.equals(((EditList) o).container);
+		return false;
+	}
+
+	@Override
+	public String toString() {
+		return "EditList" + container.toString();
+	}
+}
-- 
1.6.3.rc3.212.g8c698
