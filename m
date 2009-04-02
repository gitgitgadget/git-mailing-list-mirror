From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/5] quickdiff - Don't add GitDocument as repository listener more than once
Date: Thu,  2 Apr 2009 20:46:28 +0200
Message-ID: <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 02 20:52:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRxj-00078a-NA
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZDBSqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 14:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758920AbZDBSqw
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:46:52 -0400
Received: from mail.dewire.com ([83.140.172.130]:5497 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758098AbZDBSqu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 14:46:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 704361488983;
	Thu,  2 Apr 2009 20:46:47 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4j6dJ9D0mgKi; Thu,  2 Apr 2009 20:46:45 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 0F06C1484DAF;
	Thu,  2 Apr 2009 20:46:45 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.1.345.g89fb
In-Reply-To: <1238697991-12990-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115484>

Doing so was very costly and led to sessions being locked
for a long time while refreshing the reference document used
by Eclipse's quickdiff feature.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/decorators/GitDocument.java   |    4 +++-
 .../src/org/spearce/jgit/lib/Repository.java       |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index a9c0c7d..69e9295 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -35,6 +35,9 @@ static GitDocument create(final IResource resource) throws IOException {
 		if (RepositoryProvider.getProvider(resource.getProject()) instanceof GitProvider) {
 			ret = new GitDocument(resource);
 			ret.populate();
+			final Repository repository = ret.getRepository();
+			if (repository != null)
+				repository.addRepositoryChangedListener(ret);
 		}
 		return ret;
 	}
@@ -52,7 +55,6 @@ void populate() throws IOException {
 			return;
 		final String gitPath = mapping.getRepoRelativePath(resource);
 		final Repository repository = getRepository();
-		repository.addRepositoryChangedListener(this);
 		String baseline = GitQuickDiffProvider.baseline.get(repository);
 		if (baseline == null)
 			baseline = Constants.HEAD;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index cfd92b8..0f396ed 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1132,6 +1132,7 @@ public File getWorkDir() {
 	 * @param l
 	 */
 	public void addRepositoryChangedListener(final RepositoryListener l) {
+		assert !listeners.contains(l);
 		listeners.add(l);
 	}
 
@@ -1150,6 +1151,7 @@ public void removeRepositoryChangedListener(final RepositoryListener l) {
 	 * @param l
 	 */
 	public static void addAnyRepositoryChangedListener(final RepositoryListener l) {
+		assert !allListeners.contains(l);
 		allListeners.add(l);
 	}
 
-- 
1.6.2.1.345.g89fb
