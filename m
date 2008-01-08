From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Showing commit info like the CVS plugin instead of tooltips.
Date: Mon, 7 Jan 2008 23:20:26 -0200
Organization: Intelinet
Message-ID: <200801072320.26987.rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 02:20:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC38U-0000ES-Ob
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 02:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951AbYAHBTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 20:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757642AbYAHBTc
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 20:19:32 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1107 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754093AbYAHBTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 20:19:30 -0500
Received: (qmail 68531 invoked by uid 0); 7 Jan 2008 23:21:56 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.042502 secs); 08 Jan 2008 01:21:56 -0000
Received: from unknown (HELO ?192.168.1.100?) (189.5.206.233)
  by cvxbsd.convex.com.br with SMTP; 8 Jan 2008 01:21:56 -0000
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69833>

Tooltips for the info were annoying, especially on MacOS where the tooltip center is your pointer location.
It is now possible to copy&paste data.
Like the CVS plugin, there's a menu to show/hide views. Thought it doesn't save in the preferences store for now.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |  361 +++++++++++++++-----
 .../src/org/spearce/egit/ui/UIText.java            |    4 +
 .../src/org/spearce/egit/ui/uitext.properties      |    4 +
 3 files changed, 277 insertions(+), 92 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 3738dfd..ae404cf 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -17,6 +17,7 @@
 package org.spearce.egit.ui;
 
 import java.io.IOException;
+import java.text.SimpleDateFormat;
 import java.util.Date;
 import java.util.HashMap;
 import java.util.List;
@@ -37,10 +38,14 @@ import org.eclipse.core.runtime.IStatus;
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
@@ -48,12 +53,11 @@ import org.eclipse.jface.viewers.TableLayout;
 import org.eclipse.jface.viewers.TableViewer;
 import org.eclipse.jface.viewers.Viewer;
 import org.eclipse.swt.SWT;
+import org.eclipse.swt.custom.SashForm;
 import org.eclipse.swt.events.MouseEvent;
 import org.eclipse.swt.events.MouseListener;
-import org.eclipse.swt.events.MouseMoveListener;
 import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
-import org.eclipse.swt.graphics.Point;
 import org.eclipse.swt.layout.GridData;
 import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.widgets.Composite;
@@ -72,6 +76,8 @@ import org.eclipse.team.internal.ui.history.DialogHistoryPageSite;
 import org.eclipse.team.ui.history.HistoryPage;
 import org.eclipse.team.ui.history.IHistoryCompareAdapter;
 import org.eclipse.team.ui.history.IHistoryPageSite;
+import org.eclipse.ui.IActionBars;
+import org.eclipse.ui.part.IPageSite;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.internal.mapping.GitCommitFileRevision;
 import org.spearce.egit.core.internal.mapping.GitFileHistory;
@@ -92,16 +98,24 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	private static final String PREF_SHOWALLREPOVERSIONS = "org.spearce.egit.ui.githistorypage.showallrepoversions";
 	private static final String PREF_SHOWALLPROJECTVERSIONS = "org.spearce.egit.ui.githistorypage.showallprojectversions";
 	private static final String PREF_SHOWALLFOLDERVERSIONS = "org.spearce.egit.ui.githistorypage.showallfolderversions";
+	/* private */static final SimpleDateFormat DATETIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");
+	/* private */static final SimpleDateFormat DATETIMETZ_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z");
 
-	private Composite localComposite;
+	private SashForm localComposite;
+	private SashForm revisionInfoComposite;
 
-	private TableViewer viewer;
+	/* private */TableViewer viewer;
+	/* private */TextViewer revDetailTextViewer;
+	/* private */TextViewer revCommentTextViewer;
+	/* private */IAction toggleCommentWrapAction;
+	/* private */IAction toggleRevDetailAction;
+	/* private */IAction toggleRevCommentAction;
 
-	private Table table;
+	/* private */Table table;
 
-	private List<IFileRevision> fileRevisions;
+	/* private */List<IFileRevision> fileRevisions;
 
-	protected boolean hintShowDiffNow;
+	/* private */boolean hintShowDiffNow;
 
 	private boolean showAllProjectVersions;
 
@@ -127,7 +141,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	}
 
 	public void createControl(Composite parent) {
-		localComposite = new Composite(parent, SWT.NONE);
+		localComposite = new SashForm(parent, SWT.VERTICAL);
+
 		GridLayout layout = new GridLayout();
 		layout.marginHeight = 0;
 		layout.marginWidth = 0;
@@ -138,6 +153,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 		createTable(localComposite);
 
+		revisionInfoComposite = new SashForm(localComposite, SWT.HORIZONTAL);
+		createRevDetailTextViewer(revisionInfoComposite);
+		createRevCommentTextViewer(revisionInfoComposite);
+
 		IHistoryPageSite parentSite = getHistoryPageSite();
 		if (parentSite != null && parentSite instanceof DialogHistoryPageSite)
 			parentSite.setSelectionProvider(viewer);
@@ -149,6 +168,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		table.addMouseListener(new MouseListener() {
 		
 			public void mouseUp(MouseEvent e) {
+				return;
 			}
 		
 			public void mouseDown(MouseEvent e) {
@@ -156,25 +176,11 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 			}
 		
 			public void mouseDoubleClick(MouseEvent e) {
+				return;
 			}
 		
 		});
 
-		table.addMouseMoveListener(new MouseMoveListener() {
-			TableItem lastItem;
-			public void mouseMove(MouseEvent e) {
-				TableItem item = table.getItem(new Point(e.x,e.y));
-				if (item != null && item!=lastItem) {
-					IFileRevision rev = (IFileRevision) item.getData();
-					if (rev == null)
-						return;
-					String toolTipText = formatRevisionToolTipText(rev);
-					table.setToolTipText(toolTipText);
-				}
-				lastItem = item;
-			}
-		});
-
 		table.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
 				// update the current
@@ -184,6 +190,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					selection2[i] = (IFileRevision) selection[i].getData();
 				}
 
+				// Updates the revision info text viewers
+				cleanRevisionInfoTextViewers();
+				if(selection2.length == 1) {
+					setRevisionInfoTextViewers(selection2[0]);
+				}
+
 				compareAction.setCurrentFileRevision(fileRevisions.get(0));
 				compareAction.selectionChanged(new StructuredSelection(
 						selection2));
@@ -280,33 +292,92 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		showAllFolderVersionsAction.setChecked(isShowAllFolderVersions());
 		getSite().getActionBars().getToolBarManager().add(
 				showAllFolderVersionsAction);
+
+		toggleCommentWrapAction = new Action(UIText.ResourceHistory_toggleCommentWrap) {
+			public void run() {
+				updateResourceHistoryComposites();
+			}
+		};
+		toggleCommentWrapAction.setChecked(true);
+
+		toggleRevDetailAction = new Action(UIText.ResourceHistory_toggleRevDetail) {
+			public void run() {
+				updateResourceHistoryComposites();
+			}
+		};
+		toggleRevDetailAction.setChecked(true);
+
+		toggleRevCommentAction = new Action(UIText.ResourceHistory_toggleRevComment) {
+			public void run() {
+				updateResourceHistoryComposites();
+			}
+		};
+		toggleRevCommentAction.setChecked(true);
+
+		IActionBars actionBars = getSite().getActionBars();
+		IMenuManager menuManager = actionBars.getMenuManager();
+		if (menuManager != null) {
+			menuManager.add(toggleCommentWrapAction);
+			menuManager.add(new Separator());
+			menuManager.add(toggleRevDetailAction);
+			menuManager.add(toggleRevCommentAction);
+			menuManager.add(new Separator());
+		}
+		actionBars.updateActionBars();
+		updateResourceHistoryComposites();
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
+	/* private */boolean isShowAllRepoVersions() {
 		return showAllRepoVersions;
 	}
 
-	protected void setShowAllRepoVersions(boolean showAllRepoVersions) {
+	/* private */void setShowAllRepoVersions(boolean showAllRepoVersions) {
 		this.showAllRepoVersions = showAllRepoVersions;
 		Activator.getDefault().getPreferenceStore().setValue(
 				PREF_SHOWALLREPOVERSIONS, showAllRepoVersions);
 	}
 
-	private boolean isShowAllProjectVersions() {
+	/* private */boolean isShowAllProjectVersions() {
 		return showAllProjectVersions;
 	}
 
-	protected void setShowAllProjectVersions(boolean showAllProjectVersions) {
+	/* private */void setShowAllProjectVersions(boolean showAllProjectVersions) {
 		this.showAllProjectVersions = showAllProjectVersions;
 		Activator.getDefault().getPreferenceStore().setValue(
 				PREF_SHOWALLPROJECTVERSIONS, showAllProjectVersions);
 	}
 
-	private boolean isShowAllFolderVersions() {
+	/* private */boolean isShowAllFolderVersions() {
 		return showAllFolderVersions;
 	}
 
-	protected void setShowAllFolderVersion(boolean showAllFolderVersions) {
+	/* private */void setShowAllFolderVersion(boolean showAllFolderVersions) {
 		this.showAllFolderVersions = showAllFolderVersions;
 		Activator.getDefault().getPreferenceStore().setValue(
 				PREF_SHOWALLFOLDERVERSIONS, showAllFolderVersions);
@@ -392,7 +463,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				Date d = new Date(element.getTimestamp());
 				if (d.getTime() == -1)
 					return "";
-				return d.toString();
+				return DATETIME_FORMAT.format(d);
 			}
 			if (columnIndex == 4)
 				return element.getAuthor();
@@ -411,6 +482,166 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
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
@@ -556,10 +787,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
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
@@ -662,6 +893,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				table.getDisplay().asyncExec(new Runnable() {
 				
 					public void run() {
+						cleanRevisionInfoTextViewers();
+
 						table.removeAll();
 						table.setItemCount(fileRevisions.size());
 						table.setData("X");
@@ -720,6 +953,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		}
 
 		public void dispose() {
+			return;
 		}
 
 		public void updateElement(int index) {
@@ -757,7 +991,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		col.setResizable(true);
 		col.setText(TeamUIMessages.GenericHistoryTableProvider_RevisionTime);
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) table.getLayout()).addColumnData(new ColumnWeightData(30,
+		((TableLayout) table.getLayout()).addColumnData(new ColumnWeightData(20,
 				true));
 
 		// author
@@ -773,7 +1007,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		col.setResizable(true);
 		col.setText(TeamUIMessages.GenericHistoryTableProvider_Comment);
 		// X col.addSelectionListener(headerListener);
-		((TableLayout) table.getLayout()).addColumnData(new ColumnWeightData(35,
+		((TableLayout) table.getLayout()).addColumnData(new ColumnWeightData(45,
 				true));
 	}
 
@@ -821,61 +1055,4 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		// TODO Auto-generated method stub
 	}
 
-	/**
-	 * Formats the revision description to be displayed in the tooltip.
-	 *
-	 * @param rev
-	 *            the revision to be displayed
-	 * @return formatted description
-	 */
-	protected String formatRevisionToolTipText(IFileRevision rev) {
-		String commitStr = null;
-		if (appliedPatches != null) {
-			String id = rev.getContentIdentifier();
-			if (!id.equals("Workspace") && !id.equals("Index")) {
-				StGitPatch patch = (StGitPatch) appliedPatches
-						.get(new ObjectId(id));
-				if (patch != null)
-					commitStr = "Patch: " + patch.getName();
-			} else {
-				commitStr = id.toString();
-			}
-		}
-		if (commitStr == null)
-			commitStr = "Commit: " + rev.getContentIdentifier();
-
-		// The tooltip window is usually
-		// narrower
-		// than the comment. Remove soft returns
-		// to
-		// avoid short lines like in
-		// this
-		// example
-		String niceComment = unwrapComment(rev.getComment());
-		String toolTipText = commitStr + "\nAuthor: " + rev.getAuthor()
-				+ "\nDate: " + new Date(rev.getTimestamp()) + "\n\n"
-				+ niceComment;
-		return toolTipText;
-	}
-
-	/**
-	 * Remove soft returns (single \n) from the string. Keep hard returns
-	 * between paragraphs (two \n).
-	 *
-	 * @param origComment
-	 * @return reformated comment
-	 */
-	private static String unwrapComment(String origComment) {
-		if (origComment == null)
-			return null;
-		String paragraphs[] = origComment.split("\n\\s*\n");
-		StringBuffer result = new StringBuffer();
-		for (int i = 0; i < paragraphs.length; i++) {
-			result.append(paragraphs[i].replaceAll("\n", " "));
-			if (i < paragraphs.length - 1)
-				result.append("\n\n");
-		}
-		return result.toString();
-	}
-
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index cdbe8bb..b714c1d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -39,6 +39,10 @@ public class UIText extends NLS {
 
 	public static String QuickDiff_failedLoading;
 
+	public static String ResourceHistory_toggleCommentWrap;
+	public static String ResourceHistory_toggleRevDetail;
+	public static String ResourceHistory_toggleRevComment;
+
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
 				UIText.class);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 75e975b..f45f4d2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -28,3 +28,7 @@ ExistingOrNewPage_createNew=Create a new Git repository for this project
 
 Decorator_failedLazyLoading=Resource decorator failed to load tree contents on demand.
 QuickDiff_failedLoading=Quick diff failed to obtain file data.
+
+ResourceHistory_toggleCommentWrap=Wrap Comments
+ResourceHistory_toggleRevDetail=Show Revision Details
+ResourceHistory_toggleRevComment=Show Revision Comment
\ No newline at end of file
-- 
1.5.3.7
