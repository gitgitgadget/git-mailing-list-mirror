From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/6] Teach the revision selection handler about the active repository
Date: Fri, 11 Jul 2008 00:39:31 +0200
Message-ID: <1215729573-26536-5-git-send-email-robin.rosenberg@dewire.com>
References: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-3-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4tl-0003md-DP
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbYGJWov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbYGJWot
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:44:49 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13087 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbYGJWoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:44:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 51EC68030BA;
	Fri, 11 Jul 2008 00:44:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJZtSodyTMmS; Fri, 11 Jul 2008 00:44:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6F39C827593;
	Fri, 11 Jul 2008 00:44:39 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729573-26536-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88023>

The handler needs to know which repository the selected revision was in.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/GitHistoryPage.java   |    4 ++++
 .../history/RevObjectSelectionProvider.java        |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index d8777ef..6b55185 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -503,6 +503,8 @@ public class GitHistoryPage extends HistoryPage {
 
 	@Override
 	public boolean inputSet() {
+		if (revObjectSelectionProvider != null)
+			revObjectSelectionProvider.setActiveRepository(null);
 		cancelRefreshJob();
 
 		if (graph == null)
@@ -589,9 +591,11 @@ public class GitHistoryPage extends HistoryPage {
 		list.source(currentWalk);
 
 		final GenerateHistoryJob rj = new GenerateHistoryJob(this, list);
+		final Repository fdb = db;
 		rj.addJobChangeListener(new JobChangeAdapter() {
 			@Override
 			public void done(final IJobChangeEvent event) {
+				revObjectSelectionProvider.setActiveRepository(fdb);
 				final Control graphctl = graph.getControl();
 				if (job != rj || graphctl.isDisposed())
 					return;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java
index c44b229..46a091c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java
@@ -14,6 +14,7 @@ import org.eclipse.jface.viewers.ISelection;
 import org.eclipse.jface.viewers.ISelectionChangedListener;
 import org.eclipse.jface.viewers.ISelectionProvider;
 import org.eclipse.jface.viewers.SelectionChangedEvent;
+import org.spearce.jgit.lib.Repository;
 
 /**
  * A selection provider for Git revision objects
@@ -24,6 +25,8 @@ public class RevObjectSelectionProvider implements ISelectionProvider {
 
 	private ISelection selection;
 
+	private Repository repository;
+
 	public void addSelectionChangedListener(ISelectionChangedListener listener) {
 		listeners.add(listener);
 	}
@@ -45,4 +48,20 @@ public class RevObjectSelectionProvider implements ISelectionProvider {
 		}
 	}
 
+	/**
+	 * Sets the active repository. This one is called by the view when the view
+	 * is updated with new data.
+	 *
+	 * @param repository
+	 */
+	public void setActiveRepository(Repository repository) {
+		this.repository = repository;
+	}
+
+	/**
+	 * @return currently active repository
+	 */
+	public Repository getActiveRepository() {
+		return repository;
+	}
 }
-- 
1.5.6.2.220.g44701
