From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/6] Add timeouts to anonymous git:// daemon
Date: Fri, 19 Jun 2009 14:27:54 -0700
Message-ID: <1245446875-31102-6-git-send-email-spearce@spearce.org>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org>
 <1245446875-31102-2-git-send-email-spearce@spearce.org>
 <1245446875-31102-3-git-send-email-spearce@spearce.org>
 <1245446875-31102-4-git-send-email-spearce@spearce.org>
 <1245446875-31102-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:28:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHlde-0002a5-1r
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 23:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756257AbZFSV2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 17:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbZFSV2N
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 17:28:13 -0400
Received: from george.spearce.org ([209.20.77.23]:42465 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710AbZFSV2A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 17:28:00 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 34DFB381FF; Fri, 19 Jun 2009 21:28:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8D61F38215;
	Fri, 19 Jun 2009 21:27:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
In-Reply-To: <1245446875-31102-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121917>

If the initial command line isn't received within the configured
timeout period, the connection is dropped, and the service thread
is able to terminate.

The timeout is also pushed down to the service implementations,
so they can abort if the client doesn't speak to them within the
configured time span.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Daemon.java     |   26 ++++++++++++++++---
 .../org/spearce/jgit/transport/DaemonClient.java   |   12 +++++++--
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index be27732..3101d6f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -37,8 +37,6 @@
 
 package org.spearce.jgit.transport;
 
-import java.io.BufferedInputStream;
-import java.io.BufferedOutputStream;
 import java.io.File;
 import java.io.IOException;
 import java.io.InputStream;
@@ -79,6 +77,8 @@
 
 	private Thread acceptThread;
 
+	private int timeout;
+
 	/** Configure a daemon to listen on any available network port. */
 	public Daemon() {
 		this(null);
@@ -108,6 +108,7 @@ protected void execute(final DaemonClient dc,
 							final Repository db) throws IOException {
 						final UploadPack rp = new UploadPack(db);
 						final InputStream in = dc.getInputStream();
+						rp.setTimeout(Daemon.this.getTimeout());
 						rp.upload(in, dc.getOutputStream(), null);
 					}
 				}, new DaemonService("receive-pack", "receivepack") {
@@ -127,6 +128,7 @@ protected void execute(final DaemonClient dc,
 						final String name = "anonymous";
 						final String email = name + "@" + host;
 						rp.setRefLogIdent(new PersonIdent(name, email));
+						rp.setTimeout(Daemon.this.getTimeout());
 						rp.receive(in, dc.getOutputStream(), null);
 					}
 				} };
@@ -213,6 +215,23 @@ synchronized (exportBase) {
 		}
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
 	 * Start this daemon on a background thread.
 	 *
@@ -280,8 +299,7 @@ private void startClient(final Socket s) {
 		new Thread(processors, "Git-Daemon-Client " + peer.toString()) {
 			public void run() {
 				try {
-					dc.execute(new BufferedInputStream(s.getInputStream()),
-							new BufferedOutputStream(s.getOutputStream()));
+					dc.execute(s);
 				} catch (IOException e) {
 					// Ignore unexpected IO exceptions from clients
 					e.printStackTrace();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
index e80d86b..52b2ae0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
@@ -37,10 +37,13 @@
 
 package org.spearce.jgit.transport;
 
+import java.io.BufferedInputStream;
+import java.io.BufferedOutputStream;
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStream;
 import java.net.InetAddress;
+import java.net.Socket;
 
 /** Active network client of {@link Daemon}. */
 public class DaemonClient {
@@ -80,11 +83,13 @@ public OutputStream getOutputStream() {
 		return rawOut;
 	}
 
-	void execute(final InputStream in, final OutputStream out)
+	void execute(final Socket sock)
 			throws IOException {
-		rawIn = in;
-		rawOut = out;
+		rawIn = new BufferedInputStream(sock.getInputStream());
+		rawOut = new BufferedOutputStream(sock.getOutputStream());
 
+		if (0 < daemon.getTimeout())
+			sock.setSoTimeout(daemon.getTimeout() * 1000);
 		String cmd = new PacketLineIn(rawIn).readStringRaw();
 		final int nul = cmd.indexOf('\0');
 		if (nul >= 0) {
@@ -98,6 +103,7 @@ void execute(final InputStream in, final OutputStream out)
 		final DaemonService srv = getDaemon().matchService(cmd);
 		if (srv == null)
 			return;
+		sock.setSoTimeout(0);
 		srv.execute(this, cmd);
 	}
 }
-- 
1.6.3.2.416.g04d0
