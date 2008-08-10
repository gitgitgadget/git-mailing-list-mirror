From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 07/11] Allow WorkingTreeIterator to track last modified time for entries
Date: Sun, 10 Aug 2008 01:46:22 -0700
Message-ID: <1218357986-19671-8-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
 <1218357986-19671-3-git-send-email-spearce@spearce.org>
 <1218357986-19671-4-git-send-email-spearce@spearce.org>
 <1218357986-19671-5-git-send-email-spearce@spearce.org>
 <1218357986-19671-6-git-send-email-spearce@spearce.org>
 <1218357986-19671-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6aY-0001pt-L7
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYHJIqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbYHJIqn
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:43 -0400
Received: from george.spearce.org ([209.20.77.23]:51285 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbYHJIqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E2CD638389; Sun, 10 Aug 2008 08:46:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4051B38375;
	Sun, 10 Aug 2008 08:46:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91815>

We need this last modified time to compare against the index to decide
if a file is dirty or not.  Its computed on demand only for the items
we actually care about, as we don't need the last modified time for a
directory.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/treewalk/FileTreeIterator.java    |    9 +++++++++
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |   13 +++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.java
index 331f153..25425dd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/FileTreeIterator.java
@@ -106,6 +106,8 @@ public class FileTreeIterator extends WorkingTreeIterator {
 
 		private long length = -1;
 
+		private long lastModified;
+
 		FileEntry(final File f) {
 			file = f;
 
@@ -138,6 +140,13 @@ public class FileTreeIterator extends WorkingTreeIterator {
 		}
 
 		@Override
+		public long getLastModified() {
+			if (lastModified == 0)
+				lastModified = file.lastModified();
+			return lastModified;
+		}
+
+		@Override
 		public InputStream openInputStream() throws IOException {
 			return new FileInputStream(file);
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
index afac77b..cb4a089 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterator.java
@@ -433,6 +433,19 @@ public abstract class WorkingTreeIterator extends AbstractTreeIterator {
 		public abstract long getLength();
 
 		/**
+		 * Get the last modified time of this entry.
+		 * <p>
+		 * <b>Note: Efficient implementation required.</b>
+		 * <p>
+		 * The implementation of this method must be efficient. If a subclass
+		 * needs to compute the value they should cache the reference within an
+		 * instance member instead.
+		 * 
+		 * @return time since the epoch (in ms) of the last change.
+		 */
+		public abstract long getLastModified();
+
+		/**
 		 * Get the name of this entry within its directory.
 		 * <p>
 		 * Efficient implementations are not required. The caller will obtain
-- 
1.6.0.rc2.219.g1250ab
