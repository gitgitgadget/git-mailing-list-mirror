From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 4/5] Change GitProjectData.getRepositoryMapping to work on linked resources
Date: Tue,  5 Aug 2008 20:09:39 -0700
Message-ID: <1217992180-5697-5-git-send-email-spearce@spearce.org>
References: <1217992180-5697-1-git-send-email-spearce@spearce.org>
 <1217992180-5697-2-git-send-email-spearce@spearce.org>
 <1217992180-5697-3-git-send-email-spearce@spearce.org>
 <1217992180-5697-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 05:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQZQK-0005ZC-Lq
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 05:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762176AbYHFDJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 23:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761577AbYHFDJt
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 23:09:49 -0400
Received: from george.spearce.org ([209.20.77.23]:47471 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758505AbYHFDJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 23:09:44 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3571238438; Wed,  6 Aug 2008 03:09:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1274038420;
	Wed,  6 Aug 2008 03:09:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217992180-5697-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91480>

When we are looking up the mapping for a file contained within a linked
directory the linked directory may be mapped to a Git repository that is
not the same as the project itself, or the project doesn't even have a
Git repository.

This may also be necessary for submodules.  For example a single project
in Eclipse may actually contain several Git submodules below it and each
must have its own RepositoryMapping.

We now store the RepositoryMapping for a given IContainer directly on
that container using a session property.  This way Eclipse manages the
hash lookups for us, and we can efficiently walk up the tree to locate
the nearest mapping for any resource.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/core/project/GitProjectData.java  |   47 +++++++++++++-------
 1 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 3d5424c..9998880 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -32,6 +32,7 @@ import org.eclipse.core.resources.IResourceChangeListener;
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.Preferences;
+import org.eclipse.core.runtime.QualifiedName;
 import org.eclipse.osgi.util.NLS;
 import org.eclipse.team.core.RepositoryProvider;
 import org.spearce.egit.core.Activator;
@@ -71,6 +72,9 @@ public class GitProjectData {
 		}
 	}
 
+	private static QualifiedName MAPPING_KEY = new QualifiedName(
+			GitProjectData.class.getName(), "RepositoryMapping");
+
 	/**
 	 * Start listening for resource changes.
 	 *
@@ -226,8 +230,6 @@ public class GitProjectData {
 
 	private final Collection mappings;
 
-	private final Map c2mapping;
-
 	private final Set protectedResources;
 
 	/**
@@ -239,7 +241,6 @@ public class GitProjectData {
 	public GitProjectData(final IProject p) {
 		project = p;
 		mappings = new ArrayList();
-		c2mapping = new HashMap();
 		protectedResources = new HashSet();
 	}
 
@@ -267,15 +268,16 @@ public class GitProjectData {
 	 * @throws CoreException
 	 */
 	public void markTeamPrivateResources() throws CoreException {
-		final Iterator i = c2mapping.entrySet().iterator();
-		while (i.hasNext()) {
-			final Map.Entry e = (Map.Entry) i.next();
-			final IContainer c = (IContainer) e.getKey();
+		for (final Object rmObj : mappings) {
+			final RepositoryMapping rm = (RepositoryMapping)rmObj;
+			final IContainer c = rm.getContainer();
+			if (c == null)
+				continue; // Not fully mapped yet?
+
 			final IResource dotGit = c.findMember(".git");
 			if (dotGit != null) {
 				try {
-					final Repository r = ((RepositoryMapping) e.getValue())
-							.getRepository();
+					final Repository r = rm.getRepository();
 					final File dotGitDir = dotGit.getLocation().toFile()
 							.getCanonicalFile();
 					if (dotGitDir.equals(r.getDirectory())) {
@@ -298,14 +300,23 @@ public class GitProjectData {
 	}
 
 	/**
-	 * TODO: check usage, we should probably declare the parameter
-	 * as IProject.
-	 *
-	 * @param r Eclipse project
+	 * @param r any workbench resource contained within this project.
 	 * @return the mapping for the specified project
 	 */
-	public RepositoryMapping getRepositoryMapping(final IResource r) {
-		return (RepositoryMapping) c2mapping.get(r);
+	public RepositoryMapping getRepositoryMapping(IResource r) {
+		try {
+			while (r != null) {
+				final RepositoryMapping m;
+
+				m = (RepositoryMapping) r.getSessionProperty(MAPPING_KEY);
+				if (m != null)
+					return m;
+ 				r = r.getParent();
+			}
+		} catch (CoreException err) {
+			Activator.logError("Falied finding RepositoryMapping", err);
+		}
+		return null;
 	}
 
 	private void delete() {
@@ -445,7 +456,11 @@ public class GitProjectData {
 		m.fireRepositoryChanged();
 
 		trace("map " + c + " -> " + m.getRepository());
-		c2mapping.put(c, m);
+		try {
+			c.setSessionProperty(MAPPING_KEY, m);
+		} catch (CoreException err) {
+			Activator.logError("Failed to cache RepositoryMapping", err);
+		}
 
 		dotGit = c.findMember(".git");
 		if (dotGit != null && dotGit.getLocation().toFile().equals(git)) {
-- 
1.6.0.rc1.250.g9b5e2
