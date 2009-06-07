From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 05/10] Do not write to the reflog unless the
	refupdate logmessage is set
Date: Sun, 7 Jun 2009 15:44:46 -0700
Message-ID: <20090607224446.GE16497@spearce.org>
References: <20090520221651.GR30527@spearce.org> <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com> <20090603154129.GG3355@spearce.org> <200906080027.16338.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDR6k-0004dD-0h
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbZFGWop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 18:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbZFGWoo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:44:44 -0400
Received: from george.spearce.org ([209.20.77.23]:44523 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbZFGWon (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 18:44:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 54BC2381FE; Sun,  7 Jun 2009 22:44:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906080027.16338.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121018>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> onsdag 03 juni 2009 17:41:29 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > > Do not write to the reflog unless the refupdate logmessage is set
> > 
> > Why not?  What is the justification for this?  Isn't a reflog record
> > still useful, at least to point out that something happened at this
> > point in time, and here's the old/new values?
> 
> I need to do an update without logging to avoid a "dummy" entry in the
> reflog since I use the RefUpdate mechanism. Since this is an API and
> not and end user function, I was thinking this might be ok after all.

ACK, I agree.  How about this then?
 
--8<--
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Do not write to the reflog if refLogMessage is null

This permits micro-update steps (or otherwise uninteresting states)
to be skipped in the reflog.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |    1 +
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   53 +++++++++++++++----
 2 files changed, 43 insertions(+), 11 deletions(-)

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
index a9ab73b..17fe3be 100644
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
@@ -281,8 +283,21 @@ public String getRefLogMessage() {
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
@@ -471,21 +486,37 @@ private Result updateStore(final LockFile lock, final Result status)
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
1.6.3.2.322.g117de

-- 
Shawn.
