From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/28] Fix deadlock caused by push over SSH
Date: Thu, 17 Jul 2008 21:43:54 -0400
Message-ID: <1216345461-59382-2-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2H-0005th-3k
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbYGRBo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757486AbYGRBoZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:44:25 -0400
Received: from george.spearce.org ([209.20.77.23]:46935 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbYGRBoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 55AEC383A8; Fri, 18 Jul 2008 01:44:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 60328382A4;
	Fri, 18 Jul 2008 01:44:22 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88950>

Push does not clean up the Transport correctly when it is done
so the JSch library still has user level threads running and we
do not close down the JVM.  We must close the transport.

This was broken by 2e05675201 ("Reuse the same SSH connection")
as the JSch session is held open inside of the Transport instance
in case there are additional calls made on the same Transport.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Push.java             |    8 ++++----
 .../org/spearce/jgit/transport/FetchProcess.java   |    2 +-
 .../spearce/jgit/transport/OperationResult.java    |   16 +++++++++++++++-
 .../org/spearce/jgit/transport/PushProcess.java    |    2 +-
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
index cbdf465..ef93f2f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
@@ -52,8 +52,6 @@ class Push extends TextBuiltin {
 
 	private boolean verbose = false;
 
-	private Transport transport;
-
 	private boolean first = true;
 
 	@Override
@@ -97,7 +95,7 @@ class Push extends TextBuiltin {
 			repository = "origin";
 		else
 			repository = args[argi++];
-		transport = Transport.open(db, repository);
+		final Transport transport = Transport.open(db, repository);
 		if (thin != null)
 			transport.setPushThin(thin);
 		if (exec != null)
@@ -114,6 +112,8 @@ class Push extends TextBuiltin {
 
 		final PushResult result = transport.push(new TextProgressMonitor(),
 				toPush);
+		transport.close();
+
 		printPushResult(result);
 	}
 
@@ -149,7 +149,7 @@ class Push extends TextBuiltin {
 			final RemoteRefUpdate rru) {
 		if (first) {
 			first = false;
-			out.format("To %s\n", transport.getURI());
+			out.format("To %s\n", result.getURI());
 		}
 
 		final String remoteName = rru.getRemoteName();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index f9c2266..e99869c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -97,7 +97,7 @@ class FetchProcess {
 
 		conn = transport.openFetch();
 		try {
-			result.setAdvertisedRefs(conn.getRefsMap());
+			result.setAdvertisedRefs(transport.getURI(), conn.getRefsMap());
 			final Set<Ref> matched = new HashSet<Ref>();
 			for (final RefSpec spec : toFetch) {
 				if (spec.getSource() == null)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
index 6700e85..a2e502c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OperationResult.java
@@ -55,9 +55,22 @@ public abstract class OperationResult {
 
 	protected Map<String, Ref> advertisedRefs = Collections.emptyMap();
 
+	protected URIish uri;
+
 	protected final SortedMap<String, TrackingRefUpdate> updates = new TreeMap<String, TrackingRefUpdate>();
 
 	/**
+	 * Get the URI this result came from.
+	 * <p>
+	 * Each transport instance connects to at most one URI at any point in time.
+	 * 
+	 * @return the URI describing the location of the remote repository.
+	 */
+	public URIish getURI() {
+		return uri;
+	}
+
+	/**
 	 * Get the complete list of refs advertised by the remote.
 	 * <p>
 	 * The returned refs may appear in any order. If the caller needs these to
@@ -109,7 +122,8 @@ public abstract class OperationResult {
 		return updates.get(localName);
 	}
 
-	protected void setAdvertisedRefs(final Map<String, Ref> ar) {
+	protected void setAdvertisedRefs(final URIish u, final Map<String, Ref> ar) {
+		uri = u;
 		advertisedRefs = ar;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
index 9e63f2f..6a2176f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
@@ -211,7 +211,7 @@ class PushProcess {
 
 	private PushResult prepareOperationResult() {
 		final PushResult result = new PushResult();
-		result.setAdvertisedRefs(connection.getRefsMap());
+		result.setAdvertisedRefs(transport.getURI(), connection.getRefsMap());
 		result.setRemoteUpdates(toPush);
 
 		for (final RemoteRefUpdate rru : toPush.values()) {
-- 
1.5.6.3.569.ga9185
