From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH 6/7] Added ref deletion to RefUpdate
Date: Thu, 14 Aug 2008 20:13:48 +1000
Message-ID: <1218708829-8175-7-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
 <1218708829-8175-2-git-send-email-charleso@charleso.org>
 <1218708829-8175-3-git-send-email-charleso@charleso.org>
 <1218708829-8175-4-git-send-email-charleso@charleso.org>
 <1218708829-8175-5-git-send-email-charleso@charleso.org>
 <1218708829-8175-6-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZsB-0003J8-3g
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbYHNKOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbYHNKOg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:14:36 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:44651 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbYHNKOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:14:35 -0400
Received: by rv-out-0506.google.com with SMTP id k40so333673rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=z391ApyCMouJeCee7X5xAJMGNZPz+z7nbQ8CTbp1zwY=;
        b=JJ7+1ve4C35AYHyvsa8WsmtmXbrNYONEs+U/9JJAPrMrUeFa0lZg4KycEvPkW0H4FL
         RVaFdqADSVM5UDBGsVz2DmN8X301MJrb4JU87fJXWZvDxUdGf9rNOIWADzYDcfdEYN1P
         GClNh4cp1cqjecpQDjVo8gkyS9ifI6RFxG5QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=pQ1n70EWA4RL3aDMmoY7Mio7uc6QBd34vUl12qNiR5RI05sEIAFaQ7qpAw2mhXRMla
         9GVBJhyYNjX+8Y7EChoVVBLdIoZajK+oL31fZw70v++YIeynAd4k5nBKsdrbijzLAYYN
         QGTgH8kon9c8CTM/6P4LjxoB2aRO6CmAupwMk=
Received: by 10.114.24.1 with SMTP id 1mr944636wax.74.1218708874860;
        Thu, 14 Aug 2008 03:14:34 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id a8sm2909044poa.12.2008.08.14.03.14.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 03:14:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218708829-8175-6-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92349>

This is mixed in with the update code as they as they are common in
their general behaviour, differing only in the storing of the changes.

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   70 ++++++++++++++++++--
 1 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 1b38fce..e7560e9 100644
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
@@ -322,12 +343,12 @@ public class RefUpdate {
 		try {
 			oldValue = db.idOf(name);
 			if (oldValue == null)
-				return store(lock, Result.NEW);
+				return store.store(lock, Result.NEW);
 
 			if (isForceUpdate()) {
 				if (oldValue.equals(newValue))
 					return Result.NO_CHANGE;
-				return store(lock, Result.FORCED);
+				return store.store(lock, Result.FORCED);
 			}
 
 			newObj = walk.parseAny(newValue);
@@ -337,7 +358,7 @@ public class RefUpdate {
 
 			if (newObj instanceof RevCommit && oldObj instanceof RevCommit) {
 				if (walk.isMergedInto((RevCommit) oldObj, (RevCommit) newObj))
-					return store(lock, Result.FAST_FORWARD);
+					return store.store(lock, Result.FAST_FORWARD);
 			}
 
 			return Result.REJECTED;
@@ -346,7 +367,7 @@ public class RefUpdate {
 		}
 	}
 
-	private Result store(final LockFile lock, final Result status)
+	private Result updateStore(final LockFile lock, final Result status)
 			throws IOException {
 		lock.setNeedStatInformation(true);
 		lock.write(newValue);
@@ -366,4 +387,41 @@ public class RefUpdate {
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
