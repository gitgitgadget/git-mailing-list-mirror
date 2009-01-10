From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/3] Present type of change with file revision in diff viewer
Date: Sat, 10 Jan 2009 02:14:36 +0100
Message-ID: <1231550077-1057-3-git-send-email-robin.rosenberg@dewire.com>
References: <1231550077-1057-1-git-send-email-robin.rosenberg@dewire.com>
 <1231550077-1057-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jan 10 02:16:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSSR-0002Kg-03
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbZAJBOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbZAJBOr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:14:47 -0500
Received: from mail.dewire.com ([83.140.172.130]:8473 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687AbZAJBOo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:14:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0C8B91484F6C;
	Sat, 10 Jan 2009 02:14:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gecJJlTJ57J; Sat, 10 Jan 2009 02:14:40 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 140711484F6D;
	Sat, 10 Jan 2009 02:14:39 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231550077-1057-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105058>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/egit/ui/internal/history/RevDiff.java  |   40 +++++++++++++++++++-
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java
index 020ec73..084da3b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java
@@ -2,9 +2,13 @@
 
 import org.eclipse.compare.ITypedElement;
 import org.eclipse.compare.structuremergeviewer.IStructureComparator;
+import org.eclipse.jface.resource.ImageDescriptor;
+import org.eclipse.jface.viewers.DecorationOverlayIcon;
+import org.eclipse.jface.viewers.IDecoration;
 import org.eclipse.swt.graphics.Image;
 import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
 import org.spearce.egit.core.internal.storage.GitFileRevision;
+import org.spearce.egit.ui.UIIcons;
 import org.spearce.jgit.lib.Repository;
 
 class RevDiff {
@@ -46,9 +50,41 @@ public String getType() {
 	public Object[] getChildren() {
 		FileRevisionTypedElement[] ret = new FileRevisionTypedElement[fileDiffs.length];
 		for (int i = 0; i < ret.length; ++i) {
+			final FileDiff d = fileDiffs[i];
 			ret[i] = new FileRevisionTypedElement(GitFileRevision.inCommit(db,
-					fileDiffs[i].commit, fileDiffs[i].path,
-					fileDiffs[i].blobs[side]));
+					d.commit, d.path, d.blobs[side])) {
+				private Image image;
+
+				@Override
+				protected void finalize() throws Throwable {
+					if (image != null)
+						image.dispose();
+				}
+
+				@Override
+				public Image getImage() {
+					if (image == null) {
+						ImageDescriptor overlay;
+						switch (d.change.charAt(0)) {
+						case 'A':
+							overlay = UIIcons.OVR_PENDING_ADD;
+							break;
+						case 'M':
+							overlay = UIIcons.OVR_SHARED;
+							break;
+						case 'D':
+							overlay = UIIcons.OVR_PENDING_REMOVE;
+							break;
+						default:
+							return super.getImage(); // Should not happen...
+						}
+						image = new DecorationOverlayIcon(super.getImage(),
+								overlay, IDecoration.BOTTOM_RIGHT)
+								.createImage();
+					}
+					return image;
+				}
+			};
 		}
 		return ret;
 	}
-- 
1.6.1.rc3.56.gd0306
