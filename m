From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Resurrect group filtering options in history pane
Date: Sun,  1 Feb 2009 21:36:18 +0100
Message-ID: <1233520578-10453-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Feb 01 21:38:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTj53-0005km-58
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 21:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbZBAUg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 15:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZBAUg1
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 15:36:27 -0500
Received: from mail.dewire.com ([83.140.172.130]:20651 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266AbZBAUg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 15:36:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C423C1434D8B;
	Sun,  1 Feb 2009 21:36:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wn+tGoTigZXy; Sun,  1 Feb 2009 21:36:18 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id BCE72800271;
	Sun,  1 Feb 2009 21:36:18 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108000>

This commit restores the ability to filter on not only the selected
resource but instead all changes in the same folder, same project
or same repository. The filtering levels supported are Resource (no button
pessed), Folder, Project and Repository. Only the highest level has any
effect. The flags are persistent between eclipse sessions in the same
workspace.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/GitHistoryPage.java   |  108 +++++++++++++++++++-
 1 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index d718cd7..4e95df4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -96,7 +96,7 @@
 
 	/**
 	 * Determine if the input can be shown in this viewer.
-	 * 
+	 *
 	 * @param object
 	 *            an object that is hopefully of type ResourceList or IResource,
 	 *            but may be anything (including null).
@@ -188,6 +188,18 @@ private static boolean typeOk(final IResource object) {
 	 */
 	private List<String> pathFilters;
 
+	private static final String PREF_SHOWALLREPOVERSIONS = "org.spearce.egit.ui.githistorypage.showallrepoversions";
+
+	private static final String PREF_SHOWALLPROJECTVERSIONS = "org.spearce.egit.ui.githistorypage.showallprojectversions";
+
+	private static final String PREF_SHOWALLFOLDERVERSIONS = "org.spearce.egit.ui.githistorypage.showallfolderversions";
+
+	private boolean showAllProjectVersions;
+
+	private boolean showAllFolderVersions;
+
+	private boolean showAllRepoVersions;
+
 	/**
 	 * The selection provider tracks the selected revisions for the context menu
 	 */
@@ -236,9 +248,85 @@ public void createControl(final Composite parent) {
 		attachContextMenu(fileViewer.getControl());
 		layout();
 
+		showAllProjectVersions = Activator.getDefault().getPreferenceStore()
+				.getBoolean(PREF_SHOWALLPROJECTVERSIONS);
+		showAllFolderVersions = Activator.getDefault().getPreferenceStore()
+				.getBoolean(PREF_SHOWALLFOLDERVERSIONS);
+		showAllRepoVersions = Activator.getDefault().getPreferenceStore()
+				.getBoolean(PREF_SHOWALLREPOVERSIONS);
+
+		Action showAllRepoVersionsAction = new Action("R") {
+			public void run() {
+				cancelRefreshJob();
+				setShowAllRepoVersions(isChecked());
+				cancelRefreshJob();
+			}
+		};
+		showAllRepoVersionsAction
+				.setToolTipText("Show all versions for the repository containing the resource");
+		showAllRepoVersionsAction.setChecked(isShowAllRepoVersions());
+		getSite().getActionBars().getToolBarManager().add(
+				showAllRepoVersionsAction);
+
+		Action showAllProjectVersionsAction = new Action("P") {
+			public void run() {
+				cancelRefreshJob();
+				setShowAllProjectVersions(isChecked());
+				inputSet();
+			}
+		};
+		showAllProjectVersionsAction
+				.setToolTipText("Show all versions for the project containing the resource");
+		showAllProjectVersionsAction.setChecked(isShowAllProjectVersions());
+		getSite().getActionBars().getToolBarManager().add(
+				showAllProjectVersionsAction);
+
+		Action showAllFolderVersionsAction = new Action("F") {
+			public void run() {
+				cancelRefreshJob();
+				setShowAllFolderVersion(isChecked());
+				inputSet();
+			}
+		};
+		showAllFolderVersionsAction
+				.setToolTipText("Show all versions for the folder containing the resource");
+		showAllFolderVersionsAction.setChecked(isShowAllFolderVersions());
+		getSite().getActionBars().getToolBarManager().add(
+				showAllFolderVersionsAction);
+
 		Repository.addAnyRepositoryChangedListener(this);
 	}
 
+	/* private */boolean isShowAllRepoVersions() {
+		return showAllRepoVersions;
+	}
+
+	void setShowAllRepoVersions(boolean showAllRepoVersions) {
+		this.showAllRepoVersions = showAllRepoVersions;
+		Activator.getDefault().getPreferenceStore().setValue(
+				PREF_SHOWALLREPOVERSIONS, showAllRepoVersions);
+	}
+
+	/* private */boolean isShowAllProjectVersions() {
+		return showAllProjectVersions;
+	}
+
+	void setShowAllProjectVersions(boolean showAllProjectVersions) {
+		this.showAllProjectVersions = showAllProjectVersions;
+		Activator.getDefault().getPreferenceStore().setValue(
+				PREF_SHOWALLPROJECTVERSIONS, showAllProjectVersions);
+	}
+
+	/* private */boolean isShowAllFolderVersions() {
+		return showAllFolderVersions;
+	}
+
+	void setShowAllFolderVersion(boolean showAllFolderVersions) {
+		this.showAllFolderVersions = showAllFolderVersions;
+		Activator.getDefault().getPreferenceStore().setValue(
+				PREF_SHOWALLFOLDERVERSIONS, showAllFolderVersions);
+	}
+
 	private Runnable refschangedRunnable;
 
 	public void refsChanged(final RefsChangedEvent e) {
@@ -566,9 +654,21 @@ public boolean inputSet() {
 			else if (db != map.getRepository())
 				return false;
 
-			final String name = map.getRepoRelativePath(r);
-			if (name != null && name.length() > 0)
-				paths.add(name);
+			if (isShowAllFolderVersions()) {
+				final String name = map.getRepoRelativePath(r.getParent());
+				if (name != null && name.length() > 0)
+					paths.add(name);
+			} else if (isShowAllProjectVersions()) {
+				final String name = map.getRepoRelativePath(r.getProject());
+				if (name != null && name.length() > 0)
+					paths.add(name);
+			} else if (isShowAllRepoVersions()) {
+				// nothing
+			} else {
+				final String name = map.getRepoRelativePath(r);
+				if (name != null && name.length() > 0)
+					paths.add(name);
+			}
 		}
 
 		if (db == null)
-- 
1.6.1.285.g35d8b
