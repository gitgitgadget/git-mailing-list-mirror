From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/10] Rescan packs if a pack is modified in-place (part 1)
Date: Mon, 20 Apr 2009 18:21:09 -0700
Message-ID: <1240276872-17893-8-git-send-email-spearce@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org>
 <1240276872-17893-2-git-send-email-spearce@spearce.org>
 <1240276872-17893-3-git-send-email-spearce@spearce.org>
 <1240276872-17893-4-git-send-email-spearce@spearce.org>
 <1240276872-17893-5-git-send-email-spearce@spearce.org>
 <1240276872-17893-6-git-send-email-spearce@spearce.org>
 <1240276872-17893-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4io-0002M1-Df
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbZDUBVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757311AbZDUBVl
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:41 -0400
Received: from george.spearce.org ([209.20.77.23]:33025 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757603AbZDUBVT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1286E3821F; Tue, 21 Apr 2009 01:21:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D68A138221;
	Tue, 21 Apr 2009 01:21:15 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
In-Reply-To: <1240276872-17893-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117070>

If a pack file is modified in place it usually means that some other
process has repacked this repository, but the contents of this one
pack remained the same, but the object offsets may be different due
to different pack creation settings.  In such cases we can no longer
use the existing PacKFile or PackIndex instances and instead we need
to create new ones.

This isn't a full solution to the problem.  It is possible for an
application to obtain a PackedObjectLoader, see the PackFile get
closed due to pressure on the WindowCache, then fail when the pack
is reopened due to the pack being recreated on disk.  PackWriter
is very susceptible to this, as it caches PackedObjectLoaders for
a long time before it uses them to copy data out of an existing
pack file.

This particular solution only catches the failure where we had
opened the index a long time ago, closed the pack, and are now
opening it again in order to construct a PackedObjectLoader for
the caller.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |   66 +++++++++++++------
 .../src/org/spearce/jgit/lib/PackFile.java         |   20 +++++-
 2 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index e7156c4..36f221e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -51,6 +51,7 @@
 import java.util.Map;
 import java.util.concurrent.atomic.AtomicReference;
 
+import org.spearce.jgit.errors.PackMismatchException;
 import org.spearce.jgit.util.FS;
 
 /**
@@ -190,38 +191,53 @@ protected boolean hasObject1(final AnyObjectId objectId) {
 	@Override
 	protected ObjectLoader openObject1(final WindowCursor curs,
 			final AnyObjectId objectId) throws IOException {
-		for (final PackFile p : packs()) {
-			try {
-				final ObjectLoader ldr = p.get(curs, objectId);
-				if (ldr != null) {
-					return ldr;
+		PackFile[] pList = packs();
+		SEARCH: for (;;) {
+			for (final PackFile p : pList) {
+				try {
+					final ObjectLoader ldr = p.get(curs, objectId);
+					if (ldr != null) {
+						return ldr;
+					}
+				} catch (PackMismatchException e) {
+					// Pack was modified; refresh the entire pack list.
+					//
+					pList = scanPacks(pList);
+					continue SEARCH;
+				} catch (IOException e) {
+					// Assume the pack is corrupted.
+					//
+					removePack(p);
 				}
-			} catch (IOException e) {
-				// Assume the pack is corrupted.
-				//
-				removePack(p);
-				continue;
 			}
+			return null;
 		}
-		return null;
 	}
 
 	@Override
 	void openObjectInAllPacks1(final Collection<PackedObjectLoader> out,
 			final WindowCursor curs, final AnyObjectId objectId)
 			throws IOException {
-		for (final PackFile p : packs()) {
-			try {
-				final PackedObjectLoader ldr = p.get(curs, objectId);
-				if (ldr != null) {
-					out.add(ldr);
+		PackFile[] pList = packs();
+		SEARCH: for (;;) {
+			for (final PackFile p : pList) {
+				try {
+					final PackedObjectLoader ldr = p.get(curs, objectId);
+					if (ldr != null) {
+						out.add(ldr);
+					}
+				} catch (PackMismatchException e) {
+					// Pack was modified; refresh the entire pack list.
+					//
+					pList = scanPacks(pList);
+					continue SEARCH;
+				} catch (IOException e) {
+					// Assume the pack is corrupted.
+					//
+					removePack(p);
 				}
-			} catch (IOException e) {
-				// Assume the pack is corrupted.
-				//
-				removePack(p);
-				continue;
 			}
+			break SEARCH;
 		}
 	}
 
@@ -350,6 +366,14 @@ synchronized (packList) {
 	private static Map<String, PackFile> reuseMap(final PackFile[] old) {
 		final Map<String, PackFile> forReuse = new HashMap<String, PackFile>();
 		for (final PackFile p : old) {
+			if (p.invalid()) {
+				// The pack instance is corrupted, and cannot be safely used
+				// again. Do not include it in our reuse map.
+				//
+				p.close();
+				continue;
+			}
+
 			final PackFile prior = forReuse.put(p.getPackFile().getName(), p);
 			if (prior != null) {
 				// This should never occur. It should be impossible for us
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index bda4843..74ffef8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -73,6 +73,8 @@ public int compare(final PackFile a, final PackFile b) {
 
 	private int packLastModified;
 
+	private volatile boolean invalid;
+
 	private PackIndex loadedIdx;
 
 	private PackReverseIndex reverseIdx;
@@ -91,14 +93,24 @@ public PackFile(final File idxFile, final File packFile) {
 		pack = new WindowedFile(packFile) {
 			@Override
 			protected void onOpen() throws IOException {
-				onOpenPack();
+				try {
+					onOpenPack();
+				} catch (IOException e) {
+					invalid = true;
+					throw e;
+				}
 			}
 		};
 	}
 
 	private synchronized PackIndex idx() throws IOException {
 		if (loadedIdx == null) {
-			loadedIdx = PackIndex.open(idxFile);
+			try {
+				loadedIdx = PackIndex.open(idxFile);
+			} catch (IOException e) {
+				invalid = true;
+				throw e;
+			}
 		}
 		return loadedIdx;
 	}
@@ -267,6 +279,10 @@ boolean supportsFastCopyRawData() throws IOException {
 		return idx().hasCRC32Support();
 	}
 
+	boolean invalid() {
+		return invalid;
+	}
+
 	private void onOpenPack() throws IOException {
 		final PackIndex idx = idx();
 		final WindowCursor curs = new WindowCursor();
-- 
1.6.3.rc1.188.ga02b
