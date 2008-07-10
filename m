From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Make quick diff aware of changes in the repository.
Date: Fri, 11 Jul 2008 00:41:11 +0200
Message-ID: <1215729672-26906-2-git-send-email-robin.rosenberg@dewire.com>
References: <1215729672-26906-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vd-0004Lo-Au
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbYGJWqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355AbYGJWqh
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13193 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754400AbYGJWqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0488E802846;
	Fri, 11 Jul 2008 00:46:20 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A6bmqt+WAabY; Fri, 11 Jul 2008 00:46:18 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5CB56147B7ED;
	Fri, 11 Jul 2008 00:46:18 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729672-26906-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88036>

Currently only refs changes are relevant.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/decorators/GitDocument.java   |  107 ++++++++++++++++++++
 .../internal/decorators/GitQuickDiffProvider.java  |   57 ++---------
 2 files changed, 117 insertions(+), 47 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
new file mode 100644
index 0000000..23e06d9
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -0,0 +1,107 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.decorators;
+
+import java.io.BufferedReader;
+import java.io.CharArrayWriter;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.InputStreamReader;
+
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IStorage;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.jface.text.Document;
+import org.eclipse.team.core.RepositoryProvider;
+import org.eclipse.team.core.history.IFileHistory;
+import org.eclipse.team.core.history.IFileHistoryProvider;
+import org.eclipse.team.core.history.IFileRevision;
+import org.spearce.egit.core.GitProvider;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.ui.Activator;
+import org.spearce.jgit.lib.IndexChangedEvent;
+import org.spearce.jgit.lib.RefsChangedEvent;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryListener;
+
+class GitDocument extends Document implements RepositoryListener {
+	private final IResource resource;
+
+	static GitDocument create(IResource resource) throws IOException, CoreException {
+		GitDocument ret = null;
+		if (RepositoryProvider.getProvider(resource.getProject()) instanceof GitProvider) {
+			ret = new GitDocument(resource);
+			ret.populate();
+		}
+		return ret;
+	}
+
+	private GitDocument(IResource resource) {
+		this.resource = resource;
+	}
+
+	void populate() throws IOException, CoreException {
+		set("");
+		IProject project = resource.getProject();
+		RepositoryProvider provider = RepositoryProvider.getProvider(project);
+		getRepository().addRepositoryChangedListener(this);
+		IFileHistoryProvider fileHistoryProvider = provider
+				.getFileHistoryProvider();
+		IFileHistory fileHistoryFor = fileHistoryProvider.getFileHistoryFor(
+				resource, IFileHistoryProvider.SINGLE_REVISION, null);
+		IFileRevision[] revisions = fileHistoryFor.getFileRevisions();
+		if (revisions != null && revisions.length > 0) {
+			IFileRevision revision = revisions[0];
+			Activator.trace("(GitQuickDiffProvider) compareTo: "
+					+ revision.getContentIdentifier());
+			IStorage storage = revision.getStorage(null);
+			InputStream contents = storage.getContents();
+			BufferedReader in = new BufferedReader(new InputStreamReader(
+					contents));
+			final int DEFAULT_FILE_SIZE = 15 * 1024;
+
+			CharArrayWriter caw = new CharArrayWriter(DEFAULT_FILE_SIZE);
+			char[] readBuffer = new char[2048];
+			int n = in.read(readBuffer);
+			while (n > 0) {
+				caw.write(readBuffer, 0, n);
+				n = in.read(readBuffer);
+			}
+			String s = caw.toString();
+			set(s);
+			Activator.trace("(GitQuickDiffProvider) has reference doc, size=" + s.length() + " bytes");
+		} else {
+			Activator.trace("(GitQuickDiffProvider) no revision.");
+		}
+	}
+
+	void dispose() {
+		getRepository().removeRepositoryChangedListener(this);
+	}
+
+	public void refsChanged(final RefsChangedEvent e) {
+		try {
+			populate();
+		} catch (IOException e1) {
+			Activator.logError("Failed to refresh quickdiff", e1);
+		} catch (CoreException e1) {
+			Activator.logError("Failed to refresh quickdiff", e1);
+		}
+	}
+
+	public void indexChanged(final IndexChangedEvent e) {
+		// Index not relevant at this moment
+	}
+
+	private Repository getRepository() {
+		IProject project = resource.getProject();
+		RepositoryMapping mapping = RepositoryMapping.getMapping(project);
+		return mapping.getRepository();
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
index 5525914..052552e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
@@ -8,22 +8,13 @@
  *******************************************************************************/
 package org.spearce.egit.ui.internal.decorators;
 
-import java.io.BufferedReader;
-import java.io.CharArrayWriter;
 import java.io.IOException;
-import java.io.InputStream;
-import java.io.InputStreamReader;
 
-import org.eclipse.core.resources.IFile;
-import org.eclipse.core.resources.IStorage;
+import org.eclipse.core.resources.IResource;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.IProgressMonitor;
-import org.eclipse.jface.text.Document;
 import org.eclipse.jface.text.IDocument;
 import org.eclipse.team.core.RepositoryProvider;
-import org.eclipse.team.core.history.IFileHistory;
-import org.eclipse.team.core.history.IFileHistoryProvider;
-import org.eclipse.team.core.history.IFileRevision;
 import org.eclipse.ui.IEditorInput;
 import org.eclipse.ui.ide.ResourceUtil;
 import org.eclipse.ui.texteditor.ITextEditor;
@@ -38,12 +29,14 @@ public class GitQuickDiffProvider implements IQuickDiffReferenceProvider {
 
 	private String id;
 
-	private Document document;
+	private GitDocument document;
 
-	private IFile file;
+	private IResource resource;
 
 	public void dispose() {
-		// No resources to free
+		Activator.trace("(GitQuickDiffProvider) dispose");
+		if (document != null)
+			document.dispose();
 	}
 
 	public String getId() {
@@ -52,42 +45,12 @@ public class GitQuickDiffProvider implements IQuickDiffReferenceProvider {
 
 	public IDocument getReference(IProgressMonitor monitor)
 			throws CoreException {
-		document = new Document();
-		Activator.trace("(GitQuickDiffProvider) file: " + file);
-
-		RepositoryProvider provider = RepositoryProvider.getProvider(file
+		Activator.trace("(GitQuickDiffProvider) file: " + resource);
+		RepositoryProvider provider = RepositoryProvider.getProvider(resource
 				.getProject());
 		if (provider != null) {
 			try {
-				IFileHistoryProvider fileHistoryProvider = provider
-						.getFileHistoryProvider();
-				IFileHistory fileHistoryFor = fileHistoryProvider
-						.getFileHistoryFor(file,
-								IFileHistoryProvider.SINGLE_REVISION, null);
-				IFileRevision[] revisions = fileHistoryFor.getFileRevisions();
-				if (revisions != null && revisions.length > 0) {
-					IFileRevision revision = revisions[0];
-					Activator.trace("(GitQuickDiffProvider) compareTo: "
-							+ revision.getContentIdentifier());
-					IStorage storage = revision.getStorage(null);
-					InputStream contents = storage.getContents();
-					BufferedReader in = new BufferedReader(
-							new InputStreamReader(contents));
-					final int DEFAULT_FILE_SIZE = 15 * 1024;
-
-					CharArrayWriter caw = new CharArrayWriter(DEFAULT_FILE_SIZE);
-					char[] readBuffer = new char[2048];
-					int n = in.read(readBuffer);
-					while (n > 0) {
-						caw.write(readBuffer, 0, n);
-						n = in.read(readBuffer);
-					}
-					String s = caw.toString();
-					document.set(s);
-				} else {
-					Activator.trace("(GitQuickDiffProvider) no revision.");
-					document.set("");
-				}
+				document = GitDocument.create(resource);
 			} catch (CoreException e) {
 				Activator.error(UIText.QuickDiff_failedLoading, e);
 			} catch (IOException e) {
@@ -105,7 +68,7 @@ public class GitQuickDiffProvider implements IQuickDiffReferenceProvider {
 
 	public void setActiveEditor(ITextEditor editor) {
 		IEditorInput editorInput = editor.getEditorInput();
-		file = ResourceUtil.getFile(editorInput);
+		resource = ResourceUtil.getResource(editorInput);
 	}
 
 	public void setId(String id) {
-- 
1.5.6.2.220.g44701
