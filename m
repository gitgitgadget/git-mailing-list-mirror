From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 4/4] Add support for structured comparison.
Date: Sun, 18 Mar 2007 23:16:12 +0100
Message-ID: <20070318221612.24742.40025.stgit@lathund.dewire.com>
References: <20070318220711.24742.90943.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 23:14:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3dx-0000bz-8Y
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933353AbXCRWOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933344AbXCRWOV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:14:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7624 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933353AbXCRWOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 18:14:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C10C1802855;
	Sun, 18 Mar 2007 23:08:56 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18488-09; Sun, 18 Mar 2007 23:08:55 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 86148802664;
	Sun, 18 Mar 2007 23:08:55 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 93CE228CA9;
	Sun, 18 Mar 2007 23:16:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id trVw-Ye1rF+Q; Sun, 18 Mar 2007 23:16:20 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id F228E28CDB;
	Sun, 18 Mar 2007 23:16:12 +0100 (CET)
In-Reply-To: <20070318220711.24742.90943.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42535>

With this code we can now compare revisions at project and folder
levels, rather than only file level. We use the compare api's that
eclipse provide to do the display and detailed compare work, while
we do the high level comparisons at the SHA-1 level.

A possible downside is that the API:s we use are internal, which
could make us version dependent. This code works with both 3.2.x and
3.3M5 versions though.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 org.spearce.egit.core/META-INF/MANIFEST.MF         |    6 
 .../src/org/spearce/egit/core/GitBlobStorage.java  |  108 +++++
 .../src/org/spearce/egit/core/GitTreeStorage.java  |  484 +++++++++++++++++++++++
 .../egit/core/internal/mapping/GitFileHistory.java |    8 
 .../core/internal/mapping/GitFileRevision.java     |   25 +
 .../core/internal/mapping/GitResourceNode.java     |   97 +++++
 org.spearce.egit.ui/plugin.xml                     |   16 -
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   11 -
 .../GitCompareFileRevisionEditorInput.java         |  305 ++++++++++++++
 .../internal/actions/GitCompareRevisionAction.java |  228 +++++++++++
 10 files changed, 1268 insertions(+), 20 deletions(-)

diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index f4c96cc..8dc62d6 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -10,8 +10,12 @@ Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.team.core,
  org.eclipse.core.resources,
  org.spearce.jgit,
- org.eclipse.core.filesystem
+ org.eclipse.core.filesystem,
+ org.eclipse.compare,
+ org.eclipse.swt
 Export-Package: org.spearce.egit.core.internal.mapping;x-friends:="org.spearce.egit.ui",
+ org.spearce.egit.core,
+ org.spearce.egit.core.internal.mapping,
  org.spearce.egit.core.op,
  org.spearce.egit.core.project
 Eclipse-LazyStart: true
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
new file mode 100644
index 0000000..c947e2b
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitBlobStorage.java
@@ -0,0 +1,108 @@
+/*
+ *  Copyright (C) 2006  Robin Rosenberg
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.egit.core;
+
+import java.io.ByteArrayInputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.InputStream;
+
+import org.eclipse.core.internal.resources.ResourceException;
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IResourceStatus;
+import org.eclipse.core.resources.IStorage;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
+import org.eclipse.team.core.RepositoryProvider;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectLoader;
+import org.spearce.jgit.lib.Tree;
+import org.spearce.jgit.lib.TreeEntry;
+
+public class GitBlobStorage implements IStorage {
+
+	private final IResource resource;
+
+	private TreeEntry entry;
+
+	public GitBlobStorage(ObjectId treeId, IResource resource, String relativeResourceName) {
+		this.resource = resource;
+		if (treeId == null)
+			return;
+
+		GitProvider provider = (GitProvider) RepositoryProvider
+				.getProvider(resource.getProject());
+		RepositoryMapping repositoryMapping = provider.getData()
+				.getRepositoryMapping(resource.getProject());
+		Tree tree;
+		try {
+			tree = repositoryMapping.getRepository().mapTree(treeId);
+			String prefix = repositoryMapping.getSubset();
+			if (prefix != null)
+				prefix = prefix + "/";
+			else
+				prefix = "";
+			String name = prefix + resource.getProjectRelativePath().toString();
+			entry = tree.findMember(name);
+		} catch (IOException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		}
+	}
+
+	public InputStream getContents() throws CoreException {
+		try {
+			if (entry == null) {
+				return ((IFile) resource).getContents();
+			} else {
+				ObjectId id = entry.getId();
+				ObjectLoader reader = entry.getRepository().openBlob(id);
+				byte[] bytes = reader.getBytes();
+				return new ByteArrayInputStream(bytes);
+			}
+		} catch (FileNotFoundException e) {
+			throw new ResourceException(IResourceStatus.FAILED_READ_LOCAL,
+					resource.getFullPath(), "Could not read file", e);
+		} catch (IOException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+			throw new ResourceException(33, resource.getFullPath(), e
+					.getMessage(), e);
+		}
+	}
+
+	public IPath getFullPath() {
+		return resource.getFullPath();
+	}
+
+	public String getName() {
+		return resource.getName();
+	}
+
+	public boolean isReadOnly() {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public Object getAdapter(Class adapter) {
+		System.out.println("GitStorage("+adapter.getName()+")");
+		return null;
+	}
+
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitTreeStorage.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitTreeStorage.java
new file mode 100644
index 0000000..cd27363
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitTreeStorage.java
@@ -0,0 +1,484 @@
+/*
+ *  Copyright (C) 2006  Robin Rosenberg
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.egit.core;
+
+import java.io.IOException;
+import java.net.URI;
+
+import org.eclipse.core.resources.IContainer;
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IFolder;
+import org.eclipse.core.resources.IMarker;
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IProjectDescription;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IResourceProxy;
+import org.eclipse.core.resources.IResourceProxyVisitor;
+import org.eclipse.core.resources.IResourceVisitor;
+import org.eclipse.core.resources.IWorkspace;
+import org.eclipse.core.resources.ResourceAttributes;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.QualifiedName;
+import org.eclipse.core.runtime.jobs.ISchedulingRule;
+import org.eclipse.team.core.RepositoryProvider;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Tree;
+
+public class GitTreeStorage implements IContainer {
+
+	private Tree entry;
+
+	public GitTreeStorage(ObjectId treeId, IResource resource, String relativeResourceName) {
+		if (treeId == null)
+			return;
+
+		GitProvider provider = (GitProvider) RepositoryProvider
+				.getProvider(resource.getProject());
+		RepositoryMapping repositoryMapping = provider.getData()
+				.getRepositoryMapping(resource.getProject());
+		Tree tree;
+		try {
+			tree = repositoryMapping.getRepository().mapTree(treeId);
+			String prefix = repositoryMapping.getSubset();
+			if (prefix != null)
+				prefix = prefix + "/";
+			else
+				prefix = "";
+			String name = prefix + resource.getProjectRelativePath().toString();
+			entry = (Tree)tree.findMember(name);
+		} catch (IOException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		}
+	}
+
+	public boolean exists(IPath path) {
+		try {
+			return entry.findMember(path.toString()) != null;
+		} catch (IOException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		}
+		return false;
+	}
+
+	public IFile[] findDeletedMembersWithHistory(int depth,
+			IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IResource findMember(String name) {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IResource findMember(IPath path) {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IResource findMember(String name, boolean includePhantoms) {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IResource findMember(IPath path, boolean includePhantoms) {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public String getDefaultCharset() throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public String getDefaultCharset(boolean checkImplicit) throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IFile getFile(IPath path) {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IFolder getFolder(IPath path) {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IResource[] members() throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IResource[] members(boolean includePhantoms) throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IResource[] members(int memberFlags) throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public void setDefaultCharset(String charset) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void setDefaultCharset(String charset, IProgressMonitor monitor)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void accept(IResourceVisitor visitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void accept(IResourceProxyVisitor visitor, int memberFlags)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void accept(IResourceVisitor visitor, int depth,
+			boolean includePhantoms) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void accept(IResourceVisitor visitor, int depth, int memberFlags)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void clearHistory(IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void copy(IPath destination, boolean force, IProgressMonitor monitor)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void copy(IPath destination, int updateFlags,
+			IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void copy(IProjectDescription description, boolean force,
+			IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void copy(IProjectDescription description, int updateFlags,
+			IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public IMarker createMarker(String type) throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IResourceProxy createProxy() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public void delete(boolean force, IProgressMonitor monitor)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void delete(int updateFlags, IProgressMonitor monitor)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void deleteMarkers(String type, boolean includeSubtypes, int depth)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public boolean exists() {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public IMarker findMarker(long id) throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IMarker[] findMarkers(String type, boolean includeSubtypes, int depth)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public String getFileExtension() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IPath getFullPath() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public long getLocalTimeStamp() {
+		// TODO Auto-generated method stub
+		return 0;
+	}
+
+	public IPath getLocation() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public URI getLocationURI() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IMarker getMarker(long id) {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public long getModificationStamp() {
+		// TODO Auto-generated method stub
+		return 0;
+	}
+
+	public String getName() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IContainer getParent() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public String getPersistentProperty(QualifiedName key) throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IProject getProject() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IPath getProjectRelativePath() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public IPath getRawLocation() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public URI getRawLocationURI() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public ResourceAttributes getResourceAttributes() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public Object getSessionProperty(QualifiedName key) throws CoreException {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public int getType() {
+		// TODO Auto-generated method stub
+		return 0;
+	}
+
+	public IWorkspace getWorkspace() {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public boolean isAccessible() {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isDerived() {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isLinked() {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isLinked(int options) {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isLocal(int depth) {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isPhantom() {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isReadOnly() {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isSynchronized(int depth) {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isTeamPrivateMember() {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public void move(IPath destination, boolean force, IProgressMonitor monitor)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void move(IPath destination, int updateFlags,
+			IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void move(IProjectDescription description, int updateFlags,
+			IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void move(IProjectDescription description, boolean force,
+			boolean keepHistory, IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void refreshLocal(int depth, IProgressMonitor monitor)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void revertModificationStamp(long value) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void setDerived(boolean isDerived) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void setLocal(boolean flag, int depth, IProgressMonitor monitor)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public long setLocalTimeStamp(long value) throws CoreException {
+		// TODO Auto-generated method stub
+		return 0;
+	}
+
+	public void setPersistentProperty(QualifiedName key, String value)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void setReadOnly(boolean readOnly) {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void setResourceAttributes(ResourceAttributes attributes)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void setSessionProperty(QualifiedName key, Object value)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void setTeamPrivateMember(boolean isTeamPrivate)
+			throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public void touch(IProgressMonitor monitor) throws CoreException {
+		// TODO Auto-generated method stub
+		
+	}
+
+	public Object getAdapter(Class adapter) {
+		// TODO Auto-generated method stub
+		return null;
+	}
+
+	public boolean contains(ISchedulingRule rule) {
+		// TODO Auto-generated method stub
+		return false;
+	}
+
+	public boolean isConflicting(ISchedulingRule rule) {
+		// TODO Auto-generated method stub
+		return false;
+	}
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 78a2e68..51109fb 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -28,6 +28,7 @@ import java.util.List;
 
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.team.core.RepositoryProvider;
 import org.eclipse.team.core.history.IFileHistoryProvider;
 import org.eclipse.team.core.history.IFileRevision;
@@ -42,7 +43,7 @@ import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 
-public class GitFileHistory extends FileHistory {
+public class GitFileHistory extends FileHistory implements IAdaptable {
 
 	private final IResource resource;
 
@@ -341,4 +342,9 @@ public class GitFileHistory extends FileHistory {
 		return (IFileRevision[]) ret.toArray(new IFileRevision[ret.size()]);
 	}
 
+	public Object getAdapter(Class adapter) {
+		System.out.println("GitFileHistory.getAdapter "+adapter.getName());
+		return null;
+	}
+
 }
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
index ad15cc0..7b726f7 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileRevision.java
@@ -33,10 +33,13 @@ import org.eclipse.team.core.history.provider.FileRevision;
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.GitStorage;
 import org.spearce.egit.core.GitTag;
+import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Tree;
+import org.spearce.jgit.lib.TreeEntry;
 
 public class GitFileRevision extends FileRevision {
 
@@ -136,4 +139,26 @@ public class GitFileRevision extends FileRevision {
 	public int getCount() {
 		return count;
 	}
+
+	public TreeEntry getTreeEntry() {
+		GitProvider provider = (GitProvider) RepositoryProvider
+				.getProvider(resource.getProject());
+		RepositoryMapping repositoryMapping = provider.getData()
+				.getRepositoryMapping(resource.getProject());
+		Tree tree;
+		try {
+			tree = repositoryMapping.getRepository().mapTree(getCommit().getTreeId());
+			String prefix = repositoryMapping.getSubset();
+			if (prefix != null) {
+				prefix = prefix + "/";
+				String name = prefix + resource.getProjectRelativePath().toString();
+				return tree.findMember(name);
+			} else
+				return tree;
+		} catch (IOException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		}
+		return null;
+	}
 }
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitResourceNode.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitResourceNode.java
new file mode 100644
index 0000000..168d736
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitResourceNode.java
@@ -0,0 +1,97 @@
+package org.spearce.egit.core.internal.mapping;
+
+import java.io.ByteArrayInputStream;
+import java.io.IOException;
+import java.io.InputStream;
+
+import org.eclipse.compare.BufferedContent;
+import org.eclipse.compare.CompareUI;
+import org.eclipse.compare.ITypedElement;
+import org.eclipse.compare.structuremergeviewer.IStructureComparator;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.team.core.history.IFileRevision;
+import org.spearce.jgit.lib.FileTreeEntry;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectLoader;
+import org.spearce.jgit.lib.Tree;
+import org.spearce.jgit.lib.TreeEntry;
+
+public class GitResourceNode extends BufferedContent implements IStructureComparator, ITypedElement {
+	TreeEntry entry;
+	GitResourceNode[] children;
+
+	public GitResourceNode(TreeEntry e) {
+		entry = e;
+	}
+
+	public GitResourceNode(IFileRevision file) {
+		this(((GitFileRevision)file).getTreeEntry());
+	}
+
+	public Object[] getChildren() {
+		if (children != null)
+			return children;
+		if (entry instanceof Tree) {
+			try {
+				Tree t = (Tree)entry;
+				children = new GitResourceNode[t.memberCount()];
+				for (int i=0; i<children.length; ++i) {
+					children[i] = new GitResourceNode(t.members()[i]);
+				}
+			} catch (IOException e) {
+				// TODO: eclipse error handling
+				e.printStackTrace();
+				children = new GitResourceNode[0];
+			}
+		}
+		return children;
+	}
+	
+	public boolean equals(Object obj) {
+		return entry.getId().equals(((GitResourceNode)obj).entry.getId());
+	}
+
+	protected InputStream createStream() throws CoreException {
+		if (entry instanceof FileTreeEntry) {
+			try {
+				ObjectId id = entry.getId();
+				ObjectLoader reader = entry.getRepository().openBlob(id);
+				byte[] bytes = reader.getBytes();
+				return new ByteArrayInputStream(bytes);
+			} catch (IOException e) {
+				// TODO: eclipse error handling
+				e.printStackTrace();
+				return null;
+			}
+		}
+		return null;
+	}
+	
+	public String getName() {
+		return entry.getFullName();
+	}
+
+	public Image getImage() {
+		return CompareUI.getImage(getType());
+	}
+	
+	public String getType() {
+		if (entry instanceof Tree)
+			return ITypedElement.FOLDER_TYPE;
+		else {
+			String name = entry.getName();
+			if (name != null) {
+				int index = name.lastIndexOf('.');
+				if (index == -1)
+					return ""; //$NON-NLS-1$
+				if (index == (name.length() - 1))
+					return ""; //$NON-NLS-1$
+				return name.substring(index + 1);
+			}
+			return "";
+		}
+	}
+
+}
+
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index d81a0b6..3febce8 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -56,12 +56,6 @@
                label="%ShowResourceInHistoryAction_label"
                menubarPath="team.main/group1"
                tooltip="%ShowResourceInHistoryAction_tooltip"/>
-		<action
-		       class="org.spearce.egit.ui.internal.actions.GitCompareRevisionAction"
-        	   id="org.spearce.egit.ui.internal.actions.GitCompareAction"
-               menubarPath="team.main/group1"
-        	   label="Structured Git Compare">
-		</action>
  	  </objectContribution>
       <objectContribution
             objectClass="org.eclipse.core.resources.IFile"
@@ -70,16 +64,6 @@
          <filter name="projectPersistentProperty"
                value="org.eclipse.team.core.repository=org.spearce.egit.core.GitProvider">
          </filter>
-         <action
-               class="org.spearce.egit.ui.internal.actions.CompareWithRevisionAction"
-               definitionId="org.spearce.egit.ui.compareWithRevision"
-               helpContextId="org.spearce.egit.ui.compare_with_revision_action_context"
-               id="org.spearce.egit.ui.compareWithRevision"
-               label="%CompareWithRevisionAction_label"
-               menubarPath="compareWithMenu/compareWithGroup"
-               overrideActionId="org.eclipse.team.ui.compareLocalHistory"
-               tooltip="%CompareWithRevisionAction_tooltip">
-         </action>
       </objectContribution>
    </extension>
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 54635f5..3057344 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -63,6 +63,7 @@ import org.eclipse.team.ui.history.HistoryPage;
 import org.eclipse.team.ui.history.IHistoryCompareAdapter;
 import org.eclipse.team.ui.history.IHistoryPageSite;
 import org.spearce.egit.core.internal.mapping.GitFileRevision;
+import org.spearce.egit.ui.internal.actions.GitCompareRevisionAction;
 
 public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		IHistoryCompareAdapter {
@@ -104,6 +105,8 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 		final CompareRevisionAction compareAction = new CompareRevisionAction(
 				"Compare");
+		final GitCompareRevisionAction compareActionNG = new GitCompareRevisionAction(
+				"Compare NG");
 		tree.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
 				// update the current
@@ -116,16 +119,20 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				compareAction.setCurrentFileRevision(fileRevisions[0]);
 				compareAction.selectionChanged(new StructuredSelection(
 						selection2));
-				
-				compareAction.setEnabled(selection!=null && selection[0]!=null  && ((GitFileRevision)fileRevisions[0]).getResource().getType() == IResource.FILE);
+
+				compareActionNG.setCurrentFileRevision(fileRevisions[0]);
+				compareActionNG.selectionChanged(new StructuredSelection(
+						selection2));
 			}
 		});
 		compareAction.setPage(this);
+		compareActionNG.setPage(this);
 		MenuManager menuMgr = new MenuManager();
 		Menu menu = menuMgr.createContextMenu(tree);
 		menuMgr.addMenuListener(new IMenuListener() {
 			public void menuAboutToShow(IMenuManager menuMgr) {
 				menuMgr.add(compareAction);
+				menuMgr.add(compareActionNG);
 			}
 		});
 		menuMgr.setRemoveAllWhenShown(true);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
new file mode 100644
index 0000000..9c8bd4f
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/GitCompareFileRevisionEditorInput.java
@@ -0,0 +1,305 @@
+/*******************************************************************************
+ * Copyright (c) 2006 IBM Corporation and others.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ * 
+ * Contributors:
+ *     IBM Corporation - initial API and implementation
+ *     Robin Rosenberg - Git interface
+ *******************************************************************************/
+package org.spearce.egit.ui.internal;
+
+import java.lang.reflect.InvocationTargetException;
+
+import org.eclipse.compare.CompareConfiguration;
+import org.eclipse.compare.CompareEditorInput;
+import org.eclipse.compare.IEditableContent;
+import org.eclipse.compare.IResourceProvider;
+import org.eclipse.compare.ITypedElement;
+import org.eclipse.compare.structuremergeviewer.DiffNode;
+import org.eclipse.compare.structuremergeviewer.Differencer;
+import org.eclipse.compare.structuremergeviewer.ICompareInput;
+import org.eclipse.compare.structuremergeviewer.IStructureComparator;
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IFileState;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IStorage;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.team.internal.core.history.LocalFileRevision;
+import org.eclipse.team.internal.ui.TeamUIMessages;
+import org.eclipse.team.internal.ui.TeamUIPlugin;
+import org.eclipse.team.internal.ui.Utils;
+import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
+import org.eclipse.team.internal.ui.synchronize.LocalResourceTypedElement;
+import org.eclipse.ui.IWorkbenchPage;
+
+public class GitCompareFileRevisionEditorInput extends CompareEditorInput {
+	
+	private ITypedElement left;
+	private ITypedElement right;
+	
+	/**
+	 * Creates a new CompareFileRevisionEditorInput.
+	 * @param left 
+	 * @param right 
+	 * @param page 
+	 */
+	public GitCompareFileRevisionEditorInput(ITypedElement left, ITypedElement right, IWorkbenchPage page) {
+		super(new CompareConfiguration());
+		this.left = left;
+		this.right = right;
+	}
+
+	protected FileRevisionTypedElement getRightRevision() {
+		if (right instanceof FileRevisionTypedElement) {
+			return (FileRevisionTypedElement) right;
+		}
+		return null;
+	}
+
+	protected FileRevisionTypedElement getLeftRevision() {
+		if (left instanceof FileRevisionTypedElement) {
+			return (FileRevisionTypedElement) left;
+		}
+		return null;
+	}
+
+	private static void ensureContentsCached(FileRevisionTypedElement left, FileRevisionTypedElement right,
+			IProgressMonitor monitor) {
+		if (left != null) {
+			try {
+				left.cacheContents(monitor);
+			} catch (CoreException e) {
+				TeamUIPlugin.log(e);
+			}
+		}
+		if (right != null) {
+			try {
+				right.cacheContents(monitor);
+			} catch (CoreException e) {
+				TeamUIPlugin.log(e);
+			}
+		}
+	}
+	
+	private boolean isLeftEditable(ICompareInput input) {
+		Object left = input.getLeft();
+		if (left instanceof IEditableContent) {
+			return ((IEditableContent) left).isEditable();
+		}
+		return false;
+	}
+
+	private IResource getResource(ICompareInput input) {
+		if (getLocalElement() != null) {
+			return ((IResourceProvider) getLocalElement()).getResource();
+		}
+		return null;
+	}
+
+	private ICompareInput createCompareInput() {
+		return compare(left, right);
+	}
+	
+	private DiffNode compare(ITypedElement left, ITypedElement right) {
+		if (left.getType().equals(ITypedElement.FOLDER_TYPE)) {
+			//			return new MyDiffContainer(null, left,right);
+			DiffNode diffNode = new DiffNode(null,Differencer.CHANGE,null,left,right);
+			ITypedElement[] lc = (ITypedElement[])((IStructureComparator)left).getChildren();
+			ITypedElement[] rc = (ITypedElement[])((IStructureComparator)right).getChildren();
+			int li=0;
+			int ri=0;
+			while (li<lc.length && ri<rc.length) {
+				ITypedElement ln = lc[li];
+				ITypedElement rn = rc[ri];
+				// TODO: Git ordering!
+				if (ln.getName().compareTo(rn.getName()) < 0) {
+					diffNode.add(new DiffNode(Differencer.ADDITION,null, ln, null));
+					++li;
+				}
+				if (ln.getName().compareTo(rn.getName()) > 0) {
+					diffNode.add(new DiffNode(Differencer.DELETION,null, null, rn));
+					++ri;
+				}
+				if (ln.getName().compareTo(rn.getName()) == 0) {
+					if (!ln.equals(rn))
+						diffNode.add(compare(ln,rn));
+					++li;
+					++ri;
+				}
+			}
+			while (li<lc.length) {
+				ITypedElement ln = lc[li];
+				diffNode.add(new DiffNode(Differencer.ADDITION,null, ln, null));
+				++li;
+			}
+			while (ri<rc.length) {
+				ITypedElement rn = rc[ri];
+				diffNode.add(new DiffNode(Differencer.ADDITION,null, null, rn));
+				++ri;
+			}
+			return diffNode;
+		} else {
+			return new DiffNode(left, right);
+		}
+	}
+
+	private void initLabels(ICompareInput input) {
+		CompareConfiguration cc = getCompareConfiguration();
+		if (getLeftRevision() != null) {
+			String leftLabel = getFileRevisionLabel(getLeftRevision());
+			cc.setLeftLabel(leftLabel);
+		} else if (getResource(input) != null) {
+			String label = NLS.bind(TeamUIMessages.CompareFileRevisionEditorInput_workspace, new Object[]{ input.getLeft().getName() });
+			cc.setLeftLabel(label);
+		}
+		if (getRightRevision() != null) {
+			String rightLabel = getFileRevisionLabel(getRightRevision());
+			cc.setRightLabel(rightLabel);
+		}
+	}
+
+	private String getFileRevisionLabel(FileRevisionTypedElement element) {
+		Object fileObject = element.getFileRevision();
+		if (fileObject instanceof LocalFileRevision){
+			return NLS.bind(TeamUIMessages.CompareFileRevisionEditorInput_localRevision, new Object[]{element.getName(), element.getTimestamp()});
+		} else {
+			return NLS.bind(TeamUIMessages.CompareFileRevisionEditorInput_repository, new Object[]{ element.getName(), element.getContentIdentifier()});
+		}
+	}
+
+	/* (non-Javadoc)
+	 * @see org.eclipse.compare.CompareEditorInput#getToolTipText()
+	 */
+	public String getToolTipText() {
+		Object[] titleObject = new Object[3];
+		titleObject[0] = getLongName(left);
+		titleObject[1] = getContentIdentifier(getLeftRevision());
+		titleObject[2] = getContentIdentifier(getRightRevision());
+		return NLS.bind(TeamUIMessages.CompareFileRevisionEditorInput_compareResourceAndVersions, titleObject);	 
+	}
+	
+	/* (non-Javadoc)
+	 * @see org.eclipse.compare.CompareEditorInput#getTitle()
+	 */
+	public String getTitle() {
+		Object[] titleObject = new Object[3];
+		titleObject[0] = getShortName(left);
+		titleObject[1] = getContentIdentifier(getLeftRevision());
+		titleObject[2] = getContentIdentifier(getRightRevision());
+		return NLS.bind(TeamUIMessages.CompareFileRevisionEditorInput_compareResourceAndVersions, titleObject);	 
+	}
+	
+	/* (non-Javadoc)
+	 * @see org.eclipse.compare.CompareEditorInput#getAdapter(java.lang.Class)
+	 */
+	public Object getAdapter(Class adapter) {
+		if (adapter == IFile.class || adapter == IResource.class) {
+			if (getLocalElement() != null) {
+				return getLocalElement().getResource();
+			}
+			return null;
+		}
+		return super.getAdapter(adapter);
+	}
+	
+	private String getShortName(ITypedElement element) {
+		if (element instanceof FileRevisionTypedElement){
+			FileRevisionTypedElement fileRevisionElement = (FileRevisionTypedElement) element;
+			return fileRevisionElement.getName();
+		}
+		else if (element instanceof LocalResourceTypedElement){
+			LocalResourceTypedElement typedContent = (LocalResourceTypedElement) element;
+			return typedContent.getResource().getName();
+		}
+		return element.getName();
+	}
+	
+	private String getLongName(ITypedElement element) {
+		if (element instanceof FileRevisionTypedElement){
+			FileRevisionTypedElement fileRevisionElement = (FileRevisionTypedElement) element;
+			return fileRevisionElement.getPath();
+		}
+		else if (element instanceof LocalResourceTypedElement){
+			LocalResourceTypedElement typedContent = (LocalResourceTypedElement) element;
+			return typedContent.getResource().getFullPath().toString();
+		}
+		return element.getName();
+	}
+	
+	private String getContentIdentifier(ITypedElement element){
+		if (element instanceof FileRevisionTypedElement){
+			FileRevisionTypedElement fileRevisionElement = (FileRevisionTypedElement) element;
+			Object fileObject = fileRevisionElement.getFileRevision();
+			if (fileObject instanceof LocalFileRevision){
+				try {
+					IStorage storage = ((LocalFileRevision) fileObject).getStorage(new NullProgressMonitor());
+					if (Utils.getAdapter(storage, IFileState.class) != null){
+						//local revision
+						return TeamUIMessages.CompareFileRevisionEditorInput_0;
+					} else if (Utils.getAdapter(storage, IFile.class) != null) {
+						//current revision
+						return TeamUIMessages.CompareFileRevisionEditorInput_1;
+					}
+				} catch (CoreException e) {
+				}
+			} else {
+				return fileRevisionElement.getContentIdentifier();
+			}
+		}
+		return TeamUIMessages.CompareFileRevisionEditorInput_2;
+	}
+
+//	/* (non-Javadoc)
+//	 * @see org.eclipse.team.ui.synchronize.LocalResourceCompareEditorInput#fireInputChange()
+//	 */
+//	protected void fireInputChange() {
+//		((DiffNode)getCompareResult()).fireChange();
+//	}
+//
+//	/* (non-Javadoc)
+//	 * @see org.eclipse.team.ui.synchronize.SaveableCompareEditorInput#contentsCreated()
+//	 */
+//	protected void contentsCreated() {
+//		super.contentsCreated();
+//		notifier.initialize();
+//	}
+//	
+//	/* (non-Javadoc)
+//	 * @see org.eclipse.team.ui.synchronize.SaveableCompareEditorInput#handleDispose()
+//	 */
+//	protected void handleDispose() {
+//		super.handleDispose();
+//		notifier.dispose();
+//		if (getLocalElement() != null) {
+//			getLocalElement().discardBuffer();
+//		}
+//	}
+//
+	public LocalResourceTypedElement getLocalElement() {
+		if (left instanceof LocalResourceTypedElement) {
+			return (LocalResourceTypedElement) left;
+		}
+		return null;
+	}
+
+	public ITypedElement getLeft() {
+		return left;
+	}
+
+	protected Object prepareInput(IProgressMonitor monitor) throws InvocationTargetException, InterruptedException {
+		ICompareInput input = createCompareInput();
+		getCompareConfiguration().setLeftEditable(isLeftEditable(input));
+		getCompareConfiguration().setRightEditable(false);
+		ensureContentsCached(getLeftRevision(), getRightRevision(), monitor);
+		initLabels(input);
+		setTitle(NLS.bind(TeamUIMessages.SyncInfoCompareInput_title, new String[] { input.getName() }));
+		return input;
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
new file mode 100644
index 0000000..be840f9
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/GitCompareRevisionAction.java
@@ -0,0 +1,228 @@
+/*******************************************************************************
+ * Copyright (c) 2006 IBM Corporation and others.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ * 
+ * Contributors:
+ *     IBM Corporation - initial API and implementation
+ *     Robin Rosenberg - Git interface
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import org.eclipse.compare.CompareEditorInput;
+import org.eclipse.compare.CompareUI;
+import org.eclipse.compare.ITypedElement;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.jface.dialogs.MessageDialog;
+import org.eclipse.jface.viewers.IStructuredSelection;
+import org.eclipse.osgi.util.NLS;
+import org.eclipse.team.core.history.IFileRevision;
+import org.eclipse.team.core.history.provider.FileRevision;
+import org.eclipse.team.internal.core.history.LocalFileRevision;
+import org.eclipse.team.internal.ui.TeamUIMessages;
+import org.eclipse.team.internal.ui.history.AbstractHistoryCategory;
+import org.eclipse.team.internal.ui.synchronize.LocalResourceTypedElement;
+import org.eclipse.team.ui.history.HistoryPage;
+import org.eclipse.ui.IEditorInput;
+import org.eclipse.ui.IEditorPart;
+import org.eclipse.ui.IEditorReference;
+import org.eclipse.ui.IReusableEditor;
+import org.eclipse.ui.IWorkbenchPage;
+import org.eclipse.ui.actions.BaseSelectionListenerAction;
+import org.spearce.egit.core.GitWorkspaceFileRevision;
+import org.spearce.egit.core.internal.mapping.GitResourceNode;
+import org.spearce.egit.ui.internal.GitCompareFileRevisionEditorInput;
+
+/**
+ * Action to invoke a Git based compare on selected revivsions in the history window.
+ * 
+ * This class i almost a verbatim copy of @{link org.eclipse.team.internal.ui.actions.CompareRevisionAction}
+ * since it could not be subclassed to invoke the EGit methods.
+ */
+public class GitCompareRevisionAction extends BaseSelectionListenerAction {
+
+	HistoryPage page;
+	IStructuredSelection selection;
+	IFileRevision currentFileRevision;
+
+	public GitCompareRevisionAction(String text) {
+		super(text);
+	}
+
+	public GitCompareRevisionAction() {
+		this(TeamUIMessages.LocalHistoryPage_CompareAction);
+	}
+
+	public void run() {
+		IStructuredSelection structSel = selection;
+		Object[] objArray = structSel.toArray();
+
+		IFileRevision file1 = null;
+		IFileRevision file2 = null;
+
+		switch (structSel.size()){
+			case 1:
+				file1 = getCurrentFileRevision();
+				Object tempRevision = objArray[0];
+				if (tempRevision instanceof IFileRevision)
+					file2 = (IFileRevision) tempRevision;
+				else 
+					return;
+			break;
+
+			case 2:
+				Object tempRevision2 = objArray[0];
+				Object tempRevision3 = objArray[1];
+				
+				if (tempRevision2 instanceof IFileRevision &&
+					tempRevision3 instanceof IFileRevision){
+					file1 = (IFileRevision) objArray[0];
+					file2 = (IFileRevision) objArray[1];
+				} else 
+					return;
+			break;
+		}
+
+		if (file1 == null || file2 == null ||
+		   !file1.exists() || !file2.exists()){
+			MessageDialog.openError(page.getSite().getShell(),
+					TeamUIMessages.OpenRevisionAction_DeletedRevTitle,
+					TeamUIMessages.CompareRevisionAction_DeleteCompareMessage);
+			return;
+		}
+		
+		IResource resource = getResource(file2);
+		if (resource != null) {
+			IFileRevision temp = file1;
+			file1 = file2;
+			file2 = temp;
+		}
+		ITypedElement left;
+		resource = getResource(file1);
+		if (resource != null) {
+			left = new LocalResourceTypedElement(resource);
+		} else {
+			left = new GitResourceNode(file1);
+		}
+		ITypedElement right = new GitResourceNode(file2);
+		
+	    openInCompare(left, right);
+	}
+
+	private void openInCompare(ITypedElement left, ITypedElement right) {
+		CompareEditorInput input = createCompareEditorInput(left, right, page.getSite().getPage());
+		IWorkbenchPage workBenchPage = page.getSite().getPage();
+		IEditorPart editor = findReusableCompareEditor(workBenchPage);
+		if (editor != null) {
+			IEditorInput otherInput = editor.getEditorInput();
+			if (otherInput.equals(input)) {
+				// simply provide focus to editor
+				workBenchPage.activate(editor);
+			} else {
+				// if editor is currently not open on that input either re-use
+				// existing
+				CompareUI.reuseCompareEditor(input, (IReusableEditor) editor);
+				workBenchPage.activate(editor);
+			}
+		} else {
+			CompareUI.openCompareEditor(input);
+		}
+	}
+
+	protected GitCompareFileRevisionEditorInput createCompareEditorInput(
+			ITypedElement left, ITypedElement right, IWorkbenchPage page) {
+		return new GitCompareFileRevisionEditorInput(left, right, page);
+	}
+
+	private IResource getResource(IFileRevision revision) {
+		if (revision instanceof GitWorkspaceFileRevision) {
+			GitWorkspaceFileRevision local = (GitWorkspaceFileRevision) revision;
+			return local.getResource();
+		}
+		return null;
+	}
+
+	private IFileRevision getCurrentFileRevision() {
+		return currentFileRevision;
+	}
+
+	public void setCurrentFileRevision(IFileRevision fileRevision){
+		this.currentFileRevision = fileRevision;
+	}
+
+	/**
+	 * Returns an editor that can be re-used. An open compare editor that
+	 * has un-saved changes cannot be re-used.
+	 * @param page 
+	 * @return an EditorPart or <code>null</code> if none can be found
+	 */
+	public static IEditorPart findReusableCompareEditor(IWorkbenchPage page) {
+		IEditorReference[] editorRefs = page.getEditorReferences();	
+		for (int i = 0; i < editorRefs.length; i++) {
+			IEditorPart part = editorRefs[i].getEditor(false);
+			if(part != null 
+					&& (part.getEditorInput() instanceof GitCompareFileRevisionEditorInput) 
+					&& part instanceof IReusableEditor) {
+				if(! part.isDirty()) {	
+					return part;	
+				}
+			}
+		}
+		return null;
+	}
+	
+	protected boolean updateSelection(IStructuredSelection selection) {
+		this.selection = selection;
+		if (selection.size() == 1){
+			Object el = selection.getFirstElement();
+			if (el instanceof LocalFileRevision)
+				this.setText(TeamUIMessages.CompareRevisionAction_Local);
+			else if (el instanceof FileRevision){
+				FileRevision tempFileRevision = (FileRevision) el;
+				this.setText(NLS.bind(TeamUIMessages.CompareRevisionAction_Revision, new String[]{tempFileRevision.getContentIdentifier()}));
+			} 
+			else
+				this.setText(TeamUIMessages.CompareRevisionAction_CompareWithCurrent);
+			return shouldShow();
+		}
+		else if (selection.size() == 2){
+			this.setText(TeamUIMessages.CompareRevisionAction_CompareWithOther+" NG");	
+			return shouldShow();
+		}
+
+		return false;
+	}
+
+	public void setPage(HistoryPage page) {
+		this.page = page;
+	}
+
+	private boolean shouldShow() {
+		IStructuredSelection structSel = selection;
+		Object[] objArray = structSel.toArray();
+
+		if (objArray.length == 0)
+			return false;
+
+		// Comparing the workspace revision with itself is just stupid
+		if (objArray.length == 1 && objArray[0] instanceof GitWorkspaceFileRevision)
+			return false;
+
+		for (int i = 0; i < objArray.length; i++) {
+
+			// Don't bother showing if this a category
+			if (objArray[i] instanceof AbstractHistoryCategory)
+				return false;
+
+			IFileRevision revision = (IFileRevision) objArray[i];
+			//check to see if any of the selected revisions are deleted revisions
+			if (revision != null && !revision.exists())
+				return false;
+		}
+
+		return true;
+	}
+
+}
