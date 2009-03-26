From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH RFC v1 5/5] Use the ignore patterns cache to determine ignores
Date: Thu, 26 Mar 2009 22:34:27 +0100
Message-ID: <55baa61ac6caea86a364ddc0421d9422d96f2825.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
 <213427d4111185ae3a094a3cd578be8e6c3d5ffb.1238102327.git.ferry.huberts@pelagic.nl>
 <77afc036be3e7704333130c1cd2ab28466a91e67.1238102327.git.ferry.huberts@pelagic.nl>
 <e9605b0b1bda26f568009a42b31220d60692fce6.1238102327.git.ferry.huberts@pelagic.nl>
 <6b4495184b92d42059a12af17c54f1951337338a.1238102327.git.ferry.huberts@pelagic.nl>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 22:36:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxFC-0007np-Rl
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970AbZCZVep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZCZVem
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:34:42 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:46239 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756432AbZCZVef (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 17:34:35 -0400
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 6B24358BDD5;
	Thu, 26 Mar 2009 22:34:28 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <6b4495184b92d42059a12af17c54f1951337338a.1238102327.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114827>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 .../src/org/spearce/egit/core/ignores/DType.java   |   44 ++++++
 .../src/org/spearce/egit/core/ignores/Exclude.java |  143 ++++++++++++++++----
 .../spearce/egit/core/ignores/GitIgnoreData.java   |   43 ++++++-
 .../egit/core/ignores/IgnoreProjectCache.java      |   44 ++++++
 .../egit/core/ignores/IgnoreRepositoryCache.java   |   68 ++++++++--
 .../spearce/egit/core/project/GitProjectData.java  |    3 +
 org.spearce.jgit/META-INF/MANIFEST.MF              |    1 +
 7 files changed, 307 insertions(+), 39 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/DType.java

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/DType.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/DType.java
new file mode 100644
index 0000000..5661dca
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/DType.java
@@ -0,0 +1,44 @@
+/*******************************************************************************
+ * Copyright (C) 2009, Ferry Huberts <ferry.huberts@pelagic.nl>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.ignores;
+
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IFolder;
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
+
+/**
+ * This class describes a file type in the same way as git does.
+ * 
+ * The git definition can be found in the source file cache.h. The code can be
+ * found in the source file dir.c:get_dtype
+ */
+enum DType {
+	DT_UNKNOWN, DT_DIR, DT_REG, DT_LINK;
+
+	/*
+	 * Interface Methods
+	 */
+
+	static DType get(final IResource resource) {
+		if (resource == null) {
+			return DT_UNKNOWN;
+		}
+		if (resource instanceof IFile) {
+			return DT_REG;
+		}
+		if ((resource instanceof IFolder) || (resource instanceof IProject)) {
+			return DT_DIR;
+		}
+		if (resource.isLinked()) {
+			return DT_LINK;
+		}
+
+		return DT_UNKNOWN;
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java
index c4c48e9..eaddd17 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java
@@ -9,6 +9,9 @@
 
 import java.util.regex.Pattern;
 
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.fnmatch.FileNameMatcher;
+
 /**
  * This class describes an ignore pattern in the same way as git does, with some
  * extra information to support Eclipse specific functionality.
@@ -105,6 +108,110 @@ Exclude(final String pattern, final String base,
 	}
 
 	/*
+	 * Interface Methods
+	 */
+
+	/**
+	 * Tries to match a given resource to the Exclude
+	 * 
+	 * @param pathName
+	 *            the full path of the resource, relative to the checkout
+	 *            directory
+	 * @param baseName
+	 *            the baseName of the resource
+	 * @param resourceType
+	 *            the type of the resource
+	 * @return true when the resource matches this Exclude, false otherwise
+	 * 
+	 */
+	boolean isMatch(final String pathName, final String baseName,
+			final DType resourceType) {
+		/* this is needed to make the exact same match as git does */
+		String xbase = pathName;
+		final int pos = xbase.lastIndexOf('/');
+		if (pos < 0) {
+			xbase = "";
+		} else {
+			xbase = xbase.substring(0, pos + 1);
+		}
+
+		if (mustBeDir && (resourceType != DType.DT_DIR)) {
+			return false;
+		}
+
+		if (noDir) {
+			/* pattern does not contain directories. dir.c: match basename */
+			if (noWildcard) {
+				/* pattern does not contain directories and has no wildcards */
+				if (baseName.equals(pattern)) {
+					return to_exclude;
+				}
+			} else if (endsWith) {
+				/*
+				 * pattern does not contain directories and resource must end
+				 * with pattern.substring(1)
+				 */
+				if (baseName.endsWith(pattern.substring(1))) {
+					return to_exclude;
+				}
+			} else {
+				/*
+				 * pattern does not contain directories, has wildcards, and does
+				 * not end with pattern.substring(1)
+				 */
+				try {
+					final FileNameMatcher matcher = new FileNameMatcher(
+							pattern, null);
+					matcher.append(baseName);
+					if (matcher.isMatch()) {
+						return to_exclude;
+					}
+				} catch (final InvalidPatternException e) {
+					return false;
+				}
+			}
+		} else {
+			/*
+			 * pattern contains directories. dir.c: match with FNM_PATHNAME:
+			 * exclude (e.g. 'this.pattern') has base (baselen long) implicitly
+			 * in front of it.
+			 */
+			final int baselen = base.length();
+			String matchPattern = this.pattern;
+			if (matchPattern.startsWith("/")) {
+				matchPattern = matchPattern.substring(1);
+			}
+
+			if ((pathName.length() < baselen)
+					|| ((baselen > 0) && (pathName.charAt(baselen - 1) != '/'))
+					|| !pathName.substring(0, baselen).equals(xbase)) {
+				return false;
+			}
+
+			final String remainingResourceName = pathName.substring(baselen);
+			if (noWildcard) {
+				/* pattern contains directories and has no wildcards */
+				if (remainingResourceName.equals(matchPattern)) {
+					return to_exclude;
+				}
+			} else {
+				/* pattern contains directories and has wildcards */
+				try {
+					final FileNameMatcher matcher = new FileNameMatcher(
+							matchPattern, Character.valueOf('/'));
+					matcher.append(remainingResourceName);
+					if (matcher.isMatch()) {
+						return to_exclude;
+					}
+				} catch (final InvalidPatternException e) {
+					return false;
+				}
+			}
+		}
+		return false;
+	}
+
+	/*
 	 * Private Methods
 	 */
 
@@ -119,40 +226,18 @@ private boolean no_wildcard(final String string) {
 	/*
 	 * Getters / Setters
 	 */
-
-	public String getIgnoreFileAbsolutePath() {
-		return ignoreFileAbsolutePath;
-	}
-
-	public int getLineNumber() {
-		return lineNumber;
-	}
-
-	/**
-	 * @return the base
-	 */
-	public String getBase() {
-		return base;
-	}
-
-	/**
-	 * @return the noDir
-	 */
-	public boolean isNoDir() {
-		return noDir;
-	}
-
+	
 	/**
-	 * @return the endsWith
+	 * @return the ignoreFileAbsolutePath
 	 */
-	public boolean isEndsWith() {
-		return endsWith;
+	public String getIgnoreFileAbsolutePath() {
+		return ignoreFileAbsolutePath;
 	}
 
 	/**
-	 * @return the noWildcard
+	 * @return the lineNumber
 	 */
-	public boolean isNoWildcard() {
-		return noWildcard;
+	public int getLineNumber() {
+		return lineNumber;
 	}
 }
\ No newline at end of file
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java
index 401a378..48cf454 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java
@@ -14,6 +14,7 @@
 import org.eclipse.core.resources.IWorkspace;
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.team.core.Team;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.jgit.lib.Repository;
 
@@ -128,7 +129,7 @@ public synchronized static void importWorkspaceIgnores() {
 		 * FIXME: also do the file `git config --global --get
 		 * core.excludesfile`, is this already covered? RepositoryConfig
 		 * globalConfig = new RepositoryConfig(null, new File(FS.userHome(),
-		 * ".gitconfig"));
+		 * ".gitconfig")); RepositoryConfig.openUserConfig
 		 */
 
 		/*
@@ -136,4 +137,44 @@ public synchronized static void importWorkspaceIgnores() {
 		 * repositories.toString());
 		 */
 	}
+
+	/**
+	 * @param resource
+	 *            the resource to check
+	 * @return null when not matched, the matching Exclude otherwise the
+	 *         resource
+	 */
+	synchronized static Exclude isResourceExcluded(final IResource resource) {
+		if (resource == null) {
+			return null;
+		}
+
+		final RepositoryMapping mapping = RepositoryMapping
+				.getMapping(resource);
+		if (mapping == null) {
+			return null;
+		}
+
+		final IgnoreRepositoryCache cache = repositories.get(mapping
+				.getRepository());
+		if (cache == null) {
+			return null;
+		}
+
+		/* FIXME: also check global core.excludesfile, is this already covered? */
+
+		return cache.isIgnored(resource, mapping);
+	}
+
+	/**
+	 * @param resource
+	 * @return true when the resource is ignored
+	 */
+	public synchronized static boolean isIgnored(final IResource resource) {
+		if (isResourceExcluded(resource) != null) {
+			return true;
+		}
+
+		return Team.isIgnoredHint(resource);
+	}
 }
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java
index fe2f529..7f35240 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java
@@ -15,6 +15,7 @@
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IResourceDelta;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
 
 /**
  * This class implements a cache of ignore patterns for an Eclipse project: it
@@ -198,4 +199,47 @@ synchronized void processIgnoreFile(final IFile ignoreFile,
 		// break;
 		// }
 	}
+
+	synchronized Exclude isIgnored(final String pathName,
+			final String baseName, final DType dType,
+			final IPath deepestDirectory) {
+		IPath searchDir = deepestDirectory;
+		String lookupKey = (searchDir.isEmpty() ? searchDir.toString()
+				: searchDir.toString() + "/");
+		final boolean result = false;
+		searcher: while (!result) {
+			/* look for the first ignore file up in the tree */
+			while (!ignoreFilesIndex.containsKey(lookupKey)) {
+				searchDir = searchDir.removeLastSegments(1);
+				if (searchDir.isEmpty()) {
+					break searcher;
+				}
+				lookupKey = (searchDir.isEmpty() ? searchDir.toString()
+						: searchDir.toString() + "/");
+			}
+			final IFile ignoreFile = ignoreFilesIndex.get(lookupKey);
+
+			/* when found then try to match the resource to those patterns */
+			if (ignoreFile != null) {
+				final LinkedList<Exclude> excludeList = ignoreFiles
+						.get(ignoreFile);
+				for (int i = excludeList.size() - 1; i >= 0; i--) {
+					final Exclude x = excludeList.get(i);
+					if (x.isMatch(pathName, baseName, dType)) {
+						return x;
+					}
+				}
+			}
+
+			if (searchDir.isEmpty()) {
+				break searcher;
+			}
+			searchDir = searchDir.removeLastSegments(1);
+			lookupKey = (searchDir.isEmpty() ? searchDir.toString() : searchDir
+					.toString()
+					+ "/");
+		}
+
+		return null;
+	}
 }
\ No newline at end of file
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java
index 4b6bf61..9bfb197 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java
@@ -35,7 +35,7 @@
 	/** the repository */
 	private Repository repository = null;
 
-	/** the checkout directory for the repository */
+	/** the checkout directory for the repository, full path, platform specific */
 	private String checkoutDir = null;
 
 	/** the cache that holds ignore data on a per-project basis */
@@ -59,6 +59,9 @@
 	/** the core.excludesfile setting */
 	private String coreExcludesSetting = null;
 
+	/** the exclude for the repository itself */
+	private Exclude repositoryExclude = null;
+
 	/**
 	 * Retrieve a project mapping from the projects cache. When the project is
 	 * not yet in the cache then create a new mapping for it and store it in the
@@ -95,6 +98,8 @@ IgnoreRepositoryCache(final Repository repository) {
 		}
 		this.repository = repository;
 		this.checkoutDir = repository.getWorkDir().getAbsolutePath();
+		this.repositoryExclude = new Exclude("/.git/", "", checkoutDir
+				+ "/.git/config", 1);
 	}
 
 	/*
@@ -295,14 +300,59 @@ private boolean readRepositoryCoreExcludesSetting() {
 		return changes;
 	}
 	
-	/*
-	 * Getters / Setters
-	 */
+	synchronized Exclude isIgnored(final IResource resource,
+			final RepositoryMapping mapping) {
+		final String pathName = mapping.getRepoRelativePath(resource);
+		IPath deepestDirectory = new Path(pathName).removeLastSegments(1);
+		final String baseName = resource.getName();
+		final DType dType = DType.get(resource);
+
+		/* the repository directory is always ignored */
+		if (this.repositoryExclude.isMatch(pathName, resource.getName(), DType
+				.get(resource))) {
+			return this.repositoryExclude;
+		}
 
-	/**
-	 * @return the checkoutDir
-	 */
-	public String getCheckoutDir() {
-		return checkoutDir;
+		Exclude exclude = null;
+
+		/* check project excludes */
+		final IProject project = resource.getProject();
+		if (project != null) {
+			final IgnoreProjectCache cache = projects.get(project);
+			if (cache != null) {
+				exclude = cache.isIgnored(pathName, baseName, dType,
+						deepestDirectory);
+				if (exclude != null) {
+					return exclude;
+				}
+			}
+			deepestDirectory = new Path(mapping.getRepoRelativePath(project))
+					.removeLastSegments(1);
+		} else {
+			deepestDirectory = new Path("");
+		}
+		
+		/* check excludes outside projects */
+		exclude = outside
+				.isIgnored(pathName, baseName, dType, deepestDirectory);
+		if (exclude != null) {
+			return exclude;
+		}
+		
+		/* also check info/exclude file per repo */
+		exclude = infoExclude.isIgnored(baseName, baseName, dType,
+				deepestDirectory);
+		if (exclude != null) {
+			return exclude;
+		}
+		
+		/* also check core.excludesfile per repo */
+		exclude = coreExcludes.isIgnored(baseName, baseName, dType,
+				deepestDirectory);
+		if (exclude != null) {
+			return exclude;
+		}
+
+		return null;
 	}
 }
\ No newline at end of file
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 414bd83..09766b6 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -63,6 +63,9 @@
 		@SuppressWarnings("synthetic-access")
 		public void resourceChanged(final IResourceChangeEvent event) {
 			switch (event.getType()) {
+			case IResourceChangeEvent.POST_CHANGE:
+				// GitIgnoreData.processChangesForIgnores(event);
+				break;
 			case IResourceChangeEvent.PRE_CLOSE:
 				uncache((IProject) event.getResource());
 				GitIgnoreData.uncacheProject(event.getResource());
diff --git a/org.spearce.jgit/META-INF/MANIFEST.MF b/org.spearce.jgit/META-INF/MANIFEST.MF
index 3344c3c..e5f6478 100644
--- a/org.spearce.jgit/META-INF/MANIFEST.MF
+++ b/org.spearce.jgit/META-INF/MANIFEST.MF
@@ -7,6 +7,7 @@ Bundle-Localization: plugin
 Bundle-Vendor: %provider_name
 Export-Package: org.spearce.jgit.dircache,
  org.spearce.jgit.errors;uses:="org.spearce.jgit.lib",
+ org.spearce.jgit.fnmatch,
  org.spearce.jgit.lib,
  org.spearce.jgit.revplot,
  org.spearce.jgit.revwalk,
-- 
1.6.0.6
