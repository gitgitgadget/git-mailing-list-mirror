From: alex@bandlem.com (Alex Blewitt)
Subject: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 12:50:42 +0100 (BST)
Message-ID: <20090423115042.743E6D9CDC@apple.int.bandlem.com>
To: alex.blewitt@gmail.com, git@vger.kernel.org,
	robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 23 14:01:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwxcD-0006R8-KM
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 14:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbZDWL7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 07:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbZDWL7n
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 07:59:43 -0400
Received: from server.bandlem.com ([217.155.97.60]:48752 "EHLO
	apple.int.bandlem.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751812AbZDWL7m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 07:59:42 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2009 07:59:41 EDT
Received: by apple.int.bandlem.com (Postfix, from userid 1000)
	id 743E6D9CDC; Thu, 23 Apr 2009 12:50:42 +0100 (BST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117333>

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index 523a959..be3b40c 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -52,10 +52,12 @@ FetchAction_tooltip=Fetch from another repository
 PushAction_label=&Push To...
 PushAction_tooltip=Push to another repository
 
+IgnoreAction_label=Add to .git&ignore...
+IgnoreAction_tooltip=Ignore the selected resources
+
 GitActions_label=Git
 GitMenu_label=&Git
 
-
 Theme_label=Git
 Theme_CommitGraphNormalFont_label=Commit graph normal font
 Theme_CommitGraphNormalFont_description=This font is used to draw the revision history.
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index a94c8bc..1f62292 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -115,6 +115,12 @@
 	       menubarPath="compareWithMenu/gitCompareWithGroup"
 	       tooltip="&amp;CompareWithIndexAction_tooltip">
 	 </action>
+         <action
+               class="org.spearce.egit.ui.internal.actions.IgnoreAction"
+               id="org.spearce.egit.ui.internal.actions.IgnoreAction"
+               label="%IgnoreAction_label"
+               menubarPath="team.main/group1"
+               tooltip="%IgnoreAction_tooltip"/>
 	  </objectContribution>
 	  <objectContribution
          id="org.spearce.egit.ui.resetto"
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/IgnoreAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/IgnoreAction.java
new file mode 100644
index 0000000..501443e
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/IgnoreAction.java
@@ -0,0 +1,91 @@
+/*******************************************************************************
+ * Copyright (C) 2009, Alex Blewitt <alex.blewitt@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
+
+import org.eclipse.core.resources.IContainer;
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.WorkspaceJob;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Path;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.jface.action.IAction;
+import org.eclipse.team.core.Team;
+import org.spearce.jgit.lib.Constants;
+
+/**
+ * Action for ignoring files via .gitignore
+ *
+ */
+public class IgnoreAction extends RepositoryAction {
+	
+	private static final String GITIGNORE = ".gitignore";
+
+	@SuppressWarnings("restriction")
+	@Override
+	public void run(IAction action) {
+		final IResource[] resources = getSelectedResources();
+		if (resources.length == 0)
+			return;
+		
+		WorkspaceJob job = new WorkspaceJob("Ignore Git resources") { //$NON-NLS-1$
+			public IStatus runInWorkspace(IProgressMonitor monitor) throws CoreException {
+				monitor.beginTask("Ignoring Git resources", resources.length); //$NON-NLS-1$
+				try {
+					for (IResource resource : resources) {
+						// TODO This is pretty inefficient; multiple ignores in the same directory cause multiple writes.
+						// NB This does the same thing in DecoratableResourceAdapter, but neither currently consult .gitignore
+						if (!Team.isIgnoredHint(resource)) {
+							IContainer container = resource.getParent();
+							IFile gitignore = container.getFile(new Path(GITIGNORE));
+							String entry = "/" + resource.getName() + "\n"; //$NON-NLS-1$  //$NON-NLS-2$
+							// TODO What is the character set and new-line convention?
+							if(gitignore.exists()) {
+								// This is ugly. CVS uses an internal representation of the .gitignore to re-write/overwrite each time.
+								ByteArrayOutputStream out = new ByteArrayOutputStream(2048);
+								out.write(entry.getBytes(Constants.CHARACTER_ENCODING)); // TODO Default encoding?
+								gitignore.appendContents(new ByteArrayInputStream(out.toByteArray()),true,true,monitor);
+							} else {
+								ByteArrayInputStream bais = new ByteArrayInputStream( entry.getBytes(Constants.CHARACTER_ENCODING) ); 
+								gitignore.create( bais,true,monitor);					
+							}
+						}
+						monitor.worked(1);
+					}
+					monitor.done();
+				} catch (CoreException e) {
+					throw e;
+				} catch (Exception e) {
+					throw new CoreException(new Status(IStatus.ERROR, "org.spearce.egit.ui", "Unable to ignore resources", e)); //$NON-NLS-1$
+				}
+				return Status.OK_STATUS;			
+			}
+		};
+		job.schedule();		
+	}
+
+	@SuppressWarnings("restriction")
+	@Override
+	public boolean isEnabled() {
+		if (getProjectsInRepositoryOfSelectedResources().length == 0)
+			return false;
+
+		IResource[] resources = getSelectedResources();
+		for (IResource resource : resources) {
+			// NB This does the same thing in DecoratableResourceAdapter, but neither currently consult .gitignore
+			if (!Team.isIgnoredHint(resource))
+				return true;
+		}
+		return false;
+	}
+}
