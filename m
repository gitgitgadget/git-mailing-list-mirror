From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Improve end-of-file detection in DirCache
Date: Thu,  9 Apr 2009 08:28:18 -0700
Message-ID: <1239290899-24589-1-git-send-email-spearce@spearce.org>
References: <1239205852-28138-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 17:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrwDI-0003eD-7H
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 17:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763938AbZDIP2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 11:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761458AbZDIP2W
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 11:28:22 -0400
Received: from george.spearce.org ([209.20.77.23]:51724 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbZDIP2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 11:28:21 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 98FE33821F; Thu,  9 Apr 2009 15:28:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F06AB381D0;
	Thu,  9 Apr 2009 15:28:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.2.600.g24c24
In-Reply-To: <1239205852-28138-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116172>

When reading from a BufferInputStream attached to a FileInputStream
the available() method seems to return the number of unread bytes
in the buffer plus the unread number of bytes in the file.  There is
no guarantee for this behavior, so we can't rely on it.

Instead we read the expected 20 byte SHA1 trailer into a temporary
buffer, and then poll for a remaining byte.  If another byte is
still present in the input stream it indicates that there is more
than 20 bytes worth of data remaining, which means an extension
must be available at the current position.  If there is in fact
an extension we put back the 21 bytes we read and proceed to do
an 8 byte read for the extension header.

This relies on BufferInputStream's ability to buffer at least 21
bytes of data, and put them all back in the event that we found
an extension.  This is a much more common usage of the stream API
and is something we can rely on working correctly all of the time,
on any standard library implementation.

Found-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I'd rather do this instead.  Its accurate 100% of the time and isn't
 a hack.  So I'm dropping the patch I'm replying to and asking you
 to review and apply this 2 patch series (or at least this first
 one which should fix the problem).
 
 .../src/org/spearce/jgit/dircache/DirCache.java    |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 8eb4022..5df0f59 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
@@ -45,7 +45,6 @@
 import java.io.IOException;
 import java.io.OutputStream;
 import java.nio.ByteBuffer;
-import java.nio.channels.FileChannel;
 import java.security.DigestOutputStream;
 import java.security.MessageDigest;
 import java.util.Comparator;
@@ -344,13 +343,11 @@ public void clear() {
 
 	private void readFrom(final FileInputStream inStream) throws IOException,
 			CorruptObjectException {
-		final FileChannel fd = inStream.getChannel();
-		final long sizeOnDisk = fd.size();
 		final BufferedInputStream in = new BufferedInputStream(inStream);
 
 		// Read the index header and verify we understand it.
 		//
-		final byte[] hdr = new byte[12];
+		final byte[] hdr = new byte[20];
 		NB.readFully(in, hdr, 0, 12);
 		if (!is_DIRC(hdr))
 			throw new CorruptObjectException("Not a DIRC file.");
@@ -369,13 +366,22 @@ private void readFrom(final FileInputStream inStream) throws IOException,
 			sortedEntries[i] = new DirCacheEntry(infos, i * INFO_LEN, in);
 		lastModified = liveFile.lastModified();
 
-		// After the file entries are index extensions.
+		// After the file entries are index extensions, and then a footer.
 		//
-		while (fd.position() - in.available() < sizeOnDisk - 20) {
-			NB.readFully(in, hdr, 0, 8);
+		for (;;) {
+			in.mark(21);
+			NB.readFully(in, hdr, 0, 20);
+			if (in.read() < 0) {
+				// No extensions present; the file ended where we expected.
+				//
+				break;
+			}
+			in.reset();
+
 			switch (NB.decodeInt32(hdr, 0)) {
 			case EXT_TREE: {
 				final byte[] raw = new byte[NB.decodeInt32(hdr, 4)];
+				NB.skipFully(in, 8);
 				NB.readFully(in, raw, 0, raw.length);
 				tree = new DirCacheTree(raw, new MutableInteger(), null);
 				break;
-- 
1.6.2.2.600.g24c24
