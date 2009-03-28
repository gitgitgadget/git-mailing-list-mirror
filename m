From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Introduce ThreeWayMerge API
Date: Fri, 27 Mar 2009 19:53:51 -0700
Message-ID: <1238208832-29427-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 03:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnOiL-0005sK-GK
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 03:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760530AbZC1Cx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 22:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758244AbZC1Cx5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 22:53:57 -0400
Received: from george.spearce.org ([209.20.77.23]:55148 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266AbZC1Cxz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 22:53:55 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B12403821F; Sat, 28 Mar 2009 02:53:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C5FF3381D2;
	Sat, 28 Mar 2009 02:53:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.471.g682837
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114934>

A 3-way merge (2 trees, and one common ancestor) is a specialized
type of merge which has a tighter restriction on its inputs.  This
change refactors the merge API slightly to introduce this special
type, so we can add 3-way specific operations on the API.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is a quick two patch series to teach JGit enough to enable an
 application to perform simple cherry-picks, much like we already
 support doing simple merges.

 I'm already using it in Gerrit Code Review to enable projects to
 have a more "format-patch | am" style workflow over a "push; pull"
 style of workflow, if they choose to do that.


 .../src/org/spearce/jgit/merge/MergeStrategy.java  |    2 +-
 .../src/org/spearce/jgit/merge/Merger.java         |    2 +-
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |   11 +--
 .../spearce/jgit/merge/ThreeWayMergeStrategy.java  |   46 ++++++++++
 .../src/org/spearce/jgit/merge/ThreeWayMerger.java |   89 ++++++++++++++++++++
 5 files changed, 141 insertions(+), 9 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMergeStrategy.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMerger.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java b/org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java
index 66bd86c..5439e5c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java
@@ -55,7 +55,7 @@
 	public static final MergeStrategy THEIRS = new StrategyOneSided("theirs", 1);
 
 	/** Simple strategy to merge paths, without simultaneous edits. */
-	public static final MergeStrategy SIMPLE_TWO_WAY_IN_CORE = StrategySimpleTwoWayInCore.INSTANCE;
+	public static final ThreeWayMergeStrategy SIMPLE_TWO_WAY_IN_CORE = StrategySimpleTwoWayInCore.INSTANCE;
 
 	private static final HashMap<String, MergeStrategy> STRATEGIES = new HashMap<String, MergeStrategy>();
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java b/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
index 100cc38..db3e329 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
@@ -122,7 +122,7 @@ public ObjectWriter getObjectWriter() {
 	 *             one or more sources could not be read, or outputs could not
 	 *             be written to the Repository.
 	 */
-	public final boolean merge(final AnyObjectId[] tips) throws IOException {
+	public boolean merge(final AnyObjectId[] tips) throws IOException {
 		sourceObjects = new RevObject[tips.length];
 		for (int i = 0; i < tips.length; i++)
 			sourceObjects[i] = walk.parseAny(tips[i]);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
index 3ebe397..9807644 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
@@ -60,8 +60,8 @@
  * trees will cause a merge conflict, as this strategy does not attempt to merge
  * file contents.
  */
-public class StrategySimpleTwoWayInCore extends MergeStrategy {
-	static final MergeStrategy INSTANCE = new StrategySimpleTwoWayInCore();
+public class StrategySimpleTwoWayInCore extends ThreeWayMergeStrategy {
+	static final ThreeWayMergeStrategy INSTANCE = new StrategySimpleTwoWayInCore();
 
 	/** Create a new instance of the strategy. */
 	protected StrategySimpleTwoWayInCore() {
@@ -74,11 +74,11 @@ public String getName() {
 	}
 
 	@Override
-	public Merger newMerger(final Repository db) {
+	public ThreeWayMerger newMerger(final Repository db) {
 		return new InCoreMerger(db);
 	}
 
-	private static class InCoreMerger extends Merger {
+	private static class InCoreMerger extends ThreeWayMerger {
 		private static final int T_BASE = 0;
 
 		private static final int T_OURS = 1;
@@ -101,9 +101,6 @@ InCoreMerger(final Repository local) {
 
 		@Override
 		protected boolean mergeImpl() throws IOException {
-			if (sourceTrees.length != 2)
-				return false;
-
 			tw.reset();
 			tw.addTree(mergeBase(0, 1));
 			tw.addTree(sourceTrees[0]);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMergeStrategy.java b/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMergeStrategy.java
new file mode 100644
index 0000000..848e80b
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMergeStrategy.java
@@ -0,0 +1,46 @@
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
+package org.spearce.jgit.merge;
+
+import org.spearce.jgit.lib.Repository;
+
+/** A merge strategy to merge 2 trees, using a common base ancestor tree. */
+public abstract class ThreeWayMergeStrategy extends MergeStrategy {
+	@Override
+	public abstract ThreeWayMerger newMerger(Repository db);
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMerger.java b/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMerger.java
new file mode 100644
index 0000000..9d1621d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/ThreeWayMerger.java
@@ -0,0 +1,89 @@
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
+package org.spearce.jgit.merge;
+
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Repository;
+
+/** A merge of 2 trees, using a common base ancestor tree. */
+public abstract class ThreeWayMerger extends Merger {
+	/**
+	 * Create a new merge instance for a repository.
+	 * 
+	 * @param local
+	 *            the repository this merger will read and write data on.
+	 */
+	protected ThreeWayMerger(final Repository local) {
+		super(local);
+	}
+
+	/**
+	 * Merge together two tree-ish objects.
+	 * <p>
+	 * Any tree-ish may be supplied as inputs. Commits and/or tags pointing at
+	 * trees or commits may be passed as input objects.
+	 * 
+	 * @param a
+	 *            source tree to be combined together.
+	 * @param b
+	 *            source tree to be combined together.
+	 * @return true if the merge was completed without conflicts; false if the
+	 *         merge strategy cannot handle this merge or there were conflicts
+	 *         preventing it from automatically resolving all paths.
+	 * @throws IncorrectObjectTypeException
+	 *             one of the input objects is not a commit, but the strategy
+	 *             requires it to be a commit.
+	 * @throws IOException
+	 *             one or more sources could not be read, or outputs could not
+	 *             be written to the Repository.
+	 */
+	public boolean merge(final AnyObjectId a, final AnyObjectId b)
+			throws IOException {
+		return merge(new AnyObjectId[] { a, b });
+	}
+
+	@Override
+	public boolean merge(final AnyObjectId[] tips) throws IOException {
+		if (tips.length != 2)
+			return false;
+		return super.merge(tips);
+	}
+}
-- 
1.6.2.1.471.g682837
