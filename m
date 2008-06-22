From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Clone: Handle cancel in clone dialog specially
Date: Sun, 22 Jun 2008 19:46:36 +0200
Message-ID: <1214156797-29186-2-git-send-email-robin.rosenberg@dewire.com>
References: <20080622013640.GA18629@spearce.org>
 <1214156797-29186-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 21:01:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAUoU-0004am-HY
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 21:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbYFVTA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 15:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbYFVTA0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 15:00:26 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:63566 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753271AbYFVTA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 15:00:26 -0400
X-Greylist: delayed 4197 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jun 2008 15:00:26 EDT
Received: from localhost.localdomain (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB003C2068; Sun, 22 Jun 2008 19:50:28 +0200
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1214156797-29186-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85794>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    3 +++
 .../egit/ui/internal/clone/SourceBranchPage.java   |   18 ++++++++++++------
 .../src/org/spearce/egit/ui/uitext.properties      |    2 ++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 9ccf606..4adb99c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -122,6 +122,9 @@ public class UIText extends NLS {
 	public static String SourceBranchPage_cannotListBranches;
 
 	/** */
+	public static String SourceBranchPage_remoteListingCancelled;
+
+	/** */
 	public static String CloneDestinationPage_title;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
index b2f1a18..615be32 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/SourceBranchPage.java
@@ -20,6 +20,7 @@ import java.util.List;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.IStatus;
 import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.core.runtime.OperationCanceledException;
 import org.eclipse.core.runtime.Status;
 import org.eclipse.jface.dialogs.ErrorDialog;
 import org.eclipse.jface.operation.IRunnableWithProgress;
@@ -269,12 +270,17 @@ class SourceBranchPage extends WizardPage {
 			});
 		} catch (InvocationTargetException e) {
 			Throwable why = e.getCause();
-			ErrorDialog.openError(getShell(),
-					UIText.SourceBranchPage_transportError,
-					UIText.SourceBranchPage_cannotListBranches, new Status(
-							IStatus.ERROR, Activator.getPluginId(), 0, why
-									.getMessage(), why.getCause()));
-			transportError(why.getMessage());
+			if ((why instanceof OperationCanceledException)) {
+				transportError(UIText.SourceBranchPage_remoteListingCancelled);
+				return;
+			} else {
+				ErrorDialog.openError(getShell(),
+						UIText.SourceBranchPage_transportError,
+						UIText.SourceBranchPage_cannotListBranches, new Status(
+								IStatus.ERROR, Activator.getPluginId(), 0, why
+										.getMessage(), why.getCause()));
+				transportError(why.getMessage());
+			}
 			return;
 		} catch (InterruptedException e) {
 			transportError(UIText.SourceBranchPage_interrupted);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 18f8c28..9516aa0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -55,6 +55,8 @@ SourceBranchPage_errorBranchRequired=At least one branch must be selected.
 SourceBranchPage_transportError=Transport Error
 SourceBranchPage_cannotListBranches=Cannot list the available branches.
 SourceBranchPage_interrupted=Connection attempt interrupted.
+SourceBranchPage_remoteListingCancelled=Operation cancelled
+
 
 CloneDestinationPage_title=Local Destination
 CloneDestinationPage_description=Configure the local storage location for {0}.
-- 
1.5.5.1.178.g1f811
