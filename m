From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Add an import wizard for Eclipse projects as part of clone
Date: Wed, 31 Dec 2008 11:56:09 +0100
Message-ID: <1230720969-1735-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Dec 31 11:58:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHym8-0001OW-J2
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 11:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbYLaK4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 05:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756877AbYLaK4Y
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 05:56:24 -0500
Received: from mail.dewire.com ([83.140.172.130]:2268 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756447AbYLaK4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 05:56:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 983638030A7;
	Wed, 31 Dec 2008 11:56:13 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CIeFICB4ZVin; Wed, 31 Dec 2008 11:56:10 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B556980280E;
	Wed, 31 Dec 2008 11:56:09 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104265>

This adds an optional page for importing Eclipse style projects
as part of the clone operation.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/META-INF/MANIFEST.MF           |    1 +
 .../ui/internal/clone/CloneDestinationPage.java    |   30 +-
 .../egit/ui/internal/clone/GitCloneWizard.java     |  108 ++-
 .../ui/internal/clone/GitProjectsImportPage.java   |  956 ++++++++++++++++++++
 .../components/RepositorySelectionPage.java        |    7 +
 5 files changed, 1081 insertions(+), 21 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java

This patch I think, greatly simplifies getting an Eclipse based project
into the workbench.

I'm mostly interested in comments on pure bugs. E.g. know it's
blocking when the user selects to import the projects as part of the
clone process, I also know I'm reusing internal messages and not supplying
NLS style constansts for all textx.

Happy New Year!

-- robin


diff --git a/org.spearce.egit.ui/META-INF/MANIFEST.MF b/org.spearce.egit.ui/META-INF/MANIFEST.MF
index 092624f..420801b 100644
--- a/org.spearce.egit.ui/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.ui/META-INF/MANIFEST.MF
@@ -19,6 +19,7 @@ Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.compare,
  org.spearce.jgit,
  org.spearce.egit.core,
+ org.eclipse.ui.ide,
  org.eclipse.jsch.ui;bundle-version="1.1.100"
 Eclipse-LazyStart: true
 Bundle-RequiredExecutionEnvironment: J2SE-1.5
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index 5173335..c60dd0c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -57,12 +57,13 @@
 
 	private Text remoteText;
 
+	Button showImportWizarad;
+
 	CloneDestinationPage(final RepositorySelectionPage sp,
 			final SourceBranchPage bp) {
 		super(CloneDestinationPage.class.getName());
 		sourcePage = sp;
 		branchPage = bp;
-
 		setTitle(UIText.CloneDestinationPage_title);
 
 		final SelectionChangeListener listener = new SelectionChangeListener() {
@@ -82,7 +83,7 @@ public void createControl(final Composite parent) {
 
 		createDestinationGroup(panel);
 		createConfigGroup(panel);
-
+		createWorkbenchGroup(panel);
 		setControl(panel);
 		checkPage();
 	}
@@ -92,6 +93,8 @@ public void setVisible(final boolean visible) {
 		if (visible)
 			revalidate();
 		super.setVisible(visible);
+		if (visible)
+			directoryText.setFocus();
 	}
 
 	private void checkPreviousPagesSelections() {
@@ -165,6 +168,20 @@ public void modifyText(ModifyEvent e) {
 		});
 	}
 
+	private void createWorkbenchGroup(Composite parent) {
+		final Group g = createGroup(parent, "Workspace import");
+		newLabel(g, "Import projects after clone");
+		showImportWizarad = new Button(g, SWT.CHECK);
+		showImportWizarad.setSelection(true);
+		showImportWizarad.setLayoutData(createFieldGridData());
+		showImportWizarad.addSelectionListener(new SelectionAdapter() {
+			@Override
+			public void widgetSelected(SelectionEvent e) {
+				checkPage();
+			}
+		});
+	}
+
 	private static Group createGroup(final Composite parent, final String text) {
 		final Group g = new Group(parent, SWT.NONE);
 		final GridLayout layout = new GridLayout();
@@ -223,8 +240,9 @@ setErrorMessage(NLS.bind(UIText.CloneDestinationPage_fieldRequired,
 		}
 		final File absoluteFile = new File(dstpath).getAbsoluteFile();
 		if (!isEmptyDir(absoluteFile)) {
-			setErrorMessage(NLS.bind(UIText.CloneDestinationPage_errorNotEmptyDir,
-					absoluteFile.getPath()));
+			setErrorMessage(NLS.bind(
+					UIText.CloneDestinationPage_errorNotEmptyDir, absoluteFile
+							.getPath()));
 			setPageComplete(false);
 			return;
 		}
@@ -316,4 +334,8 @@ private String getSuggestedName() {
 		return path;
 	}
 
+	@Override
+	public boolean canFlipToNextPage() {
+		return super.canFlipToNextPage() && showImportWizarad.getSelection();
+	}
 }
\ No newline at end of file
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
index a69dc52..01d7374 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
@@ -18,11 +18,13 @@
 import org.eclipse.core.runtime.Status;
 import org.eclipse.core.runtime.jobs.Job;
 import org.eclipse.jface.dialogs.ErrorDialog;
+import org.eclipse.jface.dialogs.MessageDialog;
 import org.eclipse.jface.viewers.IStructuredSelection;
 import org.eclipse.jface.wizard.Wizard;
 import org.eclipse.osgi.util.NLS;
 import org.eclipse.ui.IImportWizard;
 import org.eclipse.ui.IWorkbench;
+import org.eclipse.ui.PlatformUI;
 import org.spearce.egit.core.op.CloneOperation;
 import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIIcons;
@@ -41,6 +43,10 @@
 
 	private CloneDestinationPage cloneDestination;
 
+	private GitProjectsImportPage importProject;
+
+	private String alreadyClonedInto;
+
 	public void init(IWorkbench arg0, IStructuredSelection arg1) {
 		setWindowTitle(UIText.GitCloneWizard_title);
 		setDefaultPageImageDescriptor(UIIcons.WIZBAN_IMPORT_REPO);
@@ -48,6 +54,47 @@ public void init(IWorkbench arg0, IStructuredSelection arg1) {
 		cloneSource = new RepositorySelectionPage(true);
 		validSource = new SourceBranchPage(cloneSource);
 		cloneDestination = new CloneDestinationPage(cloneSource, validSource);
+		importProject = new GitProjectsImportPage() {
+			@Override
+			public void setVisible(boolean visible) {
+				if (visible) {
+					if (alreadyClonedInto == null) {
+						performClone(false);
+						alreadyClonedInto = cloneDestination
+								.getDestinationFile().getAbsolutePath();
+					}
+					setDirectoryPath(alreadyClonedInto);
+					updateProjectsList(alreadyClonedInto);
+				}
+				super.setVisible(visible);
+			}
+		};
+	}
+
+	@Override
+	public boolean performCancel() {
+		if (alreadyClonedInto != null) {
+			if (MessageDialog
+					.openQuestion(getShell(), "Aborting clone.",
+							"A complete clone was already made. Do you want to delete it?")) {
+				deleteRecursively(new File(alreadyClonedInto));
+			}
+		}
+		return true;
+	}
+
+	private void deleteRecursively(File f) {
+		for (File i : f.listFiles()) {
+			if (i.isDirectory()) {
+				deleteRecursively(i);
+			} else {
+				if (!i.delete()) {
+					i.deleteOnExit();
+				}
+			}
+		}
+		if (!f.delete())
+			f.deleteOnExit();
 	}
 
 	@Override
@@ -55,10 +102,24 @@ public void addPages() {
 		addPage(cloneSource);
 		addPage(validSource);
 		addPage(cloneDestination);
+		addPage(importProject);
+	}
+
+	@Override
+	public boolean canFinish() {
+		return cloneDestination.isPageComplete()
+				&& !cloneDestination.showImportWizarad.getSelection()
+				|| importProject.isPageComplete();
 	}
 
 	@Override
 	public boolean performFinish() {
+		if (!cloneDestination.showImportWizarad.getSelection())
+			return performClone(true);
+		return importProject.createProjects();
+	}
+
+	boolean performClone(boolean background) {
 		final URIish uri = cloneSource.getSelection().getURI();
 		final boolean allSelected = validSource.isAllSelected();
 		final Collection<Ref> selectedBranches = validSource
@@ -80,24 +141,37 @@ public boolean performFinish() {
 
 		final CloneOperation op = new CloneOperation(uri, allSelected,
 				selectedBranches, workdir, branch, remoteName);
-		final Job job = new Job(NLS.bind(UIText.GitCloneWizard_jobName, uri
-				.toString())) {
-			@Override
-			protected IStatus run(final IProgressMonitor monitor) {
-				try {
-					op.run(monitor);
-					return Status.OK_STATUS;
-				} catch (InterruptedException e) {
-					return Status.CANCEL_STATUS;
-				} catch (InvocationTargetException e) {
-					Throwable thr = e.getCause();
-					return new Status(IStatus.ERROR, Activator.getPluginId(),
-							0, thr.getMessage(), thr);
+		if (background) {
+			final Job job = new Job(NLS.bind(UIText.GitCloneWizard_jobName, uri
+					.toString())) {
+				@Override
+				protected IStatus run(final IProgressMonitor monitor) {
+					try {
+						op.run(monitor);
+						return Status.OK_STATUS;
+					} catch (InterruptedException e) {
+						return Status.CANCEL_STATUS;
+					} catch (InvocationTargetException e) {
+						Throwable thr = e.getCause();
+						return new Status(IStatus.ERROR, Activator
+								.getPluginId(), 0, thr.getMessage(), thr);
+					}
 				}
+			};
+			job.setUser(true);
+			job.schedule();
+			return true;
+		} else {
+			try {
+				PlatformUI.getWorkbench().getProgressService().run(false, true,
+						op);
+				return true;
+			} catch (Exception e) {
+				Activator.logError("Failed to clone", e);
+				MessageDialog.openError(getShell(), "Failed clone", e
+						.toString());
+				return false;
 			}
-		};
-		job.setUser(true);
-		job.schedule();
-		return true;
+		}
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java
new file mode 100644
index 0000000..4241ddf
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java
@@ -0,0 +1,956 @@
+package org.spearce.egit.ui.internal.clone;
+
+/*******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation and others.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     IBM Corporation - initial API and implementation
+ *     Red Hat, Inc - extensive changes to allow importing of Archive Files
+ *     Philippe Ombredanne (pombredanne@nexb.com)
+ *     		- Bug 101180 [Import/Export] Import Existing Project into Workspace default widget is back button , should be text field
+ *     Martin Oberhuber (martin.oberhuber@windriver.com)
+ *     		- Bug 187318[Wizards] "Import Existing Project" loops forever with cyclic symbolic links
+ *     Remy Chi Jian Suen  (remy.suen@gmail.com)
+ *     		- Bug 210568 [Import/Export] [Import/Export] - Refresh button does not update list of projects
+ *     Robin Rosenberg (robin.rosenberg@dewire.com)
+ *     		- Copy for use with Git clone
+ *******************************************************************************/
+
+import java.io.File;
+import java.io.IOException;
+import java.lang.reflect.InvocationTargetException;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.HashSet;
+import java.util.Iterator;
+import java.util.List;
+import java.util.Set;
+
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IProjectDescription;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IWorkspace;
+import org.eclipse.core.resources.ResourcesPlugin;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.OperationCanceledException;
+import org.eclipse.core.runtime.Path;
+import org.eclipse.core.runtime.Platform;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.core.runtime.SubProgressMonitor;
+import org.eclipse.jface.dialogs.Dialog;
+import org.eclipse.jface.dialogs.ErrorDialog;
+import org.eclipse.jface.dialogs.MessageDialog;
+import org.eclipse.jface.operation.IRunnableWithProgress;
+import org.eclipse.jface.viewers.CheckStateChangedEvent;
+import org.eclipse.jface.viewers.CheckboxTreeViewer;
+import org.eclipse.jface.viewers.ICheckStateListener;
+import org.eclipse.jface.viewers.ITreeContentProvider;
+import org.eclipse.jface.viewers.LabelProvider;
+import org.eclipse.jface.viewers.Viewer;
+import org.eclipse.jface.viewers.ViewerComparator;
+import org.eclipse.jface.wizard.WizardPage;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.FocusAdapter;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.events.TraverseEvent;
+import org.eclipse.swt.events.TraverseListener;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Button;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.DirectoryDialog;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Text;
+import org.eclipse.ui.actions.WorkspaceModifyOperation;
+import org.eclipse.ui.internal.ide.IDEWorkbenchMessages;
+import org.eclipse.ui.internal.ide.IDEWorkbenchPlugin;
+import org.eclipse.ui.internal.ide.StatusUtil;
+import org.eclipse.ui.internal.wizards.datatransfer.DataTransferMessages;
+import org.eclipse.ui.internal.wizards.datatransfer.WizardProjectsImportPage;
+import org.eclipse.ui.statushandlers.StatusManager;
+import org.eclipse.ui.wizards.datatransfer.IImportStructureProvider;
+import org.spearce.egit.core.op.ConnectProviderOperation;
+import org.spearce.egit.ui.Activator;
+
+/**
+ * The GitWizardProjectsImportPage is the page that allows the user to import
+ * projects from a particular location. This is a modified copy of
+ * {@link WizardProjectsImportPage}
+ */
+public class GitProjectsImportPage extends WizardPage {
+
+	/**
+	 * The name of the folder containing metadata information for the workspace.
+	 */
+	public static final String METADATA_FOLDER = ".metadata"; //$NON-NLS-1$
+
+	/**
+	 * The import structure provider.
+	 */
+	private IImportStructureProvider structureProvider;
+
+	class ProjectRecord {
+		File projectSystemFile;
+
+		String projectName;
+
+		Object parent;
+
+		int level;
+
+		IProjectDescription description;
+
+		/**
+		 * Create a record for a project based on the info in the file.
+		 *
+		 * @param file
+		 */
+		ProjectRecord(File file) {
+			projectSystemFile = file;
+			setProjectName();
+		}
+
+		/**
+		 * @param parent
+		 *            The parent folder of the .project file
+		 * @param level
+		 *            The number of levels deep in the provider the file is
+		 */
+		ProjectRecord(Object parent, int level) {
+			this.parent = parent;
+			this.level = level;
+			setProjectName();
+		}
+
+		/**
+		 * Set the name of the project based on the projectFile.
+		 */
+		private void setProjectName() {
+			try {
+				// If we don't have the project name try again
+				if (projectName == null) {
+					IPath path = new Path(projectSystemFile.getPath());
+					// if the file is in the default location, use the directory
+					// name as the project name
+					if (isDefaultLocation(path)) {
+						projectName = path.segment(path.segmentCount() - 2);
+						description = IDEWorkbenchPlugin.getPluginWorkspace()
+								.newProjectDescription(projectName);
+					} else {
+						description = IDEWorkbenchPlugin.getPluginWorkspace()
+								.loadProjectDescription(path);
+						projectName = description.getName();
+					}
+
+				}
+			} catch (CoreException e) {
+				// no good couldn't get the name
+			}
+		}
+
+		/**
+		 * Returns whether the given project description file path is in the
+		 * default location for a project
+		 *
+		 * @param path
+		 *            The path to examine
+		 * @return Whether the given path is the default location for a project
+		 */
+		private boolean isDefaultLocation(IPath path) {
+			// The project description file must at least be within the project,
+			// which is within the workspace location
+			if (path.segmentCount() < 2)
+				return false;
+			return path.removeLastSegments(2).toFile().equals(
+					Platform.getLocation().toFile());
+		}
+
+		/**
+		 * Get the name of the project
+		 *
+		 * @return String
+		 */
+		public String getProjectName() {
+			return projectName;
+		}
+
+		/**
+		 * Gets the label to be used when rendering this project record in the
+		 * UI.
+		 *
+		 * @return String the label
+		 * @since 3.4
+		 */
+		public String getProjectLabel() {
+			if (description == null)
+				return projectName;
+
+			String path = projectSystemFile == null ? structureProvider
+					.getLabel(parent) : projectSystemFile.getParent();
+
+			return NLS.bind(
+					DataTransferMessages.WizardProjectsImportPage_projectLabel,
+					projectName, path);
+		}
+	}
+
+	private Text directoryPathField;
+
+	private CheckboxTreeViewer projectsList;
+
+	private ProjectRecord[] selectedProjects = new ProjectRecord[0];
+
+	// Keep track of the directory that we browsed to last time
+	// the wizard was invoked.
+	private static String previouslyBrowsedDirectory = ""; //$NON-NLS-1$
+
+	private Button browseDirectoriesButton;
+
+	private IProject[] wsProjects;
+
+	// The last selected path to minimize searches
+	private String lastPath;
+
+	// The last time that the file or folder at the selected path was modified
+	// to mimize searches
+	private long lastModified;
+
+	private Button shareCheckBox;
+
+	private boolean share;
+
+	/**
+	 * Creates a new project creation wizard page.
+	 */
+	public GitProjectsImportPage() {
+		this("gitWizardExternalProjectsPage"); //$NON-NLS-1$
+	}
+
+	/**
+	 * Create a new instance of the receiver.
+	 *
+	 * @param pageName
+	 */
+	public GitProjectsImportPage(String pageName) {
+		super(pageName);
+		setPageComplete(false);
+		setTitle(DataTransferMessages.WizardProjectsImportPage_ImportProjectsTitle);
+		setDescription(DataTransferMessages.WizardProjectsImportPage_ImportProjectsDescription);
+	}
+
+	/*
+	 * (non-Javadoc)
+	 *
+	 * @see
+	 * org.eclipse.jface.dialogs.IDialogPage#createControl(org.eclipse.swt.widgets
+	 * .Composite)
+	 */
+	public void createControl(Composite parent) {
+
+		initializeDialogUnits(parent);
+
+		Composite workArea = new Composite(parent, SWT.NONE);
+		setControl(workArea);
+
+		workArea.setLayout(new GridLayout());
+		workArea.setLayoutData(new GridData(GridData.FILL_BOTH
+				| GridData.GRAB_HORIZONTAL | GridData.GRAB_VERTICAL));
+
+		createProjectsRoot(workArea);
+		createProjectsList(workArea);
+		createOptionsArea(workArea);
+		Dialog.applyDialogFont(workArea);
+
+	}
+
+	/**
+	 * Create the area with the extra options.
+	 *
+	 * @param workArea
+	 */
+	private void createOptionsArea(Composite workArea) {
+		Composite optionsGroup = new Composite(workArea, SWT.NONE);
+		optionsGroup.setLayout(new GridLayout());
+		optionsGroup.setLayoutData(new GridData(GridData.FILL_HORIZONTAL));
+
+		shareCheckBox = new Button(optionsGroup, SWT.CHECK);
+		shareCheckBox
+				.setText("Enable Git Team operations on imported projects");
+		shareCheckBox.setLayoutData(new GridData(GridData.FILL_HORIZONTAL));
+		shareCheckBox.setSelection(share = true);
+		shareCheckBox.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				share = shareCheckBox.getSelection();
+			}
+		});
+	}
+
+	/**
+	 * Create the checkbox list for the found projects.
+	 *
+	 * @param workArea
+	 */
+	private void createProjectsList(Composite workArea) {
+
+		Label title = new Label(workArea, SWT.NONE);
+		title
+				.setText(DataTransferMessages.WizardProjectsImportPage_ProjectsListTitle);
+
+		Composite listComposite = new Composite(workArea, SWT.NONE);
+		GridLayout layout = new GridLayout();
+		layout.numColumns = 2;
+		layout.marginWidth = 0;
+		layout.makeColumnsEqualWidth = false;
+		listComposite.setLayout(layout);
+
+		listComposite.setLayoutData(new GridData(GridData.GRAB_HORIZONTAL
+				| GridData.GRAB_VERTICAL | GridData.FILL_BOTH));
+
+		projectsList = new CheckboxTreeViewer(listComposite, SWT.BORDER);
+		GridData listData = new GridData(GridData.GRAB_HORIZONTAL
+				| GridData.GRAB_VERTICAL | GridData.FILL_BOTH);
+		projectsList.getControl().setLayoutData(listData);
+
+		projectsList.setContentProvider(new ITreeContentProvider() {
+
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.jface.viewers.ITreeContentProvider#getChildren(java
+			 * .lang.Object)
+			 */
+			public Object[] getChildren(Object parentElement) {
+				return null;
+			}
+
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.jface.viewers.IStructuredContentProvider#getElements
+			 * (java.lang.Object)
+			 */
+			public Object[] getElements(Object inputElement) {
+				return getValidProjects();
+			}
+
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.jface.viewers.ITreeContentProvider#hasChildren(java
+			 * .lang.Object)
+			 */
+			public boolean hasChildren(Object element) {
+				return false;
+			}
+
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.jface.viewers.ITreeContentProvider#getParent(java
+			 * .lang.Object)
+			 */
+			public Object getParent(Object element) {
+				return null;
+			}
+
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see org.eclipse.jface.viewers.IContentProvider#dispose()
+			 */
+			public void dispose() {
+
+			}
+
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.jface.viewers.IContentProvider#inputChanged(org.eclipse
+			 * .jface.viewers.Viewer, java.lang.Object, java.lang.Object)
+			 */
+			public void inputChanged(Viewer viewer, Object oldInput,
+					Object newInput) {
+			}
+
+		});
+
+		projectsList.setLabelProvider(new LabelProvider() {
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.jface.viewers.LabelProvider#getText(java.lang.Object)
+			 */
+			public String getText(Object element) {
+				return ((ProjectRecord) element).getProjectLabel();
+			}
+		});
+
+		projectsList.addCheckStateListener(new ICheckStateListener() {
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.jface.viewers.ICheckStateListener#checkStateChanged
+			 * (org.eclipse.jface.viewers.CheckStateChangedEvent)
+			 */
+			public void checkStateChanged(CheckStateChangedEvent event) {
+				setPageComplete(projectsList.getCheckedElements().length > 0);
+			}
+		});
+
+		projectsList.setInput(this);
+		projectsList.setComparator(new ViewerComparator());
+		createSelectionButtons(listComposite);
+	}
+
+	/**
+	 * Create the selection buttons in the listComposite.
+	 *
+	 * @param listComposite
+	 */
+	private void createSelectionButtons(Composite listComposite) {
+		Composite buttonsComposite = new Composite(listComposite, SWT.NONE);
+		GridLayout layout = new GridLayout();
+		layout.marginWidth = 0;
+		layout.marginHeight = 0;
+		buttonsComposite.setLayout(layout);
+
+		buttonsComposite.setLayoutData(new GridData(
+				GridData.VERTICAL_ALIGN_BEGINNING));
+
+		Button selectAll = new Button(buttonsComposite, SWT.PUSH);
+		selectAll.setText(DataTransferMessages.DataTransfer_selectAll);
+		selectAll.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				projectsList.setCheckedElements(selectedProjects);
+				setPageComplete(projectsList.getCheckedElements().length > 0);
+			}
+		});
+		Dialog.applyDialogFont(selectAll);
+		setButtonLayoutData(selectAll);
+
+		Button deselectAll = new Button(buttonsComposite, SWT.PUSH);
+		deselectAll.setText(DataTransferMessages.DataTransfer_deselectAll);
+		deselectAll.addSelectionListener(new SelectionAdapter() {
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.swt.events.SelectionAdapter#widgetSelected(org.eclipse
+			 * .swt.events.SelectionEvent)
+			 */
+			public void widgetSelected(SelectionEvent e) {
+
+				projectsList.setCheckedElements(new Object[0]);
+				setPageComplete(false);
+			}
+		});
+		Dialog.applyDialogFont(deselectAll);
+		setButtonLayoutData(deselectAll);
+
+		Button refresh = new Button(buttonsComposite, SWT.PUSH);
+		refresh.setText(DataTransferMessages.DataTransfer_refresh);
+		refresh.addSelectionListener(new SelectionAdapter() {
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.swt.events.SelectionAdapter#widgetSelected(org.eclipse
+			 * .swt.events.SelectionEvent)
+			 */
+			public void widgetSelected(SelectionEvent e) {
+				updateProjectsList(directoryPathField.getText().trim());
+			}
+		});
+		Dialog.applyDialogFont(refresh);
+		setButtonLayoutData(refresh);
+	}
+
+	/**
+	 * Create the area where you select the root directory for the projects.
+	 *
+	 * @param workArea
+	 *            Composite
+	 */
+	private void createProjectsRoot(Composite workArea) {
+
+		// project specification group
+		Composite projectGroup = new Composite(workArea, SWT.NONE);
+		GridLayout layout = new GridLayout();
+		layout.numColumns = 3;
+		layout.makeColumnsEqualWidth = false;
+		layout.marginWidth = 0;
+		projectGroup.setLayout(layout);
+		projectGroup.setLayoutData(new GridData(GridData.FILL_HORIZONTAL));
+
+		// project location entry field
+		this.directoryPathField = new Text(projectGroup, SWT.BORDER);
+
+		this.directoryPathField.setLayoutData(new GridData(
+				GridData.FILL_HORIZONTAL | GridData.GRAB_HORIZONTAL));
+
+		// browse button
+		browseDirectoriesButton = new Button(projectGroup, SWT.PUSH);
+		browseDirectoriesButton
+				.setText(DataTransferMessages.DataTransfer_browse);
+		setButtonLayoutData(browseDirectoriesButton);
+
+		browseDirectoriesButton.addSelectionListener(new SelectionAdapter() {
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see org.eclipse.swt.events.SelectionAdapter#widgetS
+			 * elected(org.eclipse.swt.events.SelectionEvent)
+			 */
+			public void widgetSelected(SelectionEvent e) {
+				handleLocationDirectoryButtonPressed();
+			}
+
+		});
+
+		directoryPathField.addTraverseListener(new TraverseListener() {
+
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.swt.events.TraverseListener#keyTraversed(org.eclipse
+			 * .swt.events.TraverseEvent)
+			 */
+			public void keyTraversed(TraverseEvent e) {
+				if (e.detail == SWT.TRAVERSE_RETURN) {
+					e.doit = false;
+					updateProjectsList(directoryPathField.getText().trim());
+				}
+			}
+
+		});
+
+		directoryPathField.addFocusListener(new FocusAdapter() {
+
+			/*
+			 * (non-Javadoc)
+			 *
+			 * @see
+			 * org.eclipse.swt.events.FocusListener#focusLost(org.eclipse.swt
+			 * .events.FocusEvent)
+			 */
+			public void focusLost(org.eclipse.swt.events.FocusEvent e) {
+				updateProjectsList(directoryPathField.getText().trim());
+			}
+
+		});
+
+	}
+
+	/*
+	 * (non-Javadoc) Method declared on IDialogPage. Set the focus on path
+	 * fields when page becomes visible.
+	 */
+	public void setVisible(boolean visible) {
+		super.setVisible(visible);
+		this.directoryPathField.setFocus();
+	}
+
+	/**
+	 * Update the list of projects based on path.
+	 *
+	 * @param path
+	 */
+	void updateProjectsList(final String path) {
+		// on an empty path empty selectedProjects
+		if (path == null || path.length() == 0) {
+			setMessage(DataTransferMessages.WizardProjectsImportPage_ImportProjectsDescription);
+			selectedProjects = new ProjectRecord[0];
+			projectsList.refresh(true);
+			projectsList.setCheckedElements(selectedProjects);
+			setPageComplete(projectsList.getCheckedElements().length > 0);
+			lastPath = path;
+			return;
+		}
+
+		final File directory = new File(path);
+		long modified = directory.lastModified();
+		if (path.equals(lastPath) && lastModified == modified) {
+			// since the file/folder was not modified and the path did not
+			// change, no refreshing is required
+			return;
+		}
+
+		lastPath = path;
+		lastModified = modified;
+
+		try {
+			getContainer().run(true, true, new IRunnableWithProgress() {
+
+				/*
+				 * (non-Javadoc)
+				 *
+				 * @see
+				 * org.eclipse.jface.operation.IRunnableWithProgress#run(org
+				 * .eclipse.core.runtime.IProgressMonitor)
+				 */
+				public void run(IProgressMonitor monitor) {
+
+					monitor
+							.beginTask(
+									DataTransferMessages.WizardProjectsImportPage_SearchingMessage,
+									100);
+					selectedProjects = new ProjectRecord[0];
+					Collection files = new ArrayList();
+					monitor.worked(10);
+					if (directory.isDirectory()) {
+
+						if (!collectProjectFilesFromDirectory(files, directory,
+								null, monitor)) {
+							return;
+						}
+						Iterator filesIterator = files.iterator();
+						selectedProjects = new ProjectRecord[files.size()];
+						int index = 0;
+						monitor.worked(50);
+						monitor
+								.subTask(DataTransferMessages.WizardProjectsImportPage_ProcessingMessage);
+						while (filesIterator.hasNext()) {
+							File file = (File) filesIterator.next();
+							selectedProjects[index] = new ProjectRecord(file);
+							index++;
+						}
+					} else {
+						monitor.worked(60);
+					}
+					monitor.done();
+				}
+
+			});
+		} catch (InvocationTargetException e) {
+			IDEWorkbenchPlugin.log(e.getMessage(), e);
+		} catch (InterruptedException e) {
+			// Nothing to do if the user interrupts.
+		}
+
+		projectsList.refresh(true);
+		projectsList.setCheckedElements(getValidProjects());
+		if (getValidProjects().length < selectedProjects.length) {
+			setMessage(
+					DataTransferMessages.WizardProjectsImportPage_projectsInWorkspace,
+					WARNING);
+		} else {
+			setMessage(DataTransferMessages.WizardProjectsImportPage_ImportProjectsDescription);
+		}
+		setPageComplete(projectsList.getCheckedElements().length > 0);
+	}
+
+	/**
+	 * Display an error dialog with the specified message.
+	 *
+	 * @param message
+	 *            the error message
+	 */
+	protected void displayErrorDialog(String message) {
+		MessageDialog.openError(getContainer().getShell(),
+				getErrorDialogTitle(), message);
+	}
+
+	/**
+	 * @return the title for an error dialog. Subclasses should override.
+	 */
+	protected String getErrorDialogTitle() {
+		return IDEWorkbenchMessages.WizardExportPage_internalErrorTitle;
+	}
+
+	/**
+	 * Collect the list of .project files that are under directory into files.
+	 *
+	 * @param files
+	 * @param directory
+	 * @param directoriesVisited
+	 *            Set of canonical paths of directories, used as recursion guard
+	 * @param monitor
+	 *            The monitor to report to
+	 * @return boolean <code>true</code> if the operation was completed.
+	 */
+	private boolean collectProjectFilesFromDirectory(Collection files,
+			File directory, Set directoriesVisited, IProgressMonitor monitor) {
+
+		if (monitor.isCanceled()) {
+			return false;
+		}
+		monitor.subTask(NLS.bind(
+				DataTransferMessages.WizardProjectsImportPage_CheckingMessage,
+				directory.getPath()));
+		File[] contents = directory.listFiles();
+		if (contents == null)
+			return false;
+
+		// Initialize recursion guard for recursive symbolic links
+		if (directoriesVisited == null) {
+			directoriesVisited = new HashSet();
+			try {
+				directoriesVisited.add(directory.getCanonicalPath());
+			} catch (IOException exception) {
+				StatusManager.getManager().handle(
+						StatusUtil.newStatus(IStatus.ERROR, exception
+								.getLocalizedMessage(), exception));
+			}
+		}
+
+		// first look for project description files
+		final String dotProject = IProjectDescription.DESCRIPTION_FILE_NAME;
+		for (int i = 0; i < contents.length; i++) {
+			File file = contents[i];
+			if (file.isFile() && file.getName().equals(dotProject)) {
+				files.add(file);
+				// don't search sub-directories since we can't have nested
+				// projects
+				return true;
+			}
+		}
+		// no project description found, so recurse into sub-directories
+		for (int i = 0; i < contents.length; i++) {
+			if (contents[i].isDirectory()) {
+				if (!contents[i].getName().equals(METADATA_FOLDER)) {
+					try {
+						String canonicalPath = contents[i].getCanonicalPath();
+						if (!directoriesVisited.add(canonicalPath)) {
+							// already been here --> do not recurse
+							continue;
+						}
+					} catch (IOException exception) {
+						StatusManager.getManager().handle(
+								StatusUtil.newStatus(IStatus.ERROR, exception
+										.getLocalizedMessage(), exception));
+
+					}
+					collectProjectFilesFromDirectory(files, contents[i],
+							directoriesVisited, monitor);
+				}
+			}
+		}
+		return true;
+	}
+
+	/**
+	 * The browse button has been selected. Select the location.
+	 */
+	protected void handleLocationDirectoryButtonPressed() {
+
+		DirectoryDialog dialog = new DirectoryDialog(directoryPathField
+				.getShell());
+		dialog
+				.setMessage(DataTransferMessages.WizardProjectsImportPage_SelectDialogTitle);
+
+		String dirName = directoryPathField.getText().trim();
+		if (dirName.length() == 0) {
+			dirName = previouslyBrowsedDirectory;
+		}
+
+		if (dirName.length() == 0) {
+			dialog.setFilterPath(IDEWorkbenchPlugin.getPluginWorkspace()
+					.getRoot().getLocation().toOSString());
+		} else {
+			File path = new File(dirName);
+			if (path.exists()) {
+				dialog.setFilterPath(new Path(dirName).toOSString());
+			}
+		}
+
+		String selectedDirectory = dialog.open();
+		if (selectedDirectory != null) {
+			previouslyBrowsedDirectory = selectedDirectory;
+			directoryPathField.setText(previouslyBrowsedDirectory);
+			updateProjectsList(selectedDirectory);
+		}
+
+	}
+
+	void setDirectoryPath(String path) {
+		directoryPathField.setText(path);
+	}
+
+	/**
+	 * Create the selected projects
+	 *
+	 * @return boolean <code>true</code> if all project creations were
+	 *         successful.
+	 */
+	boolean createProjects() {
+		final Object[] selected = projectsList.getCheckedElements();
+		WorkspaceModifyOperation op = new WorkspaceModifyOperation() {
+			protected void execute(IProgressMonitor monitor)
+					throws InvocationTargetException, InterruptedException {
+				try {
+					monitor.beginTask("", selected.length); //$NON-NLS-1$
+					if (monitor.isCanceled()) {
+						throw new OperationCanceledException();
+					}
+					for (int i = 0; i < selected.length; i++) {
+						createExistingProject((ProjectRecord) selected[i],
+								new SubProgressMonitor(monitor, 1));
+					}
+				} finally {
+					monitor.done();
+				}
+			}
+		};
+		// run the new project creation operation
+		try {
+			getContainer().run(true, true, op);
+		} catch (InterruptedException e) {
+			return false;
+		} catch (InvocationTargetException e) {
+			// one of the steps resulted in a core exception
+			Throwable t = e.getTargetException();
+			String message = DataTransferMessages.WizardExternalProjectImportPage_errorMessage;
+			IStatus status;
+			if (t instanceof CoreException) {
+				status = ((CoreException) t).getStatus();
+			} else {
+				status = new Status(IStatus.ERROR,
+						IDEWorkbenchPlugin.IDE_WORKBENCH, 1, message, t);
+			}
+			Activator.logError(message, t);
+			ErrorDialog.openError(getShell(), message, null, status);
+			return false;
+		}
+		return true;
+	}
+
+	/**
+	 * Create the project described in record. If it is successful return true.
+	 *
+	 * @param record
+	 * @param monitor
+	 * @return boolean <code>true</code> if successful
+	 * @throws InvocationTargetException
+	 * @throws InterruptedException
+	 */
+	private boolean createExistingProject(final ProjectRecord record,
+			IProgressMonitor monitor) throws InvocationTargetException,
+			InterruptedException {
+		String projectName = record.getProjectName();
+		final IWorkspace workspace = ResourcesPlugin.getWorkspace();
+		final IProject project = workspace.getRoot().getProject(projectName);
+		if (record.description == null) {
+			// error case
+			record.description = workspace.newProjectDescription(projectName);
+			IPath locationPath = new Path(record.projectSystemFile
+					.getAbsolutePath());
+
+			// If it is under the root use the default location
+			if (Platform.getLocation().isPrefixOf(locationPath)) {
+				record.description.setLocation(null);
+			} else {
+				record.description.setLocation(locationPath);
+			}
+		} else {
+			record.description.setName(projectName);
+		}
+
+		try {
+			monitor
+					.beginTask(
+							DataTransferMessages.WizardProjectsImportPage_CreateProjectsTask,
+							100);
+			project.create(record.description, new SubProgressMonitor(monitor,
+					30));
+			int openTicks = share ? 50 : 70;
+			project.open(IResource.BACKGROUND_REFRESH, new SubProgressMonitor(
+					monitor, openTicks));
+			if (share) {
+				ConnectProviderOperation connectProviderOperation = new ConnectProviderOperation(
+						project, null);
+				connectProviderOperation
+						.run(new SubProgressMonitor(monitor, 20));
+			}
+		} catch (CoreException e) {
+			throw new InvocationTargetException(e);
+		} finally {
+			monitor.done();
+		}
+
+		return true;
+	}
+
+	/**
+	 * Method used for test suite.
+	 *
+	 * @return CheckboxTreeViewer the viewer containing all the projects found
+	 */
+	public CheckboxTreeViewer getProjectsList() {
+		return projectsList;
+	}
+
+	/**
+	 * Retrieve all the projects in the current workspace.
+	 *
+	 * @return IProject[] array of IProject in the current workspace
+	 */
+	private IProject[] getProjectsInWorkspace() {
+		if (wsProjects == null) {
+			wsProjects = IDEWorkbenchPlugin.getPluginWorkspace().getRoot()
+					.getProjects();
+		}
+		return wsProjects;
+	}
+
+	/**
+	 * Get the array of valid project records that can be imported from the
+	 * source workspace or archive, selected by the user. If a project with the
+	 * same name exists in both the source workspace and the current workspace,
+	 * it will not appear in the list of projects to import and thus cannot be
+	 * selected for import.
+	 *
+	 * Method declared public for test suite.
+	 *
+	 * @return ProjectRecord[] array of projects that can be imported into the
+	 *         workspace
+	 */
+	public ProjectRecord[] getValidProjects() {
+		List validProjects = new ArrayList();
+		for (int i = 0; i < selectedProjects.length; i++) {
+			if (!isProjectInWorkspace(selectedProjects[i].getProjectName())) {
+				validProjects.add(selectedProjects[i]);
+			}
+		}
+		return (ProjectRecord[]) validProjects
+				.toArray(new ProjectRecord[validProjects.size()]);
+	}
+
+	/**
+	 * Determine if the project with the given name is in the current workspace.
+	 *
+	 * @param projectName
+	 *            String the project name to check
+	 * @return boolean true if the project with the given name is in this
+	 *         workspace
+	 */
+	private boolean isProjectInWorkspace(String projectName) {
+		if (projectName == null) {
+			return false;
+		}
+		IProject[] workspaceProjects = getProjectsInWorkspace();
+		for (int i = 0; i < workspaceProjects.length; i++) {
+			if (projectName.equals(workspaceProjects[i].getName())) {
+				return true;
+			}
+		}
+		return false;
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
index 86cf6ec..f656518 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RepositorySelectionPage.java
@@ -660,4 +660,11 @@ private void updateAuthGroup() {
 			break;
 		}
 	}
+
+	@Override
+	public void setVisible(boolean visible) {
+		super.setVisible(visible);
+		if (visible)
+			uriText.setFocus();
+	}
 }
-- 
1.6.1.rc3.56.gd0306
