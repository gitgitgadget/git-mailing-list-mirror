From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 04/10] Speed up history by comparing tree hashes.
Date: Sun, 11 Mar 2007 19:15:37 +0100
Message-ID: <20070311181537.18012.48173.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYg-0006IS-Lb
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933943AbXCKSOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933945AbXCKSOE
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:14:04 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1618 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933943AbXCKSOB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:14:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 94C67802841;
	Sun, 11 Mar 2007 19:08:45 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26264-02; Sun, 11 Mar 2007 19:08:45 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id EC044802E25;
	Sun, 11 Mar 2007 19:08:44 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 1F1A628D45;
	Sun, 11 Mar 2007 19:15:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id tIA8DjMpDXDH; Sun, 11 Mar 2007 19:15:47 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 8B055291D2;
	Sun, 11 Mar 2007 19:15:37 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41954>

Instead of looking up full path name all the time we split the
path name of the resource we are looking at and compare hashed
at each level.

The performance improvement isn't huge since most of the work
is reading commits.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../egit/core/internal/mapping/GitFileHistory.java |   79 +++++++++++++++--------
 .../src/org/spearce/jgit/lib/ObjectId.java         |    6 ++
 2 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 163278d..6c40bb0 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -18,6 +18,7 @@ package org.spearce.egit.core.internal.mapping;
 
 import java.io.IOException;
 import java.util.ArrayList;
+import java.util.Arrays;
 import java.util.Collection;
 import java.util.Collections;
 import java.util.Date;
@@ -34,13 +35,14 @@ import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 
 public class GitFileHistory extends FileHistory {
 
 	private final IResource resource;
 
-	private final String relativeResourceName;
+	private final String[] relativeResourceName;
 
 	private final int flags;
 
@@ -50,12 +52,11 @@ public class GitFileHistory extends FileHistory {
 		this.resource = resource;
 		this.flags = flags;
 		String prefix = getRepositoryMapping().getSubset();
-		if (prefix != null)
-			prefix = prefix + "/";
-		else
-			prefix = "";
-		relativeResourceName = prefix
-				+ resource.getProjectRelativePath().toString();
+		String[] prefixSegments = prefix!=null ? prefix.split("/") : new String[0];
+		String[] resourceSegments = resource.getProjectRelativePath().segments(); 
+		relativeResourceName = new String[prefixSegments.length + resourceSegments.length];
+		System.arraycopy(prefixSegments, 0, relativeResourceName, 0, prefixSegments.length);
+		System.arraycopy(resourceSegments, 0, relativeResourceName, prefixSegments.length, resourceSegments.length);
 	}
 
 	public IFileRevision[] getContributors(IFileRevision revision) {
@@ -105,7 +106,9 @@ public class GitFileHistory extends FileHistory {
 		try {
 			ObjectId id = repository.resolve("HEAD");
 			Commit commit = repository.mapCommit(id);
-			return collectHistory(new ObjectId(ObjectId.toString(null)),
+			ObjectId[] initialResourceHash = new ObjectId[relativeResourceName.length];
+			Arrays.fill(initialResourceHash, ObjectId.zeroId());
+			return collectHistory(initialResourceHash, null,
 					repository, commit);
 		} catch (IOException e) {
 			e.printStackTrace();
@@ -113,29 +116,49 @@ public class GitFileHistory extends FileHistory {
 		}
 	}
 
-	private Collection collectHistory(ObjectId lastResourceHash,
-			Repository repository, Commit top) {
+	private Collection collectHistory(ObjectId[] lastResourceHash, TreeEntry lastEntry,
+			Repository repository, Commit top) throws IOException {
 		if (top == null)
 			return Collections.EMPTY_LIST;
 		Collection ret = new ArrayList(10000);
 		Commit current = top;
 		Commit previous = top;
+
 		do {
-			TreeEntry currentEntry;
-			try {
-				currentEntry = current.getTree().findMember(
-						relativeResourceName);
-			} catch (IOException e1) {
-				e1.printStackTrace();
-				return ret;
+			TreeEntry currentEntry = lastEntry;
+			ObjectId[] currentResourceHash = new ObjectId[lastResourceHash.length];
+			Tree t = current.getTree();
+			for (int i = 0; i < currentResourceHash.length; ++i) {
+				TreeEntry m = t.findMember(relativeResourceName[i]);
+				if (m != null) {
+					ObjectId id = m.getId();
+					currentResourceHash[i] = id;
+					if (id.equals(lastResourceHash[i])) {
+						while (++i < currentResourceHash.length) {
+							currentResourceHash[i] = lastResourceHash[i];
+						}
+					} else {
+						if (m instanceof Tree) {
+							t = (Tree)m;
+						} else {
+							if (i == currentResourceHash.length - 1) {
+								currentEntry = m;
+							} else {
+								currentEntry = null;
+								while (++i < currentResourceHash.length) {
+									currentResourceHash[i] = ObjectId.zeroId();
+								}
+							}
+						}
+					}
+				} else {
+					for (; i < currentResourceHash.length; ++i) {
+						currentResourceHash[i] = ObjectId.zeroId();
+					}
+				}
 			}
-			ObjectId currentResourceHash;
-			if (currentEntry == null)
-				currentResourceHash = new ObjectId(ObjectId.toString(null));
-			else
-				currentResourceHash = currentEntry.getId();
-
-			if (!currentResourceHash.equals(lastResourceHash))
+			
+			if (!currentResourceHash[currentResourceHash.length-1].equals(lastResourceHash[currentResourceHash.length-1]))
 				ret.add(new GitFileRevision(previous, resource));
 
 			lastResourceHash = currentResourceHash;
@@ -150,7 +173,7 @@ public class GitFileHistory extends FileHistory {
 					Commit mergeParent;
 					try {
 						mergeParent = repository.mapCommit(mergeParentId);
-						ret.addAll(collectHistory(lastResourceHash, repository,
+						ret.addAll(collectHistory(lastResourceHash, currentEntry, repository, 
 								mergeParent));
 						// TODO: this gets us a lot of duplicates that we need
 						// to filter out
@@ -208,8 +231,10 @@ public class GitFileHistory extends FileHistory {
 					return;
 				}
 			}
-			TreeEntry currentEntry = current.getTree().findMember(
-					relativeResourceName);
+			TreeEntry currentEntry = current.getTree();
+			for (int i=0; i < relativeResourceName.length && currentEntry != null; ++i) {
+				((Tree)currentEntry).findMember(relativeResourceName[i]);
+			}
 			if (currentEntry != null)
 				revisions = new IFileRevision[] { new GitFileRevision(current,
 						resource) };
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index 38fefe2..9e62424 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -30,6 +30,10 @@ public class ObjectId implements Comparable {
 		ZEROID_STR = ZEROID.toString();
 	}
 
+	public static ObjectId zeroId() {
+		return ZEROID;
+	}
+	
 	public static final boolean isId(final String id) {
 		if (id.length() != (2 * Constants.OBJECT_ID_LENGTH)) {
 			return false;
@@ -80,6 +84,8 @@ public class ObjectId implements Comparable {
 	}
 
 	private static int compare(final byte[] a, final byte[] b) {
+		if (a==b)
+			return 0;
 		for (int k = 0; k < a.length && k < b.length; k++) {
 			final int ak = a[k] & 0xff;
 			final int bk = b[k] & 0xff;
