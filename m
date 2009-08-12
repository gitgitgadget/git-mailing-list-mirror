From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH (RESEND) 1/4] Avoid unnecessary stat when scanning packs in the objects directory
Date: Wed, 12 Aug 2009 12:45:20 -0700
Message-ID: <1250106323-19408-2-git-send-email-spearce@spearce.org>
References: <1250106323-19408-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:46:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJlv-0001os-Bp
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbZHLTpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 15:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZHLTp2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:45:28 -0400
Received: from george.spearce.org ([209.20.77.23]:52210 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbZHLTpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:45:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D7C9138215; Wed, 12 Aug 2009 19:45:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2B10A381FD;
	Wed, 12 Aug 2009 19:45:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.225.gb589e
In-Reply-To: <1250106323-19408-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125733>

We only care that the pack name exists in the directory at this stage
of processing.  Performing a isFile() test against the pack file name
is likely to be slower than checking an in-memory HashSet, since the
OS call has to actually check the inode to determine whether or not
the name is a file, or some other node type.  Since we already have
forced the OS to give us a complete listing of the paths, its just
faster to consult that existing list.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |   49 +++++++++++--------
 1 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 7cc459c..4419f9c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -41,14 +41,16 @@
 import java.io.File;
 import java.io.FileNotFoundException;
 import java.io.FileReader;
-import java.io.FilenameFilter;
 import java.io.IOException;
 import java.util.ArrayList;
 import java.util.Arrays;
 import java.util.Collection;
+import java.util.Collections;
 import java.util.HashMap;
+import java.util.HashSet;
 import java.util.List;
 import java.util.Map;
+import java.util.Set;
 import java.util.concurrent.atomic.AtomicReference;
 
 import org.spearce.jgit.errors.PackMismatchException;
@@ -339,11 +341,23 @@ private static boolean inList(final PackFile[] list, final PackFile pack) {
 
 	private PackFile[] scanPacksImpl(final PackFile[] old) {
 		final Map<String, PackFile> forReuse = reuseMap(old);
-		final String[] idxList = listPackIdx();
-		final List<PackFile> list = new ArrayList<PackFile>(idxList.length);
-		for (final String indexName : idxList) {
+		final Set<String> names = listPackDirectory();
+		final List<PackFile> list = new ArrayList<PackFile>(names.size() >> 2);
+		for (final String indexName : names) {
+			// Must match "pack-[0-9a-f]{40}.idx" to be an index.
+			//
+			if (indexName.length() != 49 || !indexName.endsWith(".idx"))
+				continue;
+
 			final String base = indexName.substring(0, indexName.length() - 4);
 			final String packName = base + ".pack";
+			if (!names.contains(packName)) {
+				// Sometimes C Git's HTTP fetch transport leaves a
+				// .idx file behind and does not download the .pack.
+				// We have to skip over such useless indexes.
+				//
+				continue;
+			}
 
 			final PackFile oldPack = forReuse.remove(packName);
 			if (oldPack != null) {
@@ -352,14 +366,6 @@ private static boolean inList(final PackFile[] list, final PackFile pack) {
 			}
 
 			final File packFile = new File(packDirectory, packName);
-			if (!packFile.isFile()) {
-				// Sometimes C Git's HTTP fetch transport leaves a
-				// .idx file behind and does not download the .pack.
-				// We have to skip over such useless indexes.
-				//
-				continue;
-			}
-
 			final File idxFile = new File(packDirectory, indexName);
 			list.add(new PackFile(idxFile, packFile));
 		}
@@ -401,16 +407,17 @@ private static boolean inList(final PackFile[] list, final PackFile pack) {
 		return forReuse;
 	}
 
-	private String[] listPackIdx() {
+	private Set<String> listPackDirectory() {
 		packDirectoryLastModified = packDirectory.lastModified();
-		final String[] idxList = packDirectory.list(new FilenameFilter() {
-			public boolean accept(final File baseDir, final String n) {
-				// Must match "pack-[0-9a-f]{40}.idx" to be an index.
-				return n.length() == 49 && n.endsWith(".idx")
-						&& n.startsWith("pack-");
-			}
-		});
-		return idxList != null ? idxList : new String[0];
+		final String[] nameList = packDirectory.list();
+		if (nameList == null)
+			return Collections.emptySet();
+		final Set<String> nameSet = new HashSet<String>(nameList.length << 1);
+		for (final String name : nameList) {
+			if (name.startsWith("pack-"))
+				nameSet.add(name);
+		}
+		return nameSet;
 	}
 
 	@Override
-- 
1.6.4.225.gb589e
