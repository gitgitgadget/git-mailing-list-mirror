From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2] Fix a race condition when loading non-mmapd byte windows
Date: Sat,  7 Mar 2009 16:17:15 -0800
Message-ID: <1236471435-21888-1-git-send-email-spearce@spearce.org>
References: <1236471125-21382-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 01:18:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg6j9-00057s-6k
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 01:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbZCHART (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 19:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbZCHARS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 19:17:18 -0500
Received: from george.spearce.org ([209.20.77.23]:40895 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbZCHARS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 19:17:18 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id AC34838215; Sun,  8 Mar 2009 00:17:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F1623381D5;
	Sun,  8 Mar 2009 00:17:15 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.185.g8b635
In-Reply-To: <1236471125-21382-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112600>

Back in 439d441b0800 ("Change ByteArrayWindow to read content
outside of WindowCache's lock") I introduced a race condition
to WindowCache.

It is possible for a ByteArrayWindow to be allocated and put
into the cache, and then for the calling thread to get put
to sleep before it can actually load the window from disk.
By the time the thread wakes up again, the window may have
already been evicted from the cache, and its underlying file
was closed.  This results in stack traces such as:

java.lang.RuntimeException: Cannot fault in window
        at org.spearce.jgit.lib.ByteArrayWindow.ensureLoaded(ByteArrayWindow.java:111)
...
Caused by: java.nio.channels.ClosedChannelException
        at sun.nio.ch.FileChannelImpl.ensureOpen(FileChannelImpl.java:91)

Now when we allocate a ByteArrayWindow for a specific window reference
we increment the file reference count one additional time, forcing the
file to stay open even if the window was evicted from the cache.  The
reference count is decremented once the window loads successfully, and
this puts us back into the state of 1 reference count value for each
window still in the window cache.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Oh hell, I missed the fact that markLoaded(ByteWindow) may be
 dropping the last reference and need to close the file.

 .../src/org/spearce/jgit/lib/ByteArrayWindow.java  |    7 +++----
 .../src/org/spearce/jgit/lib/ByteBufferWindow.java |    4 ++++
 .../src/org/spearce/jgit/lib/ByteWindow.java       |    2 ++
 .../src/org/spearce/jgit/lib/WindowCache.java      |   14 +++++++++++++-
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    1 +
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
index 7b7c7a4..055a329 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteArrayWindow.java
@@ -68,7 +68,6 @@ ByteArrayWindow(final WindowedFile o, final long p, final int d,
 	}
 
 	int copy(final byte[] array, final int p, final byte[] b, final int o, int n) {
-		ensureLoaded(array);
 		n = Math.min(array.length - p, n);
 		System.arraycopy(array, p, b, o, n);
 		return n;
@@ -76,7 +75,6 @@ int copy(final byte[] array, final int p, final byte[] b, final int o, int n) {
 
 	int inflate(final byte[] array, final int pos, final byte[] b, int o,
 			final Inflater inf) throws DataFormatException {
-		ensureLoaded(array);
 		while (!inf.finished()) {
 			if (inf.needsInput()) {
 				inf.setInput(array, pos, array.length - pos);
@@ -91,7 +89,6 @@ int inflate(final byte[] array, final int pos, final byte[] b, int o,
 
 	void inflateVerify(final byte[] array, final int pos, final Inflater inf)
 			throws DataFormatException {
-		ensureLoaded(array);
 		while (!inf.finished()) {
 			if (inf.needsInput()) {
 				inf.setInput(array, pos, array.length - pos);
@@ -103,12 +100,14 @@ void inflateVerify(final byte[] array, final int pos, final Inflater inf)
 			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
 	}
 
-	private synchronized void ensureLoaded(final byte[] array) {
+	synchronized void ensureLoaded(final byte[] array) {
 		if (!loaded) {
 			try {
 				provider.fd.getChannel().read(ByteBuffer.wrap(array), start);
 			} catch (IOException e) {
 				throw new RuntimeException("Cannot fault in window", e);
+			} finally {
+				WindowCache.markLoaded(this);
 			}
 			loaded = true;
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
index a6757e8..5beb79b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteBufferWindow.java
@@ -107,4 +107,8 @@ void inflateVerify(final ByteBuffer buffer, final int pos,
 		while (!inf.finished() && !inf.needsInput())
 			inf.inflate(verifyGarbageBuffer, 0, verifyGarbageBuffer.length);
 	}
+
+	void ensureLoaded(final ByteBuffer ref) {
+		// Do nothing.
+	}
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
index 732664b..e957138 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ByteWindow.java
@@ -217,4 +217,6 @@ final void inflateVerify(T ref, long pos, Inflater inf)
 
 	abstract void inflateVerify(T ref, int pos, Inflater inf)
 			throws DataFormatException;
+
+	abstract void ensureLoaded(T ref);
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 0b9d20c..4b7e10d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -189,7 +189,13 @@ private static synchronized void reconfigureImpl(final int packedGitLimit,
 	 *             the window was not found in the cache and the given provider
 	 *             was unable to load the window on demand.
 	 */
-	public static synchronized final void get(final WindowCursor curs,
+	public static final void get(final WindowCursor curs,
+			final WindowedFile wp, final long position) throws IOException {
+		getImpl(curs, wp, position);
+		curs.window.ensureLoaded(curs.handle);
+	}
+
+	private static synchronized final void getImpl(final WindowCursor curs,
 			final WindowedFile wp, final long position) throws IOException {
 		final int id = (int) (position >> windowSizeShift);
 		final int idx = hash(wp, id);
@@ -254,6 +260,12 @@ public static synchronized final void get(final WindowCursor curs,
 		insertLRU(e);
 	}
 
+	static synchronized void markLoaded(final ByteWindow w) {
+		if (--w.provider.openCount == 0) {
+			w.provider.cacheClose();
+		}
+	}
+
 	private static void makeMostRecent(ByteWindow<?> e) {
 		if (lruHead != e) {
 			unlinkLRU(e);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index db8ea88..938f44c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -348,5 +348,6 @@ void allocWindow(final WindowCursor curs, final int windowId,
 		final byte[] b = new byte[size];
 		curs.window = new ByteArrayWindow(this, pos, windowId, b);
 		curs.handle = b;
+		openCount++; // Until the window loads, we must stay open.
 	}
 }
-- 
1.6.2.185.g8b635
