From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 10/11] Add a TreeWalk iterator implementation for IContainer
Date: Sun, 10 Aug 2008 01:46:25 -0700
Message-ID: <1218357986-19671-11-git-send-email-spearce@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org>
 <1218357986-19671-2-git-send-email-spearce@spearce.org>
 <1218357986-19671-3-git-send-email-spearce@spearce.org>
 <1218357986-19671-4-git-send-email-spearce@spearce.org>
 <1218357986-19671-5-git-send-email-spearce@spearce.org>
 <1218357986-19671-6-git-send-email-spearce@spearce.org>
 <1218357986-19671-7-git-send-email-spearce@spearce.org>
 <1218357986-19671-8-git-send-email-spearce@spearce.org>
 <1218357986-19671-9-git-send-email-spearce@spearce.org>
 <1218357986-19671-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:48:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6b7-00020G-Ia
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbYHJIqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYHJIqv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:51 -0400
Received: from george.spearce.org ([209.20.77.23]:51269 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYHJIqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A921F3837A; Sun, 10 Aug 2008 08:46:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CBE20381FD;
	Sun, 10 Aug 2008 08:46:32 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
In-Reply-To: <1218357986-19671-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91823>

Treating the Eclipse workspace as a filesystem backend for TreeWalk
can give us some nice caching on the file modification times and on
directory contents.  We also get nice APIs to open a file and read
its contents.

This iterator allows combining a walk over an IContainer with any
other sort of directory walk we may do, like against a stored tree
object in the object database or against the index file, or even
any other IContainer in the workspace (e.g. diff two projects).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/core/ContainerTreeIterator.java   |  181 ++++++++++++++++++++
 1 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
new file mode 100644
index 0000000..17b8414
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
@@ -0,0 +1,181 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+
+package org.spearce.egit.core;
+
+import java.io.File;
+import java.io.IOException;
+import java.io.InputStream;
+
+import org.eclipse.core.resources.IContainer;
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.runtime.CoreException;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+import org.spearce.jgit.treewalk.WorkingTreeIterator;
+import org.spearce.jgit.util.FS;
+
+/**
+ * Adapts an Eclipse {@link IContainer} for use in a <code>TreeWalk</code>.
+ * <p>
+ * This iterator converts an Eclipse IContainer object into something that a
+ * TreeWalk instance can iterate over in parallel with any other Git tree data
+ * structure, such as another working directory tree from outside of the
+ * workspace or a stored tree from a Repository object database.
+ * <p>
+ * Modification times provided by this iterator are obtained from the cache
+ * Eclipse uses to track external resource modification. This can be faster, but
+ * requires the user refresh their workspace when external modifications take
+ * place. This is not really a concern as it is common practice to need to do a
+ * workspace refresh after externally modifying a file.
+ * 
+ * @see org.spearce.jgit.treewalk.TreeWalk
+ */
+public class ContainerTreeIterator extends WorkingTreeIterator {
+	private static String computePrefix(final IContainer base) {
+		final RepositoryMapping rm = RepositoryMapping.getMapping(base);
+		if (rm == null)
+			throw new IllegalArgumentException("Not in a Git project: " + base);
+		return rm.getRepoRelativePath(base);
+	}
+
+	private final IContainer node;
+
+	/**
+	 * Construct a new iterator from the workspace.
+	 * <p>
+	 * The iterator will support traversal over the named container, but only if
+	 * it is contained within a project which has the Git repository provider
+	 * connected and this resource is mapped into a Git repository. During the
+	 * iteration the paths will be automatically generated to match the proper
+	 * repository paths for this container's children.
+	 * 
+	 * @param base
+	 *            the part of the workspace the iterator will walk over.
+	 */
+	public ContainerTreeIterator(final IContainer base) {
+		super(computePrefix(base));
+		node = base;
+	}
+
+	private ContainerTreeIterator(final WorkingTreeIterator p,
+			final IContainer base) {
+		super(p);
+		node = base;
+	}
+
+	@Override
+	public AbstractTreeIterator createSubtreeIterator(final Repository db)
+			throws IncorrectObjectTypeException, IOException {
+		if (FileMode.TREE.equals(mode))
+			return new ContainerTreeIterator(this,
+					(IContainer) ((ResourceEntry) current()).rsrc);
+		else
+			throw new IncorrectObjectTypeException(ObjectId.zeroId(),
+					Constants.TYPE_TREE);
+	}
+
+	@Override
+	protected Entry[] getEntries() throws IOException {
+		final IResource[] all;
+		try {
+			all = node.members(IContainer.INCLUDE_HIDDEN);
+		} catch (CoreException err) {
+			final IOException ioe = new IOException(err.getMessage());
+			ioe.initCause(err);
+			throw ioe;
+		}
+
+		final Entry[] r = new Entry[all.length];
+		for (int i = 0; i < r.length; i++)
+			r[i] = new ResourceEntry(all[i]);
+		return r;
+	}
+
+	static class ResourceEntry extends Entry {
+		final IResource rsrc;
+
+		private final FileMode mode;
+
+		private long length = -1;
+
+		ResourceEntry(final IResource f) {
+			rsrc = f;
+
+			switch (f.getType()) {
+			case IResource.FILE:
+				if (FS.INSTANCE.canExecute(asFile()))
+					mode = FileMode.EXECUTABLE_FILE;
+				else
+					mode = FileMode.REGULAR_FILE;
+				break;
+			case IResource.FOLDER: {
+				final IContainer c = (IContainer) f;
+				if (c.findMember(".git") != null)
+					mode = FileMode.GITLINK;
+				else
+					mode = FileMode.TREE;
+				break;
+			}
+			default:
+				mode = FileMode.MISSING;
+				break;
+			}
+		}
+
+		@Override
+		public FileMode getMode() {
+			return mode;
+		}
+
+		@Override
+		public String getName() {
+			return rsrc.getName();
+		}
+
+		@Override
+		public long getLength() {
+			if (length < 0) {
+				if (rsrc instanceof IFile)
+					length = asFile().length();
+				else
+					length = 0;
+			}
+			return length;
+		}
+
+		@Override
+		public long getLastModified() {
+			return rsrc.getLocalTimeStamp();
+		}
+
+		@Override
+		public InputStream openInputStream() throws IOException {
+			if (rsrc instanceof IFile) {
+				try {
+					return ((IFile) rsrc).getContents(true);
+				} catch (CoreException err) {
+					final IOException ioe = new IOException(err.getMessage());
+					ioe.initCause(err);
+					throw ioe;
+				}
+			}
+			throw new IOException("Not a regular file: " + rsrc);
+		}
+
+		private File asFile() {
+			return ((IFile) rsrc).getLocation().toFile();
+		}
+	}
+}
-- 
1.6.0.rc2.219.g1250ab
