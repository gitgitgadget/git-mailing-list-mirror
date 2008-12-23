From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Implement "jgit upload-pack" to support fetching from jgit
Date: Tue, 23 Dec 2008 14:56:45 -0800
Message-ID: <1230073007-17337-4-git-send-email-spearce@spearce.org>
References: <1230073007-17337-1-git-send-email-spearce@spearce.org>
 <1230073007-17337-2-git-send-email-spearce@spearce.org>
 <1230073007-17337-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 23:58:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFGD0-0004pX-N6
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 23:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbYLWW5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 17:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbYLWW47
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 17:56:59 -0500
Received: from george.spearce.org ([209.20.77.23]:51453 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbYLWW4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 17:56:51 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D639138211; Tue, 23 Dec 2008 22:56:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8021D38200;
	Tue, 23 Dec 2008 22:56:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230073007-17337-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103851>

All current options, with the exception of shallow fetch, are
supported by this implementation.

"jgit upload-pack" is included to support remote server side
execution.  "jgit daemon" has also had the upload-pack service
added to its service table, making fetch over git:// possible.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/UploadPack.java       |   67 +++
 .../src/org/spearce/jgit/lib/PackWriter.java       |   85 +++-
 .../jgit/transport/BasePackFetchConnection.java    |    2 +
 .../src/org/spearce/jgit/transport/Daemon.java     |   36 ++-
 .../org/spearce/jgit/transport/PacketLineOut.java  |   19 +-
 .../jgit/transport/SideBandInputStream.java        |    6 +-
 .../jgit/transport/SideBandOutputStream.java       |   93 ++++
 .../jgit/transport/SideBandProgressMonitor.java    |  150 ++++++
 .../src/org/spearce/jgit/transport/UploadPack.java |  491 ++++++++++++++++++++
 10 files changed, 915 insertions(+), 35 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/SideBandOutputStream.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/SideBandProgressMonitor.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 40177f9..1ba29e6 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -16,6 +16,7 @@ org.spearce.jgit.pgm.RevList
 org.spearce.jgit.pgm.Rm
 org.spearce.jgit.pgm.ShowRev
 org.spearce.jgit.pgm.Tag
+org.spearce.jgit.pgm.UploadPack
 org.spearce.jgit.pgm.Version
 
 org.spearce.jgit.pgm.debug.MakeCacheTree
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
new file mode 100644
index 0000000..d6f6d7c
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm;
+
+import java.io.File;
+
+import org.kohsuke.args4j.Argument;
+import org.spearce.jgit.lib.Repository;
+
+@Command(common = false, usage = "Server side backend for 'jgit fetch'")
+class UploadPack extends TextBuiltin {
+	@Argument(index = 0, required = true, metaVar = "DIRECTORY", usage = "Repository to read from")
+	File gitdir;
+
+	@Override
+	protected final boolean requiresRepository() {
+		return false;
+	}
+
+	@Override
+	protected void run() throws Exception {
+		final org.spearce.jgit.transport.UploadPack rp;
+
+		if (new File(gitdir, ".git").isDirectory())
+			gitdir = new File(gitdir, ".git");
+		db = new Repository(gitdir);
+		if (!db.getObjectsDirectory().isDirectory())
+			throw die("'" + gitdir.getPath() + "' not a git repository");
+		rp = new org.spearce.jgit.transport.UploadPack(db);
+		rp.upload(System.in, System.out, System.err);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 32394f2..89460f2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -173,7 +173,9 @@
 
 	private final Deflater deflater;
 
-	private final ProgressMonitor monitor;
+	private ProgressMonitor initMonitor;
+
+	private ProgressMonitor writeMonitor;
 
 	private final byte[] buf = new byte[16384]; // 16 KB
 
@@ -200,18 +202,41 @@
 	 * <p>
 	 * Objects for packing are specified in {@link #preparePack(Iterator)} or
 	 * {@link #preparePack(Collection, Collection, boolean, boolean)}.
-	 *
+	 * 
 	 * @param repo
 	 *            repository where objects are stored.
 	 * @param monitor
 	 *            operations progress monitor, used within
 	 *            {@link #preparePack(Iterator)},
-	 *            {@link #preparePack(Collection, Collection, boolean, boolean)},
-	 *            or {@link #writePack(OutputStream)}.
+	 *            {@link #preparePack(Collection, Collection, boolean, boolean)}
+	 *            , or {@link #writePack(OutputStream)}.
 	 */
 	public PackWriter(final Repository repo, final ProgressMonitor monitor) {
+		this(repo, monitor, monitor);
+	}
+
+	/**
+	 * Create writer for specified repository.
+	 * <p>
+	 * Objects for packing are specified in {@link #preparePack(Iterator)} or
+	 * {@link #preparePack(Collection, Collection, boolean, boolean)}.
+	 * 
+	 * @param repo
+	 *            repository where objects are stored.
+	 * @param imonitor
+	 *            operations progress monitor, used within
+	 *            {@link #preparePack(Iterator)},
+	 *            {@link #preparePack(Collection, Collection, boolean, boolean)}
+	 *            ;
+	 * @param wmonitor
+	 *            operations progress monitor, used within
+	 *            {@link #writePack(OutputStream)}.
+	 */
+	public PackWriter(final Repository repo, final ProgressMonitor imonitor,
+			final ProgressMonitor wmonitor) {
 		this.db = repo;
-		this.monitor = monitor;
+		initMonitor = imonitor;
+		writeMonitor = wmonitor;
 		this.deflater = new Deflater(db.getConfig().getCore().getCompression());
 	}
 
@@ -447,6 +472,17 @@ public void preparePack(
 	}
 
 	/**
+	 * Determine if the pack file will contain the requested object.
+	 * 
+	 * @param id
+	 *            the object to test the existence of.
+	 * @return true if the object will appear in the output pack file.
+	 */
+	public boolean willInclude(final AnyObjectId id) {
+		return objectsMap.get(id) != null;
+	}
+
+	/**
 	 * Computes SHA-1 of lexicographically sorted objects ids written in this
 	 * pack, as used to name a pack file in repository.
 	 *
@@ -529,23 +565,23 @@ public void writePack(OutputStream packStream) throws IOException {
 		countingOut = new CountingOutputStream(packStream);
 		out = new DigestOutputStream(countingOut, Constants.newMessageDigest());
 
-		monitor.beginTask(WRITING_OBJECTS_PROGRESS, getObjectsNumber());
+		writeMonitor.beginTask(WRITING_OBJECTS_PROGRESS, getObjectsNumber());
 		writeHeader();
 		writeObjects();
 		writeChecksum();
 
 		out.flush();
 		windowCursor.release();
-		monitor.endTask();
+		writeMonitor.endTask();
 	}
 
 	private void searchForReuse() throws IOException {
-		monitor.beginTask(SEARCHING_REUSE_PROGRESS, getObjectsNumber());
+		initMonitor.beginTask(SEARCHING_REUSE_PROGRESS, getObjectsNumber());
 		final Collection<PackedObjectLoader> reuseLoaders = new LinkedList<PackedObjectLoader>();
 
 		for (List<ObjectToPack> list : objectsLists) {
 			for (ObjectToPack otp : list) {
-				if (monitor.isCancelled())
+				if (initMonitor.isCancelled())
 					throw new IOException(
 							"Packing cancelled during objects writing");
 				reuseLoaders.clear();
@@ -557,11 +593,11 @@ private void searchForReuse() throws IOException {
 				if (reuseObjects && !otp.hasReuseLoader()) {
 					selectObjectReuseForObject(otp, reuseLoaders);
 				}
-				monitor.update(1);
+				initMonitor.update(1);
 			}
 		}
 
-		monitor.endTask();
+		initMonitor.endTask();
 	}
 
 	private void selectDeltaReuseForObject(final ObjectToPack otp,
@@ -625,7 +661,7 @@ private void writeHeader() throws IOException {
 	private void writeObjects() throws IOException {
 		for (List<ObjectToPack> list : objectsLists) {
 			for (ObjectToPack otp : list) {
-				if (monitor.isCancelled())
+				if (writeMonitor.isCancelled())
 					throw new IOException(
 							"Packing cancelled during objects writing");
 				if (!otp.isWritten())
@@ -663,7 +699,7 @@ private void writeObject(final ObjectToPack otp) throws IOException {
 		else
 			writeWholeObject(otp);
 
-		monitor.update(1);
+		writeMonitor.update(1);
 	}
 
 	private void writeWholeObject(final ObjectToPack otp) throws IOException {
@@ -760,21 +796,34 @@ private ObjectWalk setUpWalker(
 	private void findObjectsToPack(final ObjectWalk walker)
 			throws MissingObjectException, IncorrectObjectTypeException,
 			IOException {
-		monitor.beginTask(COUNTING_OBJECTS_PROGRESS, ProgressMonitor.UNKNOWN);
+		initMonitor.beginTask(COUNTING_OBJECTS_PROGRESS,
+				ProgressMonitor.UNKNOWN);
 		RevObject o;
 
 		while ((o = walker.next()) != null) {
 			addObject(o);
-			monitor.update(1);
+			initMonitor.update(1);
 		}
 		while ((o = walker.nextObject()) != null) {
 			addObject(o);
-			monitor.update(1);
+			initMonitor.update(1);
 		}
-		monitor.endTask();
+		initMonitor.endTask();
 	}
 
-	private void addObject(RevObject object)
+	/**
+	 * Include one object to the output file.
+	 * <p>
+	 * Objects are written in the order they are added. If the same object is
+	 * added twice, it may be written twice, creating a larger than necessary
+	 * file.
+	 * 
+	 * @param object
+	 *            the object to add.
+	 * @throws IncorrectObjectTypeException
+	 *             the object is an unsupported type.
+	 */
+	public void addObject(final RevObject object)
 			throws IncorrectObjectTypeException {
 		if (object.has(RevFlag.UNINTERESTING)) {
 			edgeObjects.add(object);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
index 2cb9b64..1fe504b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackFetchConnection.java
@@ -100,6 +100,8 @@
 
 	static final String OPTION_SHALLOW = "shallow";
 
+	static final String OPTION_NO_PROGRESS = "no-progress";
+
 	private final RevWalk walk;
 
 	/** All commits that are immediately reachable by a local ref. */
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
index c225740..b5097ef 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -41,6 +41,7 @@
 import java.io.BufferedOutputStream;
 import java.io.File;
 import java.io.IOException;
+import java.io.InputStream;
 import java.io.InterruptedIOException;
 import java.net.InetSocketAddress;
 import java.net.ServerSocket;
@@ -96,15 +97,32 @@ public Daemon(final InetSocketAddress addr) {
 		exportBase = new ArrayList<File>();
 		processors = new ThreadGroup("Git-Daemon");
 
-		services = new DaemonService[] { new DaemonService("receive-pack",
-				"receivepack") {
-			@Override
-			protected void execute(final DaemonClient dc, final Repository db)
-					throws IOException {
-				final ReceivePack rp = new ReceivePack(db);
-				rp.receive(dc.getInputStream(), dc.getOutputStream(), null);
-			}
-		} };
+		services = new DaemonService[] {
+				new DaemonService("upload-pack", "uploadpack") {
+					{
+						setEnabled(true);
+					}
+
+					@Override
+					protected void execute(final DaemonClient dc,
+							final Repository db) throws IOException {
+						final UploadPack rp = new UploadPack(db);
+						final InputStream in = dc.getInputStream();
+						rp.upload(in, dc.getOutputStream(), null);
+					}
+				}, new DaemonService("receive-pack", "receivepack") {
+					{
+						setEnabled(false);
+					}
+
+					@Override
+					protected void execute(final DaemonClient dc,
+							final Repository db) throws IOException {
+						final ReceivePack rp = new ReceivePack(db);
+						final InputStream in = dc.getInputStream();
+						rp.receive(in, dc.getOutputStream(), null);
+					}
+				} };
 	}
 
 	/** @return the address connections are received on. */
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineOut.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineOut.java
index d37b217..aae4be5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineOut.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineOut.java
@@ -50,7 +50,7 @@
 
 	PacketLineOut(final OutputStream i) {
 		out = i;
-		lenbuffer = new byte[4];
+		lenbuffer = new byte[5];
 	}
 
 	void writeString(final String s) throws IOException {
@@ -58,12 +58,22 @@ void writeString(final String s) throws IOException {
 	}
 
 	void writePacket(final byte[] packet) throws IOException {
-		writeLength(packet.length + 4);
+		formatLength(packet.length + 4);
+		out.write(lenbuffer, 0, 4);
 		out.write(packet);
 	}
 
+	void writeChannelPacket(final int channel, final byte[] buf, int off,
+			int len) throws IOException {
+		formatLength(len + 5);
+		lenbuffer[4] = (byte) channel;
+		out.write(lenbuffer, 0, 5);
+		out.write(buf, off, len);
+	}
+
 	void end() throws IOException {
-		writeLength(0);
+		formatLength(0);
+		out.write(lenbuffer, 0, 4);
 		flush();
 	}
 
@@ -74,7 +84,7 @@ void flush() throws IOException {
 	private static final byte[] hexchar = { '0', '1', '2', '3', '4', '5', '6',
 			'7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
 
-	private void writeLength(int w) throws IOException {
+	private void formatLength(int w) {
 		int o = 3;
 		while (o >= 0 && w != 0) {
 			lenbuffer[o--] = hexchar[w & 0xf];
@@ -82,6 +92,5 @@ private void writeLength(int w) throws IOException {
 		}
 		while (o >= 0)
 			lenbuffer[o--] = '0';
-		out.write(lenbuffer, 0, 4);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
index 3ec9bff..b08cf4d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
@@ -66,11 +66,11 @@
  * @see PacketLineIn#sideband(ProgressMonitor)
  */
 class SideBandInputStream extends InputStream {
-	private static final int CH_DATA = 1;
+	static final int CH_DATA = 1;
 
-	private static final int CH_PROGRESS = 2;
+	static final int CH_PROGRESS = 2;
 
-	private static final int CH_ERROR = 3;
+	static final int CH_ERROR = 3;
 
 	private static Pattern P_UNBOUNDED = Pattern.compile(
 			".*?([\\w ]+): (\\d+)(, done)?.*", Pattern.DOTALL);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandOutputStream.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandOutputStream.java
new file mode 100644
index 0000000..31c9f5d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandOutputStream.java
@@ -0,0 +1,93 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport;
+
+import java.io.IOException;
+import java.io.OutputStream;
+
+/**
+ * Multiplexes data and progress messages
+ * <p>
+ * To correctly use this class you must wrap it in a BufferedOutputStream with a
+ * buffer size no larger than either {@link #SMALL_BUF} or {@link #MAX_BUF},
+ * minus {@link #HDR_SIZE}.
+ */
+class SideBandOutputStream extends OutputStream {
+	static final int CH_DATA = SideBandInputStream.CH_DATA;
+
+	static final int CH_PROGRESS = SideBandInputStream.CH_PROGRESS;
+
+	static final int CH_ERROR = SideBandInputStream.CH_ERROR;
+
+	static final int SMALL_BUF = 1000;
+
+	static final int MAX_BUF = 65520;
+
+	static final int HDR_SIZE = 5;
+
+	private final int channel;
+
+	private final PacketLineOut pckOut;
+
+	private byte[] singleByteBuffer;
+
+	SideBandOutputStream(final int chan, final PacketLineOut out) {
+		channel = chan;
+		pckOut = out;
+	}
+
+	@Override
+	public void flush() throws IOException {
+		if (channel != CH_DATA)
+			pckOut.flush();
+	}
+
+	@Override
+	public void write(final byte[] b, final int off, final int len)
+			throws IOException {
+		pckOut.writeChannelPacket(channel, b, off, len);
+	}
+
+	@Override
+	public void write(final int b) throws IOException {
+		if (singleByteBuffer == null)
+			singleByteBuffer = new byte[1];
+		singleByteBuffer[0] = (byte) b;
+		write(singleByteBuffer);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandProgressMonitor.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandProgressMonitor.java
new file mode 100644
index 0000000..5cda7c5
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandProgressMonitor.java
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport;
+
+import java.io.BufferedOutputStream;
+import java.io.OutputStreamWriter;
+import java.io.PrintWriter;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ProgressMonitor;
+
+/** Write progress messages out to the sideband channel. */
+class SideBandProgressMonitor implements ProgressMonitor {
+	private PrintWriter out;
+
+	private boolean output;
+
+	private long taskBeganAt;
+
+	private long lastOutput;
+
+	private String msg;
+
+	private int lastWorked;
+
+	private int totalWork;
+
+	SideBandProgressMonitor(final PacketLineOut pckOut) {
+		final int bufsz = SideBandOutputStream.SMALL_BUF
+				- SideBandOutputStream.HDR_SIZE;
+		out = new PrintWriter(new OutputStreamWriter(new BufferedOutputStream(
+				new SideBandOutputStream(SideBandOutputStream.CH_PROGRESS,
+						pckOut), bufsz), Constants.CHARSET));
+	}
+
+	public void start(final int totalTasks) {
+		// Ignore the number of tasks.
+		taskBeganAt = System.currentTimeMillis();
+		lastOutput = taskBeganAt;
+	}
+
+	public void beginTask(final String title, final int total) {
+		endTask();
+		msg = title;
+		lastWorked = 0;
+		totalWork = total;
+	}
+
+	public void update(final int completed) {
+		if (msg == null)
+			return;
+
+		final int cmp = lastWorked + completed;
+		final long now = System.currentTimeMillis();
+		if (!output && now - taskBeganAt < 500)
+			return;
+		if (totalWork == UNKNOWN) {
+			if (now - lastOutput >= 500) {
+				display(cmp, null);
+				lastOutput = now;
+			}
+		} else {
+			if ((cmp * 100 / totalWork) != (lastWorked * 100) / totalWork
+					|| now - lastOutput >= 500) {
+				display(cmp, null);
+				lastOutput = now;
+			}
+		}
+		lastWorked = cmp;
+		output = true;
+	}
+
+	private void display(final int cmp, final String eol) {
+		final StringBuilder m = new StringBuilder();
+		m.append(msg);
+		m.append(": ");
+
+		if (totalWork == UNKNOWN) {
+			m.append(cmp);
+		} else {
+			final int pcnt = (cmp * 100 / totalWork);
+			if (pcnt < 100)
+				m.append(' ');
+			if (pcnt < 10)
+				m.append(' ');
+			m.append(pcnt);
+			m.append("% (");
+			m.append(cmp);
+			m.append("/");
+			m.append(totalWork);
+			m.append(")");
+		}
+		if (eol != null)
+			m.append(eol);
+		else
+			m.append("   \r");
+		out.print(m);
+		out.flush();
+	}
+
+	public boolean isCancelled() {
+		return false;
+	}
+
+	public void endTask() {
+		if (output) {
+			if (totalWork == UNKNOWN)
+				display(lastWorked, ", done\n");
+			else
+				display(totalWork, "\n");
+		}
+		output = false;
+		msg = null;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
new file mode 100644
index 0000000..4401951
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -0,0 +1,491 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport;
+
+import java.io.BufferedOutputStream;
+import java.io.EOFException;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.util.ArrayList;
+import java.util.HashSet;
+import java.util.Iterator;
+import java.util.List;
+import java.util.Map;
+import java.util.Set;
+
+import org.spearce.jgit.errors.PackProtocolException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.NullProgressMonitor;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackWriter;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.RefComparator;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevFlag;
+import org.spearce.jgit.revwalk.RevFlagSet;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevTag;
+import org.spearce.jgit.revwalk.RevWalk;
+
+/**
+ * Implements the server side of a fetch connection, transmitting objects.
+ */
+public class UploadPack {
+	static final String OPTION_INCLUDE_TAG = BasePackFetchConnection.OPTION_INCLUDE_TAG;
+
+	static final String OPTION_MULTI_ACK = BasePackFetchConnection.OPTION_MULTI_ACK;
+
+	static final String OPTION_THIN_PACK = BasePackFetchConnection.OPTION_THIN_PACK;
+
+	static final String OPTION_SIDE_BAND = BasePackFetchConnection.OPTION_SIDE_BAND;
+
+	static final String OPTION_SIDE_BAND_64K = BasePackFetchConnection.OPTION_SIDE_BAND_64K;
+
+	static final String OPTION_OFS_DELTA = BasePackFetchConnection.OPTION_OFS_DELTA;
+
+	static final String OPTION_NO_PROGRESS = BasePackFetchConnection.OPTION_NO_PROGRESS;
+
+	/** Database we read the objects from. */
+	private final Repository db;
+
+	/** Revision traversal support over {@link #db}. */
+	private final RevWalk walk;
+
+	private InputStream rawIn;
+
+	private OutputStream rawOut;
+
+	private PacketLineIn pckIn;
+
+	private PacketLineOut pckOut;
+
+	/** The refs we advertised as existing at the start of the connection. */
+	private Map<String, Ref> refs;
+
+	/** Capabilities requested by the client. */
+	private final Set<String> options = new HashSet<String>();
+
+	/** Objects the client wants to obtain. */
+	private final List<RevObject> wantAll = new ArrayList<RevObject>();
+
+	/** Objects the client wants to obtain. */
+	private final List<RevCommit> wantCommits = new ArrayList<RevCommit>();
+
+	/** Objects on both sides, these don't have to be sent. */
+	private final List<RevObject> commonBase = new ArrayList<RevObject>();
+
+	/** Marked on objects we sent in our advertisement list. */
+	private final RevFlag ADVERTISED;
+
+	/** Marked on objects the client has asked us to give them. */
+	private final RevFlag WANT;
+
+	/** Marked on objects both we and the client have. */
+	private final RevFlag PEER_HAS;
+
+	/** Marked on objects in {@link #commonBase}. */
+	private final RevFlag COMMON;
+
+	private final RevFlagSet SAVE;
+
+	private boolean multiAck;
+
+	/**
+	 * Create a new pack upload for an open repository.
+	 * 
+	 * @param copyFrom
+	 *            the source repository.
+	 */
+	public UploadPack(final Repository copyFrom) {
+		db = copyFrom;
+		walk = new RevWalk(db);
+
+		ADVERTISED = walk.newFlag("ADVERTISED");
+		WANT = walk.newFlag("WANT");
+		PEER_HAS = walk.newFlag("PEER_HAS");
+		COMMON = walk.newFlag("COMMON");
+		walk.carry(PEER_HAS);
+
+		SAVE = new RevFlagSet();
+		SAVE.add(ADVERTISED);
+		SAVE.add(WANT);
+		SAVE.add(PEER_HAS);
+	}
+
+	/** @return the repository this receive completes into. */
+	public final Repository getRepository() {
+		return db;
+	}
+
+	/** @return the RevWalk instance used by this connection. */
+	public final RevWalk getRevWalk() {
+		return walk;
+	}
+
+	/**
+	 * Execute the upload task on the socket.
+	 * 
+	 * @param input
+	 *            raw input to read client commands from. Caller must ensure the
+	 *            input is buffered, otherwise read performance may suffer.
+	 * @param output
+	 *            response back to the Git network client, to write the pack
+	 *            data onto. Caller must ensure the output is buffered,
+	 *            otherwise write performance may suffer.
+	 * @param messages
+	 *            secondary "notice" channel to send additional messages out
+	 *            through. When run over SSH this should be tied back to the
+	 *            standard error channel of the command execution. For most
+	 *            other network connections this should be null.
+	 * @throws IOException
+	 */
+	public void upload(final InputStream input, final OutputStream output,
+			final OutputStream messages) throws IOException {
+		rawIn = input;
+		rawOut = output;
+
+		pckIn = new PacketLineIn(rawIn);
+		pckOut = new PacketLineOut(rawOut);
+		service();
+	}
+
+	private void service() throws IOException {
+		sendAdvertisedRefs();
+		recvWants();
+		if (wantAll.isEmpty())
+			return;
+		multiAck = options.contains(OPTION_MULTI_ACK);
+		negotiate();
+		sendPack();
+	}
+
+	private void sendAdvertisedRefs() throws IOException {
+		refs = db.getAllRefs();
+
+		final StringBuilder m = new StringBuilder(100);
+		final char[] idtmp = new char[2 * Constants.OBJECT_ID_LENGTH];
+		final Iterator<Ref> i = RefComparator.sort(refs.values()).iterator();
+		if (i.hasNext()) {
+			final Ref r = i.next();
+			final RevObject o = safeParseAny(r.getObjectId());
+			if (o != null) {
+				advertise(m, idtmp, o, r.getOrigName());
+				m.append('\0');
+				m.append(' ');
+				m.append(OPTION_INCLUDE_TAG);
+				m.append(' ');
+				m.append(OPTION_MULTI_ACK);
+				m.append(' ');
+				m.append(OPTION_OFS_DELTA);
+				m.append(' ');
+				m.append(OPTION_SIDE_BAND);
+				m.append(' ');
+				m.append(OPTION_SIDE_BAND_64K);
+				m.append(' ');
+				m.append(OPTION_THIN_PACK);
+				m.append(' ');
+				m.append(OPTION_NO_PROGRESS);
+				m.append(' ');
+				writeAdvertisedRef(m);
+				if (o instanceof RevTag)
+					writeAdvertisedTag(m, idtmp, o, r.getName());
+			}
+		}
+		while (i.hasNext()) {
+			final Ref r = i.next();
+			final RevObject o = safeParseAny(r.getObjectId());
+			if (o != null) {
+				advertise(m, idtmp, o, r.getOrigName());
+				writeAdvertisedRef(m);
+				if (o instanceof RevTag)
+					writeAdvertisedTag(m, idtmp, o, r.getName());
+			}
+		}
+		pckOut.end();
+	}
+
+	private RevObject safeParseAny(final ObjectId id) {
+		try {
+			return walk.parseAny(id);
+		} catch (IOException e) {
+			return null;
+		}
+	}
+
+	private void advertise(final StringBuilder m, final char[] idtmp,
+			final RevObject o, final String name) {
+		o.add(ADVERTISED);
+		m.setLength(0);
+		o.getId().copyTo(idtmp, m);
+		m.append(' ');
+		m.append(name);
+	}
+
+	private void writeAdvertisedRef(final StringBuilder m) throws IOException {
+		m.append('\n');
+		pckOut.writeString(m.toString());
+	}
+
+	private void writeAdvertisedTag(final StringBuilder m, final char[] idtmp,
+			final RevObject tag, final String name) throws IOException {
+		RevObject o = tag;
+		while (o instanceof RevTag) {
+			// Fully unwrap here so later on we have these already parsed.
+			try {
+				walk.parse(((RevTag) o).getObject());
+			} catch (IOException err) {
+				return;
+			}
+			o = ((RevTag) o).getObject();
+			o.add(ADVERTISED);
+		}
+		advertise(m, idtmp, ((RevTag) tag).getObject(), name + "^{}");
+		writeAdvertisedRef(m);
+	}
+
+	private void recvWants() throws IOException {
+		boolean isFirst = true;
+		for (;; isFirst = false) {
+			String line;
+			try {
+				line = pckIn.readString();
+			} catch (EOFException eof) {
+				if (isFirst)
+					break;
+				throw eof;
+			}
+
+			if (line.length() == 0)
+				break;
+			if (!line.startsWith("want ") || line.length() < 45)
+				throw new PackProtocolException("expected want; got " + line);
+
+			if (isFirst) {
+				final int sp = line.indexOf(' ', 45);
+				if (sp >= 0) {
+					for (String c : line.substring(sp + 1).split(" "))
+						options.add(c);
+					line = line.substring(0, sp);
+				}
+			}
+
+			final ObjectId id = ObjectId.fromString(line.substring(5));
+			final RevObject o;
+			try {
+				o = walk.parseAny(id);
+			} catch (IOException e) {
+				throw new PackProtocolException(id.name() + " not valid", e);
+			}
+			if (!o.has(ADVERTISED))
+				throw new PackProtocolException(id.name() + " not valid");
+			want(o);
+		}
+	}
+
+	private void want(RevObject o) {
+		if (!o.has(WANT)) {
+			o.add(WANT);
+			wantAll.add(o);
+
+			if (o instanceof RevCommit)
+				wantCommits.add((RevCommit) o);
+
+			else if (o instanceof RevTag) {
+				do {
+					o = ((RevTag) o).getObject();
+				} while (o instanceof RevTag);
+				if (o instanceof RevCommit)
+					want(o);
+			}
+		}
+	}
+
+	private void negotiate() throws IOException {
+		ObjectId last = ObjectId.zeroId();
+		for (;;) {
+			String line;
+			try {
+				line = pckIn.readString();
+			} catch (EOFException eof) {
+				throw eof;
+			}
+
+			if (line.length() == 0) {
+				if (commonBase.isEmpty() || multiAck)
+					pckOut.writeString("NAK\n");
+
+			} else if (line.startsWith("have ") && line.length() == 45) {
+				final ObjectId id = ObjectId.fromString(line.substring(5));
+				if (matchHave(id)) {
+					// Both sides have the same object; let the client know.
+					//
+					if (multiAck) {
+						last = id;
+						pckOut.writeString("ACK " + id.name() + " continue\n");
+					} else if (commonBase.size() == 1)
+						pckOut.writeString("ACK " + id.name() + "\n");
+				} else {
+					// They have this object; we don't.
+					//
+					if (multiAck && okToGiveUp())
+						pckOut.writeString("ACK " + id.name() + " continue\n");
+				}
+
+			} else if (line.equals("done")) {
+				if (commonBase.isEmpty())
+					pckOut.writeString("NAK\n");
+
+				else if (multiAck)
+					pckOut.writeString("ACK " + last.name() + "\n");
+				break;
+
+			} else {
+				throw new PackProtocolException("expected have; got " + line);
+			}
+		}
+	}
+
+	private boolean matchHave(final ObjectId id) {
+		final RevObject o;
+		try {
+			o = walk.parseAny(id);
+		} catch (IOException err) {
+			return false;
+		}
+
+		if (!o.has(PEER_HAS)) {
+			o.add(PEER_HAS);
+			if (o instanceof RevCommit)
+				((RevCommit) o).carry(PEER_HAS);
+			if (!o.has(COMMON)) {
+				o.add(COMMON);
+				commonBase.add(o);
+			}
+		}
+		return true;
+	}
+
+	private boolean okToGiveUp() throws PackProtocolException {
+		if (commonBase.isEmpty())
+			return false;
+
+		try {
+			for (final Iterator<RevCommit> i = wantCommits.iterator(); i
+					.hasNext();) {
+				final RevCommit want = i.next();
+				if (wantSatisfied(want))
+					i.remove();
+			}
+		} catch (IOException e) {
+			throw new PackProtocolException("internal revision error", e);
+		}
+		return wantCommits.isEmpty();
+	}
+
+	private boolean wantSatisfied(final RevCommit want) throws IOException {
+		walk.resetRetain(SAVE);
+		walk.markStart(want);
+		for (;;) {
+			final RevCommit c = walk.next();
+			if (c == null)
+				break;
+			if (c.has(PEER_HAS)) {
+				if (!c.has(COMMON)) {
+					c.add(COMMON);
+					commonBase.add(c);
+				}
+				return true;
+			}
+		}
+		return false;
+	}
+
+	private void sendPack() throws IOException {
+		final boolean thin = options.contains(OPTION_THIN_PACK);
+		final boolean progress = !options.contains(OPTION_NO_PROGRESS);
+		final boolean sideband = options.contains(OPTION_SIDE_BAND)
+				|| options.contains(OPTION_SIDE_BAND_64K);
+
+		ProgressMonitor pm = NullProgressMonitor.INSTANCE;
+		OutputStream packOut = rawOut;
+
+		if (sideband) {
+			int bufsz = SideBandOutputStream.SMALL_BUF;
+			if (options.contains(OPTION_SIDE_BAND_64K))
+				bufsz = SideBandOutputStream.MAX_BUF;
+			bufsz -= SideBandOutputStream.HDR_SIZE;
+
+			packOut = new BufferedOutputStream(new SideBandOutputStream(
+					SideBandOutputStream.CH_DATA, pckOut), bufsz);
+
+			if (progress)
+				pm = new SideBandProgressMonitor(pckOut);
+		}
+
+		final PackWriter pw;
+		pw = new PackWriter(db, pm, NullProgressMonitor.INSTANCE);
+		pw.setDeltaBaseAsOffset(options.contains(OPTION_OFS_DELTA));
+		pw.preparePack(wantAll, commonBase, thin, true);
+		if (options.contains(OPTION_INCLUDE_TAG)) {
+			for (final Ref r : refs.values()) {
+				final RevObject o;
+				try {
+					o = walk.parseAny(r.getObjectId());
+				} catch (IOException e) {
+					continue;
+				}
+				if (o.has(WANT) || !(o instanceof RevTag))
+					continue;
+				final RevTag t = (RevTag) o;
+				if (!pw.willInclude(t) && pw.willInclude(t.getObject()))
+					pw.addObject(t);
+			}
+		}
+		pw.writePack(packOut);
+
+		if (sideband) {
+			packOut.flush();
+			pckOut.end();
+		} else {
+			rawOut.flush();
+		}
+	}
+}
-- 
1.6.1.rc4.301.g5497a
