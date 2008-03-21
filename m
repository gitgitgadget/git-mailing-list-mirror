From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 3/4] Show all branches and children in the revision detail viewer.
Date: Fri, 21 Mar 2008 18:08:09 -0400
Message-ID: <1206137289-4076-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 22:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcoV7-0007iP-4v
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 22:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbYCUVJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbYCUVJM
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 17:09:12 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1293 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756910AbYCUVJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 17:09:09 -0400
Received: (qmail 92174 invoked by uid 0); 21 Mar 2008 18:11:46 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 3.021823 secs); 21 Mar 2008 21:11:46 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.226.196)
  by cvxbsd.convex.com.br with SMTP; 21 Mar 2008 21:11:43 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77768>

Shows all branches containg the selected commit along with its children in
the revision detail viewer. The lines where reordered to match the same
as in gitk.

The revision info code has moved to it's own class and uses a background
thread similiar to the find toolbar to display data that may take a while
to be retrieved.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |  248 ++-----------------
 .../src/org/spearce/egit/ui/RevisionInfo.java      |  269 ++++++++++++++++++++
 .../org/spearce/egit/ui/RevisionInfoThread.java    |  212 +++++++++++++++
 3 files changed, 500 insertions(+), 229 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfo.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfoThread.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index ae1dfbf..5da095b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -46,8 +46,6 @@ import org.eclipse.jface.action.IMenuManager;
 import org.eclipse.jface.action.MenuManager;
 import org.eclipse.jface.action.Separator;
 import org.eclipse.jface.resource.JFaceResources;
-import org.eclipse.jface.text.Document;
-import org.eclipse.jface.text.TextViewer;
 import org.eclipse.jface.viewers.ColumnWeightData;
 import org.eclipse.jface.viewers.ILazyContentProvider;
 import org.eclipse.jface.viewers.StructuredSelection;
@@ -83,7 +81,6 @@ import org.eclipse.team.ui.history.HistoryPage;
 import org.eclipse.team.ui.history.IHistoryCompareAdapter;
 import org.eclipse.team.ui.history.IHistoryPageSite;
 import org.eclipse.ui.IActionBars;
-import org.eclipse.ui.part.IPageSite;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.internal.mapping.GitCommitFileRevision;
 import org.spearce.egit.core.internal.mapping.GitFileHistory;
@@ -91,9 +88,7 @@ import org.spearce.egit.core.internal.mapping.GitFileHistoryProvider;
 import org.spearce.egit.core.internal.mapping.GitFileRevision;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.internal.actions.GitCompareRevisionAction;
-import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
-import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.lib.TopologicalSorter;
 import org.spearce.jgit.lib.Repository.StGitPatch;
@@ -118,14 +113,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 	private Composite parentComposite;
 	private SashForm localComposite;
-	private SashForm revisionInfoComposite;
+	private RevisionInfo revisionInfoComposite;
 	/* private */FindToolbar findToolbar;
 
 	/* private */Preferences prefs = Activator.getDefault().getPluginPreferences();
 
 	/* private */TableViewer viewer;
-	/* private */TextViewer revDetailTextViewer;
-	/* private */TextViewer revCommentTextViewer;
 	/* private */IAction toggleCommentWrapAction;
 	/* private */IAction toggleRevDetailAction;
 	/* private */IAction toggleRevCommentAction;
@@ -164,6 +157,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	public boolean inputSet() {
 		if (viewer != null)
 			viewer.setInput(getInput());
+		if (revisionInfoComposite != null) {
+			IProject project = ((IResource) getInput()).getProject();
+			revisionInfoComposite.setRepositoryMapping(RepositoryMapping.getMapping(project));
+		}
 		// TODO Auto-generated method stub
 		return true;
 	}
@@ -189,20 +186,20 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		findToolbar = new FindToolbar(parentComposite);
 		findToolbar.addSelectionListener(new Listener() {
 			public void handleEvent(Event event) {
-				cleanRevisionInfoTextViewers();
+				revisionInfoComposite.cleanRevisionInfoTextViewers();
 				int ix = table.getSelectionIndex();
 				IFileRevision revision = fileRevisions.get(ix);
 				if(revision instanceof GitCommitFileRevision) {
-					setRevisionInfoTextViewers((GitCommitFileRevision) revision);
+					revisionInfoComposite.setRevisionInfoTextViewers((GitCommitFileRevision) revision);
 				}
 			}
 		});
 
 		createTable(localComposite);
 
-		revisionInfoComposite = new SashForm(localComposite, SWT.HORIZONTAL);
-		createRevDetailTextViewer(revisionInfoComposite);
-		createRevCommentTextViewer(revisionInfoComposite);
+		IProject project = ((IResource) getInput()).getProject();
+		RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(project);
+		revisionInfoComposite = new RevisionInfo(localComposite, getHistoryPageSite().getWorkbenchPageSite(), repositoryMapping);
 
 		IHistoryPageSite parentSite = getHistoryPageSite();
 		if (parentSite != null && parentSite instanceof DialogHistoryPageSite)
@@ -245,7 +242,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				}
 
 				// Updates the revision info text viewers
-				cleanRevisionInfoTextViewers();
+				revisionInfoComposite.cleanRevisionInfoTextViewers();
 				if(selection2.length == 1) {
 					// if the table item is not visible in the UI and it's selected via keyboard
 					// this listener is called before the listener that sets the item data.
@@ -255,7 +252,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 						revision = fileRevisions.get(ix);
 						selection2[0] = revision;
 					}
-					setRevisionInfoTextViewers((GitCommitFileRevision)revision);
+					revisionInfoComposite.setRevisionInfoTextViewers((GitCommitFileRevision)revision);
 				}
 
 				compareAction.setCurrentFileRevision(fileRevisions.get(0));
@@ -419,7 +416,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		showHideFindToolbar();
 
 		localComposite.setWeights(new int[] {65, 35});
-		revisionInfoComposite.setWeights(new int[] {40, 60});
+		revisionInfoComposite.setWeights(new int[] {50, 50});
 	}
 
 	/* private */void updateResourceHistoryComposites() {
@@ -427,22 +424,14 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		boolean showRevDetail = toggleRevDetailAction.isChecked();
 		boolean showRevComment = toggleRevCommentAction.isChecked();
 
-		revCommentTextViewer.getTextWidget().setWordWrap(commentWrap);
+		revisionInfoComposite.setCommentWordWrap(commentWrap);
 
-		if(showRevDetail && showRevComment) {
-			localComposite.setMaximizedControl(null);
-			revisionInfoComposite.setMaximizedControl(null);
+		if(!(showRevDetail || showRevComment)) {
+			localComposite.setMaximizedControl(table);
 		} else {
-			if(!(showRevDetail || showRevComment)) {
-				localComposite.setMaximizedControl(table);
-			} else if(showRevDetail) {
-				localComposite.setMaximizedControl(null);
-				revisionInfoComposite.setMaximizedControl(revDetailTextViewer.getControl());
-			} else {
-				localComposite.setMaximizedControl(null);
-				revisionInfoComposite.setMaximizedControl(revCommentTextViewer.getControl());
-			}
+			localComposite.setMaximizedControl(null);
 		}
+		revisionInfoComposite.setShowViewers(showRevDetail, showRevComment);
 	}
 
 	/* private */void updateShowTooltips() {
@@ -600,205 +589,6 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		}
 	}
 
-	private void createRevDetailTextViewer(SashForm composite) {
-		revDetailTextViewer = new TextViewer(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.READ_ONLY);
-	}
-
-	private void createRevCommentTextViewer(SashForm composite) {
-		revCommentTextViewer = new TextViewer(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.READ_ONLY);
-	}
-
-	/* private */void setRevisionInfoTextViewers(GitCommitFileRevision rev) {
-		StringBuilder revisionInfo = new StringBuilder();
-		if (appliedPatches != null) {
-			String id = rev.getContentIdentifier();
-			if (!id.equals("Workspace") && !id.equals("Index")) {
-				StGitPatch patch = (StGitPatch) appliedPatches
-						.get(new ObjectId(id));
-				if (patch != null) {
-					revisionInfo.append("Patch: ");
-					revisionInfo.append(patch.getName());
-				}
-			} else {
-				revisionInfo.append(id.toString());
-			}
-		}
-		if (revisionInfo.length() == 0) {
-			revisionInfo.append("Commit: ");
-			revisionInfo.append(rev.getContentIdentifier());
-		}
-
-		// Gets the tags for this revision.
-		// TODO: Understand this better and see if there's a simpler/shared way to do it.
-		IProject project = ((IResource) getInput()).getProject();
-		RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(project);
-		Map<ObjectId,Tag[]> newtags = new HashMap<ObjectId,Tag[]>();
-		try {
-			for (String name : repositoryMapping.getRepository().getTags()) {
-				Tag t = repositoryMapping.getRepository().mapTag(name);
-				Tag[] samecommit = newtags.get(t.getObjId());
-				if (samecommit==null) {
-					samecommit = new Tag[] { t };
-				} else {
-					Tag[] n=new Tag[samecommit.length+1];
-					for (int j=0; j<samecommit.length; ++j)
-						n[j] = samecommit[j];
-					n[n.length-1] = t;
-					samecommit = n;
-				}
-				newtags.put(t.getObjId(), samecommit);
-			}
-
-			String id = rev.getContentIdentifier();
-			if (!id.equals("Workspace") && !id.equals("Index")) {
-				ObjectId oid = new ObjectId(id);
-				StringBuilder b=new StringBuilder();
-				if (tags != null) {
-					Tag[] matching = tags.get(oid);
-					if (matching != null) {
-						for (Tag t : matching) {
-							if (b.length() > 0)
-								b.append(", ");
-							String tag = t.getTag();
-							b.append(tag);
-						}
-					}
-				}
-				if(b.length() > 0) {
-					revisionInfo.append("\nTags: ");
-					revisionInfo.append(b);
-				}
-			}
-		} catch (IOException e) {
-			// TODO: better error handling.
-			e.printStackTrace();
-		}
-
-		// Gets the branches for this revision.
-		// TODO: Branches should always show all the branches from a commit.
-		Map<ObjectId, String[]> newBranches = new HashMap<ObjectId, String[]>();
-		try {
-			for (String branch : repositoryMapping.getRepository().getBranches()) {
-				ObjectId id = repositoryMapping.getRepository().resolve(branch);
-				String[] samecommit = newBranches.get(id);
-				if (samecommit == null) {
-					samecommit = new String[] { branch };
-				} else {
-					String[] n=new String[samecommit.length + 1];
-					for (int j=0; j<samecommit.length; ++j)
-						n[j] = samecommit[j];
-					n[n.length-1] = branch;
-					samecommit = n;
-				}
-				newBranches.put(id, samecommit);
-			}
-			String[] samecommit = newBranches.get(currentHead);
-			if (samecommit == null) {
-				samecommit = new String[] { "HEAD" };
-			} else {
-				String[] n=new String[samecommit.length + 1];
-				for (int j=0; j<samecommit.length; ++j)
-					n[j] = samecommit[j];
-				n[n.length-1] = "HEAD";
-				samecommit = n;
-			}
-			newBranches.put(currentHead, samecommit);
-			branches = newBranches;
-
-			String id = rev.getContentIdentifier();
-			if (branches != null) {
-				StringBuilder b=new StringBuilder();
-				ObjectId oid = new ObjectId(id);
-				String[] matching = branches.get(oid);
-				if (matching != null) {
-					for (String t : matching) {
-						if (b.length() > 0)
-							b.append(", ");
-						if (t.startsWith("refs/heads/"))
-							t = t.substring(11);
-						b.append(t);
-					}
-				}
-				if(b.length() > 0) {
-					revisionInfo.append("\nBranches: ");
-					revisionInfo.append(b);
-				}
-			}
-		} catch (IOException e) {
-			e.printStackTrace();
-		}
-
-		Commit commit = rev.getCommit();
-		revisionInfo.append("\nAuthor: ");
-		revisionInfo.append(formatPersonIdentForRevInfo(commit.getAuthor()));
-		revisionInfo.append("\nCommitter: ");
-		revisionInfo.append(formatPersonIdentForRevInfo(commit.getCommitter()));
-		if(commit.getParentIds() != null) {
-			for(ObjectId pid : commit.getParentIds()) {
-				revisionInfo.append("\nParent: ");
-				revisionInfo.append(pid.toString());
-				try {
-					Commit pc = repositoryMapping.getRepository().mapCommit(pid);
-					revisionInfo.append(" (");
-					String cmesg = pc.getMessage();
-					int enterIndex = cmesg.indexOf("\n");
-					if(enterIndex > 0) {
-						cmesg = cmesg.substring(0, enterIndex);
-					}
-					revisionInfo.append(cmesg);
-					revisionInfo.append(" )");
-				} catch (IOException e) {
-					// TODO: better error handling.
-					e.printStackTrace();
-				}
-			}
-		}
-
-		String comment = rev.getComment();
-		revDetailTextViewer.setDocument(new Document(revisionInfo.toString()));
-		revCommentTextViewer.setDocument(new Document(comment));
-
-		// Adds the first comment line in the status line.
-		int enterIndex = comment.indexOf("\n");
-		if(enterIndex > 0) {
-			comment = comment.substring(0, enterIndex);
-		}
-		IPageSite workbenchPageSite = getHistoryPageSite().getWorkbenchPageSite();
-		if (workbenchPageSite != null) {
-			workbenchPageSite.getActionBars().getStatusLineManager().setMessage(comment);
-		}
-
-	}
-
-	private String formatPersonIdentForRevInfo(PersonIdent p) {
-		StringBuilder sb = new StringBuilder();
-		sb.append(p.getName());
-		if(p.getEmailAddress() != null) {
-			sb.append(" <");
-			sb.append(p.getEmailAddress());
-			sb.append(">");
-		}
-		if(p.getWhen() != null) {
-			sb.append(" ");
-			sb.append(DATETIMETZ_FORMAT.format(p.getWhen()));
-		}
-
-		return sb.toString();
-	}
-
-	void cleanRevisionInfoTextViewers() {
-		if(revDetailTextViewer != null && revCommentTextViewer != null) {
-			revDetailTextViewer.setDocument(new Document(""));
-			revCommentTextViewer.setDocument(new Document(""));
-
-			// Cleans the status line
-			IPageSite workbenchPageSite = getHistoryPageSite().getWorkbenchPageSite();
-			if (workbenchPageSite != null) {
-				workbenchPageSite.getActionBars().getStatusLineManager().setMessage(null);
-			}
-		}
-	}
-
 	private void createTable(Composite composite) {
 		table = new Table(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.MULTI
 				| SWT.FULL_SELECTION | SWT.VIRTUAL);
@@ -1067,7 +857,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				table.getDisplay().asyncExec(new Runnable() {
 				
 					public void run() {
-						cleanRevisionInfoTextViewers();
+						revisionInfoComposite.cleanRevisionInfoTextViewers();
 
 						table.removeAll();
 						table.setItemCount(fileRevisions.size());
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfo.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfo.java
new file mode 100644
index 0000000..1104158
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfo.java
@@ -0,0 +1,269 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares
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
+import java.text.SimpleDateFormat;
+import java.util.Set;
+
+import org.eclipse.jface.text.Document;
+import org.eclipse.jface.text.TextViewer;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.custom.SashForm;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.ui.part.IPageSite;
+import org.spearce.egit.core.internal.mapping.GitCommitFileRevision;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.core.util.RepositoryUtil;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PersonIdent;
+
+/**
+ * A revision viewer for the history page.
+ * 
+ * @see RevisionInfoThread
+ */
+public class RevisionInfo extends SashForm {
+
+	private static final SimpleDateFormat DATETIMETZ_FORMAT = new SimpleDateFormat(
+			"yyyy-MM-dd HH:mm:ss z");
+
+	private IPageSite workbenchPageSite;
+
+	private RepositoryMapping repositoryMapping;
+
+	private TextViewer revDetailTextViewer;
+
+	private TextViewer revCommentTextViewer;
+
+	private boolean showDetail;
+
+	private boolean showComment;
+
+	/**
+	 * Creates the viewer.
+	 * 
+	 * @param parent
+	 *            the parent widget
+	 * @param workbenchPageSite
+	 *            the workbench site
+	 * @param repositoryMapping
+	 *            the mapping containing the repository to be searched
+	 */
+	public RevisionInfo(Composite parent, IPageSite workbenchPageSite,
+			RepositoryMapping repositoryMapping) {
+		super(parent, SWT.HORIZONTAL);
+
+		this.workbenchPageSite = workbenchPageSite;
+		this.repositoryMapping = repositoryMapping;
+		revDetailTextViewer = new TextViewer(this, SWT.H_SCROLL | SWT.V_SCROLL
+				| SWT.READ_ONLY);
+		revCommentTextViewer = new TextViewer(this, SWT.H_SCROLL | SWT.V_SCROLL
+				| SWT.READ_ONLY);
+
+		setWeights(new int[] { 50, 50 });
+	}
+
+	/**
+	 * Sets word wrapping in the comment viewer.
+	 * 
+	 * @param wrap
+	 *            true enables wrap; false disables
+	 */
+	public void setCommentWordWrap(boolean wrap) {
+		revCommentTextViewer.getTextWidget().setWordWrap(wrap);
+	}
+
+	/**
+	 * Updates the viewers and the status line to show information for
+	 * <code>rev</code>.
+	 * 
+	 * @param rev
+	 */
+	public void setRevisionInfoTextViewers(GitCommitFileRevision rev) {
+		StringBuilder initialStaticInfo = new StringBuilder();
+		Commit commit = rev.getCommit();
+
+		if (showDetail) {
+			try {
+				// Commit line.
+				initialStaticInfo.append("Commit: ");
+				initialStaticInfo.append(rev.getContentIdentifier());
+				initialStaticInfo.append("\n");
+
+				// Author line.
+				initialStaticInfo.append("Author: ");
+				initialStaticInfo.append(formatPersonIdentForRevInfo(commit
+						.getAuthor()));
+				initialStaticInfo.append("\n");
+
+				// Committer line.
+				initialStaticInfo.append("Committer: ");
+				initialStaticInfo.append(formatPersonIdentForRevInfo(commit
+						.getCommitter()));
+				initialStaticInfo.append("\n");
+
+				RepositoryUtil repoUtil = new RepositoryUtil(repositoryMapping
+						.getRepository());
+
+				// Tags line.
+				Set<String> commitTags = repoUtil.getTagNamesForCommit(commit);
+				int count = 0;
+				if (commitTags != null) {
+					initialStaticInfo.append("Tags: ");
+					for (String tagName : commitTags) {
+						if (count != 0) {
+							initialStaticInfo.append(", ");
+						}
+						initialStaticInfo.append(tagName);
+						count++;
+					}
+					initialStaticInfo.append("\n");
+				}
+
+				// Parent lines.
+				StringBuilder[] parentDescs = null;
+				if (commit.getParentIds() != null) {
+					ObjectId[] parentIds = commit.getParentIds();
+					parentDescs = new StringBuilder[parentIds.length];
+					count = 0;
+					for (ObjectId pid : parentIds) {
+						parentDescs[count] = new StringBuilder();
+						initialStaticInfo.append("Parent: ");
+						parentDescs[count].append(pid.toString());
+
+						Commit pc = repositoryMapping.getRepository()
+								.mapCommit(pid);
+						parentDescs[count].append(" (");
+						String cmesg = pc.getMessage();
+						int enterIndex = cmesg.indexOf("\n");
+						if (enterIndex > 0) {
+							cmesg = cmesg.substring(0, enterIndex);
+						}
+						parentDescs[count].append(cmesg);
+						parentDescs[count].append(")");
+						initialStaticInfo.append(parentDescs[count]);
+						initialStaticInfo.append("\n");
+
+						count++;
+					}
+				}
+				revDetailTextViewer.setDocument(new Document(initialStaticInfo
+						.toString()));
+
+				// Starts the revision thread to complete with the details that
+				// may take some time to compute.
+				RevisionInfoThread revInfoThread = new RevisionInfoThread();
+				revInfoThread.repositoryMapping = repositoryMapping;
+				revInfoThread.revDetailTextViewer = revDetailTextViewer;
+				revInfoThread.rev = rev;
+				revInfoThread.initialStaticInfo = initialStaticInfo;
+				revInfoThread.parentDescs = parentDescs;
+				revInfoThread.start();
+			} catch (Exception e) {
+				// TODO Auto-generated catch block
+				e.printStackTrace();
+				StringBuilder revisionInfo = new StringBuilder();
+				revisionInfo.append(initialStaticInfo);
+				revisionInfo.append("\n");
+				revisionInfo.append(e.toString());
+				revDetailTextViewer.setDocument(new Document(revisionInfo
+						.toString()));
+			}
+		}
+
+		String comment = rev.getComment();
+		if (showComment) {
+			revCommentTextViewer.setDocument(new Document(comment));
+		}
+
+		// Adds the first comment line in the status line.
+		int enterIndex = comment.indexOf("\n");
+		if (enterIndex > 0) {
+			comment = comment.substring(0, enterIndex);
+		}
+
+		if (workbenchPageSite != null) {
+			workbenchPageSite.getActionBars().getStatusLineManager()
+					.setMessage(comment);
+		}
+	}
+
+	private static String formatPersonIdentForRevInfo(PersonIdent p) {
+		StringBuilder sb = new StringBuilder();
+		sb.append(p.getName());
+		if (p.getEmailAddress() != null) {
+			sb.append(" <");
+			sb.append(p.getEmailAddress());
+			sb.append(">");
+		}
+		if (p.getWhen() != null) {
+			sb.append(" ");
+			sb.append(DATETIMETZ_FORMAT.format(p.getWhen()));
+		}
+
+		return sb.toString();
+	}
+
+	/**
+	 * The revision info has 2 viewers. This methods sets which viewers to show.
+	 * 
+	 * @param showRevDetail
+	 *            true shows the revision detail viewer; false hides
+	 * @param showRevComment
+	 *            true shows the comment viewers; false hides
+	 */
+	public void setShowViewers(boolean showRevDetail, boolean showRevComment) {
+		this.showDetail = showRevDetail;
+		this.showComment = showRevComment;
+		if (!showDetail) {
+			this.setMaximizedControl(revCommentTextViewer.getControl());
+		} else if (!showComment) {
+			this.setMaximizedControl(revDetailTextViewer.getControl());
+		} else {
+			this.setMaximizedControl(null);
+		}
+	}
+
+	/**
+	 * Blanks the viewers and the status line.
+	 */
+	public void cleanRevisionInfoTextViewers() {
+		if (revDetailTextViewer != null && revCommentTextViewer != null) {
+			RevisionInfoThread.updateGlobalThreadIx();
+			revDetailTextViewer.setDocument(new Document(""));
+			revCommentTextViewer.setDocument(new Document(""));
+
+			// Cleans the status line
+			if (workbenchPageSite != null) {
+				workbenchPageSite.getActionBars().getStatusLineManager()
+						.setMessage(null);
+			}
+		}
+	}
+
+	/**
+	 * Sets the mapping containing the repository to be searched.
+	 * 
+	 * @param repositoryMapping
+	 *            the mapping
+	 */
+	public void setRepositoryMapping(RepositoryMapping repositoryMapping) {
+		this.repositoryMapping = repositoryMapping;
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfoThread.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfoThread.java
new file mode 100644
index 0000000..27fd87f
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfoThread.java
@@ -0,0 +1,212 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares
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
+import java.util.Set;
+import java.util.concurrent.CancellationException;
+
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.jface.text.Document;
+import org.eclipse.jface.text.TextViewer;
+import org.eclipse.swt.widgets.Display;
+import org.spearce.egit.core.internal.mapping.GitCommitFileRevision;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.core.util.CommitMetaInfo;
+import org.spearce.egit.core.util.RepositoryUtil;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.ObjectId;
+
+/**
+ * This class prints info the revisionInfo viewer that may take some time to be
+ * retrieved. Only one thread is executed at a time.
+ * <p>
+ * This class maintains a <code>globalThreadIx</code> internal variable that
+ * is incremented for each new thread started and the current running thread
+ * constantly checks this variable. If the current thread has the same value as
+ * <code>globalThreadIx</code> it continues executing, if it has a lower value
+ * it means that a more recent commit was selected and the current isn't
+ * necessary any more, so the current thread returns.
+ * </p>
+ * 
+ * @see RevisionInfo
+ */
+public class RevisionInfoThread extends Thread implements IProgressMonitor {
+
+	RepositoryMapping repositoryMapping;
+
+	TextViewer revDetailTextViewer;
+
+	GitCommitFileRevision rev;
+
+	StringBuilder initialStaticInfo;
+
+	StringBuilder[] parentDescs;
+
+	private static Display display = Display.getDefault();
+
+	private static int globalThreadIx = 0;
+
+	private int currentThreadIx;
+
+	/**
+	 * Creates a new object and increments the internal
+	 * <code>globalThreadIx</code> variable causing any earlier running thread
+	 * to return.
+	 */
+	public RevisionInfoThread() {
+		super("revisioninfo_thread" + ++globalThreadIx);
+		currentThreadIx = globalThreadIx;
+	}
+
+	public void run() {
+		exec(this);
+	}
+
+	private synchronized static void exec(RevisionInfoThread revThread) {
+		// If it isn't the last event, just ignore it.
+		if (revThread.currentThreadIx < globalThreadIx) {
+			return;
+		}
+
+		StringBuilder metaInfo = new StringBuilder();
+		try {
+			Commit commit = revThread.rev.getCommit();
+
+			RepositoryUtil repoUtil = new RepositoryUtil(
+					revThread.repositoryMapping.getRepository());
+			CommitMetaInfo commitMetaInfo = repoUtil.getCommitMetaInfo(commit,
+					revThread);
+
+			// Child lines.
+			Set<Commit> children = commitMetaInfo.getChildrenCommits();
+			if (children != null) {
+				for (Commit child : children) {
+					metaInfo.append("Child: ");
+					ObjectId cid = child.getCommitId();
+					metaInfo.append(cid.toString());
+
+					Commit cc = revThread.repositoryMapping.getRepository()
+							.mapCommit(cid);
+					metaInfo.append(" (");
+					String cmesg = cc.getMessage();
+					int enterIndex = cmesg.indexOf("\n");
+					if (enterIndex > 0) {
+						cmesg = cmesg.substring(0, enterIndex);
+					}
+					metaInfo.append(cmesg);
+					metaInfo.append(")");
+					metaInfo.append("\n");
+				}
+			}
+
+			// Branches line.
+			Set<String> commitBranches = commitMetaInfo
+					.getBranchNamesContainingCommit();
+			if (commitBranches != null) {
+				metaInfo.append("Branches: ");
+				int count = 0;
+				for (String branchName : commitBranches) {
+					if (count != 0) {
+						metaInfo.append(", ");
+					}
+					if (branchName.startsWith("refs/heads/")) {
+						metaInfo.append(branchName.substring(11));
+					} else {
+						metaInfo.append(branchName);
+					}
+					count++;
+				}
+				metaInfo.append("\n");
+			}
+		} catch (CancellationException e) {
+			return;
+		} catch (Exception e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+			if (revThread.currentThreadIx < globalThreadIx) {
+				return;
+			}
+			print(revThread, metaInfo, e.toString());
+		}
+
+		if (revThread.currentThreadIx < globalThreadIx) {
+			return;
+		}
+		print(revThread, metaInfo, null);
+	}
+
+	private static void print(final RevisionInfoThread revThread,
+			StringBuilder metaInfo, String errorMsg) {
+		StringBuilder revisionInfo = new StringBuilder();
+		revisionInfo.append(revThread.initialStaticInfo);
+		revisionInfo.append(metaInfo);
+		if (errorMsg != null) {
+			revisionInfo.append("\n");
+			revisionInfo.append(errorMsg);
+		}
+
+		final String revInfo = revisionInfo.toString();
+		display.asyncExec(new Runnable() {
+			public void run() {
+				if (revThread.currentThreadIx < globalThreadIx
+						|| revThread.revDetailTextViewer.getControl()
+								.isDisposed()) {
+					return;
+				}
+				revThread.revDetailTextViewer
+						.setDocument(new Document(revInfo));
+			}
+		});
+	}
+
+	static void updateGlobalThreadIx() {
+		++globalThreadIx;
+	}
+
+	public void beginTask(String arg0, int arg1) {
+		// Empty
+	}
+
+	public void done() {
+		// Empty
+	}
+
+	public void internalWorked(double arg0) {
+		// Empty
+	}
+
+	public boolean isCanceled() {
+		return currentThreadIx < globalThreadIx;
+	}
+
+	public void setCanceled(boolean arg0) {
+		// Empty
+	}
+
+	public void setTaskName(String arg0) {
+		// Empty
+	}
+
+	public void subTask(String arg0) {
+		// Empty
+	}
+
+	public void worked(int arg0) {
+		// Empty
+	}
+
+}
-- 
1.5.4.1
