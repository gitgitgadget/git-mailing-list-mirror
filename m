From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Make the Eclipse plugin resource locking more friendly
Date: Wed, 11 Feb 2009 15:35:07 -0800
Message-ID: <1234395307-6754-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, Rob Clevenger <"r..."@google.com>,
	"Shawn O. Pearce" <sop@google.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 00:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXOdE-0003xa-N8
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 00:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbZBKXfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 18:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbZBKXfL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 18:35:11 -0500
Received: from george.spearce.org ([209.20.77.23]:48776 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbZBKXfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 18:35:10 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1D2AE38211; Wed, 11 Feb 2009 23:35:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 37C1F3819E;
	Wed, 11 Feb 2009 23:35:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109546>

From: Rob Clevenger <r...@google.com>

Using the default rule factory instead of the pessimistic one
makes it less likely that the UI will freeze in a modal dialog
while Eclipse goes off and does builds.

Signed-off-by: Rob Clevenger <r...@google.com>
Signed-off-by: Shawn O. Pearce <sop@google.com>
---
 .../src/org/spearce/egit/core/GitProvider.java     |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
index a16aca9..c7baf65 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
@@ -8,7 +8,9 @@
  *******************************************************************************/
 package org.spearce.egit.core;
 
+import org.eclipse.core.resources.IResourceRuleFactory;
 import org.eclipse.core.resources.team.IMoveDeleteHook;
+import org.eclipse.core.resources.team.ResourceRuleFactory;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.team.core.RepositoryProvider;
 import org.eclipse.team.core.history.IFileHistoryProvider;
@@ -25,6 +27,8 @@
 
 	private GitFileHistoryProvider historyProvider;
 
+	private final IResourceRuleFactory resourceRuleFactory = new GitResourceRuleFactory();
+
 	public String getID() {
 		return getClass().getName();
 	}
@@ -70,4 +74,14 @@ public synchronized IFileHistoryProvider getFileHistoryProvider() {
 		}
 		return historyProvider;
 	}
+
+	@Override
+	public IResourceRuleFactory getRuleFactory() {
+		return resourceRuleFactory;
+	}
+
+	private static class GitResourceRuleFactory extends ResourceRuleFactory {
+		// Use the default rule factory instead of the
+		// pessimistic one by default.
+	}
 }
-- 
1.6.2.rc0.204.gf6b427
