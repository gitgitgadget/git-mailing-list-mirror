From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Fix "fetch pulled too many objects" when auto-following tags
Date: Tue, 23 Dec 2008 10:03:43 -0800
Message-ID: <1230055423-9944-6-git-send-email-spearce@spearce.org>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org>
 <1230055423-9944-2-git-send-email-spearce@spearce.org>
 <1230055423-9944-3-git-send-email-spearce@spearce.org>
 <1230055423-9944-4-git-send-email-spearce@spearce.org>
 <1230055423-9944-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBde-0002sv-7e
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbYLWSEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 13:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbYLWSEH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 13:04:07 -0500
Received: from george.spearce.org ([209.20.77.23]:58232 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYLWSEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 13:04:06 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 19C8538211; Tue, 23 Dec 2008 18:04:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E322B3821F;
	Tue, 23 Dec 2008 18:03:44 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230055423-9944-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103842>

If we don't take into consideration the objects obtained during
the first connection when we open a second to auto-follow tags
we will download a large chunk of the repository a second time.
This is very wasteful of network bandwidth, and is an abuse of
the server.

Because we delay all ref updates until the very end of the fetch
process we need to hold onto the set of objects we requested in
the first connection, and pass that set into the subsequent one
so it can be considered reachable.

Issue: http://code.google.com/p/egit/issues/detail?id=22
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/BaseFetchConnection.java        |   26 ++++++++++++-------
 .../jgit/transport/BasePackFetchConnection.java    |   25 +++++++++++++++----
 .../spearce/jgit/transport/FetchConnection.java    |   21 +++++++++++----
 .../org/spearce/jgit/transport/FetchProcess.java   |    6 ++++-
 .../spearce/jgit/transport/TransportBundle.java    |    3 +-
 .../jgit/transport/WalkFetchConnection.java        |   14 ++++++++--
 6 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java
index 6709bfc..bb81296 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BaseFetchConnection.java
@@ -38,8 +38,10 @@
 package org.spearce.jgit.transport;
 
 import java.util.Collection;
+import java.util.Set;
 
 import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 
@@ -54,9 +56,10 @@
 abstract class BaseFetchConnection extends BaseConnection implements
 		FetchConnection {
 	public final void fetch(final ProgressMonitor monitor,
-			final Collection<Ref> want) throws TransportException {
+			final Collection<Ref> want, final Set<ObjectId> have)
+			throws TransportException {
 		markStartedOperation();
-		doFetch(monitor, want);
+		doFetch(monitor, want, have);
 	}
 
 	/**
@@ -68,19 +71,22 @@ public boolean didFetchIncludeTags() {
 	}
 
 	/**
-	 * Implementation of {@link #fetch(ProgressMonitor, Collection)} without
-	 * checking for multiple fetch.
+	 * Implementation of {@link #fetch(ProgressMonitor, Collection, Set)}
+	 * without checking for multiple fetch.
 	 *
 	 * @param monitor
-	 *            as in {@link #fetch(ProgressMonitor, Collection)}
+	 *            as in {@link #fetch(ProgressMonitor, Collection, Set)}
 	 * @param want
-	 *            as in {@link #fetch(ProgressMonitor, Collection)}
+	 *            as in {@link #fetch(ProgressMonitor, Collection, Set)}
+	 * @param have
+	 *            as in {@link #fetch(ProgressMonitor, Collection, Set)}
 	 * @throws TransportException
-	 *             as in {@link #fetch(ProgressMonitor, Collection)}, but
+	 *             as in {@link #fetch(ProgressMonitor, Collection, Set)}, but
 	 *             implementation doesn't have to care about multiple
-	 *             {@link #fetch(ProgressMonitor, Collection)} calls, as it is
-	 *             checked in this class.
+	 *             {@link #fetch(ProgressMonitor, Collection, Set)} calls, as it
+	 *             is checked in this class.
 	 */
 	protected abstract void doFetch(final ProgressMonitor monitor,
-			final Collection<Ref> want) throws TransportException;
+			final Collection<Ref> want, final Set<ObjectId> have)
+			throws TransportException;
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 542a8a9..2cb9b64 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -41,10 +41,12 @@
 import java.io.IOException;
 import java.util.Collection;
 import java.util.Date;
+import java.util.Set;
 
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.MutableObjectId;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revwalk.RevCommit;
@@ -137,9 +139,10 @@ BasePackFetchConnection(final PackTransport packTransport) {
 	}
 
 	public final void fetch(final ProgressMonitor monitor,
-			final Collection<Ref> want) throws TransportException {
+			final Collection<Ref> want, final Set<ObjectId> have)
+			throws TransportException {
 		markStartedOperation();
-		doFetch(monitor, want);
+		doFetch(monitor, want, have);
 	}
 
 	public boolean didFetchIncludeTags() {
@@ -151,10 +154,11 @@ public boolean didFetchTestConnectivity() {
 	}
 
 	protected void doFetch(final ProgressMonitor monitor,
-			final Collection<Ref> want) throws TransportException {
+			final Collection<Ref> want, final Set<ObjectId> have)
+			throws TransportException {
 		try {
 			markRefsAdvertised();
-			markReachable(maxTimeWanted(want));
+			markReachable(have, maxTimeWanted(want));
 
 			if (sendWants(want)) {
 				negotiate(monitor);
@@ -193,7 +197,8 @@ private int maxTimeWanted(final Collection<Ref> wants) {
 		return maxTime;
 	}
 
-	private void markReachable(final int maxTime) throws IOException {
+	private void markReachable(final Set<ObjectId> have, final int maxTime)
+			throws IOException {
 		for (final Ref r : local.getAllRefs().values()) {
 			try {
 				final RevCommit o = walk.parseCommit(r.getObjectId());
@@ -204,6 +209,16 @@ private void markReachable(final int maxTime) throws IOException {
 			}
 		}
 
+		for (final ObjectId id : have) {
+			try {
+				final RevCommit o = walk.parseCommit(id);
+				o.add(REACHABLE);
+				reachableCommits.add(o);
+			} catch (IOException readError) {
+				// If we cannot read the value of the ref skip it.
+			}
+		}
+
 		if (maxTime > 0) {
 			// Mark reachable commits until we reach maxTime. These may
 			// wind up later matching up against things we want and we
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
index a56ca6c..61ef219 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
@@ -38,8 +38,10 @@
 package org.spearce.jgit.transport;
 
 import java.util.Collection;
+import java.util.Set;
 
 import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 
@@ -85,23 +87,29 @@
 	 * @param want
 	 *            one or more refs advertised by this connection that the caller
 	 *            wants to store locally.
+	 * @param have
+	 *            additional objects known to exist in the destination
+	 *            repository, especially if they aren't yet reachable by the ref
+	 *            database. Connections should take this set as an addition to
+	 *            what is reachable through all Refs, not in replace of it.
 	 * @throws TransportException
 	 *             objects could not be copied due to a network failure,
 	 *             protocol error, or error on remote side, or connection was
 	 *             already used for fetch.
 	 */
-	public void fetch(final ProgressMonitor monitor, final Collection<Ref> want)
+	public void fetch(final ProgressMonitor monitor,
+			final Collection<Ref> want, final Set<ObjectId> have)
 			throws TransportException;
 
 	/**
-	 * Did the last {@link #fetch(ProgressMonitor, Collection)} get tags?
+	 * Did the last {@link #fetch(ProgressMonitor, Collection, Set)} get tags?
 	 * <p>
 	 * Some Git aware transports are able to implicitly grab an annotated tag if
 	 * {@link TagOpt#AUTO_FOLLOW} or {@link TagOpt#FETCH_TAGS} was selected and
 	 * the object the tag peels to (references) was transferred as part of the
-	 * last {@link #fetch(ProgressMonitor, Collection)} call. If it is possible
-	 * for such tags to have been included in the transfer this method returns
-	 * true, allowing the caller to attempt tag discovery.
+	 * last {@link #fetch(ProgressMonitor, Collection, Set)} call. If it is
+	 * possible for such tags to have been included in the transfer this method
+	 * returns true, allowing the caller to attempt tag discovery.
 	 * <p>
 	 * By returning only true/false (and not the actual list of tags obtained)
 	 * the transport itself does not need to be aware of whether or not tags
@@ -113,7 +121,8 @@ public void fetch(final ProgressMonitor monitor, final Collection<Ref> want)
 	public boolean didFetchIncludeTags();
 
 	/**
-	 * Did the last {@link #fetch(ProgressMonitor, Collection)} validate graph?
+	 * Did the last {@link #fetch(ProgressMonitor, Collection, Set)} validate
+	 * graph?
 	 * <p>
 	 * Some transports walk the object graph on the client side, with the client
 	 * looking for what objects it is missing and requesting them individually
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index bb2d051..09718eb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -75,6 +75,9 @@
 	/** Set of refs we will actually wind up asking to obtain. */
 	private final HashMap<ObjectId, Ref> askFor = new HashMap<ObjectId, Ref>();
 
+	/** Objects we know we have locally. */
+	private final HashSet<ObjectId> have = new HashSet<ObjectId>();
+
 	/** Updates to local tracking branches (if any). */
 	private final ArrayList<TrackingRefUpdate> localUpdates = new ArrayList<TrackingRefUpdate>();
 
@@ -133,6 +136,7 @@ else if (tagopt == TagOpt.FETCH_TAGS)
 				// There are more tags that we want to follow, but
 				// not all were asked for on the initial request.
 				//
+				have.addAll(askFor.keySet());
 				askFor.clear();
 				for (final Ref r : additionalTags) {
 					final ObjectId id = r.getPeeledObjectId();
@@ -173,7 +177,7 @@ else if (tagopt == TagOpt.FETCH_TAGS)
 
 	private void fetchObjects(final ProgressMonitor monitor)
 			throws TransportException {
-		conn.fetch(monitor, askFor.values());
+		conn.fetch(monitor, askFor.values(), have);
 		if (transport.isCheckFetchedObjects()
 				&& !conn.didFetchTestConnectivity() && !askForIsComplete())
 			throw new TransportException(transport.getURI(),
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 7d38b02..1734d94 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -171,7 +171,8 @@ public boolean didFetchTestConnectivity() {
 
 		@Override
 		protected void doFetch(final ProgressMonitor monitor,
-				final Collection<Ref> want) throws TransportException {
+				final Collection<Ref> want, final Set<ObjectId> have)
+				throws TransportException {
 			verifyPrerequisites();
 			try {
 				final IndexPack ip = newIndexPack();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index d089f7b..91c5ea8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -195,8 +195,9 @@ public boolean didFetchTestConnectivity() {
 
 	@Override
 	protected void doFetch(final ProgressMonitor monitor,
-			final Collection<Ref> want) throws TransportException {
-		markLocalRefsComplete();
+			final Collection<Ref> want, final Set<ObjectId> have)
+			throws TransportException {
+		markLocalRefsComplete(have);
 		queueWants(want);
 
 		while (!monitor.isCancelled() && !workQueue.isEmpty()) {
@@ -642,7 +643,7 @@ private void saveLooseObject(final AnyObjectId id, final byte[] compressed)
 		return null;
 	}
 
-	private void markLocalRefsComplete() throws TransportException {
+	private void markLocalRefsComplete(final Set<ObjectId> have) throws TransportException {
 		for (final Ref r : local.getAllRefs().values()) {
 			try {
 				markLocalObjComplete(revWalk.parseAny(r.getObjectId()));
@@ -651,6 +652,13 @@ private void markLocalRefsComplete() throws TransportException {
 						+ " is missing object(s).", readError);
 			}
 		}
+		for (final ObjectId id : have) {
+			try {
+				markLocalObjComplete(revWalk.parseAny(id));
+			} catch (IOException readError) {
+				throw new TransportException("Missing assumed "+id.name(), readError);
+			}
+		}
 	}
 
 	private void markLocalObjComplete(RevObject obj) throws IOException {
-- 
1.6.1.rc4.301.g5497a
