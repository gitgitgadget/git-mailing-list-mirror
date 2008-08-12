From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 23/26] Rewrite GitMoveDeleteHook to use DirCacheBuilder
Date: Mon, 11 Aug 2008 18:08:10 -0700
Message-ID: <1218503293-14057-24-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
 <1218503293-14057-9-git-send-email-spearce@spearce.org>
 <1218503293-14057-10-git-send-email-spearce@spearce.org>
 <1218503293-14057-11-git-send-email-spearce@spearce.org>
 <1218503293-14057-12-git-send-email-spearce@spearce.org>
 <1218503293-14057-13-git-send-email-spearce@spearce.org>
 <1218503293-14057-14-git-send-email-spearce@spearce.org>
 <1218503293-14057-15-git-send-email-spearce@spearce.org>
 <1218503293-14057-16-git-send-email-spearce@spearce.org>
 <1218503293-14057-17-git-send-email-spearce@spearce.org>
 <1218503293-14057-18-git-send-email-spearce@spearce.org>
 <1218503293-14057-19-git-send-email-spearce@spearce.org>
 <1218503293-14057-20-git-send-email-spearce@spearce.org>
 <1218503293-14057-21-git-send-email-spearce@spearce.org>
 <1218503293-14057-22-git-send-email-spearce@spearce.org>
 <1218503293-14057-23-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPe-0006OQ-6f
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbYHLBJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbYHLBJ3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:09:29 -0400
Received: from george.spearce.org ([209.20.77.23]:38625 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYHLBIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:41 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4018938395; Tue, 12 Aug 2008 01:08:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 70710383A3;
	Tue, 12 Aug 2008 01:08:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-23-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92054>

The new DirCache API can read and write an index file faster than
the older GitIndex API can.  Its slightly more verbose to use but
operations will execute more quickly, especially when we are forced
to perform these single path updates by Eclipse.

When we move a file we maintain its stage status.  If the file has
been modified on disk but is not yet staged into the index (or it
was modified since staging) we leave the index alone, retaining
that staged state.

If we are moving within the same index file (same repository) we
only write the index out once.  This is a common case as most of
the renames performed by users will be within the same project,
and the same Git repository.  It is rare for a rename to wind up
spanning multiple repositories.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/egit/core/GitMoveDeleteHook.java   |  105 ++++++++++++--------
 1 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
index cc4059c..409f018 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
@@ -8,13 +8,13 @@
  *******************************************************************************/
 package org.spearce.egit.core;
 
-import java.io.File;
 import java.io.IOException;
 
 import org.eclipse.core.resources.IFile;
 import org.eclipse.core.resources.IFolder;
 import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IProjectDescription;
+import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.team.IMoveDeleteHook;
 import org.eclipse.core.resources.team.IResourceTree;
 import org.eclipse.core.runtime.Assert;
@@ -23,8 +23,10 @@ import org.eclipse.core.runtime.IStatus;
 import org.eclipse.core.runtime.Status;
 import org.spearce.egit.core.project.GitProjectData;
 import org.spearce.egit.core.project.RepositoryMapping;
-import org.spearce.jgit.lib.GitIndex;
-import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheBuilder;
+import org.spearce.jgit.dircache.DirCacheEditor;
+import org.spearce.jgit.dircache.DirCacheEntry;
 
 class GitMoveDeleteHook implements IMoveDeleteHook {
 	private static final boolean I_AM_DONE = true;
@@ -40,21 +42,37 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 
 	public boolean deleteFile(final IResourceTree tree, final IFile file,
 			final int updateFlags, final IProgressMonitor monitor) {
+		final boolean force = (updateFlags & IResource.FORCE) == IResource.FORCE;
+		if (!force && !tree.isSynchronized(file, IResource.DEPTH_ZERO))
+			return false;
+
+		final RepositoryMapping map = RepositoryMapping.getMapping(file);
+		if (map == null)
+			return false;
+
 		try {
-			RepositoryMapping map = RepositoryMapping.getMapping(file);
-			if (map != null) {
-				Repository repository = map.getRepository();
-				GitIndex index = repository.getIndex();
-				if (index.remove(map.getWorkDir(), file.getLocation().toFile()))
-					index.write();
+			final DirCache dirc = DirCache.lock(map.getRepository());
+			final int first = dirc.findEntry(map.getRepoRelativePath(file));
+			if (first < 0) {
+				dirc.unlock();
+				return false;
 			}
-			return FINISH_FOR_ME;
+
+			final DirCacheBuilder edit = dirc.builder();
+			if (first > 0)
+				edit.keep(0, first);
+			final int next = dirc.nextEntry(first);
+			if (next < dirc.getEntryCount())
+				edit.keep(next, dirc.getEntryCount() - next);
+			if (!edit.commit())
+				tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(),
+						0, CoreText.MoveDeleteHook_operationError, null));
+			tree.standardDeleteFile(file, updateFlags, monitor);
 		} catch (IOException e) {
-			e.printStackTrace();
 			tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(), 0,
 					CoreText.MoveDeleteHook_operationError, e));
-			return I_AM_DONE;
 		}
+		return true;
 	}
 
 	public boolean deleteFolder(final IResourceTree tree, final IFolder folder,
@@ -77,45 +95,48 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 		return FINISH_FOR_ME;
 	}
 
-	public boolean moveFile(final IResourceTree tree, final IFile source,
-			final IFile destination, final int updateFlags,
+	public boolean moveFile(final IResourceTree tree, final IFile srcf,
+			final IFile dstf, final int updateFlags,
 			final IProgressMonitor monitor) {
+		final boolean force = (updateFlags & IResource.FORCE) == IResource.FORCE;
+		if (!force && !tree.isSynchronized(srcf, IResource.DEPTH_ZERO))
+			return false;
+
+		final RepositoryMapping srcm = RepositoryMapping.getMapping(srcf);
+		if (srcm == null)
+			return false;
+		final RepositoryMapping dstm = RepositoryMapping.getMapping(dstf);
+
 		try {
-			final RepositoryMapping map1 = RepositoryMapping.getMapping(source);
-			if (map1 == null) {
-				// Source is not in a Git controlled project, fine
-				return FINISH_FOR_ME;
-			}
-			final GitIndex index1 = map1.getRepository().getIndex();
-			final RepositoryMapping map2 = RepositoryMapping.getMapping(destination);
-			final File sourceFile = source.getLocation().toFile();
-			if (map2 == null) {
-				if (index1.getEntry(Repository.stripWorkDir(map1.getWorkDir(), sourceFile)) == null) {
-					// if the source resource is not tracked by Git that is ok too
-					return FINISH_FOR_ME;
-				}
-				tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(),
-						0, "Destination not in a git versioned project", null));
-				return FINISH_FOR_ME;
+			final DirCache sCache = DirCache.lock(srcm.getRepository());
+			final String sPath = srcm.getRepoRelativePath(srcf);
+			final DirCacheEntry sEnt = sCache.getEntry(sPath);
+			if (sEnt == null) {
+				sCache.unlock();
+				return false;
 			}
-			GitIndex index2 = map2.getRepository().getIndex();
-			tree.standardMoveFile(source, destination, updateFlags, monitor);
-			if (index1.remove(map1.getWorkDir(), sourceFile)) {
-				index2.add(map2.getWorkDir(), destination.getLocation().toFile());
-				index1.write();
-				if (index2 != index1)
-					index2.write();
+
+			final DirCacheEditor sEdit = sCache.editor();
+			sEdit.add(new DirCacheEditor.DeletePath(sEnt));
+			if (dstm != null && dstm.getRepository() == srcm.getRepository()) {
+				final String dPath = srcm.getRepoRelativePath(dstf);
+				sEdit.add(new DirCacheEditor.PathEdit(dPath) {
+					@Override
+					public void apply(final DirCacheEntry dEnt) {
+						dEnt.copyMetaData(sEnt);
+					}
+				});
 			}
-			return I_AM_DONE;
+			if (!sEdit.commit())
+				tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(),
+						0, CoreText.MoveDeleteHook_operationError, null));
 
+			tree.standardMoveFile(srcf, dstf, updateFlags, monitor);
 		} catch (IOException e) {
-			// Recover properly!
-			e.printStackTrace();
 			tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(), 0,
 					CoreText.MoveDeleteHook_operationError, e));
-			return I_AM_DONE;
-
 		}
+		return true;
 	}
 
 	public boolean moveFolder(final IResourceTree tree, final IFolder source,
-- 
1.6.0.rc2.22.g71b99
