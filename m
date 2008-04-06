From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 1/3] FindToolbar port to the new history page.
Date: Sun,  6 Apr 2008 17:41:49 -0400
Message-ID: <1207518109-4174-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com, spearce@spearce.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 22:44:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jibj9-0006V2-Vl
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 22:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbYDFUnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbYDFUnw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 16:43:52 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1086 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752858AbYDFUnu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 16:43:50 -0400
Received: (qmail 76130 invoked by uid 0); 6 Apr 2008 17:45:08 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 2.944437 secs); 06 Apr 2008 20:45:08 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.216.152)
  by cvxbsd.convex.com.br with SMTP; 6 Apr 2008 20:45:05 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78924>

This is a port from the find toolbar to the new history page.
It is replacing the current highlight flag in order to have the
find feature back but most of the code from the toolbar shall be
replaced to make use of the new infrastructure added into jgit
(RevFlag and RevFilter).

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
Hi Shawn,

I'm reseding the toolbar port with the fixes for the items you mentioned.
It's on top of 009f11e2c8971b6053, don't know if it would have been better
to rebase it, just let me know.

Patch 3/3 is something I've come up to remove the Map hit in the paint
method. As you said you were going to revisit the jgit API soon I didn't
want to do something too elaborated that will be dumped soon. I'm
manipulating RevFlags directly from the find toolbar, so if you don't
like just ignore it.

[]s,
Roger.


 .../src/org/spearce/egit/ui/UIText.java            |   23 +
 .../egit/ui/internal/history/CommitGraphTable.java |   24 +-
 .../egit/ui/internal/history/FindResults.java      |  185 ++++++++
 .../egit/ui/internal/history/FindToolbar.java      |  460 ++++++++++++++++++++
 .../ui/internal/history/FindToolbarThread.java     |  233 ++++++++++
 .../egit/ui/internal/history/GitHistoryPage.java   |   65 +++-
 .../src/org/spearce/egit/ui/uitext.properties      |   12 +
 7 files changed, 981 insertions(+), 21 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 6421b6c..dbe0df1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -72,6 +72,29 @@ public class UIText extends NLS {
 	public static String HistoryPage_refreshJob;
 
 	/** */
+	public static String HistoryPage_findbar_findTooltip;
+	/** */
+	public static String HistoryPage_findbar_find;
+	/** */
+	public static String HistoryPage_findbar_next;
+	/** */
+	public static String HistoryPage_findbar_previous;
+	/** */
+	public static String HistoryPage_findbar_ignorecase;
+	/** */
+	public static String HistoryPage_findbar_commit;
+	/** */
+	public static String HistoryPage_findbar_comments;
+	/** */
+	public static String HistoryPage_findbar_author;
+	/** */
+	public static String HistoryPage_findbar_committer;
+	/** */
+	public static String HistoryPage_findbar_exceeded;
+	/** */
+	public static String HistoryPage_findbar_notFound;
+
+	/** */
 	public static String HistoryPreferencePage_title;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
index 6559d64..1b1d16b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
@@ -49,7 +49,6 @@ import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.revplot.PlotCommit;
 import org.spearce.jgit.revwalk.RevCommit;
-import org.spearce.jgit.revwalk.RevFlag;
 
 class CommitGraphTable {
 	private static Font highlightFont() {
@@ -81,13 +80,13 @@ class CommitGraphTable {
 
 	private SWTCommitList allCommits;
 
-	private RevFlag highlight;
+	private FindResults findResults;
 
 	CommitGraphTable(final Composite parent) {
 		nFont = Activator.getFont(UIPreferences.THEME_CommitGraphNormalFont);
 		hFont = highlightFont();
 
-		final Table rawTable = new Table(parent, SWT.MULTI | SWT.H_SCROLL
+		Table rawTable = new Table(parent, SWT.MULTI | SWT.H_SCROLL
 				| SWT.V_SCROLL | SWT.BORDER | SWT.FULL_SELECTION | SWT.VIRTUAL);
 		rawTable.setHeaderVisible(true);
 		rawTable.setLinesVisible(false);
@@ -159,10 +158,10 @@ class CommitGraphTable {
 				new Transfer[] { TextTransfer.getInstance() }, DND.CLIPBOARD);
 	}
 
-	void setInput(final RevFlag hFlag, final SWTCommitList list,
+	void setInput(final FindResults fResults, final SWTCommitList list,
 			final SWTCommit[] asArray) {
 		final SWTCommitList oldList = allCommits;
-		highlight = hFlag;
+		findResults = fResults;
 		allCommits = list;
 		table.setInput(asArray);
 		if (asArray != null && asArray.length > 0) {
@@ -211,8 +210,10 @@ class CommitGraphTable {
 	}
 
 	void doPaint(final Event event) {
-		final RevCommit c = (RevCommit) ((TableItem) event.item).getData();
-		if (highlight != null && c.has(highlight))
+		TableItem ti = (TableItem) event.item;
+		final RevCommit c = (RevCommit) ti.getData();
+		if (findResults != null
+				&& findResults.isFoundAt(table.getTable().indexOf(ti)))
 			event.gc.setFont(hFont);
 		else
 			event.gc.setFont(nFont);
@@ -232,4 +233,13 @@ class CommitGraphTable {
 		final int texty = (event.height - textsz.y) / 2;
 		event.gc.drawString(txt, event.x, event.y + texty);
 	}
+
+	/**
+	 * Returns the SWT Table that backs this CommitGraphTable.
+	 *
+	 * @return Table the SWT Table
+	 */
+	public Table getTable() {
+		return table.getTable();
+	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java
new file mode 100644
index 0000000..49ee4fc
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java
@@ -0,0 +1,185 @@
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
+package org.spearce.egit.ui.internal.history;
+
+import java.util.Arrays;
+import java.util.Iterator;
+import java.util.LinkedHashMap;
+import java.util.Map;
+
+/**
+ * Results for the find toolbar. This object stores the rows in the history
+ * table that contain a match to a given pattern.
+ *
+ * @see FindToolbar
+ * @see FindToolbarThread
+ */
+public class FindResults {
+	private Map<Integer, Integer> matchesMap = new LinkedHashMap<Integer, Integer>();
+
+	Integer[] keysArray;
+
+	private int matchesCount;
+
+	/**
+	 * Returns if the index in the history table matches the find pattern.
+	 *
+	 * @param index
+	 *            history table item index.
+	 * @return boolean <code>true</code> if the history table
+	 *         <code>index</code> contains a match to the find pattern,
+	 *         <code>false</code> otherwise
+	 */
+	public synchronized boolean isFoundAt(int index) {
+		return matchesMap.containsKey(Integer.valueOf(index));
+	}
+
+	/**
+	 * Returns the first table item index after <code>index</code> that
+	 * contains a match to the find pattern.
+	 *
+	 * @param index
+	 *            the history table item index
+	 * @return the index after <code>index</code> that contains a match.
+	 *         Returns -1 if there isn't a match after <code>index</code>
+	 */
+	public synchronized int getIndexAfter(int index) {
+		Integer[] matches = getkeysArray();
+		int sres = Arrays.binarySearch(matches, Integer.valueOf(index));
+		if (sres >= 0 && sres != matches.length - 1) {
+			return matches[sres + 1].intValue();
+		} else if (sres < 0) {
+			sres = -sres - 1;
+			if (sres < matches.length) {
+				return matches[sres].intValue();
+			}
+		}
+
+		return -1;
+	}
+
+	/**
+	 * Returns the first table item index before <code>index</code> that
+	 * contains a match to the find pattern.
+	 *
+	 * @param index
+	 *            the history table item index
+	 * @return the index before <code>index</code> that contains a match.
+	 *         Returns -1 if there isn't a match before <code>index</code>
+	 */
+	public synchronized int getIndexBefore(int index) {
+		Integer[] matches = getkeysArray();
+		int sres = Arrays.binarySearch(matches, Integer.valueOf(index));
+		if (sres >= 0 && sres != 0) {
+			return matches[sres - 1].intValue();
+		} else if (sres < -1) {
+			sres = -sres;
+			return matches[sres - 2].intValue();
+		}
+
+		return -1;
+	}
+
+	/**
+	 * Returns the first table item index that contains a match to the find
+	 * pattern.
+	 *
+	 * @return the first index that contains a match. Returns -1 if there isn't
+	 *         any match
+	 */
+	public synchronized int getFirstIndex() {
+		Iterator iter = matchesMap.keySet().iterator();
+		if (iter.hasNext()) {
+			return ((Integer) iter.next()).intValue();
+		}
+
+		return -1;
+	}
+
+	/**
+	 * Returns the last table item index that contains a match to the find
+	 * pattern.
+	 *
+	 * @return the last index that contains a match. Returns -1 if there isn't
+	 *         any match
+	 */
+	public synchronized int getLastIndex() {
+		Integer[] matches = getkeysArray();
+		if (matches.length > 0) {
+			return matches[matches.length - 1].intValue();
+		}
+
+		return -1;
+	}
+
+	/**
+	 * Returns the index in the matches list for the history table item
+	 * <code>index</code>.
+	 *
+	 * @param index
+	 *            the history table item index
+	 * @return the position of the <code>index</code> in the total matches
+	 *         list. Returns -1 if <code>index</code> doesn't contain a match
+	 */
+	public synchronized int getMatchNumberFor(int index) {
+		Integer ix = matchesMap.get(Integer.valueOf(index));
+		if (ix != null) {
+			return ix.intValue();
+		}
+
+		return -1;
+	}
+
+	/**
+	 * @return int
+	 */
+	public int size() {
+		return matchesCount;
+	}
+
+	/**
+	 * Cleans the find results. All match item indexes are removed.
+	 */
+	public synchronized void clear() {
+		matchesMap.clear();
+		keysArray = null;
+		matchesCount = 0;
+	}
+
+	/**
+	 * Adds a history table item index (<code>matchIx</code>) to the find
+	 * results matches list.
+	 *
+	 * @param matchIx
+	 *            the history table item index that matches a find pattern.
+	 */
+	public synchronized void add(int matchIx) {
+		matchesMap.put(Integer.valueOf(matchIx), Integer
+				.valueOf(++matchesCount));
+		keysArray = null;
+	}
+
+	private Integer[] getkeysArray() {
+		if (keysArray == null) {
+			keysArray = matchesMap.keySet().toArray(
+					new Integer[matchesMap.size()]);
+		}
+
+		return keysArray;
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java
new file mode 100644
index 0000000..dbd0774
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java
@@ -0,0 +1,460 @@
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
+package org.spearce.egit.ui.internal.history;
+
+import java.util.ArrayList;
+import java.util.List;
+
+import org.eclipse.core.runtime.Preferences;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.KeyAdapter;
+import org.eclipse.swt.events.KeyEvent;
+import org.eclipse.swt.events.ModifyEvent;
+import org.eclipse.swt.events.ModifyListener;
+import org.eclipse.swt.events.SelectionAdapter;
+import org.eclipse.swt.events.SelectionEvent;
+import org.eclipse.swt.graphics.Color;
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.swt.graphics.Point;
+import org.eclipse.swt.graphics.RGB;
+import org.eclipse.swt.graphics.Rectangle;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Button;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Display;
+import org.eclipse.swt.widgets.Event;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Listener;
+import org.eclipse.swt.widgets.Menu;
+import org.eclipse.swt.widgets.MenuItem;
+import org.eclipse.swt.widgets.ProgressBar;
+import org.eclipse.swt.widgets.Table;
+import org.eclipse.swt.widgets.Text;
+import org.eclipse.swt.widgets.ToolBar;
+import org.eclipse.swt.widgets.ToolItem;
+import org.eclipse.swt.widgets.Widget;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIIcons;
+import org.spearce.egit.ui.UIPreferences;
+import org.spearce.egit.ui.UIText;
+
+/**
+ * A toolbar for the history page.
+ *
+ * @see FindToolbarThread
+ * @see FindResults
+ * @see GitHistoryPage
+ */
+public class FindToolbar extends Composite {
+	private Color errorBackgroundColor;
+
+	/**
+	 * The results (matches) of the current find operation.
+	 */
+	public final FindResults findResults = new FindResults();
+
+	private Preferences prefs = Activator.getDefault().getPluginPreferences();
+
+	private List<Listener> eventList = new ArrayList<Listener>();
+
+	private Image nextIcon;
+
+	private Image previousIcon;
+
+	private Table historyTable;
+
+	private SWTCommit[] fileRevisions;
+
+	private Text patternField;
+
+	private Button nextButton;
+
+	private Button previousButton;
+
+	private Label currentPositionLabel;
+
+	private ProgressBar progressBar;
+
+	private String lastErrorPattern;
+
+	/**
+	 * Creates the toolbar.
+	 *
+	 * @param parent
+	 *            the parent widget
+	 */
+	public FindToolbar(Composite parent) {
+		super(parent, SWT.NULL);
+		createToolbar();
+	}
+
+	private void createToolbar() {
+		errorBackgroundColor = new Color(getDisplay(), new RGB(255, 150, 150));
+		nextIcon = UIIcons.ELCL16_NEXT.createImage();
+		previousIcon = UIIcons.ELCL16_PREVIOUS.createImage();
+
+		GridLayout findLayout = new GridLayout();
+		findLayout.marginHeight = 2;
+		findLayout.marginWidth = 2;
+		findLayout.numColumns = 8;
+		setLayout(findLayout);
+		setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, false));
+
+		Label findLabel = new Label(this, SWT.NULL);
+		findLabel.setText(UIText.HistoryPage_findbar_find);
+
+		patternField = new Text(this, SWT.SEARCH);
+		GridData findTextData = new GridData(SWT.FILL, SWT.FILL, true, false);
+		findTextData.minimumWidth = 50;
+		patternField.setLayoutData(findTextData);
+		patternField.setText("");
+		patternField.setTextLimit(100);
+
+		nextButton = new Button(this, SWT.HORIZONTAL);
+		nextButton.setImage(nextIcon);
+		nextButton.setText(UIText.HistoryPage_findbar_next);
+
+		previousButton = new Button(this, SWT.HORIZONTAL);
+		previousButton.setImage(previousIcon);
+		previousButton.setText(UIText.HistoryPage_findbar_previous);
+
+		final ToolBar toolBar = new ToolBar(this, SWT.FLAT);
+		new ToolItem(toolBar, SWT.SEPARATOR);
+
+		final ToolItem prefsItem = new ToolItem(toolBar, SWT.DROP_DOWN);
+		final Menu prefsMenu = new Menu(this.getShell(), SWT.POP_UP);
+		final MenuItem caseItem = new MenuItem(prefsMenu, SWT.CHECK);
+		caseItem.setText(UIText.HistoryPage_findbar_ignorecase);
+		new MenuItem(prefsMenu, SWT.SEPARATOR);
+		final MenuItem commitIdItem = new MenuItem(prefsMenu, SWT.CHECK);
+		commitIdItem.setText(UIText.HistoryPage_findbar_commit);
+		final MenuItem commentsItem = new MenuItem(prefsMenu, SWT.CHECK);
+		commentsItem.setText(UIText.HistoryPage_findbar_comments);
+		final MenuItem authorItem = new MenuItem(prefsMenu, SWT.CHECK);
+		authorItem.setText(UIText.HistoryPage_findbar_author);
+		final MenuItem committerItem = new MenuItem(prefsMenu, SWT.CHECK);
+		committerItem.setText(UIText.HistoryPage_findbar_committer);
+
+		prefsItem.addListener(SWT.Selection, new Listener() {
+			public void handleEvent(Event event) {
+				if (event.detail == SWT.ARROW) {
+					Rectangle itemBounds = prefsItem.getBounds();
+					Point point = toolBar.toDisplay(itemBounds.x, itemBounds.y
+							+ itemBounds.height);
+					prefsMenu.setLocation(point);
+					prefsMenu.setVisible(true);
+				}
+			}
+		});
+
+		currentPositionLabel = new Label(this, SWT.NULL);
+		GridData totalLabelData = new GridData();
+		totalLabelData.horizontalAlignment = SWT.FILL;
+		totalLabelData.grabExcessHorizontalSpace = true;
+		currentPositionLabel.setLayoutData(totalLabelData);
+		currentPositionLabel.setAlignment(SWT.RIGHT);
+		currentPositionLabel.setText("");
+
+		progressBar = new ProgressBar(this, SWT.HORIZONTAL);
+		GridData findProgressBarData = new GridData();
+		findProgressBarData.heightHint = 12;
+		findProgressBarData.widthHint = 35;
+		progressBar.setLayoutData(findProgressBarData);
+		progressBar.setMinimum(0);
+		progressBar.setMaximum(100);
+
+		final FindToolbar thisToolbar = this;
+		patternField.addModifyListener(new ModifyListener() {
+			public void modifyText(ModifyEvent e) {
+				final FindToolbarThread finder = new FindToolbarThread();
+				finder.pattern = ((Text) e.getSource()).getText();
+				finder.fileRevisions = fileRevisions;
+				finder.toolbar = thisToolbar;
+				finder.ignoreCase = caseItem.getSelection();
+				finder.findInCommitId = commitIdItem.getSelection();
+				finder.findInComments = commentsItem.getSelection();
+				finder.findInAuthor = authorItem.getSelection();
+				finder.findInCommitter = committerItem.getSelection();
+				getDisplay().timerExec(200, new Runnable() {
+					public void run() {
+						finder.start();
+					}
+				});
+			}
+		});
+
+		final Listener findButtonsListener = new Listener() {
+			public void handleEvent(Event event) {
+				if (patternField.getText().length() > 0
+						&& findResults.size() == 0) {
+					// If the toolbar was cleared and has a pattern typed,
+					// then we redo the find with the new table data.
+					final FindToolbarThread finder = new FindToolbarThread();
+					finder.pattern = patternField.getText();
+					finder.fileRevisions = fileRevisions;
+					finder.toolbar = thisToolbar;
+					finder.ignoreCase = caseItem.getSelection();
+					finder.findInCommitId = commitIdItem.getSelection();
+					finder.findInComments = commentsItem.getSelection();
+					finder.findInAuthor = authorItem.getSelection();
+					finder.findInCommitter = committerItem.getSelection();
+					finder.start();
+					patternField.setSelection(0, 0);
+				} else {
+					int currentIx = historyTable.getSelectionIndex();
+					int newIx = -1;
+					if (event.widget == nextButton) {
+						newIx = findResults.getIndexAfter(currentIx);
+						if (newIx == -1) {
+							newIx = findResults.getFirstIndex();
+						}
+					} else {
+						newIx = findResults.getIndexBefore(currentIx);
+						if (newIx == -1) {
+							newIx = findResults.getLastIndex();
+						}
+					}
+					sendEvent(event.widget, newIx);
+
+					String current = null;
+					int currentValue = findResults.getMatchNumberFor(newIx);
+					if (currentValue == -1) {
+						current = "-";
+					} else {
+						current = String.valueOf(currentValue);
+					}
+					currentPositionLabel.setText(current + "/"
+							+ findResults.size());
+				}
+			}
+		};
+		nextButton.addListener(SWT.Selection, findButtonsListener);
+		previousButton.addListener(SWT.Selection, findButtonsListener);
+
+		patternField.addKeyListener(new KeyAdapter() {
+			private Event event = new Event();
+
+			@Override
+			public void keyPressed(KeyEvent e) {
+				if (e.keyCode == SWT.ARROW_DOWN) {
+					if (nextButton.isEnabled()) {
+						event.widget = nextButton;
+						findButtonsListener.handleEvent(event);
+					}
+				} else if (e.keyCode == SWT.ARROW_UP) {
+					if (previousButton.isEnabled()) {
+						event.widget = previousButton;
+						findButtonsListener.handleEvent(event);
+					}
+				}
+			}
+		});
+
+		caseItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_IGNORE_CASE, caseItem
+						.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		caseItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_IGNORE_CASE));
+
+		commitIdItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMIT_ID,
+						commitIdItem.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		commitIdItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_COMMIT_ID));
+
+		commentsItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMENTS, commentsItem
+						.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		commentsItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_COMMENTS));
+
+		authorItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_AUTHOR, authorItem
+						.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		authorItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_AUTHOR));
+
+		committerItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMITTER,
+						committerItem.getSelection());
+				Activator.getDefault().savePluginPreferences();
+				clear();
+			}
+		});
+		committerItem.setSelection(prefs
+				.getBoolean(UIPreferences.FINDTOOLBAR_COMMITTER));
+	}
+
+	@Override
+	public void dispose() {
+		errorBackgroundColor.dispose();
+		nextIcon.dispose();
+		previousIcon.dispose();
+		super.dispose();
+	}
+
+	/**
+	 * Sets the table that will have its selected items changed by this toolbar.
+	 * Sets the list to be searched.
+	 *
+	 * @param historyTable
+	 * @param commitArray
+	 */
+	public void setInput(final Table historyTable, final SWTCommit[] commitArray) {
+		this.fileRevisions = commitArray;
+		this.historyTable = historyTable;
+	}
+
+	void progressUpdate(int percent) {
+		int total = findResults.size();
+		currentPositionLabel.setText("-/" + total);
+		currentPositionLabel.setForeground(null);
+		if (total > 0) {
+			nextButton.setEnabled(true);
+			previousButton.setEnabled(true);
+			patternField.setBackground(null);
+		} else {
+			nextButton.setEnabled(false);
+			previousButton.setEnabled(false);
+		}
+		progressBar.setSelection(percent);
+		historyTable.clearAll();
+	}
+
+	void findCompletionUpdate(String pattern, boolean overflow) {
+		int total = findResults.size();
+		if (total > 0) {
+			if (overflow) {
+				currentPositionLabel
+						.setText(UIText.HistoryPage_findbar_exceeded + " 1/"
+								+ total);
+			} else {
+				currentPositionLabel.setText("1/" + total);
+			}
+			int ix = findResults.getFirstIndex();
+			sendEvent(null, ix);
+
+			patternField.setBackground(null);
+			nextButton.setEnabled(true);
+			previousButton.setEnabled(true);
+			lastErrorPattern = null;
+		} else {
+			if (pattern.length() > 0) {
+				patternField.setBackground(errorBackgroundColor);
+				currentPositionLabel
+						.setText(UIText.HistoryPage_findbar_notFound);
+				// Don't keep beeping every time if the user is deleting
+				// a long not found pattern
+				if (lastErrorPattern == null
+						|| (lastErrorPattern != null && !lastErrorPattern
+								.startsWith(pattern))) {
+					getDisplay().beep();
+					nextButton.setEnabled(false);
+					previousButton.setEnabled(false);
+				}
+				lastErrorPattern = pattern;
+			} else {
+				patternField.setBackground(null);
+				currentPositionLabel.setText("");
+				nextButton.setEnabled(false);
+				previousButton.setEnabled(false);
+				lastErrorPattern = null;
+			}
+		}
+		progressBar.setSelection(0);
+		historyTable.clearAll();
+
+		if (overflow) {
+			Display display = getDisplay();
+			currentPositionLabel.setForeground(display
+					.getSystemColor(SWT.COLOR_RED));
+			display.beep();
+		} else {
+			currentPositionLabel.setForeground(null);
+		}
+	}
+
+	/**
+	 * Clears the toolbar.
+	 */
+	public void clear() {
+		patternField.setBackground(null);
+		if (patternField.getText().length() > 0) {
+			patternField.selectAll();
+			nextButton.setEnabled(true);
+			previousButton.setEnabled(true);
+		} else {
+			nextButton.setEnabled(false);
+			previousButton.setEnabled(false);
+		}
+		currentPositionLabel.setText("");
+		progressBar.setSelection(0);
+		lastErrorPattern = null;
+
+		findResults.clear();
+		if (historyTable != null) {
+			historyTable.clearAll();
+		}
+
+		FindToolbarThread.updateGlobalThreadIx();
+	}
+
+	private void sendEvent(Widget widget, int index) {
+		Event event = new Event();
+		event.type = SWT.Selection;
+		event.index = index;
+		event.widget = widget;
+		event.data = fileRevisions[index];
+		for (Listener listener : eventList) {
+			listener.handleEvent(event);
+		}
+	}
+
+	/**
+	 * Adds a selection event listener. The toolbar generates events when it
+	 * selects an item in the history table
+	 *
+	 * @param listener
+	 *            the listener that will receive the event
+	 */
+	public void addSelectionListener(Listener listener) {
+		eventList.add(listener);
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
new file mode 100644
index 0000000..95a545a
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
@@ -0,0 +1,233 @@
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
+package org.spearce.egit.ui.internal.history;
+
+/**
+ * This class executes the search function for the find toolbar. Only one thread
+ * is executed at a time.
+ * <p>
+ * This class maintains a <code>globalThreadIx</code> internal variable that
+ * is incremented for each new thread started and the current running thread
+ * constantly checks this variable. If the current thread has the same value as
+ * <code>globalThreadIx</code> it continues executing, if it has a lower value
+ * it means that a more recent search needs to be done and the current isn't
+ * necessary any more, so the current thread returns.
+ * </p>
+ * <p>
+ * To avoid consuming all the memory in the system, this class limits the
+ * maximum results it stores.
+ * </p>
+ *
+ * @see FindToolbar
+ * @see FindResults
+ */
+public class FindToolbarThread extends Thread {
+
+	private static final Object EXEC_LOCK = new Object();
+
+	private static final int MAX_RESULTS = 20000;
+
+	String pattern;
+
+	SWTCommit[] fileRevisions;
+
+	FindToolbar toolbar;
+
+	boolean ignoreCase;
+
+	boolean findInCommitId;
+
+	boolean findInComments;
+
+	boolean findInAuthor;
+
+	boolean findInCommitter;
+
+	private volatile static int globalThreadIx = 0;
+
+	private int currentThreadIx;
+
+	/**
+	 * Creates a new object and increments the internal
+	 * <code>globalThreadIx</code> variable causing any earlier running thread
+	 * to return.
+	 */
+	public FindToolbarThread() {
+		super("history_find_thread" + ++globalThreadIx);
+		currentThreadIx = globalThreadIx;
+	}
+
+	public void run() {
+		synchronized (EXEC_LOCK) {
+			execFind();
+		}
+	}
+
+	private void execFind() {
+		// If it isn't the last event, just ignore it.
+		if (currentThreadIx < globalThreadIx) {
+			return;
+		}
+
+		FindResults findResults = toolbar.findResults;
+		findResults.clear();
+
+		boolean maxResultsOverflow = false;
+		if (pattern.length() > 0 && fileRevisions != null) {
+			String findPattern = pattern;
+			if (ignoreCase) {
+				findPattern = pattern.toLowerCase();
+			}
+
+			long lastUIUpdate = System.currentTimeMillis();
+
+			int totalRevisions = fileRevisions.length;
+			int totalMatches = 0;
+			boolean notFound = true;
+			for (int i = 0; i < totalRevisions; i++) {
+				// If a new find event was generated, ends the current thread.
+				if (toolbar.getDisplay().isDisposed()
+						|| currentThreadIx < globalThreadIx) {
+					return;
+				}
+
+				// Updates the toolbar with in process info.
+				if (System.currentTimeMillis() - lastUIUpdate > 500) {
+					final int percentage = (int) (((i + 1F) / totalRevisions) * 100);
+					toolbar.getDisplay().asyncExec(new Runnable() {
+						public void run() {
+							if (toolbar.isDisposed()) {
+								return;
+							}
+							toolbar.progressUpdate(percentage);
+						}
+					});
+					lastUIUpdate = System.currentTimeMillis();
+				}
+
+				// Finds for the pattern in the revision history.
+				notFound = true;
+				SWTCommit revision = fileRevisions[i];
+
+				if (findInCommitId) {
+					String contentId = revision.getId().toString();
+					if (contentId != null) {
+						if (ignoreCase) {
+							contentId = contentId.toLowerCase();
+						}
+						if (contentId.indexOf(findPattern) != -1) {
+							totalMatches++;
+							findResults.add(i);
+							notFound = false;
+						}
+					}
+				}
+
+				if (findInComments && notFound) {
+					String comment = revision.getFullMessage();
+					if (comment != null) {
+						if (ignoreCase) {
+							comment = comment.toLowerCase();
+						}
+						if (comment.indexOf(findPattern) != -1) {
+							totalMatches++;
+							findResults.add(i);
+							notFound = false;
+						}
+					}
+				}
+
+				if (findInAuthor && notFound) {
+					String author = revision.getAuthorIdent().getName();
+					if (author != null) {
+						if (ignoreCase) {
+							author = author.toLowerCase();
+						}
+						if (author.indexOf(findPattern) != -1) {
+							totalMatches++;
+							findResults.add(i);
+							notFound = false;
+						}
+					}
+					if (notFound) {
+						String email = revision.getAuthorIdent()
+								.getEmailAddress();
+						if (email != null) {
+							if (ignoreCase) {
+								email = email.toLowerCase();
+							}
+							if (email.indexOf(findPattern) != -1) {
+								totalMatches++;
+								findResults.add(i);
+								notFound = false;
+							}
+						}
+					}
+				}
+
+				if (findInCommitter && notFound) {
+					String committer = revision.getCommitterIdent().getName();
+					if (committer != null) {
+						if (ignoreCase) {
+							committer = committer.toLowerCase();
+						}
+						if (committer.indexOf(findPattern) != -1) {
+							totalMatches++;
+							findResults.add(i);
+							notFound = false;
+						}
+					}
+					if (notFound) {
+						String email = revision.getCommitterIdent()
+								.getEmailAddress();
+						if (email != null) {
+							if (ignoreCase) {
+								email = email.toLowerCase();
+							}
+							if (email.indexOf(findPattern) != -1) {
+								totalMatches++;
+								findResults.add(i);
+								notFound = false;
+							}
+						}
+					}
+				}
+
+				if (totalMatches == MAX_RESULTS) {
+					maxResultsOverflow = true;
+					break;
+				}
+			}
+
+		}
+
+		// Updates the toolbar with the result find info.
+		final boolean overflow = maxResultsOverflow;
+		toolbar.getDisplay().syncExec(new Runnable() {
+			public void run() {
+				if (toolbar.isDisposed()) {
+					return;
+				}
+				toolbar.findCompletionUpdate(pattern, overflow);
+			}
+		});
+	}
+
+	static void updateGlobalThreadIx() {
+		++globalThreadIx;
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index 3b6d1c9..0a3e3b8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -29,6 +29,7 @@ import org.eclipse.jface.action.Action;
 import org.eclipse.jface.action.IAction;
 import org.eclipse.jface.action.IContributionItem;
 import org.eclipse.jface.action.IMenuManager;
+import org.eclipse.jface.action.IToolBarManager;
 import org.eclipse.jface.action.MenuManager;
 import org.eclipse.jface.action.Separator;
 import org.eclipse.jface.text.ITextOperationTarget;
@@ -46,6 +47,8 @@ import org.eclipse.swt.layout.GridData;
 import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.widgets.Composite;
 import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Event;
+import org.eclipse.swt.widgets.Listener;
 import org.eclipse.team.ui.history.HistoryPage;
 import org.eclipse.ui.IActionBars;
 import org.eclipse.ui.IPartListener;
@@ -59,13 +62,13 @@ import org.eclipse.ui.progress.IWorkbenchSiteProgressService;
 import org.spearce.egit.core.ResourceList;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revplot.PlotCommit;
 import org.spearce.jgit.revwalk.RevCommit;
-import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevSort;
 import org.spearce.jgit.revwalk.filter.RevFilter;
 import org.spearce.jgit.treewalk.TreeWalk;
@@ -85,6 +88,8 @@ public class GitHistoryPage extends HistoryPage {
 
 	private static final String SPLIT_INFO = UIPreferences.RESOURCEHISTORY_REV_SPLIT;
 
+	private static final String SHOW_FIND_TOOLBAR = UIPreferences.RESOURCEHISTORY_SHOW_FINDTOOLBAR;
+
 	private static final String POPUP_ID = "org.spearce.egit.ui.historyPageContributions";
 
 	/**
@@ -147,6 +152,9 @@ public class GitHistoryPage extends HistoryPage {
 	/** Viewer displaying file difference implied by {@link #graph}'s commit. */
 	private CommitFileDiffViewer fileViewer;
 
+	/** Toolbar to find commits in the history view. */
+	private FindToolbar findToolbar;
+
 	/** Our context menu manager for the entire page. */
 	private MenuManager popupMgr;
 
@@ -157,14 +165,6 @@ public class GitHistoryPage extends HistoryPage {
 	private SWTWalk currentWalk;
 
 	/**
-	 * Highlight flag that can be applied to commits to make them stand out.
-	 * <p>
-	 * Allocated at the same time as {@link #currentWalk}. If the walk
-	 * rebuilds, so must this flag.
-	 */
-	private RevFlag highlightFlag;
-
-	/**
 	 * List of paths we used to limit {@link #currentWalk}; null if no paths.
 	 * <p>
 	 * Note that a change in this list requires that {@link #currentWalk} and
@@ -197,12 +197,14 @@ public class GitHistoryPage extends HistoryPage {
 		revInfoSplit = new SashForm(graphDetailSplit, SWT.HORIZONTAL);
 		commentViewer = new CommitMessageViewer(revInfoSplit);
 		fileViewer = new CommitFileDiffViewer(revInfoSplit);
+		findToolbar = new FindToolbar(ourControl);
 
 		layoutSashForm(graphDetailSplit, SPLIT_GRAPH);
 		layoutSashForm(revInfoSplit, SPLIT_INFO);
 
 		popupMgr = new MenuManager(POPUP_ID);
 		attachCommitSelectionChanged();
+		createLocalToolbarActions();
 		createStandardActions();
 		createViewMenu();
 
@@ -248,6 +250,7 @@ public class GitHistoryPage extends HistoryPage {
 	private void layout() {
 		final boolean showComment = prefs.getBoolean(SHOW_COMMENT);
 		final boolean showFiles = prefs.getBoolean(SHOW_FILES);
+		final boolean showFindToolbar = prefs.getBoolean(SHOW_FIND_TOOLBAR);
 
 		if (showComment && showFiles) {
 			graphDetailSplit.setMaximizedControl(null);
@@ -261,6 +264,13 @@ public class GitHistoryPage extends HistoryPage {
 		} else if (!showComment && !showFiles) {
 			graphDetailSplit.setMaximizedControl(graph.getControl());
 		}
+		if (showFindToolbar) {
+			((GridData) findToolbar.getLayoutData()).heightHint = SWT.DEFAULT;
+		} else {
+			((GridData) findToolbar.getLayoutData()).heightHint = 0;
+			findToolbar.clear();
+		}
+		ourControl.layout();
 	}
 
 	private void attachCommitSelectionChanged() {
@@ -288,6 +298,32 @@ public class GitHistoryPage extends HistoryPage {
 						graph.selectCommit(c);
 					}
 				});
+		findToolbar.addSelectionListener(new Listener() {
+			public void handleEvent(Event event) {
+				graph.selectCommit((RevCommit) event.data);
+			}
+		});
+	}
+
+	private void createLocalToolbarActions() {
+		final IToolBarManager barManager = getSite().getActionBars()
+				.getToolBarManager();
+		IAction a;
+
+		a = createFindToolbarAction();
+		barManager.add(a);
+	}
+
+	private IAction createFindToolbarAction() {
+		final IAction r = new Action("Fi", UIIcons.ELCL16_FIND) {
+			public void run() {
+				prefs.setValue(SHOW_FIND_TOOLBAR, isChecked());
+				layout();
+			}
+		};
+		r.setChecked(prefs.getBoolean(SHOW_FIND_TOOLBAR));
+		r.setToolTipText(UIText.HistoryPage_findbar_findTooltip);
+		return r;
 	}
 
 	private void createViewMenu() {
@@ -470,7 +506,6 @@ public class GitHistoryPage extends HistoryPage {
 				|| pathChange(pathFilters, paths)) {
 			currentWalk = new SWTWalk(db);
 			currentWalk.sort(RevSort.COMMIT_TIME_DESC, true);
-			highlightFlag = currentWalk.newFlag("highlight");
 		} else {
 			currentWalk.reset();
 		}
@@ -500,7 +535,8 @@ public class GitHistoryPage extends HistoryPage {
 			fileWalker.setFilter(TreeFilter.ANY_DIFF);
 		}
 		fileViewer.setTreeWalk(fileWalker);
-		graph.setInput(highlightFlag, null, null);
+		findToolbar.clear();
+		graph.setInput(findToolbar.findResults, null, null);
 
 		final SWTCommitList list;
 		list = new SWTCommitList(graph.getControl().getDisplay());
@@ -539,7 +575,6 @@ public class GitHistoryPage extends HistoryPage {
 			//
 			job = null;
 			currentWalk = null;
-			highlightFlag = null;
 			pathFilters = null;
 		}
 	}
@@ -571,8 +606,10 @@ public class GitHistoryPage extends HistoryPage {
 
 		graph.getControl().getDisplay().asyncExec(new Runnable() {
 			public void run() {
-				if (!graph.getControl().isDisposed() && job == j)
-					graph.setInput(highlightFlag, list, asArray);
+				if (!graph.getControl().isDisposed() && job == j) {
+					graph.setInput(findToolbar.findResults, list, asArray);
+					findToolbar.setInput(graph.getTable(), asArray);
+				}
 			}
 		});
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 9672a0d..ef9ebee 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -39,6 +39,18 @@ HistoryPage_dateColumn=Date
 HistoryPage_pathnameColumn=Path
 HistoryPage_refreshJob=Reading history from Git
 
+HistoryPage_findbar_findTooltip=Find
+HistoryPage_findbar_find=Find:
+HistoryPage_findbar_next=next
+HistoryPage_findbar_previous=previous
+HistoryPage_findbar_ignorecase=Ignore case
+HistoryPage_findbar_commit=Commit
+HistoryPage_findbar_comments=Comments
+HistoryPage_findbar_author=Author
+HistoryPage_findbar_committer=Committer
+HistoryPage_findbar_exceeded=Results limit exceeded
+HistoryPage_findbar_notFound=String not found
+
 HistoryPreferencePage_title=Git
 
 WindowCachePreferencePage_title=Git Window Cache
-- 
1.5.4.1
