From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 4/4] Show only commits in the current branch.
Date: Sun, 23 Mar 2008 22:58:07 -0400
Message-ID: <1206327487-6543-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 03:00:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdbyg-000570-Rc
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 02:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbYCXB7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 21:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbYCXB7R
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 21:59:17 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1625 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754567AbYCXB7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 21:59:16 -0400
Received: (qmail 5033 invoked by uid 0); 23 Mar 2008 23:01:44 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 2.705301 secs); 24 Mar 2008 02:01:44 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.228.249)
  by cvxbsd.convex.com.br with SMTP; 24 Mar 2008 02:01:41 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77993>

This is a quick hack to have the functionality. It
filters the commits returned by GitFileHistory.getHistoryFor.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 org.spearce.egit.ui/icons/elcl16/cbcommits.gif     |  Bin 0 -> 354 bytes
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   80 ++++++++++++++++++++
 .../egit/ui/PluginPreferenceInitializer.java       |    1 +
 .../src/org/spearce/egit/ui/UIIcons.java           |    3 +
 .../src/org/spearce/egit/ui/UIPreferences.java     |    2 +
 5 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/elcl16/cbcommits.gif

diff --git a/org.spearce.egit.ui/icons/elcl16/cbcommits.gif b/org.spearce.egit.ui/icons/elcl16/cbcommits.gif
new file mode 100644
index 0000000000000000000000000000000000000000..21359d460ff9c3332482d503bab5d31a4db02188
GIT binary patch
literal 354
zcmZ?wbhEHb6krfwSjx!2(7+H=wQAzh<9qM*?tRd;_hIMWhh6&~cJ6!Jy6<t@ejxdz
zWj_eD?tj*>|5@XKXY~i3H5`0deeh+?!PgZB-&7oWQ-0`e$)UHUhu)SSdRKfHgh~#-
zFFO38;K+x9!ygNde9SxYG5;u#{FHa}bN12CIY+-_9sQDh^lRqPuh~G`DM5-qSs1w(
z>=|?zfB@tt2DbVG^9ww5_!wuMZ52MCV<^EOs326!!g!GV%SVs?6+&7LZZprsD?V7_
zmB_lXLhJA1F1IBNobpN+8KoQZrDa>|MMcC?7{w&}>V<`c@`a`f)$<GT2{H=I77(cC
s<lxHZ;^yV4XJcXQW@Tq*t!Lhvzjf=D9gI762JhIuqr~lqy(5D)038{o*8l(j

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index d0346a9..5a7e05b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -18,6 +18,7 @@ package org.spearce.egit.ui;
 
 import java.io.IOException;
 import java.text.SimpleDateFormat;
+import java.util.ArrayList;
 import java.util.Collections;
 import java.util.Date;
 import java.util.HashMap;
@@ -88,7 +89,9 @@ import org.spearce.egit.core.internal.mapping.GitFileHistoryProvider;
 import org.spearce.egit.core.internal.mapping.GitFileRevision;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.internal.actions.GitCompareRevisionAction;
+import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.lib.TopologicalSorter;
 import org.spearce.jgit.lib.Repository.StGitPatch;
@@ -124,6 +127,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	/* private */IAction toggleRevCommentAction;
 	/* private */IAction toggleTooltipsAction;
 	/* private */IAction findAction;
+	private IAction currentBranchCommitsAction;
 
 	/* private */Table table;
 	private MouseMoveListener tableMouseMoveListener;
@@ -132,6 +136,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 	private boolean hintShowDiffNow;
 
+	private boolean showOnlyCurrentBranch;
+
 	private boolean showAllProjectVersions;
 
 	private boolean showAllFolderVersions;
@@ -146,6 +152,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	 */
 	public GitHistoryPage(Object object) {
 		setInput(object);
+		showOnlyCurrentBranch = prefs.getBoolean(UIPreferences.RESOURCEHISTORY_SHOW_ONLY_CURRENT_BRANCH);
 		showAllProjectVersions = Activator.getDefault().getPreferenceStore()
 				.getBoolean(PREF_SHOWALLPROJECTVERSIONS);
 		showAllFolderVersions = Activator.getDefault().getPreferenceStore()
@@ -313,6 +320,27 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		getSite().getActionBars().getToolBarManager()
 				.add(findAction);
 
+		getSite().getActionBars().getToolBarManager()
+				.add(new Separator());
+
+		currentBranchCommitsAction = new Action("HEAD", UIIcons.ELCL16_HEAD) {
+			public void run() {
+				showOnlyCurrentBranch = isChecked();
+				if (historyRefreshJob.cancel()) {
+					System.out.println("rescheduling");
+					historyRefreshJob.schedule();
+				} else {
+					System.out.println("failed to cancel?");
+				}
+				prefs.setValue(UIPreferences.RESOURCEHISTORY_SHOW_ONLY_CURRENT_BRANCH, currentBranchCommitsAction.isChecked());
+				Activator.getDefault().savePluginPreferences();
+			}
+		};
+		currentBranchCommitsAction.setToolTipText("Show only commits in the current branch");
+		currentBranchCommitsAction.setChecked(showOnlyCurrentBranch);
+		getSite().getActionBars().getToolBarManager()
+				.add(currentBranchCommitsAction);
+
 		Action showAllRepoVersionsAction = new Action("R") {
 			public void run() {
 				setShowAllRepoVersions(isChecked());
@@ -842,6 +870,37 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 								monitor,
 								isShowAllRepoVersions());
 				fileRevisions = Collections.synchronizedList(fileHistoryFor.getFileRevisionsList());
+
+				if(showOnlyCurrentBranch) {
+					// Filters the history revisions list to show only
+					// the current selected branch. This is a quick hack to have it working
+					// TODO: this should probably be retrieved from the fileHistoryProvider.getHistoryFor
+					List<IFileRevision> filteredFileRevisions = Collections.synchronizedList(new ArrayList<IFileRevision>());
+					Map<String, String> parentMap = new HashMap<String, String>();
+					List<ObjectId> commitsToWalk = new ArrayList<ObjectId>();
+					if (fileRevisions.size() > 0) {
+						try {
+							Commit initialCommit = repositoryMapping.getRepository().mapCommit(currentHead);
+							verifyCurrentHeadCommits(repositoryMapping.getRepository(), parentMap, commitsToWalk, initialCommit);
+						} catch (Exception e) {
+							// TODO Auto-generated catch block
+							e.printStackTrace();
+						}
+
+						for(IFileRevision rev : fileRevisions) {
+							if(rev instanceof GitCommitFileRevision) {
+								String revId = rev.getContentIdentifier();
+								if(parentMap.containsKey(revId)) {
+									filteredFileRevisions.add(rev);
+								}
+							} else {
+								filteredFileRevisions.add(rev);
+							}
+						}
+					}
+					fileRevisions = filteredFileRevisions;
+				}
+
 				findToolbar.setFileRevisions(fileRevisions, newtags, branches);
 				Display.getDefault().syncExec(new Runnable() {
 					public void run() {
@@ -891,6 +950,27 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		}
 	}
 
+	private void verifyCurrentHeadCommits(Repository repository, 
+			Map<String, String> parentMap, List<ObjectId> commitsToWalk, Commit initialCommit) throws IOException {
+		Commit commit = initialCommit;
+		while (commit.getParentIds() != null && commit.getParentIds().length > 0 
+				&& !parentMap.containsKey(commit.getCommitId().toString())) {
+			String cid = commit.getCommitId().toString();
+			parentMap.put(cid, cid);
+			commit = repository.mapCommit(commit.getParentIds()[0]);
+			int parentCount = commit.getParentIds().length;
+			if (parentCount > 1) {
+				for (int i = 1; i < parentCount; i++) {
+					commitsToWalk.add(commit.getParentIds()[i]);
+				}
+			}
+		}
+		while (commitsToWalk.size() > 0) {
+			commit = repository.mapCommit(commitsToWalk.remove(0));
+			verifyCurrentHeadCommits(repository, parentMap, commitsToWalk, commit);
+		}
+	}
+
 	HistoryRefreshJob historyRefreshJob = new HistoryRefreshJob("Git history refresh");
 	
 	class GitHistoryContentProvider implements ILazyContentProvider {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
index c8ca116..3464fe7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
@@ -41,6 +41,7 @@ public class PluginPreferenceInitializer extends AbstractPreferenceInitializer {
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_DETAIL, true);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, true);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false);
+		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_ONLY_CURRENT_BRANCH, false);
 
 		prefs.setDefault(UIPreferences.FINDTOOLBAR_IGNORE_CASE, true);
 		prefs.setDefault(UIPreferences.FINDTOOLBAR_FIND_IN, 2);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index a04bb5c..4021fdc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -42,6 +42,8 @@ public class UIIcons {
 
 	/** Find icon */
 	public static final ImageDescriptor ELCL16_FIND;
+	/** Show only commits in the current branch icon */
+	public static final ImageDescriptor ELCL16_HEAD;
 	/** Next arrow icon */
 	public static final ImageDescriptor ELCL16_NEXT;
 	/** Previous arrow icon */
@@ -67,6 +69,7 @@ public class UIIcons {
 		OVR_CONFLICT = map("ovr/conflict.gif");
 		OVR_ASSUMEVALID = map("ovr/assumevalid.gif");
 		ELCL16_FIND = map("elcl16/find.gif");
+		ELCL16_HEAD = map("elcl16/cbcommits.gif");
 		ELCL16_NEXT = map("elcl16/next.gif");
 		ELCL16_PREVIOUS = map("elcl16/previous.gif");
 		ELCL16_COMMIT = map("elcl16/commit.gif");
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index 2ff7589..fbc7064 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -32,6 +32,8 @@ public class UIPreferences {
 	/** */
 	public final static String RESOURCEHISTORY_SHOW_FINDTOOLBAR = "resourcehistory_show_findtoolbar";
 	/** */
+	public final static String RESOURCEHISTORY_SHOW_ONLY_CURRENT_BRANCH = "resourcehistory_show_only_current_branch";
+	/** */
 	public final static String FINDTOOLBAR_IGNORE_CASE = "findtoolbar_ignore_case";
 	/** */
 	public final static String FINDTOOLBAR_FIND_IN = "findtoolbar_find_in";
-- 
1.5.4.1
