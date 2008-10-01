From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Honor receive.fsckobjects during any fetch connection
Date: Tue, 30 Sep 2008 18:31:30 -0700
Message-ID: <1222824690-7632-6-git-send-email-spearce@spearce.org>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org>
 <1222824690-7632-2-git-send-email-spearce@spearce.org>
 <1222824690-7632-3-git-send-email-spearce@spearce.org>
 <1222824690-7632-4-git-send-email-spearce@spearce.org>
 <1222824690-7632-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 03:33:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkqap-0006Nd-Ax
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 03:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbYJABbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 21:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbYJABbt
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 21:31:49 -0400
Received: from george.spearce.org ([209.20.77.23]:51635 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbYJABbh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 21:31:37 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 55F5E3835F; Wed,  1 Oct 2008 01:31:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6D69F38360;
	Wed,  1 Oct 2008 01:31:32 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.569.g798a2a
In-Reply-To: <1222824690-7632-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97180>

If the configuration option receive.fsckobjects is true or if the
application requests it on the Transport each object received over
the wire is validated to pass "git fsck" style rules.  This can be
useful when fetching data from an untrusted source, to ensure that
the incoming objects comply with parsing standards.

The optional checking does require extra CPU on the client side. A
test against git.git (69601 objects 49719 deltas) showed:

    receive.fsckobjects       average time
    --------------------------------------
    false (default)           0m17.588s
    true                      0m18.465s

So the additional checking costs about 5% more in client side time.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/BasePackFetchConnection.java    |    1 +
 .../src/org/spearce/jgit/transport/IndexPack.java  |   60 ++++++++++++++++++--
 .../src/org/spearce/jgit/transport/Transport.java  |   24 ++++++++
 .../spearce/jgit/transport/TransportBundle.java    |   10 +++-
 .../jgit/transport/WalkFetchConnection.java        |   26 +++++++--
 5 files changed, 108 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index a22b33d..a542eb7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -452,6 +452,7 @@ private void receivePack(final ProgressMonitor monitor) throws IOException {
 
 		ip = IndexPack.create(local, sideband ? pckIn.sideband(monitor) : in);
 		ip.setFixThin(thinPack);
+		ip.setObjectChecking(transport.isCheckFetchedObjects());
 		ip.index(monitor);
 		ip.renameAndOpenPack();
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 8a66ec9..ef1ee52 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -56,10 +56,12 @@
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.BinaryDelta;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.InflaterCache;
 import org.spearce.jgit.lib.MutableObjectId;
+import org.spearce.jgit.lib.ObjectChecker;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectIdMap;
 import org.spearce.jgit.lib.ObjectLoader;
@@ -136,6 +138,8 @@ public static IndexPack create(final Repository db, final InputStream is)
 
 	private int bAvail;
 
+	private ObjectChecker objCheck;
+
 	private boolean fixThin;
 
 	private int outputVersion;
@@ -231,6 +235,40 @@ public void setFixThin(final boolean fix) {
 	}
 
 	/**
+	 * Configure the checker used to validate received objects.
+	 * <p>
+	 * Usually object checking isn't necessary, as Git implementations only
+	 * create valid objects in pack files. However, additional checking may be
+	 * useful if processing data from an untrusted source.
+	 * 
+	 * @param oc
+	 *            the checker instance; null to disable object checking.
+	 */
+	public void setObjectChecker(final ObjectChecker oc) {
+		objCheck = oc;
+	}
+
+	/**
+	 * Configure the checker used to validate received objects.
+	 * <p>
+	 * Usually object checking isn't necessary, as Git implementations only
+	 * create valid objects in pack files. However, additional checking may be
+	 * useful if processing data from an untrusted source.
+	 * <p>
+	 * This is shorthand for:
+	 * 
+	 * <pre>
+	 * setObjectChecker(on ? new ObjectChecker() : null);
+	 * </pre>
+	 * 
+	 * @param on
+	 *            true to enable the default checker; false to disable it.
+	 */
+	public void setObjectChecking(final boolean on) {
+		setObjectChecker(on ? new ObjectChecker() : null);
+	}
+
+	/**
 	 * Consume data from the input stream until the packfile is indexed.
 	 * 
 	 * @param progress
@@ -375,7 +413,7 @@ private void resolveDeltas(final long pos, final int oldCRC, int type,
 			objectDigest.update(data);
 			tempObjectId.fromRaw(objectDigest.digest(), 0);
 
-			verifyNoCollision(type, data);
+			verifySafeObject(tempObjectId, type, data);
 			oe = new PackedObjectInfo(pos, crc32, tempObjectId);
 			entries[entryCount++] = oe;
 		}
@@ -658,18 +696,28 @@ private void whole(final int type, final long pos, final long sz)
 		objectDigest.update(data);
 		tempObjectId.fromRaw(objectDigest.digest(), 0);
 
-		verifyNoCollision(type, data);
+		verifySafeObject(tempObjectId, type, data);
 		final int crc32 = (int) crc.getValue();
 		entries[entryCount++] = new PackedObjectInfo(pos, crc32, tempObjectId);
 	}
 
-	private void verifyNoCollision(final int type, final byte[] data)
-			throws IOException {
-		final ObjectLoader ldr = repo.openObject(tempObjectId);
+	private void verifySafeObject(final AnyObjectId id, final int type,
+			final byte[] data) throws IOException {
+		if (objCheck != null) {
+			try {
+				objCheck.check(type, data);
+			} catch (CorruptObjectException e) {
+				throw new IOException("Invalid "
+						+ Constants.encodedTypeString(type) + " " + id.name()
+						+ ":" + e.getMessage());
+			}
+		}
+
+		final ObjectLoader ldr = repo.openObject(id);
 		if (ldr != null) {
 			final byte[] existingData = ldr.getCachedBytes();
 			if (ldr.getType() != type || !Arrays.equals(data, existingData)) {
-				throw new IOException("collision in " + tempObjectId.name());
+				throw new IOException("Collision on " + id.name());
 			}
 		}
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 7284b28..28700b7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -55,6 +55,7 @@
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.TransferConfig;
 
 /**
  * Connects two Git repositories together and copies objects between them.
@@ -351,6 +352,9 @@ private static String findTrackingRefName(final String remoteName,
 	/** Should push just check for operation result, not really push. */
 	private boolean dryRun;
 
+	/** Should an incoming (fetch) transfer validate objects? */
+	private boolean checkFetchedObjects;
+
 	/**
 	 * Create a new transport instance.
 	 * 
@@ -363,8 +367,10 @@ private static String findTrackingRefName(final String remoteName,
 	 *            URI passed to {@link #open(Repository, URIish)}.
 	 */
 	protected Transport(final Repository local, final URIish uri) {
+		final TransferConfig tc = local.getConfig().getTransfer();
 		this.local = local;
 		this.uri = uri;
+		this.checkFetchedObjects = tc.isFsckObjects();
 	}
 
 	/**
@@ -444,6 +450,24 @@ public void setFetchThin(final boolean fetchThin) {
 	}
 
 	/**
+	 * @return true if fetch will verify received objects are formatted
+	 *         correctly. Validating objects requires more CPU time on the
+	 *         client side of the connection.
+	 */
+	public boolean isCheckFetchedObjects() {
+		return checkFetchedObjects;
+	}
+
+	/**
+	 * @param check
+	 *            true to enable checking received objects; false to assume all
+	 *            received objects are valid.
+	 */
+	public void setCheckFetchedObjects(final boolean check) {
+		checkFetchedObjects = check;
+	}
+
+	/**
 	 * Default setting is: {@value RemoteConfig#DEFAULT_RECEIVE_PACK}
 	 *
 	 * @return remote executable providing receive-pack service for pack
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index d43a18f..5b321a0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -170,8 +170,7 @@ protected void doFetch(final ProgressMonitor monitor,
 				final Collection<Ref> want) throws TransportException {
 			verifyPrerequisites();
 			try {
-				final IndexPack ip = IndexPack.create(local, bin);
-				ip.setFixThin(true);
+				final IndexPack ip = newIndexPack();
 				ip.index(monitor);
 				ip.renameAndOpenPack();
 			} catch (IOException err) {
@@ -183,6 +182,13 @@ protected void doFetch(final ProgressMonitor monitor,
 			}
 		}
 
+		private IndexPack newIndexPack() throws IOException {
+			final IndexPack ip = IndexPack.create(local, bin);
+			ip.setFixThin(true);
+			ip.setObjectChecking(TransportBundle.this.isCheckFetchedObjects());
+			return ip;
+		}
+
 		private void verifyPrerequisites() throws TransportException {
 			if (prereqs.isEmpty())
 				return;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index f309fe1..5638454 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -59,6 +59,7 @@
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectChecker;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PackIndex;
 import org.spearce.jgit.lib.ProgressMonitor;
@@ -99,6 +100,9 @@
 	/** The repository this transport fetches into, or pushes out of. */
 	private final Repository local;
 
+	/** If not null the validator for received objects. */
+	private final ObjectChecker objCheck;
+
 	/**
 	 * List of all remote repositories we may need to get objects out of.
 	 * <p>
@@ -157,9 +161,9 @@
 	 */
 	private final HashMap<ObjectId, List<Throwable>> fetchErrors;
 
-	WalkFetchConnection(final WalkTransport walkTransport,
-			final WalkRemoteObjectDatabase w) {
-		local = walkTransport.local;
+	WalkFetchConnection(final WalkTransport wt, final WalkRemoteObjectDatabase w) {
+		local = wt.local;
+		objCheck = wt.isCheckFetchedObjects() ? new ObjectChecker() : null;
 
 		remotes = new ArrayList<WalkRemoteObjectDatabase>();
 		remotes.add(w);
@@ -560,10 +564,21 @@ private void verifyLooseObject(final AnyObjectId id, final byte[] compressed)
 			throw e;
 		}
 
-		if (!AnyObjectId.equals(id, uol.getId()))
+		if (!AnyObjectId.equals(id, uol.getId())) {
 			throw new TransportException("Incorrect hash for " + id.name()
 					+ "; computed " + uol.getId().name() + " as a "
-					+ uol.getType() + " from " + compressed.length + " bytes.");
+					+ Constants.encodedTypeString(uol.getType()) + " from "
+					+ compressed.length + " bytes.");
+		}
+		if (objCheck != null) {
+			try {
+				objCheck.check(uol.getType(), uol.getCachedBytes());
+			} catch (CorruptObjectException e) {
+				throw new TransportException("Invalid "
+						+ Constants.encodedTypeString(uol.getType()) + " "
+						+ id.name() + ":" + e.getMessage());
+			}
+		}
 	}
 
 	private void saveLooseObject(final AnyObjectId id, final byte[] compressed)
@@ -811,6 +826,7 @@ void downloadPack(final ProgressMonitor monitor) throws IOException {
 			s = connection.open("pack/" + packName);
 			ip = IndexPack.create(local, s.in);
 			ip.setFixThin(false);
+			ip.setObjectChecker(objCheck);
 			ip.index(monitor);
 			ip.renameAndOpenPack();
 		}
-- 
1.6.0.2.569.g798a2a
