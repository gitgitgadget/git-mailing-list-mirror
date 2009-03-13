From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/6] Add tests for RevWalk and its supporting code
Date: Fri, 13 Mar 2009 15:39:33 -0700
Message-ID: <20090313223933.GH22920@spearce.org>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org> <200903132100.26527.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 23:41:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiG3y-00006Y-0p
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 23:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759164AbZCMWji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 18:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756388AbZCMWjh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 18:39:37 -0400
Received: from george.spearce.org ([209.20.77.23]:33904 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbZCMWjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 18:39:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7723E38211; Fri, 13 Mar 2009 22:39:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903132100.26527.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113224>

These new tests cover some of the common cases we see with using a
RevWalk, and increase our code coverage in this critical area of
the JGit library.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
 > fredag 13 mars 2009 03:07:37 skrev "Shawn O. Pearce" <spearce@spearce.org>:
 > > Today I uncovered some ugly cases with "jgit rev-list B ^A", where
 > > some commits reachable from A were still being output, even though
 > > we asked that they be excluded.
 > 
 > How about a test suite to prove this is better than before?

 Its better.  :-)

 These tests don't pass before the series.  They pass after.
 
 .../org/spearce/jgit/revwalk/RevFlagSetTest.java   |  131 +++++++++++
 .../org/spearce/jgit/revwalk/RevWalkCullTest.java  |   75 +++++++
 .../spearce/jgit/revwalk/RevWalkFilterTest.java    |  233 ++++++++++++++++++++
 .../spearce/jgit/revwalk/RevWalkMergeBaseTest.java |  117 ++++++++++
 .../org/spearce/jgit/revwalk/RevWalkSortTest.java  |  164 ++++++++++++++
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |  102 +++++++++
 6 files changed, 822 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevFlagSetTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevFlagSetTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevFlagSetTest.java
new file mode 100644
index 0000000..76f3cbb
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevFlagSetTest.java
@@ -0,0 +1,131 @@
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
+package org.spearce.jgit.revwalk;
+
+import java.util.Arrays;
+import java.util.Iterator;
+
+public class RevFlagSetTest extends RevWalkTestCase {
+	public void testEmpty() {
+		final RevFlagSet set = new RevFlagSet();
+		assertEquals(0, set.mask);
+		assertEquals(0, set.size());
+		assertNotNull(set.iterator());
+		assertFalse(set.iterator().hasNext());
+	}
+
+	public void testAddOne() {
+		final String flagName = "flag";
+		final RevFlag flag = rw.newFlag(flagName);
+		assertTrue(0 != flag.mask);
+		assertSame(flagName, flag.name);
+
+		final RevFlagSet set = new RevFlagSet();
+		assertTrue(set.add(flag));
+		assertFalse(set.add(flag));
+		assertEquals(flag.mask, set.mask);
+		assertEquals(1, set.size());
+		final Iterator<RevFlag> i = set.iterator();
+		assertTrue(i.hasNext());
+		assertSame(flag, i.next());
+		assertFalse(i.hasNext());
+	}
+
+	public void testAddTwo() {
+		final RevFlag flag1 = rw.newFlag("flag_1");
+		final RevFlag flag2 = rw.newFlag("flag_2");
+		assertTrue((flag1.mask & flag2.mask) == 0);
+
+		final RevFlagSet set = new RevFlagSet();
+		assertTrue(set.add(flag1));
+		assertTrue(set.add(flag2));
+		assertEquals(flag1.mask | flag2.mask, set.mask);
+		assertEquals(2, set.size());
+	}
+
+	public void testContainsAll() {
+		final RevFlag flag1 = rw.newFlag("flag_1");
+		final RevFlag flag2 = rw.newFlag("flag_2");
+		final RevFlagSet set1 = new RevFlagSet();
+		assertTrue(set1.add(flag1));
+		assertTrue(set1.add(flag2));
+
+		assertTrue(set1.containsAll(set1));
+		assertTrue(set1.containsAll(Arrays
+				.asList(new RevFlag[] { flag1, flag2 })));
+
+		final RevFlagSet set2 = new RevFlagSet();
+		set2.add(rw.newFlag("flag_3"));
+		assertFalse(set1.containsAll(set2));
+	}
+
+	public void testEquals() {
+		final RevFlag flag1 = rw.newFlag("flag_1");
+		final RevFlag flag2 = rw.newFlag("flag_2");
+		final RevFlagSet set = new RevFlagSet();
+		assertTrue(set.add(flag1));
+		assertTrue(set.add(flag2));
+
+		assertTrue(new RevFlagSet(set).equals(set));
+		assertTrue(new RevFlagSet(Arrays.asList(new RevFlag[] { flag1, flag2 }))
+				.equals(set));
+	}
+
+	public void testRemove() {
+		final RevFlag flag1 = rw.newFlag("flag_1");
+		final RevFlag flag2 = rw.newFlag("flag_2");
+		final RevFlagSet set = new RevFlagSet();
+		assertTrue(set.add(flag1));
+		assertTrue(set.add(flag2));
+
+		assertTrue(set.remove(flag1));
+		assertFalse(set.remove(flag1));
+		assertEquals(flag2.mask, set.mask);
+		assertFalse(set.contains(flag1));
+	}
+
+	public void testContains() {
+		final RevFlag flag1 = rw.newFlag("flag_1");
+		final RevFlag flag2 = rw.newFlag("flag_2");
+		final RevFlagSet set = new RevFlagSet();
+		set.add(flag1);
+		assertTrue(set.contains(flag1));
+		assertFalse(set.contains(flag2));
+		assertFalse(set.contains("bob"));
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
new file mode 100644
index 0000000..ad78b16
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkCullTest.java
@@ -0,0 +1,75 @@
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
+package org.spearce.jgit.revwalk;
+
+import org.spearce.jgit.lib.ObjectId;
+
+public class RevWalkCullTest extends RevWalkTestCase {
+	public void testProperlyCullAllAncestors1() throws Exception {
+		// Credit goes to Junio C Hamano <gitster@pobox.com> for this
+		// test case in git-core (t/t6009-rev-list-parent.sh)
+		//
+		// We induce a clock skew so two is dated before one.
+		//
+		final ObjectId a = commit();
+		final ObjectId b = commit(-2400, a);
+		final ObjectId c = commit(b);
+		final ObjectId d = commit(c);
+
+		markStart(a);
+		markUninteresting(d);
+		assertNull(rw.next());
+	}
+
+	public void testProperlyCullAllAncestors2() throws Exception {
+		// Despite clock skew on c1 being very old it should not
+		// produce, neither should a or b, or any part of that chain.
+		//
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c1 = commit(-5, b);
+		final ObjectId c2 = commit(10, b);
+		final ObjectId d = commit(c1, c2);
+
+		markStart(d);
+		markUninteresting(c1);
+		assertCommit(d, rw.next());
+		assertCommit(c2, rw.next());
+		assertNull(rw.next());
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
new file mode 100644
index 0000000..cf2975d
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkFilterTest.java
@@ -0,0 +1,233 @@
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
+package org.spearce.jgit.revwalk;
+
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.errors.StopWalkException;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.revwalk.filter.AndRevFilter;
+import org.spearce.jgit.revwalk.filter.NotRevFilter;
+import org.spearce.jgit.revwalk.filter.OrRevFilter;
+import org.spearce.jgit.revwalk.filter.RevFilter;
+
+public class RevWalkFilterTest extends RevWalkTestCase {
+	private static final MyAll MY_ALL = new MyAll();
+
+	public void testFilter_ALL() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(RevFilter.ALL);
+		markStart(c);
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testFilter_Negate_ALL() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(RevFilter.ALL.negate());
+		markStart(c);
+		assertNull(rw.next());
+	}
+
+	public void testFilter_NOT_ALL() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(NotRevFilter.create(RevFilter.ALL));
+		markStart(c);
+		assertNull(rw.next());
+	}
+
+	public void testFilter_NONE() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(RevFilter.NONE);
+		markStart(c);
+		assertNull(rw.next());
+	}
+
+	public void testFilter_NOT_NONE() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(NotRevFilter.create(RevFilter.NONE));
+		markStart(c);
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testFilter_ALL_And_NONE() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(AndRevFilter.create(RevFilter.ALL, RevFilter.NONE));
+		markStart(c);
+		assertNull(rw.next());
+	}
+
+	public void testFilter_NONE_And_ALL() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(AndRevFilter.create(RevFilter.NONE, RevFilter.ALL));
+		markStart(c);
+		assertNull(rw.next());
+	}
+
+	public void testFilter_ALL_Or_NONE() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(OrRevFilter.create(RevFilter.ALL, RevFilter.NONE));
+		markStart(c);
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testFilter_NONE_Or_ALL() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(OrRevFilter.create(RevFilter.NONE, RevFilter.ALL));
+		markStart(c);
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testFilter_MY_ALL_And_NONE() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(AndRevFilter.create(MY_ALL, RevFilter.NONE));
+		markStart(c);
+		assertNull(rw.next());
+	}
+
+	public void testFilter_NONE_And_MY_ALL() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(AndRevFilter.create(RevFilter.NONE, MY_ALL));
+		markStart(c);
+		assertNull(rw.next());
+	}
+
+	public void testFilter_MY_ALL_Or_NONE() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(OrRevFilter.create(MY_ALL, RevFilter.NONE));
+		markStart(c);
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testFilter_NONE_Or_MY_ALL() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+
+		rw.setRevFilter(OrRevFilter.create(RevFilter.NONE, MY_ALL));
+		markStart(c);
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testFilter_NO_MERGES() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c1 = commit(b);
+		final ObjectId c2 = commit(b);
+		final ObjectId d = commit(c1, c2);
+		final ObjectId e = commit(d);
+
+		rw.setRevFilter(RevFilter.NO_MERGES);
+		markStart(e);
+		assertCommit(e, rw.next());
+		assertCommit(c2, rw.next());
+		assertCommit(c1, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	private static class MyAll extends RevFilter {
+		@Override
+		public RevFilter clone() {
+			return this;
+		}
+
+		@Override
+		public boolean include(RevWalk walker, RevCommit cmit)
+				throws StopWalkException, MissingObjectException,
+				IncorrectObjectTypeException, IOException {
+			return true;
+		}
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
new file mode 100644
index 0000000..b05e774
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkMergeBaseTest.java
@@ -0,0 +1,117 @@
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
+package org.spearce.jgit.revwalk;
+
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.revwalk.filter.RevFilter;
+
+public class RevWalkMergeBaseTest extends RevWalkTestCase {
+	public void testNone() throws Exception {
+		final ObjectId c1 = commit(commit(commit()));
+		final ObjectId c2 = commit(commit(commit()));
+
+		rw.setRevFilter(RevFilter.MERGE_BASE);
+		markStart(c1);
+		markStart(c2);
+		assertNull(rw.next());
+	}
+
+	public void testSimple() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c1 = commit(commit(commit(commit(commit(b)))));
+		final ObjectId c2 = commit(commit(commit(commit(commit(b)))));
+
+		rw.setRevFilter(RevFilter.MERGE_BASE);
+		markStart(c1);
+		markStart(c2);
+		assertCommit(b, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testMultipleHeads_SameBase1() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c1 = commit(commit(commit(commit(commit(b)))));
+		final ObjectId c2 = commit(commit(commit(commit(commit(b)))));
+		final ObjectId c3 = commit(commit(commit(b)));
+
+		rw.setRevFilter(RevFilter.MERGE_BASE);
+		markStart(c1);
+		markStart(c2);
+		markStart(c3);
+		assertCommit(b, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testMultipleHeads_SameBase2() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+		final ObjectId d1 = commit(commit(commit(commit(commit(b)))));
+		final ObjectId d2 = commit(commit(commit(commit(commit(c)))));
+		final ObjectId d3 = commit(commit(commit(c)));
+
+		rw.setRevFilter(RevFilter.MERGE_BASE);
+		markStart(d1);
+		markStart(d2);
+		markStart(d3);
+		assertCommit(b, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testCrissCross() throws Exception {
+		// See http://marc.info/?l=git&m=111463358500362&w=2 for a nice
+		// description of what this test is creating. We don't have a
+		// clean merge base for d,e as they each merged the parents b,c
+		// in different orders.
+		//
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(a);
+		final ObjectId d = commit(b, c);
+		final ObjectId e = commit(c, b);
+
+		rw.setRevFilter(RevFilter.MERGE_BASE);
+		markStart(d);
+		markStart(e);
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertNull(rw.next());
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
new file mode 100644
index 0000000..6f2eedc
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkSortTest.java
@@ -0,0 +1,164 @@
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
+package org.spearce.jgit.revwalk;
+
+import org.spearce.jgit.lib.ObjectId;
+
+public class RevWalkSortTest extends RevWalkTestCase {
+	public void testSort_Default() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(1, a);
+		final ObjectId c = commit(1, b);
+		final ObjectId d = commit(1, c);
+
+		markStart(d);
+		assertCommit(d, rw.next());
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testSort_COMMIT_TIME_DESC() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+		final ObjectId d = commit(c);
+
+		rw.sort(RevSort.COMMIT_TIME_DESC);
+		markStart(d);
+		assertCommit(d, rw.next());
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testSort_REVERSE() throws Exception {
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(b);
+		final ObjectId d = commit(c);
+
+		rw.sort(RevSort.REVERSE);
+		markStart(d);
+		assertCommit(a, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(c, rw.next());
+		assertCommit(d, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testSort_COMMIT_TIME_DESC_OutOfOrder1() throws Exception {
+		// Despite being out of order time-wise, a strand-of-pearls must
+		// still maintain topological order.
+		//
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c = commit(-5, b);
+		final ObjectId d = commit(10, c);
+		assertTrue(parse(a).getCommitTime() < parse(d).getCommitTime());
+		assertTrue(parse(c).getCommitTime() < parse(b).getCommitTime());
+
+		rw.sort(RevSort.COMMIT_TIME_DESC);
+		markStart(d);
+		assertCommit(d, rw.next());
+		assertCommit(c, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testSort_COMMIT_TIME_DESC_OutOfOrder2() throws Exception {
+		// c1 is back dated before its parent.
+		//
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c1 = commit(-5, b);
+		final ObjectId c2 = commit(10, b);
+		final ObjectId d = commit(c1, c2);
+
+		rw.sort(RevSort.COMMIT_TIME_DESC);
+		markStart(d);
+		assertCommit(d, rw.next());
+		assertCommit(c2, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertCommit(c1, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testSort_TOPO() throws Exception {
+		// c1 is back dated before its parent.
+		//
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c1 = commit(-5, b);
+		final ObjectId c2 = commit(10, b);
+		final ObjectId d = commit(c1, c2);
+
+		rw.sort(RevSort.TOPO);
+		markStart(d);
+		assertCommit(d, rw.next());
+		assertCommit(c2, rw.next());
+		assertCommit(c1, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(a, rw.next());
+		assertNull(rw.next());
+	}
+
+	public void testSort_TOPO_REVERSE() throws Exception {
+		// c1 is back dated before its parent.
+		//
+		final ObjectId a = commit();
+		final ObjectId b = commit(a);
+		final ObjectId c1 = commit(-5, b);
+		final ObjectId c2 = commit(10, b);
+		final ObjectId d = commit(c1, c2);
+
+		rw.sort(RevSort.TOPO);
+		rw.sort(RevSort.REVERSE, true);
+		markStart(d);
+		assertCommit(a, rw.next());
+		assertCommit(b, rw.next());
+		assertCommit(c1, rw.next());
+		assertCommit(c2, rw.next());
+		assertCommit(d, rw.next());
+		assertNull(rw.next());
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
new file mode 100644
index 0000000..bd696dd
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
@@ -0,0 +1,102 @@
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
+package org.spearce.jgit.revwalk;
+
+import java.util.Date;
+
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.PersonIdent;
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.lib.Tree;
+
+/** Support for tests of the {@link RevWalk} class. */
+public abstract class RevWalkTestCase extends RepositoryTestCase {
+	protected ObjectWriter ow;
+
+	protected ObjectId emptyTree;
+
+	protected long nowTick;
+
+	protected RevWalk rw;
+
+	public void setUp() throws Exception {
+		super.setUp();
+		ow = new ObjectWriter(db);
+		emptyTree = ow.writeTree(new Tree(db));
+		nowTick = 1236977987000L;
+		rw = new RevWalk(db);
+	}
+
+	protected void tick(final int secDelta) {
+		nowTick += secDelta * 1000L;
+	}
+
+	protected ObjectId commit(final ObjectId... parents) throws Exception {
+		return commit(1, parents);
+	}
+
+	protected ObjectId commit(final int secDelta, final ObjectId... parents)
+			throws Exception {
+		tick(secDelta);
+		final Commit c = new Commit(db);
+		c.setTreeId(emptyTree);
+		c.setParentIds(parents);
+		c.setAuthor(new PersonIdent(jauthor, new Date(nowTick)));
+		c.setCommitter(new PersonIdent(jcommitter, new Date(nowTick)));
+		c.setMessage("");
+		return ow.writeCommit(c);
+	}
+
+	protected RevCommit parse(final ObjectId commitId) throws Exception {
+		return rw.parseCommit(commitId);
+	}
+
+	protected void markStart(final ObjectId commitId) throws Exception {
+		rw.markStart(parse(commitId));
+	}
+
+	protected void markUninteresting(final ObjectId commitId) throws Exception {
+		rw.markUninteresting(parse(commitId));
+	}
+
+	protected void assertCommit(final ObjectId commitId, final RevCommit commit) {
+		assertEquals(commitId.name(), commit != null ? commit.name() : null);
+	}
+}
-- 
1.6.2.288.gc3f22
