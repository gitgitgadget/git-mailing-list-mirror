From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 6/9] Add branch and StGit patch to decorator
Date: Wed, 28 Feb 2007 23:26:37 +0100
Message-ID: <20070228222637.12021.63285.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXLd-0002xY-8s
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXB1WcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbXB1WcP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1417 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932567AbXB1WcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B339B8033AC
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:00 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18378-02 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:00 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 57D69802E1C
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:00 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 4CB5D29875
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id F8PMh3g5hP5x for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:37 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id ADF3029865
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:37 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41016>

This makes it easier to see in what context you are working.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../internal/decorators/GitResourceDecorator.java  |   20 ++++++++++++++++----
 .../src/org/spearce/jgit/lib/Repository.java       |   22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index bde6182..da2e256 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -16,6 +16,8 @@
  */
 package org.spearce.egit.ui.internal.decorators;
 
+import java.io.IOException;
+
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.IAdaptable;
@@ -30,6 +32,7 @@ import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.MergedTree;
+import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.TreeEntry;
 
 /**
@@ -110,10 +113,19 @@ public class GitResourceDecorator extends LabelProvider implements
 			final MergedTree diff = mapped.getActiveDiff();
 			if (diff != null && diff.isModified())
 				decoration.addPrefix(">");
-			if (mapped.getRepository().isStGitMode())
-				decoration.addSuffix(" [StGit]");
-			else
-				decoration.addSuffix(" [Git]");
+			Repository repo = mapped.getRepository();
+			try {
+				String branch = repo.getBranch();
+				if (repo.isStGitMode()) {
+					String patch = repo.getPatch();
+					decoration.addSuffix(" [StGit " + patch + "@" + branch +"]");
+				} else {
+					decoration.addSuffix(" [Git @ "+ branch + "]");
+				}
+			} catch (IOException e) {
+				e.printStackTrace();
+				decoration.addSuffix(" [Git ?]");
+			}
 			decoration.addOverlay(UIIcons.OVR_SHARED);
 			return;
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 5e0e89a..d2943c3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -342,6 +342,27 @@ public class Repository {
 		return "Repository[" + getDirectory() + "]";
 	}
 
+	public String getPatch() throws IOException {
+		final File ptr = new File(getDirectory(),"patches/"+getBranch()+"/current");
+		final BufferedReader br = new BufferedReader(new FileReader(ptr));
+		final String line = br.readLine();
+		return line;
+	}
+	public String getBranch() throws IOException {
+		final File ptr = new File(getDirectory(),"HEAD");
+		final BufferedReader br = new BufferedReader(new FileReader(ptr));
+		final String line = br.readLine();
+		
+		String ref;
+		if (line.startsWith("ref: "))
+			ref = line.substring(5);
+		else
+			ref = line; 
+		if (ref.startsWith("refs/heads/"))
+			ref = ref.substring(11);
+		return ref;
+	}
+
 	public Collection getBranches() {
 		return listFilesRecursively(new File(refsDir, "heads"), null);
 	}
@@ -391,4 +412,5 @@ public class Repository {
 		}
 		return ret;
 	}
+
 }
