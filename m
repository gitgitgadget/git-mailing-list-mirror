From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Add utilities for figuring out repositories for selected resources
Date: Sun, 31 Aug 2008 11:38:43 +0200
Message-ID: <1220175524-1523-2-git-send-email-robin.rosenberg@dewire.com>
References: <1220175524-1523-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 11:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZjRo-000794-4i
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 11:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474AbYHaJlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 05:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756515AbYHaJlL
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 05:41:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7399 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756274AbYHaJlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 05:41:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0F15C80068E;
	Sun, 31 Aug 2008 11:41:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wT632ux2ytaZ; Sun, 31 Aug 2008 11:41:06 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E4AEF800699;
	Sun, 31 Aug 2008 11:41:05 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e9
In-Reply-To: <1220175524-1523-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94470>

We want to go from selected resources to repositories and back
to any resource in those repositories

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/actions/RepositoryAction.java |   50 ++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/RepositoryAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/RepositoryAction.java
index c4e3256..8c250ca 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/RepositoryAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/RepositoryAction.java
@@ -13,6 +13,8 @@
 import java.util.Set;
 
 import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.jface.action.IAction;
 import org.eclipse.jface.dialogs.MessageDialog;
 import org.eclipse.team.internal.ui.actions.TeamAction;
@@ -36,6 +38,54 @@ public void execute(IAction action) {
 	}
 
 	/**
+	 * @return the projects hosting the selected resources
+	 */
+	protected IProject[] getProjectsForSelectedResources() {
+		Set<IProject> ret = new HashSet<IProject>();
+		for (IResource resource : (IResource[])getSelectedAdaptables(getSelection(), IResource.class))
+			ret.add(resource.getProject());
+		return ret.toArray(new IProject[ret.size()]);
+	}
+
+	/**
+	 * @param projects
+	 *            a list of projects
+	 * @return the repositories that projects map to iff all projects are mapped
+	 */ 
+	protected Repository[] getRepositoriesFor(final IProject[] projects) {
+		Set<Repository> ret = new HashSet<Repository>();
+		for (IProject project : projects) {
+			RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(project);
+			if (repositoryMapping == null)
+				return new Repository[0];
+			ret.add(repositoryMapping.getRepository());
+		}
+		return ret.toArray(new Repository[ret.size()]);
+	}
+	
+	/**
+	 * List the projects with selected resources, if all projects are connected
+	 * to a Git repository.
+	 * 
+	 * @return the tracked projects affected by the current resource selection
+	 */
+	public IProject[] getProjectsInRepositoryOfSelectedResources() {
+		Set<IProject> ret = new HashSet<IProject>();
+		Repository[] repositories = getRepositoriesFor(getProjectsForSelectedResources());
+		final IProject[] projects = ResourcesPlugin.getWorkspace().getRoot().getProjects();
+		for (IProject project : projects) {
+			RepositoryMapping mapping = RepositoryMapping.getMapping(project);
+			for (Repository repository : repositories) {
+				if (mapping != null && mapping.getRepository() == repository) {
+					ret.add(project);
+					break;
+				}
+			}
+		}
+		return ret.toArray(new IProject[ret.size()]);
+	}
+
+	/**
 	 * Figure out which repository to use. All selected
 	 * resources must map to the same Git repository.
 	 *
-- 
1.6.0.rc2.35.g04c6e9
