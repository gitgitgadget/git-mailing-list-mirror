From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/12] Allow FileHeader to create its HunkHeader children
Date: Fri, 12 Dec 2008 14:05:50 -0800
Message-ID: <1229119558-1293-5-git-send-email-spearce@spearce.org>
References: <1229119558-1293-1-git-send-email-spearce@spearce.org>
 <1229119558-1293-2-git-send-email-spearce@spearce.org>
 <1229119558-1293-3-git-send-email-spearce@spearce.org>
 <1229119558-1293-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:08:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGB9-0004x0-Tu
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbYLLWGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754365AbYLLWGJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:06:09 -0500
Received: from george.spearce.org ([209.20.77.23]:50671 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbYLLWGB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:06:01 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7D97538239; Fri, 12 Dec 2008 22:06:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A056C38200;
	Fri, 12 Dec 2008 22:05:59 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229119558-1293-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102950>

By using a factory method on FileHeader we can later subclass the
FileHeader class to handle "diff --cc" style patches, and let it
create its own subclass of HunkHeader to handle the specialized
form of the n-way diff.

The getParentCount() method is hard-coded to return 1 in the 2-way
diff case as there is exactly one parent.  But in a "diff --cc" we
need to verify the hunk header has the same number of parents as
the file header in order to parse the hunk.  So a subclass of the
FileHeader would need to override getParentCount() to return the
actual number of '@' symbols (less 1) that should appear in each
hunk header line.  (E.g. a 3-way diff shows "@@@ -" so the parent
count should be 2.)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/patch/FileHeader.java     |    8 ++++++++
 .../src/org/spearce/jgit/patch/Patch.java          |    4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index 5fe2acf..f93129d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -169,6 +169,10 @@ FileHeader(final byte[] b, final int offset) {
 		patchType = PatchType.UNIFIED;
 	}
 
+	int getParentCount() {
+		return 1;
+	}
+
 	/**
 	 * Get the old name associated with this file.
 	 * <p>
@@ -274,6 +278,10 @@ void addHunk(final HunkHeader h) {
 		hunks.add(h);
 	}
 
+	HunkHeader newHunkHeader(final int offset) {
+		return new HunkHeader(this, offset);
+	}
+
 	/** @return if a {@link PatchType#GIT_BINARY}, the new-image delta/literal */
 	public BinaryHunk getForwardBinaryHunk() {
 		return forwardBinaryHunk;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 77ae02f..05d034d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -281,8 +281,8 @@ private int parseHunks(final FileHeader fh, int c, final int end) {
 			if (match(buf, c, NEW_NAME) >= 0)
 				break;
 
-			if (isHunkHdr(buf, c, end) == 1) {
-				final HunkHeader h = new HunkHeader(fh, c);
+			if (isHunkHdr(buf, c, end) == fh.getParentCount()) {
+				final HunkHeader h = fh.newHunkHeader(c);
 				h.parseHeader(end);
 				c = h.parseBody(this, end);
 				h.endOffset = c;
-- 
1.6.1.rc2.306.ge5d5e
