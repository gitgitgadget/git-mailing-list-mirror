From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: [PATCH 2/2] Add PathSuffixFilter class which is TreeFilter.
Date: Tue, 11 Aug 2009 17:56:21 -0700
Message-ID: <1250038581-31241-2-git-send-email-grek@tuffmail.com>
References: <1250038581-31241-1-git-send-email-grek@tuffmail.com>
Cc: Grzegorz Kossakowski <grek@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 02:57:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb29J-0001ln-Or
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbZHLA4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753007AbZHLA4q
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:56:46 -0400
Received: from smtp-out.google.com ([216.239.33.17]:22120 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbZHLA4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 20:56:45 -0400
Received: from zps19.corp.google.com (zps19.corp.google.com [172.25.146.19])
	by smtp-out.google.com with ESMTP id n7C0uio6023062
	for <git@vger.kernel.org>; Wed, 12 Aug 2009 01:56:44 +0100
Received: from localhost (glacegreek.mtv.corp.google.com [172.18.102.106])
	by zps19.corp.google.com with ESMTP id n7C0uefF029293;
	Tue, 11 Aug 2009 17:56:41 -0700
Received: by localhost (Postfix, from userid 97043)
	id D30F07AAD4; Tue, 11 Aug 2009 17:56:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1250038581-31241-1-git-send-email-grek@tuffmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125634>

From: Grzegorz Kossakowski <grek@google.com>

Added a simple TreeFilter that filters all entries that have path with
given suffix. This filter is always recursive.

Signed-off-by: Grzegorz Kossakowski <grek@google.com>
---
 .../treewalk/filter/PathSuffixFilterTestCase.java  |  110 ++++++++++++++++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   33 ++++++
 .../jgit/treewalk/filter/PathSuffixFilter.java     |   74 +++++++++++++
 3 files changed, 217 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathSuffixFilter.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
new file mode 100644
index 0000000..6042119
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
@@ -0,0 +1,110 @@
+// Copyright (C) 2009 The Android Open Source Project
+//
+// Licensed under the Apache License, Version 2.0 (the "License");
+// you may not use this file except in compliance with the License.
+// You may obtain a copy of the License at
+//
+// http://www.apache.org/licenses/LICENSE-2.0
+//
+// Unless required by applicable law or agreed to in writing, software
+// distributed under the License is distributed on an "AS IS" BASIS,
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+// See the License for the specific language governing permissions and
+// limitations under the License.
+
+package org.spearce.jgit.treewalk.filter;
+
+import java.io.IOException;
+import java.util.LinkedList;
+import java.util.List;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.RepositoryTestCase;
+import org.spearce.jgit.treewalk.TreeWalk;
+
+public class PathSuffixFilterTestCase extends RepositoryTestCase {
+
+	public void testNonRecursiveFiltering() throws IOException {
+		final ObjectWriter ow = new ObjectWriter(db);
+		final ObjectId aSth = ow.writeBlob("a.sth".getBytes());
+		final ObjectId aTxt = ow.writeBlob("a.txt".getBytes());
+		final DirCache dc = DirCache.read(db);
+		final DirCacheBuilder builder = dc.builder();
+		final DirCacheEntry aSthEntry = new DirCacheEntry("a.sth");
+		aSthEntry.setFileMode(FileMode.REGULAR_FILE);
+		aSthEntry.setObjectId(aSth);
+		final DirCacheEntry aTxtEntry = new DirCacheEntry("a.txt");
+		aTxtEntry.setFileMode(FileMode.REGULAR_FILE);
+		aTxtEntry.setObjectId(aTxt);
+		builder.add(aSthEntry);
+		builder.add(aTxtEntry);
+		builder.finish();
+		final ObjectId treeId = dc.writeTree(ow);
+
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.setFilter(PathSuffixFilter.create(".txt"));
+		tw.addTree(treeId);
+
+		List<String> paths = new LinkedList<String>();
+		while (tw.next()) {
+			paths.add(tw.getPathString());
+		}
+
+		List<String> expected =  new LinkedList<String>();
+		expected.add("a.txt");
+
+		assertEquals(expected, paths);
+	}
+
+	public void testRecursiveFiltering() throws IOException {
+		final ObjectWriter ow = new ObjectWriter(db);
+		final ObjectId aSth = ow.writeBlob("a.sth".getBytes());
+		final ObjectId aTxt = ow.writeBlob("a.txt".getBytes());
+		final ObjectId bSth = ow.writeBlob("b.sth".getBytes());
+		final ObjectId bTxt = ow.writeBlob("b.txt".getBytes());
+		final DirCache dc = DirCache.read(db);
+		final DirCacheBuilder builder = dc.builder();
+		final DirCacheEntry aSthEntry = new DirCacheEntry("a.sth");
+		aSthEntry.setFileMode(FileMode.REGULAR_FILE);
+		aSthEntry.setObjectId(aSth);
+		final DirCacheEntry aTxtEntry = new DirCacheEntry("a.txt");
+		aTxtEntry.setFileMode(FileMode.REGULAR_FILE);
+		aTxtEntry.setObjectId(aTxt);
+		builder.add(aSthEntry);
+		builder.add(aTxtEntry);
+		final DirCacheEntry bSthEntry = new DirCacheEntry("sub/b.sth");
+		bSthEntry.setFileMode(FileMode.REGULAR_FILE);
+		bSthEntry.setObjectId(bSth);
+		final DirCacheEntry bTxtEntry = new DirCacheEntry("sub/b.txt");
+		bTxtEntry.setFileMode(FileMode.REGULAR_FILE);
+		bTxtEntry.setObjectId(bTxt);
+		builder.add(bSthEntry);
+		builder.add(bTxtEntry);
+		builder.finish();
+		final ObjectId treeId = dc.writeTree(ow);
+
+
+		final TreeWalk tw = new TreeWalk(db);
+		tw.setRecursive(true);
+		tw.setFilter(PathSuffixFilter.create(".txt"));
+		tw.addTree(treeId);
+
+		List<String> paths = new LinkedList<String>();
+		while (tw.next()) {
+			paths.add(tw.getPathString());
+		}
+
+		List<String> expected =  new LinkedList<String>();
+		expected.add("a.txt");
+		expected.add("sub/b.txt");
+
+		assertEquals(expected, paths);
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 5705936..ad19093 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -739,6 +739,39 @@ public int isPathPrefix(final byte[] p, final int pLen) {
 	}
 
 	/**
+	 * Test if the supplied path matches (being suffix of) the current entry's
+	 * path.
+	 * <p>
+	 * This method tests that the supplied path is exactly equal to the current
+	 * entry, or is relative to one of entry's parent directories. It is faster
+	 * to use this method then to use {@link #getPathString()} to first create
+	 * a String object, then test <code>endsWith</code> or some other type of
+	 * string match function.
+	 *
+	 * @param p
+	 *            path buffer to test. Callers should ensure the path does not
+	 *            start with '/' prior to invocation.
+	 * @param pLen
+	 *            number of bytes from <code>buf</code> to test.
+	 * @return true if p is suffix of the current path;
+	 *         false if otherwise
+	 *
+	 */
+	public boolean isPathSuffix(final byte[] p, final int pLen) {
+		final AbstractTreeIterator t = currentHead;
+		final byte[] c = t.path;
+		final int cLen = t.pathLen;
+		int ci;
+
+		for (ci = 1; ci < cLen && ci < pLen; ci++) {
+			if (c[cLen-ci] != p[pLen-ci])
+				return false;
+		}
+
+		return true;
+	}
+
+	/**
 	 * Get the current subtree depth of this walker.
 	 *
 	 * @return the current subtree depth of this walker.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathSuffixFilter.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathSuffixFilter.java
new file mode 100644
index 0000000..b5b2461
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathSuffixFilter.java
@@ -0,0 +1,74 @@
+// Copyright (C) 2009 The Android Open Source Project
+//
+// Licensed under the Apache License, Version 2.0 (the "License");
+// you may not use this file except in compliance with the License.
+// You may obtain a copy of the License at
+//
+// http://www.apache.org/licenses/LICENSE-2.0
+//
+// Unless required by applicable law or agreed to in writing, software
+// distributed under the License is distributed on an "AS IS" BASIS,
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+// See the License for the specific language governing permissions and
+// limitations under the License.
+
+package org.spearce.jgit.treewalk.filter;
+
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.treewalk.TreeWalk;
+
+/**
+ * Includes tree entries only if they match the configured path.
+ */
+public class PathSuffixFilter extends TreeFilter {
+
+	/**
+	 * Create a new tree filter for a user supplied path.
+	 * <p>
+	 * Path strings use '/' to delimit directories on all platforms.
+	 *
+	 * @param path
+	 *            the path (suffix) to filter on. Must not be the empty string.
+	 * @return a new filter for the requested path.
+	 * @throws IllegalArgumentException
+	 *             the path supplied was the empty string.
+	 */
+	public static PathSuffixFilter create(String path) {
+		if (path.length() == 0)
+			throw new IllegalArgumentException("Empty path not permitted.");
+		return new PathSuffixFilter(path);
+	}
+
+	final String pathStr;
+	final byte[] pathRaw;
+
+	private PathSuffixFilter(final String s) {
+		pathStr = s;
+		pathRaw = Constants.encode(pathStr);
+	}
+
+	@Override
+	public TreeFilter clone() {
+		return this;
+	}
+
+	@Override
+	public boolean include(TreeWalk walker) throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		if (walker.isSubtree())
+			return true;
+		else
+			return walker.isPathSuffix(pathRaw, pathRaw.length);
+
+	}
+
+	@Override
+	public boolean shouldBeRecursive() {
+		return true;
+	}
+
+}
-- 
1.6.3.3
