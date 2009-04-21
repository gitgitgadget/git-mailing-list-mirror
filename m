From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2 08/10] Scan for new packs if GIT_DIR/objects/pack
	has been modified
Date: Mon, 20 Apr 2009 19:08:07 -0700
Message-ID: <20090421020807.GA23604@spearce.org>
References: <1240276872-17893-1-git-send-email-spearce@spearce.org> <1240276872-17893-2-git-send-email-spearce@spearce.org> <1240276872-17893-3-git-send-email-spearce@spearce.org> <1240276872-17893-4-git-send-email-spearce@spearce.org> <1240276872-17893-5-git-send-email-spearce@spearce.org> <1240276872-17893-6-git-send-email-spearce@spearce.org> <1240276872-17893-7-git-send-email-spearce@spearce.org> <1240276872-17893-8-git-send-email-spearce@spearce.org> <1240276872-17893-9-git-send-email-spearce@spearce.org> <20090421013911.GZ23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 04:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw5Qd-0002CK-Ui
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 04:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbZDUCIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 22:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbZDUCII
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 22:08:08 -0400
Received: from george.spearce.org ([209.20.77.23]:56479 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbZDUCII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 22:08:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2B79B3821F; Tue, 21 Apr 2009 02:08:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090421013911.GZ23604@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117074>

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

 "Shawn O. Pearce" <spearce@spearce.org> wrote:
 > 
 > We could try to fudge it by saying < here, [...]
 > I think in real applications, its "good enough" to allow this amount
 > of fudging.

 And this version makes it so.  The interdiff is just <= changed to <.

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
index 36f221e..6ba0180 100644
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
+		if (packDirectoryLastModified < packDirectory.lastModified()) {
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
