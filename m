From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Show tags in history view
Date: Mon, 14 May 2007 01:39:17 +0200
Message-ID: <11790995573126-git-send-email-robin.rosenberg@dewire.com>
References: <11790995572233-git-send-email-robin.rosenberg@dewire.com>
 <11790995571082-git-send-email-robin.rosenberg@dewire.com>
 <11790995573817-git-send-email-robin.rosenberg@dewire.com>
 <11790995571637-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 14 01:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNyG-00061r-Ai
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758676AbXEMX7R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758505AbXEMX7R
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:59:17 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23496 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758523AbXEMX7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:59:16 -0400
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 May 2007 19:59:15 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 78A298028BE;
	Mon, 14 May 2007 01:33:00 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06019-08; Mon, 14 May 2007 01:32:59 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 280A1802C04;
	Mon, 14 May 2007 01:32:59 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id BF1F528CBD; Mon, 14 May 2007 01:39:17 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11790995571637-git-send-email-robin.rosenberg@dewire.com>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47197>

Put some content into the Tags field in the history browser. Besides
tags we put matching branch names there too.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   85 ++++++++++++++++++-
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 2 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index e5d92fe..8850405 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -18,6 +18,7 @@ package org.spearce.egit.ui;
 
 import java.io.IOException;
 import java.util.Date;
+import java.util.HashMap;
 import java.util.Map;
 
 import org.eclipse.compare.CompareConfiguration;
@@ -78,6 +79,7 @@ import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.internal.actions.GitCompareRevisionAction;
 import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.lib.Repository.StGitPatch;
 
 public class GitHistoryPage extends HistoryPage implements IAdaptable,
@@ -145,7 +147,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				if (item != null && item!=lastItem) {
 					IFileRevision rev = (IFileRevision) item.getData();
 					String commitStr=null;
-					if (appliedPatches!=null) {
+					if (rev!=null && appliedPatches!=null) {
 						String id = rev.getContentIdentifier();
 						if (!id.equals("Workspace")) {
 							StGitPatch patch = (StGitPatch) appliedPatches.get(new ObjectId(id));
@@ -275,8 +277,34 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					return id + "@.." + rs;
 			}
 
-			if (columnIndex == 2)
-				return ""; // TAGS
+			if (columnIndex == 2) {
+				String id = ((IFileRevision)element).getContentIdentifier();
+				ObjectId oid = new ObjectId(id);
+				StringBuilder b=new StringBuilder();
+				if (tags != null) {
+					Tag[] matching = tags.get(oid);
+					if (matching != null) {
+						for (Tag t : matching) {
+							if (b.length() > 0)
+								b.append(' ');
+							b.append(t.getTag());
+						}
+					}
+				}
+				if (branches != null) {
+					if (b.length() >0)
+						b.append('\n');
+					String[] matching = branches.get(oid);
+					if (matching != null) {
+						for (String t : matching) {
+							if (b.length() > 0)
+								b.append(' ');
+							b.append(t);
+						}
+					}
+				}
+				return b.toString();
+			}
 
 			if (columnIndex == 3) {
 				Date d = new Date(((IFileRevision) element).getTimestamp());
@@ -352,6 +380,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	}
 
 	private Map appliedPatches;
+	private Map<ObjectId,Tag[]> tags;
+	private Map<ObjectId, String[]> branches;
 
 	class HistoryRefreshJob extends Job {
 
@@ -373,6 +403,48 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				// TODO Auto-generated catch block
 				e.printStackTrace();
 			}
+			Map<ObjectId,Tag[]> newtags = new HashMap<ObjectId,Tag[]>();
+			try {
+				for (String name : repositoryMapping.getRepository().getTags()) {
+					Tag t = repositoryMapping.getRepository().mapTag(name);
+					Tag[] samecommit = newtags.get(t.getObjId());
+					if (samecommit==null) { 
+						samecommit = new Tag[] { t };
+					} else {
+						Tag[] n=new Tag[samecommit.length+1];
+						for (int j=0; j<samecommit.length; ++j)
+							n[j] = samecommit[j];
+						n[n.length-1] = t;
+						samecommit = n;
+					}
+					newtags.put(t.getObjId(), samecommit);
+				}
+			} catch (IOException e) {
+				// TODO Auto-generated catch block
+				e.printStackTrace();
+			}
+			Map<ObjectId, String[]> newBranches = new HashMap<ObjectId, String[]>();
+			try {
+				for (String branch : repositoryMapping.getRepository().getBranches()) {
+					ObjectId id = repositoryMapping.getRepository().resolve("refs/heads/"+branch);
+					String[] samecommit = newBranches.get(id);
+					if (samecommit == null) {
+						samecommit = new String[] { branch };
+					} else {
+						String[] n=new String[samecommit.length + 1];
+						for (int j=0; j<samecommit.length; ++j)
+							n[j] = samecommit[j];
+						n[n.length-1] = branch;
+						samecommit = n;
+					}
+					newBranches.put(id, samecommit);
+				}
+				branches = newBranches;
+			} catch (IOException e) {
+				// TODO Auto-generated catch block
+				e.printStackTrace();
+			}
+
 			IFileHistoryProvider fileHistoryProvider = provider
 					.getFileHistoryProvider();
 			IFileHistory fileHistoryFor = fileHistoryProvider
@@ -380,7 +452,9 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 							IFileHistoryProvider.SINGLE_LINE_OF_DESCENT, monitor);
 			fileRevisions = fileHistoryFor.getFileRevisions();
 			
-			final Map fnewappliedPatches = newappliedPatches; 
+			final Map fnewappliedPatches = newappliedPatches;
+			final Map<ObjectId,Tag[]> ftags = newtags;
+
 			tree.getDisplay().asyncExec(new Runnable() {
 			
 				public void run() {
@@ -389,8 +463,9 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					tree.setData(fileRevisions);
 					tree.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,true));
 					System.out.println("inputchanged, invoking refresh");
-					viewer.refresh();
 					appliedPatches = fnewappliedPatches;
+					tags = ftags;
+					viewer.refresh();
 					done(Status.OK_STATUS);
 				}
 			
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 3b2a82c..12beb88 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -470,7 +470,7 @@ public class Repository {
 		return ref;
 	}
 
-	public Collection getBranches() {
+	public Collection<String> getBranches() {
 		return listFilesRecursively(new File(refsDir, "heads"), null);
 	}
 
-- 
1.5.1.1
