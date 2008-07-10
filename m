From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/9] Add a job to periodically scan for repository changes
Date: Fri, 11 Jul 2008 00:40:47 +0200
Message-ID: <1215729651-26781-6-git-send-email-robin.rosenberg@dewire.com>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-4-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vV-0004Lo-5s
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYGJWqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbYGJWqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:09 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13129 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754275AbYGJWqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 986C38030C5;
	Fri, 11 Jul 2008 00:46:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9jn-wOmCbMI; Fri, 11 Jul 2008 00:46:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7955C8027F7;
	Fri, 11 Jul 2008 00:45:58 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729651-26781-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88033>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/Activator.java         |   75 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   10 +++
 2 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
index 8d1b8cd..3e02c44 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
@@ -10,18 +10,27 @@ package org.spearce.egit.ui;
 
 import java.net.Authenticator;
 import java.net.ProxySelector;
+import java.util.HashSet;
+import java.util.Set;
 
 import org.eclipse.core.net.proxy.IProxyService;
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.IStatus;
 import org.eclipse.core.runtime.Platform;
 import org.eclipse.core.runtime.Status;
+import org.eclipse.core.runtime.jobs.ISchedulingRule;
+import org.eclipse.core.runtime.jobs.Job;
 import org.eclipse.jsch.core.IJSchService;
 import org.eclipse.swt.graphics.Font;
 import org.eclipse.ui.plugin.AbstractUIPlugin;
 import org.eclipse.ui.themes.ITheme;
 import org.osgi.framework.BundleContext;
 import org.osgi.framework.ServiceReference;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.transport.SshSessionFactory;
 
 /**
@@ -127,6 +136,7 @@ public class Activator extends AbstractUIPlugin {
 	}
 
 	private boolean traceVerbose;
+	private RCS rcs;
 
 	/**
 	 * Constructor for the egit ui plugin singleton
@@ -140,6 +150,66 @@ public class Activator extends AbstractUIPlugin {
 		traceVerbose = isOptionSet("/trace/verbose");
 		setupSSH(context);
 		setupProxy(context);
+		setupRepoChangeScanner();
+	}
+
+	static class RCS extends Job {
+		RCS() {
+			super("Repository Change Scanner");
+		}
+
+		// FIXME, need to be more intelligent about this to avoid too much work
+		private static final long REPO_SCAN_INTERVAL = 10000L;
+
+		@Override
+		protected IStatus run(IProgressMonitor monitor) {
+			try {
+				// A repository can contain many projects, only scan once
+				// (a project could in theory be distributed among many
+				// repositories. We discard that as being ugly and stupid for
+				// the moment.
+				IProject[] projects = ResourcesPlugin.getWorkspace().getRoot().getProjects();
+				monitor.beginTask("Scanning Git repositories for changes", projects.length);
+				Set<Repository> scanned = new HashSet<Repository>();
+				for (IProject p : projects) {
+					RepositoryMapping mapping = RepositoryMapping.getMapping(p);
+					if (mapping != null) {
+						Repository r = mapping.getRepository();
+						if (!scanned.contains(r)) {
+							if (monitor.isCanceled())
+								break;
+							trace("Scanning " + r + " for changes");
+							scanned.add(r);
+							ISchedulingRule rule = p.getWorkspace().getRuleFactory().modifyRule(p);
+							getJobManager().beginRule(rule, monitor);
+							try {
+								r.scanForRepoChanges();
+							} finally {
+								getJobManager().endRule(rule);
+							}
+						}
+					}
+					monitor.worked(1);
+				}
+				monitor.done();
+				trace("Rescheduling " + getName() + " job");
+				schedule(REPO_SCAN_INTERVAL);
+			} catch (Exception e) {
+				trace("Stopped rescheduling " + getName() + "job");
+				return new Status(
+						IStatus.ERROR,
+						getPluginId(),
+						0,
+						"An error occurred while scanning for changes. Scanning aborted",
+						e);
+			}
+			return Status.OK_STATUS;
+		}
+	}
+
+	private void setupRepoChangeScanner() {
+		rcs = new RCS();
+		rcs.schedule(RCS.REPO_SCAN_INTERVAL);
 	}
 
 	private void setupSSH(final BundleContext context) {
@@ -165,6 +235,11 @@ public class Activator extends AbstractUIPlugin {
 	}
 
 	public void stop(final BundleContext context) throws Exception {
+		trace("Trying to cancel " + rcs.getName() + " job");
+		if (!rcs.cancel()) {
+			rcs.join();
+		}
+		trace("rcs.getName() " + rcs.getName() + " cancelled ok");
 		super.stop(context);
 		plugin = null;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index dfa3045..9b65154 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1092,4 +1092,14 @@ public class Repository {
 			l.indexChanged(event);
 		}
 	}
+
+	/**
+	 * Force a scan for changed refs.
+	 *
+	 * @throws IOException
+	 */
+	public void scanForRepoChanges() throws IOException {
+		getAllRefs(); // This will look for changes to refs
+		getIndex(); // This will detect changes in the index
+	}
 }
-- 
1.5.6.2.220.g44701
