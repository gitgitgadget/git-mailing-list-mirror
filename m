From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Add "compare with index" action.
Date: Thu, 12 Feb 2009 15:18:26 +0100
Message-ID: <49942FB2.9040903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 15:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXcQ4-0005Pj-FO
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 15:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbZBLOSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 09:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbZBLOSc
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 09:18:32 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:64145 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbZBLOSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 09:18:30 -0500
Received: by fxm13 with SMTP id 13so2029487fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 06:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=QW9nf5rPmqLhX6hzl7LTQ4bwUgRS8OtxOEGwfaLJ480=;
        b=Up/8XOMrcNaNhfIkhxrrd1xCCYk+HGkcfdfGbxDedUxxAtshQe4+qBmp4igYwr3nAS
         hjEoHgta0v7Zwu7QPS940wHunDZGCgQlemDPFxOc+6iIF3ze2AxzmX2rqnhYFik6fh5k
         oyrtQjbKetK2ZEzuHrtddDxK2E43qMGXCcnlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=T0R+LK0CI9PXkYcw44hhkMaG5gJnRDJDU3BI4gS+htUYfxDPKkI5fKdcvQwS2uNaEY
         k4NZMS6gDY85m81TCGP7WesTgjXCYFghCHCuhSK++nBdhGtsyL+U63z3hDeKpT7drFQ/
         8pcTbzwkxe0BjipnW2jcd9Ltmj2BptTpxK2zc=
Received: by 10.86.99.9 with SMTP id w9mr988283fgb.31.1234448308224;
        Thu, 12 Feb 2009 06:18:28 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id l19sm1249781fgb.47.2009.02.12.06.18.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 06:18:27 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109619>

In the Compare With... menu, the "compare with index" action opens
a diff editor that compares the workspace version of a file and its
index version.

The local file can be modified and saved.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
This is the second version of the patch and replace the first one
(except if it was in the time applied, in which case I will provide
a diff).

This version permits to modify and save the local file.

-- yann

 .../core/internal/storage/GitFileRevision.java     |   11 +++
 org.spearce.egit.ui/plugin.properties              |    3 +
 org.spearce.egit.ui/plugin.xml                     |    7 ++
 .../GitCompareFileRevisionEditorInput.java         |   24 +++--
 .../internal/actions/CompareWithIndexAction.java   |   92
++++++++++++++++++++
 5 files changed, 127 insertions(+), 10 deletions(-)
 create mode 100644
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java

diff --git
a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
index 21ba19e..2f23c7d 100644
---
a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
+++
b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
@@ -49,6 +49,17 @@ public static GitFileRevision inCommit(final
Repository db,
         return new CommitFileRevision(db, commit, path, blobId);
     }
 
+    /**
+     * @param db
+     *            the repository which contains the index to use.
+     * @param path
+     *            path of the resource in the index
+     * @return revision implementation for the given path in the index
+     */
+    public static GitFileRevision inIndex(final Repository db, final
String path) {
+        return new IndexFileRevision(db, path);
+    }
+
     private final String path;
 
     GitFileRevision(final String fileName) {
diff --git a/org.spearce.egit.ui/plugin.properties
b/org.spearce.egit.ui/plugin.properties
index fa043f1..0fc869b 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -31,6 +31,9 @@ Decorator_description=Shows Git specific information
on resources in projects un
 CompareWithRevisionAction_label=Compare With Git Revision
 CompareWithRevisionAction_tooltip=Compare With a Git Revision
 
+CompareWithIndexAction_label=Compare with index version
+CompareWithIndexAction_tooltip=Compare with index version
+
 ShowResourceInHistoryAction_label=Show in Resource History
 ShowResourceInHistoryAction_tooltip=Show selected files in the resource
history view.
 
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 869108c..c706309 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -108,6 +108,13 @@
                label="%CommitAction_label"
                menubarPath="team.main/group1"
                tooltip="%CommitAction_tooltip"/>
+         <action
+              
class="org.spearce.egit.ui.internal.actions.CompareWithIndexAction"
+              
id="org.spearce.egit.ui.internal.actions.CompareWithIndexAction"
+               label="%CompareWithIndexAction_label"
+               menubarPath="compareWithMenu/gitCompareWithGroup"
+               tooltip="&amp;CompareWithIndexAction_tooltip">
+         </action>
       </objectContribution>
       <objectContribution
          id="org.spearce.egit.ui.resetto"
diff --git
a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
index 8aa076f..a54c2ee 100644
---
a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
+++
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
@@ -11,7 +11,6 @@
 import java.lang.reflect.InvocationTargetException;
 
 import org.eclipse.compare.CompareConfiguration;
-import org.eclipse.compare.CompareEditorInput;
 import org.eclipse.compare.IEditableContent;
 import org.eclipse.compare.IResourceProvider;
 import org.eclipse.compare.ITypedElement;
@@ -33,14 +32,16 @@
 import org.eclipse.team.internal.ui.TeamUIPlugin;
 import org.eclipse.team.internal.ui.Utils;
 import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
+import
org.eclipse.team.internal.ui.history.CompareFileRevisionEditorInput.MyDiffNode;
 import org.eclipse.team.internal.ui.synchronize.LocalResourceTypedElement;
+import org.eclipse.team.ui.synchronize.SaveableCompareEditorInput;
 import org.eclipse.ui.IWorkbenchPage;
 
 /**
  * The input provider for the compare editor when working on resources
  * under Git control.
  */
-public class GitCompareFileRevisionEditorInput extends CompareEditorInput {
+public class GitCompareFileRevisionEditorInput extends
SaveableCompareEditorInput {
 
     private ITypedElement left;
     private ITypedElement right;
@@ -52,7 +53,7 @@
      * @param page
      */
     public GitCompareFileRevisionEditorInput(ITypedElement left,
ITypedElement right, IWorkbenchPage page) {
-        super(new CompareConfiguration());
+        super(new CompareConfiguration(), page);
         this.left = left;
         this.right = right;
     }
@@ -326,12 +327,13 @@ private String getContentIdentifier(ITypedElement
element){
         return TeamUIMessages.CompareFileRevisionEditorInput_2;
     }
 
-//    /* (non-Javadoc)
-//     * @see
org.eclipse.team.ui.synchronize.LocalResourceCompareEditorInput#fireInputChange()
-//     */
-//    protected void fireInputChange() {
-//        ((DiffNode)getCompareResult()).fireChange();
-//    }
+    /* (non-Javadoc)
+     * @see
org.eclipse.team.ui.synchronize.SaveableCompareEditorInput#fireInputChange()
+     */
+    @Override
+    protected void fireInputChange() {
+        ((MyDiffNode)getCompareResult()).fireChange();
+    }
 //
 //    /* (non-Javadoc)
 //     * @see
org.eclipse.team.ui.synchronize.SaveableCompareEditorInput#contentsCreated()
@@ -359,7 +361,9 @@ private LocalResourceTypedElement getLocalElement() {
         return null;
     }
 
-    protected Object prepareInput(IProgressMonitor monitor) throws
InvocationTargetException, InterruptedException {
+    @Override
+    protected ICompareInput prepareCompareInput(IProgressMonitor monitor)
+            throws InvocationTargetException, InterruptedException {
         ICompareInput input = createCompareInput();
         getCompareConfiguration().setLeftEditable(isLeftEditable(input));
         getCompareConfiguration().setRightEditable(false);
diff --git
a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java
new file mode 100644
index 0000000..7e14cc9
--- /dev/null
+++
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java
@@ -0,0 +1,92 @@
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
+import org.eclipse.compare.CompareUI;
+import org.eclipse.compare.ITypedElement;
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.jface.action.IAction;
+import org.eclipse.team.core.history.IFileRevision;
+import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
+import org.eclipse.team.ui.synchronize.SaveableCompareEditorInput;
+import org.spearce.egit.core.internal.storage.GitFileRevision;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.ui.internal.GitCompareFileRevisionEditorInput;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * The "compare with index" action. This action opens a diff editor
comparing
+ * the file as found in the working directory and the version found in
the index
+ * of the repository.
+ */
+@SuppressWarnings("restriction")
+public class CompareWithIndexAction extends RepositoryAction {
+
+    @Override
+    public void execute(IAction action) {
+        final IResource resource = getSelectedResources()[0];
+        final RepositoryMapping mapping =
RepositoryMapping.getMapping(resource.getProject());
+        final Repository repository = mapping.getRepository();
+        final String gitPath = mapping.getRepoRelativePath(resource);
+
+        final IFileRevision nextFile =
GitFileRevision.inIndex(repository, gitPath);
+
+        final IFile baseFile = (IFile)resource;
+        final ITypedElement base =
SaveableCompareEditorInput.createFileElement(baseFile);
+        final ITypedElement next = new FileRevisionTypedElement(nextFile);
+
+        final GitCompareFileRevisionEditorInput in = new
GitCompareFileRevisionEditorInput(
+                base, next, null);
+        CompareUI.openCompareEditor(in);
+    }
+
+    @Override
+    public boolean isEnabled() {
+        final IResource[] selectedResources = getSelectedResources();
+        if (selectedResources.length != 1)
+            return false;
+        final IResource resource = selectedResources[0];
+        if (!(resource instanceof IFile)) {
+            return false;
+        }
+        final RepositoryMapping mapping =
RepositoryMapping.getMapping(resource.getProject());
+        return mapping != null;
+    }
+
+}
\ No newline at end of file
-- 
1.6.1.2
