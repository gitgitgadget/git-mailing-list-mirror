From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/2] Enable commit for any resource in a Git-shared project
Date: Sun, 31 Aug 2008 11:38:44 +0200
Message-ID: <1220175524-1523-3-git-send-email-robin.rosenberg@dewire.com>
References: <1220175524-1523-1-git-send-email-robin.rosenberg@dewire.com>
 <1220175524-1523-2-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 11:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZjS0-0007CT-RH
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 11:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349AbYHaJlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 05:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756529AbYHaJlO
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 05:41:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7408 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756349AbYHaJlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 05:41:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 20D31800699;
	Sun, 31 Aug 2008 11:41:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAsAPwEPrwUQ; Sun, 31 Aug 2008 11:41:06 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2C32B802670;
	Sun, 31 Aug 2008 11:41:06 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e9
In-Reply-To: <1220175524-1523-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94471>

By default the commit dialog will be populated with all changed resources
in the projects that contain the selected resources, provided the projects
are associated with a Git respository.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/actions/CommitAction.java     |   33 +++++++++----------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index 8db701c..d703048 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -68,7 +68,7 @@ public void run(IAction act) {
 			return;
 		}
 
-		Repository[] repos = getRepositories();
+		Repository[] repos = getRepositoriesFor(getProjectsForSelectedResources());
 		amendAllowed = repos.length == 1;
 		for (Repository repo : repos) {
 			if (!repo.getRepositoryState().canCommit()) {
@@ -124,7 +124,7 @@ private void resetState() {
 	}
 
 	private void loadPreviousCommit() {
-		IProject project = getSelectedProjects()[0];
+		IProject project = getProjectsForSelectedResources()[0];
 
 		Repository repo = RepositoryMapping.getMapping(project).getRepository();
 		try {
@@ -313,21 +313,20 @@ private void writeTreeWithSubTrees(Tree tree) throws TeamException {
 	}
 
 	private void buildIndexHeadDiffList() throws IOException {
-		for (IProject project : getSelectedProjects()) {
+		for (IProject project : getProjectsInRepositoryOfSelectedResources()) {
 			RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(project);
-			if (repositoryMapping != null) {
-				Repository repository = repositoryMapping.getRepository();
-				Tree head = repository.mapTree("HEAD");
-				GitIndex index = repository.getIndex();
-				IndexDiff indexDiff = new IndexDiff(head, index);
-				indexDiff.diff();
-
-				includeList(project, indexDiff.getAdded(), indexChanges);
-				includeList(project, indexDiff.getChanged(), indexChanges);
-				includeList(project, indexDiff.getRemoved(), indexChanges);
-				includeList(project, indexDiff.getMissing(), notIndexed);
-				includeList(project, indexDiff.getModified(), notIndexed);
-			}
+			assert repositoryMapping != null;
+			Repository repository = repositoryMapping.getRepository();
+			Tree head = repository.mapTree("HEAD");
+			GitIndex index = repository.getIndex();
+			IndexDiff indexDiff = new IndexDiff(head, index);
+			indexDiff.diff();
+
+			includeList(project, indexDiff.getAdded(), indexChanges);
+			includeList(project, indexDiff.getChanged(), indexChanges);
+			includeList(project, indexDiff.getRemoved(), indexChanges);
+			includeList(project, indexDiff.getMissing(), notIndexed);
+			includeList(project, indexDiff.getModified(), notIndexed);
 		}
 	}
 
@@ -395,7 +394,7 @@ private boolean isChanged(RepositoryMapping map, IFile resource) {
 
 	@Override
 	public boolean isEnabled() {
-		return getRepositories().length > 0;
+		return getProjectsInRepositoryOfSelectedResources().length > 0;
 	}
 
 }
-- 
1.6.0.rc2.35.g04c6e9
