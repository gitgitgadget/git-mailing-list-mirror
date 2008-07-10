From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/6] Create a selection handler for the revision graph.
Date: Fri, 11 Jul 2008 00:39:28 +0200
Message-ID: <1215729573-26536-2-git-send-email-robin.rosenberg@dewire.com>
References: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4tk-0003md-35
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbYGJWoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbYGJWoq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:44:46 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13076 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754016AbYGJWom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:44:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8EE9B802E18;
	Fri, 11 Jul 2008 00:44:41 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RO3SyjHVcN-i; Fri, 11 Jul 2008 00:44:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id E6373802C0D;
	Fri, 11 Jul 2008 00:44:38 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88022>

This make it possible to associate content menu contributions
with selections in the history graph.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/GitHistoryPage.java   |   11 ++++-
 .../history/RevObjectSelectionProvider.java        |   48 ++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index 9bcae19..6eaa6e4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -181,6 +181,11 @@ public class GitHistoryPage extends HistoryPage {
 	 */
 	private List<String> pathFilters;
 
+	/**
+	 * The selection provider tracks the selected revisions for the context menu
+	 */
+	private RevObjectSelectionProvider revObjectSelectionProvider;
+
 	@Override
 	public void createControl(final Composite parent) {
 		GridData gd;
@@ -211,6 +216,7 @@ public class GitHistoryPage extends HistoryPage {
 		layoutSashForm(graphDetailSplit, SPLIT_GRAPH);
 		layoutSashForm(revInfoSplit, SPLIT_INFO);
 
+		revObjectSelectionProvider = new RevObjectSelectionProvider();
 		popupMgr = new MenuManager(null, POPUP_ID);
 		attachCommitSelectionChanged();
 		createLocalToolbarActions();
@@ -221,7 +227,6 @@ public class GitHistoryPage extends HistoryPage {
 		attachContextMenu(graph.getControl());
 		attachContextMenu(commentViewer.getControl());
 		attachContextMenu(fileViewer.getControl());
-
 		layout();
 	}
 
@@ -229,7 +234,8 @@ public class GitHistoryPage extends HistoryPage {
 		popupMgr.add(new Separator());
 		popupMgr.add(new Separator(IWorkbenchActionConstants.MB_ADDITIONS));
 		getSite().registerContextMenu(POPUP_ID, popupMgr,
-				getSite().getSelectionProvider());
+				revObjectSelectionProvider);
+		getSite().setSelectionProvider(revObjectSelectionProvider);
 	}
 
 	private void attachContextMenu(final Control c) {
@@ -299,6 +305,7 @@ public class GitHistoryPage extends HistoryPage {
 				c = (PlotCommit<?>) sel.getFirstElement();
 				commentViewer.setInput(c);
 				fileViewer.setInput(c);
+				revObjectSelectionProvider.setSelection(s);
 			}
 		});
 		commentViewer
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java
new file mode 100644
index 0000000..c44b229
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevObjectSelectionProvider.java
@@ -0,0 +1,48 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.history;
+
+import java.util.ArrayList;
+import java.util.List;
+
+import org.eclipse.jface.viewers.ISelection;
+import org.eclipse.jface.viewers.ISelectionChangedListener;
+import org.eclipse.jface.viewers.ISelectionProvider;
+import org.eclipse.jface.viewers.SelectionChangedEvent;
+
+/**
+ * A selection provider for Git revision objects
+ */
+public class RevObjectSelectionProvider implements ISelectionProvider {
+
+	private List<ISelectionChangedListener> listeners = new ArrayList<ISelectionChangedListener>();
+
+	private ISelection selection;
+
+	public void addSelectionChangedListener(ISelectionChangedListener listener) {
+		listeners.add(listener);
+	}
+
+	public ISelection getSelection() {
+		return selection;
+	}
+
+	public void removeSelectionChangedListener(
+			ISelectionChangedListener listener) {
+		listeners.remove(listener);
+	}
+
+	public void setSelection(ISelection selection) {
+		this.selection = selection;
+		SelectionChangedEvent event = new SelectionChangedEvent(this, selection);
+		for (ISelectionChangedListener l : listeners) {
+			l.selectionChanged(event);
+		}
+	}
+
+}
-- 
1.5.6.2.220.g44701
