From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Use pack-*.keep files during fetch and receive-pack to prevent GC
Date: Mon,  4 May 2009 13:34:52 -0700
Message-ID: <1241469292-20784-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 04 22:35:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M14sT-0002nB-6u
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 22:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbZEDUe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 16:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbZEDUez
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 16:34:55 -0400
Received: from george.spearce.org ([209.20.77.23]:55708 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbZEDUey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 16:34:54 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0348D38196; Mon,  4 May 2009 20:34:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7AE3138194;
	Mon,  4 May 2009 20:34:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc4.206.g03e16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118260>

C Git creates a pack-*.keep for a pack file while the pack file is
being stored on disk between the time it is initially created by
index-pack and when all refs finished being updated with the new
values.  By creating this file we permit concurrent "git gc" or
"git repack" in a repository while a fetch or push into the same
repository is occurring.  The pack-*.keep file prevents the gc
task from deleting the pack file, which is necessary to prevent
the objects from disappearing, as the contained objects were not
reachable from the set of existing refs when the gc started.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I think that between this, what's in master, and "[PATCH v2 1/2]
 Ensure that a PackFile instance stays invalid when overwritten",
 its now safe to run "git repack -a -d" while a JGit based daemon
 is using the same repository.  Which brings us in line with how
 git-daemon or OpenSSH based access behaves with C Git.

 .../src/org/spearce/jgit/lib/PackLock.java         |   84 ++++++++++++++++++++
 .../jgit/transport/BasePackFetchConnection.java    |   18 ++++-
 .../jgit/transport/BundleFetchConnection.java      |   18 ++++-
 .../spearce/jgit/transport/FetchConnection.java    |   25 ++++++-
 .../org/spearce/jgit/transport/FetchProcess.java   |   22 +++++-
 .../src/org/spearce/jgit/transport/IndexPack.java  |   45 ++++++++++-
 .../org/spearce/jgit/transport/ReceivePack.java    |   19 ++++-
 .../jgit/transport/WalkFetchConnection.java        |   18 ++++-
 8 files changed, 241 insertions(+), 8 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/PackLock.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackLock.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackLock.java
new file mode 100644
index 0000000..681c1e1
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackLock.java
@@ -0,0 +1,84 @@
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
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+
+/** Keeps track of a {@link PackFile}'s associated <code>.keep</code> file. */
+public class PackLock {
+	private final File keepFile;
+
+	/**
+	 * Create a new lock for a pack file.
+	 *
+	 * @param packFile
+	 *            location of the <code>pack-*.pack</code> file.
+	 */
+	public PackLock(final File packFile) {
+		final File p = packFile.getParentFile();
+		final String n = packFile.getName();
+		keepFile = new File(p, n.substring(0, n.length() - 5) + ".keep");
+	}
+
+	/**
+	 * Create the <code>pack-*.keep</code> file, with the given message.
+	 *
+	 * @param msg
+	 *            message to store in the file.
+	 * @return true if the keep file was successfully written; false otherwise.
+	 * @throws IOException
+	 *             the keep file could not be written.
+	 */
+	public boolean lock(String msg) throws IOException {
+		if (msg == null)
+			return false;
+		if (!msg.endsWith("\n"))
+			msg += "\n";
+		final LockFile lf = new LockFile(keepFile);
+		if (!lf.lock())
+			return false;
+		lf.write(Constants.encode(msg));
+		return lf.commit();
+	}
+
+	/** Remove the <code>.keep</code> file that holds this pack in place. */
+	public void unlock() {
+		keepFile.delete();
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index b75e0ef..f4cd946 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -40,6 +40,7 @@
 
 import java.io.IOException;
 import java.util.Collection;
+import java.util.Collections;
 import java.util.Date;
 import java.util.Set;
 
@@ -47,6 +48,7 @@
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revwalk.RevCommit;
@@ -126,6 +128,10 @@
 
 	private boolean includeTags;
 
+	private String lockMessage;
+
+	private PackLock packLock;
+
 	BasePackFetchConnection(final PackTransport packTransport) {
 		super(packTransport);
 		includeTags = transport.getTagOpt() != TagOpt.NO_TAGS;
@@ -157,6 +163,16 @@ public boolean didFetchTestConnectivity() {
 		return false;
 	}
 
+	public void setPackLockMessage(final String message) {
+		lockMessage = message;
+	}
+
+	public Collection<PackLock> getPackLocks() {
+		if (packLock != null)
+			return Collections.singleton(packLock);
+		return Collections.<PackLock> emptyList();
+	}
+
 	protected void doFetch(final ProgressMonitor monitor,
 			final Collection<Ref> want, final Set<ObjectId> have)
 			throws TransportException {
@@ -477,7 +493,7 @@ private void receivePack(final ProgressMonitor monitor) throws IOException {
 		ip.setFixThin(thinPack);
 		ip.setObjectChecking(transport.isCheckFetchedObjects());
 		ip.index(monitor);
-		ip.renameAndOpenPack();
+		packLock = ip.renameAndOpenPack(lockMessage);
 	}
 
 	private static class CancelledException extends Exception {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
index 2e2977e..14e0c7d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
@@ -43,6 +43,7 @@
 import java.io.InputStream;
 import java.util.ArrayList;
 import java.util.Collection;
+import java.util.Collections;
 import java.util.HashSet;
 import java.util.LinkedHashMap;
 import java.util.List;
@@ -54,6 +55,7 @@
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revwalk.RevCommit;
@@ -75,6 +77,10 @@
 
 	final Set<ObjectId> prereqs = new HashSet<ObjectId>();
 
+	private String lockMessage;
+
+	private PackLock packLock;
+
 	BundleFetchConnection(Transport transportBundle, final InputStream src) throws TransportException {
 		transport = transportBundle;
 		bin = new BufferedInputStream(src, IndexPack.BUFFER_SIZE);
@@ -158,7 +164,7 @@ protected void doFetch(final ProgressMonitor monitor,
 		try {
 			final IndexPack ip = newIndexPack();
 			ip.index(monitor);
-			ip.renameAndOpenPack();
+			packLock = ip.renameAndOpenPack(lockMessage);
 		} catch (IOException err) {
 			close();
 			throw new TransportException(transport.uri, err.getMessage(), err);
@@ -168,6 +174,16 @@ protected void doFetch(final ProgressMonitor monitor,
 		}
 	}
 
+	public void setPackLockMessage(final String message) {
+		lockMessage = message;
+	}
+
+	public Collection<PackLock> getPackLocks() {
+		if (packLock != null)
+			return Collections.singleton(packLock);
+		return Collections.<PackLock> emptyList();
+	}
+
 	private IndexPack newIndexPack() throws IOException {
 		final IndexPack ip = IndexPack.create(transport.local, bin);
 		ip.setFixThin(true);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
index 61ef219..1138614 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
@@ -42,6 +42,7 @@
 
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 
@@ -142,4 +143,26 @@ public void fetch(final ProgressMonitor monitor,
 	 *         the remote peer supplied a complete graph.
 	 */
 	public boolean didFetchTestConnectivity();
-}
\ No newline at end of file
+
+	/**
+	 * Set the lock message used when holding a pack out of garbage collection.
+	 * <p>
+	 * Callers that set a lock message <b>must</b> ensure they call
+	 * {@link #getPackLocks()} after
+	 * {@link #fetch(ProgressMonitor, Collection, Set)}, even if an exception
+	 * was thrown, and release the locks that are held.
+	 *
+	 * @param message message to use when holding a pack in place.
+	 */
+	public void setPackLockMessage(String message);
+	
+	/**
+	 * All locks created by the last
+	 * {@link #fetch(ProgressMonitor, Collection, Set)} call.
+	 *
+	 * @return collection (possibly empty) of locks created by the last call to
+	 *         fetch. The caller must release these after refs are updated in
+	 *         order to safely permit garbage collection.
+	 */
+	public Collection<PackLock> getPackLocks();
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index f216cba..08d7d65 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -57,6 +57,7 @@
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.LockFile;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
@@ -82,6 +83,8 @@
 	/** Records to be recorded into FETCH_HEAD. */
 	private final ArrayList<FetchHeadRecord> fetchHeadUpdates = new ArrayList<FetchHeadRecord>();
 
+	private final ArrayList<PackLock> packLocks = new ArrayList<PackLock>();
+
 	private FetchConnection conn;
 
 	FetchProcess(final Transport t, final Collection<RefSpec> f) {
@@ -94,7 +97,19 @@ void execute(final ProgressMonitor monitor, final FetchResult result)
 		askFor.clear();
 		localUpdates.clear();
 		fetchHeadUpdates.clear();
+		packLocks.clear();
+
+		try {
+			executeImp(monitor, result);
+		} finally {
+			for (final PackLock lock : packLocks)
+				lock.unlock();
+		}
+	}
 
+	private void executeImp(final ProgressMonitor monitor,
+			final FetchResult result) throws NotSupportedException,
+			TransportException {
 		conn = transport.openFetch();
 		try {
 			result.setAdvertisedRefs(transport.getURI(), conn.getRefsMap());
@@ -177,7 +192,12 @@ else if (tagopt == TagOpt.FETCH_TAGS)
 
 	private void fetchObjects(final ProgressMonitor monitor)
 			throws TransportException {
-		conn.fetch(monitor, askFor.values(), have);
+		try {
+			conn.setPackLockMessage("jgit fetch " + transport.uri);
+			conn.fetch(monitor, askFor.values(), have);
+		} finally {
+			packLocks.addAll(conn.getPackLocks());
+		}
 		if (transport.isCheckFetchedObjects()
 				&& !conn.didFetchTestConnectivity() && !askForIsComplete())
 			throw new TransportException(transport.getURI(),
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index eeeae16..1d709ac 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -65,6 +65,7 @@
 import org.spearce.jgit.lib.ObjectIdSubclassMap;
 import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.PackIndexWriter;
+import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.WindowCursor;
@@ -996,9 +997,30 @@ UnresolvedDelta(final long headerOffset, final int crc32) {
 	 *             removed prior to throwing the exception to the caller.
 	 */
 	public void renameAndOpenPack() throws IOException {
+		renameAndOpenPack(null);
+	}
+
+	/**
+	 * Rename the pack to it's final name and location and open it.
+	 * <p>
+	 * If the call completes successfully the repository this IndexPack instance
+	 * was created with will have the objects in the pack available for reading
+	 * and use, without needing to scan for packs.
+	 * 
+	 * @param lockMessage
+	 *            message to place in the pack-*.keep file. If null, no lock
+	 *            will be created, and this method returns null.
+	 * @return the pack lock object, if lockMessage is not null.
+	 * @throws IOException
+	 *             The pack could not be inserted into the repository's objects
+	 *             directory. The pack no longer exists on disk, as it was
+	 *             removed prior to throwing the exception to the caller.
+	 */
+	public PackLock renameAndOpenPack(final String lockMessage)
+			throws IOException {
 		if (!keepEmpty && entryCount == 0) {
 			cleanupTemporaryFiles();
-			return;
+			return null;
 		}
 
 		final MessageDigest d = Constants.newMessageDigest();
@@ -1013,21 +1035,37 @@ public void renameAndOpenPack() throws IOException {
 		final File packDir = new File(repo.getObjectsDirectory(), "pack");
 		final File finalPack = new File(packDir, "pack-" + name + ".pack");
 		final File finalIdx = new File(packDir, "pack-" + name + ".idx");
+		final PackLock keep = new PackLock(finalPack);
 
 		if (finalPack.exists()) {
 			// If the pack is already present we should never replace it.
 			//
 			cleanupTemporaryFiles();
-			return;
+			return null;
+		}
+
+		if (lockMessage != null) {
+			// If we have a reason to create a keep file for this pack, do
+			// so, or fail fast and don't put the pack in place.
+			//
+			try {
+				if (!keep.lock(lockMessage))
+					throw new IOException("Cannot lock pack in " + finalPack);
+			} catch (IOException e) {
+				cleanupTemporaryFiles();
+				throw e;
+			}
 		}
 
 		if (!dstPack.renameTo(finalPack)) {
 			cleanupTemporaryFiles();
+			keep.unlock();
 			throw new IOException("Cannot move pack to " + finalPack);
 		}
 
 		if (!dstIdx.renameTo(finalIdx)) {
 			cleanupTemporaryFiles();
+			keep.unlock();
 			if (!finalPack.delete())
 				finalPack.deleteOnExit();
 			throw new IOException("Cannot move index to " + finalIdx);
@@ -1036,10 +1074,13 @@ public void renameAndOpenPack() throws IOException {
 		try {
 			repo.openPack(finalPack, finalIdx);
 		} catch (IOException err) {
+			keep.unlock();
 			finalPack.delete();
 			finalIdx.delete();
 			throw err;
 		}
+
+		return lockMessage != null ? keep : null;
 	}
 
 	private void cleanupTemporaryFiles() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index 89ddafe..7d20079 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -57,6 +57,7 @@
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.NullProgressMonitor;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.RefComparator;
@@ -129,6 +130,9 @@
 	/** if {@link #enabledCapablities} has {@link #CAPABILITY_REPORT_STATUS} */
 	private boolean reportStatus;
 
+	/** Lock around the received pack file, while updating refs. */
+	private PackLock packLock;
+
 	/**
 	 * Create a new pack receive for an open repository.
 	 *
@@ -379,6 +383,7 @@ public void println() {
 					msgs.flush();
 				}
 			} finally {
+				unlockPack();
 				rawIn = null;
 				rawOut = null;
 				pckIn = null;
@@ -416,6 +421,7 @@ private void service() throws IOException {
 				validateCommands();
 				executeCommands();
 			}
+			unlockPack();
 
 			if (reportStatus) {
 				sendStatusReport(true, new Reporter() {
@@ -437,6 +443,13 @@ void sendString(final String s) throws IOException {
 		}
 	}
 
+	private void unlockPack() {
+		if (packLock != null) {
+			packLock.unlock();
+			packLock = null;
+		}
+	}
+
 	private void sendAdvertisedRefs() throws IOException {
 		refs = db.getAllRefs();
 
@@ -534,7 +547,11 @@ private void receivePack() throws IOException {
 		ip.setFixThin(true);
 		ip.setObjectChecking(isCheckReceivedObjects());
 		ip.index(NullProgressMonitor.INSTANCE);
-		ip.renameAndOpenPack();
+		
+		String lockMsg = "jgit receive-pack";
+		if (getRefLogIdent() != null)
+			lockMsg += " from " + getRefLogIdent().toExternalString();
+		packLock = ip.renameAndOpenPack(lockMsg);
 	}
 
 	private void checkConnectivity() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 6912a1f..06b2c87 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -64,6 +64,7 @@
 import org.spearce.jgit.lib.ObjectChecker;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PackIndex;
+import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
@@ -167,6 +168,10 @@
 	 */
 	private final HashMap<ObjectId, List<Throwable>> fetchErrors;
 
+	private String lockMessage;
+
+	private final List<PackLock> packLocks;
+
 	WalkFetchConnection(final WalkTransport t, final WalkRemoteObjectDatabase w) {
 		Transport wt = (Transport)t;
 		local = wt.local;
@@ -185,6 +190,7 @@ WalkFetchConnection(final WalkTransport t, final WalkRemoteObjectDatabase w) {
 		noAlternatesYet.add(w);
 
 		fetchErrors = new HashMap<ObjectId, List<Throwable>>();
+		packLocks = new ArrayList<PackLock>(4);
 
 		revWalk = new RevWalk(local);
 		treeWalk = new TreeWalk(local);
@@ -215,6 +221,14 @@ protected void doFetch(final ProgressMonitor monitor,
 		}
 	}
 
+	public Collection<PackLock> getPackLocks() {
+		return packLocks;
+	}
+
+	public void setPackLockMessage(final String message) {
+		lockMessage = message;
+	}
+
 	@Override
 	public void close() {
 		for (final RemotePack p : unfetchedPacks)
@@ -857,7 +871,9 @@ void downloadPack(final ProgressMonitor monitor) throws IOException {
 			ip.setFixThin(false);
 			ip.setObjectChecker(objCheck);
 			ip.index(monitor);
-			ip.renameAndOpenPack();
+			final PackLock keep = ip.renameAndOpenPack(lockMessage);
+			if (keep != null)
+				packLocks.add(keep);
 		}
 	}
 }
-- 
1.6.3.rc4.206.g03e16
