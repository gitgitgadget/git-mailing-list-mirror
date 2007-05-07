From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 09/10] Run history refresh in background
Date: Mon, 07 May 2007 23:30:04 +0200
Message-ID: <20070507213003.21546.89249.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAn6-00046J-6q
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966826AbXEGVaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966816AbXEGVai
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:30:38 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12282 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966826AbXEGVah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:30:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C5B90800783;
	Mon,  7 May 2007 23:24:30 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24816-04; Mon,  7 May 2007 23:24:30 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id EAE7E802676;
	Mon,  7 May 2007 23:24:29 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 8E7B8294E7;
	Mon,  7 May 2007 23:30:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id usi2rKi5ZMZE; Mon,  7 May 2007 23:30:21 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 166D52926D;
	Mon,  7 May 2007 23:30:04 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46491>

Don't wait in the UI for history refresh. If a history is being
computed when a new refresh is requested, abort the first one and
start a new history computation.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../egit/core/internal/mapping/GitFileHistory.java |   40 ++++++++-----
 .../internal/mapping/GitFileHistoryProvider.java   |    2 -
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   73 +++++++++++++++++------
 .../src/org/spearce/jgit/lib/Walker.java           |    4 +
 .../tst/org/spearce/jgit/lib/T0007_WalkerTest.java |    4 +
 5 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
index 4df98e6..9cf9107 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistory.java
@@ -27,6 +27,7 @@ import java.util.List;
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.IAdaptable;
+import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.team.core.RepositoryProvider;
 import org.eclipse.team.core.history.IFileHistoryProvider;
 import org.eclipse.team.core.history.IFileRevision;
@@ -52,7 +53,7 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 
 	private IFileRevision[] revisions;
 
-	public GitFileHistory(IResource resource, int flags) {
+	public GitFileHistory(IResource resource, int flags, IProgressMonitor monitor) {
 		this.resource = resource;
 		this.flags = flags;
 		String prefix = getRepositoryMapping().getSubset();
@@ -61,6 +62,15 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 		relativeResourceName = new String[prefixSegments.length + resourceSegments.length];
 		System.arraycopy(prefixSegments, 0, relativeResourceName, 0, prefixSegments.length);
 		System.arraycopy(resourceSegments, 0, relativeResourceName, prefixSegments.length, resourceSegments.length);
+		if ((flags & IFileHistoryProvider.SINGLE_LINE_OF_DESCENT) == 0) {
+			findSingleRevision(monitor);
+		} else {
+			try {
+				findRevisions(monitor);
+			} catch (IOException e) {
+				throw new Error(e);
+			}
+		}
 	}
 
 	public IFileRevision[] getContributors(IFileRevision revision) {
@@ -111,28 +121,24 @@ public class GitFileHistory extends FileHistory implements IAdaptable {
 
 static class EclipseWalker extends Walker {
 	IResource resource;
-	
-	EclipseWalker(Repository repository, Commit start, String[] relativeResourceName,boolean leafIsBlob,IResource resource,boolean followMainOnly, ObjectId lastActiveDiffId) {
+	private final IProgressMonitor monitor;
+
+	EclipseWalker(Repository repository, Commit start, String[] relativeResourceName,boolean leafIsBlob,IResource resource,boolean followMainOnly, ObjectId lastActiveDiffId, IProgressMonitor monitor) {
 		super(repository, start, relativeResourceName, leafIsBlob, followMainOnly, lastActiveDiffId);
 		this.resource = resource;
+		this.monitor = monitor;
 	}
 
 	protected void collect(Collection ret,Commit commit, int count) {
 		ret.add(new GitFileRevision(commit, resource, count));		
 	}
-	
+
+	public boolean isCancelled() {
+		return monitor.isCanceled();
+	}
 };
 
 	public IFileRevision[] getFileRevisions() {
-		if (revisions == null)
-			if ((flags & IFileHistoryProvider.SINGLE_LINE_OF_DESCENT) == 0)
-				findSingleRevision();
-			else
-				try {
-					findRevisions();
-				} catch (IOException e) {
-					throw new Error(e);
-				}
 		return revisions;
 	}
 
@@ -143,8 +149,9 @@ static class EclipseWalker extends Walker {
 	 * return the revision prior to the topmost patch, be it another patch or a
 	 * normal Git Commit. This is the revision in HEAD^. Otherwise we return the
 	 * revision in HEAD.
+	 * @param monitor 
 	 */
-	private void findSingleRevision() {
+	private void findSingleRevision(IProgressMonitor monitor) {
 		try {
 			Repository repository = getRepository();
 			ObjectId id = repository.resolve("HEAD");
@@ -177,7 +184,7 @@ static class EclipseWalker extends Walker {
 		}
 	}
 
-	private void findRevisions() throws IOException {
+	private void findRevisions(IProgressMonitor monitor) throws IOException {
 		RepositoryProvider provider = RepositoryProvider.getProvider(resource
 				.getProject());
 		if (provider instanceof GitProvider) {
@@ -203,7 +210,8 @@ static class EclipseWalker extends Walker {
 					resource.getType() == IResource.FILE, 
 					resource, 
 					(flags & IFileHistoryProvider.SINGLE_LINE_OF_DESCENT) == 0,
-					activeDiffLeafId);
+					activeDiffLeafId,
+					monitor);
 			Collection githistory = walker.collectHistory();
 			if (githistory.size() >0) {
 				if (resource.getType()==IResource.FILE) {
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
index 2d1050f..7ff1ef5 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/mapping/GitFileHistoryProvider.java
@@ -31,7 +31,7 @@ public class GitFileHistoryProvider extends FileHistoryProvider implements
 	public IFileHistory getFileHistoryFor(IResource resource, int flags,
 			IProgressMonitor monitor) {
 		// TODO: implement flags
-		return new GitFileHistory(resource, flags); // TODO: implement flags
+		return new GitFileHistory(resource, flags, monitor); // TODO: implement flags
 	}
 
 	public IFileRevision getWorkspaceFileRevision(IResource resource) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index ec200e2..57fefcc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -29,6 +29,10 @@ import org.eclipse.core.resources.IResourceChangeListener;
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IProgressMonitor;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.core.runtime.Status;
+import org.eclipse.core.runtime.jobs.Job;
 import org.eclipse.jface.action.IMenuListener;
 import org.eclipse.jface.action.IMenuManager;
 import org.eclipse.jface.action.MenuManager;
@@ -322,21 +326,22 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 
 	private Map appliedPatches;
 
-	class GitHistoryContentProvider implements ITreeContentProvider,
-			ILazyTreeContentProvider {
+	class HistoryRefreshJob extends Job {
 
-		public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
-			if (newInput == null)
-				return;
-			System.out.println("inputChanged(" + viewer + "," + oldInput + ","
-					+ newInput);
+		public HistoryRefreshJob(String name) {
+			super(name);
+		}
+
+		protected IStatus run(IProgressMonitor monitor) {
+			monitor = new NullProgressMonitor();
+			monitor.beginTask("UpdateHistory", IProgressMonitor.UNKNOWN);
 			IProject project = ((IResource) getInput()).getProject();
 			RepositoryProvider provider = RepositoryProvider
 					.getProvider(project);
 			RepositoryMapping repositoryMapping = ((GitProvider)provider).getData().getRepositoryMapping(project);
+			Map newappliedPatches = null;
 			try {
-				appliedPatches = null;
-				appliedPatches = repositoryMapping.getRepository().getAppliedPatches();
+				newappliedPatches = repositoryMapping.getRepository().getAppliedPatches();
 			} catch (IOException e) {
 				// TODO Auto-generated catch block
 				e.printStackTrace();
@@ -345,18 +350,48 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 					.getFileHistoryProvider();
 			IFileHistory fileHistoryFor = fileHistoryProvider
 					.getFileHistoryFor((IResource) getInput(),
-							IFileHistoryProvider.SINGLE_LINE_OF_DESCENT, null/* monitor */);
+							IFileHistoryProvider.SINGLE_LINE_OF_DESCENT, monitor);
 			fileRevisions = fileHistoryFor.getFileRevisions();
-			tree.removeAll();
-			tree.setItemCount(fileRevisions.length);
-			tree.setData(fileRevisions);
-			tree.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,true));
-			System.out.println("inputchanged, invoking refresh");
-			viewer.refresh();
+			
+			final Map fnewappliedPatches = newappliedPatches; 
+			tree.getDisplay().asyncExec(new Runnable() {
+			
+				public void run() {
+					tree.removeAll();
+					tree.setItemCount(fileRevisions.length);
+					tree.setData(fileRevisions);
+					tree.setLayoutData(new GridData(SWT.FILL,SWT.FILL,true,true));
+					System.out.println("inputchanged, invoking refresh");
+					viewer.refresh();
+					appliedPatches = fnewappliedPatches;
+					done(Status.OK_STATUS);
+				}
+			
+			});
+			return Status.OK_STATUS;
+		}
+		
+	}
+
+	HistoryRefreshJob historyRefreshJob = new HistoryRefreshJob("Git history refresh");
+	
+	class GitHistoryContentProvider implements ITreeContentProvider,
+			ILazyTreeContentProvider {
+
+		public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
+			if (newInput == null)
+				return;
+			System.out.println(new Date()+"inputChanged(" + viewer + "," + oldInput + ","
+					+ newInput);
+			if (historyRefreshJob.cancel()) {
+				System.out.println("rescheduling");
+				historyRefreshJob.schedule();
+			} else {
+				System.out.println("failed to cancel?");
+			}
 		}
 
 		public void dispose() {
-			// TODO Auto-generated method stub
 		}
 
 		public Object[] getElements(Object inputElement) {
@@ -380,12 +415,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		}
 
 		public void updateChildCount(Object element, int currentChildCount) {
-			viewer.setChildCount(element, fileRevisions.length);
+			viewer.setChildCount(element, fileRevisions!=null ? fileRevisions.length : 0);
 		}
 
 		public void updateElement(Object parent, int index) {
 			System.out.println("updateElement("+parent+","+index);
-			viewer.replace(parent, index, fileRevisions[index]);
+			viewer.replace(parent, index, fileRevisions!=null ? fileRevisions[index] : null);
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
index 86c8a1e..3c33274 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Walker.java
@@ -17,6 +17,8 @@ public abstract class Walker {
 	private ObjectId activeDiffLeafId;
 	private final Commit start;
 
+	protected abstract boolean isCancelled();
+	
 	protected abstract void collect(Collection ret,Commit commit, int count);
 
 	protected Walker(Repository repostory, Commit start, String[] relativeResourceName,boolean leafIsBlob,boolean followMainOnly, ObjectId activeDiffLeafId) {
@@ -126,7 +128,7 @@ public abstract class Walker {
 				current = null;
 			if (count>=0)
 				count++;
-		} while (current != null);
+		} while (current != null && !isCancelled());
 
 		return ret;
 	}
diff --git a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0007_WalkerTest.java b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0007_WalkerTest.java
index 82f0623..a41d707 100644
--- a/org.spearce.jgit/tst/org/spearce/jgit/lib/T0007_WalkerTest.java
+++ b/org.spearce.jgit/tst/org/spearce/jgit/lib/T0007_WalkerTest.java
@@ -42,6 +42,10 @@ public class T0007_WalkerTest extends SpeedTestBase {
 				System.out.println("Got: "+count+" "+commit.getCommitId());
 				ret.add(commit);
 			}
+
+			protected boolean isCancelled() {
+				return false;
+			}
 		
 		};
 		Commit[] history = (Commit[])walker.collectHistory().toArray(new Commit[0]);
