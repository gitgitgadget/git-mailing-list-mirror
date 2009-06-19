From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/6] Add timeouts to smart transport protocol clients
Date: Fri, 19 Jun 2009 14:27:52 -0700
Message-ID: <1245446875-31102-4-git-send-email-spearce@spearce.org>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org>
 <1245446875-31102-2-git-send-email-spearce@spearce.org>
 <1245446875-31102-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHldc-0002a5-G9
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 23:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163AbZFSV2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 17:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbZFSV2H
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 17:28:07 -0400
Received: from george.spearce.org ([209.20.77.23]:42459 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbZFSV16 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 17:27:58 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0BA5C381FE; Fri, 19 Jun 2009 21:28:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C04DA3819E;
	Fri, 19 Jun 2009 21:27:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
In-Reply-To: <1245446875-31102-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121912>

For both directions (input and output) we start a background thread
to interrupt the main processing thread if a read or write event on
the low-level stream does not complete in the configured timeout.
On timeout, we abort the transaction entirely.  Any sort of short
read or write doesn't need to be handled.

JSch made a timeout on write difficult because they explicitly do
a catch for InterruptedException inside of their OutputStream.  We
have to work around that by creating an additional thread that just
shuttles data between our own OutputStream and the real JSch stream.
Our OutputStream can be interrupted, which causes it to close, which
in turn closes the JSch Channel and Session.  That breaks our little
copy thread out of the JSch OutputStream, letting it terminate.  Its
not pretty, but its the best we can do with current versions of JSch.

During a push receive-pack stalls while it processes the deltas in
the received data and indexes the new pack on disk, or unpacks the
data into loose objects.  During this stall we receive no network
transfer from the remote side, so we cannot know if the peer has
deadlocked with us, or is progressing normally.  Since the time is
usually proportional to the data sent we give the remote side up to
10x the time we spent transmitting data, or our configured timeout,
hoping it will be able to complete and return a pack success or fail
status report before we timeout.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BasePackConnection.java |   36 +++++++-
 .../jgit/transport/BasePackPushConnection.java     |   29 ++++++-
 .../org/spearce/jgit/transport/SshTransport.java   |    3 +-
 .../src/org/spearce/jgit/transport/Transport.java  |   21 ++++
 .../spearce/jgit/transport/TransportGitAnon.java   |   13 +++-
 .../spearce/jgit/transport/TransportGitSsh.java    |  103 +++++++++++++++++++-
 .../org/spearce/jgit/transport/TransportLocal.java |    9 ++-
 .../org/spearce/jgit/transport/TransportSftp.java  |    3 +-
 8 files changed, 207 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 0382d2b..d759fc8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -55,6 +55,9 @@
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.util.io.InterruptTimer;
+import org.spearce.jgit.util.io.TimeoutInputStream;
+import org.spearce.jgit.util.io.TimeoutOutputStream;
 
 /**
  * Base helper class for pack-based operations implementations. Provides partial
@@ -75,6 +78,15 @@
 	/** A transport connected to {@link #uri}. */
 	protected final Transport transport;
 
+	/** Low-level input stream, if a timeout was configured. */
+	protected TimeoutInputStream timeoutIn;
+
+	/** Low-level output stream, if a timeout was configured. */
+	protected TimeoutOutputStream timeoutOut;
+
+	/** Timer to manage {@link #timeoutIn} and {@link #timeoutOut}. */
+	private InterruptTimer myTimer;
+
 	/** Buffered input stream reading from the remote. */
 	protected InputStream in;
 
@@ -102,7 +114,19 @@ BasePackConnection(final PackTransport packTransport) {
 		uri = transport.uri;
 	}
 
-	protected void init(final InputStream myIn, final OutputStream myOut) {
+	protected final void init(InputStream myIn, OutputStream myOut) {
+		final int timeout = transport.getTimeout();
+		if (timeout > 0) {
+			final Thread caller = Thread.currentThread();
+			myTimer = new InterruptTimer(caller.getName() + "-Timer");
+			timeoutIn = new TimeoutInputStream(myIn, myTimer);
+			timeoutOut = new TimeoutOutputStream(myOut, myTimer);
+			timeoutIn.setTimeout(timeout * 1000);
+			timeoutOut.setTimeout(timeout * 1000);
+			myIn = timeoutIn;
+			myOut = timeoutOut;
+		}
+
 		in = myIn instanceof BufferedInputStream ? myIn
 				: new BufferedInputStream(myIn, IndexPack.BUFFER_SIZE);
 		out = myOut instanceof BufferedOutputStream ? myOut
@@ -241,5 +265,15 @@ public void close() {
 				pckIn = null;
 			}
 		}
+
+		if (myTimer != null) {
+			try {
+				myTimer.terminate();
+			} finally {
+				myTimer = null;
+				timeoutIn = null;
+				timeoutOut = null;
+			}
+		}
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 712d3c0..2a94dfc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -92,6 +92,9 @@
 
 	private boolean writePack;
 
+	/** Time in milliseconds spent transferring the pack data. */
+	private long packTransferTime;
+
 	BasePackPushConnection(final PackTransport packTransport) {
 		super(packTransport);
 		thinPack = transport.isPushThin();
@@ -209,12 +212,14 @@ private void writePack(final Map<String, RemoteRefUpdate> refUpdates,
 		writer.setThin(thinPack);
 		writer.setDeltaBaseAsOffset(capableOfsDelta);
 		writer.preparePack(newObjects, remoteObjects);
+		final long start = System.currentTimeMillis();
 		writer.writePack(out);
+		packTransferTime = System.currentTimeMillis() - start;
 	}
 
 	private void readStatusReport(final Map<String, RemoteRefUpdate> refUpdates)
 			throws IOException {
-		final String unpackLine = pckIn.readString();
+		final String unpackLine = readStringLongTimeout();
 		if (!unpackLine.startsWith("unpack "))
 			throw new PackProtocolException(uri, "unexpected report line: "
 					+ unpackLine);
@@ -260,4 +265,26 @@ private void readStatusReport(final Map<String, RemoteRefUpdate> refUpdates)
 						+ " not received");
 		}
 	}
+
+	private String readStringLongTimeout() throws IOException {
+		if (timeoutIn == null)
+			return pckIn.readString();
+
+		// The remote side may need a lot of time to choke down the pack
+		// we just sent them. There may be many deltas that need to be
+		// resolved by the remote. Its hard to say how long the other
+		// end is going to be silent. Taking 10x the configured timeout
+		// or the time spent transferring the pack, whichever is larger,
+		// gives the other side some reasonable window to process the data,
+		// but this is just a wild guess.
+		//
+		final int oldTimeout = timeoutIn.getTimeout();
+		final int sendTime = (int) Math.min(packTransferTime, 28800000L);
+		try {
+			timeoutIn.setTimeout(10 * Math.max(sendTime, oldTimeout));
+			return pckIn.readString();
+		} finally {
+			timeoutIn.setTimeout(oldTimeout);
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
index 127096c..d45a83f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
@@ -111,6 +111,7 @@ protected void initSession() throws TransportException {
 		if (sock != null)
 			return;
 
+		final int tms = getTimeout() > 0 ? getTimeout() * 1000 : 0;
 		final String user = uri.getUser();
 		final String pass = uri.getPass();
 		final String host = uri.getHost();
@@ -118,7 +119,7 @@ protected void initSession() throws TransportException {
 		try {
 			sock = sch.getSession(user, pass, host, port);
 			if (!sock.isConnected())
-				sock.connect();
+				sock.connect(tms);
 		} catch (JSchException je) {
 			final Throwable c = je.getCause();
 			if (c instanceof UnknownHostException)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 1068f50..a6210a5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -376,6 +376,9 @@ private static String findTrackingRefName(final String remoteName,
 	/** Should refs no longer on the source be pruned from the destination? */
 	private boolean removeDeletedRefs;
 
+	/** Timeout in seconds to wait before aborting an IO read or write. */
+	private int timeout;
+
 	/**
 	 * Create a new transport instance.
 	 * 
@@ -572,6 +575,7 @@ public void applyConfig(final RemoteConfig cfg) {
 		setTagOpt(cfg.getTagOpt());
 		optionReceivePack = cfg.getReceivePack();
 		push = cfg.getPushRefSpecs();
+		timeout = cfg.getTimeout();
 	}
 
 	/**
@@ -595,6 +599,23 @@ public void setDryRun(final boolean dryRun) {
 		this.dryRun = dryRun;
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
+	 *            before aborting an IO read or write operation with this
+	 *            remote.
+	 */
+	public void setTimeout(final int seconds) {
+		timeout = seconds;
+	}
+
 	/**
 	 * Fetch objects and refs from the remote repository to the local one.
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index 0c80b9d..e23fe3b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -42,6 +42,7 @@
 import java.io.IOException;
 import java.net.ConnectException;
 import java.net.InetAddress;
+import java.net.InetSocketAddress;
 import java.net.Socket;
 import java.net.UnknownHostException;
 
@@ -82,16 +83,26 @@ public void close() {
 	}
 
 	Socket openConnection() throws TransportException {
+		final int tms = getTimeout() > 0 ? getTimeout() * 1000 : 0;
 		final int port = uri.getPort() > 0 ? uri.getPort() : GIT_PORT;
+		final Socket s = new Socket();
 		try {
-			return new Socket(InetAddress.getByName(uri.getHost()), port);
+			final InetAddress host = InetAddress.getByName(uri.getHost());
+			s.bind(null);
+			s.connect(new InetSocketAddress(host, port), tms);
 		} catch (IOException c) {
+			try {
+				s.close();
+			} catch (IOException closeErr) {
+				// ignore a failure during close, we're already failing
+			}
 			if (c instanceof UnknownHostException)
 				throw new TransportException(uri, "unknown host");
 			if (c instanceof ConnectException)
 				throw new TransportException(uri, c.getMessage());
 			throw new TransportException(uri, c.getMessage(), c);
 		}
+		return s;
 	}
 
 	void service(final String name, final PacketLineOut pckOut)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
index de72d02..bde641f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitSsh.java
@@ -40,7 +40,11 @@
 package org.spearce.jgit.transport;
 
 import java.io.IOException;
+import java.io.InputStream;
+import java.io.InterruptedIOException;
 import java.io.OutputStream;
+import java.io.PipedInputStream;
+import java.io.PipedOutputStream;
 
 import org.spearce.jgit.errors.NoRemoteRepositoryException;
 import org.spearce.jgit.errors.TransportException;
@@ -120,6 +124,7 @@ private static void sq(final StringBuilder cmd, final String val) {
 	ChannelExec exec(final String exe) throws TransportException {
 		initSession();
 
+		final int tms = getTimeout() > 0 ? getTimeout() * 1000 : 0;
 		try {
 			final ChannelExec channel = (ChannelExec) sock.openChannel("exec");
 			String path = uri.getPath();
@@ -139,7 +144,7 @@ ChannelExec exec(final String exe) throws TransportException {
 			channel.setCommand(cmd.toString());
 			errStream = createErrorStream();
 			channel.setErrStream(errStream, true);
-			channel.connect();
+			channel.connect(tms);
 			return channel;
 		} catch (JSchException je) {
 			throw new TransportException(uri, je.getMessage(), je);
@@ -198,6 +203,98 @@ NoRemoteRepositoryException cleanNotFound(NoRemoteRepositoryException nf) {
 		return new NoRemoteRepositoryException(uri, why);
 	}
 
+	// JSch won't let us interrupt writes when we use our InterruptTimer to
+	// break out of a long-running write operation. To work around that we
+	// spawn a background thread to shuttle data through a pipe, as we can
+	// issue an interrupted write out of that. Its slower, so we only use
+	// this route if there is a timeout.
+	//
+	private OutputStream outputStream(ChannelExec channel) throws IOException {
+		final OutputStream out = channel.getOutputStream();
+		if (getTimeout() <= 0)
+			return out;
+		final PipedInputStream pipeIn = new PipedInputStream();
+		final CopyThread copyThread = new CopyThread(pipeIn, out);
+		final PipedOutputStream pipeOut = new PipedOutputStream(pipeIn) {
+			@Override
+			public void flush() throws IOException {
+				super.flush();
+				copyThread.flush();
+			}
+
+			@Override
+			public void close() throws IOException {
+				super.close();
+				try {
+					copyThread.join(getTimeout() * 1000);
+				} catch (InterruptedException e) {
+					// Just wake early, the thread will terminate anyway.
+				}
+			}
+		};
+		copyThread.start();
+		return pipeOut;
+	}
+
+	private static class CopyThread extends Thread {
+		private final InputStream src;
+
+		private final OutputStream dst;
+
+		private volatile boolean doFlush;
+
+		CopyThread(final InputStream i, final OutputStream o) {
+			setName(Thread.currentThread().getName() + "-Output");
+			src = i;
+			dst = o;
+		}
+
+		void flush() {
+			if (!doFlush) {
+				doFlush = true;
+				interrupt();
+			}
+		}
+
+		@Override
+		public void run() {
+			try {
+				final byte[] buf = new byte[1024];
+				for (;;) {
+					try {
+						if (doFlush) {
+							doFlush = false;
+							dst.flush();
+						}
+
+						final int n;
+						try {
+							n = src.read(buf);
+						} catch (InterruptedIOException wakey) {
+							continue;
+						}
+						if (n < 0)
+							break;
+						dst.write(buf, 0, n);
+					} catch (IOException e) {
+						break;
+					}
+				}
+			} finally {
+				try {
+					src.close();
+				} catch (IOException e) {
+					// Ignore IO errors on close
+				}
+				try {
+					dst.close();
+				} catch (IOException e) {
+					// Ignore IO errors on close
+				}
+			}
+		}
+	}
+
 	class SshFetchConnection extends BasePackFetchConnection {
 		private ChannelExec channel;
 
@@ -207,7 +304,7 @@ SshFetchConnection() throws TransportException {
 				channel = exec(getOptionUploadPack());
 
 				if (channel.isConnected())
-					init(channel.getInputStream(), channel.getOutputStream());
+					init(channel.getInputStream(), outputStream(channel));
 				else
 					throw new TransportException(uri, errStream.toString());
 
@@ -251,7 +348,7 @@ SshPushConnection() throws TransportException {
 				channel = exec(getOptionReceivePack());
 
 				if (channel.isConnected())
-					init(channel.getInputStream(), channel.getOutputStream());
+					init(channel.getInputStream(), outputStream(channel));
 				else
 					throw new TransportException(uri, errStream.toString());
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index 428f73e..8e8e8d5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -43,6 +43,7 @@
 import java.io.File;
 import java.io.IOException;
 import java.io.InputStream;
+import java.io.OutputStream;
 import java.io.PipedInputStream;
 import java.io.PipedOutputStream;
 
@@ -240,7 +241,9 @@ public void close() {
 		ForkLocalFetchConnection() throws TransportException {
 			super(TransportLocal.this);
 			uploadPack = startProcessWithErrStream(getOptionUploadPack());
-			init(uploadPack.getInputStream(), uploadPack.getOutputStream());
+			final InputStream upIn = uploadPack.getInputStream();
+			final OutputStream upOut = uploadPack.getOutputStream();
+			init(upIn, upOut);
 			readAdvertisedRefs();
 		}
 
@@ -343,7 +346,9 @@ public void close() {
 		ForkLocalPushConnection() throws TransportException {
 			super(TransportLocal.this);
 			receivePack = startProcessWithErrStream(getOptionReceivePack());
-			init(receivePack.getInputStream(), receivePack.getOutputStream());
+			final InputStream rpIn = receivePack.getInputStream();
+			final OutputStream rpOut = receivePack.getOutputStream();
+			init(rpIn, rpOut);
 			readAdvertisedRefs();
 		}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index e18d128..57a6b09 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -112,9 +112,10 @@ public PushConnection openPush() throws TransportException {
 	ChannelSftp newSftp() throws TransportException {
 		initSession();
 
+		final int tms = getTimeout() > 0 ? getTimeout() * 1000 : 0;
 		try {
 			final Channel channel = sock.openChannel("sftp");
-			channel.connect();
+			channel.connect(tms);
 			return (ChannelSftp) channel;
 		} catch (JSchException je) {
 			throw new TransportException(uri, je.getMessage(), je);
-- 
1.6.3.2.416.g04d0
