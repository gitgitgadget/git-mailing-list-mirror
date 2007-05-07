From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 08/10] Use ObjectId[] instead of List for parents
Date: Mon, 07 May 2007 23:29:58 +0200
Message-ID: <20070507212956.21546.84795.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:30:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAn4-00046J-Vj
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966825AbXEGVah (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966827AbXEGVah
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:30:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12277 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966825AbXEGVag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:30:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 027728028B2;
	Mon,  7 May 2007 23:24:29 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24821-02; Mon,  7 May 2007 23:24:29 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 19956800783;
	Mon,  7 May 2007 23:24:29 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B0D40294E7;
	Mon,  7 May 2007 23:30:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id wSBYf5gFRd1J; Mon,  7 May 2007 23:30:19 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C25ED294E8;
	Mon,  7 May 2007 23:29:58 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46490>

This is more convenient to work with and slightly
faster and memory conserving, although the first
aspect is the most important thing.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../egit/core/internal/mapping/GitFileHistory.java |   23 ++++++++------
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    7 ++--
 .../internal/actions/GitCompareRevisionAction.java |    2 +
 .../src/org/spearce/jgit/lib/Commit.java           |   38 ++++++++++++++++++-----
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |    7 ++--
 .../src/org/spearce/jgit/lib/Walker.java           |   11 +++----
 org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java |    8 ++--
 .../spearce/jgit/lib/T0005_ShallowSpeedTest.java   |   15 ++++-----
 .../org/spearce/jgit/lib/T0006_DeepSpeedTest.java  |    7 ++--
 9 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 71b29ce..4df98e6 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -65,13 +65,13 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 
 	public IFileRevision[] getContributors(IFileRevision revision) {
 		GitFileRevision grevision = (GitFileRevision) revision;
-		List parents = grevision.getCommit().getParentIds();
-		IFileRevision[] ret = new IFileRevision[parents.size()];
+		ObjectId[] parents = grevision.getCommit().getParentIds();
+		IFileRevision[] ret = new IFileRevision[parents.length];
 		Repository repository = getRepository();
-		for (int i = 0; i < parents.size(); ++i) {
+		for (int i = 0; i < parents.length; ++i) {
 			try {
 				ret[i] = new GitFileRevision(repository
-						.mapCommit((ObjectId) parents.get(i)), grevision
+						.mapCommit(parents[i]), grevision
 				.getResource(), -1);
 			} catch (IOException e) {
 				e.printStackTrace();
@@ -150,9 +150,9 @@ static class EclipseWalker extends Walker {
 			ObjectId id = repository.resolve("HEAD");
 			Commit current = repository.mapCommit(id);
 			if (repository.isStGitMode()) {
-				List parentIds = current.getParentIds();
-				if (parentIds != null && parentIds.size() > 0)
-					current = repository.mapCommit((ObjectId) parentIds.get(0));
+				ObjectId[] parentIds = current.getParentIds();
+				if (parentIds != null && parentIds.length > 0)
+					current = repository.mapCommit(parentIds[0]);
 				else {
 					revisions = new IFileRevision[0];
 					return;
@@ -264,9 +264,12 @@ static class EclipseWalker extends Walker {
 		List ret = new ArrayList(4);
 		for (int i = 0; i < revisions.length; ++i) {
 			Commit ref = ((GitFileRevision) revisions[i]).getCommit();
-			List parentIds = ref.getParentIds();
-			if (parentIds.contains(targetCommitId)) {
-				ret.add(revisions[i]);
+			ObjectId[] parentIds = ref.getParentIds();
+			for (int j = 0; j < parentIds.length; ++j) {
+				if (parentIds[j].equals(targetCommitId)) {
+					ret.add(revisions[i]);
+					break;
+				}
 			}
 		}
 		return (IFileRevision[]) ret.toArray(new IFileRevision[ret.size()]);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 4b437a6..ec200e2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -18,7 +18,6 @@ package org.spearce.egit.ui;
 
 import java.io.IOException;
 import java.util.Date;
-import java.util.List;
 import java.util.Map;
 
 import org.eclipse.compare.CompareConfiguration;
@@ -151,9 +150,9 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				RepositoryMapping repositoryMapping = provider.getData().getRepositoryMapping(project);
 				try {
 					if (selection2.length == 1 && hintShowDiffNow) {
-						List parentIds = ((GitFileRevision)selection2[0]).getCommit().getParentIds();
-						if (parentIds.size() > 0) {
-							ObjectId parentId = (ObjectId)parentIds.get(0);
+						ObjectId[] parentIds = ((GitFileRevision)selection2[0]).getCommit().getParentIds();
+						if (parentIds.length > 0) {
+							ObjectId parentId = parentIds[0];
 							Commit parent = repositoryMapping.getRepository().mapCommit(parentId);
 							IFileRevision previous = new GitFileRevision(parent,
 									((GitFileRevision)selection2[0]).getResource(),
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
index d5780a5..6177e01 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
@@ -194,7 +194,7 @@ public class GitCompareRevisionAction extends BaseSelectionListenerAction {
 			IFileRevision rev2=(IFileRevision)selection.toArray()[1];
 			System.out.println("Compare "+rev1.getContentIdentifier()+" with "+rev2.getContentIdentifier());
 			if (rev1 instanceof GitFileRevision && rev2 instanceof GitFileRevision) {
-				ObjectId pid = (ObjectId) ((GitFileRevision)rev1).getCommit().getParentIds().get(0);
+				ObjectId pid = ((GitFileRevision)rev1).getCommit().getParentIds()[0];
 				if (pid.equals(((GitFileRevision)rev2).getCommit().getCommitId())) {
 					this.setText("Show commit diff");
 				} else {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
index f5cc6ec..d2cf3af 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Commit.java
@@ -20,21 +20,21 @@ import java.io.ByteArrayInputStream;
 import java.io.DataInputStream;
 import java.io.IOException;
 import java.nio.charset.Charset;
-import java.util.ArrayList;
-import java.util.List;
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.MissingObjectException;
 
 public class Commit implements Treeish {
+	private static final ObjectId[] EMPTY_OBJECTID_LIST = new ObjectId[0];
+
 	private final Repository objdb;
 
 	private ObjectId commitId;
 
 	private ObjectId treeId;
 
-	private List parentIds;
-
+	private ObjectId[] parentIds;
+	
 	private PersonIdent author;
 
 	private PersonIdent committer;
@@ -49,22 +49,42 @@ public class Commit implements Treeish {
 
 	public Commit(final Repository db) {
 		objdb = db;
-		parentIds = new ArrayList(2);
+		parentIds = EMPTY_OBJECTID_LIST;
 	}
 
 	public Commit(final Repository db, final ObjectId id, final byte[] raw) {
 		objdb = db;
 		commitId = id;
 		treeId = ObjectId.fromString(raw, 5);
-		parentIds = new ArrayList(2);
+		parentIds = new ObjectId[1];
+		int np=0;
 		int rawPtr = 46;
 		for (;;) {
 			if (raw[rawPtr] != 'p')
 				break;
-			parentIds.add(ObjectId.fromString(raw, rawPtr + 7));
+			if (np == 0) {
+				parentIds[np++] = ObjectId.fromString(raw, rawPtr + 7);
+			} else if (np == 1) {
+				parentIds = new ObjectId[] { parentIds[0], ObjectId.fromString(raw, rawPtr + 7) };
+			} else {
+				if (parentIds.length < np) {
+					ObjectId[] old = parentIds;
+					parentIds = new ObjectId[parentIds.length+32];
+					for (int i=0; i<np; ++i)
+						parentIds[i] = old[i];
+				}
+				parentIds[np++] = ObjectId.fromString(raw, rawPtr + 7);
+			}
 			rawPtr += 48;
 		}
-
+		if (np != parentIds.length) {
+			ObjectId[] old = parentIds;
+			parentIds = new ObjectId[np];
+			for (int i=0; i<np; ++i)
+				parentIds[i] = old[i];
+		} else
+			if (np == 0)
+				parentIds = EMPTY_OBJECTID_LIST;
 		this.raw = raw;
 	}
 
@@ -121,7 +141,7 @@ public class Commit implements Treeish {
 		committer = c;
 	}
 
-	public List getParentIds() {
+	public ObjectId[] getParentIds() {
 		return parentIds;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index f9f2bde..b947a80 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -25,7 +25,6 @@ import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStreamWriter;
 import java.security.MessageDigest;
-import java.util.Iterator;
 import java.util.zip.Deflater;
 import java.util.zip.DeflaterOutputStream;
 
@@ -121,11 +120,11 @@ public class ObjectWriter {
 		c.getTreeId().copyTo(os);
 		os.write('\n');
 
-		final Iterator i = c.getParentIds().iterator();
-		while (i.hasNext()) {
+		ObjectId[] ps = c.getParentIds();
+		for (int i=0; i<ps.length; ++i) {
 			os.write(hparent);
 			os.write(' ');
-			((ObjectId) i.next()).copyTo(os);
+			ps[i].copyTo(os);
 			os.write('\n');
 		}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
index 2928e1d..86c8a1e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
@@ -8,7 +8,6 @@ import java.util.ArrayList;
 import java.util.Arrays;
 import java.util.Collection;
 import java.util.Collections;
-import java.util.List;
 
 public abstract class Walker {
 	private String[] relativeResourceName;
@@ -98,10 +97,10 @@ public abstract class Walker {
 
 			// TODO: we may need to list more revisions when traversing
 			// branches
-			List parents = current.getParentIds();
+			ObjectId[] parents = current.getParentIds();
 			if (!followMainOnly) {
-				for (int i = 1; i < parents.size(); ++i) {
-					ObjectId mergeParentId = (ObjectId) parents.get(i);
+				for (int i = 1; i < parents.length; ++i) {
+					ObjectId mergeParentId = parents[i];
 					Commit mergeParent;
 					try {
 						mergeParent = repository.mapCommit(mergeParentId);
@@ -115,8 +114,8 @@ public abstract class Walker {
 					}
 				}
 			}
-			if (parents.size() > 0) {
-				ObjectId parentId = (ObjectId) parents.get(0);
+			if (parents.length > 0) {
+				ObjectId parentId = parents[0];
 				try {
 					current = repository.mapCommit(parentId);
 				} catch (IOException e) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java
index 8ba9182..73bf556 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java
@@ -2,9 +2,8 @@ package org.spearce.jgit.pgm;
 
 import java.io.File;
 import java.io.IOException;
-import java.util.Iterator;
-
 import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 
 public class Log {
@@ -13,8 +12,9 @@ public class Log {
 		Commit commit = db.mapCommit(args[0]);
 		System.out.println("commit " + commit.getCommitId());
 		System.out.println("tree " + commit.getTreeId());
-		for (Iterator ci = commit.getParentIds().iterator(); ci.hasNext();) {
-			System.out.println("parent " + ci.next());
+		ObjectId[] ps=commit.getParentIds();
+		for (int ci=0; ci<ps.length; ++ci) {
+			System.out.println("parent " + ps[ci]);
 		}
 		System.out.println("author " + commit.getAuthor());
 		System.out.println();
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java
index 36e74ae..b598a13 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0005_ShallowSpeedTest.java
@@ -18,7 +18,6 @@ package org.spearce.jgit.lib;
 
 import java.io.File;
 import java.io.IOException;
-import java.util.List;
 
 import junit.textui.TestRunner;
 
@@ -35,9 +34,9 @@ public class T0005_ShallowSpeedTest extends SpeedTestBase {
 		int n = 1;
 		do {
 			// System.out.println("commit="+commit.getCommitId());
-			List parent = commit.getParentIds();
-			if (parent.size() > 0) {
-				ObjectId parentId = (ObjectId) parent.get(0);
+			ObjectId[] parents = commit.getParentIds();
+			if (parents.length > 0) {
+				ObjectId parentId = parents[0];
 				commit = db.mapCommit(parentId);
 				commit.getCommitId().toString();
 				++n;
@@ -52,13 +51,13 @@ public class T0005_ShallowSpeedTest extends SpeedTestBase {
 		System.out.println("jgit="+time);
 		// ~0.750s (hot cache), ok
 		/*
-native=1748
-jgit=774
+native=1795
+jgit=722
 		 */
 		// native git seems to run SLOWER than jgit here, at roughly half the speed
 		// creating the git process is not the issue here, btw.
-		long factor10 = (nativeTime*110/time+50)/100;
-		assertEquals(2, factor10);
+		long factor10 = (nativeTime*150/time+50)/100;
+		assertEquals(3, factor10);
 	}
 
 	public static void main(String[] args) {
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
index b4ae4b8..244792c 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0006_DeepSpeedTest.java
@@ -18,7 +18,6 @@ package org.spearce.jgit.lib;
 
 import java.io.File;
 import java.io.IOException;
-import java.util.List;
 
 import junit.textui.TestRunner;
 
@@ -35,9 +34,9 @@ public class T0006_DeepSpeedTest extends SpeedTestBase {
 		int n = 1;
 		do {
 			// System.out.println("commit="+commit.getCommitId());
-			List parent = commit.getParentIds();
-			if (parent.size() > 0) {
-				ObjectId parentId = (ObjectId) parent.get(0);
+			ObjectId[] parents = commit.getParentIds();
+			if (parents.length > 0) {
+				ObjectId parentId = parents[0];
 				commit = db.mapCommit(parentId);
 				TreeEntry m = commit.getTree().findBlobMember("net/netfilter/nf_queue.c");
 				if (m != null)
