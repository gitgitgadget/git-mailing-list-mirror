From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 08/10] Show only commits that represent changes in the
	history view
Date: Sun, 11 Mar 2007 19:15:58 +0100
Message-ID: <20070311181558.18012.48529.stgit@lathund.dewire.com>
References: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYy-0006Qd-OB
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933948AbXCKSOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933949AbXCKSOZ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:14:25 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1641 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933948AbXCKSOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:14:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 976E8802848;
	Sun, 11 Mar 2007 19:09:08 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26266-04; Sun, 11 Mar 2007 19:09:08 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id D81AB800199;
	Sun, 11 Mar 2007 19:09:07 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 0BFAF28D5B;
	Sun, 11 Mar 2007 19:16:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 5l2bzThdEUcm; Sun, 11 Mar 2007 19:16:10 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B070029212;
	Sun, 11 Mar 2007 19:15:58 +0100 (CET)
In-Reply-To: <20070311180608.18012.13767.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41959>

The reason other commits were there originally was that it was useful
for debugging to see the last and first commit. I think that is no 
longer the case.
Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../egit/core/GitWorkspaceFileRevision.java        |    2 -
 .../egit/core/internal/mapping/GitFileHistory.java |   70 +++++++++++++++++++++--
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    7 ++
 3 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
index 5c3b820..82047c7 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitWorkspaceFileRevision.java
@@ -62,6 +62,6 @@ public class GitWorkspaceFileRevision extends GitFileRevision implements
 	}
 
 	public String getContentIdentifier() {
-		return null;
+		return "Workspace";
 	}
 }
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 2e4e4e9..6c114e9 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -16,7 +16,9 @@
  */
 package org.spearce.egit.core.internal.mapping;
 
+import java.io.BufferedInputStream;
 import java.io.IOException;
+import java.io.InputStream;
 import java.util.ArrayList;
 import java.util.Arrays;
 import java.util.Collection;
@@ -25,12 +27,14 @@ import java.util.Date;
 import java.util.List;
 
 import org.eclipse.core.resources.IResource;
+import org.eclipse.core.runtime.CoreException;
 import org.eclipse.team.core.RepositoryProvider;
 import org.eclipse.team.core.history.IFileHistoryProvider;
 import org.eclipse.team.core.history.IFileRevision;
 import org.eclipse.team.core.history.provider.FileHistory;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.GitWorkspaceFileRevision;
+import org.spearce.egit.core.project.GitProjectData;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
@@ -95,10 +99,14 @@ public class GitFileHistory extends FileHistory {
 		return getRepositoryMapping().getRepository();
 	}
 
-	private RepositoryMapping getRepositoryMapping() {
+	private GitProjectData getData() {
 		GitProvider provider = (GitProvider) RepositoryProvider
 				.getProvider(resource.getProject());
-		return provider.getData().getRepositoryMapping(resource.getProject());
+		return provider.getData();
+	}
+
+	private RepositoryMapping getRepositoryMapping() {
+		return getData().getRepositoryMapping(resource.getProject());
 	}
 
 	private Collection collectHistory() {
@@ -108,6 +116,15 @@ public class GitFileHistory extends FileHistory {
 			Commit commit = repository.mapCommit(id);
 			ObjectId[] initialResourceHash = new ObjectId[relativeResourceName.length];
 			Arrays.fill(initialResourceHash, ObjectId.zeroId());
+			TreeEntry[] activeDiffTreeEntries = null;
+			try {
+				activeDiffTreeEntries = getData().getActiveDiffTreeEntries(resource);
+			} catch (CoreException e1) {
+				// TODO: eclipse excetion logging
+				e1.printStackTrace();
+			}
+			if (activeDiffTreeEntries!=null)
+				initialResourceHash[initialResourceHash.length-1] = activeDiffTreeEntries[0].getId();
 			return collectHistory(initialResourceHash, null,
 					repository, commit);
 		} catch (IOException e) {
@@ -195,7 +212,6 @@ public class GitFileHistory extends FileHistory {
 				current = null;
 
 		} while (current != null);
-		ret.add(new GitFileRevision(previous, resource));
 
 		return ret;
 	}
@@ -251,13 +267,39 @@ public class GitFileHistory extends FileHistory {
 		RepositoryProvider provider = RepositoryProvider.getProvider(resource
 				.getProject());
 		if (provider instanceof GitProvider) {
-
-			List ret = new ArrayList();
-			ret.add(new GitWorkspaceFileRevision(resource));
+			GitWorkspaceFileRevision wsrevision = new GitWorkspaceFileRevision(resource);
 
 			long time0 = new Date().getTime();
 			System.out.println("getting file history");
-			ret.addAll(collectHistory());
+			List ret = new ArrayList();
+			Collection githistory = collectHistory();
+			if (githistory.size() >0) {
+				if (resource.getType()==IResource.FILE) {
+					// TODO: consider index in future versions
+					try {
+						InputStream wsContents = new BufferedInputStream(wsrevision.getStorage(null).getContents());
+						InputStream headContents = ((IFileRevision)githistory.toArray()[0]).getStorage(null).getContents();
+						if (!streamsEqual(wsContents,headContents)) {
+							ret.add(wsrevision);
+							ret.addAll(githistory);
+						} else {
+							ret.addAll(githistory);
+						}
+						wsContents.close();
+						headContents.close();
+					} catch (IOException e) {
+						// TODO: Eclipse error handling
+						e.printStackTrace();
+					} catch (CoreException e) {
+						// TODO: Eclipse error handling
+						e.printStackTrace();
+					}
+				} else {
+					ret.addAll(githistory);
+				}
+			} else {
+				ret.add(wsrevision);
+			}
 			long time1 = new Date().getTime();
 			System.out.println("got file history in " + (time1 - time0)
 					/ 1000.0 + "s");
@@ -270,6 +312,20 @@ public class GitFileHistory extends FileHistory {
 		}
 	}
 
+	private boolean streamsEqual(InputStream s1, InputStream s2) {
+		// Speed up...
+		try {
+			int c1,c2;
+			while ((c1=s1.read()) == (c2=s2.read()) && c1!=-1)
+				;
+			return c1 == -1 && c2==-1;
+		} catch (IOException e) {
+			// TODO: eclipse error handling
+			e.printStackTrace();
+			return false;
+		}
+	}
+
 	public IFileRevision[] getTargets(IFileRevision revision) {
 		GitFileRevision grevision = (GitFileRevision) revision;
 		ObjectId targetCommitId = grevision.getCommit().getCommitId();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index cd31f18..77073f2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -156,7 +156,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 			if (columnIndex == 0) {
 				String id = ((IFileRevision) element).getContentIdentifier();
 				if (id != null)
-					return id.substring(0, 7) + "..";
+					if (id.length() > 9) // make sure "Workspace" is spelled out
+						return id.substring(0, 7) + "..";
+					else
+						return id;
 				else
 					return id;
 			}
@@ -211,7 +214,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 						if (text != null)
 							item.setText(i, text);
 						else
-							item.setText("");
+							item.setText(i, "");
 					}
 					item.setData(fileRevisions[event.index]);
 				}
