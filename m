From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Make it possible to create a new Git repository in project parent directory.
Date: Tue, 10 Jun 2008 00:50:11 +0200
Message-ID: <1213051816-4046-3-git-send-email-robin.rosenberg.lists@dewire.com>
References: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-2-git-send-email-robin.rosenberg.lists@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 00:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qGE-0001Eo-AF
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 00:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbYFIWx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 18:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756452AbYFIWx2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 18:53:28 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17225 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755674AbYFIWx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 18:53:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BC3D08030B5;
	Tue, 10 Jun 2008 00:53:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJsvVocIdbyN; Tue, 10 Jun 2008 00:53:22 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id E155A1434D09;
	Tue, 10 Jun 2008 00:53:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1213051816-4046-2-git-send-email-robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84445>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

In order to share repository, the Git repository must be located
outside the project. This patch extends the scope to the parent
directory.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
index b029de7..3ed3569 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
@@ -15,8 +15,10 @@ import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.core.runtime.Path;
 import org.eclipse.core.runtime.SubProgressMonitor;
 import org.eclipse.team.core.RepositoryProvider;
 import org.spearce.egit.core.Activator;
@@ -57,7 +59,7 @@ public class ConnectProviderOperation implements IWorkspaceRunnable {
 
 		m.beginTask(CoreText.ConnectProviderOperation_connecting, 100);
 		try {
-			final Collection repos = new ArrayList();
+			final Collection<RepositoryMapping> repos = new ArrayList<RepositoryMapping>();
 
 			if (newGitDir != null) {
 				try {
@@ -68,8 +70,17 @@ public class ConnectProviderOperation implements IWorkspaceRunnable {
 
 					db = new Repository(newGitDir);
 					db.create();
+					IPath gitDirParent = Path.fromOSString(
+							db.getDirectory().getAbsolutePath())
+							.removeLastSegments(1);
+					IPath cPath = project.getLocation();
+					String subset = null;
+					if (gitDirParent.isPrefixOf(cPath)) {
+						int n = cPath.matchingFirstSegments(gitDirParent);
+						subset = cPath.removeFirstSegments(n).toPortableString();
+					}
 					repos.add(new RepositoryMapping(project, db.getDirectory(),
-							null));
+							subset));
 					db.close();
 
 					// If we don't refresh the project directory right
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 6f2c7cf..9ccf606 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -41,6 +41,9 @@ public class UIText extends NLS {
 	public static String ExistingOrNewPage_createNew;
 
 	/** */
+	public static String ExistingOrNewPage_createInParent;
+
+	/** */
 	public static String GitCloneWizard_title;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/ExistingOrNewPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/ExistingOrNewPage.java
index 24377d4..d0ddcb7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/ExistingOrNewPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/ExistingOrNewPage.java
@@ -19,6 +19,7 @@ import org.spearce.egit.ui.UIText;
 
 class ExistingOrNewPage extends WizardPage {
 	final SharingWizard myWizard;
+	private Button createInParent;
 
 	ExistingOrNewPage(final SharingWizard w) {
 		super(ExistingOrNewPage.class.getName());
@@ -45,6 +46,7 @@ class ExistingOrNewPage extends WizardPage {
 
 			public void widgetSelected(final SelectionEvent e) {
 				myWizard.setUseExisting();
+				createInParent.setEnabled(false);
 			}
 		});
 		useExisting.setSelection(true);
@@ -59,9 +61,24 @@ class ExistingOrNewPage extends WizardPage {
 
 			public void widgetSelected(final SelectionEvent e) {
 				myWizard.setCreateNew();
+				createInParent.setEnabled(true);
 			}
 		});
 
+		createInParent = new Button(g, SWT.CHECK);
+		createInParent.setEnabled(createNew.getSelection());
+		createInParent.setText(UIText.ExistingOrNewPage_createInParent);
+		createInParent.addSelectionListener(new SelectionListener() {
+			public void widgetDefaultSelected(SelectionEvent e) {
+				widgetSelected(e);
+			}
+
+			public void widgetSelected(SelectionEvent e) {
+				myWizard.setUseParent(createInParent.getSelection());
+			}
+		});
+		createInParent.setSelection(true);
+		myWizard.setUseParent(createInParent.getSelection());
 		setControl(g);
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/SharingWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/SharingWizard.java
index e02b038..292baf2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/SharingWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/SharingWizard.java
@@ -36,6 +36,8 @@ public class SharingWizard extends Wizard implements IConfigurationWizard {
 
 	private File newGitDir;
 
+	private boolean useParent;
+
 	/**
 	 * Construct the Git Sharing Wizard for connecting Git project to Eclipse
 	 */
@@ -46,7 +48,14 @@ public class SharingWizard extends Wizard implements IConfigurationWizard {
 
 	public void init(final IWorkbench workbench, final IProject p) {
 		project = p;
-		newGitDir = new File(project.getLocation().toFile(), ".git");
+		calculateNewGitDir();
+	}
+
+	private void calculateNewGitDir() {
+		File pdir = project.getLocation().toFile();
+		if (useParent)
+			pdir = pdir.getParentFile();
+		newGitDir = new File(pdir, ".git");
 	}
 
 	public void addPages() {
@@ -100,4 +109,9 @@ public class SharingWizard extends Wizard implements IConfigurationWizard {
 			return false;
 		}
 	}
+
+	void setUseParent(boolean selection) {
+		useParent = selection;
+		calculateNewGitDir();
+	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index f4980a0..18f8c28 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -25,6 +25,7 @@ ExistingOrNewPage_description=Select Git Repository Location
 ExistingOrNewPage_groupHeader=Repository Location
 ExistingOrNewPage_useExisting=Search for existing Git repositories
 ExistingOrNewPage_createNew=Create a new Git repository for this project
+ExistingOrNewPage_createInParent=Create repository in project's parent directory
 
 GitCloneWizard_title=Import Git Repository
 GitCloneWizard_jobName=Cloning from {0}
-- 
1.5.5.1.178.g1f811
