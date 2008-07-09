From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/4] Avoid deadlock while fetching from local repository
Date: Wed,  9 Jul 2008 00:15:28 -0400
Message-ID: <1215576931-4174-2-git-send-email-spearce@spearce.org>
References: <1215576931-4174-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 06:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGR6V-0004EZ-VH
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 06:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbYGIEPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 00:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbYGIEPf
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 00:15:35 -0400
Received: from george.spearce.org ([209.20.77.23]:46870 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYGIEPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 00:15:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 144A03821F; Wed,  9 Jul 2008 04:15:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 80F5F38195;
	Wed,  9 Jul 2008 04:15:32 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1215576931-4174-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87840>

We cannot send a packet line end command to git-upload-pack after we
have sent our want list and obtained a pack back from it.  Once the
want list has ended git-upload-pack wants no further data sent to
it, and attempting to write more may cause us to deadlock as the
pipe won't accept the data.

Not sending the packet line end if we don't send a want list is a
(minor) protocol error.  To avoid these protocol errors (which
may display on stderr from git-upload-pack) we still send the end
during close if we have not yet sent a want list.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BasePackConnection.java |    7 ++++++-
 .../jgit/transport/BasePackFetchConnection.java    |    1 +
 .../jgit/transport/BasePackPushConnection.java     |    1 +
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index a878f01..7dc4620 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -83,6 +83,9 @@ abstract class BasePackConnection extends BaseConnection {
 	/** Packet line encoder around {@link #out}. */
 	protected PacketLineOut pckOut;
 
+	/** Send {@link PacketLineOut#end()} before closing {@link #out}? */
+	protected boolean outNeedsEnd;
+
 	/** Capability tokens advertised by the remote side. */
 	private final Set<String> remoteCapablities = new HashSet<String>();
 
@@ -99,6 +102,7 @@ abstract class BasePackConnection extends BaseConnection {
 
 		pckIn = new PacketLineIn(in);
 		pckOut = new PacketLineOut(out);
+		outNeedsEnd = true;
 	}
 
 	protected void readAdvertisedRefs() throws TransportException {
@@ -195,7 +199,8 @@ abstract class BasePackConnection extends BaseConnection {
 	public void close() {
 		if (out != null) {
 			try {
-				pckOut.end();
+				if (outNeedsEnd)
+					pckOut.end();
 				out.close();
 			} catch (IOException err) {
 				// Ignore any close errors.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 04a91bf..12b36f2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -253,6 +253,7 @@ abstract class BasePackFetchConnection extends BasePackConnection implements
 			pckOut.writeString(line.toString());
 		}
 		pckOut.end();
+		outNeedsEnd = false;
 		return !first;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 784a578..6d95eaf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -148,6 +148,7 @@ class BasePackPushConnection extends BasePackConnection implements
 		if (monitor.isCancelled())
 			throw new TransportException(uri, "push cancelled");
 		pckOut.end();
+		outNeedsEnd = false;
 	}
 
 	private String enableCapabilties() {
-- 
1.5.6.74.g8a5e
