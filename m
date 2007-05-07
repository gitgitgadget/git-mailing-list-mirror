From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 06/10] Create a generic history walker
Date: Mon, 07 May 2007 23:29:45 +0200
Message-ID: <20070507212944.21546.60718.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:30:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAmr-00043f-1b
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966608AbXEGVaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966816AbXEGVaW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:30:22 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12266 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966608AbXEGVaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:30:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F3C028028B2;
	Mon,  7 May 2007 23:24:13 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24821-01; Mon,  7 May 2007 23:24:12 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 4D5C2800783;
	Mon,  7 May 2007 23:24:12 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id DF577294E9;
	Mon,  7 May 2007 23:30:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id fawABRORWmTG; Mon,  7 May 2007 23:30:02 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 9C385294EA;
	Mon,  7 May 2007 23:29:45 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46488>

This was needed to created a performance test program. This
is a very stupid walker so far since it only follows the
first parent. The main reason is that the viewer is not
capable of more. The only reason it is usable to me is that
most projects I work on have few branches and even fewer
merges (that can be detected by CVS converters).

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../egit/core/internal/mapping/GitFileHistory.java |  149 ++++++-----------------
 .../src/org/spearce/jgit/lib/Walker.java           |  134 +++++++++++++++++++++
 .../tst/org/spearce/jgit/lib/T0007_WalkerTest.java |   63 ++++++++++
 3 files changed, 233 insertions(+), 113 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 0569862..71b29ce 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -20,9 +20,7 @@ import java.io.BufferedInputStream;
 import java.io.IOException;
 import java.io.InputStream;
 import java.util.ArrayList;
-import java.util.Arrays;
 import java.util.Collection;
-import java.util.Collections;
 import java.util.Date;
 import java.util.List;
 
@@ -42,6 +40,7 @@ import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
+import org.spearce.jgit.lib.Walker;
 
 public class GitFileHistory extends FileHistory implements IAdaptable {
 
@@ -110,124 +109,30 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 		return getData().getRepositoryMapping(resource.getProject());
 	}
 
-	private Collection collectHistory() {
-		Repository repository = getRepository();
-		try {
-			ObjectId id = repository.resolve("HEAD");
-			Commit commit = repository.mapCommit(id);
-			ObjectId[] initialResourceHash = new ObjectId[relativeResourceName.length];
-			Arrays.fill(initialResourceHash, ObjectId.zeroId());
-			TreeEntry[] activeDiffTreeEntries = null;
-			try {
-				activeDiffTreeEntries = getData().getActiveDiffTreeEntries(resource);
-			} catch (CoreException e1) {
-				// TODO: eclipse excetion logging
-				e1.printStackTrace();
-			}
-			if (activeDiffTreeEntries!=null)
-				initialResourceHash[initialResourceHash.length-1] = activeDiffTreeEntries[0].getId();
-			return collectHistory(0, initialResourceHash, null,
-					repository, commit);
-		} catch (IOException e) {
-			e.printStackTrace();
-			return Collections.EMPTY_LIST;
-		}
+static class EclipseWalker extends Walker {
+	IResource resource;
+	
+	EclipseWalker(Repository repository, Commit start, String[] relativeResourceName,boolean leafIsBlob,IResource resource,boolean followMainOnly, ObjectId lastActiveDiffId) {
+		super(repository, start, relativeResourceName, leafIsBlob, followMainOnly, lastActiveDiffId);
+		this.resource = resource;
 	}
 
-	private Collection collectHistory(int count, ObjectId[] lastResourceHash, TreeEntry lastEntry,
-			Repository repository, Commit top) throws IOException {
-		if (top == null)
-			return Collections.EMPTY_LIST;
-		Collection ret = new ArrayList(10000);
-		Commit current = top;
-		Commit previous = top;
-
-		do {
-			TreeEntry currentEntry = lastEntry;
-			ObjectId[] currentResourceHash = new ObjectId[lastResourceHash.length];
-			Tree t = current.getTree();
-			for (int i = 0; i < currentResourceHash.length; ++i) {
-				TreeEntry m;
-				if (i == relativeResourceName.length-1 && resource.getType() == IResource.FILE)
-					m = t.findBlobMember(relativeResourceName[i]);
-				else
-					m = t.findTreeMember(relativeResourceName[i]);
-				if (m != null) {
-					ObjectId id = m.getId();
-					currentResourceHash[i] = id;
-					if (id.equals(lastResourceHash[i])) {
-						while (++i < currentResourceHash.length) {
-							currentResourceHash[i] = lastResourceHash[i];
-						}
-					} else {
-						if (m instanceof Tree) {
-							t = (Tree)m;
-						} else {
-							if (i == currentResourceHash.length - 1) {
-								currentEntry = m;
-							} else {
-								currentEntry = null;
-								while (++i < currentResourceHash.length) {
-									currentResourceHash[i] = ObjectId.zeroId();
-								}
-							}
-						}
-					}
-				} else {
-					for (; i < currentResourceHash.length; ++i) {
-						currentResourceHash[i] = ObjectId.zeroId();
-					}
-				}
-			}
-			
-			if (currentResourceHash.length == 0 || !currentResourceHash[currentResourceHash.length-1].equals(lastResourceHash[currentResourceHash.length-1]))
-				ret.add(new GitFileRevision(previous, resource, count));
-
-			lastResourceHash = currentResourceHash;
-			previous = current;
-
-			// TODO: we may need to list more revisions when traversing
-			// branches
-			List parents = current.getParentIds();
-			if ((flags & IFileHistoryProvider.SINGLE_LINE_OF_DESCENT) == 0) {
-				for (int i = 1; i < parents.size(); ++i) {
-					ObjectId mergeParentId = (ObjectId) parents.get(i);
-					Commit mergeParent;
-					try {
-						mergeParent = repository.mapCommit(mergeParentId);
-						ret.addAll(collectHistory(0, lastResourceHash, currentEntry, repository, 
-								mergeParent));
-						// TODO: this gets us a lot of duplicates that we need
-						// to filter out
-						// Leave that til we get a GUI.
-					} catch (IOException e) {
-						e.printStackTrace();
-					}
-				}
-			}
-			if (parents.size() > 0) {
-				ObjectId parentId = (ObjectId) parents.get(0);
-				try {
-					current = repository.mapCommit(parentId);
-				} catch (IOException e) {
-					e.printStackTrace();
-					current = null;
-				}
-			} else
-				current = null;
-			if (count>=0)
-				count++;
-		} while (current != null);
-
-		return ret;
+	protected void collect(Collection ret,Commit commit, int count) {
+		ret.add(new GitFileRevision(commit, resource, count));		
 	}
+	
+};
 
 	public IFileRevision[] getFileRevisions() {
 		if (revisions == null)
 			if ((flags & IFileHistoryProvider.SINGLE_LINE_OF_DESCENT) == 0)
 				findSingleRevision();
 			else
-				findRevisions();
+				try {
+					findRevisions();
+				} catch (IOException e) {
+					throw new Error(e);
+				}
 		return revisions;
 	}
 
@@ -272,7 +177,7 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 		}
 	}
 
-	private void findRevisions() {
+	private void findRevisions() throws IOException {
 		RepositoryProvider provider = RepositoryProvider.getProvider(resource
 				.getProject());
 		if (provider instanceof GitProvider) {
@@ -281,7 +186,25 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 			long time0 = new Date().getTime();
 			System.out.println("getting file history");
 			List ret = new ArrayList();
-			Collection githistory = collectHistory();
+			TreeEntry[] activeDiffTreeEntries = null;
+			try {
+				activeDiffTreeEntries = getData().getActiveDiffTreeEntries(resource);
+			} catch (CoreException e1) {
+				// TODO: eclipse excetion logging
+				e1.printStackTrace();
+			}
+			ObjectId activeDiffLeafId = null;
+			if (activeDiffTreeEntries!=null)
+				activeDiffLeafId = activeDiffTreeEntries[0].getId();
+
+			ObjectId head = getRepository().resolve("HEAD");
+			Commit start = getRepository().mapCommit(head);
+			EclipseWalker walker = new EclipseWalker(getRepository(), start, relativeResourceName, 
+					resource.getType() == IResource.FILE, 
+					resource, 
+					(flags & IFileHistoryProvider.SINGLE_LINE_OF_DESCENT) == 0,
+					activeDiffLeafId);
+			Collection githistory = walker.collectHistory();
 			if (githistory.size() >0) {
 				if (resource.getType()==IResource.FILE) {
 					// TODO: consider index in future versions
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
new file mode 100644
index 0000000..2928e1d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
@@ -0,0 +1,134 @@
+/**
+ * 
+ */
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.Arrays;
+import java.util.Collection;
+import java.util.Collections;
+import java.util.List;
+
+public abstract class Walker {
+	private String[] relativeResourceName;
+	private boolean leafIsBlob;
+	private boolean followMainOnly;
+	private Repository repository;
+	private ObjectId activeDiffLeafId;
+	private final Commit start;
+
+	protected abstract void collect(Collection ret,Commit commit, int count);
+
+	protected Walker(Repository repostory, Commit start, String[] relativeResourceName,boolean leafIsBlob,boolean followMainOnly, ObjectId activeDiffLeafId) {
+		this.repository = repostory;
+		this.start = start;
+		this.relativeResourceName = relativeResourceName;
+		this.leafIsBlob = leafIsBlob;
+		this.followMainOnly = followMainOnly;
+		this.activeDiffLeafId = activeDiffLeafId;
+	}
+	
+	public Collection collectHistory() {
+		try {
+			Commit commit = start;
+			ObjectId[] initialResourceHash = new ObjectId[relativeResourceName.length];
+			Arrays.fill(initialResourceHash, ObjectId.zeroId());
+			if (activeDiffLeafId != null)
+				initialResourceHash[initialResourceHash.length-1] = activeDiffLeafId;
+			return collectHistory(0, initialResourceHash, null,
+					repository, commit);
+		} catch (IOException e) {
+			e.printStackTrace();
+			return Collections.EMPTY_LIST;
+		}
+	}
+
+	Collection collectHistory(int count, ObjectId[] lastResourceHash, TreeEntry lastEntry,
+			Repository repository, Commit top) throws IOException {
+		if (top == null)
+			return Collections.EMPTY_LIST;
+		Collection ret = new ArrayList(10000);
+		Commit current = top;
+		Commit previous = top;
+
+		do {
+			TreeEntry currentEntry = lastEntry;
+			ObjectId[] currentResourceHash = new ObjectId[lastResourceHash.length];
+			Tree t = current.getTree();
+			for (int i = 0; i < currentResourceHash.length; ++i) {
+				TreeEntry m;
+				if (i == relativeResourceName.length-1 && leafIsBlob)
+					m = t.findBlobMember(relativeResourceName[i]);
+				else
+					m = t.findTreeMember(relativeResourceName[i]);
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
+			}
+			
+			if (currentResourceHash.length == 0 || !currentResourceHash[currentResourceHash.length-1].equals(lastResourceHash[currentResourceHash.length-1])) {
+				collect(ret, previous, count);
+			}
+			lastResourceHash = currentResourceHash;
+			previous = current;
+
+			// TODO: we may need to list more revisions when traversing
+			// branches
+			List parents = current.getParentIds();
+			if (!followMainOnly) {
+				for (int i = 1; i < parents.size(); ++i) {
+					ObjectId mergeParentId = (ObjectId) parents.get(i);
+					Commit mergeParent;
+					try {
+						mergeParent = repository.mapCommit(mergeParentId);
+						ret.addAll(collectHistory(0, lastResourceHash, currentEntry, repository, 
+								mergeParent));
+						// TODO: this gets us a lot of duplicates that we need
+						// to filter out
+						// Leave that til we get a GUI.
+					} catch (IOException e) {
+						e.printStackTrace();
+					}
+				}
+			}
+			if (parents.size() > 0) {
+				ObjectId parentId = (ObjectId) parents.get(0);
+				try {
+					current = repository.mapCommit(parentId);
+				} catch (IOException e) {
+					e.printStackTrace();
+					current = null;
+				}
+			} else
+				current = null;
+			if (count>=0)
+				count++;
+		} while (current != null);
+
+		return ret;
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0007_WalkerTest.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0007_WalkerTest.java
new file mode 100644
index 0000000..82f0623
--- /dev/null
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0007_WalkerTest.java
@@ -0,0 +1,63 @@
+/*
+ *  Copyright (C) 2006  Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+import java.util.Collection;
+
+import junit.textui.TestRunner;
+
+/**
+ * A performance test like T0006_DeepSpeedTest, but more
+ * realistic since it is smarter.
+ */
+public class T0007_WalkerTest extends SpeedTestBase {
+
+	protected void setUp() throws Exception {
+		prepare(new String[] { "git", "log", "365bbe0d0caaf2ba74d56556827babf0bc66965d","--","net/netfilter/nf_queue.c" });
+	}
+
+	public void testHistoryScan() throws IOException {
+//		long start = System.currentTimeMillis();
+		Repository db = new Repository(new File(kernelrepo));
+		String[] path = { "net", "netfilter", "nf_queue.c" };
+		Walker walker = new Walker(db,db.mapCommit(new ObjectId("365bbe0d0caaf2ba74d56556827babf0bc66965d")),path,true,true,null) {
+
+			protected void collect(Collection ret, Commit commit, int count) {
+				System.out.println("Got: "+count+" "+commit.getCommitId());
+				ret.add(commit);
+			}
+		
+		};
+		Commit[] history = (Commit[])walker.collectHistory().toArray(new Commit[0]);
+		assertEquals(8, history.length);
+		assertEquals("365bbe0d0caaf2ba74d56556827babf0bc66965d",history[0].getCommitId().toString());
+		assertEquals("a4c12d6c5dde48c69464baf7c703e425ee511433",history[1].getCommitId().toString());
+		assertEquals("761a126017e3f001d3f5a574787aa232a9cd5bb5",history[2].getCommitId().toString());
+		assertEquals("22a3e233ca08a2ddc949ba1ae8f6e16ec7ef1a13",history[3].getCommitId().toString());
+		assertEquals("460fbf82c0842cad3f3c744c4dcb81978b7829f3",history[4].getCommitId().toString());
+		assertEquals("272a5322d5219b00a1e541ad9d0d76824df1aa2a",history[5].getCommitId().toString());
+		assertEquals("8e33ba49765484bc6de3a2f8143733713fa93bc1",history[6].getCommitId().toString());
+		assertEquals("826509f8110049663799bc20f2b5b6170e2f78ca",history[7].getCommitId().toString());
+		
+	}
+
+	public static void main(String[] args) {
+		TestRunner.run(T0007_WalkerTest.class);
+	}
+}
