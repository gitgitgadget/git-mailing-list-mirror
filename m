From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH 2/7] Refactor of RefUpdate force to call common updateImpl instead of duplication
Date: Thu, 14 Aug 2008 20:13:44 +1000
Message-ID: <1218708829-8175-3-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
 <1218708829-8175-2-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZrb-00038Q-HO
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbYHNKOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbYHNKOU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:14:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:50988 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbYHNKOS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:14:18 -0400
Received: by wa-out-1112.google.com with SMTP id j37so199004waf.23
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=QAJxsoc7jb2znQeLq/d192A5LFCADQRR59VMLAzQXr4=;
        b=AaIMkCC7xAperyFIuIJAbxdS09SAuZGLm1/ip6RGZYBO0S3ISONe/FO0gMokYdonma
         vXV3CV7ursaw+hI+vfB0I5pNwz4nz2rlLb0ukPKgmsT6ZO3f6P09EWPKmQqWbuKo/pTL
         1JjYe7WuDCFPRZSxVyloYTvFKHq92Fj1hjit4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=B8vjUalaLpzfnUMQHa42e769p/aVs8S4D359lDsAY5LOqOvKgaMJ12MK6WaMSq62JT
         ikHL+JHjhNc6TFEusiXEniLEACAt13Kba3NuChrRBABG8RJ8ifJFJnexrKMDmbDm8RuK
         Ax3xHM1RudaRqAEcUd8maXC1Ole5tfiRz34P8=
Received: by 10.114.196.13 with SMTP id t13mr942571waf.219.1218708858451;
        Thu, 14 Aug 2008 03:14:18 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id a8sm2909044poa.12.2008.08.14.03.14.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 03:14:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218708829-8175-2-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92344>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   38 ++++---------------
 1 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 369cb37..1b38fce 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -266,31 +266,8 @@ public class RefUpdate {
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
@@ -347,6 +324,12 @@ public class RefUpdate {
 			if (oldValue == null)
 				return store(lock, Result.NEW);
 
+			if (isForceUpdate()) {
+				if (oldValue.equals(newValue))
+					return Result.NO_CHANGE;
+				return store(lock, Result.FORCED);
+			}
+
 			newObj = walk.parseAny(newValue);
 			oldObj = walk.parseAny(oldValue);
 			if (newObj == oldObj)
@@ -355,13 +338,8 @@ public class RefUpdate {
 			if (newObj instanceof RevCommit && oldObj instanceof RevCommit) {
 				if (walk.isMergedInto((RevCommit) oldObj, (RevCommit) newObj))
 					return store(lock, Result.FAST_FORWARD);
-				if (isForceUpdate())
-					return store(lock, Result.FORCED);
-				return Result.REJECTED;
 			}
 
-			if (isForceUpdate())
-				return store(lock, Result.FORCED);
 			return Result.REJECTED;
 		} finally {
 			lock.unlock();
-- 
1.6.0.rc2.35.g04c6e
