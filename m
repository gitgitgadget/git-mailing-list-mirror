From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/6] Create baseclasses for actions and operations on RevObjects
Date: Fri, 11 Jul 2008 00:39:32 +0200
Message-ID: <1215729573-26536-6-git-send-email-robin.rosenberg@dewire.com>
References: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-3-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-4-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4tm-0003md-1o
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYGJWox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbYGJWow
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:44:52 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13091 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754017AbYGJWoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:44:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2D2238030C5;
	Fri, 11 Jul 2008 00:44:44 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UwoOG+YS3O5x; Fri, 11 Jul 2008 00:44:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id DE68D147B7EC;
	Fri, 11 Jul 2008 00:44:39 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729573-26536-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88024>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/actions/AbstractOperationAction.java  |   15 +++++++----
 .../internal/actions/AbstractRevObjectAction.java  |   26 ++++++++++++++++++++
 .../actions/AbstractRevObjectOperation.java        |   21 ++++++++++++++++
 3 files changed, 57 insertions(+), 5 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectOperation.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
index be6d0d5..52f60f5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractOperationAction.java
@@ -32,11 +32,20 @@ import org.spearce.egit.ui.UIText;
  * Common functionality for EGit operations.
  */
 public abstract class AbstractOperationAction implements IObjectActionDelegate {
-	private IWorkbenchPart wp;
+	/**
+	 * The active workbench part
+	 */
+	protected IWorkbenchPart wp;
 
 	private IWorkspaceRunnable op;
 
 	public void selectionChanged(final IAction act, final ISelection sel) {
+		// work performed in setActivePart
+	}
+
+	public void setActivePart(final IAction act, final IWorkbenchPart part) {
+		wp = part;
+		ISelection sel = part.getSite().getPage().getSelection();
 		final List selection;
 		if (sel instanceof IStructuredSelection && !sel.isEmpty()) {
 			selection = ((IStructuredSelection) sel).toList();
@@ -47,10 +56,6 @@ public abstract class AbstractOperationAction implements IObjectActionDelegate {
 		act.setEnabled(op != null && wp != null);
 	}
 
-	public void setActivePart(final IAction act, final IWorkbenchPart part) {
-		wp = part;
-	}
-
 	/**
 	 * Instantiate an operation on an action on provided objects.
 	 *
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectAction.java
new file mode 100644
index 0000000..b7f4285
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectAction.java
@@ -0,0 +1,26 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import org.spearce.egit.ui.internal.history.RevObjectSelectionProvider;
+import org.spearce.jgit.lib.Repository;
+
+abstract class AbstractRevObjectAction extends AbstractOperationAction {
+
+	/**
+	 * Find out which repository is involved here
+	 *
+	 * @return the Git repository associated with the selected RevObject
+	 */
+	protected Repository getActiveRepository() {
+		RevObjectSelectionProvider selectionProvider = (RevObjectSelectionProvider) wp
+				.getSite().getSelectionProvider();
+		return selectionProvider.getActiveRepository();
+	}
+
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectOperation.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectOperation.java
new file mode 100644
index 0000000..0c5d570
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/AbstractRevObjectOperation.java
@@ -0,0 +1,21 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.actions;
+
+import org.eclipse.core.resources.IWorkspaceRunnable;
+import org.spearce.jgit.lib.Repository;
+
+abstract class AbstractRevObjectOperation implements IWorkspaceRunnable {
+
+	Repository repository;
+
+	AbstractRevObjectOperation(final Repository repository) {
+		this.repository = repository;
+	}
+
+}
-- 
1.5.6.2.220.g44701
