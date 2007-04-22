From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/4] Use the Git sort order.
Date: Sun, 22 Apr 2007 23:36:03 +0200
Message-ID: <20070422213602.26396.59463.stgit@lathund.dewire.com>
References: <20070422212907.26396.12810.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 22 23:36:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfjjp-0008L6-Dk
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 23:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbXDVVgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXDVVgn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 17:36:43 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14896 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbXDVVgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 17:36:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BD54E802884;
	Sun, 22 Apr 2007 23:30:48 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25797-02; Sun, 22 Apr 2007 23:30:47 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 2D00B802892;
	Sun, 22 Apr 2007 23:30:47 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 64C3829100;
	Sun, 22 Apr 2007 23:36:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id JyoOkod8uFoU; Sun, 22 Apr 2007 23:36:20 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 6956129805;
	Sun, 22 Apr 2007 23:36:03 +0200 (CEST)
In-Reply-To: <20070422212907.26396.12810.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45280>

Do not resort trees when reading into memory. This requires
that a number of routines learn to sort tree
entries as if they end with a '/'. To do that a parameter
must be passed. I do this by passing a NUL or '/' byte as
an extra parameter for the comparison routines.

No noticeable performance difference can be noted. The reason
for this patch is to simply implementation of the git index
and make jgit more git-like.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/core/GitBlobStorage.java  |    2 -
 .../org/spearce/egit/core/GitMoveDeleteHook.java   |   17 ++++-
 .../src/org/spearce/egit/core/GitStorage.java      |    5 +
 .../egit/core/internal/mapping/GitFileHistory.java |   11 ++-
 .../core/internal/mapping/GitFileRevision.java     |    5 +
 .../org/spearce/egit/core/op/TrackOperation.java   |    8 +-
 .../org/spearce/egit/core/op/UntrackOperation.java |    6 +-
 .../spearce/egit/core/project/GitProjectData.java  |   10 ++-
 .../egit/core/project/RepositoryMapping.java       |    2 -
 .../org.spearce.jgit--All-Tests.launch             |    6 ++
 .../src/org/spearce/jgit/lib/MergedTree.java       |   27 +++++--
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |    7 --
 .../src/org/spearce/jgit/lib/SubtreeSorter.java    |   40 -----------
 .../src/org/spearce/jgit/lib/Tree.java             |   85 ++++++++++++++++-------
 .../src/org/spearce/jgit/lib/TreeEntry.java        |    9 ++
 .../tst/org/spearce/jgit/lib/T0002_Tree.java       |   33 +++++----
 .../org/spearce/jgit/lib/T0006_DeepSpeedTest.java  |    2 -
 17 files changed, 160 insertions(+), 115 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
index c947e2b..3ab2184 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
@@ -59,7 +59,7 @@ public class GitBlobStorage implements IStorage {
 			else
 				prefix = "";
 			String name = prefix + resource.getProjectRelativePath().toString();
-			entry = tree.findMember(name);
+			entry = tree.findBlobMember(name);
 		} catch (IOException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
index e09ac76..389fc76 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
@@ -122,7 +122,7 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 
 		if (s != null && m != null && m.getCacheTree() != null) {
 			try {
-				final TreeEntry e = m.getCacheTree().findMember(s);
+				final TreeEntry e = m.getCacheTree().findTreeMember(s);
 				if (e != null) {
 					e.delete();
 					m.recomputeMerge();
@@ -182,7 +182,10 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 		}
 
 		try {
-			srcEnt = srcMap.getCacheTree().findMember(srcPath);
+			if (src.getType() == IResource.FILE)
+				srcEnt = srcMap.getCacheTree().findBlobMember(srcPath);
+			else
+				srcEnt = srcMap.getCacheTree().findTreeMember(srcPath);
 			if (srcEnt == null) {
 				return FINISH_FOR_ME;
 			}
@@ -199,7 +202,11 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 			if (dstPath == null) {
 				dstTree = dstMap.getCacheTree();
 			} else {
-				final TreeEntry e = dstMap.getCacheTree().findMember(dstPath);
+				final TreeEntry e;
+				if (src.getType() == IResource.FILE)
+					e = dstMap.getCacheTree().findBlobMember(dstPath);
+				else
+					e = dstMap.getCacheTree().findTreeMember(dstPath);
 				if (e == null) {
 					dstTree = dstMap.getCacheTree().addTree(dstPath);
 				} else if (e instanceof Tree) {
@@ -216,7 +223,9 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 			// What? Something already exists at the destination? Assume
 			// Eclipse meant for us to replace the item.
 			//
-			final TreeEntry existing = dstTree.findMember(dstName);
+			TreeEntry existing = dstTree.findTreeMember(dstName);
+			if (existing == null)
+				dstTree.findBlobMember(dstName);
 			if (existing != null) {
 				existing.delete();
 			}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
index ce4ff71..edef5db 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitStorage.java
@@ -62,7 +62,10 @@ public class GitStorage implements IStorage {
 			else
 				prefix = "";
 			String name = prefix + resource.getProjectRelativePath().toString();
-			entry = tree.findMember(name);
+			if (resource.getType() == IResource.FILE)
+				entry = tree.findBlobMember(name);
+			else
+				entry = tree.findTreeMember(name);
 		} catch (IOException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 51109fb..0569862 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -147,7 +147,11 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 			ObjectId[] currentResourceHash = new ObjectId[lastResourceHash.length];
 			Tree t = current.getTree();
 			for (int i = 0; i < currentResourceHash.length; ++i) {
-				TreeEntry m = t.findMember(relativeResourceName[i]);
+				TreeEntry m;
+				if (i == relativeResourceName.length-1 && resource.getType() == IResource.FILE)
+					m = t.findBlobMember(relativeResourceName[i]);
+				else
+					m = t.findTreeMember(relativeResourceName[i]);
 				if (m != null) {
 					ObjectId id = m.getId();
 					currentResourceHash[i] = id;
@@ -251,7 +255,10 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 			}
 			TreeEntry currentEntry = current.getTree();
 			for (int i=0; i < relativeResourceName.length && currentEntry != null; ++i) {
-				((Tree)currentEntry).findMember(relativeResourceName[i]);
+				if (i == relativeResourceName.length-1 && resource.getType() == IResource.FILE)
+					((Tree)currentEntry).findBlobMember(relativeResourceName[i]);
+				else
+					((Tree)currentEntry).findTreeMember(relativeResourceName[i]);
 			}
 			if (currentEntry != null)
 				revisions = new IFileRevision[] { new GitFileRevision(current, resource,
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
index def142f..63d8486 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
@@ -156,7 +156,10 @@ public class GitFileRevision extends FileRevision {
 				else {
 					prefix = prefix + "/";
 					String name = prefix + relPath;
-					return tree.findMember(name);
+					if (resource.getType() == IResource.FILE)
+						return tree.findBlobMember(name);
+					else
+						return tree.findTreeMember(name);
 				}
 			} else
 				return tree;
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
index 2f4488d..df3dba7 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
@@ -137,12 +137,14 @@ public class TrackOperation implements IWorkspaceRunnable {
 			// Uh, what? Why are we adding a phantom resource? Just say no!
 			//
 		} else if (toAdd instanceof IFile) {
-			if (!t.exists(path)) {
-				t.addFile(path);
+			if (!t.existsTree(path)) {
+				if (!t.existsBlob(path)) {				
+					t.addFile(path);
+				}
 			}
 		} else if (toAdd instanceof IContainer) {
 			final IResource[] m = ((IContainer) toAdd).members();
-			final TreeEntry e = t.findMember(path);
+			final TreeEntry e = t.findTreeMember(path);
 			final Tree c;
 			c = e instanceof Tree ? (Tree) e : e == null ? t.addTree(path)
 					: null;
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
index 1a81192..d477644 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
@@ -120,7 +120,11 @@ public class UntrackOperation implements IWorkspaceRunnable {
 
 		try {
 			final Tree t = m.getCacheTree();
-			final TreeEntry e = t.findMember(s);
+			final TreeEntry e;
+			if (torm.getType() == IResource.FILE)
+				e = t.findBlobMember(s);
+			else
+				e = t.findTreeMember(s);
 			if (e != null) {
 				e.delete();
 				tomerge.put(m, m);
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 10cc3a0..0c4683e 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -296,7 +296,10 @@ public class GitProjectData {
 
 		if (s != null && m != null && m.getActiveDiff() != null) {
 			try {
-				return m.getActiveDiff().findMember(s);
+				if (r.getType() == IResource.FILE)
+					return m.getActiveDiff().findBlobMember(s);
+				else
+					return m.getActiveDiff().findTreeMember(s);
 			} catch (IOException ioe) {
 				throw Activator.error(
 						CoreText.GitProjectData_lazyResolveFailed, ioe);
@@ -416,7 +419,10 @@ public class GitProjectData {
 							try {
 								synchronized (cacheTree) {
 									final TreeEntry e;
-									e = cacheTree.findMember(s);
+									if (r.getType() == IResource.FILE)
+										e = cacheTree.findBlobMember(s);
+									else
+										e = cacheTree.findTreeMember(s);
 									if (e instanceof FileTreeEntry) {
 										trace("modified " + r + " -> "
 												+ e.getFullName());
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index df10665..6b9beed 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -210,7 +210,7 @@ public class RepositoryMapping {
 		Tree head = getRepository().mapTree(Constants.HEAD);
 		if (head != null) {
 			if (getSubset() != null) {
-				final TreeEntry e = head.findMember(getSubset());
+				final TreeEntry e = head.findTreeMember(getSubset());
 				e.detachParent();
 				head = e instanceof Tree ? (Tree) e : null;
 			}
diff --git a/org.spearce.jgit/org.spearce.jgit--All-Tests.launch b/org.spearce.jgit/org.spearce.jgit--All-Tests.launch
index bdbfdea..0ff3d23 100644
--- a/org.spearce.jgit/org.spearce.jgit--All-Tests.launch
+++ b/org.spearce.jgit/org.spearce.jgit--All-Tests.launch
@@ -3,11 +3,17 @@
 <booleanAttribute key="org.eclipse.jdt.junit.KEEPRUNNING_ATTR" value="false"/>
 <stringAttribute key="org.eclipse.jdt.launching.MAIN_TYPE" value=""/>
 <stringAttribute key="org.eclipse.jdt.junit.TESTNAME" value=""/>
+<listAttribute key="org.eclipse.debug.core.MAPPED_RESOURCE_TYPES">
+<listEntry value="4"/>
+</listAttribute>
 <stringAttribute key="org.eclipse.jdt.launching.PROJECT_ATTR" value="org.spearce.jgit"/>
 <listAttribute key="org.eclipse.debug.ui.favoriteGroups">
 <listEntry value="org.eclipse.debug.ui.launchGroup.run"/>
 <listEntry value="org.eclipse.debug.ui.launchGroup.debug"/>
 </listAttribute>
+<listAttribute key="org.eclipse.debug.core.MAPPED_RESOURCE_PATHS">
+<listEntry value="/org.spearce.jgit"/>
+</listAttribute>
 <stringAttribute key="org.eclipse.jdt.junit.CONTAINER" value="=org.spearce.jgit"/>
 <booleanAttribute key="org.eclipse.debug.core.appendEnvironmentVariables" value="true"/>
 <stringAttribute key="org.eclipse.jdt.junit.TEST_KIND" value="org.eclipse.jdt.junit.loader.junit3"/>
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/MergedTree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/MergedTree.java
index e5b2967..165adc3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/MergedTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/MergedTree.java
@@ -53,7 +53,7 @@ public class MergedTree {
 	}
 
 	private static final int binarySearch(final TreeEntry[] entries,
-			final int width, final byte[] nameUTF8, final int nameStart,
+			final int width, final byte[] nameUTF8, final byte nameUTF8last, final int nameStart,
 			final int nameEnd) {
 		if (entries.length == 0)
 			return -1;
@@ -66,7 +66,7 @@ public class MergedTree {
 			while (entries[ix] == null)
 				ix++;
 			cmp = Tree.compareNames(entries[ix].getNameUTF8(), nameUTF8,
-					nameStart, nameEnd);
+					nameStart, nameEnd, TreeEntry.lastChar(entries[ix]), nameUTF8last);
 			if (cmp < 0)
 				low = mid + 1;
 			else if (cmp == 0)
@@ -95,11 +95,11 @@ public class MergedTree {
 		return isModified(sources);
 	}
 
-	public TreeEntry[] findMember(final String s) throws IOException {
-		return findMember(s.getBytes(Constants.CHARACTER_ENCODING), 0);
+	public TreeEntry[] findMember(final String s, final byte slast) throws IOException {
+		return findMember(s.getBytes(Constants.CHARACTER_ENCODING), slast, 0);
 	}
 
-	public TreeEntry[] findMember(final byte[] s, final int offset)
+	public TreeEntry[] findMember(final byte[] s, final byte slast, final int offset)
 			throws IOException {
 		final int srcCnt = sources.length;
 		int slash;
@@ -108,7 +108,8 @@ public class MergedTree {
 		for (slash = offset; slash < s.length && s[slash] != '/'; slash++) {
 			// search for path component terminator
 		}
-		p = binarySearch(merged, srcCnt, s, offset, slash);
+		byte xlast = slash<s.length ? (byte)'/' : slast;
+		p = binarySearch(merged, srcCnt, s, xlast, offset, slash);
 		if (p < 0)
 			return null;
 
@@ -127,7 +128,15 @@ public class MergedTree {
 				subs[j] = merged[k] instanceof Tree ? (Tree) merged[k] : null;
 			subtrees[p] = new MergedTree(subs);
 		}
-		return subtrees[p].findMember(s, slash + 1);
+		return subtrees[p].findMember(s, slast, slash + 1);
+	}
+
+	public TreeEntry[] findBlobMember(String s) throws IOException {
+		return findMember(s,(byte)0);
+	}
+
+	public TreeEntry[] findTreeMember(String s) throws IOException {
+		return findMember(s,(byte)'/');
 	}
 
 	private void matchByName() throws IOException {
@@ -160,6 +169,7 @@ public class MergedTree {
 		newMerged = new TreeEntry[pos * srcCnt];
 		for (pos = 0, treeId = 0; done < srcCnt; pos += srcCnt, treeId++) {
 			byte[] minName = null;
+			int minNameLast = 0;
 
 			if ((pos + srcCnt) >= newMerged.length) {
 				final TreeEntry[] t = new TreeEntry[newMerged.length * 2];
@@ -176,10 +186,11 @@ public class MergedTree {
 
 				final TreeEntry thisEntry = ents[ti];
 				final int cmp = minName == null ? -1 : Tree.compareNames(
-						thisEntry.getNameUTF8(), minName);
+						thisEntry.getNameUTF8(), minName, TreeEntry.lastChar(thisEntry), minNameLast);
 
 				if (cmp < 0) {
 					minName = thisEntry.getNameUTF8();
+					minNameLast = TreeEntry.lastChar(thisEntry);
 					for (int j = srcId - 1; j >= 0; j--) {
 						if (newMerged[pos + j] != null) {
 							newMerged[pos + j] = null;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index 5722eec..f9f2bde 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -25,7 +25,6 @@ import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStreamWriter;
 import java.security.MessageDigest;
-import java.util.Arrays;
 import java.util.Iterator;
 import java.util.zip.Deflater;
 import java.util.zip.DeflaterOutputStream;
@@ -82,12 +81,6 @@ public class ObjectWriter {
 	public ObjectId writeTree(final Tree t) throws IOException {
 		final ByteArrayOutputStream o = new ByteArrayOutputStream();
 		final TreeEntry[] items = t.members();
-		for (int k = items.length - 1; k >= 0; k--) {
-			if (items[k] instanceof Tree) {
-				Arrays.sort(items, SubtreeSorter.INSTANCE);
-				break;
-			}
-		}
 		for (int k = 0; k < items.length; k++) {
 			final TreeEntry e = items[k];
 			final ObjectId id = e.getId();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/SubtreeSorter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/SubtreeSorter.java
deleted file mode 100644
index 2557525..0000000
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/SubtreeSorter.java
+++ /dev/null
@@ -1,40 +0,0 @@
-package org.spearce.jgit.lib;
-
-import java.util.Comparator;
-
-public class SubtreeSorter implements Comparator {
-	public static final SubtreeSorter INSTANCE = new SubtreeSorter();
-
-	public int compare(final Object o1, final Object o2) {
-		final TreeEntry a = (TreeEntry) o1;
-		final TreeEntry b = (TreeEntry) o2;
-		final byte[] aName = a.getNameUTF8();
-		final byte[] bName = b.getNameUTF8();
-
-		for (int k = 0; k < aName.length && k < bName.length; k++) {
-			if (aName[k] < bName[k])
-				return -1;
-			else if (aName[k] > bName[k])
-				return 1;
-		}
-
-		if (aName.length < bName.length) {
-			if (a instanceof Tree && '/' > bName[aName.length])
-				return 1;
-			return -1;
-		} else if (aName.length == bName.length) {
-			if (a instanceof Tree && b instanceof Tree)
-				return 0;
-			else if (a instanceof Tree)
-				return 1;
-			else if (b instanceof Tree)
-				return -1;
-			else
-				return 0;
-		} else {
-			if (b instanceof Tree && aName[bName.length] < '/')
-				return -1;
-			return 1;
-		}
-	}
-}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
index 65ed400..73a5e2c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
@@ -17,7 +17,6 @@
 package org.spearce.jgit.lib;
 
 import java.io.IOException;
-import java.util.Arrays;
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.EntryExistsException;
@@ -26,13 +25,14 @@ import org.spearce.jgit.errors.MissingObjectException;
 public class Tree extends TreeEntry implements Treeish {
 	public static final TreeEntry[] EMPTY_TREE = {};
 
-	public static final int compareNames(final byte[] a, final byte[] b) {
-		return compareNames(a, b, 0, b.length);
+	public static final int compareNames(final byte[] a, final byte[] b, final int lasta,final int lastb) {
+		return compareNames(a, b, 0, b.length, lasta, lastb);
 	}
 
 	public static final int compareNames(final byte[] a, final byte[] nameUTF8,
-			final int nameStart, final int nameEnd) {
-		for (int j = 0, k = nameStart; j < a.length && k < nameEnd; j++, k++) {
+			final int nameStart, final int nameEnd, final int lasta, int lastb) {
+		int j,k;
+		for (j = 0, k = nameStart; j < a.length && k < nameEnd; j++, k++) {
 			final int aj = a[j] & 0xff;
 			final int bk = nameUTF8[k] & 0xff;
 			if (aj < bk)
@@ -40,6 +40,28 @@ public class Tree extends TreeEntry implements Treeish {
 			else if (aj > bk)
 				return 1;
 		}
+		if (j < a.length) {
+			int aj = a[j]&0xff;
+			if (aj < lastb)
+				return -1;
+			else if (aj > lastb)
+				return 1;
+			else
+				return 0;
+		}
+		if (k < nameEnd) {
+			int bk = nameUTF8[k] & 0xff;
+			if (lasta < bk)
+				return -1;
+			else if (lasta > bk)
+				return 1;
+			else
+				return 0;
+		}
+		if (lasta < lastb)
+			return -1;
+		else if (lasta > lastb)
+			return 1;
 
 		final int namelength = nameEnd - nameStart;
 		if (a.length == namelength)
@@ -60,7 +82,7 @@ public class Tree extends TreeEntry implements Treeish {
 	}
 
 	private static final int binarySearch(final TreeEntry[] entries,
-			final byte[] nameUTF8, final int nameStart, final int nameEnd) {
+			final byte[] nameUTF8, final int nameUTF8last, final int nameStart, final int nameEnd) {
 		if (entries.length == 0)
 			return -1;
 		int high = entries.length;
@@ -68,7 +90,7 @@ public class Tree extends TreeEntry implements Treeish {
 		do {
 			final int mid = (low + high) / 2;
 			final int cmp = compareNames(entries[mid].getNameUTF8(), nameUTF8,
-					nameStart, nameEnd);
+					nameStart, nameEnd, TreeEntry.lastChar(entries[mid]), nameUTF8last);
 			if (cmp < 0)
 				low = mid + 1;
 			else if (cmp == 0)
@@ -151,7 +173,8 @@ public class Tree extends TreeEntry implements Treeish {
 		}
 
 		ensureLoaded();
-		p = binarySearch(contents, s, offset, slash);
+		byte xlast = slash<s.length ? (byte)'/' : 0;
+		p = binarySearch(contents, s, xlast, offset, slash);
 		if (p >= 0 && slash < s.length && contents[p] instanceof Tree)
 			return ((Tree) contents[p]).addFile(s, slash + 1);
 
@@ -184,7 +207,7 @@ public class Tree extends TreeEntry implements Treeish {
 		}
 
 		ensureLoaded();
-		p = binarySearch(contents, s, offset, slash);
+		p = binarySearch(contents, s, (byte)'/', offset, slash);
 		if (p >= 0 && slash < s.length && contents[p] instanceof Tree)
 			return ((Tree) contents[p]).addTree(s, slash + 1);
 
@@ -202,7 +225,7 @@ public class Tree extends TreeEntry implements Treeish {
 		final int p;
 
 		ensureLoaded();
-		p = binarySearch(contents, e.getNameUTF8(), 0, e.getNameUTF8().length);
+		p = binarySearch(contents, e.getNameUTF8(), TreeEntry.lastChar(e), 0, e.getNameUTF8().length);
 		if (p < 0) {
 			e.attachParent(this);
 			insertEntry(p, e);
@@ -227,7 +250,7 @@ public class Tree extends TreeEntry implements Treeish {
 
 	void removeEntry(final TreeEntry e) {
 		final TreeEntry[] c = contents;
-		final int p = binarySearch(c, e.getNameUTF8(), 0,
+		final int p = binarySearch(c, e.getNameUTF8(), TreeEntry.lastChar(e), 0,
 				e.getNameUTF8().length);
 		if (p >= 0) {
 			final TreeEntry[] n = new TreeEntry[c.length - 1];
@@ -257,15 +280,23 @@ public class Tree extends TreeEntry implements Treeish {
 			return c;
 	}
 
-	public boolean exists(final String s) throws IOException {
-		return findMember(s) != null;
+	public boolean exists(final String s, byte slast) throws IOException {
+		return findMember(s, slast) != null;
 	}
 
-	public TreeEntry findMember(final String s) throws IOException {
-		return findMember(s.getBytes(Constants.CHARACTER_ENCODING), 0);
+	public boolean existsTree(String path) throws IOException {
+		return exists(path,(byte)'/');
 	}
 
-	public TreeEntry findMember(final byte[] s, final int offset)
+	public boolean existsBlob(String path) throws IOException {
+		return exists(path,(byte)0);
+	}
+
+	public TreeEntry findMember(final String s, byte slast) throws IOException {
+		return findMember(s.getBytes(Constants.CHARACTER_ENCODING), slast, 0);
+	}
+
+	public TreeEntry findMember(final byte[] s, final byte slast, final int offset)
 			throws IOException {
 		int slash;
 		int p;
@@ -275,17 +306,26 @@ public class Tree extends TreeEntry implements Treeish {
 		}
 
 		ensureLoaded();
-		p = binarySearch(contents, s, offset, slash);
+		byte xlast = slash<s.length ? (byte)'/' : slast;
+		p = binarySearch(contents, s, xlast, offset, slash);
 		if (p >= 0) {
 			final TreeEntry r = contents[p];
 			if (slash < s.length)
-				return r instanceof Tree ? ((Tree) r).findMember(s, slash + 1)
+				return r instanceof Tree ? ((Tree) r).findMember(s, slast, slash + 1)
 						: null;
 			return r;
 		}
 		return null;
 	}
 
+	public TreeEntry findBlobMember(String s) throws IOException {
+		return findMember(s,(byte)0);
+	}
+
+	public TreeEntry findTreeMember(String s) throws IOException {
+		return findMember(s,(byte)'/');
+	}
+
 	public void accept(final TreeVisitor tv, final int flags)
 			throws IOException {
 		final TreeEntry[] c;
@@ -326,7 +366,6 @@ public class Tree extends TreeEntry implements Treeish {
 		int rawPtr = 0;
 		TreeEntry[] temp = new TreeEntry[64];
 		int nextIndex = 0;
-		boolean resort = false;
 
 		while (rawPtr < raw.length) {
 			int c = raw[rawPtr++] & 0xff;
@@ -362,7 +401,6 @@ public class Tree extends TreeEntry implements Treeish {
 				ent = new FileTreeEntry(this, id, name, true);
 			else if (FileMode.TREE.equals(mode)) {
 				ent = new Tree(this, id, name);
-				resort = true;
 			} else if (FileMode.SYMLINK.equals(mode))
 				ent = new SymlinkTreeEntry(this, id, name);
 			else
@@ -388,12 +426,6 @@ public class Tree extends TreeEntry implements Treeish {
 			contents = n;
 		}
 
-		// Resort contents using our internal sorting order. Git sorts
-		// subtrees as though their names end in '/' but that's not how
-		// we sort them in memory. Its all the fault of the index...
-		//
-		if (resort)
-			Arrays.sort(contents);
 	}
 
 	public String toString() {
@@ -403,4 +435,5 @@ public class Tree extends TreeEntry implements Treeish {
 		r.append(getFullName());
 		return r.toString();
 	}
+
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
index 084a9f3..1219846 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
@@ -126,10 +126,17 @@ public abstract class TreeEntry implements Comparable {
 		if (this == o)
 			return 0;
 		if (o instanceof TreeEntry)
-			return Tree.compareNames(nameUTF8, ((TreeEntry) o).nameUTF8);
+			return Tree.compareNames(nameUTF8, ((TreeEntry) o).nameUTF8, lastChar(this), lastChar((TreeEntry)o));
 		return -1;
 	}
 
+	final public static int lastChar(TreeEntry treeEntry) {
+		if (treeEntry instanceof FileTreeEntry)
+			return '\0';
+		else
+			return '/';
+	}
+
 	public void accept(final TreeVisitor tv) throws IOException {
 		accept(tv, 0);
 	}
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0002_Tree.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0002_Tree.java
index e757ef8..62df113 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0002_Tree.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0002_Tree.java
@@ -38,7 +38,8 @@ public class T0002_Tree extends RepositoryTestCase {
 		assertTrue("no id", t.getId() == null);
 		assertTrue("tree is self", t.getTree() == t);
 		assertTrue("database is r", t.getRepository() == db);
-		assertTrue("no foo child", t.findMember("foo") == null);
+		assertTrue("no foo child", t.findTreeMember("foo") == null);
+		assertTrue("no foo child", t.findBlobMember("foo") == null);
 	}
 
 	public void test002_addFile() throws IOException {
@@ -57,7 +58,7 @@ public class T0002_Tree extends RepositoryTestCase {
 		assertTrue("no id", f.getId() == null);
 		assertTrue("is modified", t.isModified());
 		assertTrue("has no id", t.getId() == null);
-		assertTrue("found bob", t.findMember(f.getName()) == f);
+		assertTrue("found bob", t.findBlobMember(f.getName()) == f);
 
 		final TreeEntry[] i = t.members();
 		assertTrue("iterator is not empty", i != null && i.length > 0);
@@ -87,7 +88,7 @@ public class T0002_Tree extends RepositoryTestCase {
 		assertTrue("tree is self", f.getTree() == f);
 		assertTrue("parent is modified", t.isModified());
 		assertTrue("parent has no id", t.getId() == null);
-		assertTrue("found bob child", t.findMember(f.getName()) == f);
+		assertTrue("found bob child", t.findTreeMember(f.getName()) == f);
 
 		final TreeEntry[] i = t.members();
 		assertTrue("iterator is not empty", i.length > 0);
@@ -145,14 +146,14 @@ public class T0002_Tree extends RepositoryTestCase {
 		assertTrue("t not modified.", !t.isModified());
 
 		assertEquals("full path of h ok", "f/g/h", h.getFullName());
-		assertTrue("Can find h", t.findMember(h.getFullName()) == h);
-		assertTrue("Can't find f/z", t.findMember("f/z") == null);
-		assertTrue("Can't find y/z", t.findMember("y/z") == null);
+		assertTrue("Can find h", t.findTreeMember(h.getFullName()) == h);
+		assertTrue("Can't find f/z", t.findBlobMember("f/z") == null);
+		assertTrue("Can't find y/z", t.findBlobMember("y/z") == null);
 
 		final FileTreeEntry i = h.addFile("i");
 		assertNotNull(i);
 		assertEquals("full path of i ok", "f/g/h/i", i.getFullName());
-		assertTrue("Can find i", t.findMember(i.getFullName()) == i);
+		assertTrue("Can find i", t.findBlobMember(i.getFullName()) == i);
 		assertTrue("h modified", h.isModified());
 		assertTrue("g modified", g.isModified());
 		assertTrue("f modified", f.isModified());
@@ -190,17 +191,17 @@ public class T0002_Tree extends RepositoryTestCase {
 
 	public void test008_SubtreeInternalSorting() throws IOException {
 		final Tree t = new Tree(db);
-		final FileTreeEntry e0 = t.addFile("a-");
-		final FileTreeEntry e1 = t.addFile("a-b");
-		final Tree e2 = t.addTree("a");
-		final FileTreeEntry e3 = t.addFile("a=");
-		final FileTreeEntry e4 = t.addFile("a=b");
+		final FileTreeEntry e0 = t.addFile("a-b");
+		final FileTreeEntry e1 = t.addFile("a-");
+		final FileTreeEntry e2 = t.addFile("a=b");
+		final Tree e3 = t.addTree("a");
+		final FileTreeEntry e4 = t.addFile("a=");
 
 		final TreeEntry[] ents = t.members();
-		assertSame(e2, ents[0]);
+		assertSame(e1, ents[0]);
 		assertSame(e0, ents[1]);
-		assertSame(e1, ents[2]);
-		assertSame(e3, ents[3]);
-		assertSame(e4, ents[4]);
+		assertSame(e3, ents[2]);
+		assertSame(e4, ents[3]);
+		assertSame(e2, ents[4]);
 	}
 }
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
index 2ae9d42..b4ae4b8 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
@@ -39,7 +39,7 @@ public class T0006_DeepSpeedTest extends SpeedTestBase {
 			if (parent.size() > 0) {
 				ObjectId parentId = (ObjectId) parent.get(0);
 				commit = db.mapCommit(parentId);
-				TreeEntry m = commit.getTree().findMember("net/netfilter/nf_queue.c");
+				TreeEntry m = commit.getTree().findBlobMember("net/netfilter/nf_queue.c");
 				if (m != null)
 					commit.getCommitId().toString();
 				++n;
