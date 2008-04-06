From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 3/3] Use RevFlag to highlight find results in the history page.
Date: Sun,  6 Apr 2008 17:42:18 -0400
Message-ID: <1207518138-4215-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com, spearce@spearce.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 22:45:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jibjd-0006dA-To
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 22:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbYDFUoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 16:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbYDFUoQ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 16:44:16 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1156 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753910AbYDFUoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 16:44:15 -0400
Received: (qmail 76604 invoked by uid 0); 6 Apr 2008 17:45:35 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.638749 secs); 06 Apr 2008 20:45:35 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.216.152)
  by cvxbsd.convex.com.br with SMTP; 6 Apr 2008 20:45:34 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78926>

Make the toolbar aware of the highlight flag so that we can
roolback CommitGraphTable and prevent it from consulting a Map
in it's doPaint method.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../egit/ui/internal/history/CommitGraphTable.java |   13 ++++-----
 .../egit/ui/internal/history/FindResults.java      |   27 +++++++++++++++++++-
 .../egit/ui/internal/history/FindToolbar.java      |    6 +++-
 .../ui/internal/history/FindToolbarThread.java     |   12 ++++----
 .../egit/ui/internal/history/GitHistoryPage.java   |   18 +++++++++++--
 5 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
index 1b1d16b..74837f8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
@@ -49,6 +49,7 @@ import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.revplot.PlotCommit;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevFlag;
 
 class CommitGraphTable {
 	private static Font highlightFont() {
@@ -80,7 +81,7 @@ class CommitGraphTable {
 
 	private SWTCommitList allCommits;
 
-	private FindResults findResults;
+	private RevFlag highlight;
 
 	CommitGraphTable(final Composite parent) {
 		nFont = Activator.getFont(UIPreferences.THEME_CommitGraphNormalFont);
@@ -158,10 +159,10 @@ class CommitGraphTable {
 				new Transfer[] { TextTransfer.getInstance() }, DND.CLIPBOARD);
 	}
 
-	void setInput(final FindResults fResults, final SWTCommitList list,
+	void setInput(final RevFlag hFlag, final SWTCommitList list,
 			final SWTCommit[] asArray) {
 		final SWTCommitList oldList = allCommits;
-		findResults = fResults;
+		highlight = hFlag;
 		allCommits = list;
 		table.setInput(asArray);
 		if (asArray != null && asArray.length > 0) {
@@ -210,10 +211,8 @@ class CommitGraphTable {
 	}
 
 	void doPaint(final Event event) {
-		TableItem ti = (TableItem) event.item;
-		final RevCommit c = (RevCommit) ti.getData();
-		if (findResults != null
-				&& findResults.isFoundAt(table.getTable().indexOf(ti)))
+		final RevCommit c = (RevCommit) ((TableItem) event.item).getData();
+		if (highlight != null && c.has(highlight))
 			event.gc.setFont(hFont);
 		else
 			event.gc.setFont(nFont);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java
index 49ee4fc..f754424 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindResults.java
@@ -16,11 +16,16 @@
  */
 package org.spearce.egit.ui.internal.history;
 
+import java.util.ArrayList;
 import java.util.Arrays;
 import java.util.Iterator;
 import java.util.LinkedHashMap;
+import java.util.List;
 import java.util.Map;
 
+import org.spearce.jgit.revwalk.RevFlag;
+import org.spearce.jgit.revwalk.RevObject;
+
 /**
  * Results for the find toolbar. This object stores the rows in the history
  * table that contain a match to a given pattern.
@@ -31,10 +36,14 @@ import java.util.Map;
 public class FindResults {
 	private Map<Integer, Integer> matchesMap = new LinkedHashMap<Integer, Integer>();
 
+	private List<RevObject> revObjList = new ArrayList<RevObject>();
+
 	Integer[] keysArray;
 
 	private int matchesCount;
 
+	private RevFlag highlight;
+
 	/**
 	 * Returns if the index in the history table matches the find pattern.
 	 *
@@ -155,7 +164,13 @@ public class FindResults {
 	 * Cleans the find results. All match item indexes are removed.
 	 */
 	public synchronized void clear() {
+		if (highlight != null) {
+			for (RevObject o : revObjList) {
+				o.remove(highlight);
+			}
+		}
 		matchesMap.clear();
+		revObjList.clear();
 		keysArray = null;
 		matchesCount = 0;
 	}
@@ -166,10 +181,14 @@ public class FindResults {
 	 *
 	 * @param matchIx
 	 *            the history table item index that matches a find pattern.
+	 * @param revObj
+	 *            The RevObject that will have the highlight tag set.
 	 */
-	public synchronized void add(int matchIx) {
+	public synchronized void add(int matchIx, RevObject revObj) {
 		matchesMap.put(Integer.valueOf(matchIx), Integer
 				.valueOf(++matchesCount));
+		revObjList.add(revObj);
+		revObj.add(highlight);
 		keysArray = null;
 	}
 
@@ -182,4 +201,10 @@ public class FindResults {
 		return keysArray;
 	}
 
+	void setHighlightFlag(RevFlag hFlag) {
+		if (highlight != null) {
+			clear();
+		}
+		this.highlight = hFlag;
+	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java
index 5715d12..7f66eeb 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbar.java
@@ -52,6 +52,7 @@ import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.revwalk.RevFlag;
 
 /**
  * A toolbar for the history page.
@@ -409,12 +410,15 @@ public class FindToolbar extends Composite {
 	 * Sets the table that will have its selected items changed by this toolbar.
 	 * Sets the list to be searched.
 	 *
+	 * @param hFlag
 	 * @param historyTable
 	 * @param commitArray
 	 */
-	public void setInput(final Table historyTable, final SWTCommit[] commitArray) {
+	public void setInput(final RevFlag hFlag, final Table historyTable,
+			final SWTCommit[] commitArray) {
 		this.fileRevisions = commitArray;
 		this.historyTable = historyTable;
+		findResults.setHighlightFlag(hFlag);
 	}
 
 	void progressUpdate(int percent) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
index 95a545a..8a20f5f 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FindToolbarThread.java
@@ -131,7 +131,7 @@ public class FindToolbarThread extends Thread {
 						}
 						if (contentId.indexOf(findPattern) != -1) {
 							totalMatches++;
-							findResults.add(i);
+							findResults.add(i, revision);
 							notFound = false;
 						}
 					}
@@ -145,7 +145,7 @@ public class FindToolbarThread extends Thread {
 						}
 						if (comment.indexOf(findPattern) != -1) {
 							totalMatches++;
-							findResults.add(i);
+							findResults.add(i, revision);
 							notFound = false;
 						}
 					}
@@ -159,7 +159,7 @@ public class FindToolbarThread extends Thread {
 						}
 						if (author.indexOf(findPattern) != -1) {
 							totalMatches++;
-							findResults.add(i);
+							findResults.add(i, revision);
 							notFound = false;
 						}
 					}
@@ -172,7 +172,7 @@ public class FindToolbarThread extends Thread {
 							}
 							if (email.indexOf(findPattern) != -1) {
 								totalMatches++;
-								findResults.add(i);
+								findResults.add(i, revision);
 								notFound = false;
 							}
 						}
@@ -187,7 +187,7 @@ public class FindToolbarThread extends Thread {
 						}
 						if (committer.indexOf(findPattern) != -1) {
 							totalMatches++;
-							findResults.add(i);
+							findResults.add(i, revision);
 							notFound = false;
 						}
 					}
@@ -200,7 +200,7 @@ public class FindToolbarThread extends Thread {
 							}
 							if (email.indexOf(findPattern) != -1) {
 								totalMatches++;
-								findResults.add(i);
+								findResults.add(i, revision);
 								notFound = false;
 							}
 						}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index 0a3e3b8..604b438 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -69,6 +69,7 @@ import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revplot.PlotCommit;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevSort;
 import org.spearce.jgit.revwalk.filter.RevFilter;
 import org.spearce.jgit.treewalk.TreeWalk;
@@ -165,6 +166,14 @@ public class GitHistoryPage extends HistoryPage {
 	private SWTWalk currentWalk;
 
 	/**
+	 * Highlight flag that can be applied to commits to make them stand out.
+	 * <p>
+	 * Allocated at the same time as {@link #currentWalk}. If the walk
+	 * rebuilds, so must this flag.
+	 */
+	private RevFlag highlightFlag;
+
+	/**
 	 * List of paths we used to limit {@link #currentWalk}; null if no paths.
 	 * <p>
 	 * Note that a change in this list requires that {@link #currentWalk} and
@@ -506,6 +515,7 @@ public class GitHistoryPage extends HistoryPage {
 				|| pathChange(pathFilters, paths)) {
 			currentWalk = new SWTWalk(db);
 			currentWalk.sort(RevSort.COMMIT_TIME_DESC, true);
+			highlightFlag = currentWalk.newFlag("highlight");
 		} else {
 			currentWalk.reset();
 		}
@@ -536,7 +546,7 @@ public class GitHistoryPage extends HistoryPage {
 		}
 		fileViewer.setTreeWalk(fileWalker);
 		findToolbar.clear();
-		graph.setInput(findToolbar.findResults, null, null);
+		graph.setInput(highlightFlag, null, null);
 
 		final SWTCommitList list;
 		list = new SWTCommitList(graph.getControl().getDisplay());
@@ -575,6 +585,7 @@ public class GitHistoryPage extends HistoryPage {
 			//
 			job = null;
 			currentWalk = null;
+			highlightFlag = null;
 			pathFilters = null;
 		}
 	}
@@ -607,8 +618,9 @@ public class GitHistoryPage extends HistoryPage {
 		graph.getControl().getDisplay().asyncExec(new Runnable() {
 			public void run() {
 				if (!graph.getControl().isDisposed() && job == j) {
-					graph.setInput(findToolbar.findResults, list, asArray);
-					findToolbar.setInput(graph.getTable(), asArray);
+					graph.setInput(highlightFlag, list, asArray);
+					findToolbar.setInput(highlightFlag, graph.getTable(),
+							asArray);
 				}
 			}
 		});
-- 
1.5.4.1
