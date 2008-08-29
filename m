From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Disambiguate "push not supported" from "repository not found"
Date: Thu, 28 Aug 2008 17:18:38 -0700
Message-ID: <1219969118-31672-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYriW-0007fV-R1
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbYH2ASl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbYH2ASl
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:18:41 -0400
Received: from george.spearce.org ([209.20.77.23]:44470 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbYH2ASk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:18:40 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id BE17038376; Fri, 29 Aug 2008 00:18:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1AFF338360;
	Fri, 29 Aug 2008 00:18:39 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94234>

If we are pushing to a remote repository the reason why we
get no refs may be because push is not permitted, or it is
a bad URI and points to a non-existant repository.

To get a good error message for the user we need to open a
fetch connection to see if fetch also fails.  If it failed
we know the URI is invalid; if fetch succeeds we know that
the repository is there but the user is just not allowed to
push to it over this transport.

With this change we now get useful error messages:

  $ ./jgit.sh push git://repo.or.cz/egit.git refs/heads/master
  fatal: git://repo.or.cz/egit.git: push not permitted

  $ ./jgit.sh push git://repo.or.cz/fake.git refs/heads/master
  fatal: git://repo.or.cz/fake.git: not found.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BasePackConnection.java |   19 ++++++++-------
 .../jgit/transport/BasePackPushConnection.java     |   25 ++++++++++++++++++++
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index de0c7b6..e35f850 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -72,6 +72,9 @@
 	/** Remote repository location. */
 	protected final URIish uri;
 
+	/** A transport connected to {@link #uri}. */
+	protected final PackTransport transport;
+
 	/** Buffered input stream reading from the remote. */
 	protected InputStream in;
 
@@ -93,6 +96,7 @@
 	BasePackConnection(final PackTransport packTransport) {
 		local = packTransport.local;
 		uri = packTransport.uri;
+		transport = packTransport;
 	}
 
 	protected void init(final InputStream myIn, final OutputStream myOut) {
@@ -129,15 +133,8 @@ private void readAdvertisedRefsImpl() throws IOException {
 			try {
 				line = pckIn.readString();
 			} catch (EOFException eof) {
-				if (avail.isEmpty()) {
-					String service = "unknown";
-					if (this instanceof PushConnection)
-						service = "push";
-					else if (this instanceof FetchConnection)
-						service = "fetch";
-					throw new NoRemoteRepositoryException(uri, service
-							+ " service not found.");
-				}
+				if (avail.isEmpty())
+					throw noRepository();
 				throw eof;
 			}
 
@@ -185,6 +182,10 @@ else if (this instanceof FetchConnection)
 		available(avail);
 	}
 
+	protected TransportException noRepository() {
+		return new NoRemoteRepositoryException(uri, "not found.");
+	}
+
 	protected boolean isCapableOf(final String option) {
 		return remoteCapablities.contains(option);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index a2d5b6f..a6ab9c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -43,6 +43,8 @@
 import java.util.Collection;
 import java.util.Map;
 
+import org.spearce.jgit.errors.NoRemoteRepositoryException;
+import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.PackProtocolException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ObjectId;
@@ -98,6 +100,29 @@ public void push(final ProgressMonitor monitor,
 		doPush(monitor, refUpdates);
 	}
 
+	@Override
+	protected TransportException noRepository() {
+		// Sadly we cannot tell the "invalid URI" case from "push not allowed".
+		// Opening a fetch connection can help us tell the difference, as any
+		// useful repository is going to support fetch if it also would allow
+		// push. So if fetch throws NoRemoteRepositoryException we know the
+		// URI is wrong. Otherwise we can correctly state push isn't allowed
+		// as the fetch connection opened successfully.
+		//
+		try {
+			transport.openFetch().close();
+		} catch (NotSupportedException e) {
+			// Fall through.
+		} catch (NoRemoteRepositoryException e) {
+			// Fetch concluded the repository doesn't exist.
+			//
+			return e;
+		} catch (TransportException e) {
+			// Fall through.
+		}
+		return new TransportException(uri, "push not permitted");
+	}
+
 	protected void doPush(final ProgressMonitor monitor,
 			final Map<String, RemoteRefUpdate> refUpdates)
 			throws TransportException {
-- 
1.6.0.174.gd789c
