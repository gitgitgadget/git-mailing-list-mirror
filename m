From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Change RevObject dispose() semantics to avoid reparses
Date: Fri, 12 Jun 2009 16:00:18 -0700
Message-ID: <1244847619-7364-5-git-send-email-spearce@spearce.org>
References: <1244847619-7364-1-git-send-email-spearce@spearce.org>
 <1244847619-7364-2-git-send-email-spearce@spearce.org>
 <1244847619-7364-3-git-send-email-spearce@spearce.org>
 <1244847619-7364-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:00:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFjn-000336-Ep
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbZFLXAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700AbZFLXAc
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:00:32 -0400
Received: from george.spearce.org ([209.20.77.23]:40056 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbZFLXA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:00:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B438D381FD; Fri, 12 Jun 2009 23:00:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D701638200;
	Fri, 12 Jun 2009 23:00:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <1244847619-7364-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121464>

UploadPack was suffering from performance problems because dispose()
was unsetting the PARSED flag, causing another visit to a commit to
reparse the object from disk, even though we already had its parents
in memory.  If a client was 50,000 commits ahead of the server,
then the client could send 50,000 have requests, each time the
server is executing a full reparse of its own commit graph trying
to determine if the common set is sufficient yet.

Instead of asking applications to dispose of commit buffers when the
commit is popped out of the RevWalk we now dispose of the buffer as
soon as the headers are parsed.  For applications that never need
the buffer but have to process a lot of commits in the pending queue,
this can reduce memory usage by a fair amount, as the pending queue
no longer has to retain the buffers until the commits are returned
to the application for buffer disposal.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |    2 +-
 .../src/org/spearce/jgit/lib/PackWriter.java       |    3 +-
 .../spearce/jgit/revwalk/BoundaryGenerator.java    |    2 +-
 .../spearce/jgit/revwalk/MergeBaseGenerator.java   |    2 +-
 .../src/org/spearce/jgit/revwalk/ObjectWalk.java   |    4 +-
 .../org/spearce/jgit/revwalk/PendingGenerator.java |    6 +-
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |   18 ++++-
 .../src/org/spearce/jgit/revwalk/RevObject.java    |   13 ++--
 .../src/org/spearce/jgit/revwalk/RevTag.java       |   19 ++++-
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   72 ++++++++++++++++----
 .../spearce/jgit/revwalk/RewriteTreeFilter.java    |    2 +-
 .../src/org/spearce/jgit/transport/UploadPack.java |    4 +-
 .../jgit/transport/WalkFetchConnection.java        |   15 +---
 13 files changed, 111 insertions(+), 51 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
index 0a1e7b8..befc3d5 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
@@ -160,7 +160,7 @@ protected RevTag tag(final String name, final RevObject dst)
 	}
 
 	protected <T extends RevObject> T parse(final T t) throws Exception {
-		rw.parse(t);
+		rw.parseBody(t);
 		return t;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index a35f61d..e25fe8f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -820,6 +820,7 @@ private ObjectWalk setUpWalker(
 			throws MissingObjectException, IOException,
 			IncorrectObjectTypeException {
 		final ObjectWalk walker = new ObjectWalk(db);
+		walker.setRetainBody(false);
 		walker.sort(RevSort.TOPO);
 		walker.sort(RevSort.COMMIT_TIME_DESC, true);
 		if (thin)
@@ -854,12 +855,10 @@ private void findObjectsToPack(final ObjectWalk walker)
 
 		while ((o = walker.next()) != null) {
 			addObject(o);
-			o.dispose();
 			initMonitor.update(1);
 		}
 		while ((o = walker.nextObject()) != null) {
 			addObject(o);
-			o.dispose();
 			initMonitor.update(1);
 		}
 		initMonitor.endTask();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/BoundaryGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/BoundaryGenerator.java
index f167830..6e3d6cf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/BoundaryGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/BoundaryGenerator.java
@@ -115,7 +115,7 @@ RevCommit next() throws MissingObjectException,
 				if ((c.flags & DUPLICATE) != 0)
 					continue;
 				if ((c.flags & PARSED) == 0)
-					c.parse(walk);
+					c.parseHeaders(walk);
 				c.flags |= DUPLICATE;
 				boundary.add(c);
 			}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
index 8694e4c..afe3dfe 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/MergeBaseGenerator.java
@@ -137,7 +137,7 @@ RevCommit next() throws MissingObjectException,
 				if ((p.flags & IN_PENDING) != 0)
 					continue;
 				if ((p.flags & PARSED) == 0)
-					p.parse(walker);
+					p.parseHeaders(walker);
 				p.flags |= IN_PENDING;
 				pending.add(p);
 			}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
index 484d104..b2329cf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/ObjectWalk.java
@@ -134,7 +134,7 @@ public void markStart(RevObject o) throws MissingObjectException,
 		while (o instanceof RevTag) {
 			addObject(o);
 			o = ((RevTag) o).getObject();
-			parse(o);
+			parseHeaders(o);
 		}
 
 		if (o instanceof RevCommit)
@@ -186,7 +186,7 @@ public void markUninteresting(RevObject o) throws MissingObjectException,
 			if (hasRevSort(RevSort.BOUNDARY))
 				addObject(o);
 			o = ((RevTag) o).getObject();
-			parse(o);
+			parseHeaders(o);
 		}
 
 		if (o instanceof RevCommit)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
index 8e3d6bc..0b97f92 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/PendingGenerator.java
@@ -135,7 +135,7 @@ RevCommit next() throws MissingObjectException,
 					if ((p.flags & SEEN) != 0)
 						continue;
 					if ((p.flags & PARSED) == 0)
-						p.parse(walker);
+						p.parseHeaders(walker);
 					p.flags |= SEEN;
 					pending.add(p);
 				}
@@ -157,14 +157,14 @@ RevCommit next() throws MissingObjectException,
 						overScan = OVER_SCAN;
 					}
 					if (canDispose)
-						c.dispose();
+						c.disposeBody();
 					continue;
 				}
 
 				if (produce)
 					return last = c;
 				else if (canDispose)
-					c.dispose();
+					c.disposeBody();
 			}
 		} catch (StopWalkException swe) {
 			walker.curs.release();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 679718e..f211dfd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -74,11 +74,21 @@ protected RevCommit(final AnyObjectId id) {
 	}
 
 	@Override
-	void parse(final RevWalk walk) throws MissingObjectException,
+	void parseHeaders(final RevWalk walk) throws MissingObjectException,
 			IncorrectObjectTypeException, IOException {
 		parseCanonical(walk, loadCanonical(walk));
 	}
 
+	@Override
+	void parseBody(final RevWalk walk) throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		if (buffer == null) {
+			buffer = loadCanonical(walk);
+			if ((flags & PARSED) == 0)
+				parseCanonical(walk, buffer);
+		}
+	}
+
 	void parseCanonical(final RevWalk walk, final byte[] raw) {
 		final MutableObjectId idBuffer = walk.idBuffer;
 		idBuffer.fromString(raw, 5);
@@ -125,7 +135,8 @@ else if (nParents == 1) {
 			commitTime = RawParseUtils.parseBase10(raw, ptr, null);
 		}
 
-		buffer = raw;
+		if (walk.isRetainBody())
+			buffer = raw;
 		flags |= PARSED;
 	}
 	
@@ -375,8 +386,7 @@ public void reset() {
 		inDegree = 0;
 	}
 
-	public void dispose() {
-		flags &= ~PARSED;
+	final void disposeBody() {
 		buffer = null;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
index 0e0386c..024e9ec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevObject.java
@@ -57,12 +57,18 @@ RevObject(final AnyObjectId name) {
 		super(name);
 	}
 
-	void parse(final RevWalk walk) throws MissingObjectException,
+	void parseHeaders(final RevWalk walk) throws MissingObjectException,
 			IncorrectObjectTypeException, IOException {
 		loadCanonical(walk);
 		flags |= PARSED;
 	}
 
+	void parseBody(final RevWalk walk) throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		if ((flags & PARSED) == 0)
+			parseHeaders(walk);
+	}
+
 	final byte[] loadCanonical(final RevWalk walk) throws IOException,
 			MissingObjectException, IncorrectObjectTypeException,
 			CorruptObjectException {
@@ -180,11 +186,6 @@ public final void remove(final RevFlagSet set) {
 		flags &= ~set.mask;
 	}
 
-	/** Release as much memory as possible from this object. */
-	public void dispose() {
-		// Nothing needs to be done for most objects.
-	}
-
 	@Override
 	public String toString() {
 		final StringBuilder s = new StringBuilder();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index e876025..2fab266 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -69,11 +69,21 @@ protected RevTag(final AnyObjectId id) {
 	}
 
 	@Override
-	void parse(final RevWalk walk) throws MissingObjectException,
+	void parseHeaders(final RevWalk walk) throws MissingObjectException,
 			IncorrectObjectTypeException, IOException {
 		parseCanonical(walk, loadCanonical(walk));
 	}
 
+	@Override
+	void parseBody(final RevWalk walk) throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		if (buffer == null) {
+			buffer = loadCanonical(walk);
+			if ((flags & PARSED) == 0)
+				parseCanonical(walk, buffer);
+		}
+	}
+
 	void parseCanonical(final RevWalk walk, final byte[] rawTag)
 			throws CorruptObjectException {
 		final MutableInteger pos = new MutableInteger();
@@ -87,7 +97,9 @@ void parseCanonical(final RevWalk walk, final byte[] rawTag)
 		int p = pos.value += 4; // "tag "
 		final int nameEnd = RawParseUtils.nextLF(rawTag, p) - 1;
 		name = RawParseUtils.decode(Constants.CHARSET, rawTag, p, nameEnd);
-		buffer = rawTag;
+
+		if (walk.isRetainBody())
+			buffer = rawTag;
 		flags |= PARSED;
 	}
 
@@ -195,8 +207,7 @@ public final String getName() {
 		return name;
 	}
 
-	public void dispose() {
-		flags &= ~PARSED;
+	final void disposeBody() {
 		buffer = null;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index 40bdb4e..5589fb0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -175,6 +175,8 @@
 
 	private TreeFilter treeFilter;
 
+	private boolean retainBody;
+
 	/**
 	 * Create a new revision walker for a given repository.
 	 * 
@@ -192,6 +194,7 @@ public RevWalk(final Repository repo) {
 		sorting = EnumSet.of(RevSort.NONE);
 		filter = RevFilter.ALL;
 		treeFilter = TreeFilter.ALL;
+		retainBody = true;
 	}
 
 	/**
@@ -237,7 +240,7 @@ public void markStart(final RevCommit c) throws MissingObjectException,
 		if ((c.flags & SEEN) != 0)
 			return;
 		if ((c.flags & PARSED) == 0)
-			c.parse(this);
+			c.parseHeaders(this);
 		c.flags |= SEEN;
 		roots.add(c);
 		queue.add(c);
@@ -510,6 +513,32 @@ public void setTreeFilter(final TreeFilter newFilter) {
 	}
 
 	/**
+	 * Should the body of a commit or tag be retained after parsing its headers?
+	 * <p>
+	 * Usually the body is always retained, but some application code might not
+	 * care and would prefer to discard the body of a commit as early as
+	 * possible, to reduce memory usage.
+	 *
+	 * @return true if the body should be retained; false it is discarded.
+	 */
+	public boolean isRetainBody() {
+		return retainBody;
+	}
+
+	/**
+	 * Set whether or not the body of a commit or tag is retained.
+	 * <p>
+	 * If a body of a commit or tag is not retained, the application must
+	 * call {@link #parseBody(RevObject)} before the body can be safely
+	 * accessed through the type specific access methods.
+	 *
+	 * @param retain true to retain bodies; false to discard them early.
+	 */
+	public void setRetainBody(final boolean retain) {
+		retainBody = retain;
+	}
+
+	/**
 	 * Locate a reference to a blob without loading it.
 	 * <p>
 	 * The blob may or may not exist in the repository. It is impossible to tell
@@ -625,7 +654,7 @@ public RevCommit parseCommit(final AnyObjectId id)
 		RevObject c = parseAny(id);
 		while (c instanceof RevTag) {
 			c = ((RevTag) c).getObject();
-			parse(c);
+			parseHeaders(c);
 		}
 		if (!(c instanceof RevCommit))
 			throw new IncorrectObjectTypeException(id.toObjectId(),
@@ -637,7 +666,7 @@ public RevCommit parseCommit(final AnyObjectId id)
 	 * Locate a reference to a tree.
 	 * <p>
 	 * This method only returns successfully if the tree object exists, is
-	 * verified to be a tree, and was parsed without error.
+	 * verified to be a tree.
 	 *
 	 * @param id
 	 *            name of the tree object, or a commit or annotated tag that may
@@ -656,7 +685,7 @@ public RevTree parseTree(final AnyObjectId id)
 		RevObject c = parseAny(id);
 		while (c instanceof RevTag) {
 			c = ((RevTag) c).getObject();
-			parse(c);
+			parseHeaders(c);
 		}
 
 		final RevTree t;
@@ -667,12 +696,12 @@ else if (!(c instanceof RevTree))
 					Constants.TYPE_TREE);
 		else
 			t = (RevTree) c;
-		parse(t);
+		parseHeaders(t);
 		return t;
 	}
 
 	/**
-	 * Locate a reference to any object and immediately parse its content.
+	 * Locate a reference to any object and immediately parse its headers.
 	 * <p>
 	 * This method only returns successfully if the object exists and was parsed
 	 * without error. Parsing an object can be expensive as the type must be
@@ -724,12 +753,12 @@ public RevObject parseAny(final AnyObjectId id)
 			}
 			objects.add(r);
 		} else
-			parse(r);
+			parseHeaders(r);
 		return r;
 	}
 
 	/**
-	 * Ensure the object's content has been parsed.
+	 * Ensure the object's critical headers have been parsed.
 	 * <p>
 	 * This method only returns successfully if the object exists and was parsed
 	 * without error.
@@ -741,11 +770,28 @@ public RevObject parseAny(final AnyObjectId id)
 	 * @throws IOException
 	 *             a pack file or loose object could not be read.
 	 */
-	public void parse(final RevObject obj) throws MissingObjectException,
-			IOException {
-		if ((obj.flags & PARSED) != 0)
-			return;
-		obj.parse(this);
+	public void parseHeaders(final RevObject obj)
+			throws MissingObjectException, IOException {
+		if ((obj.flags & PARSED) == 0)
+			obj.parseHeaders(this);
+	}
+
+	/**
+	 * Ensure the object's fully body content is available.
+	 * <p>
+	 * This method only returns successfully if the object exists and was parsed
+	 * without error.
+	 * 
+	 * @param obj
+	 *            the object the caller needs to be parsed.
+	 * @throws MissingObjectException
+	 *             the supplied does not exist.
+	 * @throws IOException
+	 *             a pack file or loose object could not be read.
+	 */
+	public void parseBody(final RevObject obj)
+			throws MissingObjectException, IOException {
+		obj.parseBody(this);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RewriteTreeFilter.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RewriteTreeFilter.java
index a5edbf0..754be07 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RewriteTreeFilter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RewriteTreeFilter.java
@@ -94,7 +94,7 @@ public boolean include(final RevWalk walker, final RevCommit c)
 		for (int i = 0; i < nParents; i++) {
 			final RevCommit p = c.parents[i];
 			if ((p.flags & PARSED) == 0)
-				p.parse(walker);
+				p.parseHeaders(walker);
 			trees[i] = p.getTree();
 		}
 		trees[nParents] = c.getTree();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index 45d57b3..5127dad 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -137,6 +137,7 @@
 	public UploadPack(final Repository copyFrom) {
 		db = copyFrom;
 		walk = new RevWalk(db);
+		walk.setRetainBody(false);
 
 		ADVERTISED = walk.newFlag("ADVERTISED");
 		WANT = walk.newFlag("WANT");
@@ -270,7 +271,7 @@ private void writeAdvertisedTag(final StringBuilder m, final char[] idtmp,
 		while (o instanceof RevTag) {
 			// Fully unwrap here so later on we have these already parsed.
 			try {
-				walk.parse(((RevTag) o).getObject());
+				walk.parseHeaders(((RevTag) o).getObject());
 			} catch (IOException err) {
 				return;
 			}
@@ -434,7 +435,6 @@ private boolean wantSatisfied(final RevCommit want) throws IOException {
 				}
 				return true;
 			}
-			c.dispose();
 		}
 		return false;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 4d14305..6929c5f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -193,6 +193,7 @@ WalkFetchConnection(final WalkTransport t, final WalkRemoteObjectDatabase w) {
 		packLocks = new ArrayList<PackLock>(4);
 
 		revWalk = new RevWalk(local);
+		revWalk.setRetainBody(false);
 		treeWalk = new TreeWalk(local);
 		COMPLETE = revWalk.newFlag("COMPLETE");
 		IN_WORK_QUEUE = revWalk.newFlag("IN_WORK_QUEUE");
@@ -266,7 +267,7 @@ private void process(final ObjectId id) throws TransportException {
 				obj = (RevObject) id;
 				if (obj.has(COMPLETE))
 					return;
-				revWalk.parse(obj);
+				revWalk.parseHeaders(obj);
 			} else {
 				obj = revWalk.parseAny(id);
 				if (obj.has(COMPLETE))
@@ -276,12 +277,6 @@ private void process(final ObjectId id) throws TransportException {
 			throw new TransportException("Cannot read " + id.name(), e);
 		}
 
-		// We only care about traversal; disposing an object throws its
-		// message buffer (if any) away but retains the links so we can
-		// continue to navigate, but use less memory long-term.
-		//
-		obj.dispose();
-
 		switch (obj.getType()) {
 		case Constants.OBJ_BLOB:
 			processBlob(obj);	
@@ -694,9 +689,8 @@ private void markLocalRefsComplete(final Set<ObjectId> have) throws TransportExc
 	private void markLocalObjComplete(RevObject obj) throws IOException {
 		while (obj.getType() == Constants.OBJ_TAG) {
 			obj.add(COMPLETE);
-			obj.dispose();
 			obj = ((RevTag) obj).getObject();
-			revWalk.parse(obj);
+			revWalk.parseHeaders(obj);
 		}
 
 		switch (obj.getType()) {
@@ -734,11 +728,10 @@ private void pushLocalCommit(final RevCommit p)
 			throws MissingObjectException, IOException {
 		if (p.has(LOCALLY_SEEN))
 			return;
-		revWalk.parse(p);
+		revWalk.parseHeaders(p);
 		p.add(LOCALLY_SEEN);
 		p.add(COMPLETE);
 		p.carry(COMPLETE);
-		p.dispose();
 		localCommitQueue.add(p);
 	}
 
-- 
1.6.3.2.367.gf0de
