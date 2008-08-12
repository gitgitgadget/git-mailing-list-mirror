From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 24/26] Teach GitMoveDeleteHook how to move a folder recursively
Date: Mon, 11 Aug 2008 18:08:11 -0700
Message-ID: <1218503293-14057-25-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPe-0006OQ-TG
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYHLBJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbYHLBJa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:09:30 -0400
Received: from george.spearce.org ([209.20.77.23]:38630 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYHLBIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:42 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id AE26D383A3; Tue, 12 Aug 2008 01:08:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E6F8038378;
	Tue, 12 Aug 2008 01:08:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-24-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92051>

When the user renames or moves a folder Eclipse passes us one event
to move the entire container and its contents.  So we need to move
all of the files contained within that container in our index.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/egit/core/GitMoveDeleteHook.java   |   51 ++++++++++++++++++--
 1 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
index 409f018..2cdff7d 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitMoveDeleteHook.java
@@ -1,6 +1,7 @@
 /*******************************************************************************
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2007, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -139,12 +140,52 @@ class GitMoveDeleteHook implements IMoveDeleteHook {
 		return true;
 	}
 
-	public boolean moveFolder(final IResourceTree tree, final IFolder source,
-			final IFolder destination, final int updateFlags,
+	public boolean moveFolder(final IResourceTree tree, final IFolder srcf,
+			final IFolder dstf, final int updateFlags,
 			final IProgressMonitor monitor) {
-		// TODO: Implement this. Should be relatively easy, but consider that
-		// Eclipse thinks folders are real thinsgs, while Git does not care.
-		return FINISH_FOR_ME;
+		final boolean force = (updateFlags & IResource.FORCE) == IResource.FORCE;
+		if (!force && !tree.isSynchronized(srcf, IResource.DEPTH_ZERO))
+			return false;
+
+		final RepositoryMapping srcm = RepositoryMapping.getMapping(srcf);
+		if (srcm == null)
+			return false;
+		final RepositoryMapping dstm = RepositoryMapping.getMapping(dstf);
+
+		try {
+			final DirCache sCache = DirCache.lock(srcm.getRepository());
+			final String sPath = srcm.getRepoRelativePath(srcf);
+			final DirCacheEntry[] sEnt = sCache.getEntriesWithin(sPath);
+			if (sEnt.length == 0) {
+				sCache.unlock();
+				return false;
+			}
+
+			final DirCacheEditor sEdit = sCache.editor();
+			sEdit.add(new DirCacheEditor.DeleteTree(sPath));
+			if (dstm != null && dstm.getRepository() == srcm.getRepository()) {
+				final String dPath = srcm.getRepoRelativePath(dstf) + "/";
+				final int sPathLen = sPath.length() + 1;
+				for (final DirCacheEntry se : sEnt) {
+					final String p = se.getPathString().substring(sPathLen);
+					sEdit.add(new DirCacheEditor.PathEdit(dPath + p) {
+						@Override
+						public void apply(final DirCacheEntry dEnt) {
+							dEnt.copyMetaData(se);
+						}
+					});
+				}
+			}
+			if (!sEdit.commit())
+				tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(),
+						0, CoreText.MoveDeleteHook_operationError, null));
+
+			tree.standardMoveFolder(srcf, dstf, updateFlags, monitor);
+		} catch (IOException e) {
+			tree.failed(new Status(IStatus.ERROR, Activator.getPluginId(), 0,
+					CoreText.MoveDeleteHook_operationError, e));
+		}
+		return true;
 	}
 
 	public boolean moveProject(final IResourceTree tree, final IProject source,
-- 
1.6.0.rc2.22.g71b99
