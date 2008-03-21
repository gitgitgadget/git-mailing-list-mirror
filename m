From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 2/4] Infrastructure to retrieve commit related information.
Date: Fri, 21 Mar 2008 18:07:46 -0400
Message-ID: <1206137266-4055-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 22:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcoV6-0007iP-8O
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 22:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762290AbYCUVIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 17:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762056AbYCUVIr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 17:08:47 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1507 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758946AbYCUVIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 17:08:46 -0400
Received: (qmail 91907 invoked by uid 0); 21 Mar 2008 18:11:24 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.62936 secs); 21 Mar 2008 21:11:24 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.226.196)
  by cvxbsd.convex.com.br with SMTP; 21 Mar 2008 21:11:22 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77770>

Infrastructure to retrieve all the branches that contain a commit,
the children of a commit, tags and branches referencing a commit.

It was added in the core package so it is easier to reuse it.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 org.spearce.egit.core/META-INF/MANIFEST.MF         |    6 +-
 .../org/spearce/egit/core/util/CommitMetaInfo.java |   59 ++++++
 .../org/spearce/egit/core/util/RepositoryUtil.java |  217 ++++++++++++++++++++
 3 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/util/CommitMetaInfo.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/util/RepositoryUtil.java

diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index 48ddb91..6dfc2f7 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -11,10 +11,10 @@ Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.core.resources,
  org.spearce.jgit,
  org.eclipse.core.filesystem
-Export-Package: org.spearce.egit.core.internal.mapping;x-friends:="org.spearce.egit.ui",
- org.spearce.egit.core,
+Export-Package: org.spearce.egit.core,
  org.spearce.egit.core.internal.mapping,
  org.spearce.egit.core.op,
- org.spearce.egit.core.project
+ org.spearce.egit.core.project,
+ org.spearce.egit.core.util
 Eclipse-LazyStart: true
 Bundle-RequiredExecutionEnvironment: J2SE-1.5
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/util/CommitMetaInfo.java b/org.spearce.egit.core/src/org/spearce/egit/core/util/CommitMetaInfo.java
new file mode 100644
index 0000000..48de3fb
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/util/CommitMetaInfo.java
@@ -0,0 +1,59 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares
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
+package org.spearce.egit.core.util;
+
+import java.util.Set;
+
+import org.spearce.jgit.lib.Commit;
+
+/**
+ * This class stores information that are not part of a commit and requires a
+ * walk through out the repository to be discovered.
+ */
+public class CommitMetaInfo {
+
+	private Set<String> branchNamesContainingCommit;
+
+	private Set<Commit> childrenCommits;
+
+	CommitMetaInfo(Set<String> branchNamesContainingCommit,
+			Set<Commit> childrenCommits) {
+		this.branchNamesContainingCommit = branchNamesContainingCommit;
+		this.childrenCommits = childrenCommits;
+	}
+
+	/**
+	 * Returns all the branches that contain the commit.
+	 * 
+	 * @return Set<String> a <code>Set</code> containing the branch names,
+	 *         sorted in ascending string order or null
+	 */
+	public Set<String> getBranchNamesContainingCommit() {
+		return branchNamesContainingCommit;
+	}
+
+	/**
+	 * Returns the children commits.
+	 * 
+	 * @return Set<Commit> a <code>Set</code> containing the children commits
+	 *         or null.
+	 */
+	public Set<Commit> getChildrenCommits() {
+		return childrenCommits;
+	}
+
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/util/RepositoryUtil.java b/org.spearce.egit.core/src/org/spearce/egit/core/util/RepositoryUtil.java
new file mode 100644
index 0000000..9a08868
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/util/RepositoryUtil.java
@@ -0,0 +1,217 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares
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
+package org.spearce.egit.core.util;
+
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.HashMap;
+import java.util.HashSet;
+import java.util.List;
+import java.util.Map;
+import java.util.Set;
+import java.util.TreeSet;
+import java.util.concurrent.CancellationException;
+
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Tag;
+
+/**
+ * This class provides convenience methods to retrieve Git repository data in a
+ * digested form.
+ */
+public class RepositoryUtil {
+
+	private Repository repository;
+
+	private Map<ObjectId, Set<String>> sha1ToTagsMap = new HashMap<ObjectId, Set<String>>();
+
+	private Map<ObjectId, Set<String>> headCommitToBranchesMap = new HashMap<ObjectId, Set<String>>();
+
+	/**
+	 * Constructs a <code>RepositoryUtil</code> for the
+	 * <code>repository</code>.
+	 * 
+	 * @param repository
+	 *            the Git repository from where data will be retrieved.
+	 * @throws IOException
+	 */
+	public RepositoryUtil(Repository repository) throws IOException {
+		this.repository = repository;
+
+		refresh();
+	}
+
+	/**
+	 * Retrieves a <code>Set</code> with all the tags referencing
+	 * <code>commit<code>.
+	 * 
+	 * @param commit to be checked for references
+	 * @return Set<String> the tag names referencing the commit sorted in ascending string order or null
+	 */
+	public Set<String> getTagNamesForCommit(Commit commit) {
+		return sha1ToTagsMap.get(commit.getCommitId());
+	}
+
+	/**
+	 * Retrieves a <code>Set</code> with all the branch names referencing
+	 * <code>commit<code>.
+	 * 
+	 * @param commit
+	 * @return Set<String> the branch names referencing the commit sorted in ascending string order or null
+	 */
+	public Set<String> getBranchNamesForCommit(Commit commit) {
+		return headCommitToBranchesMap.get(commit.getCommitId());
+	}
+
+	/**
+	 * Walks through all branches in the repository searching information
+	 * related to <code>commit</code>. This information is stored in the
+	 * <code>CommitMetaInfo</code>.
+	 * 
+	 * @param commit
+	 *            to be checked for references
+	 * @param monitor
+	 *            the monitor from where cancellation is checked or null
+	 * @return CommitMetaInfo
+	 * @throws IOException
+	 * @throws CancellationException
+	 *             if <code>monitor.isCanceled()</code> returns true during
+	 *             the execution of this method
+	 */
+	public CommitMetaInfo getCommitMetaInfo(Commit commit,
+			IProgressMonitor monitor) throws IOException, CancellationException {
+		Set<Commit> childrenSet = new HashSet<Commit>();
+		Map<String, String> allBranches = new HashMap<String, String>();
+		ObjectId commitId = commit.getCommitId();
+		Set<String> branchNameSet = headCommitToBranchesMap.get(commitId);
+		if (branchNameSet != null) {
+			for (String branchName : branchNameSet) {
+				allBranches.put(branchName, branchName);
+			}
+		}
+
+		// Verifies all branches for the commit we want
+		List<ObjectId> commitsToWalk = new ArrayList<ObjectId>();
+		commitsToWalk.addAll(headCommitToBranchesMap.keySet());
+		Map<String, String> tempBranches = new HashMap<String, String>();
+		Map<ObjectId, Map<String, String>> savedTempBranches = new HashMap<ObjectId, Map<String, String>>();
+		while (commitsToWalk.size() > 0) {
+			ObjectId branchHead = commitsToWalk.remove(0);
+			Commit headCommit = repository.mapCommit(branchHead);
+			Map<String, String> tb = savedTempBranches.get(branchHead);
+			if (tb == null) {
+				tempBranches.clear();
+				tb = tempBranches;
+			}
+			lookforMetaInfo(commitId, headCommit, allBranches, childrenSet, tb,
+					commitsToWalk, savedTempBranches, monitor);
+		}
+
+		Set<String> keySet = null;
+		if (allBranches.size() > 0) {
+			keySet = new TreeSet<String>();
+			keySet.addAll(allBranches.keySet());
+		}
+		if (childrenSet.size() == 0) {
+			childrenSet = null;
+		}
+
+		CommitMetaInfo metaInfo = new CommitMetaInfo(keySet, childrenSet);
+		return metaInfo;
+	}
+
+	private void lookforMetaInfo(ObjectId targetCommitId, Commit headCommit,
+			Map<String, String> allBranches, Set<Commit> childrenSet,
+			Map<String, String> tempBranches, List<ObjectId> commitsToWalk,
+			Map<ObjectId, Map<String, String>> savedTempBranches,
+			IProgressMonitor monitor) throws IOException, CancellationException {
+		Commit child = null;
+		Commit commit = headCommit;
+		ObjectId commitId = commit.getCommitId();
+		while (!commitId.equals(targetCommitId)) {
+			child = commit;
+			Set<String> branchNameSet = headCommitToBranchesMap.get(commit
+					.getCommitId());
+			if (branchNameSet != null) {
+				for (String branchName : branchNameSet) {
+					tempBranches.put(branchName, branchName);
+				}
+			}
+			ObjectId[] pIds = commit.getParentIds();
+			if (pIds != null && pIds.length > 0) {
+				commit = repository.mapCommit(pIds[0]);
+				commitId = commit.getCommitId();
+				int parentCount = pIds.length;
+				if (parentCount > 1) {
+					for (int i = 1; i < parentCount; i++) {
+						commitsToWalk.add(pIds[i]);
+						Map<String, String> tb = savedTempBranches.get(pIds[i]);
+						if (tb == null) {
+							tb = new HashMap<String, String>();
+							savedTempBranches.put(pIds[i], tb);
+						}
+						tb.putAll(tempBranches);
+						if (pIds[i].equals(targetCommitId)) {
+							childrenSet.add(child);
+						}
+					}
+				}
+			} else {
+				break;
+			}
+			if (monitor != null && monitor.isCanceled()) {
+				throw new CancellationException("getCommitMetaInfo cancelled");
+			}
+		}
+		if (commitId.equals(targetCommitId)) {
+			allBranches.putAll(tempBranches);
+			if (child != null) {
+				childrenSet.add(child);
+			}
+		}
+	}
+
+	private void refresh() throws IOException {
+		// Refresh tags
+		sha1ToTagsMap.clear();
+		for (String tagName : repository.getTags()) {
+			Tag tag = repository.mapTag(tagName);
+			Set<String> tagSet = sha1ToTagsMap.get(tag.getObjId());
+			if (tagSet == null) {
+				tagSet = new TreeSet<String>();
+				sha1ToTagsMap.put(tag.getObjId(), tagSet);
+			}
+			tagSet.add(tag.getTag());
+		}
+
+		// Refresh branches
+		headCommitToBranchesMap.clear();
+		for (String branchName : repository.getBranches()) {
+			ObjectId commitId = repository.resolve(branchName);
+			Set<String> branchSet = headCommitToBranchesMap.get(commitId);
+			if (branchSet == null) {
+				branchSet = new TreeSet<String>();
+				headCommitToBranchesMap.put(commitId, branchSet);
+			}
+			branchSet.add(branchName);
+		}
+	}
+
+}
-- 
1.5.4.1
