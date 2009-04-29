From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 12/11] Add a test for LongMap, IndexPack's helper class
Date: Wed, 29 Apr 2009 13:42:35 -0700
Message-ID: <20090429204235.GJ23604@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org> <1240953146-12878-10-git-send-email-spearce@spearce.org> <1240953146-12878-11-git-send-email-spearce@spearce.org> <200904292145.34462.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Simon <yann.simon.fr@gmail.com>,
	Matthias Sohn <matthias.sohn@sap.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzGcr-000294-8P
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbZD2Umg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZD2Umg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:42:36 -0400
Received: from george.spearce.org ([209.20.77.23]:54135 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbZD2Umf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:42:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 60F0A38064; Wed, 29 Apr 2009 20:42:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904292145.34462.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117943>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
 > tisdag 28 april 2009 23:12:23 skrev "Shawn O. Pearce" <spearce@spearce.org>:
 > > We now use a custom Map implementation which supports primitive long
 > > as the hash key, rather than requiring boxing for java.util.HashMap.
 > > This removes the issue FindBugs was identifying.
 > 
 > No unit test for LongMap?

 .../org/spearce/jgit/transport/LongMapTest.java    |  132 ++++++++++++++++++++
 1 files changed, 132 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/LongMapTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/LongMapTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/LongMapTest.java
new file mode 100644
index 0000000..c59fd1f
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/LongMapTest.java
@@ -0,0 +1,132 @@
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
+import junit.framework.TestCase;
+
+public class LongMapTest extends TestCase {
+	private LongMap<Long> map;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		map = new LongMap<Long>();
+	}
+
+	public void testEmptyMap() {
+		assertFalse(map.containsKey(0));
+		assertFalse(map.containsKey(1));
+
+		assertNull(map.get(0));
+		assertNull(map.get(1));
+
+		assertNull(map.remove(0));
+		assertNull(map.remove(1));
+	}
+
+	public void testInsertMinValue() {
+		final Long min = Long.valueOf(Long.MIN_VALUE);
+		assertNull(map.put(Long.MIN_VALUE, min));
+		assertTrue(map.containsKey(Long.MIN_VALUE));
+		assertSame(min, map.get(Long.MIN_VALUE));
+		assertFalse(map.containsKey(Integer.MIN_VALUE));
+	}
+
+	public void testReplaceMaxValue() {
+		final Long min = Long.valueOf(Long.MAX_VALUE);
+		final Long one = Long.valueOf(1);
+		assertNull(map.put(Long.MAX_VALUE, min));
+		assertSame(min, map.get(Long.MAX_VALUE));
+		assertSame(min, map.put(Long.MAX_VALUE, one));
+		assertSame(one, map.get(Long.MAX_VALUE));
+	}
+
+	public void testRemoveOne() {
+		final long start = 1;
+		assertNull(map.put(start, Long.valueOf(start)));
+		assertEquals(Long.valueOf(start), map.remove(start));
+		assertFalse(map.containsKey(start));
+	}
+
+	public void testRemoveCollision1() {
+		// This test relies upon the fact that we always >>> 1 the value
+		// to derive an unsigned hash code. Thus, 0 and 1 fall into the
+		// same hash bucket. Further it relies on the fact that we add
+		// the 2nd put at the top of the chain, so removing the 1st will
+		// cause a different code path.
+		//
+		assertNull(map.put(0, Long.valueOf(0)));
+		assertNull(map.put(1, Long.valueOf(1)));
+		assertEquals(Long.valueOf(0), map.remove(0));
+
+		assertFalse(map.containsKey(0));
+		assertTrue(map.containsKey(1));
+	}
+
+	public void testRemoveCollision2() {
+		// This test relies upon the fact that we always >>> 1 the value
+		// to derive an unsigned hash code. Thus, 0 and 1 fall into the
+		// same hash bucket. Further it relies on the fact that we add
+		// the 2nd put at the top of the chain, so removing the 2nd will
+		// cause a different code path.
+		//
+		assertNull(map.put(0, Long.valueOf(0)));
+		assertNull(map.put(1, Long.valueOf(1)));
+		assertEquals(Long.valueOf(1), map.remove(1));
+
+		assertTrue(map.containsKey(0));
+		assertFalse(map.containsKey(1));
+	}
+
+	public void testSmallMap() {
+		final long start = 12;
+		final long n = 8;
+		for (long i = start; i < start + n; i++)
+			assertNull(map.put(i, Long.valueOf(i)));
+		for (long i = start; i < start + n; i++)
+			assertEquals(Long.valueOf(i), map.get(i));
+	}
+
+	public void testLargeMap() {
+		final long start = Integer.MAX_VALUE;
+		final long n = 100000;
+		for (long i = start; i < start + n; i++)
+			assertNull(map.put(i, Long.valueOf(i)));
+		for (long i = start; i < start + n; i++)
+			assertEquals(Long.valueOf(i), map.get(i));
+	}
+}
-- 
1.6.3.rc3.199.g24398
