From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT RFC] Enable commit for any resource in a Git-shared project
Date: Fri, 13 Jun 2008 01:39:57 +0200
Message-ID: <1213313997-1520-3-git-send-email-robin.rosenberg@dewire.com>
References: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com>
 <1213313997-1520-2-git-send-email-robin.rosenberg@dewire.com>
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 01:44:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6wT7-0002ZA-Lz
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 01:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbYFLXnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbYFLXno
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 19:43:44 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29447 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755719AbYFLXnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 19:43:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5131D1434CD1;
	Fri, 13 Jun 2008 01:43:13 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rd-k-CagqG6y; Fri, 13 Jun 2008 01:43:11 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 379991434DF4;
	Fri, 13 Jun 2008 01:43:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1213313997-1520-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84814>

By default the commit dialog will be populated with all changed resources
in the projects that contain the selected resources, provided the projects
are associated with a Git respository.
---
 .../egit/ui/internal/actions/CommitAction.java     |   31 +++++++++----------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index db38c10..da32ea5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -68,7 +68,7 @@ public class CommitAction extends RepositoryAction {
 			return;
 		}
 
-		Repository[] repos = getRepositories();
+		Repository[] repos = getRepositoriesFor(getProjectsForSelectedResources());
 		amendAllowed = repos.length == 1;
 		for (Repository repo : repos) {
 			if (!repo.getRepositoryState().canCommit()) {
@@ -313,21 +313,20 @@ public class CommitAction extends RepositoryAction {
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
 
@@ -395,7 +394,7 @@ public class CommitAction extends RepositoryAction {
 
 	@Override
 	public boolean isEnabled() {
-		return getRepositories().length > 0;
+		return getProjectsInRepositoryOfSelectedResources().length > 0;
 	}
 
 }
-- 
1.5.5.1.178.g1f811
