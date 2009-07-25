From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/4] Make ObjectDirectory last modified time atomically updated with list
Date: Sat, 25 Jul 2009 15:52:21 -0700
Message-ID: <1248562343-18815-3-git-send-email-spearce@spearce.org>
References: <1248562343-18815-1-git-send-email-spearce@spearce.org>
 <1248562343-18815-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:52:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUq6Y-0002UW-Pu
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 00:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbZGYWw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 18:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbZGYWw1
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 18:52:27 -0400
Received: from george.spearce.org ([209.20.77.23]:58126 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZGYWwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 18:52:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3F0CD3821F; Sat, 25 Jul 2009 22:52:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 35116381FE;
	Sat, 25 Jul 2009 22:52:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248562343-18815-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124085>

By moving the last modified time and the PackFile[] into the same
object and using that object as the atomic access unit we ensure
that the two values change atomically for all readers.

This refactoring step prepares the code so we can later fix a race
condition where the objects directory is modified multiple times in
the same filesystem clock window, but a reader scanned the directory
during that same clock window.

A nice cleanup performed here is to eliminate the null pointer value
from the packList reference field.  Instead of getting a null we
get NO_PACKS, which uses an "impossible" last modified time of -1,
forcing any caller to scan the directory the first time a pack
is required.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |  126 ++++++++++----------
 1 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 4419f9c..5b28207 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -66,7 +66,7 @@
  * {@link PackFile}s.
  */
 public class ObjectDirectory extends ObjectDatabase {
-	private static final PackFile[] NO_PACKS = {};
+	private static final PackList NO_PACKS = new PackList(-1, new PackFile[0]);
 
 	private final File objects;
 
@@ -76,9 +76,7 @@
 
 	private final File alternatesFile;
 
-	private final AtomicReference<PackFile[]> packList;
-
-	private volatile long packDirectoryLastModified;
+	private final AtomicReference<PackList> packList;
 
 	/**
 	 * Initialize a reference to an on-disk object directory.
@@ -91,8 +89,7 @@ public ObjectDirectory(final File dir) {
 		infoDirectory = new File(objects, "info");
 		packDirectory = new File(objects, "pack");
 		alternatesFile = new File(infoDirectory, "alternates");
-
-		packList = new AtomicReference<PackFile[]>();
+		packList = new AtomicReference<PackList>(NO_PACKS);
 	}
 
 	/**
@@ -116,13 +113,10 @@ public void create() throws IOException {
 
 	@Override
 	public void closeSelf() {
-		PackFile[] packs = packList.get();
-		if (packs != null) {
-			packList.set(null);
-			for (final PackFile p : packs) {
-				p.close();
-			}
-		}
+		final PackList packs = packList.get();
+		packList.set(NO_PACKS);
+		for (final PackFile p : packs.packs)
+			p.close();
 	}
 
 	/**
@@ -176,7 +170,7 @@ public String toString() {
 
 	@Override
 	protected boolean hasObject1(final AnyObjectId objectId) {
-		for (final PackFile p : packs()) {
+		for (final PackFile p : packList.get().packs) {
 			try {
 				if (p.hasObject(objectId)) {
 					return true;
@@ -196,9 +190,9 @@ protected boolean hasObject1(final AnyObjectId objectId) {
 	@Override
 	protected ObjectLoader openObject1(final WindowCursor curs,
 			final AnyObjectId objectId) throws IOException {
-		PackFile[] pList = packs();
+		PackList pList = packList.get();
 		SEARCH: for (;;) {
-			for (final PackFile p : pList) {
+			for (final PackFile p : pList.packs) {
 				try {
 					final PackedObjectLoader ldr = p.get(curs, objectId);
 					if (ldr != null) {
@@ -224,9 +218,9 @@ protected ObjectLoader openObject1(final WindowCursor curs,
 	void openObjectInAllPacks1(final Collection<PackedObjectLoader> out,
 			final WindowCursor curs, final AnyObjectId objectId)
 			throws IOException {
-		PackFile[] pList = packs();
+		PackList pList = packList.get();
 		SEARCH: for (;;) {
-			for (final PackFile p : pList) {
+			for (final PackFile p : pList.packs) {
 				try {
 					final PackedObjectLoader ldr = p.get(curs, objectId);
 					if (ldr != null) {
@@ -265,8 +259,8 @@ protected ObjectLoader openObject2(final WindowCursor curs,
 
 	@Override
 	protected boolean tryAgain1() {
-		final PackFile[] old = packList.get();
-		if (packDirectoryLastModified < packDirectory.lastModified()) {
+		final PackList old = packList.get();
+		if (old.tryAgain(packDirectory.lastModified())) {
 			scanPacks(old);
 			return true;
 		}
@@ -274,57 +268,46 @@ protected boolean tryAgain1() {
 	}
 
 	private void insertPack(final PackFile pf) {
-		PackFile[] o, n;
+		PackList o, n;
 		do {
-			o = packs();
-			n = new PackFile[1 + o.length];
-			n[0] = pf;
-			System.arraycopy(o, 0, n, 1, o.length);
+			o = packList.get();
+			final PackFile[] oldList = o.packs;
+			final PackFile[] newList = new PackFile[1 + oldList.length];
+			newList[0] = pf;
+			System.arraycopy(oldList, 0, newList, 1, oldList.length);
+			n = new PackList(o.lastModified, newList);
 		} while (!packList.compareAndSet(o, n));
 	}
 
 	private void removePack(final PackFile deadPack) {
-		PackFile[] o, n;
+		PackList o, n;
 		do {
 			o = packList.get();
-			if (o == null || !inList(o, deadPack)) {
-				break;
 
-			} else if (o.length == 1) {
-				n = NO_PACKS;
+			final PackFile[] oldList = o.packs;
+			final int j = indexOf(oldList, deadPack);
+			if (j < 0)
+				break;
 
-			} else {
-				n = new PackFile[o.length - 1];
-				int j = 0;
-				for (final PackFile p : o) {
-					if (p != deadPack) {
-						n[j++] = p;
-					}
-				}
-			}
+			final PackFile[] newList = new PackFile[oldList.length - 1];
+			System.arraycopy(oldList, 0, newList, 0, j);
+			System.arraycopy(oldList, j + 1, newList, j, newList.length - j);
+			n = new PackList(o.lastModified, newList);
 		} while (!packList.compareAndSet(o, n));
 		deadPack.close();
 	}
 
-	private static boolean inList(final PackFile[] list, final PackFile pack) {
-		for (final PackFile p : list) {
-			if (p == pack) {
-				return true;
-			}
+	private static int indexOf(final PackFile[] list, final PackFile pack) {
+		for (int i = 0; i < list.length; i++) {
+			if (list[i] == pack)
+				return i;
 		}
-		return false;
-	}
-
-	private PackFile[] packs() {
-		PackFile[] r = packList.get();
-		if (r == null)
-			r = scanPacks(null);
-		return r;
+		return -1;
 	}
 
-	private PackFile[] scanPacks(final PackFile[] original) {
+	private PackList scanPacks(final PackList original) {
 		synchronized (packList) {
-			PackFile[] o, n;
+			PackList o, n;
 			do {
 				o = packList.get();
 				if (o != original) {
@@ -333,14 +316,15 @@ private static boolean inList(final PackFile[] list, final PackFile pack) {
 					//
 					return o;
 				}
-				n = scanPacksImpl(o != null ? o : NO_PACKS);
+				n = scanPacksImpl(o);
 			} while (!packList.compareAndSet(o, n));
 			return n;
 		}
 	}
 
-	private PackFile[] scanPacksImpl(final PackFile[] old) {
+	private PackList scanPacksImpl(final PackList old) {
 		final Map<String, PackFile> forReuse = reuseMap(old);
+		final long lastModified = packDirectory.lastModified();
 		final Set<String> names = listPackDirectory();
 		final List<PackFile> list = new ArrayList<PackFile>(names.size() >> 2);
 		for (final String indexName : names) {
@@ -374,17 +358,17 @@ private static boolean inList(final PackFile[] list, final PackFile pack) {
 			p.close();
 		}
 
-		if (list.isEmpty()) {
-			return NO_PACKS;
-		}
+		if (list.isEmpty())
+			return new PackList(lastModified, NO_PACKS.packs);
+
 		final PackFile[] r = list.toArray(new PackFile[list.size()]);
 		Arrays.sort(r, PackFile.SORT);
-		return r;
+		return new PackList(lastModified, r);
 	}
 
-	private static Map<String, PackFile> reuseMap(final PackFile[] old) {
+	private static Map<String, PackFile> reuseMap(final PackList old) {
 		final Map<String, PackFile> forReuse = new HashMap<String, PackFile>();
-		for (final PackFile p : old) {
+		for (final PackFile p : old.packs) {
 			if (p.invalid()) {
 				// The pack instance is corrupted, and cannot be safely used
 				// again. Do not include it in our reuse map.
@@ -408,7 +392,6 @@ private static boolean inList(final PackFile[] list, final PackFile pack) {
 	}
 
 	private Set<String> listPackDirectory() {
-		packDirectoryLastModified = packDirectory.lastModified();
 		final String[] nameList = packDirectory.list();
 		if (nameList == null)
 			return Collections.emptySet();
@@ -454,4 +437,21 @@ private ObjectDatabase openAlternate(final String location)
 		}
 		return new ObjectDirectory(objdir);
 	}
+
+	private static final class PackList {
+		/** Last modification time of {@link ObjectDirectory#packDirectory}. */
+		final long lastModified;
+
+		/** All known packs, sorted by {@link PackFile#SORT}. */
+		final PackFile[] packs;
+
+		PackList(final long lastModified, final PackFile[] packs) {
+			this.lastModified = lastModified;
+			this.packs = packs;
+		}
+
+		boolean tryAgain(final long currLastModified) {
+			return lastModified < currLastModified;
+		}
+	}
 }
-- 
1.6.4.rc2.216.g769fa
