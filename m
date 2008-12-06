From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Drop StGit support
Date: Sun,  7 Dec 2008 00:01:23 +0100
Message-ID: <1228604483-30761-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Dec 07 00:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L96B5-0002Yg-DW
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 00:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbYLFXB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 18:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbYLFXB2
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 18:01:28 -0500
Received: from mail.dewire.com ([83.140.172.130]:28156 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbYLFXB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 18:01:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 678C61475A96;
	Sun,  7 Dec 2008 00:01:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EeYXj7yoV+eO; Sun,  7 Dec 2008 00:01:24 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 82AF4147EAE9;
	Sun,  7 Dec 2008 00:01:24 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102481>

It is slow and none of the jgit/egit developers use it.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitResourceDecorator.java  |   20 ++----
 .../src/org/spearce/jgit/lib/Repository.java       |   62 --------------------
 2 files changed, 7 insertions(+), 75 deletions(-)

This applies on top of the close outputstream bugfix patch posted recently.

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 1055fcc..97a0311 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -322,19 +322,13 @@ public void decorate(final Object element, final IDecoration decoration) {
 								Repository repo = mapped.getRepository();
 								try {
 									String branch = repo.getBranch();
-									if (repo.isStGitMode()) {
-										String patch = repo.getPatch();
-										decoration.addSuffix(" [StGit " + patch + "@" + branch
-												+ "]");
-									} else {
-										RepositoryState repositoryState = repo.getRepositoryState();
-										String statename;
-										if (repositoryState.equals(RepositoryState.SAFE))
-											statename = "";
-										else
-											statename = repositoryState.getDescription() + " ";
-										decoration.addSuffix(" [Git " + statename + "@ " + branch + "]");
-									}
+									RepositoryState repositoryState = repo.getRepositoryState();
+									String statename;
+									if (repositoryState.equals(RepositoryState.SAFE))
+										statename = "";
+									else
+										statename = repositoryState.getDescription() + " ";
+									decoration.addSuffix(" [Git " + statename + "@ " + branch + "]");
 								} catch (IOException e) {
 									e.printStackTrace();
 									decoration.addSuffix(" [Git ?]");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index da1494f..b63ef18 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -58,7 +58,6 @@
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.RevisionSyntaxException;
-import org.spearce.jgit.stgit.StGitPatch;
 import org.spearce.jgit.util.FS;
 
 /**
@@ -988,67 +987,6 @@ public Ref peel(final Ref ref) {
 		return ret;
 	}
 
-	/**
-	 * @return true if HEAD points to a StGit patch.
-	 */
-	public boolean isStGitMode() {
-		File file = new File(getDirectory(), "HEAD");
-		BufferedReader reader = null;
-		try {
-			reader = new BufferedReader(new FileReader(file));
-			String string = reader.readLine();
-			if (!string.startsWith("ref: refs/heads/"))
-				return false;
-			String branch = string.substring("ref: refs/heads/".length());
-			File currentPatches = new File(new File(new File(getDirectory(),
-					"patches"), branch), "applied");
-			if (!currentPatches.exists())
-				return false;
-			if (currentPatches.length() == 0)
-				return false;
-			return true;
-
-		} catch (IOException e) {
-			e.printStackTrace();
-			return false;
-		} finally {
-			try {
-				if (reader != null)
-					reader.close();
-			} catch (IOException e1) {
-				// nothing to do here
-			}
-		}
-	}
-
-	/**
-	 * @return applied patches in a map indexed on current commit id
-	 * @throws IOException
-	 */
-	public Map<ObjectId,StGitPatch> getAppliedPatches() throws IOException {
-		Map<ObjectId,StGitPatch> ret = new HashMap<ObjectId,StGitPatch>();
-		if (isStGitMode()) {
-			File patchDir = new File(new File(getDirectory(),"patches"),getBranch());
-			BufferedReader apr = new BufferedReader(new FileReader(new File(patchDir,"applied")));
-			try {
-				for (String patchName=apr.readLine(); patchName!=null; patchName=apr.readLine()) {
-					File topFile = new File(new File(new File(patchDir,"patches"), patchName), "top");
-					BufferedReader tfr = new BufferedReader(new FileReader(topFile));
-					try {
-						String objectId = tfr.readLine();
-						ObjectId id = ObjectId.fromString(objectId);
-						ret.put(id, new StGitPatch(patchName, id));
-					} finally {
-						tfr.close();
-					}
-				}
-			} finally {
-				apr.close();
-			}
-		}
-		return ret;
-	}
-	
 	/** Clean up stale caches */
 	public void refreshFromDisk() {
 		refs.clearCache();
-- 
1.6.0.3.640.g6331a
