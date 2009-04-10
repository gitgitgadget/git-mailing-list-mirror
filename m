From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/2] Improve end-of-file detection in DirCache
Date: Fri, 10 Apr 2009 04:35:50 +0200
Message-ID: <200904100435.50482.robin.rosenberg.lists@dewire.com>
References: <1239205852-28138-1-git-send-email-robin.rosenberg@dewire.com> <1239290899-24589-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 04:38:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls6dL-0006vS-6n
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 04:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935242AbZDJCge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 22:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934070AbZDJCgd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 22:36:33 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:56173 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934966AbZDJCgc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 22:36:32 -0400
Received: from sleipner.localnet (217.213.75.253) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 49CCD9F8001C4045; Fri, 10 Apr 2009 04:36:28 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1239290899-24589-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116234>

torsdag 09 april 2009 17:28:18 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> When reading from a BufferInputStream attached to a FileInputStream
> the available() method seems to return the number of unread bytes
> in the buffer plus the unread number of bytes in the file.  There is
> no guarantee for this behavior, so we can't rely on it.
> 
> Instead we read the expected 20 byte SHA1 trailer into a temporary
> buffer, and then poll for a remaining byte.  If another byte is
> still present in the input stream it indicates that there is more
> than 20 bytes worth of data remaining, which means an extension
> must be available at the current position.  If there is in fact
> an extension we put back the 21 bytes we read and proceed to do
> an 8 byte read for the extension header.
> 
> This relies on BufferInputStream's ability to buffer at least 21
> bytes of data, and put them all back in the event that we found
> an extension.  This is a much more common usage of the stream API
> and is something we can rely on working correctly all of the time,
> on any standard library implementation.

Much better. Here's a regression test, fails before, but not after.

-- robin

>From b6561578a5ff48309f69a8d442cf47ec1b51bc49 Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Fri, 10 Apr 2009 04:16:31 +0200
Subject: [EGIT PATCH] Test case for the DirCache reading code.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/dircache/DirCacheTreeTest.java    |   33 ++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
index b37095d..aca0b90 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheTreeTest.java
@@ -37,6 +37,9 @@
 
 package org.spearce.jgit.dircache;
 
+import java.io.IOException;
+
+import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.lib.RepositoryTestCase;
 
 public class DirCacheTreeTest extends RepositoryTestCase {
@@ -147,4 +150,34 @@ public void testTwoLevelSubtree() throws Exception {
 		assertEquals(acLast - acFirst + 1, acTree.getEntrySpan());
 		assertFalse(acTree.isValid());
 	}
+
+	/**
+	 * We had bugs related to buffer size in the DirCache. This test creates an
+	 * index larger than the default BufferedInputStream buffer size. This made
+	 * the DirCache unable to read the extensions when index size exceeded the
+	 * buffer size (in some cases at least).
+	 * 
+	 * @throws CorruptObjectException
+	 * @throws IOException
+	 */
+	public void testWriteReadTree() throws CorruptObjectException, IOException {
+		final DirCache dc = DirCache.lock(db);
+
+		final String A = String.format("a%2000s", "a");
+		final String B = String.format("b%2000s", "b");
+		final String[] paths = { A + ".", A + "." + B, A + "/" + B, A + "0" + B };
+		final DirCacheEntry[] ents = new DirCacheEntry[paths.length];
+		for (int i = 0; i < paths.length; i++)
+			ents[i] = new DirCacheEntry(paths[i]);
+
+		final DirCacheBuilder b = dc.builder();
+		for (int i = 0; i < ents.length; i++)
+			b.add(ents[i]);
+
+		b.commit();
+		DirCache read = DirCache.read(db);
+
+		assertEquals(paths.length, read.getEntryCount());
+		assertEquals(1, read.getCacheTree(true).getChildCount());
+	}
 }
