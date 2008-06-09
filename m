From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Reset the graph plotter internals when HEAD has changed.
Date: Tue, 10 Jun 2008 00:50:10 +0200
Message-ID: <1213051816-4046-2-git-send-email-robin.rosenberg.lists@dewire.com>
References: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 00:54:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qGD-0001Eo-NC
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 00:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbYFIWx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 18:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbYFIWx0
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 18:53:26 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17218 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755604AbYFIWxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 18:53:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D633A1434DE3;
	Tue, 10 Jun 2008 00:53:23 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id btbSsQYcZdwa; Tue, 10 Jun 2008 00:53:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id C54D58030B5;
	Tue, 10 Jun 2008 00:53:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84440>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

When we reset HEAD to an old revision it becomes more visible than when
we add a new commit. This is an intermediate solution.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index 27cda08..278e1e4 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -162,6 +162,9 @@ public class GitHistoryPage extends HistoryPage {
 	/** Revision walker that allocated our graph's commit nodes. */
 	private SWTWalk currentWalk;
 
+	/** Last HEAD */
+	private AnyObjectId currentHeadId;
+
 	/**
 	 * Highlight flag that can be applied to commits to make them stand out.
 	 * <p>
@@ -521,8 +524,18 @@ public class GitHistoryPage extends HistoryPage {
 		if (db == null)
 			return false;
 
+		final AnyObjectId headId;
+		try {
+			headId = db.resolve("HEAD");
+		} catch (IOException e) {
+			Activator.logError("Cannot parse HEAD in: "
+					+ db.getDirectory().getAbsolutePath(), e);
+			return false;
+		}
+
 		if (currentWalk == null || currentWalk.getRepository() != db
-				|| pathChange(pathFilters, paths)) {
+				|| pathChange(pathFilters, paths)
+				|| headId != null && !headId.equals(currentHeadId)) {
 			currentWalk = new SWTWalk(db);
 			currentWalk.sort(RevSort.COMMIT_TIME_DESC, true);
 			currentWalk.sort(RevSort.BOUNDARY, true);
@@ -531,13 +544,12 @@ public class GitHistoryPage extends HistoryPage {
 			currentWalk.reset();
 		}
 
+		if (headId == null)
+			return false;
 		try {
-			final AnyObjectId headId = db.resolve("HEAD");
-			if (headId == null)
-				return false;
 			currentWalk.markStart(currentWalk.parseCommit(headId));
 		} catch (IOException e) {
-			Activator.logError("Cannot parse HEAD in: "
+			Activator.logError("Cannot read HEAD commit " + headId + " in: "
 					+ db.getDirectory().getAbsolutePath(), e);
 			return false;
 		}
-- 
1.5.5.1.178.g1f811
