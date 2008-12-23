From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/13] Make Repository thread-safe
Date: Mon, 22 Dec 2008 16:27:16 -0800
Message-ID: <1229992043-1053-7-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
 <1229992043-1053-5-git-send-email-spearce@spearce.org>
 <1229992043-1053-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9v-0005lu-P2
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbYLWA1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYLWA1i
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:38 -0500
Received: from george.spearce.org ([209.20.77.23]:54480 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbYLWA12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:28 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 883FB3821F; Tue, 23 Dec 2008 00:27:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 431EC38210;
	Tue, 23 Dec 2008 00:27:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103793>

The Repository class itself is now thread-safe.  Thread safety is
ensured by copying values onto the caller stack prior to use.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   75 ++++++++++++-------
 1 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index ff36a3d..89ad991 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -46,6 +46,7 @@
 import java.io.FilenameFilter;
 import java.io.IOException;
 import java.util.ArrayList;
+import java.util.Arrays;
 import java.util.Collection;
 import java.util.Collections;
 import java.util.HashMap;
@@ -79,20 +80,22 @@
  * 	</ul>
  * </li>
  * </ul>
- *
+ * <p>
+ * This class is thread-safe.
+ * <p>
  * This implementation only handles a subtly undocumented subset of git features.
  *
  */
 public class Repository {
 	private final File gitDir;
 
-	private final File[] objectsDirs;
-
 	private final RepositoryConfig config;
 
 	private final RefDatabase refs;
 
-	private PackFile[] packs;
+	private File[] objectDirectoryList;
+
+	private PackFile[] packFileList;
 
 	private GitIndex index;
 
@@ -111,18 +114,19 @@
 	public Repository(final File d) throws IOException {
 		gitDir = d.getAbsoluteFile();
 		try {
-			objectsDirs = readObjectsDirs(FS.resolve(gitDir, "objects"),
-					new ArrayList<File>()).toArray(new File[0]);
+			objectDirectoryList = readObjectsDirs(
+					FS.resolve(gitDir, "objects"), new ArrayList<File>())
+					.toArray(new File[0]);
 		} catch (IOException e) {
 			IOException ex = new IOException("Cannot find all object dirs for " + gitDir);
 			ex.initCause(e);
 			throw ex;
 		}
 		refs = new RefDatabase(this);
-		packs = new PackFile[0];
+		packFileList = new PackFile[0];
 		config = new RepositoryConfig(this);
 
-		final boolean isExisting = objectsDirs[0].exists();
+		final boolean isExisting = objectDirectoryList[0].exists();
 		if (isExisting) {
 			getConfig().load();
 			final String repositoryFormatVersion = getConfig().getString(
@@ -138,7 +142,8 @@ public Repository(final File d) throws IOException {
 			scanForPacks();
 	}
 
-	private Collection<File> readObjectsDirs(File objectsDir, Collection<File> ret) throws IOException {
+	private static Collection<File> readObjectsDirs(File objectsDir,
+			Collection<File> ret) throws IOException {
 		ret.add(objectsDir);
 		final File altFile = FS.resolve(objectsDir, "info/alternates");
 		if (altFile.exists()) {
@@ -160,7 +165,7 @@ public Repository(final File d) throws IOException {
 	 *
 	 * @throws IOException
 	 */
-	public void create() throws IOException {
+	public synchronized void create() throws IOException {
 		if (gitDir.exists()) {
 			throw new IllegalStateException("Repository already exists: "
 					+ gitDir);
@@ -169,9 +174,9 @@ public void create() throws IOException {
 		gitDir.mkdirs();
 		refs.create();
 
-		objectsDirs[0].mkdirs();
-		new File(objectsDirs[0], "pack").mkdir();
-		new File(objectsDirs[0], "info").mkdir();
+		objectDirectoryList[0].mkdirs();
+		new File(objectDirectoryList[0], "pack").mkdir();
+		new File(objectDirectoryList[0], "info").mkdir();
 
 		new File(gitDir, "branches").mkdir();
 		new File(gitDir, "remotes").mkdir();
@@ -182,6 +187,14 @@ public void create() throws IOException {
 		getConfig().save();
 	}
 
+	private synchronized File[] objectsDirs(){
+		return objectDirectoryList;
+	}
+
+	private synchronized PackFile[] packs(){
+		return packFileList;
+	}
+
 	/**
 	 * @return GIT_DIR
 	 */
@@ -193,7 +206,7 @@ public File getDirectory() {
 	 * @return the directory containing the objects owned by this repository.
 	 */
 	public File getObjectsDirectory() {
-		return objectsDirs[0];
+		return objectsDirs()[0];
 	}
 
 	/**
@@ -217,6 +230,7 @@ public File toFile(final AnyObjectId objectId) {
 		final String n = objectId.name();
 		String d=n.substring(0, 2);
 		String f=n.substring(2);
+		final File[] objectsDirs = objectsDirs();
 		for (int i=0; i<objectsDirs.length; ++i) {
 			File ret = new File(new File(objectsDirs[i], d), f);
 			if (ret.exists())
@@ -231,6 +245,7 @@ public File toFile(final AnyObjectId objectId) {
 	 *         known shared repositories.
 	 */
 	public boolean hasObject(final AnyObjectId objectId) {
+		final PackFile[] packs = packs();
 		int k = packs.length;
 		if (k > 0) {
 			do {
@@ -271,6 +286,7 @@ public ObjectLoader openObject(final AnyObjectId id)
 	 */
 	public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId id)
 			throws IOException {
+		final PackFile[] packs = packs();
 		int k = packs.length;
 		if (k > 0) {
 			do {
@@ -341,7 +357,7 @@ public ObjectLoader openObject(final WindowCursor curs, final AnyObjectId id)
 	void openObjectInAllPacks(final AnyObjectId objectId,
 			final Collection<PackedObjectLoader> resultLoaders,
 			final WindowCursor curs) throws IOException {
-		for (PackFile pack : packs) {
+		for (PackFile pack : packs()) {
 			final PackedObjectLoader loader = pack.get(curs, objectId);
 			if (loader != null)
 				resultLoaders.add(loader);
@@ -766,11 +782,10 @@ public void close() {
 		closePacks();
 	}
 
-	void closePacks() {
-		for (int k = packs.length - 1; k >= 0; k--) {
-			packs[k].close();
-		}
-		packs = new PackFile[0];
+	synchronized void closePacks() {
+		for (int k = packFileList.length - 1; k >= 0; k--)
+			packFileList[k].close();
+		packFileList = new PackFile[0];
 	}
 
 	/**
@@ -795,11 +810,13 @@ public void openPack(final File pack, final File idx) throws IOException {
 			throw new IllegalArgumentException("Pack " + pack
 					+ "does not match index " + idx);
 
-		final PackFile[] cur = packs;
-		final PackFile[] arr = new PackFile[cur.length + 1];
-		System.arraycopy(cur, 0, arr, 1, cur.length);
-		arr[0] = new PackFile(this, idx, pack);
-		packs = arr;
+		synchronized (this) {
+			final PackFile[] cur = packFileList;
+			final PackFile[] arr = new PackFile[cur.length + 1];
+			System.arraycopy(cur, 0, arr, 1, cur.length);
+			arr[0] = new PackFile(this, idx, pack);
+			packFileList = arr;
+		}
 	}
 
 	/**
@@ -808,11 +825,13 @@ public void openPack(final File pack, final File idx) throws IOException {
 	 */
 	public void scanForPacks() {
 		final ArrayList<PackFile> p = new ArrayList<PackFile>();
-		for (int i=0; i<objectsDirs.length; ++i)
-			scanForPacks(new File(objectsDirs[i], "pack"), p);
+		for (final File d : objectsDirs())
+			scanForPacks(new File(d, "pack"), p);
 		final PackFile[] arr = new PackFile[p.size()];
 		p.toArray(arr);
-		packs = arr;
+		synchronized (this) {
+			packFileList = arr;
+		}
 	}
 
 	private void scanForPacks(final File packDir, Collection<PackFile> packList) {
-- 
1.6.1.rc4.301.g5497a
