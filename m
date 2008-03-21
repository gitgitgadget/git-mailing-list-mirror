From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 4/4] Show changed files in the revision detail viewer.
Date: Fri, 21 Mar 2008 18:08:31 -0400
Message-ID: <1206137311-4097-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 22:10:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcoV8-0007iP-0E
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 22:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbYCUVJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756299AbYCUVJ3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 17:09:29 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1164 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753800AbYCUVJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 17:09:28 -0400
Received: (qmail 92460 invoked by uid 0); 21 Mar 2008 18:12:07 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.182727 secs); 21 Mar 2008 21:12:07 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.226.196)
  by cvxbsd.convex.com.br with SMTP; 21 Mar 2008 21:12:05 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77769>

Shows files changed from the parent commits in the revision detail viewer.
It gives a better idea of the impact of a commit when browsing the
history.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../org/spearce/egit/ui/RevisionInfoThread.java    |  130 ++++++++++++++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfoThread.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfoThread.java
index 27fd87f..f5d5754 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfoThread.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/RevisionInfoThread.java
@@ -16,6 +16,7 @@
  */
 package org.spearce.egit.ui;
 
+import java.io.IOException;
 import java.util.Set;
 import java.util.concurrent.CancellationException;
 
@@ -29,6 +30,8 @@ import org.spearce.egit.core.util.CommitMetaInfo;
 import org.spearce.egit.core.util.RepositoryUtil;
 import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Tree;
+import org.spearce.jgit.lib.TreeEntry;
 
 /**
  * This class prints info the revisionInfo viewer that may take some time to be
@@ -132,6 +135,39 @@ public class RevisionInfoThread extends Thread implements IProgressMonitor {
 				}
 				metaInfo.append("\n");
 			}
+
+			if (revThread.currentThreadIx < globalThreadIx) {
+				return;
+			}
+			print(revThread, metaInfo, null);
+
+			// List changed files.
+			ObjectId[] parentIds = commit.getParentIds();
+			if (parentIds.length > 0) {
+				Commit current = revThread.repositoryMapping.getRepository()
+						.mapCommit(revThread.rev.getCommitId());
+				int count = 0;
+				for (ObjectId parentId : parentIds) {
+					Commit previous = revThread.repositoryMapping
+							.getRepository().mapCommit(parentId);
+
+					StringBuilder changedFiles;
+					changedFiles = compare(current.getTree(), previous
+							.getTree(), revThread);
+					metaInfo.append("\n");
+					metaInfo.append("Files changed from ");
+					metaInfo.append(revThread.parentDescs[count]);
+					metaInfo.append(":\n");
+					metaInfo.append(changedFiles);
+
+					count++;
+				}
+			} else {
+				metaInfo.append("\n");
+				metaInfo.append("Initial commit");
+				metaInfo.append(":\n");
+				addDirectoryFiles(metaInfo, revThread.rev.getTreeEntry(), true);
+			}
 		} catch (CancellationException e) {
 			return;
 		} catch (Exception e) {
@@ -173,6 +209,100 @@ public class RevisionInfoThread extends Thread implements IProgressMonitor {
 		});
 	}
 
+	private static String ADDED_MARK = "+\t";
+
+	private static String DELETED_MARK = "-\t";
+
+	private static String MODIFIED_MARK = "\t";
+
+	private static StringBuilder compare(Tree current, Tree parent,
+			RevisionInfoThread revThread) throws IOException,
+			CancellationException {
+		StringBuilder sb = new StringBuilder();
+		TreeEntry[] c = current.members();
+		TreeEntry[] p = parent.members();
+		int cix = 0;
+		int pix = 0;
+
+		while (cix < c.length && pix < p.length) {
+			TreeEntry compC = c[cix];
+			TreeEntry compP = p[pix];
+			int compareTo = compC.getName().compareTo(compP.getName());
+			if (compareTo == 0) {
+				if (!compC.getId().equals(compP.getId())) {
+					if (compC instanceof Tree && compP instanceof Tree) {
+						sb
+								.append(compare((Tree) compC, (Tree) compP,
+										revThread));
+					} else if (compC instanceof Tree) {
+						sb.append(DELETED_MARK);
+						sb.append(compP.getFullName());
+						sb.append("\n");
+						addDirectoryFiles(sb, compC, true);
+					} else if (compP instanceof Tree) {
+						addDirectoryFiles(sb, compP, false);
+						sb.append(ADDED_MARK);
+						sb.append(compC.getFullName());
+						sb.append("\n");
+					} else {
+						sb.append(MODIFIED_MARK);
+						sb.append(compC.getFullName());
+						sb.append("\n");
+					}
+				}
+				cix++;
+				pix++;
+			} else if (compareTo < 0) {
+				addDirectoryFiles(sb, compC, true);
+				cix++;
+			} else {
+				addDirectoryFiles(sb, compP, false);
+				pix++;
+			}
+			if (revThread.currentThreadIx < globalThreadIx) {
+				throw new CancellationException("getCommitMetaInfo cancelled");
+			}
+		}
+		while (cix < c.length) {
+			addDirectoryFiles(sb, c[cix], true);
+			cix++;
+		}
+		while (pix < p.length) {
+			addDirectoryFiles(sb, p[pix], false);
+			pix++;
+		}
+
+		return sb;
+	}
+
+	private static void addDirectoryFiles(StringBuilder sb, TreeEntry te,
+			boolean isAdd) throws IOException {
+		if (te instanceof Tree) {
+			TreeEntry[] members = ((Tree) te).members();
+			for (TreeEntry member : members) {
+				if (member instanceof Tree) {
+					addDirectoryFiles(sb, member, isAdd);
+				} else {
+					if (isAdd) {
+						sb.append(ADDED_MARK);
+					} else {
+						sb.append(DELETED_MARK);
+					}
+					sb.append(member.getFullName());
+					sb.append("\n");
+				}
+			}
+		} else {
+			if (isAdd) {
+				sb.append(ADDED_MARK);
+			} else {
+				sb.append(DELETED_MARK);
+			}
+			sb.append(te.getFullName());
+			sb.append("\n");
+		}
+	}
+
 	static void updateGlobalThreadIx() {
 		++globalThreadIx;
 	}
-- 
1.5.4.1
