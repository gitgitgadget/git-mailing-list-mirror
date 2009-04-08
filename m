From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/4] Multi-project connect to Git provider
Date: Wed,  8 Apr 2009 17:51:31 +0200
Message-ID: <1239205891-28236-4-git-send-email-robin.rosenberg@dewire.com>
References: <1239205891-28236-1-git-send-email-robin.rosenberg@dewire.com>
 <1239205891-28236-2-git-send-email-robin.rosenberg@dewire.com>
 <1239205891-28236-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lra67-0003ue-Vu
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbZDHPvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbZDHPvq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:51:46 -0400
Received: from mail.dewire.com ([83.140.172.130]:6928 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755267AbZDHPvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 11:51:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 15E6A14915D6;
	Wed,  8 Apr 2009 17:51:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WFzX9shRJ5Sb; Wed,  8 Apr 2009 17:51:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id C3D9214915DD;
	Wed,  8 Apr 2009 17:51:39 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1239205891-28236-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116093>

Eclipse supports connecting multiple projects to a repository. This
patch implements this for Git.

The sharing Wizard has been rewritten and create support moved out
of the ConnectOperation class to the wizard.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../core/T0003_AdaptableFileTreeIteratorTest.java  |    2 +-
 .../egit/core/internal/mapping/T0002_history.java  |    2 +-
 .../op/T0001_ConnectProviderOperationTest.java     |   11 +-
 .../src/org/spearce/egit/core/CoreText.java        |    8 +-
 .../src/org/spearce/egit/core/coretext.properties  |    4 +-
 .../egit/core/op/ConnectProviderOperation.java     |  112 ++++------
 .../src/org/spearce/egit/ui/UIText.java            |   17 +-
 .../ui/internal/clone/GitProjectsImportPage.java   |    2 +-
 .../ui/internal/sharing/ExistingOrNewPage.java     |  235 ++++++++++++++++----
 .../egit/ui/internal/sharing/SharingWizard.java    |   53 ++---
 .../src/org/spearce/egit/ui/uitext.properties      |   11 +-
 11 files changed, 283 insertions(+), 174 deletions(-)

diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/T0003_AdaptableFileTreeIteratorTest.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/T0003_AdaptableFileTreeIteratorTest.java
index 1e2fe03..63e0798 100644
--- a/org.spearce.egit.core.test/src/org/spearce/egit/core/T0003_AdaptableFileTreeIteratorTest.java
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/T0003_AdaptableFileTreeIteratorTest.java
@@ -44,7 +44,7 @@ protected void setUp() throws Exception {
 		fileWriter.close();
 
 		final ConnectProviderOperation operation = new ConnectProviderOperation(
-				project.getProject(), null);
+				project.getProject());
 		operation.run(null);
 	}
 
diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java
index 148e61e..735540e 100644
--- a/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/internal/mapping/T0002_history.java
@@ -78,7 +78,7 @@ protected void setUp() throws Exception {
 		assertEquals(RefUpdate.Result.NEW, lck.forceUpdate());
 
 		ConnectProviderOperation operation = new ConnectProviderOperation(
-				project.getProject(), null);
+				project.getProject());
 		operation.run(null);
 	}
 
diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
index 1d332a3..f891262 100644
--- a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
@@ -35,7 +35,7 @@
 	public void testNoRepository() throws CoreException {
 
 		ConnectProviderOperation operation = new ConnectProviderOperation(
-				project.getProject(), null);
+				project.getProject());
 		operation.run(null);
 
 		// We are shared because we declared as shared
@@ -43,12 +43,15 @@ public void testNoRepository() throws CoreException {
 		assertTrue(!gitDir.exists());
 	}
 
-	public void testNewRepository() throws CoreException {
+	public void testNewRepository() throws CoreException, IOException {
 
 		File gitDir = new File(project.getProject().getWorkspace().getRoot()
 				.getRawLocation().toFile(), ".git");
+		Repository repository = new Repository(gitDir);
+		repository.create();
+		repository.close();
 		ConnectProviderOperation operation = new ConnectProviderOperation(
-				project.getProject(), gitDir);
+				project.getProject());
 		operation.run(null);
 
 		assertTrue(RepositoryProvider.isShared(project.getProject()));
@@ -90,7 +93,7 @@ public void testNewUnsharedFile() throws CoreException, IOException,
 		assertEquals(RefUpdate.Result.NEW, lck.forceUpdate());
 
 		ConnectProviderOperation operation = new ConnectProviderOperation(
-				project.getProject(), null);
+				project.getProject());
 		operation.run(null);
 
 		final boolean f[] = new boolean[1];
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
index 46a7ef6..6b2627b 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/CoreText.java
@@ -28,13 +28,7 @@
 	public static String ConnectProviderOperation_connecting;
 
 	/** */
-	public static String ConnectProviderOperation_creating;
-
-	/** */
-	public static String ConnectProviderOperation_recordingMapping;
-
-	/** */
-	public static String ConnectProviderOperation_updatingCache;
+	public static String ConnectProviderOperation_ConnectingProject;
 
 	/** */
 	public static String DisconnectProviderOperation_disconnecting;
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
index a911889..663c996 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
@@ -16,9 +16,7 @@
 ##
 
 ConnectProviderOperation_connecting=Connecting Git team provider.
-ConnectProviderOperation_creating=Creating new Git repository.
-ConnectProviderOperation_recordingMapping=Saving repository mappings.
-ConnectProviderOperation_updatingCache=Updating workspace cache.
+ConnectProviderOperation_ConnectingProject=Connecting project {0}
 
 DisconnectProviderOperation_disconnecting=Disconnecting Git team provider.
 
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
index 7fc82ec..274fabb 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
@@ -8,8 +8,6 @@
  *******************************************************************************/
 package org.spearce.egit.core.op;
 
-import java.io.File;
-import java.util.ArrayList;
 import java.util.Collection;
 
 import org.eclipse.core.resources.IProject;
@@ -19,6 +17,7 @@
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
 import org.eclipse.core.runtime.SubProgressMonitor;
+import org.eclipse.osgi.util.NLS;
 import org.eclipse.team.core.RepositoryProvider;
 import org.spearce.egit.core.Activator;
 import org.spearce.egit.core.CoreText;
@@ -26,29 +25,31 @@
 import org.spearce.egit.core.project.GitProjectData;
 import org.spearce.egit.core.project.RepositoryFinder;
 import org.spearce.egit.core.project.RepositoryMapping;
-import org.spearce.jgit.lib.Repository;
 
 /**
- * Connects Eclipse to an existing Git repository, or creates a new one.
+ * Connects Eclipse to an existing Git repository
  */
 public class ConnectProviderOperation implements IWorkspaceRunnable {
-	private final IProject project;
-
-	private final File newGitDir;
+	private final IProject[] projects;
 
 	/**
 	 * Create a new connection operation to execute within the workspace.
 	 * 
 	 * @param proj
 	 *            the project to connect to the Git team provider.
-	 * @param newdir
-	 *            git repository to create if the user requested a new
-	 *            repository be constructed for this project; null to scan for
-	 *            an existing repository and connect to that.
 	 */
-	public ConnectProviderOperation(final IProject proj, final File newdir) {
-		project = proj;
-		newGitDir = newdir;
+	public ConnectProviderOperation(final IProject proj) {
+		this(new IProject[] { proj });
+	}
+
+	/**
+	 * Create a new connection operation to execute within the workspace.
+	 *
+	 * @param projects
+	 *            the projects to connect to the Git team provider.
+	 */
+	public ConnectProviderOperation(final IProject[] projects) {
+		this.projects = projects;
 	}
 
 	public void run(IProgressMonitor m) throws CoreException {
@@ -56,63 +57,42 @@ public void run(IProgressMonitor m) throws CoreException {
 			m = new NullProgressMonitor();
 		}
 
-		m.beginTask(CoreText.ConnectProviderOperation_connecting, 100);
+		m.beginTask(CoreText.ConnectProviderOperation_connecting,
+				100 * projects.length);
 		try {
-			final Collection<RepositoryMapping> repos = new ArrayList<RepositoryMapping>();
-
-			if (newGitDir != null) {
-				try {
-					final Repository db;
-
-					m.subTask(CoreText.ConnectProviderOperation_creating);
-					Activator.trace("Creating repository " + newGitDir);
-
-					db = new Repository(newGitDir);
-					db.create();
-					repos.add(new RepositoryMapping(project, db.getDirectory()));
-					db.close();
-
-					// If we don't refresh the project directory right
-					// now we won't later know that a .git directory
-					// exists within it and we won't mark the .git
-					// directory as a team-private member. Failure
-					// to do so might allow someone to delete
-					// the .git directory without us stopping them.
-					//
-					project.refreshLocal(IResource.DEPTH_ONE,
-							new SubProgressMonitor(m, 10));
 
+			for (IProject project : projects) {
+				m.setTaskName(NLS.bind(
+						CoreText.ConnectProviderOperation_ConnectingProject,
+						project.getName()));
+				Activator.trace("Locating repository for " + project); //$NON-NLS-1$
+				Collection<RepositoryMapping> repos = new RepositoryFinder(
+						project).find(new SubProgressMonitor(m, 40));
+				if (repos.size() == 1) {
+					GitProjectData projectData = new GitProjectData(project);
+					try {
+						projectData.setRepositoryMappings(repos);
+						projectData.store();
+					} catch (CoreException ce) {
+						GitProjectData.delete(project);
+						throw ce;
+					} catch (RuntimeException ce) {
+						GitProjectData.delete(project);
+						throw ce;
+					}
+					RepositoryProvider
+							.map(project, GitProvider.class.getName());
+					projectData = GitProjectData.get(project);
+					project.refreshLocal(IResource.DEPTH_INFINITE,
+							new SubProgressMonitor(m, 50));
 					m.worked(10);
-				} catch (Throwable err) {
-					throw Activator.error(
-							CoreText.ConnectProviderOperation_creating, err);
+				} else {
+					Activator
+							.trace("Attempted to share project without repository ignored :" //$NON-NLS-1$
+									+ project);
+					m.worked(60);
 				}
-			} else {
-				Activator.trace("Finding existing repositories.");
-				repos.addAll(new RepositoryFinder(project)
-						.find(new SubProgressMonitor(m, 20)));
 			}
-
-			m.subTask(CoreText.ConnectProviderOperation_recordingMapping);
-			GitProjectData projectData = new GitProjectData(project);
-			projectData.setRepositoryMappings(repos);
-			projectData.store();
-
-			try {
-				RepositoryProvider.map(project, GitProvider.class.getName());
-			} catch (CoreException ce) {
-				GitProjectData.delete(project);
-				throw ce;
-			} catch (RuntimeException ce) {
-				GitProjectData.delete(project);
-				throw ce;
-			}
-
-			projectData = GitProjectData.get(project);
-			project.refreshLocal(IResource.DEPTH_INFINITE,
-					new SubProgressMonitor(m, 50));
-
-			m.subTask(CoreText.ConnectProviderOperation_updatingCache);
 		} finally {
 			m.done();
 		}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index f14eada..654e155 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -68,22 +68,31 @@
 	public static String GenericOperationFailed;
 
 	/** */
+	public static String ExistingOrNewPage_CreateButton;
+
+	/** */
 	public static String ExistingOrNewPage_title;
 
 	/** */
 	public static String ExistingOrNewPage_description;
 
 	/** */
-	public static String ExistingOrNewPage_groupHeader;
+	public static String ExistingOrNewPage_ErrorFailedToCreateRepository;
+
+	/** */
+	public static String ExistingOrNewPage_ErrorFailedToRefreshRepository;
+
+	/** */
+	public static String ExistingOrNewPage_HeaderPath;
 
 	/** */
-	public static String ExistingOrNewPage_useExisting;
+	public static String ExistingOrNewPage_HeaderProject;
 
 	/** */
-	public static String ExistingOrNewPage_createNew;
+	public static String ExistingOrNewPage_HeaderRepository;
 
 	/** */
-	public static String ExistingOrNewPage_createInParent;
+	public static String ExistingOrNewPage_SymbolicValueEmptyMapping;
 
 	/** */
 	public static String GitCloneWizard_title;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java
index 5d82edc..8e02cd1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java
@@ -711,7 +711,7 @@ private boolean createExistingProject(final ProjectRecord record,
 					monitor, openTicks));
 			if (share) {
 				ConnectProviderOperation connectProviderOperation = new ConnectProviderOperation(
-						project, null);
+						project);
 				connectProviderOperation
 						.run(new SubProgressMonitor(monitor, 20));
 			}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/ExistingOrNewPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/ExistingOrNewPage.java
index b3ea769..8676f0a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/ExistingOrNewPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/ExistingOrNewPage.java
@@ -1,5 +1,5 @@
 /*******************************************************************************
- * Copyright (C) 2007, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2009, Robin Rosenberg
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -7,80 +7,221 @@
  *******************************************************************************/
 package org.spearce.egit.ui.internal.sharing;
 
+import java.io.File;
+import java.io.IOException;
+import java.util.Collection;
+import java.util.Iterator;
+
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
+import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.core.runtime.Path;
+import org.eclipse.jface.dialogs.MessageDialog;
+import org.eclipse.jface.layout.GridDataFactory;
 import org.eclipse.jface.wizard.WizardPage;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.SelectionEvent;
 import org.eclipse.swt.events.SelectionListener;
-import org.eclipse.swt.layout.RowLayout;
+import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.widgets.Button;
 import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Event;
 import org.eclipse.swt.widgets.Group;
+import org.eclipse.swt.widgets.Listener;
+import org.eclipse.swt.widgets.Text;
+import org.eclipse.swt.widgets.Tree;
+import org.eclipse.swt.widgets.TreeColumn;
+import org.eclipse.swt.widgets.TreeItem;
+import org.spearce.egit.core.Activator;
+import org.spearce.egit.core.project.RepositoryFinder;
+import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.Repository;
 
+/**
+ * Wizard page for connecting projects to Git repositories.
+ */
 class ExistingOrNewPage extends WizardPage {
-	final SharingWizard myWizard;
-	private Button createInParent;
 
-	ExistingOrNewPage(final SharingWizard w) {
+	private final SharingWizard myWizard;
+	private Button button;
+	private Tree tree;
+	private Text repositoryToCreate;
+	private IPath minumumPath;
+
+	ExistingOrNewPage(SharingWizard w) {
 		super(ExistingOrNewPage.class.getName());
 		setTitle(UIText.ExistingOrNewPage_title);
 		setDescription(UIText.ExistingOrNewPage_description);
 		setImageDescriptor(UIIcons.WIZBAN_CONNECT_REPO);
-		myWizard = w;
+		this.myWizard = w;
 	}
 
-	public void createControl(final Composite parent) {
-		final Group g;
-		final Button useExisting;
-		final Button createNew;
-
-		g = new Group(parent, SWT.NONE);
-		g.setText(UIText.ExistingOrNewPage_groupHeader);
-		g.setLayout(new RowLayout(SWT.VERTICAL));
-
-		useExisting = new Button(g, SWT.RADIO);
-		useExisting.setText(UIText.ExistingOrNewPage_useExisting);
-		useExisting.addSelectionListener(new SelectionListener() {
-			public void widgetDefaultSelected(final SelectionEvent e) {
-				widgetSelected(e);
+	public void createControl(Composite parent) {
+		Group g = new Group(parent, SWT.NONE);
+		g.setLayout(new GridLayout(3,false));
+		g.setLayoutData(GridDataFactory.fillDefaults().grab(true, true).create());
+		tree = new Tree(g, SWT.BORDER|SWT.MULTI);
+		tree.setHeaderVisible(true);
+		tree.setLayout(new GridLayout());
+		tree.setLayoutData(GridDataFactory.fillDefaults().grab(true, true).span(3,1).create());
+		TreeColumn c1 = new TreeColumn(tree,SWT.NONE);
+		c1.setText(UIText.ExistingOrNewPage_HeaderProject);
+		c1.setWidth(100);
+		TreeColumn c2 = new TreeColumn(tree,SWT.NONE);
+		c2.setText(UIText.ExistingOrNewPage_HeaderPath);
+		c2.setWidth(400);
+		TreeColumn c3 = new TreeColumn(tree,SWT.NONE);
+		c3.setText(UIText.ExistingOrNewPage_HeaderRepository);
+		c3.setWidth(200);
+		for (IProject project : myWizard.projects) {
+			TreeItem treeItem = new TreeItem(tree, SWT.NONE);
+			treeItem.setData(project);
+			treeItem.setText(0, project.getName());
+			treeItem.setText(1, project.getLocation().toOSString());
+			RepositoryFinder repositoryFinder = new RepositoryFinder(project);
+			Collection<RepositoryMapping> find;
+			try {
+				find = repositoryFinder.find(new NullProgressMonitor());
+				if (find.size() == 0)
+					treeItem.setText(2, ""); //$NON-NLS-1$
+				else {
+					Iterator<RepositoryMapping> mi = find.iterator();
+					RepositoryMapping m = mi.next();
+					if (m.getGitDir() == null)
+						treeItem.setText(2,UIText.ExistingOrNewPage_SymbolicValueEmptyMapping);
+					else
+						treeItem.setText(2, m.getGitDir());
+					while (mi.hasNext()) {
+						TreeItem treeItem2 = new TreeItem(treeItem, SWT.NONE);
+						if (m.getGitDir() == null)
+							treeItem2.setText(2,UIText.ExistingOrNewPage_SymbolicValueEmptyMapping);
+						else
+							treeItem2.setText(2,m.getGitDir());
+					}
+				}
+			} catch (CoreException e) {
+				TreeItem treeItem2 = new TreeItem(treeItem, SWT.BOLD|SWT.ITALIC);
+				treeItem2.setText(e.getMessage());
 			}
+		}
 
-			public void widgetSelected(final SelectionEvent e) {
-				myWizard.setUseExisting();
-				createInParent.setEnabled(false);
+		button = new Button(g, SWT.PUSH);
+		button.setLayoutData(GridDataFactory.fillDefaults().create());
+		button.setText(UIText.ExistingOrNewPage_CreateButton);
+		button.addSelectionListener(new SelectionListener() {
+			public void widgetSelected(SelectionEvent e) {
+				File gitDir = new File(repositoryToCreate.getText(),".git");
+				try {
+					Repository repository = new Repository(gitDir);
+					repository.create();
+					for (IProject project : getProjects()) {
+						// If we don't refresh the project directories right
+						// now we won't later know that a .git directory
+						// exists within it and we won't mark the .git
+						// directory as a team-private member. Failure
+						// to do so might allow someone to delete
+						// the .git directory without us stopping them.
+						// (Half lie, we should optimize so we do not
+						// refresh when the .git is not within the project)
+						//
+						if (!gitDir.toString().contains("..")) //$NON-NLS-1$
+							project.refreshLocal(IResource.DEPTH_ONE,
+									new NullProgressMonitor());
+					}
+				} catch (IOException e1) {
+					MessageDialog.openError(getShell(), UIText.ExistingOrNewPage_ErrorFailedToCreateRepository, gitDir.toString() + ":\n" + e1.getMessage());
+					Activator.logError("Failed to create repository at " + gitDir, e1); //$NON-NLS-1$
+				} catch (CoreException e2) {
+					Activator.logError(UIText.ExistingOrNewPage_ErrorFailedToRefreshRepository + gitDir, e2);
+				}
+				for (TreeItem ti : tree.getSelection()) {
+					ti.setText(2, gitDir.toString());
+				}
+				updateCreateOptions();
+				getContainer().updateButtons();
+			}
+			public void widgetDefaultSelected(SelectionEvent e) {
 			}
 		});
-		useExisting.setSelection(true);
-
-		createNew = new Button(g, SWT.RADIO);
-		createNew.setEnabled(myWizard.canCreateNew());
-		createNew.setText(UIText.ExistingOrNewPage_createNew);
-		createNew.addSelectionListener(new SelectionListener() {
-			public void widgetDefaultSelected(final SelectionEvent e) {
-				widgetSelected(e);
+		repositoryToCreate = new Text(g, SWT.SINGLE | SWT.BORDER);
+		repositoryToCreate.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).span(1,1).create());
+		repositoryToCreate.addListener(SWT.Modify, new Listener() {
+			public void handleEvent(Event e) {
+				if (e.text == null)
+					return;
+				IPath fromOSString = Path.fromOSString(e.text);
+				button.setEnabled(minumumPath
+						.matchingFirstSegments(fromOSString) == fromOSString
+						.segmentCount());
 			}
-
-			public void widgetSelected(final SelectionEvent e) {
-				myWizard.setCreateNew();
-				createInParent.setEnabled(true);
+		});
+		Text l = new Text(g,SWT.NONE);
+		l.setEnabled(false);
+		l.setEditable(false);
+		l.setText(File.separatorChar + ".git"); //$NON-NLS-1$
+		l.setLayoutData(GridDataFactory.fillDefaults().create());
+		tree.addSelectionListener(new SelectionListener() {
+			public void widgetSelected(SelectionEvent e) {
+				updateCreateOptions();
+			}
+			public void widgetDefaultSelected(SelectionEvent e) {
+				// Empty
 			}
 		});
+		updateCreateOptions();
+		setControl(g);
+	}
 
-		createInParent = new Button(g, SWT.CHECK);
-		createInParent.setEnabled(createNew.getSelection());
-		createInParent.setText(UIText.ExistingOrNewPage_createInParent);
-		createInParent.addSelectionListener(new SelectionListener() {
-			public void widgetDefaultSelected(SelectionEvent e) {
-				widgetSelected(e);
+	private void updateCreateOptions() {
+		minumumPath = null;
+		IPath p = null;
+		for (TreeItem ti : tree.getSelection()) {
+			String path = ti.getText(2);
+			if (!path.equals("")) { //$NON-NLS-1$
+				p = null;
+				break;
+			}
+			String gitDirParentCandidate = ti.getText(1);
+			IPath thisPath = Path.fromOSString(gitDirParentCandidate);
+			if (p == null)
+				p = thisPath;
+			else {
+				int n = p.matchingFirstSegments(thisPath);
+				p = p.removeLastSegments(p.segmentCount() - n);
 			}
+		}
+		minumumPath = p;
+		if (p != null) {
+			repositoryToCreate.setText(p.toOSString());
+		} else {
+			repositoryToCreate.setText(""); //$NON-NLS-1$
+		}
+		button.setEnabled(p != null);
+		repositoryToCreate.setEnabled(p != null);
+		getContainer().updateButtons();
+	}
 
-			public void widgetSelected(SelectionEvent e) {
-				myWizard.setUseParent(createInParent.getSelection());
+	@Override
+	public boolean isPageComplete() {
+		if (tree.getSelectionCount() == 0)
+			return false;
+		for (TreeItem ti : tree.getSelection()) {
+			String path = ti.getText(2);
+			if (path.equals("")) { //$NON-NLS-1$
+				return false;
 			}
-		});
-		createInParent.setSelection(true);
-		myWizard.setUseParent(createInParent.getSelection());
-		setControl(g);
+		}
+		return true;
+	}
+
+	public IProject[] getProjects() {
+		IProject[] ret = new IProject[tree.getSelection().length];
+		for (int i = 0; i < ret.length; ++i)
+			ret[i] = (IProject)tree.getSelection()[i].getData();
+		return ret;
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/SharingWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/SharingWizard.java
index 292baf2..1e89ab2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/SharingWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/SharingWizard.java
@@ -8,7 +8,6 @@
  *******************************************************************************/
 package org.spearce.egit.ui.internal.sharing;
 
-import java.io.File;
 import java.lang.reflect.InvocationTargetException;
 
 import org.eclipse.core.resources.IProject;
@@ -20,6 +19,7 @@
 import org.eclipse.jface.operation.IRunnableWithProgress;
 import org.eclipse.jface.wizard.Wizard;
 import org.eclipse.team.ui.IConfigurationWizard;
+import org.eclipse.team.ui.IConfigurationWizardExtension;
 import org.eclipse.ui.IWorkbench;
 import org.spearce.egit.core.op.ConnectProviderOperation;
 import org.spearce.egit.ui.Activator;
@@ -27,16 +27,13 @@
 
 /**
  * The dialog used for activating Team>Share, i.e. to create a new
- * Git repository or associate a project with one.
+ * Git repository or associate projects with one.
  */
-public class SharingWizard extends Wizard implements IConfigurationWizard {
-	private IProject project;
+public class SharingWizard extends Wizard implements IConfigurationWizard,
+		IConfigurationWizardExtension {
+	IProject[] projects;
 
-	private boolean create;
-
-	private File newGitDir;
-
-	private boolean useParent;
+	private ExistingOrNewPage existingPage;
 
 	/**
 	 * Construct the Git Sharing Wizard for connecting Git project to Eclipse
@@ -46,39 +43,23 @@ public SharingWizard() {
 		setNeedsProgressMonitor(true);
 	}
 
-	public void init(final IWorkbench workbench, final IProject p) {
-		project = p;
-		calculateNewGitDir();
+	public void init(IWorkbench workbench, IProject[] p) {
+		this.projects = new IProject[p.length];
+		System.arraycopy(p, 0, this.projects, 0, p.length);
 	}
 
-	private void calculateNewGitDir() {
-		File pdir = project.getLocation().toFile();
-		if (useParent)
-			pdir = pdir.getParentFile();
-		newGitDir = new File(pdir, ".git");
+	public void init(final IWorkbench workbench, final IProject p) {
+		projects = new IProject[] { p };
 	}
 
 	public void addPages() {
-		addPage(new ExistingOrNewPage(this));
-	}
-
-	boolean canCreateNew() {
-		return !newGitDir.exists();
-	}
-
-	void setCreateNew() {
-		if (canCreateNew()) {
-			create = true;
-		}
-	}
-
-	void setUseExisting() {
-		create = false;
+		existingPage = new ExistingOrNewPage(this);
+		addPage(existingPage);
 	}
 
 	public boolean performFinish() {
 		final ConnectProviderOperation op = new ConnectProviderOperation(
-				project, create ? newGitDir : null);
+				existingPage.getProjects());
 		try {
 			getContainer().run(true, false, new IRunnableWithProgress() {
 				public void run(final IProgressMonitor monitor)
@@ -110,8 +91,8 @@ public void run(final IProgressMonitor monitor)
 		}
 	}
 
-	void setUseParent(boolean selection) {
-		useParent = selection;
-		calculateNewGitDir();
+	@Override
+	public boolean canFinish() {
+		return existingPage.isPageComplete();
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 1e1a29d..1d21c81 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -35,12 +35,15 @@ SharingWizard_failed=Failed to initialize Git team provider.
 
 GenericOperationFailed={0} Failed
 
+ExistingOrNewPage_CreateButton=&Create...
 ExistingOrNewPage_title=Configure Git Repository
 ExistingOrNewPage_description=Select Git Repository Location
-ExistingOrNewPage_groupHeader=Repository Location
-ExistingOrNewPage_useExisting=Search for existing Git repositories
-ExistingOrNewPage_createNew=Create a new Git repository for this project
-ExistingOrNewPage_createInParent=Create repository in project's parent directory
+ExistingOrNewPage_ErrorFailedToCreateRepository=Failed to create repository
+ExistingOrNewPage_ErrorFailedToRefreshRepository=Failed to refresh project after creating repo at
+ExistingOrNewPage_HeaderPath=Path
+ExistingOrNewPage_HeaderProject=Project
+ExistingOrNewPage_HeaderRepository=Repository
+ExistingOrNewPage_SymbolicValueEmptyMapping=<empty repository mapping>
 
 GitCloneWizard_title=Import Git Repository
 GitCloneWizard_jobName=Cloning from {0}
-- 
1.6.2.2.446.gfbdc0
