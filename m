From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 1/2] Show committer and parent commit(s) on the revision detail viewer.
Date: Sun, 27 Jan 2008 00:29:27 -0200
Message-ID: <1201400967-5860-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 03:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIxDh-0005MQ-TC
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 03:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbYA0CZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 21:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbYA0CZ2
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 21:25:28 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1739 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751158AbYA0CZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 21:25:27 -0500
Received: (qmail 35806 invoked by uid 0); 27 Jan 2008 00:28:24 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.64403 secs); 27 Jan 2008 02:28:24 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.215.94)
  by cvxbsd.convex.com.br with SMTP; 27 Jan 2008 02:28:23 -0000
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71798>

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
Hi Robin,

Here it goes again.

[]s,
Roger.

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   56 +++++++++++++++++---
 1 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 649df3f..289331c 100644
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
@@ -221,12 +223,13 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				if(selection2.length == 1) {
 					// if the table item is not visible in the UI and it's selected via keyboard
 					// this listener is called before the listener that sets the item data.
-					if(selection2[0] == null) {
+					IFileRevision revision = selection2[0];
+					if(revision == null) {
 						int ix = table.getSelectionIndex();
-						GitFileRevision revision = (GitFileRevision) fileRevisions.get(ix);
+						revision = fileRevisions.get(ix);
 						selection2[0] = revision;
 					}
-					setRevisionInfoTextViewers(selection2[0]);
+					setRevisionInfoTextViewers((GitCommitFileRevision)revision);
 				}
 
 				compareAction.setCurrentFileRevision(fileRevisions.get(0));
@@ -554,7 +557,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		revCommentTextViewer = new TextViewer(composite, SWT.H_SCROLL | SWT.V_SCROLL | SWT.READ_ONLY);
 	}
 
-	/* private */void setRevisionInfoTextViewers(IFileRevision rev) {
+	/* private */void setRevisionInfoTextViewers(GitCommitFileRevision rev) {
 		StringBuilder revisionInfo = new StringBuilder();
 		if (appliedPatches != null) {
 			String id = rev.getContentIdentifier();
@@ -616,6 +619,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				}
 			}
 		} catch (IOException e) {
+			// TODO: better error handling.
 			e.printStackTrace();
 		}
 
@@ -673,10 +677,31 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 			e.printStackTrace();
 		}
 
+		Commit commit = rev.getCommit();
 		revisionInfo.append("\nAuthor: ");
-		revisionInfo.append(rev.getAuthor());
-		revisionInfo.append("\nDate: ");
-		revisionInfo.append(DATETIMETZ_FORMAT.format(new Date(rev.getTimestamp())));
+		revisionInfo.append(formatPersonIdentForRevInfo(commit.getAuthor()));
+		revisionInfo.append("\nCommitter: ");
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
+					// TODO: better error handling.
+					e.printStackTrace();
+				}
+			}
+		}
 
 		String comment = rev.getComment();
 		revDetailTextViewer.setDocument(new Document(revisionInfo.toString()));
@@ -691,6 +716,23 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
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
