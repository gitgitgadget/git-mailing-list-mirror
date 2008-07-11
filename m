From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 7/7] Add a job to refresh projects when the index changes.
Date: Fri, 11 Jul 2008 11:32:25 +0200
Message-ID: <1215768745-1420-1-git-send-email-robin.rosenberg@dewire.com>
References: <20080711043317.GD32633@spearce.org>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHF5H-000330-E8
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 11:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbYGKJhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 05:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbYGKJhh
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 05:37:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15242 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbYGKJhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 05:37:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E62BF8027F7;
	Fri, 11 Jul 2008 11:37:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1TwYJLd1nRH; Fri, 11 Jul 2008 11:37:34 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 08DD08006B7;
	Fri, 11 Jul 2008 11:37:34 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <20080711043317.GD32633@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88103>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/Activator.java         |   85 +++++++++++++++++++-
 1 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
index 3e02c44..89e6579 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
@@ -11,16 +11,20 @@ package org.spearce.egit.ui;
 import java.net.Authenticator;
 import java.net.ProxySelector;
 import java.util.HashSet;
+import java.util.Iterator;
+import java.util.LinkedHashSet;
 import java.util.Set;
 
 import org.eclipse.core.net.proxy.IProxyService;
 import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.IStatus;
 import org.eclipse.core.runtime.Platform;
 import org.eclipse.core.runtime.Status;
+import org.eclipse.core.runtime.SubProgressMonitor;
 import org.eclipse.core.runtime.jobs.ISchedulingRule;
 import org.eclipse.core.runtime.jobs.Job;
 import org.eclipse.jsch.core.IJSchService;
@@ -30,7 +34,10 @@ import org.eclipse.ui.themes.ITheme;
 import org.osgi.framework.BundleContext;
 import org.osgi.framework.ServiceReference;
 import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.lib.IndexChangedEvent;
+import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryListener;
 import org.spearce.jgit.transport.SshSessionFactory;
 
 /**
@@ -137,6 +144,7 @@ public class Activator extends AbstractUIPlugin {
 
 	private boolean traceVerbose;
 	private RCS rcs;
+	private RIRefresh refreshJob;
 
 	/**
 	 * Constructor for the egit ui plugin singleton
@@ -151,6 +159,71 @@ public class Activator extends AbstractUIPlugin {
 		setupSSH(context);
 		setupProxy(context);
 		setupRepoChangeScanner();
+		setupRepoIndexRefresh();
+	}
+
+	private void setupRepoIndexRefresh() {
+		refreshJob = new RIRefresh();
+		Repository.addAnyRepositoryChangedListener(refreshJob);
+	}
+
+	static class RIRefresh extends Job implements RepositoryListener {
+
+		RIRefresh() {
+			super("Git index refresh Job");
+		}
+
+		private Set<IProject> projectsToScan = new LinkedHashSet<IProject>();
+
+		@Override
+		protected IStatus run(IProgressMonitor monitor) {
+			IProject[] projects = ResourcesPlugin.getWorkspace().getRoot().getProjects();
+			monitor.beginTask("Refreshing git managed projects", projects.length);
+
+			while (projectsToScan.size() > 0) {
+				IProject p;
+				synchronized (projectsToScan) {
+					if (projectsToScan.size() == 0)
+						break;
+					Iterator<IProject> i = projectsToScan.iterator();
+					p = i.next();
+					i.remove();
+				}
+				ISchedulingRule rule = p.getWorkspace().getRuleFactory().refreshRule(p);
+				try {
+					getJobManager().beginRule(rule, monitor);
+					p.refreshLocal(IResource.DEPTH_INFINITE, new SubProgressMonitor(monitor, 1));
+				} catch (CoreException e) {
+					logError("Failed to refresh projects from index changes", e);
+					return new Status(IStatus.ERROR, getPluginId(), e.getMessage());
+				} finally {
+					getJobManager().endRule(rule);
+				}
+			}
+			monitor.done();
+			return Status.OK_STATUS;
+		}
+
+		public void indexChanged(IndexChangedEvent e) {
+			IProject[] projects = ResourcesPlugin.getWorkspace().getRoot().getProjects();
+			Set<IProject> toRefresh= new HashSet<IProject>();
+			for (IProject p : projects) {
+				RepositoryMapping mapping = RepositoryMapping.getMapping(p);
+				if (mapping != null && mapping.getRepository() == e.getRepository()) {
+					toRefresh.add(p);
+				}
+			}
+			synchronized (projectsToScan) {
+				projectsToScan.addAll(toRefresh);
+			}
+			if (projectsToScan.size() > 0)
+				schedule();
+		}
+
+		public void refsChanged(RefsChangedEvent e) {
+			// Do not react here
+		}
+
 	}
 
 	static class RCS extends Job {
@@ -236,10 +309,14 @@ public class Activator extends AbstractUIPlugin {
 
 	public void stop(final BundleContext context) throws Exception {
 		trace("Trying to cancel " + rcs.getName() + " job");
-		if (!rcs.cancel()) {
-			rcs.join();
-		}
-		trace("rcs.getName() " + rcs.getName() + " cancelled ok");
+		rcs.cancel();
+		trace("Trying to cancel " + refreshJob.getName() + " job");
+		refreshJob.cancel();
+
+		rcs.join();
+		refreshJob.join();
+
+		trace("Jobs terminated");
 		super.stop(context);
 		plugin = null;
 	}
-- 
1.5.6.2.220.g44701
