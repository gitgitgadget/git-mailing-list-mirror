From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH v2] The default encoding for reading commits is UTF-8 rather than system default
Date: Wed,  7 Oct 2009 20:26:40 +0400
Message-ID: <1254932800-3788-1-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 07 18:28:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvZN1-00074w-Kj
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 18:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759540AbZJGQ1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 12:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759535AbZJGQ1T
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 12:27:19 -0400
Received: from mail.intellij.net ([213.182.181.98]:51764 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759534AbZJGQ1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 12:27:18 -0400
Received: (qmail 21626 invoked by uid 89); 7 Oct 2009 16:26:40 -0000
Received: by simscan 1.1.0 ppid: 21582, pid: 21618, t: 0.0077s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 7 Oct 2009 16:26:40 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129649>

When reading commits the system default encoding was used if no encoding
was specified in the commit. The patch modifies test to add a check that
commit message was encoded correctly (the test fails on old implementation
if system encoding is not UTF-8) and fixes Commit.decode() method to use
UTF-8 is encoding is not specified in the commit object.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---

This version is over eclipse.org packages.

See man git-commit (the section "DISCUSSION"), for justification why
UTF-8 should be used. Note that this was already correctly implemented
in ObjectWriter.writeCommit(...) method. But Commit.decode() was not
implemented in the same way for some reason.
 
 .../tst/org/eclipse/jgit/lib/T0003_Basic.java      |    3 +++
 .../src/org/eclipse/jgit/lib/Commit.java           |   18 +++++++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/org.eclipse.jgit.test/tst/org/eclipse/jgit/lib/T0003_Basic.java b/org.eclipse.jgit.test/tst/org/eclipse/jgit/lib/T0003_Basic.java
index 98fb794..f3bc9b1 100644
--- a/org.eclipse.jgit.test/tst/org/eclipse/jgit/lib/T0003_Basic.java
+++ b/org.eclipse.jgit.test/tst/org/eclipse/jgit/lib/T0003_Basic.java
@@ -348,6 +348,9 @@ public void test023_createCommitNonAnullii() throws IOException {
 		commit.setMessage("\u00dcbergeeks");
 		ObjectId cid = new ObjectWriter(db).writeCommit(commit);
 		assertEquals("4680908112778718f37e686cbebcc912730b3154", cid.name());
+		Commit loadedCommit = db.mapCommit(cid);
+		assertNotSame(loadedCommit, commit);
+		assertEquals(commit.getMessage(), loadedCommit.getMessage());
 	}
 
 	public void test024_createCommitNonAscii() throws IOException {
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/Commit.java b/org.eclipse.jgit/src/org/eclipse/jgit/lib/Commit.java
index b2cf9b1..430cddc 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/Commit.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/lib/Commit.java
@@ -299,17 +299,13 @@ private void decode() {
 				br.read(readBuf);
 				int msgstart = readBuf.length != 0 ? ( readBuf[0] == '\n' ? 1 : 0 ) : 0;
 
-				if (encoding != null) {
-					// TODO: this isn't reliable so we need to guess the encoding from the actual content
-					author = new PersonIdent(new String(rawAuthor.getBytes(),encoding.name()));
-					committer = new PersonIdent(new String(rawCommitter.getBytes(),encoding.name()));
-					message = new String(readBuf,msgstart, readBuf.length-msgstart, encoding.name());
-				} else {
-					// TODO: use config setting / platform / ascii / iso-latin
-					author = new PersonIdent(new String(rawAuthor.getBytes()));
-					committer = new PersonIdent(new String(rawCommitter.getBytes()));
-					message = new String(readBuf, msgstart, readBuf.length-msgstart);
-				}
+				// If encoding is not specified, the default for commit is UTF-8
+				if (encoding == null) encoding = Constants.CHARSET;
+
+				// TODO: this isn't reliable so we need to guess the encoding from the actual content
+				author = new PersonIdent(new String(rawAuthor.getBytes(),encoding.name()));
+				committer = new PersonIdent(new String(rawCommitter.getBytes(),encoding.name()));
+				message = new String(readBuf,msgstart, readBuf.length-msgstart, encoding.name());
 			} catch (IOException e) {
 				e.printStackTrace();
 			} finally {
-- 
1.6.1.2
