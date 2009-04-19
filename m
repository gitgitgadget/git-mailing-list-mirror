From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 3/3] Rescan for packs and retry once if object lookup scan fails
Date: Sun, 19 Apr 2009 20:30:09 +0200
Message-ID: <1240165809-16703-4-git-send-email-robin.rosenberg@dewire.com>
References: <200904181905.55119.robin.rosenberg.lists@dewire.com>
 <1240165809-16703-1-git-send-email-robin.rosenberg@dewire.com>
 <1240165809-16703-2-git-send-email-robin.rosenberg@dewire.com>
 <1240165809-16703-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 19 20:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvbo9-0000re-RE
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 20:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbZDSSaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 14:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbZDSSaU
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 14:30:20 -0400
Received: from mail.dewire.com ([83.140.172.130]:19121 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093AbZDSSaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 14:30:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 47EDD149164F;
	Sun, 19 Apr 2009 20:30:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iaZ5vIkoqgbW; Sun, 19 Apr 2009 20:30:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 733281491658;
	Sun, 19 Apr 2009 20:30:12 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240165809-16703-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116911>

We do this by catching the FileNotFoundException thrown by the lower
layers an rescan for packs.

A lookup failure may happen if no pack contains the requested object, so
the loose object lookup fails. The other case is that one of the packs
we use has been deleted by a repack. In either case there is a good chance
that there is a new pack or loose object that contains the object.

Therefore we scan for new packs, invalidating an old ones that may have
been deleted and retry the lookup.

At the same time we stop scanning for new packs regularly since we now
have another mechanism for finding them.
---
 .../src/org/spearce/jgit/lib/Repository.java       |   76 ++++++++++++++++----
 1 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index cfd92b8..ec4226c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -100,6 +100,8 @@
 	private GitIndex index;
 
 	private List<RepositoryListener> listeners = new Vector<RepositoryListener>(); // thread safe
+
+	private int packFileListGeneration;
 	static private List<RepositoryListener> allListeners = new Vector<RepositoryListener>(); // thread safe
 
 	/**
@@ -291,6 +293,40 @@ public ObjectLoader openObject(final AnyObjectId id)
 	 */
 	public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId id)
 			throws IOException {
+		boolean scanned = false;
+		try {
+			ObjectLoader loader = openObjectInPacks(curs, id);
+			if (loader != null)
+				return loader;
+		} catch (FileNotFoundException fnfe) {
+			System.out.println(new java.util.Date().toString() + ": failed to load " + id + ", rescanning for new packs");
+			scanned = true;
+			if (scanForPacks()) {
+				ObjectLoader loader = openObjectInPacks(curs, id);
+				if (loader != null)
+					return loader;
+			}
+		}
+		try {
+			return new UnpackedObjectLoader(this, id);
+		} catch (FileNotFoundException fnfe) {
+			System.out.println(new java.util.Date().toString() + ": failed to load " + id + ", rescanning for new packs");
+			if (!scanned && scanForPacks()) {
+				ObjectLoader loader = openObjectInPacks(curs, id);
+				if (loader != null)
+					return loader;
+				try {
+					return new UnpackedObjectLoader(this, id);
+				} catch (FileNotFoundException fnfe2) {
+					return null;
+				}
+			}
+			return null;
+		}
+	}
+
+	private ObjectLoader openObjectInPacks(final WindowCursor curs, final AnyObjectId id)
+			throws IOException {
 		final PackFile[] packs = packs();
 		int k = packs.length;
 		while (k > 0) {
@@ -298,11 +334,7 @@ public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId id)
 			if (ol != null)
 				return ol;
 		}
-		try {
-			return new UnpackedObjectLoader(this, id);
-		} catch (FileNotFoundException fnfe) {
-			return null;
-		}
+		return null;
 	}
 
 	/**
@@ -813,23 +845,39 @@ synchronized (this) {
 	}
 
 	/**
-	 * Scan the object dirs, including alternates for packs
-	 * to use.
+	 * Scan the object dirs, including alternates for packs to use.
+	 * 
+	 * @return true if new packs were found
 	 */
-	public void scanForPacks() {
+	public boolean scanForPacks() {
+		int oldPackFileListGeneration = packFileListGeneration;
 		final ArrayList<PackFile> p = new ArrayList<PackFile>();
-		p.addAll(Arrays.asList(packs()));
 		for (final File d : objectsDirs())
-			scanForPacks(new File(d, "pack"), p);
+			scanForPacks(new File(d, "pack"), p, packFileList);
 		final PackFile[] arr = new PackFile[p.size()];
 		p.toArray(arr);
 		Arrays.sort(arr, PackFile.SORT);
 		synchronized (this) {
+			if (!samePackfileArray(packFileList, arr))
+				packFileListGeneration++;
 			packFileList = arr;
 		}
+		return oldPackFileListGeneration != packFileListGeneration;
 	}
 
-	private void scanForPacks(final File packDir, Collection<PackFile> packList) {
+	private static<T> boolean samePackfileArray(PackFile[] oldList, PackFile[] newList) {
+		if (oldList == null)
+			return false;
+		if (oldList.length != newList.length)
+			return false;
+		for (int i = 0; i < oldList.length; ++i) {
+			if (!oldList[i].getPackFile().equals(newList[i].getPackFile()))
+				return false;
+		}
+		return true;
+	}
+	
+	private void scanForPacks(final File packDir, Collection<PackFile> packList, PackFile[] oldPackFileList) {
 		final String[] idxList = packDir.list(new FilenameFilter() {
 			public boolean accept(final File baseDir, final String n) {
 				// Must match "pack-[0-9a-f]{40}.idx" to be an index.
@@ -851,9 +899,11 @@ public boolean accept(final File baseDir, final String n) {
 					continue;
 				}
 
-				for (final PackFile p : packList) {
-					if (packFile.equals(p.getPackFile()))
+				for (final PackFile p : oldPackFileList) {
+					if (packFile.equals(p.getPackFile())) {
+						packList.add(p);
 						continue SCAN;
+					}
 				}
 
 				packList.add(new PackFile(idxFile, packFile));
-- 
1.6.2.2.446.gfbdc0
