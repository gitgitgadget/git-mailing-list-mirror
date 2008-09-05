From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH] Fix: RefUpdate.delete does not prune empty directories
Date: Sat,  6 Sep 2008 08:56:47 +1000
Message-ID: <1220655407-5817-1-git-send-email-charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 00:58:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbkFo-0008Cu-2j
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 00:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbYIEW4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbYIEW4z
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 18:56:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:32300 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYIEW4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 18:56:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so638640rvb.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:sender;
        bh=8CHqJq2Bml7eWl4JjB67onYx81013RNZU2UnWzT+xGc=;
        b=EQAo0fJhVXQgjOpHmn38WETN+E1mnkO1pSiIv7gyCCs+ePxY8GXUL0suBUP4JbKcav
         O4eGRrD5au3Sg+3lW9g/5NweQaO45RGlM/2Yz+C+qYU1D5uBhQcls4p8EiJWXf0m6dDb
         s4ZhUyT0vZNyIUD2cA+LQ3F8cCRyFMiG5wq+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:sender;
        b=YyY/lFUlC5Hj2gT1RpBlrEOlhNG79fB/1S1skGs1Myn+YkqwYNjWO93H1PjDwIycAs
         7ygLjPTrB19irnsTcOaH5SbYK9goNY9jjZgo0LRmEZ4QZCfUqGUHq3i3gMZHHp/l1PQt
         UwNX8KIapR9cdzFcHRq8MMJ8F5DosbbN8wgl4=
Received: by 10.140.201.8 with SMTP id y8mr6998857rvf.28.1220655414142;
        Fri, 05 Sep 2008 15:56:54 -0700 (PDT)
Received: from localhost.localdomain ( [118.208.67.176])
        by mx.google.com with ESMTPS id l31sm1458140rvb.2.2008.09.05.15.56.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Sep 2008 15:56:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.1.220.g80d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95047>

When the last loose ref (or reflog) is removed from a directory the
directory itself should also be removed, up to refs/{heads,tags,remotes}.
Otherwise we may fail when doing something like:

  delete refs/heads/foo/bar
  create refs/heads/foo

as refs/heads/foo is still a directory and cannot be a file.

http://code.google.com/p/egit/issues/detail?id=10

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   34 ++++++++++++++--
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   41 +++++++++++++++++--
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
index 1ade2ef..6e2cfa8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RefUpdateTest.java
@@ -76,16 +76,22 @@ public void testDeleteHead() throws IOException {
 	}
 
 	public void testLogDeleted() throws IOException {
-		final File log = new File(db.getDirectory(), Constants.LOGS
-				+ "/refs/heads/a");
-		log.getParentFile().mkdirs();
-		log.createNewFile();
+		String refName = "refs/heads/a";
+		final File log = createLog(refName);
 		assertTrue(log.exists());
-		final RefUpdate ref = updateRef("refs/heads/a");
+		final RefUpdate ref = updateRef(refName);
 		delete(ref, Result.FAST_FORWARD);
 		assertFalse(log.exists());
 	}
 
+	private File createLog(String name) throws IOException {
+		final File log = new File(db.getDirectory(), Constants.LOGS + "/"
+				+ name);
+		log.getParentFile().mkdirs();
+		log.createNewFile();
+		return log;
+	}
+
 	public void testDeleteNotFound() throws IOException {
 		final RefUpdate ref = updateRef("refs/heads/xyz");
 		delete(ref, Result.NEW, false, true);
@@ -103,4 +109,22 @@ public void testDeleteForce() throws IOException {
 		ref.setForceUpdate(true);
 		delete(ref, Result.FORCED);
 	}
+
+	public void testDeleteEmptyDirs() throws IOException {
+		final String top = "refs/heads/a";
+		final String newRef = top + "/b/c";
+		final String newRef2 = top + "/d";
+		updateRef(newRef).update();
+		updateRef(newRef2).update();
+		delete(updateRef(newRef2), Result.NO_CHANGE);
+		assertExists(true, top);
+		createLog(newRef);
+		delete(updateRef(newRef), Result.NO_CHANGE);
+		assertExists(false, top);
+		assertExists(false, Constants.LOGS + "/" + top);
+	}
+
+	private void assertExists(final boolean expected, final String name) {
+		assertEquals(expected, new File(db.getDirectory(), name).exists());
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index e9c0e77..86b44c5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -459,13 +459,44 @@ Result store(LockFile lock, Result status) throws IOException {
 				return status;
 			if (storage.isPacked())
 				db.removePackedRef(ref.getName());
+
+			final int levels = count(ref.getName(), '/') - 2;
+
+			// Delete logs _before_ unlocking
+			final File gitDir = db.getRepository().getDirectory();
+			final File logDir = new File(gitDir, Constants.LOGS);
+			deleteFileAndEmptyDir(new File(logDir, ref.getName()), levels);
+
+			// We have to unlock before (maybe) deleting the parent directories
+			lock.unlock();
 			if (storage.isLoose())
-				if (!looseFile.delete())
-					throw new IOException("File cannot be deleted: "
-							+ looseFile);
-			new File(db.getRepository().getDirectory(), Constants.LOGS + "/"
-					+ ref.getName()).delete();
+				deleteFileAndEmptyDir(looseFile, levels);
 			return status;
 		}
+
+		private void deleteFileAndEmptyDir(final File file, final int depth)
+				throws IOException {
+			if (file.exists()) {
+				if (!file.delete())
+					throw new IOException("File cannot be deleted: " + file);
+				deleteEmptyDir(file.getParentFile(), depth);
+			}
+		}
+
+		private void deleteEmptyDir(File dir, int depth) {
+			for (; depth > 0 && dir != null; depth--) {
+				if (!dir.delete())
+					break;
+				dir = dir.getParentFile();
+			}
+		}
+	}
+
+	private static int count(final String s, final char c) {
+		int count = 0;
+		for (int p = s.indexOf(c); p >= 0; p = s.indexOf(c, p + 1)) {
+			count++;
+		}
+		return count;
 	}
 }
-- 
1.6.0.1.220.g80d1
