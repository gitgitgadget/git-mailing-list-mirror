From: Tomi Pakarinen <tomi.pakarinen@iki.fi>
Subject: [EGIT PATCH] git property page for project properties.
Date: Mon, 20 Oct 2008 22:06:44 +0300
Message-ID: <1224529604-42397-1-git-send-email-tomi.pakarinen@iki.fi>
Cc: git@vger.kernel.org, Tomi Pakarinen <tomi.pakarinen@iki.fi>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Oct 20 22:31:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks06j-0007ky-Pn
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 21:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYJTTGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbYJTTGr
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 15:06:47 -0400
Received: from smtp5.pp.htv.fi ([213.243.153.39]:37691 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbYJTTGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 15:06:46 -0400
Received: from localhost.localdomain (cs27046087.pp.htv.fi [89.27.46.87])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 855325BC121;
	Mon, 20 Oct 2008 22:06:44 +0300 (EEST)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98700>

 Show git property page in project's properties, if project
has git repository provider.

Signed-off-by: Tomi Pakarinen <tomi.pakarinen@iki.fi>
---

 This is similar to CVS's property page. Current
information on page is very limited and non editable.

 Tomi.

 org.spearce.egit.ui/plugin.properties              |    2 +
 org.spearce.egit.ui/plugin.xml                     |   13 ++
 .../preferences/GitProjectPropertyPage.java        |  147 ++++++++++++++++++++
 3 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index da91e48..fa043f1 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -1,6 +1,8 @@
 plugin_name=Git Team Provider (UI)
 provider_name=spearce.org
 
+Git=Git
+
 Git_clone_category=Git
 Git_clone_wizard=Git Repository
 Git_clone_description=Clone an existing Git repository.
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index ee8a5a0..e6e3762 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -194,6 +194,19 @@
             id="org.spearce.egit.ui.internal.preferences.WindowCachePreferencePage" />
    </extension>
 
+   <extension point="org.eclipse.ui.propertyPages">
+      <page
+            objectClass="org.eclipse.core.resources.IProject"
+            adaptable="true"
+            name="%Git"
+            class="org.spearce.egit.ui.internal.preferences.GitProjectPropertyPage"
+            id="org.spearce.egit.ui.preferences.GitProjectPropertyPage">
+         <filter
+               name="projectPersistentProperty"
+               value="org.eclipse.team.core.repository=org.spearce.egit.core.GitProvider">
+         </filter>
+      </page>
+   </extension>
    <extension point="org.eclipse.ui.decorators">
       <decorator
             lightweight="true"
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java
new file mode 100644
index 0000000..fd7e14a
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/GitProjectPropertyPage.java
@@ -0,0 +1,147 @@
+/*******************************************************************************
+ * Copyright (C) 2008, Tomi Pakarinen <tomi.pakarinen@iki.fi>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * See LICENSE for the full license text, also available.
+ *******************************************************************************/
+package org.spearce.egit.ui.internal.preferences;
+
+import java.io.IOException;
+
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.runtime.IAdaptable;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Display;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.swt.widgets.Text;
+import org.eclipse.ui.dialogs.PropertyPage;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * Property page to be shown in project properties, if project is shared using
+ * git provider. Currently there aren't any modifiable element.
+ */
+public class GitProjectPropertyPage extends PropertyPage {
+
+	Text gitDir;
+
+	Text branch;
+
+	Text id;
+
+	Text state;
+
+	Text workDir;
+
+	@Override
+	protected Control createContents(Composite parent) {
+		final Composite composite = new Composite(parent, SWT.NULL);
+
+		composite.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true));
+		final GridLayout layout = new GridLayout();
+		layout.numColumns = 2;
+		layout.marginHeight = 0;
+		layout.marginWidth = 0;
+		layout.horizontalSpacing = 0;
+		layout.verticalSpacing = 0;
+		composite.setLayout(layout);
+
+		gitDir = createLabeledReadOnlyText(composite, "Git directory:");
+		workDir = createLabeledReadOnlyText(composite, "Working directory:");
+		branch = createLabeledReadOnlyText(composite, "Branch:");
+		id = createLabeledReadOnlyText(composite, "Id:");
+		state = createLabeledReadOnlyText(composite, "Current state:");
+
+		// Get the project that is the source of this property page
+		IProject project = null;
+		final IAdaptable element = getElement();
+		if (element instanceof IProject) {
+			project = (IProject) element;
+		} else {
+			Object adapter = element.getAdapter(IProject.class);
+			if (adapter instanceof IProject) {
+				project = (IProject) adapter;
+			}
+		}
+
+		Repository repository = RepositoryMapping.getMapping(project)
+				.getRepository();
+
+		if (repository != null) {
+			try {
+				fillValues(repository);
+			} catch (IOException e) {
+				e.printStackTrace();
+			}
+		}
+
+		return composite;
+	}
+
+	private void fillValues(Repository repository) throws IOException {
+		gitDir.setText(repository.getDirectory().getAbsolutePath());
+		branch.setText(repository.getBranch());
+		workDir.setText(repository.getWorkDir().getAbsolutePath());
+
+		switch (repository.getRepositoryState()) {
+		case BISECTING:
+			state.setText("Bisecting");
+			break;
+		case MERGING:
+			state.setText("Merging");
+			break;
+		case REBASING:
+			state.setText("Rebasing");
+			break;
+		case REBASING_INTERACTIVE:
+			state.setText("Rebasing interactive");
+			break;
+		case REBASING_MERGE:
+			state.setText("Rebasing merge");
+			break;
+		case SAFE:
+			state.setText("Safe");
+			break;
+		}
+
+		final ObjectId objectId = repository
+				.resolve(repository.getFullBranch());
+		id.setText(objectId.name());
+	}
+
+	/**
+	 * Create a read only text field with a label
+	 * 
+	 * @param parent
+	 *            the parent composite for new widgets
+	 * @param labelText
+	 *            text for label
+	 * @return the new read only text field
+	 */
+	protected Text createLabeledReadOnlyText(Composite parent,
+			final String labelText) {
+		Label label = new Label(parent, SWT.LEFT);
+		label.setText(labelText);
+		GridData data = new GridData();
+		data.horizontalSpan = 1;
+		data.horizontalAlignment = GridData.FILL;
+		label.setLayoutData(data);
+
+		Text text = new Text(parent, SWT.LEFT | SWT.READ_ONLY);
+		text.setBackground(Display.getDefault().getSystemColor(
+				SWT.COLOR_WIDGET_BACKGROUND));
+		data = new GridData();
+		data.horizontalSpan = 1;
+		data.horizontalAlignment = GridData.FILL;
+		text.setLayoutData(data);
+		return text;
+	}
+
+}
-- 
1.6.0.2
