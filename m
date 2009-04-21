From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/10] Scan for new packs if GIT_DIR/objects/pack has been modified
Date: Mon, 20 Apr 2009 18:21:10 -0700
Message-ID: <1240276872-17893-9-git-send-email-spearce@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org>
 <1240276872-17893-2-git-send-email-spearce@spearce.org>
 <1240276872-17893-3-git-send-email-spearce@spearce.org>
 <1240276872-17893-4-git-send-email-spearce@spearce.org>
 <1240276872-17893-5-git-send-email-spearce@spearce.org>
 <1240276872-17893-6-git-send-email-spearce@spearce.org>
 <1240276872-17893-7-git-send-email-spearce@spearce.org>
 <1240276872-17893-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:23:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4hX-00021g-KA
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 03:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234AbZDUBVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 21:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757078AbZDUBVb
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 21:21:31 -0400
Received: from george.spearce.org ([209.20.77.23]:33032 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbZDUBVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 21:21:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8D08338221; Tue, 21 Apr 2009 01:21:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2580C38222;
	Tue, 21 Apr 2009 01:21:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.188.ga02b
In-Reply-To: <1240276872-17893-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117064>

If GIT_DIR/objects/pack directory has changed then one or more packs
may have been added to the directory, or removed from it, due to a
concurrent application performing a repack.  In such cases we need
to reload the list of available packs before conducting a search.

As packs are infrequently created or modified relative to searches,
we only scan for new packs if our search through existing packs has
turned up no results.

Transports that create packs locally through IndexPack automatically
register their new PackFile, so even those cases will typically not
require scanning the object directory again.

As misses are fairly common during IndexPack (due to its automatic
collision detection logic) we avoid scanning for packs unless the
GIT_DIR/objects/pack directory has been modified since the last
scan of it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |   15 ++++++++++++++-
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |   13 +++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
index ed1290f..ec228a1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
@@ -137,7 +137,7 @@ private final boolean hasObjectImpl1(final AnyObjectId objectId) {
 				return true;
 			}
 		}
-		return false;
+		return tryAgain1() && hasObject1(objectId);
 	}
 
 	private final boolean hasObjectImpl2(final String objectId) {
@@ -216,6 +216,12 @@ private ObjectLoader openObjectImpl1(final WindowCursor curs,
 				return ldr;
 			}
 		}
+		if (tryAgain1()) {
+			ldr = openObject1(curs, objectId);
+			if (ldr != null) {
+				return ldr;
+			}
+		}
 		return null;
 	}
 
@@ -311,6 +317,13 @@ void openObjectInAllPacks1(Collection<PackedObjectLoader> out,
 	}
 
 	/**
+	 * @return true if the fast-half search should be tried again.
+	 */
+	protected boolean tryAgain1() {
+		return false;
+	}
+
+	/**
 	 * Get the alternate databases known to this database.
 	 * 
 	 * @return the alternate list. Never null, but may be an empty array.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 36f221e..d29c63a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -75,6 +75,8 @@
 
 	private final AtomicReference<PackFile[]> packList;
 
+	private volatile long packDirectoryLastModified;
+
 	/**
 	 * Initialize a reference to an on-disk object directory.
 	 * 
@@ -257,6 +259,16 @@ protected ObjectLoader openObject2(final WindowCursor curs,
 		}
 	}
 
+	@Override
+	protected boolean tryAgain1() {
+		final PackFile[] old = packList.get();
+		if (packDirectoryLastModified <= packDirectory.lastModified()) {
+			scanPacks(old);
+			return true;
+		}
+		return false;
+	}
+
 	private void insertPack(final PackFile pf) {
 		PackFile[] o, n;
 		do {
@@ -389,6 +401,7 @@ synchronized (packList) {
 	}
 
 	private String[] listPackIdx() {
+		packDirectoryLastModified = packDirectory.lastModified();
 		final String[] idxList = packDirectory.list(new FilenameFilter() {
 			public boolean accept(final File baseDir, final String n) {
 				// Must match "pack-[0-9a-f]{40}.idx" to be an index.
-- 
1.6.3.rc1.188.ga02b
