From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/6] Drop unused GitBlobStorage class
Date: Tue,  5 Feb 2008 01:15:33 +0100
Message-ID: <1202170534-15788-6-git-send-email-robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-2-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-4-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-5-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 01:43:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBtr-0001DL-94
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbYBEAmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757401AbYBEAmK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:42:10 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18375 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757463AbYBEAmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:42:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 95D97800690;
	Tue,  5 Feb 2008 01:15:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k9+mJVHGjZIB; Tue,  5 Feb 2008 01:15:37 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 3E97E800692;
	Tue,  5 Feb 2008 01:15:34 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 509EC290EF; Tue,  5 Feb 2008 01:15:34 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
In-Reply-To: <1202170534-15788-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72599>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/core/GitBlobStorage.java  |   99 --------------------
 1 files changed, 0 insertions(+), 99 deletions(-)
 delete mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
deleted file mode 100644
index f7a062c..0000000
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- *  Copyright (C) 2006  Robin Rosenberg
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License, version 2.1, as published by the Free Software Foundation.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
- */
-package org.spearce.egit.core;
-
-import java.io.ByteArrayInputStream;
-import java.io.FileNotFoundException;
-import java.io.IOException;
-import java.io.InputStream;
-
-import org.eclipse.core.internal.resources.ResourceException;
-import org.eclipse.core.resources.IFile;
-import org.eclipse.core.resources.IResource;
-import org.eclipse.core.resources.IResourceStatus;
-import org.eclipse.core.resources.IStorage;
-import org.eclipse.core.runtime.CoreException;
-import org.eclipse.core.runtime.IPath;
-import org.spearce.egit.core.project.RepositoryMapping;
-import org.spearce.jgit.lib.ObjectId;
-import org.spearce.jgit.lib.ObjectLoader;
-import org.spearce.jgit.lib.Tree;
-import org.spearce.jgit.lib.TreeEntry;
-
-public class GitBlobStorage implements IStorage {
-
-	private final IResource resource;
-
-	private TreeEntry entry;
-
-	public GitBlobStorage(ObjectId treeId, IResource resource, String relativeResourceName) {
-		this.resource = resource;
-		if (treeId == null)
-			return;
-
-		RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(resource);
-		Tree tree;
-		try {
-			tree = repositoryMapping.getRepository().mapTree(treeId);
-			String name = repositoryMapping.getRepoRelativePath(resource);
-			entry = tree.findBlobMember(name);
-		} catch (IOException e) {
-			// TODO Auto-generated catch block
-			e.printStackTrace();
-		}
-	}
-
-	public InputStream getContents() throws CoreException {
-		try {
-			if (entry == null) {
-				return ((IFile) resource).getContents();
-			} else {
-				ObjectId id = entry.getId();
-				ObjectLoader reader = entry.getRepository().openBlob(id);
-				byte[] bytes = reader.getBytes();
-				return new ByteArrayInputStream(bytes);
-			}
-		} catch (FileNotFoundException e) {
-			throw new ResourceException(IResourceStatus.FAILED_READ_LOCAL,
-					resource.getFullPath(), "Could not read file", e);
-		} catch (IOException e) {
-			// TODO Auto-generated catch block
-			e.printStackTrace();
-			throw new ResourceException(33, resource.getFullPath(), e
-					.getMessage(), e);
-		}
-	}
-
-	public IPath getFullPath() {
-		return resource.getFullPath();
-	}
-
-	public String getName() {
-		return resource.getName();
-	}
-
-	public boolean isReadOnly() {
-		// TODO Auto-generated method stub
-		return false;
-	}
-
-	public Object getAdapter(Class adapter) {
-		System.out.println("GitStorage("+adapter.getName()+")");
-		return null;
-	}
-
-}
-- 
1.5.4.rc4.25.g81cc
