From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/13] Add compare-and-swap semantics to RefUpdate
Date: Mon, 22 Dec 2008 16:27:20 -0800
Message-ID: <1229992043-1053-11-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
 <1229992043-1053-5-git-send-email-spearce@spearce.org>
 <1229992043-1053-6-git-send-email-spearce@spearce.org>
 <1229992043-1053-7-git-send-email-spearce@spearce.org>
 <1229992043-1053-8-git-send-email-spearce@spearce.org>
 <1229992043-1053-9-git-send-email-spearce@spearce.org>
 <1229992043-1053-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9z-0005lu-7q
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbYLWA1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbYLWA1s
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:48 -0500
Received: from george.spearce.org ([209.20.77.23]:54474 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbYLWA13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:29 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 275B238221; Tue, 23 Dec 2008 00:27:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7232738200;
	Tue, 23 Dec 2008 00:27:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103789>

This permits the caller to set the value it expects to find in the
Ref upon obtaining the update lock.  If the ref value doesn't match
then the update is aborted with Result.LOCK_FAILURE, so the caller
can recover gracefully without making unexpected changes.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   30 ++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 235c2fd..0c9ce91 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -149,6 +149,9 @@
 	/** Old value of the ref, obtained after we lock it. */
 	private ObjectId oldValue;
 
+	/** If non-null, the value {@link #oldValue} must have to continue. */
+	private ObjectId expValue;
+
 	/** Result of the update operation. */
 	private Result result = Result.NOT_ATTEMPTED;
 
@@ -190,6 +193,27 @@ public void setNewObjectId(final AnyObjectId id) {
 	}
 
 	/**
+	 * @return the expected value of the ref after the lock is taken, but before
+	 *         update occurs. Null to avoid the compare and swap test. Use
+	 *         {@link ObjectId#zeroId()} to indicate expectation of a
+	 *         non-existant ref.
+	 */
+	public ObjectId getExpectedOldObjectId() {
+		return expValue;
+	}
+
+	/**
+	 * @param id
+	 *            the expected value of the ref after the lock is taken, but
+	 *            before update occurs. Null to avoid the compare and swap test.
+	 *            Use {@link ObjectId#zeroId()} to indicate expectation of a
+	 *            non-existant ref.
+	 */
+	public void setExpectedOldObjectId(final AnyObjectId id) {
+		expValue = id != null ? id.toObjectId() : null;
+	}
+
+	/**
 	 * Check if this update wants to forcefully change the ref.
 	 * 
 	 * @return true if this update should ignore merge tests.
@@ -370,6 +394,12 @@ private Result updateImpl(final RevWalk walk, final Store store)
 			return Result.LOCK_FAILURE;
 		try {
 			oldValue = db.idOf(getName());
+			if (expValue != null) {
+				final ObjectId o;
+				o = oldValue != null ? oldValue : ObjectId.zeroId();
+				if (!expValue.equals(o))
+					return Result.LOCK_FAILURE;
+			}
 			if (oldValue == null)
 				return store.store(lock, Result.NEW);
 
-- 
1.6.1.rc4.301.g5497a
