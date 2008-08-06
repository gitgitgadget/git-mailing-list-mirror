From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 1/5] Remove the pointless GitProjectData resource change listener
Date: Tue,  5 Aug 2008 20:09:36 -0700
Message-ID: <1217992180-5697-2-git-send-email-spearce@spearce.org>
References: <1217992180-5697-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 05:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQZQI-0005ZC-JV
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 05:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761985AbYHFDJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 23:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758425AbYHFDJo
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 23:09:44 -0400
Received: from george.spearce.org ([209.20.77.23]:47467 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYHFDJm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 23:09:42 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1081A38445; Wed,  6 Aug 2008 03:09:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3FC5538419;
	Wed,  6 Aug 2008 03:09:41 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217992180-5697-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91476>

Apparently on any IResourceChangeEvent.POST_CHANGE we just burn some
CPU time and generate some garbage for the GC to clean out later.  I
cannot see a reason why this code is still here.  My memory says we
did this in the past to notify the resource decorator that it needs
to update, or we used it for our cache tree invalidation.

Since this code has no side effect other than to waste time we can
safely remove it, and cut our project down a little bit.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/core/project/GitProjectData.java  |   64 --------------------
 1 files changed, 0 insertions(+), 64 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 8754bd1..3d5424c 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -29,8 +29,6 @@ import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IResourceChangeEvent;
 import org.eclipse.core.resources.IResourceChangeListener;
-import org.eclipse.core.resources.IResourceDelta;
-import org.eclipse.core.resources.IResourceDeltaVisitor;
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.Preferences;
@@ -61,10 +59,6 @@ public class GitProjectData {
 		@SuppressWarnings("synthetic-access")
 		public void resourceChanged(final IResourceChangeEvent event) {
 			switch (event.getType()) {
-			case IResourceChangeEvent.POST_CHANGE:
-				projectsChanged(event.getDelta().getAffectedChildren(
-						IResourceDelta.CHANGED));
-				break;
 			case IResourceChangeEvent.PRE_CLOSE:
 				uncache((IProject) event.getResource());
 				break;
@@ -182,16 +176,6 @@ public class GitProjectData {
 		Activator.trace("(GitProjectData) " + m);
 	}
 
-	private static void projectsChanged(final IResourceDelta[] projDeltas) {
-		for (int k = 0; k < projDeltas.length; k++) {
-			final IResource r = projDeltas[k].getResource();
-			final GitProjectData d = get((IProject) r);
-			if (d != null) {
-				d.notifyChanged(projDeltas[k]);
-			}
-		}
-	}
-
 	private synchronized static void cache(final IProject p,
 			final GitProjectData d) {
 		projectDataCache.put(p, d);
@@ -380,54 +364,6 @@ public class GitProjectData {
 		}
 	}
 
-	private void notifyChanged(final IResourceDelta projDelta) {
-//		final Set affectedMappings = new HashSet();
-		try {
-			projDelta.accept(new IResourceDeltaVisitor() {
-				public boolean visit(final IResourceDelta d)
-						throws CoreException {
-					final int f = d.getFlags();
-					IResource res = d.getResource();
-					IResource r = res;
-					if ((f & IResourceDelta.CONTENT) != 0
-							|| (f & IResourceDelta.ENCODING) != 0
-							|| r instanceof IContainer) {
-						String s = null;
-						RepositoryMapping m = null;
-
-						while (r != null) {
-							m = getRepositoryMapping(r);
-							if (m != null) {
-								break;
-							}
-
-							if (s != null) {
-								s = r.getName() + "/" + s;
-							} else {
-								s = r.getName();
-							}
-
-							r = r.getParent();
-						}
-
-						if (m == null) {
-							return false;
-						} else if (s == null) {
-							return true;
-						}
-					}
-					return false;
-				}
-			});
-		} catch (CoreException ce) {
-			// We are in deep trouble. This should NOT have happend. Detach
-			// our listeners and forget it ever did.
-			//
-			detachFromWorkspace();
-			Activator.logError(CoreText.GitProjectData_notifyChangedFailed, ce);
-		}
-	}
-
 	private File propertyFile() {
 		return new File(getProject()
 				.getWorkingLocation(Activator.getPluginId()).toFile(),
-- 
1.6.0.rc1.250.g9b5e2
