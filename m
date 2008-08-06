From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 5/5] Correct getRepositoryMapping callers to use any IResource
Date: Tue,  5 Aug 2008 20:09:40 -0700
Message-ID: <1217992180-5697-6-git-send-email-spearce@spearce.org>
References: <1217992180-5697-1-git-send-email-spearce@spearce.org>
 <1217992180-5697-2-git-send-email-spearce@spearce.org>
 <1217992180-5697-3-git-send-email-spearce@spearce.org>
 <1217992180-5697-4-git-send-email-spearce@spearce.org>
 <1217992180-5697-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 05:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQZQL-0005ZC-B1
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 05:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762084AbYHFDJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 23:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758425AbYHFDJv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 23:09:51 -0400
Received: from george.spearce.org ([209.20.77.23]:47482 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYHFDJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 23:09:45 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8799838420; Wed,  6 Aug 2008 03:09:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 9181D38419;
	Wed,  6 Aug 2008 03:09:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217992180-5697-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91481>

We really need to use the exact resource we want a mapping for, even
if that is an IFile, because the file may be in a different repository
than the project it is contained in.  This can happen due to linked
resources, or due to submodules.  Either way the mapping cannot be
driven by the project.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/egit/core/op/UntrackOperation.java |    4 +---
 .../egit/core/project/RepositoryMapping.java       |   14 +++++++-------
 .../egit/ui/internal/actions/CommitAction.java     |    2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
index 369ff38..b491e6d 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
@@ -15,7 +15,6 @@ import java.util.IdentityHashMap;
 import java.util.Iterator;
 
 import org.eclipse.core.resources.IContainer;
-import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IResourceVisitor;
 import org.eclipse.core.resources.IWorkspaceRunnable;
@@ -67,9 +66,8 @@ public class UntrackOperation implements IWorkspaceRunnable {
 				obj = ((IAdaptable)obj).getAdapter(IResource.class);
 				if (obj instanceof IResource) {
 					final IResource toRemove = (IResource)obj;
-					final IProject p = toRemove.getProject();					
 					final GitProjectData pd = GitProjectData.get(toRemove.getProject());
-					final RepositoryMapping rm = pd.getRepositoryMapping(p);
+					final RepositoryMapping rm = pd.getRepositoryMapping(toRemove);
 					final GitIndex index = rm.getRepository().getIndex();
 					tomerge.put(rm, Boolean.TRUE);
 					if (toRemove instanceof IContainer) {
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index 17e8142..961dbaf 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -221,15 +221,15 @@ public class RepositoryMapping {
 	 * @return the RepositoryMapping for this resource,
 	 *         or null for non GitProvider.
 	 */
-	public static RepositoryMapping getMapping(IResource resource) {
-		IProject project = resource.getProject();
+	public static RepositoryMapping getMapping(final IResource resource) {
+		final IProject project = resource.getProject();
 		if (project == null)
 			return null;
-		RepositoryProvider provider = RepositoryProvider.getProvider(project);
-		if (!(provider instanceof GitProvider))
+
+		final RepositoryProvider rp = RepositoryProvider.getProvider(project);
+		if (!(rp instanceof GitProvider))
 			return null;
-		GitProvider gp = (GitProvider)provider;
-		RepositoryMapping repositoryMapping = gp.getData().getRepositoryMapping(project);
-		return repositoryMapping;
+
+		return ((GitProvider)rp).getData().getRepositoryMapping(resource);
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index db38c10..4956be3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -363,7 +363,7 @@ public class CommitAction extends RepositoryAction {
 
 		try {
 			RepositoryMapping repositoryMapping = projectData
-					.getRepositoryMapping(resource.getProject());
+					.getRepositoryMapping(resource);
 
 			if (isChanged(repositoryMapping, resource)) {
 				files.add(resource);
-- 
1.6.0.rc1.250.g9b5e2
