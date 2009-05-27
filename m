From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 05/10] Do not write to the reflog unless the refupdate logmessage is set
Date: Thu, 28 May 2009 00:08:52 +0200
Message-ID: <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com>
References: <20090520221651.GR30527@spearce.org>
 <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com>
 <1243462137-24133-5-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 28 00:09:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RJj-0005Vu-Iz
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757736AbZE0WJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757274AbZE0WJe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:09:34 -0400
Received: from mail.dewire.com ([83.140.172.130]:25351 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbZE0WJe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:09:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F2532145D124;
	Thu, 28 May 2009 00:09:33 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uenXiF+KqUgJ; Thu, 28 May 2009 00:09:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.10])
	by dewire.com (Postfix) with ESMTP id 472CF145D132;
	Thu, 28 May 2009 00:09:00 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1243462137-24133-5-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120121>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |    1 +
 .../src/org/spearce/jgit/lib/RefUpdate.java        |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 6b1975a..84653c8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -126,6 +126,7 @@ public void testDeleteLooseAndItsDirectory() throws IOException {
 		RefUpdate updateRef = db.updateRef("refs/heads/z/c");
 		updateRef.setNewObjectId(pid);
 		updateRef.setForceUpdate(true);
+		updateRef.setRefLogMessage("new test ref", false);
 		Result update = updateRef.update();
 		assertEquals(Result.NEW, update); // internal
 		assertTrue(new File(db.getDirectory(), Constants.R_HEADS + "z")
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index a9ab73b..79d9f2d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -479,7 +479,8 @@ else if (status == Result.FAST_FORWARD)
 			else if (status == Result.NEW)
 				msg += ": created";
 		}
-		RefLogWriter.append(this, msg);
+		if (msg != null)
+			RefLogWriter.append(this, msg);
 		if (!lock.commit())
 			return Result.LOCK_FAILURE;
 		db.stored(this.ref.getOrigName(),  ref.getName(), newValue, lock.getCommitLastModified());
-- 
1.6.3.dirty
