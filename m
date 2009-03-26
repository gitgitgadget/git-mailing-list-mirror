From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH RFC v1 2/5] Enable the ignore handling of the plugin
Date: Thu, 26 Mar 2009 22:34:24 +0100
Message-ID: <77afc036be3e7704333130c1cd2ab28466a91e67.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
 <213427d4111185ae3a094a3cd578be8e6c3d5ffb.1238102327.git.ferry.huberts@pelagic.nl>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 22:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxFB-0007np-CB
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbZCZVej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756520AbZCZVeh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:34:37 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:46230 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755016AbZCZVed (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 17:34:33 -0400
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 2D63C58BDD2;
	Thu, 26 Mar 2009 22:34:28 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <213427d4111185ae3a094a3cd578be8e6c3d5ffb.1238102327.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114826>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 org.spearce.egit.core/META-INF/MANIFEST.MF         |    1 +
 .../org/spearce/egit/core/op/TrackOperation.java   |    6 +++---
 .../decorators/DecoratableResourceAdapter.java     |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index 20df15f..546ea72 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -13,6 +13,7 @@ Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.core.filesystem,
  org.eclipse.ui
 Export-Package: org.spearce.egit.core,
+ org.spearce.egit.core.ignores;x-friends:="org.spearce.egit.ui",
  org.spearce.egit.core.internal.storage;x-friends:="org.spearce.egit.ui",
  org.spearce.egit.core.internal.util;x-friends:="org.spearce.egit.ui",
  org.spearce.egit.core.op,
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
index 29b4344..4a4b93c 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
@@ -24,9 +24,9 @@
 import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
-import org.eclipse.team.core.Team;
 import org.spearce.egit.core.Activator;
 import org.spearce.egit.core.CoreText;
+import org.spearce.egit.core.ignores.GitIgnoreData;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.GitIndex.Entry;
@@ -96,12 +96,12 @@ public boolean visit(IResource resource) throws CoreException {
 									// by explicitly selecting and invoking track on it.
 									if (resource.getType() == IResource.FILE) {
 										Entry entry = index.getEntry(repoPath);
-										if (!Team.isIgnoredHint(resource) || entry != null && entry.isAssumedValid()) {
+										if (!GitIgnoreData.isIgnored(resource) || ((entry != null) && entry.isAssumedValid())) {
 											entry = index.add(rm.getWorkDir(), new File(rm.getWorkDir(), repoPath));
 											entry.setAssumeValid(false);
 										}
 									}
-									if (Team.isIgnoredHint(resource))
+									if (GitIgnoreData.isIgnored(resource))
 										return false;
 
 								} catch (IOException e) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
index 5c68d5b..4c740d5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
@@ -22,10 +22,10 @@
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IWorkspaceRoot;
 import org.eclipse.jface.preference.IPreferenceStore;
-import org.eclipse.team.core.Team;
 import org.spearce.egit.core.AdaptableFileTreeIterator;
 import org.spearce.egit.core.ContainerTreeIterator;
 import org.spearce.egit.core.ContainerTreeIterator.ResourceEntry;
+import org.spearce.egit.core.ignores.GitIgnoreData;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIPreferences;
@@ -363,7 +363,7 @@ private static boolean timestampMatches(DirCacheEntry indexEntry,
 
 	private static boolean isIgnored(IResource resource) {
 		// TODO: Also read ignores from .git/info/excludes et al.
-		return Team.isIgnoredHint(resource);
+		return GitIgnoreData.isIgnored(resource);
 	}
 
 	public String getName() {
-- 
1.6.0.6
