From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5 v2] Add copy(InputStream) to TemporaryBuffer
Date: Thu, 11 Dec 2008 08:53:45 -0800
Message-ID: <20081211165345.GG32487@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org> <1228971522-28764-2-git-send-email-spearce@spearce.org> <1228971522-28764-3-git-send-email-spearce@spearce.org> <200812111640.34435.robin.rosenberg@dewire.com> <20081211155218.GF32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 17:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAop0-0006Op-Tl
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 17:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461AbYLKQxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 11:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757796AbYLKQxr
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 11:53:47 -0500
Received: from george.spearce.org ([209.20.77.23]:50737 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788AbYLKQxq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 11:53:46 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C27E638200; Thu, 11 Dec 2008 16:53:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081211155218.GF32487@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102805>

In some places we may find ourselves with an InputStream we
need to copy into a TemporaryBuffer, so we can flatten out the
entire stream to a single byte[].  Putting the copy loop here
is more useful then duplicating it in application level code.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  "Shawn O. Pearce" <spearce@spearce.org> wrote:
  > Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
  > > torsdag 11 december 2008 05:58:39 skrev Shawn O. Pearce:
  > > > +		final byte[] b = new byte[2048];
  > >
  > > Why not 8192 here too?
  > 
  > Blargh, you're right.  Actually what I should do is look to see
  > if blocks != null, in which case I should alloc a block and read
  > directly into it.  That would avoid one copy of the data.

  And now we do that...
  
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
index b1ffd6e..761f359 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
@@ -42,6 +42,7 @@
 import java.io.FileInputStream;
 import java.io.FileOutputStream;
 import java.io.IOException;
+import java.io.InputStream;
 import java.io.OutputStream;
 import java.util.ArrayList;
 
@@ -135,6 +136,39 @@ public void write(final byte[] b, int off, int len) throws IOException {
 			diskOut.write(b, off, len);
 	}
 
+	/**
+	 * Copy all bytes remaining on the input stream into this buffer.
+	 * 
+	 * @param in
+	 *            the stream to read from, until EOF is reached.
+	 * @throws IOException
+	 *             an error occurred reading from the input stream, or while
+	 *             writing to a local temporary file.
+	 */
+	public void copy(final InputStream in) throws IOException {
+		if (blocks != null) {
+			for (;;) {
+				Block s = last();
+				if (s.isFull()) {
+					if (reachedInCoreLimit())
+						break;
+					s = new Block();
+					blocks.add(s);
+				}
+
+				final int n = in.read(s.buffer, s.count, Block.SZ - s.count);
+				if (n < 1)
+					return;
+				s.count += n;
+			}
+		}
+
+		final byte[] tmp = new byte[Block.SZ];
+		int n;
+		while ((n = in.read(tmp)) > 0)
+			diskOut.write(tmp, 0, n);
+	}
+
 	private Block last() {
 		return blocks.get(blocks.size() - 1);
 	}
-- 
1.6.1.rc2.306.ge5d5e


-- 
Shawn.
