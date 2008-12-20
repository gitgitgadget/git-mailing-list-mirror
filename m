From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Use the possible resources's specific encoding for quickdiff
Date: Sun, 21 Dec 2008 00:14:28 +0100
Message-ID: <1229814868-13916-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Dec 21 00:15:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEB31-0000M9-T5
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 00:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbYLTXOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 18:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbYLTXOd
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 18:14:33 -0500
Received: from mail.dewire.com ([83.140.172.130]:6172 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbYLTXOc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 18:14:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DC9F31484F40;
	Sun, 21 Dec 2008 00:14:29 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F4egEbGsZMfe; Sun, 21 Dec 2008 00:14:29 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id D8240802E24;
	Sun, 21 Dec 2008 00:14:28 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103672>

Encoding can be defined in many places. It could be defined for a specific
resource, workspace, JVM invocation or platform. Let Eclipse handle the
logic. We always ask for the current revisions encoding, which in theory
could be different from the encoding specified for the version we are
retrieving.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/decorators/GitDocument.java   |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index a985a68..a9c0c7d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -9,8 +9,10 @@
 
 import java.io.IOException;
 
+import org.eclipse.core.resources.IEncodedStorage;
 import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
+import org.eclipse.core.runtime.CoreException;
 import org.eclipse.jface.text.Document;
 import org.eclipse.team.core.RepositoryProvider;
 import org.spearce.egit.core.GitProvider;
@@ -66,7 +68,23 @@ void populate() throws IOException {
 			Activator.trace("(GitQuickDiffProvider) compareTo: " + baseline);
 			ObjectLoader loader = repository.openBlob(blobEnry.getId());
 			byte[] bytes = loader.getBytes();
-			String s = new String(bytes); // FIXME Platform default charset. should be Eclipse default
+			String charset;
+			// Get the encoding for the current version. As a matter of
+			// principle one might want to use the eclipse settings for the
+			// version we are retrieving as that may be defined by the
+			// project settings, but there is no historic API for this.
+			IEncodedStorage encodedStorage = ((IEncodedStorage)resource);
+			try {
+				if (encodedStorage != null)
+					charset = encodedStorage.getCharset();
+				else
+					charset = resource.getParent().getDefaultCharset();
+			} catch (CoreException e) {
+				charset = Constants.CHARACTER_ENCODING;
+			}
+			// Finally we could consider validating the content with respect
+			// to the content. We don't do that here.
+			String s = new String(bytes, charset);
 			set(s);
 			Activator.trace("(GitQuickDiffProvider) has reference doc, size=" + s.length() + " bytes");
 		} else {
-- 
1.6.1.rc3.56.gd0306
