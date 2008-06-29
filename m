From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/21] Allow PackWriter to prepare object list and compute name before writing
Date: Sun, 29 Jun 2008 03:59:18 -0400
Message-ID: <1214726371-93520-9-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
 <1214726371-93520-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrk-0000I1-W5
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbYF2IAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYF2IAq
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36771 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbYF2IAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpI-0004Ms-1F; Sun, 29 Jun 2008 04:00:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 570CE20FBAE; Sun, 29 Jun 2008 04:00:00 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 75D5520FBD0;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-8-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86780>

When we are writing a pack for a dumb protocol transport we want to
get the name of the pack prior to generating its output stream.  This
permits us to open the pack stream directly under its final name and
write into it without needing to issue a rename in the middle of the
process.  By splitting the pack preparing phase from the writing phase
we are able to request computeName() between the two stages and create
the OutputStream based upon the result.

To improve performance we also now buffer what we write to the pack
stream, if the pack stream was not already a buffered stream.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    8 +-
 .../src/org/spearce/jgit/lib/PackWriter.java       |  124 +++++++++-----------
 .../jgit/transport/BasePackPushConnection.java     |    5 +-
 3 files changed, 66 insertions(+), 71 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 3f07a57..4dd4b2a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -87,7 +87,7 @@ public class PackWriterTest extends RepositoryTestCase {
 		packBase = new File(trash, "tmp_pack");
 		packFile = new File(trash, "tmp_pack.pack");
 		indexFile = new File(trash, "tmp_pack.idx");
-		writer = new PackWriter(db, cos, new TextProgressMonitor());
+		writer = new PackWriter(db, new TextProgressMonitor());
 	}
 
 	/**
@@ -438,14 +438,16 @@ public class PackWriterTest extends RepositoryTestCase {
 			final Collection<ObjectId> uninterestings, final boolean thin,
 			final boolean ignoreMissingUninteresting)
 			throws MissingObjectException, IOException {
-		writer.writePack(interestings, uninterestings, thin,
+		writer.preparePack(interestings, uninterestings, thin,
 				ignoreMissingUninteresting);
+		writer.writePack(cos);
 		verifyOpenPack(thin);
 	}
 
 	private void createVerifyOpenPack(final Iterator<RevObject> objectSource)
 			throws MissingObjectException, IOException {
-		writer.writePack(objectSource);
+		writer.preparePack(objectSource);
+		writer.writePack(cos);
 		verifyOpenPack(false);
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index e346668..c7aa061 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -37,6 +37,7 @@
 
 package org.spearce.jgit.lib;
 
+import java.io.BufferedOutputStream;
 import java.io.IOException;
 import java.io.OutputStream;
 import java.security.DigestOutputStream;
@@ -76,10 +77,10 @@ import org.spearce.jgit.util.NB;
  * order of objects in pack</li>
  * </ul>
  * Typical usage consists of creating instance intended for some pack,
- * configuring options through accessors methods and finally call
- * {@link #writePack(Iterator)} or
- * {@link #writePack(Collection, Collection, boolean, boolean)} with objects
- * specification, to generate a pack stream.
+ * configuring options, preparing the list of objects by calling
+ * {@link #preparePack(Iterator)} or
+ * {@link #preparePack(Collection, Collection, boolean, boolean)}, and finally
+ * producing the stream with {@link #writePack(OutputStream)}.
  * </p>
  * <p>
  * Class provide set of configurable options and {@link ProgressMonitor}
@@ -99,7 +100,7 @@ public class PackWriter {
 	 * Title of {@link ProgressMonitor} task used during counting objects to
 	 * pack.
 	 *
-	 * @see #writePack(Collection, Collection, boolean, boolean)
+	 * @see #preparePack(Collection, Collection, boolean, boolean)
 	 */
 	public static final String COUNTING_OBJECTS_PROGRESS = "Counting objects to pack";
 
@@ -107,8 +108,7 @@ public class PackWriter {
 	 * Title of {@link ProgressMonitor} task used during searching for objects
 	 * reuse or delta reuse.
 	 *
-	 * @see #writePack(Iterator)
-	 * @see #writePack(Collection, Collection, boolean, boolean)
+	 * @see #writePack(OutputStream)
 	 */
 	public static final String SEARCHING_REUSE_PROGRESS = "Searching for delta and object reuse";
 
@@ -116,8 +116,7 @@ public class PackWriter {
 	 * Title of {@link ProgressMonitor} task used during writing out pack
 	 * (objects)
 	 *
-	 * @see #writePack(Iterator)
-	 * @see #writePack(Collection, Collection, boolean, boolean)
+	 * @see #writePack(OutputStream)
 	 */
 	public static final String WRITING_OBJECTS_PROGRESS = "Writing objects";
 
@@ -168,9 +167,9 @@ public class PackWriter {
 
 	private final Repository db;
 
-	private final DigestOutputStream out;
+	private DigestOutputStream out;
 
-	private final CountingOutputStream countingOut;
+	private CountingOutputStream countingOut;
 
 	private final Deflater deflater;
 
@@ -197,28 +196,22 @@ public class PackWriter {
 	private boolean thin;
 
 	/**
-	 * Create writer for specified repository, that will write a pack to
-	 * provided output stream. Objects for packing are specified in
-	 * {@link #writePack(Iterator)} or
-	 * {@link #writePack(Collection, Collection, boolean, boolean)}.
+	 * Create writer for specified repository.
+	 * <p>
+	 * Objects for packing are specified in {@link #preparePack(Iterator)} or
+	 * {@link #preparePack(Collection, Collection, boolean, boolean)}.
 	 *
 	 * @param repo
 	 *            repository where objects are stored.
-	 * @param out
-	 *            output stream of pack data; no buffering is guaranteed by
-	 *            writer.
 	 * @param monitor
 	 *            operations progress monitor, used within
-	 *            {@link #writePack(Iterator)} or
-	 *            {@link #writePack(Collection, Collection, boolean, boolean)}.
+	 *            {@link #preparePack(Iterator)},
+	 *            {@link #preparePack(Collection, Collection, boolean, boolean)},
+	 *            or {@link #writePack(OutputStream)}.
 	 */
-	public PackWriter(final Repository repo, final OutputStream out,
-			final ProgressMonitor monitor) {
+	public PackWriter(final Repository repo, final ProgressMonitor monitor) {
 		this.db = repo;
 		this.monitor = monitor;
-		this.countingOut = new CountingOutputStream(out);
-		this.out = new DigestOutputStream(countingOut, Constants
-				.newMessageDigest());
 		this.deflater = new Deflater(db.getConfig().getCore().getCompression());
 	}
 
@@ -241,9 +234,9 @@ public class PackWriter {
 	 * use it if possible. Normally, only deltas with base to another object
 	 * existing in set of objects to pack will be used. Exception is however
 	 * thin-pack (see
-	 * {@link #writePack(Collection, Collection, boolean, boolean)} and
-	 * {@link #writePack(Iterator)}) where base object must exist on other side
-	 * machine.
+	 * {@link #preparePack(Collection, Collection, boolean, boolean)} and
+	 * {@link #preparePack(Iterator)}) where base object must exist on other
+	 * side machine.
 	 * <p>
 	 * When raw delta data is directly copied from a pack file, checksum is
 	 * computed to verify data.
@@ -371,8 +364,7 @@ public class PackWriter {
 	}
 
 	/**
-	 * Write pack to output stream according to current writer configuration for
-	 * provided source iterator of objects.
+	 * Prepare the list of objects to be written to the pack stream.
 	 * <p>
 	 * Iterator <b>exactly</b> determines which objects are included in a pack
 	 * and order they appear in pack (except that objects order by type is not
@@ -391,17 +383,6 @@ public class PackWriter {
 	 * {@link RevFlag#UNINTERESTING} flag. This type of pack is used only for
 	 * transport.
 	 * </p>
-	 * <p>
-	 * At first, this method collects and sorts objects to pack, then deltas
-	 * search is performed if set up accordingly, finally pack stream is
-	 * written. {@link ProgressMonitor} tasks {@value #SEARCHING_REUSE_PROGRESS}
-	 * (only if resueDeltas or reuseObjects is enabled) and
-	 * {@value #WRITING_OBJECTS_PROGRESS} are updated during packing.
-	 * </p>
-	 * <p>
-	 * All reused objects data checksum (Adler32/CRC32) is computed and
-	 * validated against existing checksum.
-	 * </p>
 	 *
 	 * @param objectsSource
 	 *            iterator of object to store in a pack; order of objects within
@@ -414,20 +395,17 @@ public class PackWriter {
 	 *            {@link RevFlag#UNINTERESTING} flag set, it won't be included
 	 *            in a pack, but is considered as edge-object for thin-pack.
 	 * @throws IOException
-	 *             when some I/O problem occur during reading objects for pack
-	 *             or writing pack stream.
+	 *             when some I/O problem occur during reading objects.
 	 */
-	public void writePack(final Iterator<RevObject> objectsSource)
+	public void preparePack(final Iterator<RevObject> objectsSource)
 			throws IOException {
 		while (objectsSource.hasNext()) {
 			addObject(objectsSource.next());
 		}
-		writePackInternal();
 	}
 
 	/**
-	 * Write pack to output stream according to current writer configuration for
-	 * provided sets of interesting and uninteresting objects.
+	 * Prepare the list of objects to be written to the pack stream.
 	 * <p>
 	 * Basing on these 2 sets, another set of objects to put in a pack file is
 	 * created: this set consists of all objects reachable (ancestors) from
@@ -437,18 +415,6 @@ public class PackWriter {
 	 * Order is consistent with general git in-pack rules: sort by object type,
 	 * recency, path and delta-base first.
 	 * </p>
-	 * <p>
-	 * At first, this method collects and sorts objects to pack, then deltas
-	 * search is performed if set up accordingly, finally pack stream is
-	 * written. {@link ProgressMonitor} tasks
-	 * {@value #COUNTING_OBJECTS_PROGRESS}, {@value #SEARCHING_REUSE_PROGRESS}
-	 * (only if resueDeltas or reuseObjects is enabled) and
-	 * {@value #WRITING_OBJECTS_PROGRESS} are updated during packing.
-	 * </p>
-	 * <p>
-	 * All reused objects data checksum (Adler32/CRC32) is computed and
-	 * validated against existing checksum.
-	 * </p>
 	 *
 	 * @param interestingObjects
 	 *            collection of objects to be marked as interesting (start
@@ -468,17 +434,15 @@ public class PackWriter {
 	 *            otherwise - non existing uninteresting objects may cause
 	 *            {@link MissingObjectException}
 	 * @throws IOException
-	 *             when some I/O problem occur during reading objects for pack
-	 *             or writing pack stream.
+	 *             when some I/O problem occur during reading objects.
 	 */
-	public void writePack(final Collection<ObjectId> interestingObjects,
+	public void preparePack(final Collection<ObjectId> interestingObjects,
 			final Collection<ObjectId> uninterestingObjects,
 			final boolean thin, final boolean ignoreMissingUninteresting)
 			throws IOException {
 		ObjectWalk walker = setUpWalker(interestingObjects,
 				uninterestingObjects, thin, ignoreMissingUninteresting);
 		findObjectsToPack(walker);
-		writePackInternal();
 	}
 
 	/**
@@ -499,8 +463,8 @@ public class PackWriter {
 	/**
 	 * Create an index file to match the pack file just written.
 	 * <p>
-	 * This method can only be invoked after {@link #writePack(Iterator)} or
-	 * {@link #writePack(Collection, Collection, boolean, boolean)} has been
+	 * This method can only be invoked after {@link #preparePack(Iterator)} or
+	 * {@link #preparePack(Collection, Collection, boolean, boolean)} has been
 	 * invoked and completed successfully. Writing a corresponding index is an
 	 * optional feature that not all pack users may require.
 	 * 
@@ -532,10 +496,38 @@ public class PackWriter {
 		return sortedByName;
 	}
 
-	private void writePackInternal() throws IOException {
+	/**
+	 * Write the prepared pack to the supplied stream.
+	 * <p>
+	 * At first, this method collects and sorts objects to pack, then deltas
+	 * search is performed if set up accordingly, finally pack stream is
+	 * written. {@link ProgressMonitor} tasks {@value #SEARCHING_REUSE_PROGRESS}
+	 * (only if resueDeltas or reuseObjects is enabled) and
+	 * {@value #WRITING_OBJECTS_PROGRESS} are updated during packing.
+	 * </p>
+	 * <p>
+	 * All reused objects data checksum (Adler32/CRC32) is computed and
+	 * validated against existing checksum.
+	 * </p>
+	 *
+	 * @param packStream
+	 *            output stream of pack data. If the stream is not buffered it
+	 *            will be buffered by the writer. Caller is responsible for
+	 *            closing the stream.
+	 * @throws IOException
+	 *             an error occurred reading a local object's data to include in
+	 *             the pack, or writing compressed object data to the output
+	 *             stream.
+	 */
+	public void writePack(OutputStream packStream) throws IOException {
 		if (reuseDeltas || reuseObjects)
 			searchForReuse();
 
+		if (!(packStream instanceof BufferedOutputStream))
+			packStream = new BufferedOutputStream(packStream);
+		countingOut = new CountingOutputStream(packStream);
+		out = new DigestOutputStream(countingOut, Constants.newMessageDigest());
+
 		monitor.beginTask(WRITING_OBJECTS_PROGRESS, getObjectsNumber());
 		writeHeader();
 		writeObjects();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 217486a..7ae3aa7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -161,7 +161,7 @@ class BasePackPushConnection extends BasePackConnection implements
 
 	private void writePack(final Map<String, RemoteRefUpdate> refUpdates,
 			final ProgressMonitor monitor) throws IOException {
-		final PackWriter writer = new PackWriter(local, out, monitor);
+		final PackWriter writer = new PackWriter(local, monitor);
 		final ArrayList<ObjectId> remoteObjects = new ArrayList<ObjectId>(
 				getRefs().size());
 		final ArrayList<ObjectId> newObjects = new ArrayList<ObjectId>(
@@ -172,7 +172,8 @@ class BasePackPushConnection extends BasePackConnection implements
 		for (final RemoteRefUpdate r : refUpdates.values())
 			newObjects.add(r.getNewObjectId());
 
-		writer.writePack(newObjects, remoteObjects, thinPack, true);
+		writer.preparePack(newObjects, remoteObjects, thinPack, true);
+		writer.writePack(out);
 	}
 
 	private void readStatusReport(final Map<String, RemoteRefUpdate> refUpdates)
-- 
1.5.6.74.g8a5e
