From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH v2 6/7] Added ref deletion to RefUpdate
Date: Fri, 15 Aug 2008 10:25:57 +1000
Message-ID: <1218759957-16735-2-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
 <1218759957-16735-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 02:27:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTnA7-0000uH-Vz
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbYHOA0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 20:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbYHOA0R
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:26:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:9782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbYHOA0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:26:13 -0400
Received: by wa-out-1112.google.com with SMTP id j37so363194waf.23
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 17:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=KQ/6KXL3Yu/7Hv1CZniZOEOqH3rQtHdKtr9vB3BU/vI=;
        b=r7f2JU9pihkAp+ZKbboYIvPTwY/foaRV8IOeismCj7mpn8eocv6mtOgyrifX+GPvZh
         t8n7FUVgqNewfIFvAM7sYNKIvffkqz8mkNRmLlz/nVSQ0PTaUhZFWIOeOJeQeOIlLPsU
         zGN1Z4xxFdCx82I+sYYFcFx21wSzZ8d7yrC5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=rCzvAHJ6+wDhGPspQYB+9ziXP5661EVnEXi/4QNvATZf67j2JWYBkP4y2CAYxKiKV2
         ui1PUhD9wUS3R4upHZT1qRGhFhGiTgqFy8d27Sujfsngs0ozBlUwPDjiHS2NKe9V9ACN
         18aLt9Noo5f/5r213Payr5JQjCnDP2MhFpXL0=
Received: by 10.114.160.17 with SMTP id i17mr2015782wae.48.1218759972099;
        Thu, 14 Aug 2008 17:26:12 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id m26sm4570571pof.1.2008.08.14.17.26.06
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 17:26:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218759957-16735-1-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92450>

This is mixed in with the update code as they as they are common in
their general behaviour, differing only in the storing of the changes.

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   70 ++++++++++++++++++--
 1 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 4587fc1..858ba46 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -40,6 +40,7 @@ package org.spearce.jgit.lib;
 import java.io.File;
 import java.io.IOException;
 
+import org.spearce.jgit.lib.Ref.Storage;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevWalk;
@@ -146,8 +147,11 @@ public class RefUpdate {
 	/** Result of the update operation. */
 	private Result result = Result.NOT_ATTEMPTED;
 
+	private final Ref ref;
+
 	RefUpdate(final RefDatabase r, final Ref ref, final File f) {
 		db = r;
+		this.ref = ref;
 		name = ref.getName();
 		oldValue = ref.getObjectId();
 		looseFile = f;
@@ -304,14 +308,31 @@ public class RefUpdate {
 	public Result update(final RevWalk walk) throws IOException {
 		requireCanDoUpdate();
 		try {
-			return result = updateImpl(walk);
+			return result = updateImpl(walk, new UpdateStore());
+		} catch (IOException x) {
+			result = Result.IO_FAILURE;
+			throw x;
+		}
+	}
+
+	/**
+	 * Delete the ref.
+	 * 
+	 * @return the result status of the delete.
+	 * @throws IOException
+	 */
+	public Result delete() throws IOException {
+		try {
+			return updateImpl(new RevWalk(db.getRepository()),
+					new DeleteStore());
 		} catch (IOException x) {
 			result = Result.IO_FAILURE;
 			throw x;
 		}
 	}
 
-	private Result updateImpl(final RevWalk walk) throws IOException {
+	private Result updateImpl(final RevWalk walk, final Store store)
+			throws IOException {
 		final LockFile lock;
 		RevObject newObj;
 		RevObject oldObj;
@@ -322,7 +343,7 @@ public class RefUpdate {
 		try {
 			oldValue = db.idOf(name);
 			if (oldValue == null)
-				return store(lock, Result.NEW);
+				return store.store(lock, Result.NEW);
 
 			newObj = walk.parseAny(newValue);
 			oldObj = walk.parseAny(oldValue);
@@ -331,18 +352,18 @@ public class RefUpdate {
 
 			if (newObj instanceof RevCommit && oldObj instanceof RevCommit) {
 				if (walk.isMergedInto((RevCommit) oldObj, (RevCommit) newObj))
-					return store(lock, Result.FAST_FORWARD);
+					return store.store(lock, Result.FAST_FORWARD);
 			}
 
 			if (isForceUpdate())
-				return store(lock, Result.FORCED);
+				return store.store(lock, Result.FORCED);
 			return Result.REJECTED;
 		} finally {
 			lock.unlock();
 		}
 	}
 
-	private Result store(final LockFile lock, final Result status)
+	private Result updateStore(final LockFile lock, final Result status)
 			throws IOException {
 		lock.setNeedStatInformation(true);
 		lock.write(newValue);
@@ -362,4 +383,41 @@ public class RefUpdate {
 		db.stored(name, newValue, lock.getCommitLastModified());
 		return status;
 	}
+
+	/**
+	 * Handle the abstraction of storing a ref update. This is because both
+	 * updating and deleting of a ref have merge testing in common.
+	 */
+	private abstract class Store {
+		abstract Result store(final LockFile lock, final Result status)
+				throws IOException;
+	}
+
+	private class UpdateStore extends Store {
+
+		@Override
+		Result store(final LockFile lock, final Result status)
+				throws IOException {
+			return updateStore(lock, status);
+		}
+	}
+
+	private class DeleteStore extends Store {
+
+		@Override
+		Result store(LockFile lock, Result status) throws IOException {
+			Storage storage = ref.getStorage();
+			if (storage == Storage.NEW)
+				return status;
+			if (storage.isPacked())
+				db.removePackedRef(ref.getName());
+			if (storage.isLoose())
+				if (!looseFile.delete())
+					throw new IOException("File cannot be deleted: "
+							+ looseFile);
+			new File(db.getRepository().getDirectory(), Constants.LOGS + "/"
+					+ ref.getName()).delete();
+			return status;
+		}
+	}
 }
-- 
1.6.0.rc2.35.g04c6e
