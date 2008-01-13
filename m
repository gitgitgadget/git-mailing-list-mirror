From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Showing commit info similar to the CVS plugin.
Date: Sun, 13 Jan 2008 19:08:30 -0200
Message-ID: <1200258510-15235-1-git-send-email-rogersoares@intelinet.com.br>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 22:07:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEA3K-0000We-FT
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 22:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYAMVHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 16:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbYAMVHA
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 16:07:00 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1217 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753647AbYAMVG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 16:06:59 -0500
Received: (qmail 33344 invoked by uid 0); 13 Jan 2008 19:08:57 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.216229 secs); 13 Jan 2008 21:08:57 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.219.118)
  by cvxbsd.convex.com.br with SMTP; 13 Jan 2008 21:08:55 -0000
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70412>

Tooltips for the info were annoying, especially on MacOS where the tooltip center is your pointer location.
It is now possible to copy&paste data.
Like the CVS plugin, there's a menu to show/hide views.
Tooltips can still be enabled via a menu option.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
It now has a preference to enable/disable tooltips and the
preference is persisted across eclipse restarts.
I already merged this with the pu branch so I could test it while working on this one.

 org.spearce.egit.ui/plugin.xml                     |    4 +
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |  327 +++++++++++++++++++-
 .../egit/ui/PluginPreferenceInitializer.java       |   46 +++
 .../src/org/spearce/egit/ui/UIPreferences.java     |   32 ++
 .../src/org/spearce/egit/ui/UIText.java            |    9 +
 .../src/org/spearce/egit/ui/uitext.properties      |    5 +
 6 files changed, 406 insertions(+), 17 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 60519b0..b62c9d7 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -1,6 +1,10 @@
 <?xml version="1.0" encoding="UTF-8"?>
 <?eclipse version="3.0"?>
 <plugin>
+   <extension point="org.eclipse.core.runtime.preferences">
+      <initializer class="org.spearce.egit.ui.PluginPreferenceInitializer"/>
+   </extension>
+
    <extension point="org.eclipse.team.ui.configurationWizards">
       <wizard name="%SharingWizard_name"
             icon="icons/sharing.gif"
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 45d5903..803adc5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -17,6 +17,7 @@
 package org.spearce.egit.ui;
 
 import java.io.IOException;
+import java.text.SimpleDateFormat;
 import java.util.Date;
 import java.util.HashMap;
 import java.util.List;
@@ -34,13 +35,18 @@ import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Preferences;
 import org.eclipse.core.runtime.Status;
 import org.eclipse.core.runtime.jobs.Job;
 import org.eclipse.jface.action.Action;
+import org.eclipse.jface.action.IAction;
 import org.eclipse.jface.action.IMenuListener;
 import org.eclipse.jface.action.IMenuManager;
 import org.eclipse.jface.action.MenuManager;
+import org.eclipse.jface.action.Separator;
 import org.eclipse.jface.resource.JFaceResources;
+import org.eclipse.jface.text.Document;
+import org.eclipse.jface.text.TextViewer;
 import org.eclipse.jface.viewers.ColumnWeightData;
 import org.eclipse.jface.viewers.ILazyContentProvider;
 import org.eclipse.jface.viewers.StructuredSelection;
@@ -48,6 +54,7 @@ import org.eclipse.jface.viewers.TableLayout;
 import org.eclipse.jface.viewers.TableViewer;
 import org.eclipse.jface.viewers.Viewer;
 import org.eclipse.swt.SWT;
+import org.eclipse.swt.custom.SashForm;
 import org.eclipse.swt.events.MouseAdapter;
 import org.eclipse.swt.events.MouseEvent;
 import org.eclipse.swt.events.MouseMoveListener;
@@ -72,6 +79,8 @@ import org.eclipse.team.internal.ui.history.DialogHistoryPageSite;
 import org.eclipse.team.ui.history.HistoryPage;
 import org.eclipse.team.ui.history.IHistoryCompareAdapter;
 import org.eclipse.team.ui.history.IHistoryPageSite;
+import org.eclipse.ui.IActionBars;
+import org.eclipse.ui.part.IPageSite;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.internal.mapping.GitCommitFileRevision;
 import org.spearce.egit.core.internal.mapping.GitFileHistory;
@@ -98,14 +107,26 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	private static final String PREF_SHOWALLREPOVERSIONS = "org.spearce.egit.ui.githistorypage.showallrepoversions";
 	private static final String PREF_SHOWALLPROJECTVERSIONS = "org.spearce.egit.ui.githistorypage.showallprojectversions";
 	private static final String PREF_SHOWALLFOLDERVERSIONS = "org.spearce.egit.ui.githistorypage.showallfolderversions";
+	/* private */static final SimpleDateFormat DATETIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");
+	/* private */static final SimpleDateFormat DATETIMETZ_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z");
 
-	private Composite localComposite;
+	private SashForm localComposite;
+	private SashForm revisionInfoComposite;
 
-	private TableViewer viewer;
+	/* private */Preferences prefs = Activator.getDefault().getPluginPreferences();
 
-	private Table table;
+	/* private */TableViewer viewer;
+	/* private */TextViewer revDetailTextViewer;
+	/* private */TextViewer revCommentTextViewer;
+	/* private */IAction toggleCommentWrapAction;
+	/* private */IAction toggleRevDetailAction;
+	/* private */IAction toggleRevCommentAction;
+	/* private */IAction toggleTooltipsAction;
 
-	private List<IFileRevision> fileRevisions;
+	/* private */Table table;
+	private MouseMoveListener tableMouseMoveListener;
+
+	/* private */List<IFileRevision> fileRevisions;
 
 	private boolean hintShowDiffNow;
 
@@ -139,7 +160,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	}
 
 	public void createControl(Composite parent) {
-		localComposite = new Composite(parent, SWT.NONE);
+		localComposite = new SashForm(parent, SWT.VERTICAL);
+
 		GridLayout layout = new GridLayout();
 		layout.marginHeight = 0;
 		layout.marginWidth = 0;
@@ -150,6 +172,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 		createTable(localComposite);
 
+		revisionInfoComposite = new SashForm(localComposite, SWT.HORIZONTAL);
+		createRevDetailTextViewer(revisionInfoComposite);
+		createRevCommentTextViewer(revisionInfoComposite);
+
 		IHistoryPageSite parentSite = getHistoryPageSite();
 		if (parentSite != null && parentSite instanceof DialogHistoryPageSite)
 			parentSite.setSelectionProvider(viewer);
@@ -158,6 +184,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				"Compare");
 		final GitCompareRevisionAction compareActionPrev = new GitCompareRevisionAction(
 				"Show commit");
+
 		table.addMouseListener(new MouseAdapter() {
 		
 			public void mouseDown(MouseEvent e) {
@@ -166,7 +193,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 		});
 
-		table.addMouseMoveListener(new MouseMoveListener() {
+		tableMouseMoveListener = new MouseMoveListener() {
 			TableItem lastItem;
 			public void mouseMove(MouseEvent e) {
 				TableItem item = table.getItem(new Point(e.x,e.y));
@@ -179,7 +206,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				}
 				lastItem = item;
 			}
-		});
+		};
 
 		table.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
@@ -190,6 +217,19 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					selection2[i] = (IFileRevision) selection[i].getData();
 				}
 
+				// Updates the revision info text viewers
+				cleanRevisionInfoTextViewers();
+				if(selection2.length == 1) {
+					// if the table item is not visible in the UI and it's selected via keyboard
+					// this listener is called before the listener that sets the item data.
+					if(selection2[0] == null) {
+						int ix = table.getSelectionIndex();
+						GitFileRevision revision = (GitFileRevision) fileRevisions.get(ix);
+						selection2[0] = revision;
+					}
+					setRevisionInfoTextViewers(selection2[0]);
+				}
+
 				compareAction.setCurrentFileRevision(fileRevisions.get(0));
 				compareAction.selectionChanged(new StructuredSelection(
 						selection2));
@@ -286,9 +326,99 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		showAllFolderVersionsAction.setChecked(isShowAllFolderVersions());
 		getSite().getActionBars().getToolBarManager().add(
 				showAllFolderVersionsAction);
+
+		toggleCommentWrapAction = new Action(UIText.ResourceHistory_toggleCommentWrap) {
+			public void run() {
+				updateResourceHistoryComposites();
+				prefs.setValue(UIPreferences.RESOURCEHISTORY_SHOW_COMMENT_WRAP, toggleCommentWrapAction.isChecked());
+				Activator.getDefault().savePluginPreferences();
+			}
+		};
+		toggleCommentWrapAction.setChecked(prefs.getBoolean(UIPreferences.RESOURCEHISTORY_SHOW_COMMENT_WRAP));
+
+		toggleRevDetailAction = new Action(UIText.ResourceHistory_toggleRevDetail) {
+			public void run() {
+				updateResourceHistoryComposites();
+				prefs.setValue(UIPreferences.RESOURCEHISTORY_SHOW_REV_DETAIL, toggleRevDetailAction.isChecked());
+				Activator.getDefault().savePluginPreferences();
+			}
+		};
+		toggleRevDetailAction.setChecked(prefs.getBoolean(UIPreferences.RESOURCEHISTORY_SHOW_REV_DETAIL));
+
+		toggleRevCommentAction = new Action(UIText.ResourceHistory_toggleRevComment) {
+			public void run() {
+				updateResourceHistoryComposites();
+				prefs.setValue(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, toggleRevCommentAction.isChecked());
+				Activator.getDefault().savePluginPreferences();
+			}
+		};
+		toggleRevCommentAction.setChecked(prefs.getBoolean(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT));
+
+		toggleTooltipsAction = new Action(UIText.ResourceHistory_toggleTooltips) {
+			public void run() {
+				updateShowTooltips();
+				prefs.setValue(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, toggleTooltipsAction.isChecked());
+				Activator.getDefault().savePluginPreferences();
+			}
+		};
+		toggleTooltipsAction.setChecked(prefs.getBoolean(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS));
+
+		IActionBars actionBars = getSite().getActionBars();
+		IMenuManager menuManager = actionBars.getMenuManager();
+		if (menuManager != null) {
+			menuManager.add(toggleCommentWrapAction);
+			menuManager.add(new Separator());
+			menuManager.add(toggleRevDetailAction);
+			menuManager.add(toggleRevCommentAction);
+			menuManager.add(toggleTooltipsAction);
+			menuManager.add(new Separator());
+		}
+		actionBars.updateActionBars();
+		updateResourceHistoryComposites();
+		updateShowTooltips();
+
+		localComposite.setWeights(new int[] {65, 35});
+		revisionInfoComposite.setWeights(new int[] {40, 60});
+	}
+
+	/* private */void updateResourceHistoryComposites() {
+		boolean commentWrap = toggleCommentWrapAction.isChecked();
+		boolean showRevDetail = toggleRevDetailAction.isChecked();
+		boolean showRevComment = toggleRevCommentAction.isChecked();
+
+		revCommentTextViewer.getTextWidget().setWordWrap(commentWrap);
+
+		if(showRevDetail && showRevComment) {
+			localComposite.setMaximizedControl(null);
+			revisionInfoComposite.setMaximizedControl(null);
+		} else {
+			if(!(showRevDetail || showRevComment)) {
+				localComposite.setMaximizedControl(table);
+			} else if(showRevDetail) {
+				localComposite.setMaximizedControl(null);
+				revisionInfoComposite.setMaximizedControl(revDetailTextViewer.getControl());
+			} else {
+				localComposite.setMaximizedControl(null);
+				revisionInfoComposite.setMaximizedControl(revCommentTextViewer.getControl());
+			}
+		}
 	}
 
-	private boolean isShowAllRepoVersions() {
+	/* private */void updateShowTooltips() {
+		boolean showTooltip = toggleTooltipsAction.isChecked();
+
+		if(showTooltip) {
+			table.addMouseMoveListener(tableMouseMoveListener);
+		} else {
+			table.removeMouseMoveListener(tableMouseMoveListener);
+			// TODO: workaround for setToolTipText(null), it doesn't work on eclipse gtk.
+			// Robin suggested a javadoc F2 style tooltip to replace the current one,
+			// so if we move to the javadoc style tooltip, this problem may be irrelevant.
+			table.setToolTipText(null);
+		}
+	}
+
+	/* private */boolean isShowAllRepoVersions() {
 		return showAllRepoVersions;
 	}
 
@@ -298,7 +428,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				PREF_SHOWALLREPOVERSIONS, showAllRepoVersions);
 	}
 
-	private boolean isShowAllProjectVersions() {
+	/* private */boolean isShowAllProjectVersions() {
 		return showAllProjectVersions;
 	}
 
@@ -308,7 +438,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				PREF_SHOWALLPROJECTVERSIONS, showAllProjectVersions);
 	}
 
-	private boolean isShowAllFolderVersions() {
+	/* private */boolean isShowAllFolderVersions() {
 		return showAllFolderVersions;
 	}
 
@@ -398,7 +528,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				Date d = new Date(element.getTimestamp());
 				if (d.getTime() == -1)
 					return "";
-				return d.toString();
+				return DATETIME_FORMAT.format(d);
 			}
 			if (columnIndex == 4)
 				return element.getAuthor();
@@ -417,6 +547,166 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		}
 	}
 
+	private void createRevDetailTextViewer(SashForm composite) {
+		revDetailTextViewer = new TextViewer(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.READ_ONLY);
+	}
+
+	private void createRevCommentTextViewer(SashForm composite) {
+		revCommentTextViewer = new TextViewer(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.READ_ONLY);
+	}
+
+	/* private */void setRevisionInfoTextViewers(IFileRevision rev) {
+		StringBuilder revisionInfo = new StringBuilder();
+		if (appliedPatches != null) {
+			String id = rev.getContentIdentifier();
+			if (!id.equals("Workspace") && !id.equals("Index")) {
+				StGitPatch patch = (StGitPatch) appliedPatches
+						.get(new ObjectId(id));
+				if (patch != null) {
+					revisionInfo.append("Patch: ");
+					revisionInfo.append(patch.getName());
+				}
+			} else {
+				revisionInfo.append(id.toString());
+			}
+		}
+		if (revisionInfo.length() == 0) {
+			revisionInfo.append("Commit: ");
+			revisionInfo.append(rev.getContentIdentifier());
+		}
+
+		// Gets the tags for this revision.
+		// TODO: Understand this better and see if there's a simpler/shared way to do it.
+		IProject project = ((IResource) getInput()).getProject();
+		RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(project);
+		Map<ObjectId,Tag[]> newtags = new HashMap<ObjectId,Tag[]>();
+		try {
+			for (String name : repositoryMapping.getRepository().getTags()) {
+				Tag t = repositoryMapping.getRepository().mapTag(name);
+				Tag[] samecommit = newtags.get(t.getObjId());
+				if (samecommit==null) { 
+					samecommit = new Tag[] { t };
+				} else {
+					Tag[] n=new Tag[samecommit.length+1];
+					for (int j=0; j<samecommit.length; ++j)
+						n[j] = samecommit[j];
+					n[n.length-1] = t;
+					samecommit = n;
+				}
+				newtags.put(t.getObjId(), samecommit);
+			}
+
+			String id = rev.getContentIdentifier();
+			if (!id.equals("Workspace") && !id.equals("Index")) {
+				ObjectId oid = new ObjectId(id);
+				StringBuilder b=new StringBuilder();
+				if (tags != null) {
+					Tag[] matching = tags.get(oid);
+					if (matching != null) {
+						for (Tag t : matching) {
+							if (b.length() > 0)
+								b.append(", ");
+							String tag = t.getTag();
+							b.append(tag);
+						}
+					}
+				}
+				if(b.length() > 0) {
+					revisionInfo.append("\nTags: ");
+					revisionInfo.append(b);
+				}
+			}
+		} catch (IOException e) {
+			e.printStackTrace();
+		}
+
+		// Gets the branches for this revision.
+		// TODO: Branches should always show all the branches from a commit.
+		Map<ObjectId, String[]> newBranches = new HashMap<ObjectId, String[]>();
+		try {
+			for (String branch : repositoryMapping.getRepository().getBranches()) {
+				ObjectId id = repositoryMapping.getRepository().resolve(branch);
+				String[] samecommit = newBranches.get(id);
+				if (samecommit == null) {
+					samecommit = new String[] { branch };
+				} else {
+					String[] n=new String[samecommit.length + 1];
+					for (int j=0; j<samecommit.length; ++j)
+						n[j] = samecommit[j];
+					n[n.length-1] = branch;
+					samecommit = n;
+				}
+				newBranches.put(id, samecommit);
+			}
+			String[] samecommit = newBranches.get(currentHead);
+			if (samecommit == null) {
+				samecommit = new String[] { "HEAD" };
+			} else {
+				String[] n=new String[samecommit.length + 1];
+				for (int j=0; j<samecommit.length; ++j)
+					n[j] = samecommit[j];
+				n[n.length-1] = "HEAD";
+				samecommit = n;
+			}
+			newBranches.put(currentHead, samecommit);
+			branches = newBranches;
+
+			String id = rev.getContentIdentifier();
+			if (branches != null) {
+				StringBuilder b=new StringBuilder();
+				ObjectId oid = new ObjectId(id);
+				String[] matching = branches.get(oid);
+				if (matching != null) {
+					for (String t : matching) {
+						if (b.length() > 0)
+							b.append(", ");
+						if (t.startsWith("refs/heads/"))
+							t = t.substring(11);
+						b.append(t);
+					}
+				}
+				if(b.length() > 0) {
+					revisionInfo.append("\nBranches: ");
+					revisionInfo.append(b);
+				}
+			}
+		} catch (IOException e) {
+			e.printStackTrace();
+		}
+
+		revisionInfo.append("\nAuthor: ");
+		revisionInfo.append(rev.getAuthor());
+		revisionInfo.append("\nDate: ");
+		revisionInfo.append(DATETIMETZ_FORMAT.format(new Date(rev.getTimestamp())));
+
+		String comment = rev.getComment();
+		revDetailTextViewer.setDocument(new Document(revisionInfo.toString()));
+		revCommentTextViewer.setDocument(new Document(comment));
+
+		// Adds the first comment line in the status line.
+		int enterIndex = comment.indexOf("\n");
+		if(enterIndex > 0) {
+			comment = comment.substring(0, enterIndex);
+		}
+		IPageSite workbenchPageSite = getHistoryPageSite().getWorkbenchPageSite();
+		if (workbenchPageSite != null) {
+			workbenchPageSite.getActionBars().getStatusLineManager().setMessage(comment);
+		}
+	}
+
+	/* private */void cleanRevisionInfoTextViewers() {
+		if(revDetailTextViewer != null && revCommentTextViewer != null) {
+			revDetailTextViewer.setDocument(new Document(""));
+			revCommentTextViewer.setDocument(new Document(""));
+
+			// Cleans the status line
+			IPageSite workbenchPageSite = getHistoryPageSite().getWorkbenchPageSite();
+			if (workbenchPageSite != null) {
+				workbenchPageSite.getActionBars().getStatusLineManager().setMessage(null);
+			}
+		}
+	}
+
 	private void createTable(Composite composite) {
 		table = new Table(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.MULTI
 				| SWT.FULL_SELECTION | SWT.VIRTUAL);
@@ -562,10 +852,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		viewer.setInput(getInput());
 	}
 
-	private Map appliedPatches;
+	/* private */Map appliedPatches;
 	ObjectId currentHead;
-	private Map<ObjectId,Tag[]> tags;
-	private Map<ObjectId, String[]> branches;
+	/* private */Map<ObjectId,Tag[]> tags;
+	/* private */Map<ObjectId, String[]> branches;
 	GitHistoryLabelProvider lp = new GitHistoryLabelProvider();
 
 	class HistoryRefreshJob extends Job {
@@ -668,6 +958,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				table.getDisplay().asyncExec(new Runnable() {
 				
 					public void run() {
+						cleanRevisionInfoTextViewers();
+
 						table.removeAll();
 						table.setItemCount(fileRevisions.size());
 						table.setData("X");
@@ -726,6 +1018,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		}
 
 		public void dispose() {
+			return;
 		}
 
 		public void updateElement(int index) {
@@ -763,7 +1056,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		col.setResizable(true);
 		col.setText(TeamUIMessages.GenericHistoryTableProvider_RevisionTime);
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) table.getLayout()).addColumnData(new ColumnWeightData(30,
+		((TableLayout) table.getLayout()).addColumnData(new ColumnWeightData(20,
 				true));
 
 		// author
@@ -779,7 +1072,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		col.setResizable(true);
 		col.setText(TeamUIMessages.GenericHistoryTableProvider_Comment);
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) table.getLayout()).addColumnData(new ColumnWeightData(35,
+		((TableLayout) table.getLayout()).addColumnData(new ColumnWeightData(45,
 				true));
 	}
 
@@ -859,7 +1152,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		// example
 		String niceComment = unwrapComment(rev.getComment());
 		String toolTipText = commitStr + "\nAuthor: " + rev.getAuthor()
-				+ "\nDate: " + new Date(rev.getTimestamp()) + "\n\n"
+				+ "\nDate: " + DATETIMETZ_FORMAT.format(new Date(rev.getTimestamp())) + "\n\n"
 				+ niceComment;
 		return toolTipText;
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
new file mode 100644
index 0000000..ab89bec
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
@@ -0,0 +1,46 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares <rogersoares@intelinet.com.br>
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
+package org.spearce.egit.ui;
+
+import org.eclipse.core.runtime.Preferences;
+import org.eclipse.core.runtime.preferences.AbstractPreferenceInitializer;
+
+/**
+ * Plugin extension point to initialize the plugin runtime preferences.
+ */
+public class PluginPreferenceInitializer extends AbstractPreferenceInitializer {
+
+	/**
+	 * Calls super constructor.
+	 */
+	public PluginPreferenceInitializer() {
+		super();
+	}
+
+	/**
+	 * This method initializes the plugin preferences with default values.
+	 */
+	public void initializeDefaultPreferences() {
+		Preferences prefs = Activator.getDefault().getPluginPreferences();
+
+		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_COMMENT_WRAP, true);
+		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_DETAIL, true);
+		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, true);
+		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false);
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
new file mode 100644
index 0000000..900023a
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -0,0 +1,32 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares <rogersoares@intelinet.com.br>
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
+package org.spearce.egit.ui;
+
+/**
+ * Preferences used by the plugin.
+ * All plugin preferences shall be referenced by a constant in this class.
+ */
+public class UIPreferences {
+	/** */
+	public final static String RESOURCEHISTORY_SHOW_COMMENT_WRAP = "resourcehistory_show_comment_wrap";
+	/** */
+	public final static String RESOURCEHISTORY_SHOW_REV_DETAIL = "resourcehistory_show_rev_detail";
+	/** */
+	public final static String RESOURCEHISTORY_SHOW_REV_COMMENT = "resourcehistory_show_rev_comment";
+	/** */
+	public final static String RESOURCEHISTORY_SHOW_TOOLTIPS = "resourcehistory_show_tooltips";
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index b6c7a28..1454124 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -53,6 +53,15 @@ public class UIText extends NLS {
 	/** */
 	public static String QuickDiff_failedLoading;
 
+	/** */
+	public static String ResourceHistory_toggleCommentWrap;
+	/** */
+	public static String ResourceHistory_toggleRevDetail;
+	/** */
+	public static String ResourceHistory_toggleRevComment;
+	/** */
+	public static String ResourceHistory_toggleTooltips;
+
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
 				UIText.class);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 75e975b..be02978 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -28,3 +28,8 @@ ExistingOrNewPage_createNew=Create a new Git repository for this project
 
 Decorator_failedLazyLoading=Resource decorator failed to load tree contents on demand.
 QuickDiff_failedLoading=Quick diff failed to obtain file data.
+
+ResourceHistory_toggleCommentWrap=Wrap Comments
+ResourceHistory_toggleRevDetail=Show Revision Details
+ResourceHistory_toggleRevComment=Show Revision Comment
+ResourceHistory_toggleTooltips=Show Revision Tooltip
-- 
1.5.3.7
