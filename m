From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: [JGIT PATCH] Add PathSuffixFilter class which is TreeFilter.
Date: Tue, 11 Aug 2009 18:16:09 -0700
Message-ID: <1250039769-1331-1-git-send-email-grek@tuffmail.com>
Cc: Grzegorz Kossakowski <grek@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 03:16:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb2S8-0006ms-Ur
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 03:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbZHLBQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 21:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbZHLBQU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 21:16:20 -0400
Received: from smtp-out.google.com ([216.239.45.13]:62689 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbZHLBQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 21:16:20 -0400
Received: from spaceape8.eur.corp.google.com (spaceape8.eur.corp.google.com [172.28.16.142])
	by smtp-out.google.com with ESMTP id n7C1GJwx028220
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 18:16:20 -0700
Received: from localhost (glacegreek.mtv.corp.google.com [172.18.102.106])
	by spaceape8.eur.corp.google.com with ESMTP id n7C1GFjT027065;
	Tue, 11 Aug 2009 18:16:16 -0700
Received: by localhost (Postfix, from userid 97043)
	id 7349A7AAD3; Tue, 11 Aug 2009 18:16:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125639>

From: Grzegorz Kossakowski <grek@google.com>

Added a simple TreeFilter that filters all entries that have path with
given suffix. This filter is always recursive.

Signed-off-by: Grzegorz Kossakowski <grek@google.com>
---
 .../treewalk/filter/PathSuffixFilterTestCase.java  |  133 ++++++++++++++++++++
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   32 +++++
 .../jgit/treewalk/filter/PathSuffixFilter.java     |   97 ++++++++++++++
 3 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathSuffixFilter.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
new file mode 100644
index 0000000..5240ed9
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/filter/PathSuffixFilterTestCase.java
@@ -0,0 +1,133 @@
+/*
+ * 2009 Copyright Google, Inc.
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
index 5705936..16088b4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -739,6 +739,38 @@ public int isPathPrefix(final byte[] p, final int pLen) {
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
+	 *            path buffer to test.
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
index 0000000..8777e7d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathSuffixFilter.java
@@ -0,0 +1,97 @@
+/*
+ * 2009 Copyright Google, Inc.
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
