From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Improve end-of-file detection in DirCache
Date: Wed,  8 Apr 2009 17:50:52 +0200
Message-ID: <1239205852-28138-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lra4i-0003Kw-TF
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbZDHPvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbZDHPu6
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:50:58 -0400
Received: from mail.dewire.com ([83.140.172.130]:6915 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbZDHPu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 11:50:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EAAAF14915DB;
	Wed,  8 Apr 2009 17:50:55 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APwvaMIjzIAU; Wed,  8 Apr 2009 17:50:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id EF37414915D6;
	Wed,  8 Apr 2009 17:50:54 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116090>

When reading from an BufferInputStream attached to a
FileInputStream the available() method seems to return
the number of unread bytes in the buffer plus the unread
number of bytes in the file.

There is no guarantee for this behaviour so this quick fix
might not be as stable as we would wish.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

---
  http://code.google.com/p/egit/issues/detail?id=66
---
 .../src/org/spearce/jgit/dircache/DirCache.java    |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
index 8eb4022..657762e 100644
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
@@ -344,8 +343,6 @@ public void clear() {
 
 	private void readFrom(final FileInputStream inStream) throws IOException,
 			CorruptObjectException {
-		final FileChannel fd = inStream.getChannel();
-		final long sizeOnDisk = fd.size();
 		final BufferedInputStream in = new BufferedInputStream(inStream);
 
 		// Read the index header and verify we understand it.
@@ -369,9 +366,16 @@ private void readFrom(final FileInputStream inStream) throws IOException,
 			sortedEntries[i] = new DirCacheEntry(infos, i * INFO_LEN, in);
 		lastModified = liveFile.lastModified();
 
-		// After the file entries are index extensions.
-		//
-		while (fd.position() - in.available() < sizeOnDisk - 20) {
+		/*
+		 * InputStream.available() on file input streams seems to return the
+		 * rest of the file i.e. buffer size + unread file on disk. There is no
+		 * guarantee for this so we need to fix this or we may miss extensions
+		 * when reading the index in a few races cases.
+		 *
+		 * That is currently no disaster though.
+		 */
+		while (in.available() > 20) {
+			// After the file entries are index extensions.
 			NB.readFully(in, hdr, 0, 8);
 			switch (NB.decodeInt32(hdr, 0)) {
 			case EXT_TREE: {
-- 
1.6.2.2.446.gfbdc0
