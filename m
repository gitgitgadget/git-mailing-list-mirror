From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Remove directory entries from Structure Compare view.
Date: Fri, 4 Jan 2008 00:11:17 -0200
Organization: Intelinet
Message-ID: <200801040011.17934.rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 03:22:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAcCP-0007a6-7o
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 03:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYADCVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 21:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbYADCVt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 21:21:49 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1306 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752249AbYADCVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 21:21:48 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2008 21:21:47 EST
Received: (qmail 42100 invoked by uid 0); 4 Jan 2008 00:17:55 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.011292 secs); 04 Jan 2008 02:17:55 -0000
Received: from unknown (HELO ?192.168.1.2?) (189.5.219.143)
  by cvxbsd.convex.com.br with SMTP; 4 Jan 2008 02:17:54 -0000
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69546>

Date: Wed, 2 Jan 2008 22:51:33 -0200

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
Please evaluate.

 .../GitCompareFileRevisionEditorInput.java         |   25 +++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java 
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
index 82cd205..eaba1fa 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
@@ -21,6 +21,7 @@ import org.eclipse.compare.ITypedElement;
 import org.eclipse.compare.structuremergeviewer.DiffNode;
 import org.eclipse.compare.structuremergeviewer.Differencer;
 import org.eclipse.compare.structuremergeviewer.ICompareInput;
+import org.eclipse.compare.structuremergeviewer.IDiffElement;
 import org.eclipse.compare.structuremergeviewer.IStructureComparator;
 import org.eclipse.core.resources.IFile;
 import org.eclipse.core.resources.IFileState;
@@ -299,7 +300,29 @@ public class GitCompareFileRevisionEditorInput extends CompareEditorInput {
 		ensureContentsCached(getLeftRevision(), getRightRevision(), monitor);
 		initLabels(input);
 		setTitle(NLS.bind(TeamUIMessages.SyncInfoCompareInput_title, new String[] { input.getName() }));
-		return input;
+
+		// The compare editor (Structure Compare) will show the diff filenames
+		// with their project relative path. So, no need to also show directory entries.
+		DiffNode flatDiffNode = new DiffNode(null,Differencer.CHANGE,null,left,right);
+		flatDiffView(flatDiffNode, (DiffNode) input);
+
+		return flatDiffNode;
+	}
+
+	private void flatDiffView(DiffNode rootNode, DiffNode currentNode) {
+		if(currentNode != null) {
+			IDiffElement[] dElems = currentNode.getChildren();
+			if(dElems != null) {
+				for(IDiffElement dElem : dElems) {
+					DiffNode dNode = (DiffNode) dElem;
+					if(dNode.getChildren() != null && dNode.getChildren().length > 0) {
+						flatDiffView(rootNode, dNode);
+					} else {
+						rootNode.add(dNode);
+					}
+				}
+			}
+		}
 	}
 
 }
-- 
1.5.3.7
