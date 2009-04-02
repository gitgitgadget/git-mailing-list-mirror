From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/5] Move dcocument to repository mapping to GitDocument
Date: Thu,  2 Apr 2009 20:46:29 +0200
Message-ID: <1238697991-12990-4-git-send-email-robin.rosenberg@dewire.com>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-2-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 02 20:52:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRxi-00078a-VN
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbZDBSqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 14:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756492AbZDBSqv
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:46:51 -0400
Received: from mail.dewire.com ([83.140.172.130]:5494 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754392AbZDBSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 14:46:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B62821484141;
	Thu,  2 Apr 2009 20:46:46 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SGx4WeSrtQVU; Thu,  2 Apr 2009 20:46:45 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 35CE61488983;
	Thu,  2 Apr 2009 20:46:45 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.1.345.g89fb
In-Reply-To: <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115483>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/decorators/GitDocument.java   |   23 ++++++++++++++++++-
 .../internal/decorators/GitQuickDiffProvider.java  |    8 +------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index 69e9295..8c82a55 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -1,5 +1,5 @@
 /*******************************************************************************
- * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, 2009 Robin Rosenberg <robin.rosenberg@dewire.com>
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -8,6 +8,8 @@
 package org.spearce.egit.ui.internal.decorators;
 
 import java.io.IOException;
+import java.util.Map;
+import java.util.WeakHashMap;
 
 import org.eclipse.core.resources.IEncodedStorage;
 import org.eclipse.core.resources.IProject;
@@ -29,6 +31,7 @@
 
 class GitDocument extends Document implements RepositoryListener {
 	private final IResource resource;
+	static Map<GitDocument,Repository> doc2repo = new WeakHashMap<GitDocument, Repository>();
 
 	static GitDocument create(final IResource resource) throws IOException {
 		GitDocument ret = null;
@@ -44,7 +47,7 @@ static GitDocument create(final IResource resource) throws IOException {
 
 	private GitDocument(IResource resource) {
 		this.resource = resource;
-		GitQuickDiffProvider.doc2repo.put(this, getRepository());
+		GitDocument.doc2repo.put(this, getRepository());
 	}
 
 	void populate() throws IOException {
@@ -95,6 +98,7 @@ void populate() throws IOException {
 	}
 
 	void dispose() {
+		doc2repo.remove(this);
 		Repository repository = getRepository();
 		if (repository != null)
 			repository.removeRepositoryChangedListener(this);
@@ -119,4 +123,19 @@ private Repository getRepository() {
 			return mapping.getRepository();
 		return null;
 	}
+
+	/**
+	 * A change occurred to a repository. Update any GitDocument instances
+	 * referring to such repositories.
+	 * 
+	 * @param repository Repository which changed 
+	 * @throws IOException
+	 */
+	static void refreshRelevant(final Repository repository) throws IOException {
+		for (Map.Entry<GitDocument, Repository> i : doc2repo.entrySet()) {
+			if (i.getValue() == repository) {
+				i.getKey().populate();
+			}
+		}
+	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
index 88f5ea0..6c71f3c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
@@ -37,7 +37,6 @@
 	private IResource resource;
 
 	static Map<Repository,String> baseline = new WeakHashMap<Repository,String>();
-	static Map<GitDocument,Repository> doc2repo = new WeakHashMap<GitDocument, Repository>();
 
 	/**
 	 * Create the GitQuickDiffProvider instance
@@ -48,7 +47,6 @@ public GitQuickDiffProvider() {
 
 	public void dispose() {
 		Activator.trace("(GitQuickDiffProvider) dispose");
-		doc2repo.remove(document);
 		if (document != null)
 			document.dispose();
 	}
@@ -96,11 +94,7 @@ public void setId(String id) {
 	 */
 	public static void setBaselineReference(final Repository repository, final String baseline) throws IOException {
 		GitQuickDiffProvider.baseline.put(repository, baseline);
-		for (Map.Entry<GitDocument, Repository> i : doc2repo.entrySet()) {
-			if (i.getValue() == repository) {
-				i.getKey().populate();
-			}
-		}
+		GitDocument.refreshRelevant(repository);
 	}
 
 }
-- 
1.6.2.1.345.g89fb
