From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] pgm.push: Ensure SSH connections are closed
Date: Wed, 27 Aug 2008 16:02:06 -0700
Message-ID: <1219878126-18622-2-git-send-email-spearce@spearce.org>
References: <1219878126-18622-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYU2v-00085z-8D
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbYH0XCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbYH0XCL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:02:11 -0400
Received: from george.spearce.org ([209.20.77.23]:55164 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbYH0XCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:02:08 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8E08F38378; Wed, 27 Aug 2008 23:02:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 19A3138375;
	Wed, 27 Aug 2008 23:02:07 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
In-Reply-To: <1219878126-18622-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93975>

If we don't close the transport when we are done with it
the SSH session stored within the Transport will still be
opened to the remote side.  JSch may have created one or
more background user threads to handle that connection,
which means the JVM won't terminate cleanly when we are
done with our work.

We must close each and every transport we opened.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Push.java             |   24 ++++++++++++-------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index f53f2fe..53ad080 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -50,6 +50,7 @@
 import org.spearce.jgit.transport.RefSpec;
 import org.spearce.jgit.transport.RemoteRefUpdate;
 import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.URIish;
 import org.spearce.jgit.transport.RemoteRefUpdate.Status;
 
 @Command(common = true, usage = "Update remote repository from local refs")
@@ -111,13 +112,18 @@ protected void run() throws Exception {
 			final Collection<RemoteRefUpdate> toPush = transport
 					.findRemoteRefUpdatesFor(refSpecs);
 
-			final PushResult result = transport.push(new TextProgressMonitor(),
-					toPush);
-			printPushResult(transport, result);
+			final URIish uri = transport.getURI();
+			final PushResult result;
+			try {
+				result = transport.push(new TextProgressMonitor(), toPush);
+			} finally {
+				transport.close();
+			}
+			printPushResult(uri, result);
 		}
 	}
 
-	private void printPushResult(final Transport transport,
+	private void printPushResult(final URIish uri,
 			final PushResult result) {
 		shownURI = false;
 		boolean everythingUpToDate = true;
@@ -126,7 +132,7 @@ private void printPushResult(final Transport transport,
 		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
 			if (rru.getStatus() == Status.UP_TO_DATE) {
 				if (verbose)
-					printRefUpdateResult(transport, result, rru);
+					printRefUpdateResult(uri, result, rru);
 			} else
 				everythingUpToDate = false;
 		}
@@ -134,25 +140,25 @@ private void printPushResult(final Transport transport,
 		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
 			// ...then successful updates...
 			if (rru.getStatus() == Status.OK)
-				printRefUpdateResult(transport, result, rru);
+				printRefUpdateResult(uri, result, rru);
 		}
 
 		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
 			// ...finally, others (problematic)
 			if (rru.getStatus() != Status.OK
 					&& rru.getStatus() != Status.UP_TO_DATE)
-				printRefUpdateResult(transport, result, rru);
+				printRefUpdateResult(uri, result, rru);
 		}
 
 		if (everythingUpToDate)
 			out.println("Everything up-to-date");
 	}
 
-	private void printRefUpdateResult(final Transport transport,
+	private void printRefUpdateResult(final URIish uri,
 			final PushResult result, final RemoteRefUpdate rru) {
 		if (!shownURI) {
 			shownURI = true;
-			out.format("To %s\n", transport.getURI());
+			out.format("To %s\n", uri);
 		}
 
 		final String remoteName = rru.getRemoteName();
-- 
1.6.0.174.gd789c
