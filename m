From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH RFC v1 1/5] Build up the ignore patterns cache upon workspace startup.
Date: Thu, 26 Mar 2009 22:34:23 +0100
Message-ID: <213427d4111185ae3a094a3cd578be8e6c3d5ffb.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 22:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmxFt-00088S-UU
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739AbZCZVer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 17:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZCZVeq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:34:46 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:46224 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755739AbZCZVee (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 17:34:34 -0400
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id E242158BDC7;
	Thu, 26 Mar 2009 22:34:27 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <cover.1238102327.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1238102327.git.ferry.huberts@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114828>

Read in all relevant ignore files: all .gitignore files in the projects,
all .gitignore files between the checkout directory and the project
directories, the info/exclude ignore files of the repositories, the
repository core.excludesfile ignore files and the global
core.excludesfile ignore file.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 .../src/org/spearce/egit/core/ignores/Exclude.java |  158 ++++++
 .../spearce/egit/core/ignores/GitIgnoreData.java   |  139 +++++
 .../org/spearce/egit/core/ignores/IgnoreFile.java  |   82 +++
 .../egit/core/ignores/IgnoreFileOutside.java       |  543 ++++++++++++++++++++
 .../egit/core/ignores/IgnoreProjectCache.java      |  201 ++++++++
 .../egit/core/ignores/IgnoreRepositoryCache.java   |  308 +++++++++++
 .../spearce/egit/core/project/GitProjectData.java  |    5 +
 7 files changed, 1436 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFile.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFileOutside.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java
new file mode 100644
index 0000000..c4c48e9
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java
@@ -0,0 +1,158 @@
+/*******************************************************************************
+ * Copyright (C) 2009, Ferry Huberts <ferry.huberts@pelagic.nl>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.ignores;
+
+import java.util.regex.Pattern;
+
+/**
+ * This class describes an ignore pattern in the same way as git does, with some
+ * extra information to support Eclipse specific functionality.
+ * 
+ * The git definition can be found in the source file dir.h, within the
+ * exclude_list structure definition. The code can be found in the source file
+ * dir.c:excluded_1
+ */
+class Exclude {
+	/** the pattern to match */
+	private String pattern = null;
+
+	/**
+	 * the directory in which the pattern is anchored, relative to the checkout
+	 * directory and with a trailing slash (except when in the checkout
+	 * directory, in which case it will be an empty string). Slashes are in Unix
+	 * format: forward slashes
+	 */
+	private String base = null;
+
+	/**
+	 * true when the resource must be excluded when matched, false in case of a
+	 * negative pattern: when it must be included
+	 */
+	private boolean to_exclude = true;
+
+	/** true when the resource must be a directory */
+	private boolean mustBeDir = false;
+
+	/** true when the pattern does not contain directories */
+	private boolean noDir = false;
+
+	/** true when the resource must end with pattern.substring(1) */
+	private boolean endsWith = false;
+
+	/** true when the pattern has no wildcards */
+	private boolean noWildcard = false;
+
+	/*
+	 * Extra Information
+	 */
+
+	/**
+	 * the full path name of the ignore file. Stored so that a user can ask
+	 * 'which pattern in which ignore file makes this resource be ignored?'
+	 */
+	private String ignoreFileAbsolutePath = null;
+
+	/**
+	 * the line number of the pattern in the ignore file. Stored for the same
+	 * reason as the ignoreFileFullPath field
+	 */
+	private int lineNumber = 0;
+
+	/**
+	 * Constructor. See the git source file dir.c, method add_exclude
+	 * 
+	 * @param pattern
+	 *            the pattern to match
+	 * @param base
+	 *            the directory in which the pattern is anchored, relative to
+	 *            the checkout directory and with a trailing slash (except when
+	 *            in the checkout directory, in which case it will be an empty
+	 *            string). Slashes are in Unix format: forward slashes
+	 * @param ignoreFileAbsolutePath
+	 *            the full path name of the ignore file. Stored so that a user
+	 *            can ask 'which pattern in which ignore file makes this
+	 *            resource be ignored?'
+	 * @param lineNumber
+	 *            the line number of the pattern in the ignore file. Stored for
+	 *            the same reason as the ignoreFileFullPath field
+	 */
+	Exclude(final String pattern, final String base,
+			final String ignoreFileAbsolutePath, final int lineNumber) {
+		this.pattern = pattern;
+		this.base = base;
+
+		this.to_exclude = !this.pattern.startsWith("!");
+		if (!this.to_exclude) {
+			this.pattern = this.pattern.substring(1);
+		}
+
+		this.mustBeDir = this.pattern.endsWith("/");
+		if (this.mustBeDir) {
+			this.pattern = this.pattern.substring(0, this.pattern.length() - 1);
+		}
+		this.noDir = !this.pattern.contains("/");
+		this.noWildcard = no_wildcard(this.pattern);
+		this.endsWith = ((this.pattern.charAt(0) == '*') && no_wildcard(this.pattern
+				.substring(1)));
+
+		this.ignoreFileAbsolutePath = ignoreFileAbsolutePath;
+		this.lineNumber = lineNumber;
+	}
+
+	/*
+	 * Private Methods
+	 */
+
+	private static Pattern wildcardPattern = Pattern
+			.compile("^.*[\\*\\?\\[\\{].*$");
+
+	/* dir.c::no_wildcard */
+	private boolean no_wildcard(final String string) {
+		return !wildcardPattern.matcher(string).matches();
+	}
+
+	/*
+	 * Getters / Setters
+	 */
+
+	public String getIgnoreFileAbsolutePath() {
+		return ignoreFileAbsolutePath;
+	}
+
+	public int getLineNumber() {
+		return lineNumber;
+	}
+
+	/**
+	 * @return the base
+	 */
+	public String getBase() {
+		return base;
+	}
+
+	/**
+	 * @return the noDir
+	 */
+	public boolean isNoDir() {
+		return noDir;
+	}
+
+	/**
+	 * @return the endsWith
+	 */
+	public boolean isEndsWith() {
+		return endsWith;
+	}
+
+	/**
+	 * @return the noWildcard
+	 */
+	public boolean isNoWildcard() {
+		return noWildcard;
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java
new file mode 100644
index 0000000..401a378
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java
@@ -0,0 +1,139 @@
+/*******************************************************************************
+ * Copyright (C) 2009, Ferry Huberts <ferry.huberts@pelagic.nl>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.ignores;
+
+import java.util.HashMap;
+
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IWorkspace;
+import org.eclipse.core.resources.ResourcesPlugin;
+import org.eclipse.core.runtime.CoreException;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * This class provides management of ignore data. It deals with .gitignore
+ * files, the .git/info/exclude file, and core.excludefile settings. It also
+ * deals with with changes to those files.
+ * 
+ * The git code for ignores can be found in its files dir.{h,c}.
+ * 
+ * See the file Documentation/gitignore.txt in the git repository for a
+ * description of how ignores work.
+ */
+public class GitIgnoreData {
+
+	/*
+	 * Ignore Data Cache
+	 */
+
+	private static HashMap<Repository, IgnoreRepositoryCache> repositories = new HashMap<Repository, IgnoreRepositoryCache>();
+
+	/**
+	 * Retrieve a repository mapping from the repositories cache. When the
+	 * repository is not yet in the cache then create a new mapping for it and
+	 * store it in the cache first.
+	 * 
+	 * @param repository
+	 *            the repository to retrieve from the repositories cache
+	 * @return the repository mapping in the cache
+	 */
+	private static IgnoreRepositoryCache getRepositoryFromCache(
+			final Repository repository) {
+		IgnoreRepositoryCache cache = repositories.get(repository);
+		if (cache == null) {
+			cache = new IgnoreRepositoryCache(repository);
+			repositories.put(repository, cache);
+		}
+		return cache;
+	}
+
+	/*
+	 * Public Methods
+	 */
+
+	/**
+	 * This method must be invoked upon shutdown of the plugin. It empties the
+	 * ignore cache.
+	 */
+	public synchronized static void clear() {
+		for (final IgnoreRepositoryCache projectCache : repositories.values()) {
+			projectCache.clear();
+		}
+		repositories.clear();
+	}
+
+	/**
+	 * @param project
+	 *            the project to remove the ignores for
+	 */
+	public synchronized static void uncacheProject(final IResource project) {
+		if ((project == null) || (!(project instanceof IProject))) {
+			return;
+		}
+
+		final RepositoryMapping mapping = RepositoryMapping.getMapping(project);
+		if (mapping == null) {
+			return;
+		}
+
+		final Repository repository = mapping.getRepository();
+		final IgnoreRepositoryCache ignoreData = repositories.get(repository);
+		if (ignoreData == null) {
+			return;
+		}
+
+		ignoreData.uncacheProject((IProject) project);
+	}
+
+	/**
+	 * This method must be invoked upon startup. It goes through all files in
+	 * the workspace and picks up all .gitignore files, parses them so that the
+	 * plugin knows what to ignore. It also goes up the directory tree from the
+	 * project root directories to look for .gitignore files.
+	 */
+	public synchronized static void importWorkspaceIgnores() {
+		final IWorkspace workSpace = ResourcesPlugin.getWorkspace();
+		final IProject[] projects = workSpace.getRoot().getProjects();
+		for (final IProject project : projects) {
+			final RepositoryMapping mapping = RepositoryMapping
+					.getMapping(project);
+			if (mapping != null) {
+				try {
+					final IResource[] projectChildren = project.members();
+					final IgnoreRepositoryCache ignoreRepositoryCache = getRepositoryFromCache(mapping
+							.getRepository());
+					ignoreRepositoryCache.importProjectIgnores(project,
+							projectChildren);
+					ignoreRepositoryCache.importProjectIgnoresOutside(project);
+				} catch (final CoreException e) {
+					/* swallow */
+				}
+			}
+		}
+
+		for (final IgnoreRepositoryCache repositoryCache : repositories
+				.values()) {
+			repositoryCache.importRepositoryInfoExclude();
+			repositoryCache.importRepositoryCoreExclude();
+		}
+
+		/*
+		 * FIXME: also do the file `git config --global --get
+		 * core.excludesfile`, is this already covered? RepositoryConfig
+		 * globalConfig = new RepositoryConfig(null, new File(FS.userHome(),
+		 * ".gitconfig"));
+		 */
+
+		/*
+		 * System.out.println("== GitIgnoreData.repositories ==\n" +
+		 * repositories.toString());
+		 */
+	}
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFile.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFile.java
new file mode 100644
index 0000000..78dd71d
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFile.java
@@ -0,0 +1,82 @@
+/*******************************************************************************
+ * Copyright (C) 2009, Ferry Huberts <ferry.huberts@pelagic.nl>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.ignores;
+
+import java.io.BufferedReader;
+import java.io.IOException;
+import java.io.InputStreamReader;
+import java.util.LinkedList;
+
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.runtime.CoreException;
+
+/**
+ * This class implements ignore file helpers.
+ */
+class IgnoreFile {
+	/**
+	 * This method parses an ignore file.
+	 * 
+	 * @param ignoreFileBaseDir
+	 *            the directory of the ignore file, relative to the checkout
+	 *            directory and with a trailing slash. Slashes are in Unix
+	 *            format: forward slashes
+	 * @param ignoreFile
+	 *            the .gitignore file
+	 * @return returns a set of Excludes that reflects the ignore patterns.
+	 */
+	static LinkedList<Exclude> parseIgnoreFile(final String ignoreFileBaseDir,
+			final IFile ignoreFile) {
+		final LinkedList<Exclude> excludes = new LinkedList<Exclude>();
+
+		/* make sure that the resource is synchronized */
+		try {
+			if (!ignoreFile.isSynchronized(IResource.DEPTH_ZERO)) {
+				ignoreFile.refreshLocal(IResource.DEPTH_ZERO, null);
+			}
+		} catch (final Exception e) {
+			return excludes;
+		}
+
+		String base = ignoreFileBaseDir;
+		if (base.equals("/")) {
+			base = "";
+		}
+		final String ignoreFileName = ignoreFile.getLocation().toOSString();
+		BufferedReader txtIn = null;
+		int lineNumber = 0;
+		try {
+			txtIn = new BufferedReader(new InputStreamReader(ignoreFile
+					.getContents()));
+			String line;
+			while ((line = txtIn.readLine()) != null) {
+				lineNumber++;
+				line = line.trim();
+				if (!line.startsWith("#") && (line.length() > 0)) {
+					excludes.add(new Exclude(line, base, ignoreFileName,
+							lineNumber));
+				}
+			}
+		} catch (final CoreException e) {
+			/* swallow */
+		} catch (final IOException e) {
+			/* swallow */
+		} finally {
+			try {
+				if (txtIn != null) {
+					txtIn.close();
+					txtIn = null;
+				}
+			} catch (final IOException e1) {
+				/* swallow */
+			}
+		}
+		return excludes;
+	}
+}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFileOutside.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFileOutside.java
new file mode 100644
index 0000000..8ad5a48
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFileOutside.java
@@ -0,0 +1,543 @@
+/*******************************************************************************
+ * Copyright (C) 2009, Ferry Huberts <ferry.huberts@pelagic.nl>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.ignores;
+
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.InputStream;
+import java.io.Reader;
+import java.net.URI;
+import java.util.Map;
+
+import org.eclipse.core.resources.IContainer;
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IFileState;
+import org.eclipse.core.resources.IMarker;
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IProjectDescription;
+import org.eclipse.core.resources.IResourceProxy;
+import org.eclipse.core.resources.IResourceProxyVisitor;
+import org.eclipse.core.resources.IResourceVisitor;
+import org.eclipse.core.resources.IWorkspace;
+import org.eclipse.core.resources.ResourceAttributes;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Path;
+import org.eclipse.core.runtime.QualifiedName;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.core.runtime.content.IContentDescription;
+import org.eclipse.core.runtime.jobs.ISchedulingRule;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * This class is only used to be able to store the .gitignore files in the
+ * ignore cache that are outside the projects (up in the checkout directory tree
+ * from the project root directory)
+ */
+class IgnoreFileOutside implements IFile {
+	private String relativeDir = null;
+
+	private String relativePath = null;
+
+	private String resourceBaseName = null;
+
+	private String absoluteDir = null;
+
+	private String fullPath = null;
+
+	private File fullPathFile = null;
+
+	private long lastModificationTime = 0L;
+
+	/**
+	 * Constructor
+	 * 
+	 * @param repository
+	 *            the repository. when null then the relativeDir parameter is
+	 *            taken to be an absolute path
+	 * @param directory
+	 *            the directory in which the pattern is anchored, relative to
+	 *            the checkout directory and with a trailing slash (except when
+	 *            in the checkout directory, in which case it will be an empty
+	 *            string). Slashes are in Unix format: forward slashes. When
+	 *            repository is null then this is taken to be an absolute
+	 *            directory with slashes in platform format.
+	 * @param resourceBasename
+	 *            the name of the ignore file.
+	 */
+	IgnoreFileOutside(final Repository repository, final String directory,
+			final String resourceBasename) {
+		if ((directory == null) || (resourceBasename == null)) {
+			throw new IllegalArgumentException("Can not handle NULL values: "
+					+ directory + ", " + resourceBasename);
+		}
+
+		this.relativeDir = directory.replaceAll("/", File.separator);
+		this.resourceBaseName = resourceBasename
+				.replaceAll("/", File.separator);
+		this.relativePath = this.relativeDir + this.resourceBaseName;
+
+		String repoRoot = "";
+		if (repository != null) {
+			repoRoot = repository.getWorkDir().getAbsolutePath()
+					+ File.separator;
+		}
+		this.absoluteDir = repoRoot + this.relativeDir;
+		this.fullPath = this.absoluteDir + this.resourceBaseName;
+		this.fullPathFile = new File(this.fullPath);
+	}
+
+	/* used interface methods */
+
+	public boolean exists() {
+		return this.fullPathFile.exists();
+	}
+
+	public InputStream getContents() throws CoreException {
+		try {
+			return new FileInputStream(fullPath);
+		} catch (final FileNotFoundException e) {
+			/* FIXME: use actual plugin id */
+			throw new CoreException(new Status(IStatus.WARNING, "git plugin", e
+					.getLocalizedMessage()));
+		}
+	}
+
+	public String getName() {
+		return resourceBaseName;
+	}
+
+	public IPath getProjectRelativePath() {
+		return new Path(relativePath);
+	}
+
+	public boolean isSynchronized(final int depth) {
+		return (lastModificationTime == this.fullPathFile.lastModified());
+	}
+
+	public void refreshLocal(final int depth, final IProgressMonitor monitor)
+			throws CoreException {
+		lastModificationTime = this.fullPathFile.lastModified();
+		return;
+	}
+
+	public IPath getLocation() {
+		return new Path(fullPath);
+	}
+
+	/*
+	 * Overridden Methods
+	 */
+
+	@Override
+	public boolean equals(final Object obj) {
+		if (!(obj instanceof IgnoreFileOutside)) {
+			throw new IllegalArgumentException("Wrong type");
+		}
+		return ((IgnoreFileOutside) obj).fullPath.equals(this.fullPath);
+	}
+
+	@Override
+	public int hashCode() {
+		return fullPath.hashCode();
+	}
+
+	@Override
+	public String toString() {
+		return fullPath;
+	}
+
+	/*
+	 * Unused Interface Methods
+	 */
+
+	public void appendContents(final InputStream source, final int updateFlags,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void appendContents(final InputStream source, final boolean force,
+			final boolean keepHistory, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void create(final InputStream source, final boolean force,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void create(final InputStream source, final int updateFlags,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void createLink(final IPath localLocation, final int updateFlags,
+			final IProgressMonitor monitor) throws CoreException {
+
+		/** not used */
+	}
+
+	public void createLink(final URI location, final int updateFlags,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void delete(final boolean force, final boolean keepHistory,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public String getCharset() throws CoreException {
+		return null;
+	}
+
+	public String getCharset(final boolean checkImplicit) throws CoreException {
+		return null;
+	}
+
+	public String getCharsetFor(final Reader reader) throws CoreException {
+		return null;
+	}
+
+	public IContentDescription getContentDescription() throws CoreException {
+		return null;
+	}
+
+	public InputStream getContents(final boolean force) throws CoreException {
+		return null;
+	}
+
+	public int getEncoding() throws CoreException {
+		return 0;
+	}
+
+	public IPath getFullPath() {
+		return null;
+	}
+
+	public IFileState[] getHistory(final IProgressMonitor monitor)
+			throws CoreException {
+		return null;
+	}
+
+	public boolean isReadOnly() {
+		return false;
+	}
+
+	public void move(final IPath destination, final boolean force,
+			final boolean keepHistory, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void setCharset(final String newCharset) throws CoreException {
+		/** not used */
+	}
+
+	public void setCharset(final String newCharset,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void setContents(final InputStream source, final int updateFlags,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void setContents(final IFileState source, final int updateFlags,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void setContents(final InputStream source, final boolean force,
+			final boolean keepHistory, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void setContents(final IFileState source, final boolean force,
+			final boolean keepHistory, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void accept(final IResourceVisitor visitor) throws CoreException {
+		/** not used */
+	}
+
+	public void accept(final IResourceProxyVisitor visitor,
+			final int memberFlags) throws CoreException {
+		/** not used */
+	}
+
+	public void accept(final IResourceVisitor visitor, final int depth,
+			final boolean includePhantoms) throws CoreException {
+		/** not used */
+	}
+
+	public void accept(final IResourceVisitor visitor, final int depth,
+			final int memberFlags) throws CoreException {
+		/** not used */
+	}
+
+	public void clearHistory(final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void copy(final IPath destination, final boolean force,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void copy(final IPath destination, final int updateFlags,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void copy(final IProjectDescription description,
+			final boolean force, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void copy(final IProjectDescription description,
+			final int updateFlags, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public IMarker createMarker(final String type) throws CoreException {
+		return null;
+	}
+
+	public IResourceProxy createProxy() {
+		return null;
+	}
+
+	public void delete(final boolean force, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void delete(final int updateFlags, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void deleteMarkers(final String type, final boolean includeSubtypes,
+			final int depth) throws CoreException {
+		/** not used */
+	}
+
+	public IMarker findMarker(final long id) throws CoreException {
+		return null;
+	}
+
+	public IMarker[] findMarkers(final String type,
+			final boolean includeSubtypes, final int depth)
+			throws CoreException {
+		return null;
+	}
+
+	public int findMaxProblemSeverity(final String type,
+			final boolean includeSubtypes, final int depth)
+			throws CoreException {
+		return 0;
+	}
+
+	public String getFileExtension() {
+		return null;
+	}
+
+	public long getLocalTimeStamp() {
+		return 0;
+	}
+
+	public URI getLocationURI() {
+		return null;
+	}
+
+	public IMarker getMarker(final long id) {
+		return null;
+	}
+
+	public long getModificationStamp() {
+		return 0;
+	}
+
+	public IContainer getParent() {
+		return null;
+	}
+
+	public Map getPersistentProperties() throws CoreException {
+		return null;
+	}
+
+	public String getPersistentProperty(final QualifiedName key)
+			throws CoreException {
+		return null;
+	}
+
+	public IProject getProject() {
+		return null;
+	}
+
+	public IPath getRawLocation() {
+		return null;
+	}
+
+	public URI getRawLocationURI() {
+		return null;
+	}
+
+	public ResourceAttributes getResourceAttributes() {
+		return null;
+	}
+
+	public Map getSessionProperties() throws CoreException {
+		return null;
+	}
+
+	public Object getSessionProperty(final QualifiedName key)
+			throws CoreException {
+		return null;
+	}
+
+	public int getType() {
+		return 0;
+	}
+
+	public IWorkspace getWorkspace() {
+		return null;
+	}
+
+	public boolean isAccessible() {
+		return false;
+	}
+
+	public boolean isDerived() {
+		return false;
+	}
+
+	public boolean isDerived(final int options) {
+		return false;
+	}
+
+	public boolean isHidden() {
+		return false;
+	}
+
+	public boolean isLinked() {
+		return false;
+	}
+
+	public boolean isLinked(final int options) {
+		return false;
+	}
+
+	public boolean isLocal(final int depth) {
+		return false;
+	}
+
+	public boolean isPhantom() {
+		return false;
+	}
+
+	public boolean isTeamPrivateMember() {
+		return false;
+	}
+
+	public void move(final IPath destination, final boolean force,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void move(final IPath destination, final int updateFlags,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void move(final IProjectDescription description,
+			final int updateFlags, final IProgressMonitor monitor)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void move(final IProjectDescription description,
+			final boolean force, final boolean keepHistory,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public void revertModificationStamp(final long value) throws CoreException {
+		/** not used */
+	}
+
+	public void setDerived(final boolean isDerived) throws CoreException {
+		/** not used */
+	}
+
+	public void setHidden(final boolean isHidden) throws CoreException {
+		/** not used */
+	}
+
+	public void setLocal(final boolean flag, final int depth,
+			final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public long setLocalTimeStamp(final long value) throws CoreException {
+		return 0;
+	}
+
+	public void setPersistentProperty(final QualifiedName key,
+			final String value) throws CoreException {
+		/** not used */
+	}
+
+	public void setReadOnly(final boolean readOnly) {
+		/** not used */
+	}
+
+	public void setResourceAttributes(final ResourceAttributes attributes)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void setSessionProperty(final QualifiedName key, final Object value)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void setTeamPrivateMember(final boolean isTeamPrivate)
+			throws CoreException {
+		/** not used */
+	}
+
+	public void touch(final IProgressMonitor monitor) throws CoreException {
+		/** not used */
+	}
+
+	public Object getAdapter(final Class adapter) {
+		return null;
+	}
+
+	public boolean contains(final ISchedulingRule rule) {
+		return false;
+	}
+
+	public boolean isConflicting(final ISchedulingRule rule) {
+		return false;
+	}
+
+}
\ No newline at end of file
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java
new file mode 100644
index 0000000..fe2f529
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java
@@ -0,0 +1,201 @@
+/*******************************************************************************
+ * Copyright (C) 2009, Ferry Huberts <ferry.huberts@pelagic.nl>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.ignores;
+
+import java.util.HashMap;
+import java.util.LinkedList;
+
+import org.eclipse.core.resources.IFile;
+import org.eclipse.core.resources.IFolder;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IResourceDelta;
+import org.eclipse.core.runtime.CoreException;
+
+/**
+ * This class implements a cache of ignore patterns for an Eclipse project: it
+ * holds a list of ignore patterns, stored in 'ignoreFiles' against the ignore
+ * file handle. We also keep an ignoreFilesIndex of the ignore file handle
+ * stored against the directory names (relative to the 'checkoutDir') of the
+ * ignore ignoreFiles in 'ignoreFilesIndex'. We use this to access the cache and
+ * retrieve the list of ignore patterns. This is because when trying to
+ * determine whether a resource is ignored we must first try the ignore file in
+ * the directory of the resource, and if it doesn't match, then in the directory
+ * up from that, and so on, al the way up to the checkout directory.
+ */
+class IgnoreProjectCache {
+	/**
+	 * the directory of the project, relative to the checkout, with a trailing
+	 * slash, except when in the checkout directory in which case it will be
+	 * empty
+	 */
+	private String projectDirInCheckout = null;
+
+	/**
+	 * Map used to find .gitignore ignore files in ignoreFiles. key=directory
+	 * path of the .gitignore file, relative to the checkout directory,
+	 * value=IFile to use to ignoreFilesIndex ignoreFiles
+	 */
+	private final HashMap<String, IFile> ignoreFilesIndex = new HashMap<String, IFile>();
+
+	/**
+	 * Map with .gitignore ignore files and their exclude patterns.
+	 * key=.gitignore file handle, value=list with its ignore patterns
+	 */
+	private final HashMap<IFile, LinkedList<Exclude>> ignoreFiles = new HashMap<IFile, LinkedList<Exclude>>();
+
+	/*
+	 * Constructors
+	 */
+
+	/**
+	 * Constructor
+	 * 
+	 * @param projectDirInCheckout
+	 *            the directory of the project, relative to the checkout
+	 */
+	IgnoreProjectCache(final String projectDirInCheckout) {
+		if (projectDirInCheckout == null) {
+			throw new ExceptionInInitializerError(
+					"NULL is not a valid project directory");
+		}
+
+		this.projectDirInCheckout = projectDirInCheckout;
+		if (!this.projectDirInCheckout.isEmpty()
+				&& !this.projectDirInCheckout.endsWith("/")) {
+			this.projectDirInCheckout = this.projectDirInCheckout.concat("/");
+		}
+	}
+
+	/*
+	 * Methods
+	 */
+
+	synchronized void clear() {
+		ignoreFilesIndex.clear();
+
+		for (final LinkedList<Exclude> excludeList : ignoreFiles.values()) {
+			excludeList.clear();
+		}
+		ignoreFiles.clear();
+	}
+
+	synchronized void importProjectIgnores(final IResource[] projectChildren) {
+		if (projectChildren == null) {
+			return;
+		}
+
+		for (final IResource projectChild : projectChildren) {
+			if (projectChild != null) {
+				if (projectChild instanceof IFile) {
+					if (projectChild.getName().equals(".gitignore")) {
+						String projectRelativeDir = projectChild
+								.getProjectRelativePath().removeLastSegments(1)
+								.toString();
+						if (!projectRelativeDir.isEmpty()) {
+							projectRelativeDir = projectRelativeDir + "/";
+						}
+						final String ignoreFileBaseDir = projectDirInCheckout
+								+ projectRelativeDir;
+						processIgnoreFile((IFile) projectChild,
+								ignoreFileBaseDir, IResourceDelta.ADDED,
+								IResourceDelta.CONTENT);
+					}
+				} else if (projectChild instanceof IFolder) {
+					try {
+						importProjectIgnores(((IFolder) projectChild).members());
+					} catch (final CoreException e) {
+						/* swallow */
+					}
+				} else {
+					/* FIXME: signal an error */
+					System.out.println("Unhandled resource type in"
+							+ " processResourceForIgnoreChild: "
+							+ projectChild.getClass().getName());
+				}
+			}
+		}
+	}
+
+	/**
+	 * This method parses a .gitignore file and stores the patterns for use by
+	 * the plugin. It is shared between startup of the workspace and changes to
+	 * the workspace.
+	 * 
+	 * @param ignoreFile
+	 *            the .gitignore file
+	 * @param ignoreFileBaseDir
+	 *            the directory of the ignore file, relative to the checkout
+	 *            directory and with a trailing slash (except when in the
+	 *            checkout directory, in which case it will be an empty string).
+	 *            Slashes are in Unix format: forward slashes
+	 * @param changeKind
+	 *            the kind of the change
+	 * @param changeFlags
+	 *            further information on the change
+	 */
+	synchronized void processIgnoreFile(final IFile ignoreFile,
+			final String ignoreFileBaseDir, final int changeKind,
+			final int changeFlags) {
+		if ((ignoreFile == null) || (changeKind == IResourceDelta.NO_CHANGE)) {
+			return;
+		}
+
+		if (((changeKind & IResourceDelta.ADDED) == IResourceDelta.ADDED)
+				|| ((changeKind & IResourceDelta.ADDED_PHANTOM) == IResourceDelta.ADDED_PHANTOM)
+				|| (((changeKind & IResourceDelta.CHANGED) == IResourceDelta.CHANGED) && ((changeFlags & IResourceDelta.CONTENT) == IResourceDelta.CONTENT))) {
+			ignoreFiles.put(ignoreFile, IgnoreFile.parseIgnoreFile(
+					ignoreFileBaseDir, ignoreFile));
+			ignoreFilesIndex.put(ignoreFileBaseDir, ignoreFile);
+		} else if (((changeKind & IResourceDelta.REMOVED) == IResourceDelta.REMOVED)
+				|| ((changeKind & IResourceDelta.REMOVED_PHANTOM) == IResourceDelta.REMOVED_PHANTOM)) {
+			ignoreFiles.remove(ignoreFile);
+			ignoreFilesIndex.remove(ignoreFileBaseDir);
+		} else {
+			System.out.println("Unhandled change combination kind/flags: "
+					+ changeKind + "/" + changeFlags);
+		}
+
+		// int changeKind = projectChild.getKind();
+		// int changeFlags = projectChild.getFlags();
+		// switch (changeKind) {
+		// case IResourceDelta.ADDED:
+		// case IResourceDelta.ADDED_PHANTOM:
+		// if ((changeFlags & IResourceDelta.MOVED_FROM) ==
+		// IResourceDelta.MOVED_FROM) {
+		// /*
+		// * The resource has moved: getMovedToPath will
+		// * return the path of where it was moved to.
+		// */
+		// break;
+		// }
+		//
+		// /* simply parse the content and process it */
+		// break;
+		//
+		// case IResourceDelta.REMOVED:
+		// case IResourceDelta.REMOVED_PHANTOM:
+		// /* remove the patterns from the file */
+		// break;
+		//
+		// case IResourceDelta.CHANGED:
+		// /* this one is more involved, also have to deal with moved
+		// ignoreFiles */
+		// if ((changeFlags & IResourceDelta.REPLACED) ==
+		// IResourceDelta.REPLACED) {
+		// /*
+		// * The resource has moved: getMovedToPath will
+		// * return the path of where it was moved to.
+		// */
+		// }
+		// break;
+		//
+		// default:
+		// break;
+		// }
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java
new file mode 100644
index 0000000..4b6bf61
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java
@@ -0,0 +1,308 @@
+/*******************************************************************************
+ * Copyright (C) 2009, Ferry Huberts <ferry.huberts@pelagic.nl>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.core.ignores;
+
+import java.io.File;
+import java.util.HashMap;
+
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IResourceDelta;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IPath;
+import org.eclipse.core.runtime.Path;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryConfig;
+
+/**
+ * This class manages the ignore data for a single repository (and its
+ * checkout). It implements the model that a single repository can contain
+ * multiple projects.
+ * 
+ * It contains a cache that holds ignore data on a per-project basis and it also
+ * contains a cache that holds ignore data that does not belong to any project
+ * but still belongs to the repository. The latter cache we need because Eclipse
+ * will not send change events for those files; we have to re-read these files
+ * every time there is a change.
+ */
+class IgnoreRepositoryCache {
+	/** the repository */
+	private Repository repository = null;
+
+	/** the checkout directory for the repository */
+	private String checkoutDir = null;
+
+	/** the cache that holds ignore data on a per-project basis */
+	private final HashMap<IProject, IgnoreProjectCache> projects = new HashMap<IProject, IgnoreProjectCache>();
+
+	/** cache that holds ignore data that does not belong to any project */
+	private final IgnoreProjectCache outside = new IgnoreProjectCache("");
+
+	/** cache that holds ignore data of the .git/info/exclude files */
+	private final IgnoreProjectCache infoExclude = new IgnoreProjectCache("");
+
+	/** cache that holds ignore data of the core exclude setting */
+	private final IgnoreProjectCache coreExcludes = new IgnoreProjectCache("");
+
+	/** the .git/info/exclude file */
+	private IgnoreFileOutside infoExcludesFile = null;
+
+	/** the core.excludes file setting from the config */
+	private IgnoreFileOutside coreExcludesFile = null;
+
+	/** the core.excludesfile setting */
+	private String coreExcludesSetting = null;
+
+	/**
+	 * Retrieve a project mapping from the projects cache. When the project is
+	 * not yet in the cache then create a new mapping for it and store it in the
+	 * cache first.
+	 * 
+	 * @param project
+	 *            the project to retrieve from the projects cache
+	 * @return the project mapping in the cache
+	 */
+	private IgnoreProjectCache getProjectFromCache(final IProject project) {
+		IgnoreProjectCache cache = projects.get(project);
+		if (cache == null) {
+			cache = new IgnoreProjectCache(RepositoryMapping
+					.getMapping(project).getRepoRelativePath(project));
+			projects.put(project, cache);
+		}
+		return cache;
+	}
+
+	/*
+	 * Constructors
+	 */
+
+	/**
+	 * Constructor
+	 * 
+	 * @param repository
+	 *            the repository
+	 */
+	IgnoreRepositoryCache(final Repository repository) {
+		if (repository == null) {
+			throw new ExceptionInInitializerError(
+					"NULL is not a valid repository");
+		}
+		this.repository = repository;
+		this.checkoutDir = repository.getWorkDir().getAbsolutePath();
+	}
+
+	/*
+	 * Methods
+	 */
+
+	synchronized void clear() {
+		for (final IgnoreProjectCache projectCache : projects.values()) {
+			projectCache.clear();
+		}
+		projects.clear();
+		outside.clear();
+		infoExclude.clear();
+		coreExcludes.clear();
+	}
+
+	/**
+	 * @param project
+	 *            the project for which to remove the ignore data
+	 */
+	synchronized void uncacheProject(final IProject project) {
+		if (project == null) {
+			return;
+		}
+
+		final IgnoreProjectCache cache = projects.get(project);
+		if (cache == null) {
+			return;
+		}
+
+		/*
+		 * FIXME: remove everything that is not 'outside' to remaining projects
+		 */
+
+		cache.clear();
+
+		projects.remove(project);
+	}
+
+	/**
+	 * Process all project children: look for .gitignore files and read in the
+	 * ignore patterns.
+	 * 
+	 * @param project
+	 *            the project
+	 * @param projectChildren
+	 *            the project children
+	 */
+	synchronized void importProjectIgnores(final IProject project,
+			final IResource[] projectChildren) {
+		if ((project == null) || (projectChildren == null)) {
+			return;
+		}
+
+		final IgnoreProjectCache projectCache = getProjectFromCache(project);
+		projectCache.importProjectIgnores(projectChildren);
+	}
+
+	/*
+	 * walk directory tree up looking for .gitignore files until in the checkout
+	 * directory
+	 */
+	synchronized boolean importProjectIgnoresOutside(final IProject project) {
+		boolean changes = false;
+
+		String projectDirectory = RepositoryMapping.getMapping(project)
+				.getRepoRelativePath(project);
+		while (!projectDirectory.isEmpty()) {
+			final int pos = projectDirectory.lastIndexOf('/');
+			if (pos < 0) {
+				projectDirectory = "";
+			} else {
+				projectDirectory = projectDirectory.substring(0, pos) + "/";
+			}
+
+			final IgnoreFileOutside ignoreFile = new IgnoreFileOutside(
+					repository, projectDirectory, ".gitignore");
+			if (!ignoreFile.isSynchronized(0)) {
+				changes = true;
+				String projectRelativeDir = ignoreFile.getProjectRelativePath()
+						.removeLastSegments(1).toString();
+				if (!projectRelativeDir.isEmpty()) {
+					projectRelativeDir = projectRelativeDir + "/";
+				}
+				final String ignoreFileBaseDir = projectDirectory
+						+ projectRelativeDir;
+				outside.processIgnoreFile(ignoreFile, ignoreFileBaseDir,
+						IResourceDelta.ADDED, IResourceDelta.CONTENT);
+			}
+		}
+
+		return changes;
+	}
+
+	synchronized boolean importRepositoryInfoExclude() {
+		readRepositoryInfoExcludesFile();
+
+		if ((infoExcludesFile != null) && !infoExcludesFile.isSynchronized(0)) {
+			try {
+				infoExcludesFile.refreshLocal(IResource.DEPTH_ZERO, null);
+			} catch (final CoreException e) {
+				/* swallow */
+			}
+			infoExclude.clear();
+			infoExclude.processIgnoreFile(infoExcludesFile, "",
+					IResourceDelta.ADDED, IResourceDelta.CONTENT);
+			return true;
+		}
+		return false;
+	}
+
+	synchronized boolean importRepositoryCoreExclude() {
+		readRepositoryCoreExcludesSetting();
+		if ((coreExcludesFile != null) && !coreExcludesFile.isSynchronized(0)) {
+			try {
+				coreExcludesFile.refreshLocal(IResource.DEPTH_ZERO, null);
+			} catch (final CoreException e) {
+				/* swallow */
+			}
+			coreExcludes.clear();
+			coreExcludes.processIgnoreFile(coreExcludesFile, "",
+					IResourceDelta.ADDED, IResourceDelta.CONTENT);
+			return true;
+		}
+		return false;
+	}
+
+	/*
+	 * Private Methods
+	 */
+
+	private boolean readRepositoryInfoExcludesFile() {
+		boolean changes = false;
+
+		if (infoExcludesFile == null) {
+			infoExcludesFile = new IgnoreFileOutside(this.repository, "",
+					".git/info/exclude");
+			changes = true;
+			if (!infoExcludesFile.exists()) {
+				infoExcludesFile = null;
+				changes = false;
+			}
+		} else {
+			if (!infoExcludesFile.exists()) {
+				infoExcludesFile = null;
+				changes = true;
+			}
+		}
+
+		return changes;
+	}
+
+	private boolean readRepositoryCoreExcludesSetting() {
+		final RepositoryConfig config = repository.getConfig();
+		if (config == null) {
+			return false;
+		}
+
+		boolean changes = false;
+		String newCoreExcludesSetting = config.getString("core", null,
+				"excludesfile");
+		if (newCoreExcludesSetting != null) {
+			/* FIXME check this! both for per-repo and global */
+			if (!newCoreExcludesSetting.equals(coreExcludesSetting)) {
+				changes = true;
+
+				final IPath newCoreExcludesSettingPath = new Path(
+						newCoreExcludesSetting);
+				newCoreExcludesSetting = newCoreExcludesSettingPath
+						.toOSString();
+				if (!newCoreExcludesSettingPath.isAbsolute()) {
+					newCoreExcludesSetting = repository.getWorkDir()
+							.getAbsolutePath().toString()
+							+ File.separator + newCoreExcludesSetting;
+				}
+
+				if (coreExcludesFile != null) {
+					coreExcludesFile = null;
+				}
+
+				final int pos = newCoreExcludesSetting
+						.lastIndexOf(File.separatorChar);
+				final String directory = newCoreExcludesSetting.substring(0,
+						pos);
+				final String resourceBasename = newCoreExcludesSetting
+						.substring(pos + 1);
+
+				coreExcludes.clear();
+				coreExcludesSetting = newCoreExcludesSetting;
+				coreExcludesFile = new IgnoreFileOutside(null, directory,
+						resourceBasename);
+			}
+		} else {
+			changes = (coreExcludesSetting != null);
+			coreExcludesSetting = null;
+			coreExcludesFile = null;
+		}
+		return changes;
+	}
+	
+	/*
+	 * Getters / Setters
+	 */
+
+	/**
+	 * @return the checkoutDir
+	 */
+	public String getCheckoutDir() {
+		return checkoutDir;
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index 31d5483..414bd83 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -40,6 +40,7 @@
 import org.spearce.egit.core.CoreText;
 import org.spearce.egit.core.GitCorePreferences;
 import org.spearce.egit.core.GitProvider;
+import org.spearce.egit.core.ignores.GitIgnoreData;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.WindowCache;
 import org.spearce.jgit.lib.WindowCacheConfig;
@@ -64,9 +65,11 @@ public void resourceChanged(final IResourceChangeEvent event) {
 			switch (event.getType()) {
 			case IResourceChangeEvent.PRE_CLOSE:
 				uncache((IProject) event.getResource());
+				GitIgnoreData.uncacheProject(event.getResource());
 				break;
 			case IResourceChangeEvent.PRE_DELETE:
 				delete((IProject) event.getResource());
+				GitIgnoreData.uncacheProject(event.getResource());
 				break;
 			default:
 				break;
@@ -84,6 +87,7 @@ public void resourceChanged(final IResourceChangeEvent event) {
 	 */
 	public static void attachToWorkspace(final boolean includeChange) {
 		trace("attachToWorkspace - addResourceChangeListener");
+		GitIgnoreData.importWorkspaceIgnores();
 		ResourcesPlugin.getWorkspace().addResourceChangeListener(
 				rcl,
 				(includeChange ? IResourceChangeEvent.POST_CHANGE : 0)
@@ -97,6 +101,7 @@ public static void attachToWorkspace(final boolean includeChange) {
 	public static void detachFromWorkspace() {
 		trace("detachFromWorkspace - removeResourceChangeListener");
 		ResourcesPlugin.getWorkspace().removeResourceChangeListener(rcl);
+		GitIgnoreData.clear();
 	}
 
 	/**
-- 
1.6.0.6
