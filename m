From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 8/8] Define a basic merge API, and a two-way tree merge strategy
Date: Mon, 13 Oct 2008 14:10:17 -0700
Message-ID: <1223932217-4771-9-git-send-email-spearce@spearce.org>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org>
 <1223932217-4771-2-git-send-email-spearce@spearce.org>
 <1223932217-4771-3-git-send-email-spearce@spearce.org>
 <1223932217-4771-4-git-send-email-spearce@spearce.org>
 <1223932217-4771-5-git-send-email-spearce@spearce.org>
 <1223932217-4771-6-git-send-email-spearce@spearce.org>
 <1223932217-4771-7-git-send-email-spearce@spearce.org>
 <1223932217-4771-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:12:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUiF-0002Kl-Pf
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609AbYJMVKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756570AbYJMVKg
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:10:36 -0400
Received: from george.spearce.org ([209.20.77.23]:39787 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209AbYJMVKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:10:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2E523383A3; Mon, 13 Oct 2008 21:10:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1BD013835F;
	Mon, 13 Oct 2008 21:10:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
In-Reply-To: <1223932217-4771-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98154>

This basic merge implementation is sufficient to merge two commits in
memory and write the result out as a new commit, without having a work
tree on the local filesystem.  It is therefore suitable for use within
a batch server process where human intervention is not available to
resolve conflicts.

This API should permit extending it with the working tree and a copy
of the work tree's DirCache, so edits in the tree can be merged in
parallel with edits from commits.  But the functionality is not yet
implemented, so it is still a pie-in-the-sky concept.

The main strategy "simple-two-way-in-core" provides a basic 3 way
merge on the path level only.  File contents are never patched by
this strategy, making it somewhat safe for automatic merges.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/merge/MergeStrategy.java  |  134 +++++++++++++
 .../src/org/spearce/jgit/merge/Merger.java         |  207 ++++++++++++++++++++
 .../org/spearce/jgit/merge/StrategyOneSided.java   |   98 +++++++++
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |  179 +++++++++++++++++
 4 files changed, 618 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java b/org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java
new file mode 100644
index 0000000..d28dcc1
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/MergeStrategy.java
@@ -0,0 +1,134 @@
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
+package org.spearce.jgit.merge;
+
+import java.util.HashMap;
+
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * A method of combining two or more trees together to form an output tree.
+ * <p>
+ * Different strategies may employ different techniques for deciding which paths
+ * (and ObjectIds) to carry from the input trees into the final output tree.
+ */
+public abstract class MergeStrategy {
+	/** Simple strategy that sets the output tree to the first input tree. */
+	public static final MergeStrategy OURS = new StrategyOneSided("ours", 0);
+
+	/** Simple strategy that sets the output tree to the second input tree. */
+	public static final MergeStrategy THEIRS = new StrategyOneSided("theirs", 1);
+
+	/** Simple strategy to merge paths, without simultaneous edits. */
+	public static final MergeStrategy SIMPLE_TWO_WAY_IN_CORE = StrategySimpleTwoWayInCore.INSTANCE;
+
+	private static final HashMap<String, MergeStrategy> STRATEGIES = new HashMap<String, MergeStrategy>();
+
+	static {
+		register(OURS);
+		register(THEIRS);
+		register(SIMPLE_TWO_WAY_IN_CORE);
+	}
+
+	/**
+	 * Register a merge strategy so it can later be obtained by name.
+	 * 
+	 * @param imp
+	 *            the strategy to register.
+	 * @throws IllegalArgumentException
+	 *             a strategy by the same name has already been registered.
+	 */
+	public static void register(final MergeStrategy imp) {
+		register(imp.getName(), imp);
+	}
+
+	/**
+	 * Register a merge strategy so it can later be obtained by name.
+	 * 
+	 * @param name
+	 *            name the strategy can be looked up under.
+	 * @param imp
+	 *            the strategy to register.
+	 * @throws IllegalArgumentException
+	 *             a strategy by the same name has already been registered.
+	 */
+	public static synchronized void register(final String name,
+			final MergeStrategy imp) {
+		if (STRATEGIES.containsKey(name))
+			throw new IllegalArgumentException("Merge strategy \"" + name
+					+ "\" already exists as a default strategy");
+		STRATEGIES.put(name, imp);
+	}
+
+	/**
+	 * Locate a strategy by name.
+	 * 
+	 * @param name
+	 *            name of the strategy to locate.
+	 * @return the strategy instance; null if no strategy matches the name.
+	 */
+	public static synchronized MergeStrategy get(final String name) {
+		return STRATEGIES.get(name);
+	}
+
+	/**
+	 * Get all registered strategies.
+	 * 
+	 * @return the registered strategy instances. No inherit order is returned;
+	 *         the caller may modify (and/or sort) the returned array if
+	 *         necessary to obtain a reasonable ordering.
+	 */
+	public static synchronized MergeStrategy[] get() {
+		final MergeStrategy[] r = new MergeStrategy[STRATEGIES.size()];
+		STRATEGIES.values().toArray(r);
+		return r;
+	}
+
+	/** @return default name of this strategy implementation. */
+	public abstract String getName();
+
+	/**
+	 * Create a new merge instance.
+	 * 
+	 * @param db
+	 *            repository database the merger will read from, and eventually
+	 *            write results back to.
+	 * @return the new merge instance which implements this strategy.
+	 */
+	public abstract Merger newMerger(Repository db);
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java b/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
new file mode 100644
index 0000000..fb8d7b2
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/Merger.java
@@ -0,0 +1,207 @@
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
+package org.spearce.jgit.merge;
+
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectWriter;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevTree;
+import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.revwalk.filter.RevFilter;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+import org.spearce.jgit.treewalk.CanonicalTreeParser;
+import org.spearce.jgit.treewalk.EmptyTreeIterator;
+
+/**
+ * Instance of a specific {@link MergeStrategy} for a single {@link Repository}.
+ */
+public abstract class Merger {
+	/** The repository this merger operates on. */
+	protected final Repository db;
+
+	/** A RevWalk for computing merge bases, or listing incoming commits. */
+	protected final RevWalk walk;
+
+	private ObjectWriter writer;
+
+	/** The original objects supplied in the merge; this can be any tree-ish. */
+	protected RevObject[] sourceObjects;
+
+	/** If {@link #sourceObjects}[i] is a commit, this is the commit. */
+	protected RevCommit[] sourceCommits;
+
+	/** The trees matching every entry in {@link #sourceObjects}. */
+	protected RevTree[] sourceTrees;
+
+	/**
+	 * Create a new merge instance for a repository.
+	 * 
+	 * @param local
+	 *            the repository this merger will read and write data on.
+	 */
+	protected Merger(final Repository local) {
+		db = local;
+		walk = new RevWalk(db);
+	}
+
+	/**
+	 * @return the repository this merger operates on.
+	 */
+	public Repository getRepository() {
+		return db;
+	}
+
+	/**
+	 * @return an object writer to create objects in {@link #getRepository()}.
+	 */
+	public ObjectWriter getObjectWriter() {
+		if (writer == null)
+			writer = new ObjectWriter(getRepository());
+		return writer;
+	}
+
+	/**
+	 * Merge together two or more tree-ish objects.
+	 * <p>
+	 * Any tree-ish may be supplied as inputs. Commits and/or tags pointing at
+	 * trees or commits may be passed as input objects.
+	 * 
+	 * @param tips
+	 *            source trees to be combined together. The merge base is not
+	 *            included in this set.
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
+	public final boolean merge(final AnyObjectId[] tips) throws IOException {
+		sourceObjects = new RevObject[tips.length];
+		for (int i = 0; i < tips.length; i++)
+			sourceObjects[i] = walk.parseAny(tips[i]);
+
+		sourceCommits = new RevCommit[sourceObjects.length];
+		for (int i = 0; i < sourceObjects.length; i++) {
+			try {
+				sourceCommits[i] = walk.parseCommit(sourceObjects[i]);
+			} catch (IncorrectObjectTypeException err) {
+				sourceCommits[i] = null;
+			}
+		}
+
+		sourceTrees = new RevTree[sourceObjects.length];
+		for (int i = 0; i < sourceObjects.length; i++)
+			sourceTrees[i] = walk.parseTree(sourceObjects[i]);
+
+		return mergeImpl();
+	}
+
+	/**
+	 * Create an iterator to walk the merge base of two commits.
+	 * 
+	 * @param aIdx
+	 *            index of the first commit in {@link #sourceObjects}.
+	 * @param bIdx
+	 *            index of the second commit in {@link #sourceObjects}.
+	 * @return the new iterator
+	 * @throws IncorrectObjectTypeException
+	 *             one of the input objects is not a commit.
+	 * @throws IOException
+	 *             objects are missing or multiple merge bases were found.
+	 */
+	protected AbstractTreeIterator mergeBase(final int aIdx, final int bIdx)
+			throws IOException {
+		if (sourceCommits[aIdx] == null)
+			throw new IncorrectObjectTypeException(sourceObjects[aIdx],
+					Constants.TYPE_COMMIT);
+		if (sourceCommits[bIdx] == null)
+			throw new IncorrectObjectTypeException(sourceObjects[bIdx],
+					Constants.TYPE_COMMIT);
+
+		walk.reset();
+		walk.setRevFilter(RevFilter.MERGE_BASE);
+		walk.markStart(sourceCommits[aIdx]);
+		walk.markStart(sourceCommits[bIdx]);
+		final RevCommit base = walk.next();
+		if (base == null)
+			return new EmptyTreeIterator();
+		final RevCommit base2 = walk.next();
+		if (base2 != null) {
+			throw new IOException("Multiple merge bases for:" + "\n  "
+					+ sourceCommits[aIdx].name() + "\n  "
+					+ sourceCommits[bIdx].name() + "found:" + "\n  "
+					+ base.name() + "\n  " + base2.name());
+		}
+		return new CanonicalTreeParser(null, db, base.getTree());
+	}
+
+	/**
+	 * Execute the merge.
+	 * <p>
+	 * This method is called from {@link #merge(AnyObjectId[])} after the
+	 * {@link #sourceObjects}, {@link #sourceCommits} and {@link #sourceTrees}
+	 * have been populated.
+	 * 
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
+	protected abstract boolean mergeImpl() throws IOException;
+
+	/**
+	 * @return resulting tree, if {@link #merge(AnyObjectId[])} returned true.
+	 */
+	public abstract ObjectId getResultTreeId();
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java
new file mode 100644
index 0000000..0c3dcc2
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategyOneSided.java
@@ -0,0 +1,98 @@
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
+package org.spearce.jgit.merge;
+
+import java.io.IOException;
+
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * Trivial merge strategy to make the resulting tree exactly match an input.
+ * <p>
+ * This strategy can be used to cauterize an entire side branch of history, by
+ * setting the output tree to one of the inputs, and ignoring any of the paths
+ * of the other inputs.
+ */
+public class StrategyOneSided extends MergeStrategy {
+	private final String strategyName;
+
+	private final int treeIndex;
+
+	/**
+	 * Create a new merge strategy to select a specific input tree.
+	 * 
+	 * @param name
+	 *            name of this strategy.
+	 * @param index
+	 *            the position of the input tree to accept as the result.
+	 */
+	protected StrategyOneSided(final String name, final int index) {
+		strategyName = name;
+		treeIndex = index;
+	}
+
+	@Override
+	public String getName() {
+		return strategyName;
+	}
+
+	@Override
+	public Merger newMerger(final Repository db) {
+		return new OneSide(db, treeIndex);
+	}
+
+	protected static class OneSide extends Merger {
+		private final int treeIndex;
+
+		protected OneSide(final Repository local, final int index) {
+			super(local);
+			treeIndex = index;
+		}
+
+		@Override
+		protected boolean mergeImpl() throws IOException {
+			return treeIndex < sourceTrees.length;
+		}
+
+		@Override
+		public ObjectId getResultTreeId() {
+			return sourceTrees[treeIndex];
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
new file mode 100644
index 0000000..893add9
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
@@ -0,0 +1,179 @@
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
+package org.spearce.jgit.merge;
+
+import java.io.IOException;
+
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.errors.UnmergedPathException;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+import org.spearce.jgit.treewalk.NameConflictTreeWalk;
+
+/**
+ * Merges two commits together in-memory, ignoring any working directory.
+ * <p>
+ * The strategy chooses a path from one of the two input trees if the path is
+ * unchanged in the other relative to their common merge base tree. This is a
+ * trivial 3-way merge (at the file path level only).
+ * <p>
+ * Modifications of the same file path (content and/or file mode) by both input
+ * trees will cause a merge conflict, as this strategy does not attempt to merge
+ * file contents.
+ */
+public class StrategySimpleTwoWayInCore extends MergeStrategy {
+	static final MergeStrategy INSTANCE = new StrategySimpleTwoWayInCore();
+
+	/** Create a new instance of the strategy. */
+	protected StrategySimpleTwoWayInCore() {
+		//
+	}
+
+	@Override
+	public String getName() {
+		return "simple-two-way-in-core";
+	}
+
+	@Override
+	public Merger newMerger(final Repository db) {
+		return new InCoreMerger(db);
+	}
+
+	private static class InCoreMerger extends Merger {
+		private static final int T_BASE = 0;
+
+		private static final int T_OURS = 1;
+
+		private static final int T_THEIRS = 2;
+
+		private final NameConflictTreeWalk tw;
+
+		private final DirCache cache;
+
+		private DirCacheBuilder builder;
+
+		private ObjectId resultTree;
+
+		InCoreMerger(final Repository local) {
+			super(local);
+			tw = new NameConflictTreeWalk(db);
+			cache = DirCache.newInCore();
+		}
+
+		@Override
+		protected boolean mergeImpl() throws IOException {
+			if (sourceTrees.length != 2)
+				return false;
+
+			tw.reset();
+			tw.addTree(mergeBase(0, 1));
+			tw.addTree(sourceTrees[0]);
+			tw.addTree(sourceTrees[1]);
+
+			boolean hasConflict = false;
+			builder = cache.builder();
+			while (tw.next()) {
+				final int modeO = tw.getRawMode(T_OURS);
+				final int modeT = tw.getRawMode(T_THEIRS);
+				if (modeO == modeT && tw.idEqual(T_OURS, T_THEIRS)) {
+					same();
+					continue;
+				}
+
+				final int modeB = tw.getRawMode(T_BASE);
+				if (modeB == modeO && tw.idEqual(T_BASE, T_OURS))
+					add(T_THEIRS, DirCacheEntry.STAGE_0);
+				else if (modeB == modeT && tw.idEqual(T_BASE, T_THEIRS))
+					add(T_OURS, DirCacheEntry.STAGE_0);
+				else {
+					conflict();
+					hasConflict = true;
+				}
+			}
+			builder.finish();
+			builder = null;
+
+			if (hasConflict)
+				return false;
+			try {
+				resultTree = cache.writeTree(getObjectWriter());
+				return true;
+			} catch (UnmergedPathException upe) {
+				resultTree = null;
+				return false;
+			}
+		}
+
+		private void same() throws IOException {
+			if (tw.isSubtree())
+				builder.addTree(tw.getRawPath(), db, tw.getObjectId(1));
+			else
+				add(T_OURS, DirCacheEntry.STAGE_0);
+		}
+
+		private void conflict() {
+			add(T_BASE, DirCacheEntry.STAGE_1);
+			add(T_OURS, DirCacheEntry.STAGE_2);
+			add(T_THEIRS, DirCacheEntry.STAGE_3);
+		}
+
+		private void add(final int tree, final int stage) {
+			final AbstractTreeIterator i = getTree(tree);
+			if (i != null) {
+				final DirCacheEntry e;
+
+				e = new DirCacheEntry(tw.getRawPath(), stage);
+				e.setObjectIdFromRaw(i.idBuffer(), i.idOffset());
+				e.setFileMode(tw.getFileMode(tree));
+				builder.add(e);
+			}
+		}
+
+		private AbstractTreeIterator getTree(final int tree) {
+			return tw.getTree(tree, AbstractTreeIterator.class);
+		}
+
+		@Override
+		public ObjectId getResultTreeId() {
+			return resultTree;
+		}
+	}
+}
-- 
1.6.0.2.706.g340fc
