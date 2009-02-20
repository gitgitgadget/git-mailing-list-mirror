From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Add "compare with index" action.
Date: Fri, 20 Feb 2009 09:20:29 +0100
Message-ID: <499E67CD.9020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:22:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQe5-0002Ox-G4
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbZBTIUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbZBTIUg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:20:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:51594 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbZBTIUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:20:34 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1720609fgg.17
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 00:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=PALxEYqGMgVJJX/zsEScgGa10/AyvQWM8/tUZUVOklQ=;
        b=ihSkG1s9EHGoc5YcMU9FIauOp7IjhY3F0SrKojnbqDyKhGhsJ3u0zsVFb3JseNTimM
         ZwJ5VqAi6a4vipcwdYEnccUbk++BxNOTlXHci+1Ct60vZja6Pn8yTMLEECHLZMWpP6YH
         vMUXaY4ZTR4QRd7ZkseYe+S5nwiXiJLdvmLKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=jDikKYL8wYxVlfa6Uhx5GYuHfBambH6CkyDP2j4oEBGK1VrqKJOm7106BzNUVuRm6y
         sJCRlLrMnJh0qw1cIaCxNXENxnPhLt2XBBTr2HADmjibFMwsNThvuhwTIIAlVtqXn8mY
         o3l4tyCwgFIfR94cz+6EvdzhWPzgmymayd7DY=
Received: by 10.86.72.15 with SMTP id u15mr911000fga.8.1235118031793;
        Fri, 20 Feb 2009 00:20:31 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 4sm937020fge.24.2009.02.20.00.20.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 00:20:31 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110814>

In the Compare With... menu, the "compare with index" action opens
a diff editor that compares the workspace version of a file and its
index version.

The local file can be modified and saved.

The staged version can be modified and saved. This updates the index.
For this, add methods into GitIndex to allow to specify a content
different from the file.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
This send correct the whitespaces corruption.

-- yann

 .../core/internal/storage/GitFileRevision.java     |   11 ++
 org.spearce.egit.ui/plugin.properties              |    3 +
 org.spearce.egit.ui/plugin.xml                     |    7 +
 .../spearce/egit/ui/internal/EditableRevision.java |  157 ++++++++++++++++++++
 .../GitCompareFileRevisionEditorInput.java         |   36 +++--
 .../internal/actions/CompareWithIndexAction.java   |  119 +++++++++++++++
 .../src/org/spearce/jgit/lib/GitIndex.java         |   65 ++++++++
 7 files changed, 384 insertions(+), 14 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/EditableRevision.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
index 21ba19e..2f23c7d 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
@@ -49,6 +49,17 @@ public static GitFileRevision inCommit(final Repository db,
 		return new CommitFileRevision(db, commit, path, blobId);
 	}
 
+	/**
+	 * @param db
+	 *            the repository which contains the index to use.
+	 * @param path
+	 *            path of the resource in the index
+	 * @return revision implementation for the given path in the index
+	 */
+	public static GitFileRevision inIndex(final Repository db, final String path) {
+		return new IndexFileRevision(db, path);
+	}
+
 	private final String path;
 
 	GitFileRevision(final String fileName) {
diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index 58b879f..cb3a5be 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -31,6 +31,9 @@ Decorator_description=Shows Git specific information on resources in projects un
 CompareWithRevisionAction_label=Compare With Git Revision
 CompareWithRevisionAction_tooltip=Compare With a Git Revision
 
+CompareWithIndexAction_label=Compare with index version
+CompareWithIndexAction_tooltip=Compare with index version
+
 ShowResourceInHistoryAction_label=Show in Resource History
 ShowResourceInHistoryAction_tooltip=Show selected files in the resource history view.
 
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 2f23559..678fd73 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -108,6 +108,13 @@
                label="%CommitAction_label"
                menubarPath="team.main/group1"
                tooltip="%CommitAction_tooltip"/>
+         <action
+               class="org.spearce.egit.ui.internal.actions.CompareWithIndexAction"
+               id="org.spearce.egit.ui.internal.actions.CompareWithIndexAction"
+               label="%CompareWithIndexAction_label"
+               menubarPath="compareWithMenu/gitCompareWithGroup"
+               tooltip="&amp;CompareWithIndexAction_tooltip">
+         </action>
 	  </objectContribution>
 	  <objectContribution
          id="org.spearce.egit.ui.resetto"
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/EditableRevision.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/EditableRevision.java
new file mode 100644
index 0000000..ee064ef
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/EditableRevision.java
@@ -0,0 +1,157 @@
+/*
+ * Copyright (C) 2009, Yann Simon <yann.simon.fr@gmail.com>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.egit.ui.internal;
+
+import java.io.ByteArrayInputStream;
+import java.io.InputStream;
+
+import org.eclipse.compare.IContentChangeListener;
+import org.eclipse.compare.IContentChangeNotifier;
+import org.eclipse.compare.IEditableContent;
+import org.eclipse.compare.ISharedDocumentAdapter;
+import org.eclipse.compare.ITypedElement;
+import org.eclipse.compare.internal.ContentChangeNotifier;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.Platform;
+import org.eclipse.team.core.history.IFileRevision;
+import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
+import org.eclipse.team.internal.ui.synchronize.EditableSharedDocumentAdapter;
+
+/**
+ * @author simon
+ *
+ */
+public class EditableRevision extends FileRevisionTypedElement implements
+		ITypedElement, IEditableContent, IContentChangeNotifier {
+
+	private byte[] modifiedContent;
+
+	private ContentChangeNotifier fChangeNotifier;
+
+	private EditableSharedDocumentAdapter sharedDocumentAdapter;
+
+	/**
+	 * @param fileRevision
+	 */
+	public EditableRevision(IFileRevision fileRevision) {
+		super(fileRevision);
+	}
+
+	public boolean isEditable() {
+		return true;
+	}
+
+	public ITypedElement replace(ITypedElement dest, ITypedElement src) {
+		return null;
+	}
+
+	@Override
+	public InputStream getContents() throws CoreException {
+		if (modifiedContent != null) {
+			return new ByteArrayInputStream(modifiedContent);
+		}
+		return super.getContents();
+	}
+
+	public void setContent(byte[] newContent) {
+		modifiedContent = newContent;
+		fireContentChanged();
+	}
+
+	/**
+	 * @return the modified content
+	 */
+	public byte[] getModifiedContent() {
+		return modifiedContent;
+	}
+
+	public Object getAdapter(Class adapter) {
+		if (adapter == ISharedDocumentAdapter.class) {
+			return getSharedDocumentAdapter();
+		}
+		return Platform.getAdapterManager().getAdapter(this, adapter);
+	}
+
+	private synchronized ISharedDocumentAdapter getSharedDocumentAdapter() {
+		if (sharedDocumentAdapter == null)
+			sharedDocumentAdapter = new EditableSharedDocumentAdapter(
+					new EditableSharedDocumentAdapter.ISharedDocumentAdapterListener() {
+						public void handleDocumentConnected() {
+						}
+
+						public void handleDocumentFlushed() {
+						}
+
+						public void handleDocumentDeleted() {
+						}
+
+						public void handleDocumentSaved() {
+						}
+
+						public void handleDocumentDisconnected() {
+						}
+					});
+		return sharedDocumentAdapter;
+	}
+
+	public void addContentChangeListener(IContentChangeListener listener) {
+		if (fChangeNotifier == null)
+			fChangeNotifier = new ContentChangeNotifier(this);
+		fChangeNotifier.addContentChangeListener(listener);
+	}
+
+	public void removeContentChangeListener(IContentChangeListener listener) {
+		if (fChangeNotifier != null) {
+			fChangeNotifier.removeContentChangeListener(listener);
+			if (fChangeNotifier.isEmpty())
+				fChangeNotifier = null;
+		}
+	}
+
+	/**
+	 * Notifies all registered <code>IContentChangeListener</code>s of a content
+	 * change.
+	 */
+	protected void fireContentChanged() {
+		if (fChangeNotifier == null || fChangeNotifier.isEmpty()) {
+			return;
+		}
+		fChangeNotifier.fireContentChanged();
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
index 8aa076f..49d4a42 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
@@ -11,7 +11,6 @@
 import java.lang.reflect.InvocationTargetException;
 
 import org.eclipse.compare.CompareConfiguration;
-import org.eclipse.compare.CompareEditorInput;
 import org.eclipse.compare.IEditableContent;
 import org.eclipse.compare.IResourceProvider;
 import org.eclipse.compare.ITypedElement;
@@ -34,13 +33,14 @@
 import org.eclipse.team.internal.ui.Utils;
 import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
 import org.eclipse.team.internal.ui.synchronize.LocalResourceTypedElement;
+import org.eclipse.team.ui.synchronize.SaveableCompareEditorInput;
 import org.eclipse.ui.IWorkbenchPage;
 
 /**
  * The input provider for the compare editor when working on resources
  * under Git control.
  */
-public class GitCompareFileRevisionEditorInput extends CompareEditorInput {
+public class GitCompareFileRevisionEditorInput extends SaveableCompareEditorInput {
 
 	private ITypedElement left;
 	private ITypedElement right;
@@ -52,7 +52,7 @@
 	 * @param page
 	 */
 	public GitCompareFileRevisionEditorInput(ITypedElement left, ITypedElement right, IWorkbenchPage page) {
-		super(new CompareConfiguration());
+		super(new CompareConfiguration(), page);
 		this.left = left;
 		this.right = right;
 	}
@@ -90,9 +90,18 @@ private static void ensureContentsCached(FileRevisionTypedElement left, FileRevi
 	}
 
 	private boolean isLeftEditable(ICompareInput input) {
-		Object left = input.getLeft();
-		if (left instanceof IEditableContent) {
-			return ((IEditableContent) left).isEditable();
+		Object tmpLeft = input.getLeft();
+		return isEditable(tmpLeft);
+	}
+
+	private boolean isRightEditable(ICompareInput input) {
+		Object tmpRight = input.getRight();
+		return isEditable(tmpRight);
+	}
+
+	private boolean isEditable(Object object) {
+		if (object instanceof IEditableContent) {
+			return ((IEditableContent) object).isEditable();
 		}
 		return false;
 	}
@@ -326,12 +335,9 @@ private String getContentIdentifier(ITypedElement element){
 		return TeamUIMessages.CompareFileRevisionEditorInput_2;
 	}
 
-//	/* (non-Javadoc)
-//	 * @see org.eclipse.team.ui.synchronize.LocalResourceCompareEditorInput#fireInputChange()
-//	 */
-//	protected void fireInputChange() {
-//		((DiffNode)getCompareResult()).fireChange();
-//	}
+	@Override
+	protected void fireInputChange() {
+	}
 //
 //	/* (non-Javadoc)
 //	 * @see org.eclipse.team.ui.synchronize.SaveableCompareEditorInput#contentsCreated()
@@ -359,10 +365,12 @@ private LocalResourceTypedElement getLocalElement() {
 		return null;
 	}
 
-	protected Object prepareInput(IProgressMonitor monitor) throws InvocationTargetException, InterruptedException {
+	@Override
+	protected ICompareInput prepareCompareInput(IProgressMonitor monitor)
+			throws InvocationTargetException, InterruptedException {
 		ICompareInput input = createCompareInput();
 		getCompareConfiguration().setLeftEditable(isLeftEditable(input));
-		getCompareConfiguration().setRightEditable(false);
+		getCompareConfiguration().setRightEditable(isRightEditable(input));
 		ensureContentsCached(getLeftRevision(), getRightRevision(), monitor);
 		initLabels(input);
 		setTitle(NLS.bind(TeamUIMessages.SyncInfoCompareInput_title, new String[] { input.getName() }));
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java
new file mode 100644
index 0000000..3bc24be
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java
@@ -0,0 +1,119 @@
+/*
+ * Copyright (C) 2009, Yann Simon <yann.simon.fr@gmail.com>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.egit.ui.internal.actions;
+
+import java.io.File;
+import java.io.IOException;
+
+import org.eclipse.compare.CompareUI;
+import org.eclipse.compare.IContentChangeListener;
+import org.eclipse.compare.IContentChangeNotifier;
+import org.eclipse.compare.ITypedElement;
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.jface.action.IAction;
+import org.eclipse.team.core.history.IFileRevision;
+import org.eclipse.team.internal.ui.Utils;
+import org.eclipse.team.ui.synchronize.SaveableCompareEditorInput;
+import org.spearce.egit.core.internal.storage.GitFileRevision;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.ui.internal.EditableRevision;
+import org.spearce.egit.ui.internal.GitCompareFileRevisionEditorInput;
+import org.spearce.jgit.lib.GitIndex;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * The "compare with index" action. This action opens a diff editor comparing
+ * the file as found in the working directory and the version found in the index
+ * of the repository.
+ */
+@SuppressWarnings("restriction")
+public class CompareWithIndexAction extends RepositoryAction {
+
+	@Override
+	public void execute(IAction action) {
+		final IResource resource = getSelectedResources()[0];
+		final RepositoryMapping mapping = RepositoryMapping.getMapping(resource.getProject());
+		final Repository repository = mapping.getRepository();
+		final String gitPath = mapping.getRepoRelativePath(resource);
+
+		final IFileRevision nextFile = GitFileRevision.inIndex(repository, gitPath);
+
+		final IFile baseFile = (IFile) resource;
+		final ITypedElement base = SaveableCompareEditorInput.createFileElement(baseFile);
+
+		final EditableRevision next = new EditableRevision(nextFile);
+
+		IContentChangeListener listener = new IContentChangeListener() {
+			public void contentChanged(IContentChangeNotifier source) {
+				final byte[] newContent = next.getModifiedContent();
+				try {
+					final GitIndex index = repository.getIndex();
+					final File file = new File(baseFile.getLocation().toString());
+					index.add(mapping.getWorkDir(), file, newContent);
+				} catch (IOException e) {
+					Utils.handleError(getTargetPart().getSite().getShell(), e,
+							"Error during adding to index",
+							"Error during adding to index");
+					return;
+				}
+			}
+		};
+
+		next.addContentChangeListener(listener);
+
+		final GitCompareFileRevisionEditorInput in = new GitCompareFileRevisionEditorInput(
+				base, next, null);
+		CompareUI.openCompareEditor(in);
+	}
+
+	@Override
+	public boolean isEnabled() {
+		final IResource[] selectedResources = getSelectedResources();
+		if (selectedResources.length != 1)
+			return false;
+
+		final IResource resource = selectedResources[0];
+		if (!(resource instanceof IFile)) {
+			return false;
+		}
+		final RepositoryMapping mapping = RepositoryMapping.getMapping(resource.getProject());
+		return mapping != null;
+	}
+
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 920a9c9..21b495a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -170,6 +170,30 @@ public Entry add(File wd, File f) throws IOException {
 	}
 
 	/**
+	 * Add the content of a file to the index.
+	 *
+	 * @param wd
+	 *            workdir
+	 * @param f
+	 *            the file
+	 * @param content
+	 *            content of the file
+	 * @return a new or updated index entry for the path represented by f
+	 * @throws IOException
+	 */
+	public Entry add(File wd, File f, byte[] content) throws IOException {
+		byte[] key = makeKey(wd, f);
+		Entry e = entries.get(key);
+		if (e == null) {
+			e = new Entry(key, f, 0, content);
+			entries.put(key, e);
+		} else {
+			e.update(f, content);
+		}
+		return e;
+	}
+
+	/**
 	 * Remove a path from the index.
 	 *
 	 * @param wd
@@ -360,6 +384,25 @@ Entry(byte[] key, File f, int stage)
 			flags = (short) ((stage << 12) | name.length); // TODO: fix flags
 		}
 
+		Entry(byte[] key, File f, int stage, byte[] newContent)
+				throws IOException {
+			ctime = f.lastModified() * 1000000L;
+			mtime = ctime; // we use same here
+			dev = -1;
+			ino = -1;
+			if (config_filemode() && File_canExecute(f))
+				mode = FileMode.EXECUTABLE_FILE.getBits();
+			else
+				mode = FileMode.REGULAR_FILE.getBits();
+			uid = -1;
+			gid = -1;
+			size = newContent.length;
+			ObjectWriter writer = new ObjectWriter(db);
+			sha1 = writer.writeBlob(newContent);
+			name = key;
+			flags = (short) ((stage << 12) | name.length); // TODO: fix flags
+		}
+
 		Entry(TreeEntry f, int stage) {
 			ctime = -1; // hmm
 			mtime = -1;
@@ -433,6 +476,28 @@ public boolean update(File f) throws IOException {
 			return modified;
 		}
 
+		/**
+		 * Update this index entry with stat and SHA-1 information if it looks
+		 * like the file has been modified in the workdir.
+		 *
+		 * @param f
+		 *            file in work dir
+		 * @param newContent
+		 *            the new content of the file
+		 * @return true if a change occurred
+		 * @throws IOException
+		 */
+		public boolean update(File f, byte[] newContent) throws IOException {
+			boolean modified = false;
+			size = newContent.length;
+			ObjectWriter writer = new ObjectWriter(db);
+			ObjectId newsha1 = sha1 = writer.writeBlob(newContent);
+			if (!newsha1.equals(sha1))
+				modified = true;
+			sha1 = newsha1;
+			return modified;
+		}
+
 		void write(ByteBuffer buf) {
 			int startposition = buf.position();
 			buf.putInt((int) (ctime / 1000000000L));
-- 
1.6.1.2
