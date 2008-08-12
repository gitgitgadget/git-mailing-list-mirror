From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 25/26] Rewrite UntrackOperation to use DirCacheBuilder
Date: Mon, 11 Aug 2008 18:08:12 -0700
Message-ID: <1218503293-14057-26-git-send-email-spearce@spearce.org>
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
 <1218503293-14057-24-git-send-email-spearce@spearce.org>
 <1218503293-14057-25-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPg-0006OQ-7b
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbYHLBJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbYHLBJc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:09:32 -0400
Received: from george.spearce.org ([209.20.77.23]:38631 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYHLBIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:42 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 49D3538391; Tue, 12 Aug 2008 01:08:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 34ECA383A4;
	Tue, 12 Aug 2008 01:08:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-25-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92044>

We can more efficiently untrack single files and entire directories using
the DirCacheBuilder API as that API is able to perform range edits on
the index data structure.  Its also able to perform faster disk IO, due
to less conversion overheads.

Although performance of untrack is not a critical feature it is a good
idea to move it over to the newer API, as we will eventually get rid of
the GitIndex class entirely.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/egit/core/op/UntrackOperation.java |   98 +++++++++++---------
 1 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
index b491e6d..4656552 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
@@ -1,6 +1,7 @@
 /*******************************************************************************
  * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -8,15 +9,14 @@
  *******************************************************************************/
 package org.spearce.egit.core.op;
 
-import java.io.File;
 import java.io.IOException;
 import java.util.Collection;
 import java.util.IdentityHashMap;
-import java.util.Iterator;
+import java.util.Map;
 
 import org.eclipse.core.resources.IContainer;
+import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
-import org.eclipse.core.resources.IResourceVisitor;
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.IAdaptable;
@@ -26,7 +26,9 @@ import org.spearce.egit.core.Activator;
 import org.spearce.egit.core.CoreText;
 import org.spearce.egit.core.project.GitProjectData;
 import org.spearce.egit.core.project.RepositoryMapping;
-import org.spearce.jgit.lib.GitIndex;
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheEditor;
+import org.spearce.jgit.lib.Repository;
 
 /**
  * Remove one or more existing files/folders from the Git repository.
@@ -43,6 +45,10 @@ import org.spearce.jgit.lib.GitIndex;
 public class UntrackOperation implements IWorkspaceRunnable {
 	private final Collection rsrcList;
 
+	private final IdentityHashMap<Repository, DirCacheEditor> edits;
+
+	private final IdentityHashMap<RepositoryMapping, Object> mappings;
+
 	/**
 	 * Create a new operation to stop tracking existing files/folders.
 	 * 
@@ -52,63 +58,69 @@ public class UntrackOperation implements IWorkspaceRunnable {
 	 */
 	public UntrackOperation(final Collection rsrcs) {
 		rsrcList = rsrcs;
+		edits = new IdentityHashMap<Repository, DirCacheEditor>();
+		mappings = new IdentityHashMap<RepositoryMapping, Object>();
 	}
 
 	public void run(IProgressMonitor m) throws CoreException {
-		if (m == null) {
+		if (m == null)
 			m = new NullProgressMonitor();
-		}
 
-		final IdentityHashMap<RepositoryMapping, Boolean> tomerge = new IdentityHashMap<RepositoryMapping, Boolean>();
+		edits.clear();
+		mappings.clear();
+
 		m.beginTask(CoreText.AddOperation_adding, rsrcList.size() * 200);
 		try {
 			for (Object obj : rsrcList) {
-				obj = ((IAdaptable)obj).getAdapter(IResource.class);
-				if (obj instanceof IResource) {
-					final IResource toRemove = (IResource)obj;
-					final GitProjectData pd = GitProjectData.get(toRemove.getProject());
-					final RepositoryMapping rm = pd.getRepositoryMapping(toRemove);
-					final GitIndex index = rm.getRepository().getIndex();
-					tomerge.put(rm, Boolean.TRUE);
-					if (toRemove instanceof IContainer) {
-						((IContainer)toRemove).accept(new IResourceVisitor() {
-							public boolean visit(IResource resource) throws CoreException {
-								if (resource.getType() == IResource.FILE) {
-									index.remove(rm.getWorkDir(), new File(rm.getWorkDir(),rm.getRepoRelativePath(resource)));
-								}
-								return true;
-							}
-						},IResource.DEPTH_INFINITE, IContainer.EXCLUDE_DERIVED);
-					} else {
-						index.remove(rm.getWorkDir(), new File(rm.getWorkDir(),rm.getRepoRelativePath(toRemove)));
-					}
-				}
+				obj = ((IAdaptable) obj).getAdapter(IResource.class);
+				if (obj instanceof IResource)
+					remove((IResource) obj);
 				m.worked(200);
 			}
-			for (RepositoryMapping rm : tomerge.keySet()) {
-				m.setTaskName("Writing index for "+rm.getRepository().getDirectory());
-				rm.getRepository().getIndex().write();
+
+			for (Map.Entry<Repository, DirCacheEditor> e : edits.entrySet()) {
+				final Repository db = e.getKey();
+				final DirCacheEditor editor = e.getValue();
+				m.setTaskName("Writing index for " + db.getDirectory());
+				editor.commit();
 			}
 		} catch (RuntimeException e) {
-			e.printStackTrace();
 			throw Activator.error(CoreText.UntrackOperation_failed, e);
 		} catch (IOException e) {
-			e.printStackTrace();
 			throw Activator.error(CoreText.UntrackOperation_failed, e);
 		} finally {
+			for (final RepositoryMapping rm : mappings.keySet())
+				rm.fireRepositoryChanged();
+			edits.clear();
+			mappings.clear();
+			m.done();
+		}
+	}
+
+	private void remove(final IResource path) throws CoreException {
+		final IProject proj = path.getProject();
+		final GitProjectData pd = GitProjectData.get(proj);
+		if (pd == null)
+			return;
+		final RepositoryMapping rm = pd.getRepositoryMapping(path);
+		if (rm == null)
+			return;
+		final Repository db = rm.getRepository();
+
+		DirCacheEditor e = edits.get(db);
+		if (e == null) {
 			try {
-				final Iterator i = tomerge.keySet().iterator();
-				while (i.hasNext()) {
-					final RepositoryMapping r = (RepositoryMapping) i.next();
-					r.getRepository().getIndex().read();
-					r.fireRepositoryChanged();
-				}
-			} catch (IOException e) {
-				e.printStackTrace();
-			} finally {
-				m.done();
+				e = DirCache.lock(db).editor();
+			} catch (IOException err) {
+				throw Activator.error(CoreText.UntrackOperation_failed, err);
 			}
+			edits.put(db, e);
+			mappings.put(rm, rm);
 		}
-	}
 
+		if (path instanceof IContainer)
+			e.add(new DirCacheEditor.DeleteTree(rm.getRepoRelativePath(path)));
+		else
+			e.add(new DirCacheEditor.DeletePath(rm.getRepoRelativePath(path)));
+	}
 }
-- 
1.6.0.rc2.22.g71b99
