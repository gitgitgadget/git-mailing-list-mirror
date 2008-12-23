From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/13] Make RefDatabase thread-safe
Date: Mon, 22 Dec 2008 16:27:14 -0800
Message-ID: <1229992043-1053-5-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9t-0005lu-Mf
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYLWA1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbYLWA1b
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:31 -0500
Received: from george.spearce.org ([209.20.77.23]:54474 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbYLWA11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:27 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9FA5038260; Tue, 23 Dec 2008 00:27:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7F7D838197;
	Tue, 23 Dec 2008 00:27:25 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103784>

This is necessary to support a thread-safe Repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   29 +++++++++++---------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 4cf6e08..87f26bf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -93,7 +93,7 @@ RefDatabase(final Repository r) {
 		clearCache();
 	}
 
-	void clearCache() {
+	synchronized void clearCache() {
 		looseRefs = new HashMap<String, Ref>();
 		looseRefsMTime = new HashMap<String, Long>();
 		packedRefs = new HashMap<String, Ref>();
@@ -139,9 +139,11 @@ RefUpdate newUpdate(final String name) throws IOException {
 	}
 
 	void stored(final String origName, final String name, final ObjectId id, final long time) {
-		looseRefs.put(name, new Ref(Ref.Storage.LOOSE, origName, name, id));
-		looseRefsMTime.put(name, time);
-		setModified();
+		synchronized (this) {
+			looseRefs.put(name, new Ref(Ref.Storage.LOOSE, origName, name, id));
+			looseRefsMTime.put(name, time);
+			setModified();
+		}
 		db.fireRefsMaybeChanged();
 	}
 
@@ -157,11 +159,13 @@ void stored(final String origName, final String name, final ObjectId id, final l
 	void link(final String name, final String target) throws IOException {
 		final byte[] content = Constants.encode("ref: " + target + "\n");
 		lockAndWriteFile(fileForRef(name), content);
-		setModified();
+		synchronized (this) {
+			setModified();
+		}
 		db.fireRefsMaybeChanged();
 	}
 
-	void setModified() {
+	private void setModified() {
 		lastRefModification = refModificationCounter++;
 	}
 
@@ -210,7 +214,7 @@ Ref readRef(final String partialName) throws IOException {
 		return avail;
 	}
 
-	private void readPackedRefs(final Map<String, Ref> avail) {
+	private synchronized void readPackedRefs(final Map<String, Ref> avail) {
 		refreshPackedRefs();
 		avail.putAll(packedRefs);
 	}
@@ -229,7 +233,7 @@ private void readLooseRefs(final Map<String, Ref> avail,
 		}
 	}
 
-	private void readOneLooseRef(final Map<String, Ref> avail,
+	private synchronized void readOneLooseRef(final Map<String, Ref> avail,
 			final String origName, final String refName, final File ent) {
 		// Unchanged and cached? Don't read it again.
 		//
@@ -323,8 +327,8 @@ private Ref readRefBasic(final String name, final int depth) throws IOException 
 		return readRefBasic(name, name, depth);
 	}
 
-	private Ref readRefBasic(final String origName, final String name, final int depth)
-			throws IOException {
+	private synchronized Ref readRefBasic(final String origName,
+			final String name, final int depth) throws IOException {
 		// Prefer loose ref to packed ref as the loose
 		// file can be more up-to-date than a packed one.
 		//
@@ -408,7 +412,7 @@ private Ref readRefBasic(final String origName, final String name, final int dep
 		return ref;
 	}
 
-	private void refreshPackedRefs() {
+	private synchronized void refreshPackedRefs() {
 		final long currTime = packedRefsFile.lastModified();
 		final long currLen = currTime == 0 ? 0 : packedRefsFile.length();
 		if (currTime == packedRefsLastModified && currLen == packedRefsLength)
@@ -479,7 +483,7 @@ private void lockAndWriteFile(File file, byte[] content) throws IOException {
 			throw new ObjectWritingException("Unable to write " + name);
 	}
 
-	void removePackedRef(String name) throws IOException {
+	synchronized void removePackedRef(String name) throws IOException {
 		packedRefs.remove(name);
 		writePackedRefs();
 	}
@@ -508,5 +512,4 @@ private static BufferedReader openReader(final File fileLocation)
 		return new BufferedReader(new InputStreamReader(new FileInputStream(
 				fileLocation), Constants.CHARSET));
 	}
-
 }
-- 
1.6.1.rc4.301.g5497a
