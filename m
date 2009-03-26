From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH RFC v1 3/5] Optimise ignore evaluation
Date: Thu, 26 Mar 2009 22:34:25 +0100
Message-ID: <e9605b0b1bda26f568009a42b31220d60692fce6.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
 <213427d4111185ae3a094a3cd578be8e6c3d5ffb.1238102327.git.ferry.huberts@pelagic.nl>
 <77afc036be3e7704333130c1cd2ab28466a91e67.1238102327.git.ferry.huberts@pelagic.nl>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 22:36:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxFA-0007np-KV
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602AbZCZVef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756318AbZCZVef
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:34:35 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:46234 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754190AbZCZVed (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 17:34:33 -0400
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 385CE58BDD3;
	Thu, 26 Mar 2009 22:34:28 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <77afc036be3e7704333130c1cd2ab28466a91e67.1238102327.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114824>

Do not call GitIgnoreData.isIgnored(resource) multiple times when
not needed.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 .../org/spearce/egit/core/op/TrackOperation.java   |    5 +++--
 .../decorators/DecoratableResourceAdapter.java     |    9 ++-------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
index 4a4b93c..a64c1dd 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
@@ -94,14 +94,15 @@ public boolean visit(IResource resource) throws CoreException {
 									// first. If a resource within a ignored folder is marked
 									// we ignore it here, i.e. there is no way to unmark it expect
 									// by explicitly selecting and invoking track on it.
+									boolean ignored = GitIgnoreData.isIgnored(resource);
 									if (resource.getType() == IResource.FILE) {
 										Entry entry = index.getEntry(repoPath);
-										if (!GitIgnoreData.isIgnored(resource) || ((entry != null) && entry.isAssumedValid())) {
+										if (!ignored || ((entry != null) && entry.isAssumedValid())) {
 											entry = index.add(rm.getWorkDir(), new File(rm.getWorkDir(), repoPath));
 											entry.setAssumeValid(false);
 										}
 									}
-									if (GitIgnoreData.isIgnored(resource))
+									if (ignored)
 										return false;
 
 								} catch (IOException e) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
index 4c740d5..7b48fd8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
@@ -118,7 +118,7 @@ private void extractResourceProperties(TreeWalk treeWalk) {
 		if (resourceEntry == null)
 			return;
 
-		if (isIgnored(resourceEntry.getResource())) {
+		if (GitIgnoreData.isIgnored(resourceEntry.getResource())) {
 			ignored = true;
 			return;
 		}
@@ -261,7 +261,7 @@ public boolean shouldBeRecursive() {
 
 	private void extractContainerProperties(TreeWalk treeWalk) throws IOException {
 
-		if (isIgnored(resource)) {
+		if (GitIgnoreData.isIgnored(resource)) {
 			ignored = true;
 			return;
 		}
@@ -361,11 +361,6 @@ private static boolean timestampMatches(DirCacheEntry indexEntry,
 		}
 	}
 
-	private static boolean isIgnored(IResource resource) {
-		// TODO: Also read ignores from .git/info/excludes et al.
-		return GitIgnoreData.isIgnored(resource);
-	}
-
 	public String getName() {
 		return resource.getName();
 	}
-- 
1.6.0.6
