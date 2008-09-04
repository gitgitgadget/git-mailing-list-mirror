From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/7] Refactor TransportBundle to not be dependent on FileInputStream
Date: Thu,  4 Sep 2008 16:42:18 -0700
Message-ID: <1220571739-4219-7-git-send-email-spearce@spearce.org>
References: <1220571739-4219-1-git-send-email-spearce@spearce.org>
 <1220571739-4219-2-git-send-email-spearce@spearce.org>
 <1220571739-4219-3-git-send-email-spearce@spearce.org>
 <1220571739-4219-4-git-send-email-spearce@spearce.org>
 <1220571739-4219-5-git-send-email-spearce@spearce.org>
 <1220571739-4219-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOUB-0000iN-27
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYIDXma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbYIDXm3
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:42:29 -0400
Received: from george.spearce.org ([209.20.77.23]:33770 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbYIDXmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:42:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 31E8838353; Thu,  4 Sep 2008 23:42:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D1D6F38360;
	Thu,  4 Sep 2008 23:42:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
In-Reply-To: <1220571739-4219-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94976>

By using a straight up BufferedInputStream and making it play nicely
with IndexPack's internal buffering we can permit TransportBundle to
accept input from any sort of InputStream, not just those that have
a positionable Channel underneath of them.  This makes it possible
to stream a bundle over the network, or from a byte[] in memory.

IndexPack now publishes its BUFFER_SIZE member so callers can create
their own BufferedInputStream with the same size buffer.  This way we
can be sure that reads after the first bypass BufferedInputStream's
buffer and go directly into IndexPack's buffer.

The BUFFER_SIZE is increased to 8192 as that is the same size that
is used by default in BufferedInputStream in Java 6.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BasePackConnection.java |    2 +-
 .../src/org/spearce/jgit/transport/IndexPack.java  |   20 +++++++--
 .../spearce/jgit/transport/TransportBundle.java    |   43 ++++++--------------
 3 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 6101802..184a5fd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -101,7 +101,7 @@ BasePackConnection(final PackTransport packTransport) {
 
 	protected void init(final InputStream myIn, final OutputStream myOut) {
 		in = myIn instanceof BufferedInputStream ? myIn
-				: new BufferedInputStream(myIn);
+				: new BufferedInputStream(myIn, IndexPack.BUFFER_SIZE);
 		out = myOut instanceof BufferedOutputStream ? myOut
 				: new BufferedOutputStream(myOut);
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index 2c98823..bc52896 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -76,20 +76,30 @@
 	/** Progress message when computing names of delta compressed objects. */
 	public static final String PROGRESS_RESOLVE_DELTA = "Resolving deltas";
 
-	private static final int BUFFER_SIZE = 4096;
+	/**
+	 * Size of the internal stream buffer.
+	 * <p>
+	 * If callers are going to be supplying IndexPack a BufferedInputStream they
+	 * should use this buffer size as the size of the buffer for that
+	 * BufferedInputStream, and any other its may be wrapping. This way the
+	 * buffers will cascade efficiently and only the IndexPack buffer will be
+	 * receiving the bulk of the data stream.
+	 */
+	public static final int BUFFER_SIZE = 8192;
 
 	/**
 	 * Create an index pack instance to load a new pack into a repository.
 	 * <p>
 	 * The received pack data and generated index will be saved to temporary
-	 * files within the repository's <code>objects</code> directory. To use
-	 * the data contained within them call {@link #renameAndOpenPack()} once the
+	 * files within the repository's <code>objects</code> directory. To use the
+	 * data contained within them call {@link #renameAndOpenPack()} once the
 	 * indexing is complete.
 	 * 
 	 * @param db
 	 *            the repository that will receive the new pack.
 	 * @param is
-	 *            stream to read the pack data from.
+	 *            stream to read the pack data from. If the stream is buffered
+	 *            use {@link #BUFFER_SIZE} as the buffer size for the stream.
 	 * @return a new index pack instance.
 	 * @throws IOException
 	 *             a temporary file could not be created.
@@ -164,6 +174,8 @@ public static IndexPack create(final Repository db, final InputStream is)
 	 * 
 	 * @param db
 	 * @param src
+	 *            stream to read the pack data from. If the stream is buffered
+	 *            use {@link #BUFFER_SIZE} as the buffer size for the stream.
 	 * @param dstBase
 	 * @throws IOException
 	 *             the output packfile could not be created.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index de62fb8..765fc0f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -102,7 +102,13 @@ TransportBundle(final Repository local, final URIish uri) {
 	@Override
 	public FetchConnection openFetch() throws NotSupportedException,
 			TransportException {
-		return new BundleFetchConnection();
+		final InputStream src;
+		try {
+			src = new FileInputStream(bundle);
+		} catch (FileNotFoundException err) {
+			throw new TransportException(uri, "not found");
+		}
+		return new BundleFetchConnection(src);
 	}
 
 	@Override
@@ -117,20 +123,12 @@ public void close() {
 	}
 
 	class BundleFetchConnection extends BaseFetchConnection {
-		FileInputStream in;
-
-		RewindBufferedInputStream bin;
+		InputStream bin;
 
 		final Set<ObjectId> prereqs = new HashSet<ObjectId>();
 
-		BundleFetchConnection() throws TransportException {
-			try {
-				in = new FileInputStream(bundle);
-				bin = new RewindBufferedInputStream(in);
-			} catch (FileNotFoundException err) {
-				throw new TransportException(uri, "not found");
-			}
-
+		BundleFetchConnection(final InputStream src) throws TransportException {
+			bin = new BufferedInputStream(src, IndexPack.BUFFER_SIZE);
 			try {
 				switch (readSignature()) {
 				case 2:
@@ -139,10 +137,6 @@ BundleFetchConnection() throws TransportException {
 				default:
 					throw new TransportException(uri, "not a bundle");
 				}
-
-				in.getChannel().position(
-						in.getChannel().position() - bin.buffered());
-				bin = null;
 			} catch (TransportException err) {
 				close();
 				throw err;
@@ -208,7 +202,7 @@ protected void doFetch(final ProgressMonitor monitor,
 				final Collection<Ref> want) throws TransportException {
 			verifyPrerequisites();
 			try {
-				final IndexPack ip = IndexPack.create(local, in);
+				final IndexPack ip = IndexPack.create(local, bin);
 				ip.setFixThin(true);
 				ip.index(monitor);
 				ip.renameAndOpenPack();
@@ -281,26 +275,15 @@ private void verifyPrerequisites() throws TransportException {
 
 		@Override
 		public void close() {
-			if (in != null) {
+			if (bin != null) {
 				try {
-					in.close();
+					bin.close();
 				} catch (IOException ie) {
 					// Ignore close failures.
 				} finally {
-					in = null;
 					bin = null;
 				}
 			}
 		}
-
-		class RewindBufferedInputStream extends BufferedInputStream {
-			RewindBufferedInputStream(final InputStream src) {
-				super(src);
-			}
-
-			int buffered() {
-				return (count - pos);
-			}
-		}
 	}
 }
-- 
1.6.0.1.319.g9f32b
