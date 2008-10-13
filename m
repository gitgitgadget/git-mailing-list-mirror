From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Check object connectivity during fetch if fsck is enabled
Date: Mon, 13 Oct 2008 10:36:40 -0700
Message-ID: <1223919401-15873-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:38:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRMj-00079b-NH
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbYJMRgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbYJMRgo
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:36:44 -0400
Received: from george.spearce.org ([209.20.77.23]:35098 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbYJMRgn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:36:43 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E6A9638368; Mon, 13 Oct 2008 17:36:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2995E3826E;
	Mon, 13 Oct 2008 17:36:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98129>

If we are fetching over a pack oriented connection and we are doing
object-level fsck validation we need to also verify the graph is
fully connected after the fetch is complete.  This additional check
is necessary to ensure the peer didn't omit objects that we don't
have, but which are listed as needing to be present.

On the walk style fetch connection we can bypass this check, as the
connectivity was implicitly verified by the walker as it downloaded
objects and built its queue of things to fetch.  Native pack and
bundle transports however do not have this check built into them,
and require that we execute the work ourselves.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is a follow-on to my fsck during fetch series, which is already
 in master.  Making calls to ObjectChecker isn't enough as it does
 not check the DAG's connectivity.

 .../jgit/transport/BasePackFetchConnection.java    |    4 +++
 .../spearce/jgit/transport/FetchConnection.java    |   22 ++++++++++++++++++++
 .../org/spearce/jgit/transport/FetchProcess.java   |   13 ++++++++++-
 .../spearce/jgit/transport/TransportBundle.java    |    4 +++
 .../jgit/transport/WalkFetchConnection.java        |    4 +++
 5 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index a542eb7..542a8a9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -146,6 +146,10 @@ public boolean didFetchIncludeTags() {
 		return false;
 	}
 
+	public boolean didFetchTestConnectivity() {
+		return false;
+	}
+
 	protected void doFetch(final ProgressMonitor monitor,
 			final Collection<Ref> want) throws TransportException {
 		try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
index 9d25b0d..d93972d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchConnection.java
@@ -111,4 +111,26 @@ public void fetch(final ProgressMonitor monitor, final Collection<Ref> want)
 	 *         false if tags were not implicitly obtained.
 	 */
 	public boolean didFetchIncludeTags();
+
+	/**
+	 * Did the last {@link #fetch(ProgressMonitor, Collection)} validate graph?
+	 * <p>
+	 * Some transports walk the object graph on the client side, with the client
+	 * looking for what objects it is missing and requesting them individually
+	 * from the remote peer. By virtue of completing the fetch call the client
+	 * implicitly tested the object connectivity, as every object in the graph
+	 * was either already local or was requested successfully from the peer. In
+	 * such transports this method returns true.
+	 * <p>
+	 * Some transports assume the remote peer knows the Git object graph and is
+	 * able to supply a fully connected graph to the client (although it may
+	 * only be transferring the parts the client does not yet have). Its faster
+	 * to assume such remote peers are well behaved and send the correct
+	 * response to the client. In such tranports this method returns false.
+	 * 
+	 * @return true if the last fetch had to perform a connectivity check on the
+	 *         client side in order to succeed; false if the last fetch assumed
+	 *         the remote peer supplied a complete graph.
+	 */
+	public boolean didFetchTestConnectivity();
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index 654572d..bb2d051 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -118,7 +118,7 @@ else if (tagopt == TagOpt.FETCH_TAGS)
 
 			final boolean includedTags;
 			if (!askFor.isEmpty() && !askForIsComplete()) {
-				conn.fetch(monitor, askFor.values());
+				fetchObjects(monitor);
 				includedTags = conn.didFetchIncludeTags();
 
 				// Connection was used for object transfer. If we
@@ -143,7 +143,7 @@ else if (tagopt == TagOpt.FETCH_TAGS)
 				if (!askFor.isEmpty() && (!includedTags || !askForIsComplete())) {
 					reopenConnection();
 					if (!askFor.isEmpty())
-						conn.fetch(monitor, askFor.values());
+						fetchObjects(monitor);
 				}
 			}
 		} finally {
@@ -171,6 +171,15 @@ else if (tagopt == TagOpt.FETCH_TAGS)
 		}
 	}
 
+	private void fetchObjects(final ProgressMonitor monitor)
+			throws TransportException {
+		conn.fetch(monitor, askFor.values());
+		if (transport.isCheckFetchedObjects()
+				&& !conn.didFetchTestConnectivity() && !askForIsComplete())
+			throw new TransportException(transport.getURI(),
+					"peer did not supply a complete object graph");
+	}
+
 	private void closeConnection() {
 		if (conn != null) {
 			conn.close();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 5b321a0..7d38b02 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -165,6 +165,10 @@ private String readLine(final byte[] hdrbuf) throws IOException {
 			return RawParseUtils.decode(Constants.CHARSET, hdrbuf, 0, lf);
 		}
 
+		public boolean didFetchTestConnectivity() {
+			return false;
+		}
+
 		@Override
 		protected void doFetch(final ProgressMonitor monitor,
 				final Collection<Ref> want) throws TransportException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
index 5638454..d089f7b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkFetchConnection.java
@@ -189,6 +189,10 @@ WalkFetchConnection(final WalkTransport wt, final WalkRemoteObjectDatabase w) {
 		workQueue = new LinkedList<ObjectId>();
 	}
 
+	public boolean didFetchTestConnectivity() {
+		return true;
+	}
+
 	@Override
 	protected void doFetch(final ProgressMonitor monitor,
 			final Collection<Ref> want) throws TransportException {
-- 
1.6.0.2.706.g340fc
