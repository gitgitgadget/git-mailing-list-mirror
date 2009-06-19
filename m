From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/6] Add timeouts to smart transport protocol servers
Date: Fri, 19 Jun 2009 14:27:53 -0700
Message-ID: <1245446875-31102-5-git-send-email-spearce@spearce.org>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org>
 <1245446875-31102-2-git-send-email-spearce@spearce.org>
 <1245446875-31102-3-git-send-email-spearce@spearce.org>
 <1245446875-31102-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHldd-0002a5-90
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 23:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126AbZFSV2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 17:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbZFSV2K
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 17:28:10 -0400
Received: from george.spearce.org ([209.20.77.23]:42462 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbZFSV17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 17:27:59 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 30826381FD; Fri, 19 Jun 2009 21:28:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 34FB7381FF;
	Fri, 19 Jun 2009 21:27:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
In-Reply-To: <1245446875-31102-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121915>

Like with the client side support, we spawn a background thread and
use that to wake up the real service thread if it blocks too long in
a read or write operation.  Typically this sort of long running IO
indicates the client is not responding, and the server should abort
its transaction and disconnect the client.

Like with the push client, the push server doesn't know when the
client will be done computing its pack file and start sending it
to the server.  Consequently we aren't entirely sure when we can
safely say the client is dead, vs. the client is just busy doing
its local compression work before transmitting.  By upping our
timeout to 10x the originally configured value we can give the
client a reasonable chance to finish packing data before we do
wind up aborting.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/ReceivePack.java    |   57 +++++++++++++++++++
 .../src/org/spearce/jgit/transport/UploadPack.java |   59 ++++++++++++++++++--
 2 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index c92a903..16b0c57 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -69,6 +69,9 @@
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.transport.ReceiveCommand.Result;
+import org.spearce.jgit.util.io.InterruptTimer;
+import org.spearce.jgit.util.io.TimeoutInputStream;
+import org.spearce.jgit.util.io.TimeoutOutputStream;
 
 /**
  * Implements the server side of a push connection, receiving objects.
@@ -109,6 +112,14 @@
 	/** Hook to report on the commands after execution. */
 	private PostReceiveHook postReceive;
 
+	/** Timeout in seconds to wait for client interaction. */
+	private int timeout;
+
+	/** Timer to manage {@link #timeout}. */
+	private InterruptTimer timer;
+
+	private TimeoutInputStream timeoutIn;
+
 	private InputStream rawIn;
 
 	private OutputStream rawOut;
@@ -297,6 +308,23 @@ public void setPostReceiveHook(final PostReceiveHook h) {
 		postReceive = h != null ? h : PostReceiveHook.NULL;
 	}
 
+	/** @return timeout (in seconds) before aborting an IO operation. */
+	public int getTimeout() {
+		return timeout;
+	}
+
+	/**
+	 * Set the timeout before willing to abort an IO call.
+	 *
+	 * @param seconds
+	 *            number of seconds to wait (with no data transfer occurring)
+	 *            before aborting an IO read or write operation with the
+	 *            connected client.
+	 */
+	public void setTimeout(final int seconds) {
+		timeout = seconds;
+	}
+
 	/** @return all of the command received by the current request. */
 	public List<ReceiveCommand> getAllCommands() {
 		return Collections.unmodifiableList(commands);
@@ -365,6 +393,17 @@ public void receive(final InputStream input, final OutputStream output,
 			rawIn = input;
 			rawOut = output;
 
+			if (timeout > 0) {
+				final Thread caller = Thread.currentThread();
+				timer = new InterruptTimer(caller.getName() + "-Timer");
+				timeoutIn = new TimeoutInputStream(rawIn, timer);
+				TimeoutOutputStream o = new TimeoutOutputStream(rawOut, timer);
+				timeoutIn.setTimeout(timeout * 1000);
+				o.setTimeout(timeout * 1000);
+				rawIn = timeoutIn;
+				rawOut = o;
+			}
+
 			pckIn = new PacketLineIn(rawIn);
 			pckOut = new PacketLineOut(rawOut);
 			if (messages != null) {
@@ -389,6 +428,7 @@ public void println() {
 				}
 			} finally {
 				unlockPack();
+				timeoutIn = null;
 				rawIn = null;
 				rawOut = null;
 				pckIn = null;
@@ -397,6 +437,13 @@ public void println() {
 				refs = null;
 				enabledCapablities = null;
 				commands = null;
+				if (timer != null) {
+					try {
+						timer.terminate();
+					} finally {
+						timer = null;
+					}
+				}
 			}
 		}
 	}
@@ -557,6 +604,13 @@ private boolean needPack() {
 	}
 
 	private void receivePack() throws IOException {
+		// It might take the client a while to pack the objects it needs
+		// to send to us.  We should increase our timeout so we don't
+		// abort while the client is computing.
+		//
+		if (timeoutIn != null)
+			timeoutIn.setTimeout(10 * timeout * 1000);
+
 		final IndexPack ip = IndexPack.create(db, rawIn);
 		ip.setFixThin(true);
 		ip.setObjectChecking(isCheckReceivedObjects());
@@ -566,6 +620,9 @@ private void receivePack() throws IOException {
 		if (getRefLogIdent() != null)
 			lockMsg += " from " + getRefLogIdent().toExternalString();
 		packLock = ip.renameAndOpenPack(lockMsg);
+
+		if (timeoutIn != null)
+			timeoutIn.setTimeout(timeout * 1000);
 	}
 
 	private void checkConnectivity() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index 7d17b2d..b0fa885 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -64,6 +64,9 @@
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevTag;
 import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.util.io.InterruptTimer;
+import org.spearce.jgit.util.io.TimeoutInputStream;
+import org.spearce.jgit.util.io.TimeoutOutputStream;
 
 /**
  * Implements the server side of a fetch connection, transmitting objects.
@@ -89,6 +92,12 @@
 	/** Revision traversal support over {@link #db}. */
 	private final RevWalk walk;
 
+	/** Timeout in seconds to wait for client interaction. */
+	private int timeout;
+
+	/** Timer to manage {@link #timeout}. */
+	private InterruptTimer timer;
+
 	private InputStream rawIn;
 
 	private OutputStream rawOut;
@@ -164,6 +173,23 @@ public final RevWalk getRevWalk() {
 		return walk;
 	}
 
+	/** @return timeout (in seconds) before aborting an IO operation. */
+	public int getTimeout() {
+		return timeout;
+	}
+
+	/**
+	 * Set the timeout before willing to abort an IO call.
+	 *
+	 * @param seconds
+	 *            number of seconds to wait (with no data transfer occurring)
+	 *            before aborting an IO read or write operation with the
+	 *            connected client.
+	 */
+	public void setTimeout(final int seconds) {
+		timeout = seconds;
+	}
+
 	/**
 	 * Execute the upload task on the socket.
 	 *
@@ -183,12 +209,33 @@ public final RevWalk getRevWalk() {
 	 */
 	public void upload(final InputStream input, final OutputStream output,
 			final OutputStream messages) throws IOException {
-		rawIn = input;
-		rawOut = output;
+		try {
+			rawIn = input;
+			rawOut = output;
+
+			if (timeout > 0) {
+				final Thread caller = Thread.currentThread();
+				timer = new InterruptTimer(caller.getName() + "-Timer");
+				TimeoutInputStream i = new TimeoutInputStream(rawIn, timer);
+				TimeoutOutputStream o = new TimeoutOutputStream(rawOut, timer);
+				i.setTimeout(timeout * 1000);
+				o.setTimeout(timeout * 1000);
+				rawIn = i;
+				rawOut = o;
+			}
 
-		pckIn = new PacketLineIn(rawIn);
-		pckOut = new PacketLineOut(rawOut);
-		service();
+			pckIn = new PacketLineIn(rawIn);
+			pckOut = new PacketLineOut(rawOut);
+			service();
+		} finally {
+			if (timer != null) {
+				try {
+					timer.terminate();
+				} finally {
+					timer = null;
+				}
+			}
+		}
 	}
 
 	private void service() throws IOException {
-- 
1.6.3.2.416.g04d0
