From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH v2 2/7] Refactor of RefUpdate force to call common updateImpl instead of duplication
Date: Fri, 15 Aug 2008 10:25:56 +1000
Message-ID: <1218759957-16735-1-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 02:27:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTnA6-0000uH-Ll
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYHOA0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 20:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYHOA0J
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:26:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:48570 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYHOA0H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:26:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so675767rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=SBVrkQMGU4ypQyBoF0hiiAbzh0g2MKyh1VWjfsGum9g=;
        b=l8nsAfNA02fCdilzAFAVolxZqi5oliemNVOp+NnkInrQ5esFslutcCxL785EnksPy8
         aL0JMIs8Mn86kIwHuapKj/Udm163dNRNz1ATuUWyaAywCqwQ/jSBqGVDTTcj95/Di05b
         mIzGfX95X9nXYytpTLxMycsjiBsRv1MpXXMHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=g7NqsWl2LqHmPBAebLsfOEJpNBnQLk0Xuy9UAWCFzkv2SNQRUwbJrKIvc7Mj9qcL4d
         PZ4vOAB2Otx4hdlylJmAhv0boRKRpS44LUSPFogwN2fRKFfVvV3QE1oP1+89vaINvCq+
         QTqWLmb/DcbELkxF86QxgVJ+j3770sgeMxeeY=
Received: by 10.115.54.7 with SMTP id g7mr2013138wak.212.1218759966266;
        Thu, 14 Aug 2008 17:26:06 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id m26sm4570571pof.1.2008.08.14.17.26.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 17:26:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218708829-8175-1-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92449>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   34 ++-----------------
 1 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 369cb37..4587fc1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -258,39 +258,16 @@ public class RefUpdate {
 	/**
 	 * Force the ref to take the new value.
 	 * <p>
-	 * No merge tests are performed, so the value of {@link #isForceUpdate()}
-	 * will not be honored.
+	 * This is just a convenient helper for setting the force flag, and as such
+	 * the merge test is performed.
 	 * 
 	 * @return the result status of the update.
 	 * @throws IOException
 	 *             an unexpected IO error occurred while writing changes.
 	 */
 	public Result forceUpdate() throws IOException {
-		requireCanDoUpdate();
-		try {
-			return result = forceUpdateImpl();
-		} catch (IOException x) {
-			result = Result.IO_FAILURE;
-			throw x;
-		}
-	}
-
-	private Result forceUpdateImpl() throws IOException {
-		final LockFile lock;
-
-		lock = new LockFile(looseFile);
-		if (!lock.lock())
-			return Result.LOCK_FAILURE;
-		try {
-			oldValue = db.idOf(name);
-			if (oldValue == null)
-				return store(lock, Result.NEW);
-			if (oldValue.equals(newValue))
-				return Result.NO_CHANGE;
-			return store(lock, Result.FORCED);
-		} finally {
-			lock.unlock();
-		}
+		force = true;
+		return update();
 	}
 
 	/**
@@ -355,9 +332,6 @@ public class RefUpdate {
 			if (newObj instanceof RevCommit && oldObj instanceof RevCommit) {
 				if (walk.isMergedInto((RevCommit) oldObj, (RevCommit) newObj))
 					return store(lock, Result.FAST_FORWARD);
-				if (isForceUpdate())
-					return store(lock, Result.FORCED);
-				return Result.REJECTED;
 			}
 
 			if (isForceUpdate())
-- 
1.6.0.rc2.35.g04c6e
