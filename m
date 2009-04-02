From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/5] Cache resolved ids in quickdiff document for faster update
Date: Thu,  2 Apr 2009 20:46:31 +0200
Message-ID: <1238697991-12990-6-git-send-email-robin.rosenberg@dewire.com>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-2-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-4-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 02 20:53:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRyS-0007QY-8q
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760111AbZDBSrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757118AbZDBSrQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:47:16 -0400
Received: from mail.dewire.com ([83.140.172.130]:5508 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754295AbZDBSrO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 14:47:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2F25D1484141;
	Thu,  2 Apr 2009 20:47:12 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a3CQByclvkXd; Thu,  2 Apr 2009 20:47:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 809D01488985;
	Thu,  2 Apr 2009 20:46:45 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.1.345.g89fb
In-Reply-To: <1238697991-12990-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115485>

We do this by caching the commit, tree and blob ids and can then
very quickly decide whether a change in baseline actually results in a
changed version of the reference blob used for quickdiff.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/decorators/GitDocument.java   |   70 +++++++++++++++++---
 1 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index 347e6fc..59a738c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -20,8 +20,11 @@
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.Activator;
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.IndexChangedEvent;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
@@ -31,6 +34,11 @@
 
 class GitDocument extends Document implements RepositoryListener {
 	private final IResource resource;
+
+	private AnyObjectId lastCommit;
+	private AnyObjectId lastTree;
+	private AnyObjectId lastBlob;
+
 	static Map<GitDocument,Repository> doc2repo = new WeakHashMap<GitDocument, Repository>();
 
 	static GitDocument create(final IResource resource) throws IOException {
@@ -51,29 +59,68 @@ private GitDocument(IResource resource) {
 		GitDocument.doc2repo.put(this, getRepository());
 	}
 
+	private void setResolved(final AnyObjectId commit, final AnyObjectId tree, final AnyObjectId blob, final String value) {
+		lastCommit = commit != null ? commit.copy() : null;
+		lastTree = tree != null ? tree.copy() : null;
+		lastBlob = blob != null ? blob.copy() : null;
+		set(value);
+		if (blob != null)
+			Activator.trace("(GitDocument) resolved " + resource + " to " + lastBlob + " in " + lastCommit + "/" + lastTree);
+		else
+			Activator.trace("(GitDocument) unresolved " + resource);
+	}
+
 	void populate() throws IOException {
 		Activator.trace("(GitDocument) populate: " + resource);
-		set("");
 		final IProject project = resource.getProject();
 		RepositoryMapping mapping = RepositoryMapping.getMapping(project);
-		if (mapping == null)
+		if (mapping == null) {
+			setResolved(null, null, null, "");
 			return;
+		}
 		final String gitPath = mapping.getRepoRelativePath(resource);
-		final Repository repository = getRepository();
+		final Repository repository = mapping.getRepository();
 		String baseline = GitQuickDiffProvider.baseline.get(repository);
 		if (baseline == null)
 			baseline = Constants.HEAD;
-		Tree baselineTree = repository.mapTree(baseline);
-		if (baselineTree == null) {
+		ObjectId commitId = repository.resolve(baseline);
+		if (commitId != null) {
+			if (commitId.equals(lastCommit)) {
+				Activator.trace("(GitDocument) already resolved"); 
+				return;
+			}
+		} else {
 			Activator.logError("Could not resolve quickdiff baseline "
 					+ baseline + " corresponding to " + resource + " in "
 					+ repository, new Throwable());
+			setResolved(null, null, null, "");
+			return;
+		}
+		Commit baselineCommit = repository.mapCommit(commitId);
+		if (baselineCommit == null) {
+			Activator.logError("Could not load commit " + commitId + " for "
+					+ baseline + " corresponding to " + resource + " in "
+					+ repository, new Throwable());
+			setResolved(null, null, null, "");
+			return;
+		}
+		ObjectId treeId = baselineCommit.getTreeId();
+		if (treeId.equals(lastTree)) {
+			Activator.trace("(GitDocument) already resolved"); 
+			return;
+		}
+		Tree baselineTree = baselineCommit.getTree();
+		if (baselineTree == null) {
+			Activator.logError("Could not load tree " + treeId + " for "
+					+ baseline + " corresponding to " + resource + " in "
+					+ repository, new Throwable());
+			setResolved(null, null, null, "");
 			return;
 		}
-		TreeEntry blobEnry = baselineTree.findBlobMember(gitPath);
-		if (blobEnry != null) {
+		TreeEntry blobEntry = baselineTree.findBlobMember(gitPath);
+		if (blobEntry != null && !blobEntry.getId().equals(lastBlob)) {
 			Activator.trace("(GitDocument) compareTo: " + baseline);
-			ObjectLoader loader = repository.openBlob(blobEnry.getId());
+			ObjectLoader loader = repository.openBlob(blobEntry.getId());
 			byte[] bytes = loader.getBytes();
 			String charset;
 			// Get the encoding for the current version. As a matter of
@@ -92,10 +139,13 @@ void populate() throws IOException {
 			// Finally we could consider validating the content with respect
 			// to the content. We don't do that here.
 			String s = new String(bytes, charset);
-			set(s);
+			setResolved(commitId, baselineTree.getId(), blobEntry.getId(), s);
 			Activator.trace("(GitDocument) has reference doc, size=" + s.length() + " bytes");
 		} else {
-			Activator.trace("(GitDocument) no revision.");
+			if (blobEntry == null)
+				setResolved(null, null, null, "");
+			else
+				Activator.trace("(GitDocument) already resolved"); 
 		}
 	}
 
-- 
1.6.2.1.345.g89fb
