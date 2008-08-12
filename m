From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 26/26] Rewrite AssumeUnchangedOperation to use DirCache
Date: Mon, 11 Aug 2008 18:08:13 -0700
Message-ID: <1218503293-14057-27-git-send-email-spearce@spearce.org>
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
 <1218503293-14057-26-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPf-0006OQ-IO
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYHLBJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbYHLBJf
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:09:35 -0400
Received: from george.spearce.org ([209.20.77.23]:38645 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbYHLBJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:09:15 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D7EF23838B; Tue, 12 Aug 2008 01:08:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8DC013837C;
	Tue, 12 Aug 2008 01:08:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-26-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92045>

Its faster to use the DirCache and run over the range of entries
than to use GitIndex and probe the hash many times as we are in
a loop over the resources in the workspace.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../egit/core/op/AssumeUnchangedOperation.java     |  133 ++++++++++----------
 1 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/AssumeUnchangedOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/AssumeUnchangedOperation.java
index 78a84bb..fa70b6c 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/AssumeUnchangedOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/AssumeUnchangedOperation.java
@@ -1,6 +1,7 @@
 /*******************************************************************************
  * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -11,11 +12,11 @@ package org.spearce.egit.core.op;
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
@@ -23,9 +24,11 @@ import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
 import org.spearce.egit.core.Activator;
 import org.spearce.egit.core.CoreText;
+import org.spearce.egit.core.project.GitProjectData;
 import org.spearce.egit.core.project.RepositoryMapping;
-import org.spearce.jgit.lib.GitIndex;
-import org.spearce.jgit.lib.GitIndex.Entry;
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheEntry;
+import org.spearce.jgit.lib.Repository;
 
 /**
  * Tell JGit to ignore changes in selected files
@@ -33,87 +36,89 @@ import org.spearce.jgit.lib.GitIndex.Entry;
 public class AssumeUnchangedOperation implements IWorkspaceRunnable {
 	private final Collection rsrcList;
 
+	private final IdentityHashMap<Repository, DirCache> caches;
+
+	private final IdentityHashMap<RepositoryMapping, Object> mappings;
+
 	/**
 	 * Create a new operation to ignore changes in tracked files
-	 *
+	 * 
 	 * @param rsrcs
-	 *            collection of {@link IResource}s which should be 
-	 *            ignored when looking for changes or committing.
+	 *            collection of {@link IResource}s which should be ignored when
+	 *            looking for changes or committing.
 	 */
 	public AssumeUnchangedOperation(final Collection rsrcs) {
 		rsrcList = rsrcs;
+		caches = new IdentityHashMap<Repository, DirCache>();
+		mappings = new IdentityHashMap<RepositoryMapping, Object>();
 	}
 
 	public void run(IProgressMonitor m) throws CoreException {
-		if (m == null) {
+		if (m == null)
 			m = new NullProgressMonitor();
-		}
 
-		final IdentityHashMap<RepositoryMapping, Boolean> tomerge = new IdentityHashMap<RepositoryMapping, Boolean>();
-		m.beginTask(CoreText.AssumeUnchangedOperation_adding, rsrcList.size() * 200);
+		caches.clear();
+		mappings.clear();
+
+		m.beginTask(CoreText.AssumeUnchangedOperation_adding,
+				rsrcList.size() * 200);
 		try {
 			for (Object obj : rsrcList) {
-				obj = ((IAdaptable)obj).getAdapter(IResource.class);
-				if (obj instanceof IResource) {
-					final IResource toAssumeValid = (IResource)obj;
-					final RepositoryMapping rm = RepositoryMapping.getMapping(toAssumeValid);
-					final GitIndex index = rm.getRepository().getIndex();
-
-					if (toAssumeValid instanceof IContainer) {
-						((IContainer)toAssumeValid).accept(new IResourceVisitor() {
-							public boolean visit(IResource resource) throws CoreException {
-								try {
-									String repoPath = rm.getRepoRelativePath(resource);
-									Entry entry = index.getEntry(repoPath);
-									if (entry != null) {
-										if (!entry.isAssumedValid()) {
-											entry.setAssumeValid(true);
-											tomerge.put(rm, Boolean.TRUE);
-										}
-									}
-								} catch (IOException e) {
-									e.printStackTrace();
-									throw Activator.error(CoreText.AssumeUnchangedOperation_failed, e);
-								}
-								return true;
-							}
-						},IResource.DEPTH_INFINITE, IContainer.EXCLUDE_DERIVED);
-					} else {
-						String repoPath = rm.getRepoRelativePath((IResource) obj);
-						Entry entry = index.getEntry(repoPath);
-						if (entry != null) {
-							if (!entry.isAssumedValid()) {
-								entry.setAssumeValid(true);
-								tomerge.put(rm, Boolean.TRUE);
-							}
-						}
-					}
-				}
+				obj = ((IAdaptable) obj).getAdapter(IResource.class);
+				if (obj instanceof IResource)
+					assumeValid((IResource) obj);
 				m.worked(200);
 			}
-			for (RepositoryMapping rm : tomerge.keySet()) {
-				m.setTaskName("Writing index for "+rm.getRepository().getDirectory());
-				rm.getRepository().getIndex().write();
+
+			for (Map.Entry<Repository, DirCache> e : caches.entrySet()) {
+				final Repository db = e.getKey();
+				final DirCache editor = e.getValue();
+				m.setTaskName("Writing index for " + db.getDirectory());
+				editor.write();
+				editor.commit();
 			}
 		} catch (RuntimeException e) {
-			e.printStackTrace();
-			throw Activator.error(CoreText.AssumeUnchangedOperation_failed, e);
+			throw Activator.error(CoreText.UntrackOperation_failed, e);
 		} catch (IOException e) {
-			e.printStackTrace();
-			throw Activator.error(CoreText.AssumeUnchangedOperation_failed, e);
+			throw Activator.error(CoreText.UntrackOperation_failed, e);
 		} finally {
+			for (final RepositoryMapping rm : mappings.keySet())
+				rm.fireRepositoryChanged();
+			caches.clear();
+			mappings.clear();
+			m.done();
+		}
+	}
+
+	private void assumeValid(final IResource resource) throws CoreException {
+		final IProject proj = resource.getProject();
+		final GitProjectData pd = GitProjectData.get(proj);
+		if (pd == null)
+			return;
+		final RepositoryMapping rm = pd.getRepositoryMapping(resource);
+		if (rm == null)
+			return;
+		final Repository db = rm.getRepository();
+
+		DirCache cache = caches.get(db);
+		if (cache == null) {
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
+				cache = DirCache.lock(db);
+			} catch (IOException err) {
+				throw Activator.error(CoreText.UntrackOperation_failed, err);
 			}
+			caches.put(db, cache);
+			mappings.put(rm, rm);
+		}
+
+		final String path = rm.getRepoRelativePath(resource);
+		if (resource instanceof IContainer) {
+			for (final DirCacheEntry ent : cache.getEntriesWithin(path))
+				ent.setAssumeValid(true);
+		} else {
+			final DirCacheEntry ent = cache.getEntry(path);
+			if (ent != null)
+				ent.setAssumeValid(true);
 		}
 	}
 }
-- 
1.6.0.rc2.22.g71b99
