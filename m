From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 07/10] Set a nice reflog message in the branch command
Date: Thu, 28 May 2009 00:08:54 +0200
Message-ID: <1243462137-24133-8-git-send-email-robin.rosenberg@dewire.com>
References: <20090520221651.GR30527@spearce.org>
 <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-5-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-7-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 28 00:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RJl-0005Vu-Gw
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757961AbZE0WJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758089AbZE0WJk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:09:40 -0400
Received: from mail.dewire.com ([83.140.172.130]:25365 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757636AbZE0WJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:09:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B1051145D123;
	Thu, 28 May 2009 00:09:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhm9NQcQh8kM; Thu, 28 May 2009 00:09:35 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 7F43B145D134;
	Thu, 28 May 2009 00:09:00 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1243462137-24133-7-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120117>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/Branch.java           |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index 11002f0..dbe297e 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
@@ -98,12 +98,18 @@ protected void run() throws Exception {
 
 			if (branches.size() > 0) {
 				String newHead = branches.get(0);
-				ObjectId startAt;
+				String startBranch;
 				if (branches.size() == 2)
-					startAt = db.resolve(branches.get(1) + "^0");
+					startBranch = branches.get(1);
 				else
-					startAt = db.resolve(Constants.HEAD + "^0");
-
+					startBranch = Constants.HEAD;
+				Ref startRef = db.getRef(startBranch);
+				ObjectId startAt = db.resolve(startBranch + "^0");
+				if (startRef != null)
+					startBranch = startRef.getName();
+				else
+					startBranch = startAt.name();
+				startBranch = db.shortenRefName(startBranch);
 				String newRefName = newHead;
 				if (!newRefName.startsWith(Constants.R_HEADS))
 					newRefName = Constants.R_HEADS + newRefName;
@@ -114,6 +120,7 @@ protected void run() throws Exception {
 				RefUpdate updateRef = db.updateRef(newRefName);
 				updateRef.setNewObjectId(startAt);
 				updateRef.setForceUpdate(createForce);
+				updateRef.setRefLogMessage("branch: Created from " + startBranch, false);
 				Result update = updateRef.update();
 				if (update == Result.REJECTED)
 					throw die(String.format("Could not create branch %s: %s", newHead, update.toString()));
-- 
1.6.3.dirty
