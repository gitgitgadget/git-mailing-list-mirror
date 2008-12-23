From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Teach TransportLocal how to use our own ReceivePack implementation
Date: Tue, 23 Dec 2008 10:34:59 -0800
Message-ID: <1230057299-13783-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFC7H-0005fr-Gc
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbYLWSfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 13:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbYLWSfB
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 13:35:01 -0500
Received: from george.spearce.org ([209.20.77.23]:54981 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbYLWSfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 13:35:00 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0B85438210; Tue, 23 Dec 2008 18:35:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 63DB838197;
	Tue, 23 Dec 2008 18:34:59 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103848>

If the user hasn't reconfigured git receive-pack on this remote
then we can use our internal implementation instead of forking
out to the C implementation.  It may be faster to stay within
the JVM then to start the external process.

In-memory pipes are constructed to copy the data between the
calling client thread and the background ReceivePack worker.
In certain cases we may even be able to do a faster copy by
directly hard-linking object files and/or packs, but that
isn't traditionally how Git behaves, so we use the standard
network protocol anyway.

Since our ReceivePack process doesn't fire hooks by default
we no longer will invoke any hooks during a push to a local
repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/TransportLocal.java |   88 +++++++++++++++++++-
 1 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index d74f1b3..b5dd5fc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -43,6 +43,8 @@
 import java.io.File;
 import java.io.IOException;
 import java.io.InputStream;
+import java.io.PipedInputStream;
+import java.io.PipedOutputStream;
 
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.TransportException;
@@ -90,7 +92,10 @@ public FetchConnection openFetch() throws TransportException {
 	@Override
 	public PushConnection openPush() throws NotSupportedException,
 			TransportException {
-		return new LocalPushConnection();
+		final String rp = getOptionReceivePack();
+		if ("git-receive-pack".equals(rp) || "git receive-pack".equals(rp))
+			return new InternalLocalPushConnection();
+		return new ForkLocalPushConnection();
 	}
 
 	@Override
@@ -151,10 +156,87 @@ public void close() {
 		}
 	}
 
-	class LocalPushConnection extends BasePackPushConnection {
+	class InternalLocalPushConnection extends BasePackPushConnection {
+		private Thread worker;
+
+		InternalLocalPushConnection() throws TransportException {
+			super(TransportLocal.this);
+
+			final Repository dst;
+			try {
+				dst = new Repository(remoteGitDir);
+			} catch (IOException err) {
+				throw new TransportException(uri, "not a git directory");
+			}
+
+			final PipedInputStream in_r;
+			final PipedOutputStream in_w;
+
+			final PipedInputStream out_r;
+			final PipedOutputStream out_w;
+			try {
+				in_r = new PipedInputStream();
+				in_w = new PipedOutputStream(in_r);
+
+				out_r = new PipedInputStream();
+				out_w = new PipedOutputStream(out_r);
+			} catch (IOException err) {
+				dst.close();
+				throw new TransportException(uri, "cannot connect pipes", err);
+			}
+
+			worker = new Thread("JGit-Receive-Pack") {
+				public void run() {
+					try {
+						final ReceivePack rp = new ReceivePack(dst);
+						rp.receive(out_r, in_w, System.err);
+					} catch (IOException err) {
+						// Client side of the pipes should report the problem.
+					} catch (RuntimeException err) {
+						// Clients side will notice we went away, and report.
+					} finally {
+						try {
+							out_r.close();
+						} catch (IOException e2) {
+							// Ignore close failure, we probably crashed above.
+						}
+
+						try {
+							in_w.close();
+						} catch (IOException e2) {
+							// Ignore close failure, we probably crashed above.
+						}
+
+						dst.close();
+					}
+				}
+			};
+			worker.start();
+
+			init(in_r, out_w);
+			readAdvertisedRefs();
+		}
+
+		@Override
+		public void close() {
+			super.close();
+
+			if (worker != null) {
+				try {
+					worker.join();
+				} catch (InterruptedException ie) {
+					// Stop waiting and return anyway.
+				} finally {
+					worker = null;
+				}
+			}
+		}
+	}
+
+	class ForkLocalPushConnection extends BasePackPushConnection {
 		private Process receivePack;
 
-		LocalPushConnection() throws TransportException {
+		ForkLocalPushConnection() throws TransportException {
 			super(TransportLocal.this);
 			receivePack = startProcessWithErrStream(getOptionReceivePack());
 			init(receivePack.getInputStream(), receivePack.getOutputStream());
-- 
1.6.1.rc4.301.g5497a
