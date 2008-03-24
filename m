From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH 4/4] Show only commits in the current branch.
Date: Mon, 24 Mar 2008 09:47:14 +0000
Message-ID: <200803240947.15130.robin.rosenberg@dewire.com>
References: <1206327487-6543-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Mon Mar 24 10:48:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdjHz-0000jr-FF
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 10:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbYCXJrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 05:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbYCXJrk
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 05:47:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29239 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755294AbYCXJrj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 05:47:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 00233802659;
	Mon, 24 Mar 2008 10:47:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IHuFHlG-0Li2; Mon, 24 Mar 2008 10:47:37 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id F05A7800784;
	Mon, 24 Mar 2008 10:47:36 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1206327487-6543-1-git-send-email-rogersoares@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78015>

Den Monday 24 March 2008 02.58.07 skrev du:
> This is a quick hack to have the functionality. It
> filters the commits returned by GitFileHistory.getHistoryFor.

Good ui, but I don't like the filter (seem you didn't either from your comment) so I suggest inserting this patch
before the 4/4 patch of yours. Then in your patch drop the filter and fix the call to getHistory. This will
improve performance since the "current branch only" will be the view I (and probably most other people)
will use the most.

@@ -868,39 +865,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 						.getHistoryFor(startingPoint,
 								-1,
 								monitor,
-								isShowAllRepoVersions());
+								isShowAllRepoVersions(),
+								!showOnlyCurrentBranch);
 				fileRevisions = Collections.synchronizedList(fileHistoryFor.getFileRevisionsList());

As a side note, I used the IFileHistory{,Provider} interfaces originally because they existed in Eclipse already.
The problem is that it really doesn't fit so the getHistoryFor method used is not part of those interfaces. I was just too lazy to
completely remove the interfaces yet.

-- robin

>From 5935318f49f8bcfdcae81ec12667605e42ea8d9e Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Mon, 24 Mar 2008 08:56:35 +0000
Subject: [PATCH] Add a flag to GitFileHistory to follow only current branch

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/core/internal/mapping/GitFileHistory.java |   17 ++++++++++++-----
 .../internal/mapping/GitFileHistoryProvider.java   |    8 +++++---
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    3 ++-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index bdef5f1..ea1faa1 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -65,6 +65,8 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 
 	private final boolean returnAll;
 
+	private boolean allHeads;
+
 	/**
 	 * Construct a {@link GitFileHistory} object for a given resource (path)
 	 * with some filtering applied. The filter could reduce the number of
@@ -78,11 +80,14 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 	 * @param returnAll
 	 *            true if all versions should be collected even if the filter
 	 *            does not match.
+	 * @param allHeads
+	 *            true if all heads should be followed
 	 */
-	public GitFileHistory(IResource resource, int flags, IProgressMonitor monitor, boolean returnAll) {
+	public GitFileHistory(IResource resource, int flags, IProgressMonitor monitor, boolean returnAll, boolean allHeads) {
 		this.resource = resource;
 		this.flags = flags;
 		this.returnAll = returnAll;
+		this.allHeads = allHeads;
 		String prefix = RepositoryMapping.getMapping(resource).getSubset();
 		String[] prefixSegments = prefix!=null ? prefix.split("/") : new String[0];
 		String[] resourceSegments = resource.getProjectRelativePath().segments(); 
@@ -262,10 +267,12 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 				List<Commit> startList = new ArrayList<Commit>();
 
 				startList.add(repository.mapCommit(head));
-				for(String branch : repository.getBranches()) {
-					Commit commit = repository.mapCommit(branch);
-					if (commit != null)
-						startList.add(commit);
+				if (allHeads) {
+					for(String branch : repository.getBranches()) {
+						Commit commit = repository.mapCommit(branch);
+						if (commit != null)
+							startList.add(commit);
+					}
 				}
 				Commit[] starts = startList.toArray(new Commit[startList.size()]);
 				EclipseWalker walker = new EclipseWalker(
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
index 7847fd5..cbbfaa3 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
@@ -34,7 +34,7 @@ public class GitFileHistoryProvider extends FileHistoryProvider implements
 
 	public IFileHistory getFileHistoryFor(IResource resource, int flags,
 			IProgressMonitor monitor) {
-		return new GitFileHistory(resource, flags, monitor, false);
+		return new GitFileHistory(resource, flags, monitor, false, true);
 	}
 
 	public IFileRevision getWorkspaceFileRevision(IResource resource) {
@@ -58,12 +58,14 @@ public class GitFileHistoryProvider extends FileHistoryProvider implements
 	 *            progress monitor
 	 * @param returnAll
 	 *            true if all revisions are returned and interesting revisions marked.
+	 * @param allHeads
+	 *            true if all heads should be followed
 	 *
 	 * @return a {@link GitFileHistory} object.
 	 *
 	 */
-	public GitFileHistory getHistoryFor(IResource resource, int flags, IProgressMonitor monitor, boolean returnAll) {
-		return new GitFileHistory(resource, flags, monitor, returnAll); // TODO: implement flags
+	public GitFileHistory getHistoryFor(IResource resource, int flags, IProgressMonitor monitor, boolean returnAll, boolean allHeads) {
+		return new GitFileHistory(resource, flags, monitor, returnAll, allHeads);
 	}
 
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index d0346a9..984e54e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -840,7 +840,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 						.getHistoryFor(startingPoint,
 								-1,
 								monitor,
-								isShowAllRepoVersions());
+								isShowAllRepoVersions(),
+								true);
 				fileRevisions = Collections.synchronizedList(fileHistoryFor.getFileRevisionsList());
 				findToolbar.setFileRevisions(fileRevisions, newtags, branches);
 				Display.getDefault().syncExec(new Runnable() {
-- 
1.5.4.3
