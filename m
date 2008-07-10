From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 9/9] Attach the resource decorator to the repository change event mechanism
Date: Fri, 11 Jul 2008 00:40:51 +0200
Message-ID: <1215729651-26781-10-git-send-email-robin.rosenberg@dewire.com>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-4-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-5-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-6-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-7-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-8-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-9-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vY-0004Lo-KF
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbYGJWqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754426AbYGJWqV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13152 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbYGJWqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EE8E3147B7F5;
	Fri, 11 Jul 2008 00:46:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zhIdmrsk9iA3; Fri, 11 Jul 2008 00:46:04 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6E2A1802C0D;
	Fri, 11 Jul 2008 00:45:59 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729651-26781-9-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88039>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitResourceDecorator.java  |   29 +++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 0308f6a..dcb87b7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -10,6 +10,8 @@
 package org.spearce.egit.ui.internal.decorators;
 
 import java.io.IOException;
+import java.util.HashSet;
+import java.util.Set;
 
 import org.eclipse.core.resources.IContainer;
 import org.eclipse.core.resources.IFile;
@@ -38,7 +40,11 @@ import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.GitIndex;
+import org.spearce.jgit.lib.IndexChangedEvent;
+import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryChangedEvent;
+import org.spearce.jgit.lib.RepositoryListener;
 import org.spearce.jgit.lib.RepositoryState;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
@@ -61,7 +67,7 @@ public class GitResourceDecorator extends LabelProvider implements
 
 	private static final RCL myrcl = new RCL();
 
-	static class RCL implements RepositoryChangeListener, Runnable {
+	static class RCL implements RepositoryChangeListener, RepositoryListener, Runnable {
 		private boolean requested;
 
 		public synchronized void run() {
@@ -70,6 +76,26 @@ public class GitResourceDecorator extends LabelProvider implements
 					GitResourceDecorator.class.getName());
 		}
 
+		public void refsChanged(RefsChangedEvent e) {
+			repositoryChanged(e);
+		}
+
+		public void indexChanged(IndexChangedEvent e) {
+			repositoryChanged(e);
+		}
+
+		private void repositoryChanged(RepositoryChangedEvent e) {
+			Set<RepositoryMapping> ms = new HashSet<RepositoryMapping>();
+			for (IProject p : ResourcesPlugin.getWorkspace().getRoot().getProjects()) {
+				RepositoryMapping mapping = RepositoryMapping.getMapping(p);
+				if (mapping != null && mapping.getRepository() == e.getRepository())
+					ms.add(mapping);
+			}
+			for (RepositoryMapping m : ms) {
+				repositoryChanged(m);
+			}
+		}
+
 		public void repositoryChanged(final RepositoryMapping which) {
 			try {
 				which.getContainer().accept(new IResourceVisitor() {
@@ -139,6 +165,7 @@ public class GitResourceDecorator extends LabelProvider implements
 	static ResCL myrescl = new ResCL();
 
 	static {
+		Repository.addAnyRepositoryChangedListener(myrcl);
 		GitProjectData.addRepositoryChangeListener(myrcl);
 		ResourcesPlugin.getWorkspace().addResourceChangeListener(myrescl,
 				IResourceChangeEvent.POST_CHANGE);
-- 
1.5.6.2.220.g44701
