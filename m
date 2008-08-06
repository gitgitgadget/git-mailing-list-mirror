From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 3/5] Fix RepositoryMapping.getRepoRelativePath to honor linked resources
Date: Tue,  5 Aug 2008 20:09:38 -0700
Message-ID: <1217992180-5697-4-git-send-email-spearce@spearce.org>
References: <1217992180-5697-1-git-send-email-spearce@spearce.org>
 <1217992180-5697-2-git-send-email-spearce@spearce.org>
 <1217992180-5697-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 05:10:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQZQJ-0005ZC-Th
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 05:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762050AbYHFDJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 23:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758575AbYHFDJs
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 23:09:48 -0400
Received: from george.spearce.org ([209.20.77.23]:47475 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYHFDJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 23:09:44 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6B07638447; Wed,  6 Aug 2008 03:09:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7081C38419;
	Wed,  6 Aug 2008 03:09:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217992180-5697-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91479>

If a project resource is linked to a repository working directory we
should be locating the path of the resource within the repository by
the path it appears in the filesystem, not the path it appears at in
the Eclipse project structure.  By using the filesystem location we
can ensure the paths match what C Git would see when accessing the
same resource.

By making this change we can now safely remove the subset concept
from RepositoryMapping as it was a crude form of trying to come up
with the same result when projects appeared within a repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../egit/core/op/ConnectProviderOperation.java     |   14 +----
 .../egit/core/project/RepositoryFinder.java        |   11 +--
 .../egit/core/project/RepositoryMapping.java       |   65 ++++++++-----------
 3 files changed, 32 insertions(+), 58 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
index 3ed3569..bf814f4 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/ConnectProviderOperation.java
@@ -15,10 +15,8 @@ import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.core.runtime.CoreException;
-import org.eclipse.core.runtime.IPath;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
-import org.eclipse.core.runtime.Path;
 import org.eclipse.core.runtime.SubProgressMonitor;
 import org.eclipse.team.core.RepositoryProvider;
 import org.spearce.egit.core.Activator;
@@ -70,17 +68,7 @@ public class ConnectProviderOperation implements IWorkspaceRunnable {
 
 					db = new Repository(newGitDir);
 					db.create();
-					IPath gitDirParent = Path.fromOSString(
-							db.getDirectory().getAbsolutePath())
-							.removeLastSegments(1);
-					IPath cPath = project.getLocation();
-					String subset = null;
-					if (gitDirParent.isPrefixOf(cPath)) {
-						int n = cPath.matchingFirstSegments(gitDirParent);
-						subset = cPath.removeFirstSegments(n).toPortableString();
-					}
-					repos.add(new RepositoryMapping(project, db.getDirectory(),
-							subset));
+					repos.add(new RepositoryMapping(project, db.getDirectory()));
 					db.close();
 
 					// If we don't refresh the project directory right
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryFinder.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryFinder.java
index 68cf79c..116a7bf 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryFinder.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryFinder.java
@@ -92,17 +92,15 @@ public class RepositoryFinder {
 				final IResource[] children;
 
 				if (ownCfg.isFile()) {
-					register(c, ownCfg.getParentFile(), null);
+					register(c, ownCfg.getParentFile());
 				} else if (c.isLinked() || c instanceof IProject) {
-					String s = fsLoc.getName();
 					File p = fsLoc.getParentFile();
 					while (p != null) {
 						final File pCfg = configFor(p);
 						if (pCfg.isFile()) {
-							register(c, pCfg.getParentFile(), s);
+							register(c, pCfg.getParentFile());
 							break;
 						}
-						s = p.getName() + "/" + s;
 						p = p.getParentFile();
 					}
 				}
@@ -132,14 +130,13 @@ public class RepositoryFinder {
 		return new File(new File(fsLoc, ".git"), "config");
 	}
 
-	private void register(final IContainer c, final File gitdir,
-			final String subset) {
+	private void register(final IContainer c, final File gitdir) {
 		File f;
 		try {
 			f = gitdir.getCanonicalFile();
 		} catch (IOException ioe) {
 			f = gitdir.getAbsoluteFile();
 		}
-		results.add(new RepositoryMapping(c, f, subset));
+		results.add(new RepositoryMapping(c, f));
 	}
 }
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index 6a0b56f..17e8142 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -41,10 +41,10 @@ public class RepositoryMapping {
 
 	private final String gitdirPath;
 
-	private final String subset;
-
 	private Repository db;
 
+	private String workdirPrefix;
+
 	private IContainer container;
 
 	/**
@@ -55,12 +55,9 @@ public class RepositoryMapping {
 	 */
 	public RepositoryMapping(final Properties p, final String initialKey) {
 		final int dot = initialKey.lastIndexOf('.');
-		String s;
 
 		containerPath = initialKey.substring(0, dot);
 		gitdirPath = p.getProperty(initialKey);
-		s = p.getProperty(containerPath + ".subset");
-		subset = "".equals(s) ? null : s;
 	}
 
 	/**
@@ -69,10 +66,8 @@ public class RepositoryMapping {
 	 *
 	 * @param mappedContainer
 	 * @param gitDir
-	 * @param subsetRoot
 	 */
-	public RepositoryMapping(final IContainer mappedContainer,
-			final File gitDir, final String subsetRoot) {
+	public RepositoryMapping(final IContainer mappedContainer, final File gitDir) {
 		final IPath cLoc = mappedContainer.getLocation()
 				.removeTrailingSeparator();
 		final IPath gLoc = Path.fromOSString(gitDir.getAbsolutePath())
@@ -98,8 +93,6 @@ public class RepositoryMapping {
 		} else {
 			gitdirPath = gLoc.toPortableString();
 		}
-
-		subset = "".equals(subsetRoot) ? null : subsetRoot;
 	}
 
 	IPath getContainerPath() {
@@ -111,17 +104,6 @@ public class RepositoryMapping {
 	}
 
 	/**
-	 * Eclipse projects typically reside one or more levels
-	 * below the repository. This method return the relative
-	 * path to the project. Null is returned instead of "".
-	 *
-	 * @return relative path from repository to project, or null
-	 */
-	public String getSubset() {
-		return subset;
-	}
-
-	/**
 	 * @return the workdir file, i.e. where the files are checked out
 	 */
 	public File getWorkDir() {
@@ -130,6 +112,7 @@ public class RepositoryMapping {
 
 	synchronized void clear() {
 		db = null;
+		workdirPrefix = null;
 		container = null;
 	}
 
@@ -142,6 +125,15 @@ public class RepositoryMapping {
 
 	synchronized void setRepository(final Repository r) {
 		db = r;
+
+		try {
+			workdirPrefix = getWorkDir().getCanonicalPath();
+		} catch (IOException err) {
+			workdirPrefix = getWorkDir().getAbsolutePath();
+		}
+		workdirPrefix = workdirPrefix.replace('\\', '/');
+		if (!workdirPrefix.endsWith("/"))
+			workdirPrefix += "/";
 	}
 
 	/**
@@ -166,9 +158,6 @@ public class RepositoryMapping {
 
 	synchronized void store(final Properties p) {
 		p.setProperty(containerPath + ".gitdir", gitdirPath);
-		if (subset != null && !"".equals(subset)) {
-			p.setProperty(containerPath + ".subset", subset);
-		}
 	}
 
 	public String toString() {
@@ -209,20 +198,20 @@ public class RepositoryMapping {
 	 * @param rsrc
 	 * @return the path relative to the Git repository, including base name.
 	 */
-	public String getRepoRelativePath(IResource rsrc) {
-		String prefix = getSubset();
-		String projectRelativePath = rsrc.getProjectRelativePath().toString();
-		String repoRelativePath;
-		if (prefix != null) {
-			if (projectRelativePath.length() == 0)
-				repoRelativePath = prefix;
-			else
-				repoRelativePath = prefix + "/" + projectRelativePath;
-		} else
-			repoRelativePath = projectRelativePath;
-
-		assert repoRelativePath != null;
-		return repoRelativePath;
+	public String getRepoRelativePath(final IResource rsrc) {
+		// We should only be called for resources that are actually
+		// in this repository, so we can safely assume that their
+		// path prefix matches workdirPrefix. Testing that here is
+		// rather expensive so we don't bother.
+		//
+		final int pfxLen = workdirPrefix.length();
+		final String p = rsrc.getLocation().toString();
+		final int pLen = p.length();
+		if (pLen > pfxLen)
+			return p.substring(pfxLen);
+		else if (p.length() == pfxLen - 1)
+			return "";
+		return null;
 	}
 
 	/**
-- 
1.6.0.rc1.250.g9b5e2
