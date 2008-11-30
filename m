From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 7/8] Close files opened by unit testing framework
Date: Mon,  1 Dec 2008 00:40:34 +0100
Message-ID: <1228088435-23722-8-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
 <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-3-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-4-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-5-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-6-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-7-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvi-0001xS-OW
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbYK3Xk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754401AbYK3Xkw
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:52 -0500
Received: from mail.dewire.com ([83.140.172.130]:25217 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882AbYK3Xks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A173314433E9;
	Mon,  1 Dec 2008 00:40:46 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ksvQ3UuY4Np; Mon,  1 Dec 2008 00:40:45 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 443B6147D543;
	Mon,  1 Dec 2008 00:40:38 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228088435-23722-7-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101991>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   12 ++++++++----
 .../tst/org/spearce/jgit/lib/T0007_Index.java      |   10 +++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index aaa3592..376a76e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -165,10 +165,14 @@ protected File writeTrashFile(final String name, final String data)
 	protected static void checkFile(File f, final String checkData)
 			throws IOException {
 		Reader r = new InputStreamReader(new FileInputStream(f), "ISO-8859-1");
-		char[] data = new char[(int) f.length()];
-		if (f.length() !=  r.read(data))
-			throw new IOException("Internal error reading file data from "+f);
-		assertEquals(checkData, new String(data));
+		try {
+			char[] data = new char[(int) f.length()];
+			if (f.length() !=  r.read(data))
+				throw new IOException("Internal error reading file data from "+f);
+			assertEquals(checkData, new String(data));
+		} finally {
+			r.close();
+		}
 	}
 
 	protected Repository db;
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
index 69f3a48..499812e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0007_Index.java
@@ -424,9 +424,13 @@ public void test031_executeBit_coreModeFalse() throws IllegalArgumentException, 
 	private String content(File f) throws IOException {
 		byte[] buf = new byte[(int) f.length()];
 		FileInputStream is = new FileInputStream(f);
-		int read = is.read(buf);
-		assertEquals(f.length(), read);
-		return new String(buf, 0);
+		try {
+			int read = is.read(buf);
+			assertEquals(f.length(), read);
+			return new String(buf, 0);
+		} finally {
+			is.close();
+		}
 	}
 
 	private void delete(File f) throws IOException {
-- 
1.6.0.3.640.g6331a
