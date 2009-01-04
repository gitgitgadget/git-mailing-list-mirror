From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: [EGIT PATCH] Sorting commit items by click on the table header in
 commit dialog.
Date: Mon, 05 Jan 2009 00:46:47 +0200
Message-ID: <gjre95$4cs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 23:48:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJblq-00015F-Hl
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 23:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbZADWrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 17:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZADWrO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 17:47:14 -0500
Received: from main.gmane.org ([80.91.229.2]:33865 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbZADWrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 17:47:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LJbkU-00010B-NJ
	for git@vger.kernel.org; Sun, 04 Jan 2009 22:47:10 +0000
Received: from 91.200.115.178 ([91.200.115.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 22:47:10 +0000
Received: from vvavrychuk by 91.200.115.178 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 22:47:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91.200.115.178
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104549>

In order to implement new feature I have replaced class associated with every table row.
CommitItem class encapsulate data that commit dialog manipulates with.
Comparators are written using idiom from http://tobega.blogspot.com/2008/05/beautiful-enums.html.
Clicks on a certain column are handled in HeaderSelectionListener class.

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
---
 .../egit/ui/internal/actions/CommitAction.java     |    2 +-
 .../egit/ui/internal/dialogs/CommitDialog.java     |  248 ++++++++++++++------
 2 files changed, 176 insertions(+), 74 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index d703048..779596c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -139,7 +139,7 @@ private void loadPreviousCommit() {
 	private void performCommit(CommitDialog commitDialog, String commitMessage)
 			throws TeamException {
 		// System.out.println("Commit Message: " + commitMessage);
-		IFile[] selectedItems = commitDialog.getSelectedItems();
+		IFile[] selectedItems = commitDialog.getSelectedFiles();
 
 		HashMap<Repository, Tree> treeMap = new HashMap<Repository, Tree>();
 		try {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index 4f932f2..a0598ff 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -15,6 +15,7 @@
 import java.io.IOException;
 import java.util.ArrayList;
 import java.util.Collections;
+import java.util.Comparator;
 import java.util.Iterator;
 
 import org.eclipse.core.resources.IFile;
@@ -28,9 +29,11 @@
 import org.eclipse.jface.viewers.IStructuredSelection;
 import org.eclipse.jface.viewers.ITableLabelProvider;
 import org.eclipse.jface.viewers.Viewer;
+import org.eclipse.jface.viewers.ViewerComparator;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.KeyAdapter;
 import org.eclipse.swt.events.KeyEvent;
+import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
 import org.eclipse.swt.events.SelectionListener;
 import org.eclipse.swt.graphics.Image;
@@ -62,56 +65,38 @@
  */
 public class CommitDialog extends Dialog {
 
+	class CommitContentProvider implements IStructuredContentProvider {
+
+		public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
+			// Empty
+		}
+
+		public void dispose() {
+			// Empty
+		}
+
+		public Object[] getElements(Object inputElement) {
+			return items.toArray();
+		}
+
+	}
+
 	class CommitLabelProvider extends WorkbenchLabelProvider implements
 			ITableLabelProvider {
 		public String getColumnText(Object obj, int columnIndex) {
-			IFile file = (IFile) obj;
-			if (columnIndex == 1)
-				return file.getProject().getName() + ": "
-						+ file.getProjectRelativePath();
+			CommitItem item = (CommitItem) obj;
 
-			else if (columnIndex == 0) {
-				String prefix = "Unknown";
+			switch (columnIndex) {
+			case 0:
+				return item.status;
 
-				try {
-					RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(file.getProject());
-
-					Repository repo = repositoryMapping.getRepository();
-					GitIndex index = repo.getIndex();
-					Tree headTree = repo.mapTree("HEAD");
-
-					String repoPath = repositoryMapping
-							.getRepoRelativePath(file);
-					TreeEntry headEntry = headTree.findBlobMember(repoPath);
-					boolean headExists = headTree.existsBlob(repoPath);
-
-					Entry indexEntry = index.getEntry(repoPath);
-					if (headEntry == null) {
-						prefix = "Added";
-						if (indexEntry.isModified(repositoryMapping.getWorkDir()))
-							prefix = "Added, index diff";
-					} else if (indexEntry == null) {
-						prefix = "Removed";
-					} else if (headExists
-							&& !headEntry.getId().equals(
-									indexEntry.getObjectId())) {
-						prefix = "Modified";
-
-
-						if (indexEntry.isModified(repositoryMapping.getWorkDir()))
-							prefix = "Mod., index diff";
-					} else if (!new File(repositoryMapping.getWorkDir(), indexEntry.getName()).isFile()) {
-						prefix = "Rem., not staged";
-					} else if (indexEntry.isModified(repositoryMapping.getWorkDir())) {
-						prefix = "Mod., not staged";
-					}
-
-				} catch (Exception e) {
-				}
+			case 1:
+				return item.file.getProject().getName() + ": "
+						+ item.file.getProjectRelativePath();
 
-				return prefix;
+			default:
+				return null;
 			}
-			return null;
 		}
 
 		public Image getColumnImage(Object element, int columnIndex) {
@@ -121,7 +106,7 @@ public Image getColumnImage(Object element, int columnIndex) {
 		}
 	}
 
-	ArrayList<IFile> files;
+	ArrayList<CommitItem> items = new ArrayList<CommitItem>();
 
 	/**
 	 * @param parentShell
@@ -227,30 +212,17 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
 		TableColumn statCol = new TableColumn(resourcesTable, SWT.LEFT);
 		statCol.setText("Status");
 		statCol.setWidth(150);
+		statCol.addSelectionListener(new HeaderSelectionListener(CommitItem.Order.ByStatus));
 
 		TableColumn resourceCol = new TableColumn(resourcesTable, SWT.LEFT);
 		resourceCol.setText("File");
 		resourceCol.setWidth(415);
+		resourceCol.addSelectionListener(new HeaderSelectionListener(CommitItem.Order.ByFile));
 
 		filesViewer = new CheckboxTableViewer(resourcesTable);
-		filesViewer.setContentProvider(new IStructuredContentProvider() {
-
-			public void inputChanged(Viewer viewer, Object oldInput,
-					Object newInput) {
-				// Empty
-			}
-
-			public void dispose() {
-				// Empty
-			}
-
-			public Object[] getElements(Object inputElement) {
-				return files.toArray();
-			}
-
-		});
+		filesViewer.setContentProvider(new CommitContentProvider());
 		filesViewer.setLabelProvider(new CommitLabelProvider());
-		filesViewer.setInput(files);
+		filesViewer.setInput(items);
 		filesViewer.setAllChecked(true);
 		filesViewer.getTable().setMenu(getContextMenu());
 
@@ -271,15 +243,15 @@ public void handleEvent(Event arg0) {
 				try {
 					ArrayList<GitIndex> changedIndexes = new ArrayList<GitIndex>();
 					for (Iterator<Object> it = sel.iterator(); it.hasNext();) {
-						IFile file = (IFile) it.next();
+						CommitItem commitItem = (CommitItem) it.next();
 
-						IProject project = file.getProject();
+						IProject project = commitItem.file.getProject();
 						RepositoryMapping map = RepositoryMapping.getMapping(project);
 
 						Repository repo = map.getRepository();
 						GitIndex index = null;
 						index = repo.getIndex();
-						Entry entry = index.getEntry(map.getRepoRelativePath(file));
+						Entry entry = index.getEntry(map.getRepoRelativePath(commitItem.file));
 						if (entry != null && entry.isModified(map.getWorkDir())) {
 							entry.update(new File(map.getWorkDir(), entry.getName()));
 							if (!changedIndexes.contains(index))
@@ -302,6 +274,47 @@ public void handleEvent(Event arg0) {
 		return menu;
 	}
 
+	private static String getFileStatus(IFile file) {
+		String prefix = "Unknown";
+
+		try {
+			RepositoryMapping repositoryMapping = RepositoryMapping
+					.getMapping(file.getProject());
+
+			Repository repo = repositoryMapping.getRepository();
+			GitIndex index = repo.getIndex();
+			Tree headTree = repo.mapTree("HEAD");
+
+			String repoPath = repositoryMapping.getRepoRelativePath(file);
+			TreeEntry headEntry = headTree.findBlobMember(repoPath);
+			boolean headExists = headTree.existsBlob(repoPath);
+
+			Entry indexEntry = index.getEntry(repoPath);
+			if (headEntry == null) {
+				prefix = "Added";
+				if (indexEntry.isModified(repositoryMapping.getWorkDir()))
+					prefix = "Added, index diff";
+			} else if (indexEntry == null) {
+				prefix = "Removed";
+			} else if (headExists
+					&& !headEntry.getId().equals(indexEntry.getObjectId())) {
+				prefix = "Modified";
+
+				if (indexEntry.isModified(repositoryMapping.getWorkDir()))
+					prefix = "Mod., index diff";
+			} else if (!new File(repositoryMapping.getWorkDir(), indexEntry
+					.getName()).isFile()) {
+				prefix = "Rem., not staged";
+			} else if (indexEntry.isModified(repositoryMapping.getWorkDir())) {
+				prefix = "Mod., not staged";
+			}
+
+		} catch (Exception e) {
+		}
+
+		return prefix;
+	}
+
 	/**
 	 * @return The message the user entered
 	 */
@@ -323,7 +336,7 @@ public void setCommitMessage(String s) {
 	private boolean amending = false;
 	private boolean amendAllowed = true;
 
-	private ArrayList<IFile> selectedItems = new ArrayList<IFile>();
+	private ArrayList<IFile> selectedFiles = new ArrayList<IFile>();
 	private String previousCommitMessage = "";
 
 	/**
@@ -331,15 +344,51 @@ public void setCommitMessage(String s) {
 	 *
 	 * @param items
 	 */
-	public void setSelectedItems(IFile[] items) {
-		Collections.addAll(selectedItems, items);
+	public void setSelectedFiles(IFile[] items) {
+		Collections.addAll(selectedFiles, items);
 	}
 
 	/**
 	 * @return the resources selected by the user to commit.
 	 */
-	public IFile[] getSelectedItems() {
-		return selectedItems.toArray(new IFile[0]);
+	public IFile[] getSelectedFiles() {
+		return selectedFiles.toArray(new IFile[0]);
+	}
+
+	class HeaderSelectionListener extends SelectionAdapter {
+
+		private CommitItem.Order order;
+
+		private boolean reversed;
+
+		public HeaderSelectionListener(CommitItem.Order order) {
+			this.order = order;
+		}
+
+		@Override
+		public void widgetSelected(SelectionEvent e) {
+			TableColumn column = (TableColumn)e.widget;
+			Table table = column.getParent();
+
+			if (column == table.getSortColumn()) {
+				reversed = !reversed;
+			} else {
+				reversed = false;
+			}
+			table.setSortColumn(column);
+
+			Comparator<CommitItem> comparator;
+			if (reversed) {
+				comparator = order.descending();
+				table.setSortDirection(SWT.DOWN);
+			} else {
+				comparator = order;
+				table.setSortDirection(SWT.UP);
+			}
+
+			filesViewer.setComparator(new CommitViewerComparator(comparator));
+		}
+
 	}
 
 	@Override
@@ -350,9 +399,9 @@ protected void okPressed() {
 		amending = amendingButton.getSelection();
 		
 		Object[] checkedElements = filesViewer.getCheckedElements();
-		selectedItems.clear();
+		selectedFiles.clear();
 		for (Object obj : checkedElements)
-			selectedItems.add((IFile) obj);
+			selectedFiles.add(((CommitItem) obj).file);
 
 		if (commitMessage.trim().length() == 0) {
 			MessageDialog.openWarning(getShell(), "No message", "You must enter a commit message");
@@ -368,7 +417,7 @@ protected void okPressed() {
 			}
 		} else author = null;
 
-		if (selectedItems.isEmpty() && !amending) {
+		if (selectedFiles.isEmpty() && !amending) {
 			MessageDialog.openWarning(getShell(), "No items selected", "No items are currently selected to be committed.");
 			return;
 		}
@@ -382,7 +431,13 @@ protected void okPressed() {
 	 * @param files potentially affected by a new commit
 	 */
 	public void setFileList(ArrayList<IFile> files) {
-		this.files = files;
+		items.clear();
+		for (IFile file : files) {
+			CommitItem item = new CommitItem();
+			item.status = getFileStatus(file);
+			item.file = file;
+			items.add(item);
+		}
 	}
 
 	@Override
@@ -468,3 +523,50 @@ protected int getShellStyle() {
 		return super.getShellStyle() | SWT.RESIZE;
 	}
 }
+
+class CommitItem {
+	String status;
+
+	IFile file;
+
+	public static enum Order implements Comparator<CommitItem> {
+		ByStatus() {
+
+			public int compare(CommitItem o1, CommitItem o2) {
+				return o1.status.compareTo(o2.status);
+			}
+
+		},
+
+		ByFile() {
+
+			public int compare(CommitItem o1, CommitItem o2) {
+				return o1.file.getProjectRelativePath().toString().
+					compareTo(o2.file.getProjectRelativePath().toString());
+			}
+
+		};
+
+		public Comparator<CommitItem> ascending() {
+			return this;
+		}
+
+		public Comparator<CommitItem> descending() {
+			return Collections.reverseOrder(this);
+		}
+	}
+}
+
+class CommitViewerComparator extends ViewerComparator {
+
+	public CommitViewerComparator(Comparator comparator){
+		super(comparator);
+	}
+
+	@SuppressWarnings("unchecked")
+	@Override
+	public int compare(Viewer viewer, Object e1, Object e2) {
+		return getComparator().compare(e1, e2);
+	}
+
+}
-- 
1.5.6.1.1071.g76fb
