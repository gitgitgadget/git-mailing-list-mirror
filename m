From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/3] Use a job for the resource decorator
Date: Fri, 11 Jul 2008 00:41:06 +0200
Message-ID: <1215729668-26865-2-git-send-email-robin.rosenberg@dewire.com>
References: <1215729668-26865-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:48:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vb-0004Lo-5Z
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbYGJWqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbYGJWq2
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:28 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13183 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754346AbYGJWqR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6BAE1827593;
	Fri, 11 Jul 2008 00:46:16 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C0CHmlJsgG-i; Fri, 11 Jul 2008 00:46:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D6544802846;
	Fri, 11 Jul 2008 00:46:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729668-26865-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88043>

Scanning directories for changes is slow so we want to use
a background job. We also connect to the repository event mechanism

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitResourceDecorator.java  |  162 +++++++++++---------
 1 files changed, 92 insertions(+), 70 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index dcb87b7..c625ce6 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -11,6 +11,8 @@ package org.spearce.egit.ui.internal.decorators;
 
 import java.io.IOException;
 import java.util.HashSet;
+import java.util.Iterator;
+import java.util.LinkedHashSet;
 import java.util.Set;
 
 import org.eclipse.core.resources.IContainer;
@@ -25,14 +27,19 @@ import org.eclipse.core.resources.IResourceVisitor;
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.IAdaptable;
+import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.IStatus;
 import org.eclipse.core.runtime.QualifiedName;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.core.runtime.jobs.ISchedulingRule;
+import org.eclipse.core.runtime.jobs.Job;
 import org.eclipse.jface.viewers.IDecoration;
 import org.eclipse.jface.viewers.ILightweightLabelDecorator;
 import org.eclipse.jface.viewers.LabelProvider;
 import org.eclipse.jface.viewers.LabelProviderChangedEvent;
 import org.eclipse.swt.widgets.Display;
 import org.eclipse.team.core.Team;
-import org.eclipse.ui.PlatformUI;
+import org.eclipse.ui.IDecoratorManager;
 import org.spearce.egit.core.project.GitProjectData;
 import org.spearce.egit.core.project.RepositoryChangeListener;
 import org.spearce.egit.core.project.RepositoryMapping;
@@ -65,17 +72,24 @@ import org.spearce.jgit.lib.GitIndex.Entry;
 public class GitResourceDecorator extends LabelProvider implements
 		ILightweightLabelDecorator {
 
-	private static final RCL myrcl = new RCL();
+	static final String decoratorId = "org.spearce.egit.ui.internal.decorators.GitResourceDecorator";
+	static class ResCL extends Job implements IResourceChangeListener, RepositoryChangeListener, RepositoryListener {
 
-	static class RCL implements RepositoryChangeListener, RepositoryListener, Runnable {
-		private boolean requested;
+		ResCL() {
+			super("Git resource decorator trigger");
+		}
 
-		public synchronized void run() {
-			requested = false;
-			PlatformUI.getWorkbench().getDecoratorManager().update(
-					GitResourceDecorator.class.getName());
+		GitResourceDecorator getActiveDecorator() {
+			IDecoratorManager decoratorManager = Activator.getDefault()
+					.getWorkbench().getDecoratorManager();
+			if (decoratorManager.getEnabled(decoratorId))
+				return (GitResourceDecorator) decoratorManager
+						.getLightweightLabelDecorator(decoratorId);
+			return null;
 		}
 
+		private Set<IResource> resources = new LinkedHashSet<IResource>();
+
 		public void refsChanged(RefsChangedEvent e) {
 			repositoryChanged(e);
 		}
@@ -97,76 +111,87 @@ public class GitResourceDecorator extends LabelProvider implements
 		}
 
 		public void repositoryChanged(final RepositoryMapping which) {
-			try {
-				which.getContainer().accept(new IResourceVisitor() {
-					public boolean visit(IResource resource) throws CoreException {
-						if (resource instanceof IContainer)
-							clearDecorationState(resource);
-						return true;
-					}
-				});
-			} catch (CoreException e) {
-				// TODO Auto-generated catch block
-				e.printStackTrace();
+			synchronized (resources) {
+				resources.add(which.getContainer());
 			}
-			start();
+			schedule();
 		}
 
-		synchronized void start() {
-			if (requested)
-				return;
-			final Display d = PlatformUI.getWorkbench().getDisplay();
-			if (d.getThread() == Thread.currentThread())
-				run();
-			else {
-				requested = true;
-				d.asyncExec(this);
+		@Override
+		protected IStatus run(IProgressMonitor arg0) {
+			try {
+				if (resources.size() > 0) {
+					IResource m;
+					synchronized(resources) {
+						Iterator<IResource> i = resources.iterator();
+						m = i.next();
+						i.remove();
+						if (resources.size() > 0)
+							schedule();
+					}
+					ISchedulingRule markerRule = m.getWorkspace().getRuleFactory().markerRule(m);
+					getJobManager().beginRule(markerRule, arg0);
+					try {
+						m.accept(new IResourceVisitor() {
+							public boolean visit(IResource resource) throws CoreException {
+								getActiveDecorator().clearDecorationState(resource);
+								return true;
+							}
+						});
+					} finally {
+						getJobManager().endRule(markerRule);
+					}
+				}
+				return Status.OK_STATUS;
+			} catch (Exception e) {
+				return new Status(IStatus.ERROR, Activator.getPluginId(), "Failed to trigger resource decoration", e);
 			}
 		}
-	}
 
-	static class ResCL implements IResourceChangeListener {
 		public void resourceChanged(IResourceChangeEvent event) {
 			if (event.getType() != IResourceChangeEvent.POST_CHANGE) {
 				return;
 			}
 			try {
 				event.getDelta().accept(new IResourceDeltaVisitor() {
-
 					public boolean visit(IResourceDelta delta)
 							throws CoreException {
 						for (IResource r = delta.getResource(); r.getType() != IResource.ROOT; r = r
 								.getParent()) {
-							try {
-								clearDecorationState(r);
-							} catch (CoreException e) {
-								// TODO Auto-generated catch block
-								e.printStackTrace();
+							synchronized (resources) {
+								resources.add(r);
 							}
 						}
 						return true;
 					}
-
 				});
-			} catch (CoreException e2) {
-				// TODO Auto-generated catch block
-				e2.printStackTrace();
-				return;
+			} catch (Exception e) {
+				Activator.logError("Problem during decorations. Stopped", e);
 			}
-			myrcl.start();
+			schedule();
 		}
-	}
 
-	static void clearDecorationState(IResource r) throws CoreException {
+		void force() {
+			for (IProject p : ResourcesPlugin.getWorkspace().getRoot().getProjects()) {
+				synchronized (resources) {
+					resources.add(p);
+				}
+			}
+			schedule();
+		}
+	} // End ResCL
+
+	void clearDecorationState(IResource r) throws CoreException {
 		if (r.isAccessible())
 			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
+		fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
 	}
 
 	static ResCL myrescl = new ResCL();
 
 	static {
-		Repository.addAnyRepositoryChangedListener(myrcl);
-		GitProjectData.addRepositoryChangeListener(myrcl);
+		Repository.addAnyRepositoryChangedListener(myrescl);
+		GitProjectData.addRepositoryChangeListener(myrescl);
 		ResourcesPlugin.getWorkspace().addResourceChangeListener(myrescl,
 				IResourceChangeEvent.POST_CHANGE);
 	}
@@ -179,7 +204,7 @@ public class GitResourceDecorator extends LabelProvider implements
 	 * </p>
 	 */
 	public static void refresh() {
-		myrcl.start();
+		myrescl.force();
 	}
 
 	private static IResource toIResource(final Object e) {
@@ -368,36 +393,33 @@ public class GitResourceDecorator extends LabelProvider implements
 
 		try {
 			Integer dirty = (Integer) rsrc.getSessionProperty(GITFOLDERDIRTYSTATEPROPERTY);
+			Runnable runnable = new Runnable() {
+				public void run() {
+					// Async could be called after a
+					// project is closed or a
+					// resource is deleted
+					if (!rsrc.isAccessible())
+						return;
+					fireLabelProviderChanged(new LabelProviderChangedEvent(
+							GitResourceDecorator.this, rsrc));
+				}
+			};
 			if (dirty == null) {
 				rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, new Integer(flag));
 				orState(rsrc.getParent(), flag);
-				Display.getDefault().asyncExec(new Runnable() {
-					public void run() {
-						// Async could be called after a
-						// project is closed or a
-						// resource is deleted
-						if (!rsrc.isAccessible())
-							return;
-						fireLabelProviderChanged(new LabelProviderChangedEvent(
-								GitResourceDecorator.this, rsrc));
-					}
-				});
+//				if (Thread.currentThread() == Display.getDefault().getThread())
+//					runnable.run();
+//				else
+					Display.getDefault().asyncExec(runnable);
 			} else {
 				if ((dirty.intValue() | flag) != dirty.intValue()) {
 					dirty = new Integer(dirty.intValue() | flag);
 					rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, dirty);
 					orState(rsrc.getParent(), dirty.intValue());
-					Display.getDefault().asyncExec(new Runnable() {
-						public void run() {
-							// Async could be called after a
-							// project is closed or a
-							// resource is deleted
-							if (!rsrc.isAccessible())
-								return;
-							fireLabelProviderChanged(new LabelProviderChangedEvent(
-									GitResourceDecorator.this, rsrc));
-						}
-					});
+//					if (Thread.currentThread() == Display.getDefault().getThread())
+//						runnable.run();
+//					else
+						Display.getDefault().asyncExec(runnable);
 				}
 			}
 		} catch (CoreException e) {
-- 
1.5.6.2.220.g44701
