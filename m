From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] Support for delegating tree iterators
Date: Wed,  1 Jul 2009 21:52:52 +0400
Message-ID: <1246470772-4496-1-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 19:53:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM3zT-0007cV-RA
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 19:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbZGARwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 13:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbZGARww
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 13:52:52 -0400
Received: from mail.intellij.net ([213.182.181.98]:35989 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbZGARww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 13:52:52 -0400
Received: (qmail 21907 invoked by uid 89); 1 Jul 2009 17:52:53 -0000
Received: by simscan 1.1.0 ppid: 21864, pid: 21899, t: 0.0061s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 1 Jul 2009 17:52:53 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122588>

This patch introduce some methods that simplify creation of tree
iterators that wraps other iterators and which are located in
other package. Such iterators need to efficiently access the
name component of the path of wrapped iterator and wrapped bits.
The patch also adds a method that ensuring that path buffer has
a requried capacity when the required capacity is known in advance.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
Note that WorkingTreeIterator.parseEntry is possibly might be a good 
place to use ensurePathCapacity(...) instead or growPath(...).
  
 .../jgit/treewalk/AbstractTreeIterator.java        |   60 +++++++++++++++++++-
 1 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 057250e..8f5f8c5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -252,8 +252,41 @@ protected AbstractTreeIterator(final AbstractTreeIterator p,
 	 *            be moved into the larger buffer.
 	 */
 	protected void growPath(final int len) {
+		setPathCapacity(path.length << 1, len);
+	}
+
+	/**
+	 * Ensure that path is capable to hold at least {@code capacity} bytes
+	 *
+	 * @param capacity
+	 *            the amount of bytes to hold
+	 * @param len
+	 *            the amount of live bytes in path buffer 
+	 */
+	protected void ensurePathCapacity(final int capacity, final int len) {
+		if(path.length >= capacity) {
+			return;
+		}
+		final byte[] o = path;
+		int current = o.length;
+		int newCapacity = current;
+		while(newCapacity < capacity && newCapacity > 0) {
+			newCapacity <<= 1;
+		}
+		setPathCapacity(newCapacity, len);
+	}
+
+	/**
+	 * Set path buffer capacity to the specified size
+	 *
+	 * @param capacity
+	 *            the new size
+	 * @param len
+	 *            the amount of bytes to copy
+	 */
+	private void setPathCapacity(int capacity, int len) {
 		final byte[] o = path;
-		final byte[] n = new byte[o.length << 1];
+		final byte[] n = new byte[capacity];
 		System.arraycopy(o, 0, n, 0, len);
 		for (AbstractTreeIterator p = this; p != null && p.path == o; p = p.parent)
 			p.path = n;
@@ -354,7 +387,12 @@ public void getEntryObjectId(final MutableObjectId out) {
 	public FileMode getEntryFileMode() {
 		return FileMode.fromBits(mode);
 	}
-
+	
+	/** @return the file mode of the current entry as bits */
+	public int getEntryFileModeBits() {
+		return mode;
+	}
+	
 	/** @return path of the current entry, as a string. */
 	public String getEntryPathString() {
 		return TreeWalk.pathOf(this);
@@ -531,4 +569,22 @@ public void skip() throws CorruptObjectException {
 	public void stopWalk() {
 		// Do nothing by default.  Most iterators do not care.
 	}
+	
+	/**
+	 * @return the length of the name component of the path for the current entry
+	 */
+	public int getNameLength() {
+		return pathLen - pathOffset;
+	}
+	
+	/**
+	 * Get the name component of the current entry path into the provided buffer.
+	 * 
+	 * @param buffer the buffer to get the name into, it is assumed that buffer can hold the name
+	 * @param offset the offset of the name in the buffer
+	 * @see #getNameLength()
+	 */
+	public void getName(byte[] buffer, int offset) {
+		System.arraycopy(path, pathOffset, buffer, offset, pathLen - pathOffset);
+	}
 }
-- 
1.6.1.2
