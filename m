From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Show diffs for changed files under a new or deleted directory.
Date: Sun, 17 Feb 2008 10:55:46 -0500
Message-ID: <1203263746-2924-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 14:56:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQk0Y-0006Gz-Bx
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 14:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbYBQN4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 08:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbYBQN4G
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 08:56:06 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1103 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754871AbYBQN4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 08:56:05 -0500
Received: (qmail 92503 invoked by uid 0); 17 Feb 2008 10:58:51 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.669591 secs); 17 Feb 2008 13:58:51 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.208.28)
  by cvxbsd.convex.com.br with SMTP; 17 Feb 2008 13:58:51 -0000
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74133>

When a directory is added or removed in a commit the files under it 
were not being shown in the structure compare viewer. This fixes it by
adding diff nodes for all the files under this directory.

This patch also fixes some files showing as being removed in the
structure compare when they were actually being added.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
Hi Robin,

What is "TODO: Git ordering" supposed to change?

Please evaluate.

[]s,
Roger.


 .../GitCompareFileRevisionEditorInput.java         |   79 +++++++++++++++++---
 1 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
index d3bc92a..d72093b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
@@ -122,30 +122,65 @@ public class GitCompareFileRevisionEditorInput extends CompareEditorInput {
 			while (li<lc.length && ri<rc.length) {
 				ITypedElement ln = lc[li];
 				ITypedElement rn = rc[ri];
+				int compareTo = ln.getName().compareTo(rn.getName());
 				// TODO: Git ordering!
-				if (ln.getName().compareTo(rn.getName()) < 0) {
-					diffNode.add(new DiffNode(Differencer.ADDITION,null, ln, null));
-					++li;
-				}
-				if (ln.getName().compareTo(rn.getName()) > 0) {
-					diffNode.add(new DiffNode(Differencer.DELETION,null, null, rn));
-					++ri;
-				}
-				if (ln.getName().compareTo(rn.getName()) == 0) {
+				if (compareTo == 0) {
 					if (!ln.equals(rn))
 						diffNode.add(compare(ln,rn));
 					++li;
 					++ri;
+				} else if (compareTo < 0) {
+					DiffNode childDiffNode = new DiffNode(Differencer.ADDITION, null, ln, null);
+					diffNode.add(childDiffNode);
+					if (ln.getType().equals(ITypedElement.FOLDER_TYPE)) {
+						ITypedElement[] children = (ITypedElement[])((IStructureComparator)ln).getChildren();
+						if(children != null && children.length > 0) {
+							for (ITypedElement child : children) {
+								childDiffNode.add(addDirectoryFiles(child, Differencer.ADDITION));
+							}
+						}
+					}
+					++li;
+				} else {
+					DiffNode childDiffNode = new DiffNode(Differencer.DELETION, null, null, rn);
+					diffNode.add(childDiffNode);
+					if (rn.getType().equals(ITypedElement.FOLDER_TYPE)) {
+						ITypedElement[] children = (ITypedElement[])((IStructureComparator)rn).getChildren();
+						if(children != null && children.length > 0) {
+							for (ITypedElement child : children) {
+								childDiffNode.add(addDirectoryFiles(child, Differencer.DELETION));
+							}
+						}
+					}
+					++ri;
 				}
 			}
 			while (li<lc.length) {
 				ITypedElement ln = lc[li];
-				diffNode.add(new DiffNode(Differencer.ADDITION,null, ln, null));
+				DiffNode childDiffNode = new DiffNode(Differencer.ADDITION, null, ln, null);
+				diffNode.add(childDiffNode);
+				if (ln.getType().equals(ITypedElement.FOLDER_TYPE)) {
+					ITypedElement[] children = (ITypedElement[])((IStructureComparator)ln).getChildren();
+					if(children != null && children.length > 0) {
+						for (ITypedElement child : children) {
+							childDiffNode.add(addDirectoryFiles(child, Differencer.ADDITION));
+						}
+					}
+				}
 				++li;
 			}
 			while (ri<rc.length) {
 				ITypedElement rn = rc[ri];
-				diffNode.add(new DiffNode(Differencer.ADDITION,null, null, rn));
+				DiffNode childDiffNode = new DiffNode(Differencer.DELETION, null, null, rn);
+				diffNode.add(childDiffNode);
+				if (rn.getType().equals(ITypedElement.FOLDER_TYPE)) {
+					ITypedElement[] children = (ITypedElement[])((IStructureComparator)rn).getChildren();
+					if(children != null && children.length > 0) {
+						for (ITypedElement child : children) {
+							childDiffNode.add(addDirectoryFiles(child, Differencer.DELETION));
+						}
+					}
+				}
 				++ri;
 			}
 			return diffNode;
@@ -154,6 +189,28 @@ public class GitCompareFileRevisionEditorInput extends CompareEditorInput {
 		}
 	}
 
+	private DiffNode addDirectoryFiles(ITypedElement elem, int diffType) {
+		ITypedElement l = null;
+		ITypedElement r = null;
+		if (diffType == Differencer.DELETION) {
+			r = elem;
+		} else {
+			l = elem;
+		}
+
+		if (elem.getType().equals(ITypedElement.FOLDER_TYPE)) {
+			DiffNode diffNode = null;
+			diffNode = new DiffNode(null,Differencer.CHANGE,null,l,r);
+			ITypedElement[] children = (ITypedElement[])((IStructureComparator)elem).getChildren();
+			for (ITypedElement child : children) {
+				diffNode.add(addDirectoryFiles(child, diffType));
+			}
+			return diffNode;
+		} else {
+			return new DiffNode(diffType, null, l, r);
+		}
+	}
+
 	private void initLabels(ICompareInput input) {
 		CompareConfiguration cc = getCompareConfiguration();
 		if(left != null && left instanceof GitResourceNode) {
-- 
1.5.3.8
