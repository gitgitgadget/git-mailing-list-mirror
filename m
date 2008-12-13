From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Add raw buffer fetch methods to FileHeader, HunkHeader
Date: Fri, 12 Dec 2008 18:42:25 -0800
Message-ID: <1229136146-15359-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 03:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBKTq-0002m4-7E
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 03:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbYLMCm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 21:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbYLMCm2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 21:42:28 -0500
Received: from george.spearce.org ([209.20.77.23]:38316 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbYLMCm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 21:42:27 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2CCF138211; Sat, 13 Dec 2008 02:42:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9810B38194;
	Sat, 13 Dec 2008 02:42:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102980>

These permit application level code to read back the patch
script, for example to slice it up and output parts into a
UI on a per-file or per-hunk basis.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Two last-minute patches.  While using this code in Gerrit 2 I
 realized I forgot to add a way to get the script back after its
 been parsed by the library.  :-)

 .../src/org/spearce/jgit/patch/BinaryHunk.java     |   15 +++++++++++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |   15 +++++++++++++++
 .../src/org/spearce/jgit/patch/HunkHeader.java     |   15 +++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
index 92eab86..f43a1b9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
@@ -81,6 +81,21 @@ public FileHeader getFileHeader() {
 		return file;
 	}
 
+	/** @return the byte array holding this hunk's patch script. */
+	public byte[] getBuffer() {
+		return file.buf;
+	}
+
+	/** @return offset the start of this hunk in {@link #getBuffer()}. */
+	public int getStartOffset() {
+		return startOffset;
+	}
+
+	/** @return offset one past the end of the hunk in {@link #getBuffer()}. */
+	public int getEndOffset() {
+		return endOffset;
+	}
+
 	/** @return type of this binary hunk */
 	public Type getType() {
 		return type;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index 79e4b0a..7c3a45a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -173,6 +173,21 @@ int getParentCount() {
 		return 1;
 	}
 
+	/** @return the byte array holding this file's patch script. */
+	public byte[] getBuffer() {
+		return buf;
+	}
+
+	/** @return offset the start of this file's script in {@link #getBuffer()}. */
+	public int getStartOffset() {
+		return startOffset;
+	}
+
+	/** @return offset one past the end of the file script. */
+	public int getEndOffset() {
+		return endOffset;
+	}
+
 	/**
 	 * Get the old name associated with this file.
 	 * <p>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
index fc149ac..12c670d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/HunkHeader.java
@@ -123,6 +123,21 @@ public FileHeader getFileHeader() {
 		return file;
 	}
 
+	/** @return the byte array holding this hunk's patch script. */
+	public byte[] getBuffer() {
+		return file.buf;
+	}
+
+	/** @return offset the start of this hunk in {@link #getBuffer()}. */
+	public int getStartOffset() {
+		return startOffset;
+	}
+
+	/** @return offset one past the end of the hunk in {@link #getBuffer()}. */
+	public int getEndOffset() {
+		return endOffset;
+	}
+
 	/** @return information about the old image mentioned in this hunk. */
 	public OldImage getOldImage() {
 		return old;
-- 
1.6.1.rc2.306.ge5d5e
