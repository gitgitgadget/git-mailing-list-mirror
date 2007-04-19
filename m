From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 3/3] Show patch name in history view
Date: Thu, 19 Apr 2007 19:10:47 +0000
Message-ID: <20070419191047.19224.99661.stgit@lathund.dewire.com>
References: <20070419191036.19224.81654.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 19 21:07:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hebyv-0001MY-Hx
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766943AbXDSTHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 15:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766944AbXDSTHc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 15:07:32 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21302 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1766943AbXDSTHb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 15:07:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 98D14A149BE;
	Thu, 19 Apr 2007 21:01:41 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20805-06; Thu, 19 Apr 2007 21:01:41 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 13CE3802873;
	Thu, 19 Apr 2007 21:01:41 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id CB7B8291D9;
	Thu, 19 Apr 2007 21:10:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ehjRRISMUOu2; Thu, 19 Apr 2007 19:10:50 +0000 (UTC)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 0807E29210;
	Thu, 19 Apr 2007 21:10:48 +0200 (CEST)
In-Reply-To: <20070419191036.19224.81654.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45039>

Substitute commit id for patch name if a commit represents a patch state.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   20 ++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   38 +++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 5655105..c72e1f1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -18,6 +18,7 @@ package org.spearce.egit.ui;
 
 import java.io.IOException;
 import java.util.Date;
+import java.util.Map;
 
 import org.eclipse.compare.CompareConfiguration;
 import org.eclipse.compare.structuremergeviewer.ICompareInput;
@@ -69,6 +70,7 @@ import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.internal.actions.GitCompareRevisionAction;
 import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository.StGitPatch;
 
 public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		IHistoryCompareAdapter {
@@ -198,6 +200,11 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				String rss = ((IFileRevision) element).getURI().toString();
 				String rs = rss.substring(rss.length()-10);
 				String id = ((IFileRevision) element).getContentIdentifier();
+				if (appliedPatches!=null) {
+					StGitPatch patch = (StGitPatch) appliedPatches.get(new ObjectId(id));
+					if (patch!=null)
+						return patch.getName();
+				}
 				if (id != null)
 					if (id.length() > 9) // make sure "Workspace" is spelled out
 						return id.substring(0, 7) + "..";
@@ -280,6 +287,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		viewer.setInput(getInput());
 	}
 
+	private Map appliedPatches;
+
 	class GitHistoryContentProvider implements ITreeContentProvider,
 			ILazyTreeContentProvider {
 
@@ -288,8 +297,17 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				return;
 			System.out.println("inputChanged(" + viewer + "," + oldInput + ","
 					+ newInput);
+			IProject project = ((IResource) getInput()).getProject();
 			RepositoryProvider provider = RepositoryProvider
-					.getProvider(((IResource) getInput()).getProject());
+					.getProvider(project);
+			RepositoryMapping repositoryMapping = ((GitProvider)provider).getData().getRepositoryMapping(project);
+			try {
+				appliedPatches = null;
+				appliedPatches = repositoryMapping.getRepository().getAppliedPatches();
+			} catch (IOException e) {
+				// TODO Auto-generated catch block
+				e.printStackTrace();
+			}
 			IFileHistoryProvider fileHistoryProvider = provider
 					.getFileHistoryProvider();
 			IFileHistory fileHistoryFor = fileHistoryProvider
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 5c31092..501dcc8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -27,6 +27,7 @@ import java.lang.ref.Reference;
 import java.lang.ref.SoftReference;
 import java.util.ArrayList;
 import java.util.Collection;
+import java.util.HashMap;
 import java.util.Map;
 import java.util.WeakHashMap;
 
@@ -477,6 +478,43 @@ public class Repository {
 		}
 	}
 
+	public static class StGitPatch {
+		public StGitPatch(String patchName, ObjectId id) {
+			name = patchName;
+			gitId = id;
+		}
+		public ObjectId getGitId() {
+			return gitId;
+		}
+		public String getName() {
+			return name;
+		}
+		private String name;
+		private ObjectId gitId;		
+	}
+
+	/**
+	 * @return applied patches in a map indexed on current commit id
+	 * @throws IOException
+	 */
+	public Map getAppliedPatches() throws IOException {
+		Map ret = new HashMap();
+		if (isStGitMode()) {
+			File patchDir = new File(new File(getDirectory(),"patches"),getBranch());
+			BufferedReader apr = new BufferedReader(new FileReader(new File(patchDir,"applied")));
+			for (String patchName=apr.readLine(); patchName!=null; patchName=apr.readLine()) {
+				File topFile = new File(new File(new File(patchDir,"patches"), patchName), "top");
+				BufferedReader tfr = new BufferedReader(new FileReader(topFile));
+				String objectId = tfr.readLine();
+				ObjectId id = new ObjectId(objectId);
+				ret.put(id, new StGitPatch(patchName, id));
+				tfr.close();
+			}
+			apr.close();
+		}
+		return ret;
+	}
+	
 	private Collection listFilesRecursively(File root, File start) {
 		if (start == null)
 			start = root;
