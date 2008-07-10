From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/2] Provide the ability to configure the quickdiff baseline
Date: Fri, 11 Jul 2008 00:41:12 +0200
Message-ID: <1215729672-26906-3-git-send-email-robin.rosenberg@dewire.com>
References: <1215729672-26906-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729672-26906-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vc-0004Lo-Fs
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbYGJWqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355AbYGJWqd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:33 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13196 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754584AbYGJWqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7E269147B7ED;
	Fri, 11 Jul 2008 00:46:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tH4xte09ti7; Fri, 11 Jul 2008 00:46:19 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 8572A147B7F1;
	Fri, 11 Jul 2008 00:46:18 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729672-26906-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88041>

By default quickdiff compares to HEAD, but you can change that
using the context menu in the history graph. The setting is
remembered during a session on a per Git repository basis.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.properties              |    2 +-
 org.spearce.egit.ui/plugin.xml                     |   14 +++++
 .../actions/QuickdiffBaselineOperation.java        |   44 +++++++++++++++
 .../actions/ResetQuickdiffBaselineAction.java      |   24 ++++++++
 .../actions/SetQuickdiffBaselineAction.java        |   26 +++++++++
 .../egit/ui/internal/decorators/GitDocument.java   |   57 ++++++-------------
 .../internal/decorators/GitQuickDiffProvider.java  |   33 +++++++++++-
 7 files changed, 158 insertions(+), 42 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index 64a88c3..3240ec0 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -6,7 +6,7 @@ Git_clone_wizard=Git Repository
 Git_clone_description=Clone an existing Git repository.
 
 SharingWizard_name=Git
-GitRemoteQuickDiffProvider_label=Latest Git Revision
+GitRemoteQuickDiffProvider_label=A Git Revision
 
 DisconnectAction_label=Disconnect
 DisconnectAction_tooltip=Disconnect the Git team provider.
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index cfd4b80..b809300 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -124,6 +124,20 @@
                enablesFor="1"
                tooltip="Resets HEAD and index, and working directory (changed in tracked files will be lost)">
          </action>
+	 <action
+	       class="org.spearce.egit.ui.internal.actions.SetQuickdiffBaselineAction"
+	       enablesFor="1"
+	       id="org.spearce.egit.ui.setquickdiffbaseline"
+	       label="Set as quickdiff baseline"
+	       menubarPath="additions">
+	 </action>
+	 <action
+	       class="org.spearce.egit.ui.internal.actions.ResetQuickdiffBaselineAction"
+	       enablesFor="*"
+	       id="org.spearce.egit.ui.resetquickdiffbaseline"
+	       label="Reset quickdiff baseline to HEAD"
+	       menubarPath="additions">
+	 </action>
 	  </objectContribution>
    </extension>
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java
new file mode 100644
index 0000000..990958f
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java
@@ -0,0 +1,44 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import java.io.IOException;
+
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.internal.decorators.GitQuickDiffProvider;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * UI operation to change the git quickdiff baseline
+ */
+public class QuickdiffBaselineOperation extends AbstractRevObjectOperation {
+
+	private final String baseline;
+
+	/**
+	 * Construct a QuickdiffBaselineOperation for changing quickdiff baseline
+	 * @param repository
+	 *
+	 * @param baseline
+	 */
+	QuickdiffBaselineOperation(final Repository repository, final String baseline) {
+		super(repository);
+		this.baseline = baseline;
+	}
+
+	public void run(IProgressMonitor monitor) throws CoreException {
+		try {
+			GitQuickDiffProvider.setBaselineReference(repository, baseline);
+		} catch (IOException e) {
+			Activator.logError("Cannot set quickdiff basekine", e);
+		}
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
new file mode 100644
index 0000000..a42635a
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
@@ -0,0 +1,24 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import java.util.List;
+
+import org.eclipse.core.resources.IWorkspaceRunnable;
+import org.eclipse.jface.action.IAction;
+
+/**
+ * Changes the reference for the quickdiff
+ */
+public class ResetQuickdiffBaselineAction extends AbstractRevObjectAction {
+
+	@Override
+	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
+		return new QuickdiffBaselineOperation(getActiveRepository(), "HEAD");
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java
new file mode 100644
index 0000000..05686cf
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java
@@ -0,0 +1,26 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import java.util.List;
+
+import org.eclipse.core.resources.IWorkspaceRunnable;
+import org.eclipse.jface.action.IAction;
+import org.spearce.jgit.revwalk.RevObject;
+
+/**
+ * Changes the reference for the quickdiff
+ */
+public class SetQuickdiffBaselineAction extends AbstractRevObjectAction {
+
+	@Override
+	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
+		return new QuickdiffBaselineOperation(getActiveRepository(), ((RevObject)selection.get(0)).getId().toString());
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index 23e06d9..ebed0cf 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -7,33 +7,26 @@
  *******************************************************************************/
 package org.spearce.egit.ui.internal.decorators;
 
-import java.io.BufferedReader;
-import java.io.CharArrayWriter;
 import java.io.IOException;
-import java.io.InputStream;
-import java.io.InputStreamReader;
 
 import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
-import org.eclipse.core.resources.IStorage;
-import org.eclipse.core.runtime.CoreException;
 import org.eclipse.jface.text.Document;
 import org.eclipse.team.core.RepositoryProvider;
-import org.eclipse.team.core.history.IFileHistory;
-import org.eclipse.team.core.history.IFileHistoryProvider;
-import org.eclipse.team.core.history.IFileRevision;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.Activator;
 import org.spearce.jgit.lib.IndexChangedEvent;
+import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.RepositoryListener;
+import org.spearce.jgit.lib.TreeEntry;
 
 class GitDocument extends Document implements RepositoryListener {
 	private final IResource resource;
 
-	static GitDocument create(IResource resource) throws IOException, CoreException {
+	static GitDocument create(final IResource resource) throws IOException {
 		GitDocument ret = null;
 		if (RepositoryProvider.getProvider(resource.getProject()) instanceof GitProvider) {
 			ret = new GitDocument(resource);
@@ -44,36 +37,24 @@ class GitDocument extends Document implements RepositoryListener {
 
 	private GitDocument(IResource resource) {
 		this.resource = resource;
+		GitQuickDiffProvider.doc2repo.put(this, getRepository());
 	}
 
-	void populate() throws IOException, CoreException {
+	void populate() throws IOException {
 		set("");
-		IProject project = resource.getProject();
-		RepositoryProvider provider = RepositoryProvider.getProvider(project);
-		getRepository().addRepositoryChangedListener(this);
-		IFileHistoryProvider fileHistoryProvider = provider
-				.getFileHistoryProvider();
-		IFileHistory fileHistoryFor = fileHistoryProvider.getFileHistoryFor(
-				resource, IFileHistoryProvider.SINGLE_REVISION, null);
-		IFileRevision[] revisions = fileHistoryFor.getFileRevisions();
-		if (revisions != null && revisions.length > 0) {
-			IFileRevision revision = revisions[0];
-			Activator.trace("(GitQuickDiffProvider) compareTo: "
-					+ revision.getContentIdentifier());
-			IStorage storage = revision.getStorage(null);
-			InputStream contents = storage.getContents();
-			BufferedReader in = new BufferedReader(new InputStreamReader(
-					contents));
-			final int DEFAULT_FILE_SIZE = 15 * 1024;
-
-			CharArrayWriter caw = new CharArrayWriter(DEFAULT_FILE_SIZE);
-			char[] readBuffer = new char[2048];
-			int n = in.read(readBuffer);
-			while (n > 0) {
-				caw.write(readBuffer, 0, n);
-				n = in.read(readBuffer);
-			}
-			String s = caw.toString();
+		final IProject project = resource.getProject();
+		final String gitPath = RepositoryMapping.getMapping(project).getRepoRelativePath(resource);
+		final Repository repository = getRepository();
+		repository.addRepositoryChangedListener(this);
+		String baseline = GitQuickDiffProvider.baseline.get(repository);
+		if (baseline == null)
+			baseline = "HEAD";
+		TreeEntry blobEnry = repository.mapTree(baseline).findBlobMember(gitPath);
+		if (blobEnry != null) {
+			Activator.trace("(GitQuickDiffProvider) compareTo: " + baseline);
+			ObjectLoader loader = repository.openBlob(blobEnry.getId());
+			byte[] bytes = loader.getBytes();
+			String s = new String(bytes); // FIXME Platform default charset. should be Eclipse default
 			set(s);
 			Activator.trace("(GitQuickDiffProvider) has reference doc, size=" + s.length() + " bytes");
 		} else {
@@ -90,8 +71,6 @@ class GitDocument extends Document implements RepositoryListener {
 			populate();
 		} catch (IOException e1) {
 			Activator.logError("Failed to refresh quickdiff", e1);
-		} catch (CoreException e1) {
-			Activator.logError("Failed to refresh quickdiff", e1);
 		}
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
index 052552e..88f5ea0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
@@ -9,6 +9,8 @@
 package org.spearce.egit.ui.internal.decorators;
 
 import java.io.IOException;
+import java.util.Map;
+import java.util.WeakHashMap;
 
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.runtime.CoreException;
@@ -21,6 +23,7 @@ import org.eclipse.ui.texteditor.ITextEditor;
 import org.eclipse.ui.texteditor.quickdiff.IQuickDiffReferenceProvider;
 import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.Repository;
 
 /**
  * This class provides input for the Eclipse Quick Diff feature.
@@ -33,8 +36,19 @@ public class GitQuickDiffProvider implements IQuickDiffReferenceProvider {
 
 	private IResource resource;
 
+	static Map<Repository,String> baseline = new WeakHashMap<Repository,String>();
+	static Map<GitDocument,Repository> doc2repo = new WeakHashMap<GitDocument, Repository>();
+
+	/**
+	 * Create the GitQuickDiffProvider instance
+	 */
+	public GitQuickDiffProvider() {
+		// Empty
+	}
+
 	public void dispose() {
 		Activator.trace("(GitQuickDiffProvider) dispose");
+		doc2repo.remove(document);
 		if (document != null)
 			document.dispose();
 	}
@@ -51,8 +65,6 @@ public class GitQuickDiffProvider implements IQuickDiffReferenceProvider {
 		if (provider != null) {
 			try {
 				document = GitDocument.create(resource);
-			} catch (CoreException e) {
-				Activator.error(UIText.QuickDiff_failedLoading, e);
 			} catch (IOException e) {
 				Activator.error(UIText.QuickDiff_failedLoading, e);
 			}
@@ -74,4 +86,21 @@ public class GitQuickDiffProvider implements IQuickDiffReferenceProvider {
 	public void setId(String id) {
 		this.id = id;
 	}
+
+	/**
+	 * Set a new baseline for quickdiff
+	 *
+	 * @param repository
+	 * @param baseline any commit reference, ref, symref or sha-1
+	 * @throws IOException
+	 */
+	public static void setBaselineReference(final Repository repository, final String baseline) throws IOException {
+		GitQuickDiffProvider.baseline.put(repository, baseline);
+		for (Map.Entry<GitDocument, Repository> i : doc2repo.entrySet()) {
+			if (i.getValue() == repository) {
+				i.getKey().populate();
+			}
+		}
+	}
+
 }
-- 
1.5.6.2.220.g44701
