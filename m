From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Simplify the PackWriter.preparePack() API
Date: Thu, 26 Mar 2009 12:42:47 -0700
Message-ID: <1238096567-27567-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 20:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmvUy-0005g3-OY
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 20:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760887AbZCZTmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 15:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759990AbZCZTmw
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 15:42:52 -0400
Received: from george.spearce.org ([209.20.77.23]:41103 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088AbZCZTmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 15:42:51 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DFA2038215; Thu, 26 Mar 2009 19:42:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B8E44381D2;
	Thu, 26 Mar 2009 19:42:47 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.1.471.g682837
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114812>

It has always bothered me that we had two boolean "mode" parameters
as part of the preparePack method call, when most other options were
set by standard setter methods.  In all current callers (except the
unit tests) the ignoreMissingUninteresting was always set to true,
and in many of the callers, packthin was false.  Moving these to
setters with a reasonable default simplifies callers considerably.

Signed-off-by: Shawn O. Pearce <sop@google.com>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    5 +-
 .../src/org/spearce/jgit/lib/PackWriter.java       |   78 +++++++++++++-------
 .../jgit/transport/BasePackPushConnection.java     |    3 +-
 .../org/spearce/jgit/transport/BundleWriter.java   |    3 +-
 .../src/org/spearce/jgit/transport/UploadPack.java |    3 +-
 .../spearce/jgit/transport/WalkPushConnection.java |    2 +-
 6 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index f7139fc..5ebca09 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -442,8 +442,9 @@ private void createVerifyOpenPack(final Collection<ObjectId> interestings,
 			final Collection<ObjectId> uninterestings, final boolean thin,
 			final boolean ignoreMissingUninteresting)
 			throws MissingObjectException, IOException {
-		writer.preparePack(interestings, uninterestings, thin,
-				ignoreMissingUninteresting);
+		writer.setThin(thin);
+		writer.setIgnoreMissingUninteresting(ignoreMissingUninteresting);
+		writer.preparePack(interestings, uninterestings);
 		writer.writePack(cos);
 		verifyOpenPack(thin);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 601ce71..83506bd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -78,7 +78,7 @@
  * Typical usage consists of creating instance intended for some pack,
  * configuring options, preparing the list of objects by calling
  * {@link #preparePack(Iterator)} or
- * {@link #preparePack(Collection, Collection, boolean, boolean)}, and finally
+ * {@link #preparePack(Collection, Collection)}, and finally
  * producing the stream with {@link #writePack(OutputStream)}.
  * </p>
  * <p>
@@ -99,7 +99,7 @@
 	 * Title of {@link ProgressMonitor} task used during counting objects to
 	 * pack.
 	 *
-	 * @see #preparePack(Collection, Collection, boolean, boolean)
+	 * @see #preparePack(Collection, Collection)
 	 */
 	public static final String COUNTING_OBJECTS_PROGRESS = "Counting objects";
 
@@ -196,18 +196,20 @@
 
 	private boolean thin;
 
+	private boolean ignoreMissingUninteresting = true;
+	
 	/**
 	 * Create writer for specified repository.
 	 * <p>
 	 * Objects for packing are specified in {@link #preparePack(Iterator)} or
-	 * {@link #preparePack(Collection, Collection, boolean, boolean)}.
+	 * {@link #preparePack(Collection, Collection)}.
 	 *
 	 * @param repo
 	 *            repository where objects are stored.
 	 * @param monitor
 	 *            operations progress monitor, used within
 	 *            {@link #preparePack(Iterator)},
-	 *            {@link #preparePack(Collection, Collection, boolean, boolean)}
+	 *            {@link #preparePack(Collection, Collection)}
 	 *            , or {@link #writePack(OutputStream)}.
 	 */
 	public PackWriter(final Repository repo, final ProgressMonitor monitor) {
@@ -218,15 +220,14 @@ public PackWriter(final Repository repo, final ProgressMonitor monitor) {
 	 * Create writer for specified repository.
 	 * <p>
 	 * Objects for packing are specified in {@link #preparePack(Iterator)} or
-	 * {@link #preparePack(Collection, Collection, boolean, boolean)}.
+	 * {@link #preparePack(Collection, Collection)}.
 	 *
 	 * @param repo
 	 *            repository where objects are stored.
 	 * @param imonitor
 	 *            operations progress monitor, used within
 	 *            {@link #preparePack(Iterator)},
-	 *            {@link #preparePack(Collection, Collection, boolean, boolean)}
-	 *            ;
+	 *            {@link #preparePack(Collection, Collection)}
 	 * @param wmonitor
 	 *            operations progress monitor, used within
 	 *            {@link #writePack(OutputStream)}.
@@ -259,7 +260,7 @@ public boolean isReuseDeltas() {
 	 * use it if possible. Normally, only deltas with base to another object
 	 * existing in set of objects to pack will be used. Exception is however
 	 * thin-pack (see
-	 * {@link #preparePack(Collection, Collection, boolean, boolean)} and
+	 * {@link #preparePack(Collection, Collection)} and
 	 * {@link #preparePack(Iterator)}) where base object must exist on other
 	 * side machine.
 	 * <p>
@@ -367,6 +368,45 @@ public void setMaxDeltaDepth(int maxDeltaDepth) {
 		this.maxDeltaDepth = maxDeltaDepth;
 	}
 
+	/** @return true if this writer is producing a thin pack. */
+	public boolean isThin() {
+		return thin;
+	}
+
+	/**
+	 * @param packthin
+	 *            a boolean indicating whether writer may pack objects with
+	 *            delta base object not within set of objects to pack, but
+	 *            belonging to party repository (uninteresting/boundary) as
+	 *            determined by set; this kind of pack is used only for
+	 *            transport; true - to produce thin pack, false - otherwise.
+	 */
+	public void setThin(final boolean packthin) {
+		thin = packthin;
+	}
+
+	/**
+	 * @return true to ignore objects that are uninteresting and also not found
+	 *         on local disk; false to throw a {@link MissingObjectException}
+	 *         out of {@link #preparePack(Collection, Collection)} if an
+	 *         uninteresting object is not in the source repository. By default,
+	 *         true, permitting gracefully ignoring of uninteresting objects.
+	 */
+	public boolean isIgnoreMissingUninteresting() {
+		return ignoreMissingUninteresting;
+	}
+	
+	/**
+	 * @param ignore
+	 *            true if writer should ignore non existing uninteresting
+	 *            objects during construction set of objects to pack; false
+	 *            otherwise - non existing uninteresting objects may cause
+	 *            {@link MissingObjectException}
+	 */
+	public void setIgnoreMissingUninteresting(final boolean ignore) {
+		ignoreMissingUninteresting = ignore;
+	}
+
 	/**
 	 * Set the pack index file format version this instance will create.
 	 *
@@ -447,28 +487,15 @@ public void preparePack(final Iterator<RevObject> objectsSource)
 	 * @param uninterestingObjects
 	 *            collection of objects to be marked as uninteresting (end
 	 *            points of graph traversal).
-	 * @param packthin
-	 *            a boolean indicating whether writer may pack objects with
-	 *            delta base object not within set of objects to pack, but
-	 *            belonging to party repository (uninteresting/boundary) as
-	 *            determined by set; this kind of pack is used only for
-	 *            transport; true - to produce thin pack, false - otherwise.
-	 * @param ignoreMissingUninteresting
-	 *            true if writer should ignore non existing uninteresting
-	 *            objects during construction set of objects to pack; false
-	 *            otherwise - non existing uninteresting objects may cause
-	 *            {@link MissingObjectException}
 	 * @throws IOException
 	 *             when some I/O problem occur during reading objects.
 	 */
 	public void preparePack(
 			final Collection<? extends ObjectId> interestingObjects,
-			final Collection<? extends ObjectId> uninterestingObjects,
-			final boolean packthin, final boolean ignoreMissingUninteresting)
+			final Collection<? extends ObjectId> uninterestingObjects)
 			throws IOException {
-		this.thin = packthin;
 		ObjectWalk walker = setUpWalker(interestingObjects,
-				uninterestingObjects, ignoreMissingUninteresting);
+				uninterestingObjects);
 		findObjectsToPack(walker);
 	}
 
@@ -502,7 +529,7 @@ public ObjectId computeName() {
 	 * Create an index file to match the pack file just written.
 	 * <p>
 	 * This method can only be invoked after {@link #preparePack(Iterator)} or
-	 * {@link #preparePack(Collection, Collection, boolean, boolean)} has been
+	 * {@link #preparePack(Collection, Collection)} has been
 	 * invoked and completed successfully. Writing a corresponding index is an
 	 * optional feature that not all pack users may require.
 	 *
@@ -760,8 +787,7 @@ private void writeChecksum() throws IOException {
 
 	private ObjectWalk setUpWalker(
 			final Collection<? extends ObjectId> interestingObjects,
-			final Collection<? extends ObjectId> uninterestingObjects,
-			final boolean ignoreMissingUninteresting)
+			final Collection<? extends ObjectId> uninterestingObjects)
 			throws MissingObjectException, IOException,
 			IncorrectObjectTypeException {
 		final ObjectWalk walker = new ObjectWalk(db);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index a078d7e..dde1d26 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -201,7 +201,8 @@ private void writePack(final Map<String, RemoteRefUpdate> refUpdates,
 				newObjects.add(r.getNewObjectId());
 		}
 
-		writer.preparePack(newObjects, remoteObjects, thinPack, true);
+		writer.setThin(thinPack);
+		writer.preparePack(newObjects, remoteObjects);
 		writer.writePack(out);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleWriter.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleWriter.java
index a22a31d..8000837 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleWriter.java
@@ -166,7 +166,8 @@ public void writeBundle(OutputStream os) throws IOException {
 		inc.addAll(include.values());
 		for (final RevCommit r : assume)
 			exc.add(r.getId());
-		packWriter.preparePack(inc, exc, exc.size() > 0, true);
+		packWriter.setThin(exc.size() > 0);
+		packWriter.preparePack(inc, exc);
 
 		final Writer w = new OutputStreamWriter(os, Constants.CHARSET);
 		w.write(TransportBundle.V2_BUNDLE_SIGNATURE);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index 204859c..45d57b3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -464,7 +464,8 @@ private void sendPack() throws IOException {
 		final PackWriter pw;
 		pw = new PackWriter(db, pm, NullProgressMonitor.INSTANCE);
 		pw.setDeltaBaseAsOffset(options.contains(OPTION_OFS_DELTA));
-		pw.preparePack(wantAll, commonBase, thin, true);
+		pw.setThin(thin);
+		pw.preparePack(wantAll, commonBase);
 		if (options.contains(OPTION_INCLUDE_TAG)) {
 			for (final Ref r : refs.values()) {
 				final RevObject o;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index 3246ee6..acdb5b8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -210,7 +210,7 @@ private void sendpack(final List<RemoteRefUpdate> updates,
 				if (r.getPeeledObjectId() != null)
 					have.add(r.getPeeledObjectId());
 			}
-			pw.preparePack(need, have, false, true);
+			pw.preparePack(need, have);
 
 			// We don't have to continue further if the pack will
 			// be an empty pack, as the remote has all objects it
-- 
1.6.2.1.471.g682837
