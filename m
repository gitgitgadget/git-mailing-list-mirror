From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/9] Connect the history page to the refs update subscription mechanism
Date: Fri, 11 Jul 2008 00:40:45 +0200
Message-ID: <1215729651-26781-4-git-send-email-robin.rosenberg@dewire.com>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vT-0004Lo-TN
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbYGJWqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbYGJWqE
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:04 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13119 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754188AbYGJWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C0E11147B7EE;
	Fri, 11 Jul 2008 00:45:59 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hq+ENnmrTojT; Fri, 11 Jul 2008 00:45:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 22E0A802E18;
	Fri, 11 Jul 2008 00:45:58 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88034>

Now the history page can get updated automatically without polling.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/GitHistoryPage.java   |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index 7e2f726..418f3b6 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -168,6 +168,9 @@ public class GitHistoryPage extends HistoryPage implements RepositoryListener {
 	/** Last HEAD */
 	private AnyObjectId currentHeadId;
 
+	/** We need to remember the current repository */
+	private Repository db;
+
 	/**
 	 * Highlight flag that can be applied to commits to make them stand out.
 	 * <p>
@@ -536,6 +539,9 @@ public class GitHistoryPage extends HistoryPage implements RepositoryListener {
 			revObjectSelectionProvider.setActiveRepository(null);
 		cancelRefreshJob();
 
+		if (db != null)
+			db.removeRepositoryChangedListener(this);
+
 		if (graph == null)
 			return false;
 
@@ -543,7 +549,8 @@ public class GitHistoryPage extends HistoryPage implements RepositoryListener {
 		if (in == null || in.length == 0)
 			return false;
 
-		Repository db = null;
+		db = null;
+
 		final ArrayList<String> paths = new ArrayList<String>(in.length);
 		for (final IResource r : in) {
 			final RepositoryMapping map = RepositoryMapping.getMapping(r);
@@ -563,6 +570,8 @@ public class GitHistoryPage extends HistoryPage implements RepositoryListener {
 		if (db == null)
 			return false;
 
+		db.addRepositoryChangedListener(this);
+
 		final AnyObjectId headId;
 		try {
 			headId = db.resolve("HEAD");
-- 
1.5.6.2.220.g44701
