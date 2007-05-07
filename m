From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 10/10] Enable a tooltip in the history view
Date: Mon, 07 May 2007 23:30:09 +0200
Message-ID: <20070507213009.21546.55877.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:31:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAnU-0004Dl-Lr
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966834AbXEGVav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966811AbXEGVau
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:30:50 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12289 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966981AbXEGVar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:30:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id ACFED802676;
	Mon,  7 May 2007 23:24:41 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24821-03; Mon,  7 May 2007 23:24:41 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 3FBDD800783;
	Mon,  7 May 2007 23:24:41 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id D7FAF2926D;
	Mon,  7 May 2007 23:30:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id SdAZa7UGCMTN; Mon,  7 May 2007 23:30:36 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 386FA294E6;
	Mon,  7 May 2007 23:30:09 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46492>

This tooltip show the comment in full rather than the first line only.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   27 +++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 57fefcc..e5d92fe 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -48,9 +48,11 @@ import org.eclipse.jface.viewers.Viewer;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.MouseEvent;
 import org.eclipse.swt.events.MouseListener;
+import org.eclipse.swt.events.MouseMoveListener;
 import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
 import org.eclipse.swt.graphics.Image;
+import org.eclipse.swt.graphics.Point;
 import org.eclipse.swt.layout.GridData;
 import org.eclipse.swt.layout.GridLayout;
 import org.eclipse.swt.widgets.Composite;
@@ -136,6 +138,31 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		
 		});
 
+		tree.addMouseMoveListener(new MouseMoveListener() {
+			TreeItem lastItem;
+			public void mouseMove(MouseEvent e) {
+				TreeItem item = tree.getItem(new Point(e.x,e.y));
+				if (item != null && item!=lastItem) {
+					IFileRevision rev = (IFileRevision) item.getData();
+					String commitStr=null;
+					if (appliedPatches!=null) {
+						String id = rev.getContentIdentifier();
+						if (!id.equals("Workspace")) {
+							StGitPatch patch = (StGitPatch) appliedPatches.get(new ObjectId(id));
+							if (patch!=null)
+								commitStr = "Patch: "+patch.getName();
+						} else {
+							commitStr = "Workspace:";
+						}
+					}
+					if (commitStr == null)
+						commitStr = "Commit: "+rev.getContentIdentifier();
+					tree.setToolTipText(commitStr+"\nAuthor:\t"+rev.getAuthor()+"\nDate:\t"+new Date(rev.getTimestamp())+"\n\n"+rev.getComment());
+				}
+				lastItem = item;
+			}
+		});
+
 		tree.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
 				// update the current
