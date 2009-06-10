From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH v5 3/7] Do not write to the reflog unless the refupdate logmessage is set
Date: Wed, 10 Jun 2009 23:22:21 +0200
Message-ID: <1244668945-12622-4-git-send-email-robin.rosenberg@dewire.com>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-1-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-2-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jun 10 23:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEVFv-0007hX-L9
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 23:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbZFJVWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756787AbZFJVWh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 17:22:37 -0400
Received: from mail.dewire.com ([83.140.172.130]:3882 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbZFJVWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 17:22:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BDEF6147D5A9;
	Wed, 10 Jun 2009 23:22:33 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id giLaSz73tWuf; Wed, 10 Jun 2009 23:22:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 05962147D5AC;
	Wed, 10 Jun 2009 23:22:28 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1244668945-12622-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121303>

From: Shawn O. Pearce <spearce@spearce.org>

This permits micro-update steps (or otherwise uninteresting states)
to be skipped in the reflog.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |    1 +
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   56 +++++++++++++++----
 2 files changed, 45 insertions(+), 12 deletions(-)

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
index a9ab73b..8044c6e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -165,6 +165,7 @@ RefUpdate(final RefDatabase r, final Ref ref, final File f) {
 		this.ref = ref;
 		oldValue = ref.getObjectId();
 		looseFile = f;
+		refLogMessage = "";
 	}
 
 	/** @return the repository the updated ref resides in */
@@ -264,7 +265,8 @@ public void setRefLogIdent(final PersonIdent pi) {
 	/**
 	 * Get the message to include in the reflog.
 	 * 
-	 * @return message the caller wants to include in the reflog.
+	 * @return message the caller wants to include in the reflog; null if the
+	 *         update should not be logged.
 	 */
 	public String getRefLogMessage() {
 		return refLogMessage;
@@ -274,15 +276,29 @@ public String getRefLogMessage() {
 	 * Set the message to include in the reflog.
 	 * 
 	 * @param msg
-	 *            the message to describe this change.
+	 *            the message to describe this change. It may be null
+	 *            if appendStatus is null in order not to append to the reflog
 	 * @param appendStatus
 	 *            true if the status of the ref change (fast-forward or
 	 *            forced-update) should be appended to the user supplied
 	 *            message.
 	 */
 	public void setRefLogMessage(final String msg, final boolean appendStatus) {
-		refLogMessage = msg;
-		refLogIncludeResult = appendStatus;
+		if (msg == null && !appendStatus)
+			disableRefLog();
+		else if (msg == null && appendStatus) {
+			refLogMessage = "";
+			refLogIncludeResult = true;
+		} else {
+			refLogMessage = msg;
+			refLogIncludeResult = appendStatus;
+		}
+	}
+
+	/** Don't record this update in the ref's associated reflog. */
+	public void disableRefLog() {
+		refLogMessage = null;
+		refLogIncludeResult = false;
 	}
 
 	/**
@@ -471,21 +487,37 @@ private Result updateStore(final LockFile lock, final Result status)
 		lock.setNeedStatInformation(true);
 		lock.write(newValue);
 		String msg = getRefLogMessage();
-		if (msg != null && refLogIncludeResult) {
-			if (status == Result.FORCED)
-				msg += ": forced-update";
-			else if (status == Result.FAST_FORWARD)
-				msg += ": fast forward";
-			else if (status == Result.NEW)
-				msg += ": created";
+		if (msg != null) {
+			if (refLogIncludeResult) {
+				String strResult = toResultString(status);
+				if (strResult != null) {
+					if (msg.length() > 0)
+						msg = msg + ": " + strResult;
+					else
+						msg = strResult;
+				}
+			}
+			RefLogWriter.append(this, msg);
 		}
-		RefLogWriter.append(this, msg);
 		if (!lock.commit())
 			return Result.LOCK_FAILURE;
 		db.stored(this.ref.getOrigName(),  ref.getName(), newValue, lock.getCommitLastModified());
 		return status;
 	}
 
+	private static String toResultString(final Result status) {
+		switch (status) {
+		case FORCED:
+			return "forced-update";
+		case FAST_FORWARD:
+			return "fast forward";
+		case NEW:
+			return "created";
+		default:
+			return null;
+		}
+	}
+
 	/**
 	 * Handle the abstraction of storing a ref update. This is because both
 	 * updating and deleting of a ref have merge testing in common.
-- 
1.6.3.2.199.g7340d
