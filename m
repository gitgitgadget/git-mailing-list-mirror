From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] showing commiter and parent commit(s) on the revision detail viewer
Date: Fri, 25 Jan 2008 10:02:09 -0200
Message-ID: <1201262529-3306-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg.lists@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 13:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JINLl-0002M0-Vk
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 13:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbYAYMHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 07:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbYAYMHX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 07:07:23 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1402 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753632AbYAYMHW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 07:07:22 -0500
Received: (qmail 6105 invoked by uid 0); 25 Jan 2008 10:10:28 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.961442 secs); 25 Jan 2008 12:10:28 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.248.8)
  by cvxbsd.convex.com.br with SMTP; 25 Jan 2008 12:10:26 -0000
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71700>

---
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   57 +++++++++++++++++---
 1 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 649df3f..cc11b97 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -88,7 +88,9 @@ import org.spearce.egit.core.internal.mapping.GitFileHistoryProvider;
 import org.spearce.egit.core.internal.mapping.GitFileRevision;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.internal.actions.GitCompareRevisionAction;
+import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.lib.TopologicalSorter;
 import org.spearce.jgit.lib.Repository.StGitPatch;
@@ -221,14 +223,16 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				if(selection2.length == 1) {
 					// if the table item is not visible in the UI and it's selected via keyboard
 					// this listener is called before the listener that sets the item data.
-					if(selection2[0] == null) {
+					GitCommitFileRevision revision = (GitCommitFileRevision) selection2[0];
+					if(revision == null) {
 						int ix = table.getSelectionIndex();
-						GitFileRevision revision = (GitFileRevision) fileRevisions.get(ix);
+						revision = (GitCommitFileRevision) fileRevisions.get(ix);
 						selection2[0] = revision;
 					}
-					setRevisionInfoTextViewers(selection2[0]);
+					setRevisionInfoTextViewers(revision);
 				}
 
+
 				compareAction.setCurrentFileRevision(fileRevisions.get(0));
 				compareAction.selectionChanged(new StructuredSelection(
 						selection2));
@@ -554,7 +558,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		revCommentTextViewer = new TextViewer(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.READ_ONLY);
 	}
 
-	/* private */void setRevisionInfoTextViewers(IFileRevision rev) {
+	/* private */void setRevisionInfoTextViewers(GitCommitFileRevision rev) {
 		StringBuilder revisionInfo = new StringBuilder();
 		if (appliedPatches != null) {
 			String id = rev.getContentIdentifier();
@@ -570,7 +574,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 			}
 		}
 		if (revisionInfo.length() == 0) {
-			revisionInfo.append("Commit: ");
+			revisionInfo.append("Commit ID: ");
 			revisionInfo.append(rev.getContentIdentifier());
 		}
 
@@ -673,10 +677,30 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 			e.printStackTrace();
 		}
 
+		Commit commit = rev.getCommit();
 		revisionInfo.append("\nAuthor: ");
-		revisionInfo.append(rev.getAuthor());
-		revisionInfo.append("\nDate: ");
-		revisionInfo.append(DATETIMETZ_FORMAT.format(new Date(rev.getTimestamp())));
+		revisionInfo.append(formatPersonIdentForRevInfo(commit.getAuthor()));
+		revisionInfo.append("\nCommiter: ");
+		revisionInfo.append(formatPersonIdentForRevInfo(commit.getCommitter()));
+		if(commit.getParentIds() != null) {
+			for(ObjectId pid : commit.getParentIds()) {
+				revisionInfo.append("\nParent: ");
+				revisionInfo.append(pid.toString());
+				try {
+					Commit pc = repositoryMapping.getRepository().mapCommit(pid);
+					revisionInfo.append(" (");
+					String cmesg = pc.getMessage();
+					int enterIndex = cmesg.indexOf("\n");
+					if(enterIndex > 0) {
+						cmesg = cmesg.substring(0, enterIndex);
+					}
+					revisionInfo.append(cmesg);
+					revisionInfo.append(" )");
+				} catch (IOException e) {
+					e.printStackTrace();
+				}
+			}
+		}
 
 		String comment = rev.getComment();
 		revDetailTextViewer.setDocument(new Document(revisionInfo.toString()));
@@ -691,6 +715,23 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		if (workbenchPageSite != null) {
 			workbenchPageSite.getActionBars().getStatusLineManager().setMessage(comment);
 		}
+
+	}
+
+	private String formatPersonIdentForRevInfo(PersonIdent p) {
+		StringBuilder sb = new StringBuilder();
+		sb.append(p.getName());
+		if(p.getEmailAddress() != null) {
+			sb.append(" <");
+			sb.append(p.getEmailAddress());
+			sb.append(">");
+		}
+		if(p.getWhen() != null) {
+			sb.append(" ");
+			sb.append(DATETIMETZ_FORMAT.format(p.getWhen()));
+		}
+
+		return sb.toString();
 	}
 
 	/* private */void cleanRevisionInfoTextViewers() {
-- 
1.5.3.7
