From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/7] Normalize paths to /-format when parsing GIT URI's
Date: Thu,  8 Jan 2009 17:56:28 +0100
Message-ID: <1231433791-9267-5-git-send-email-robin.rosenberg@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-2-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-3-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:58:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyDM-0001ZY-Rb
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbZAHQ4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbZAHQ4l
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:56:41 -0500
Received: from mail.dewire.com ([83.140.172.130]:25781 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbZAHQ4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:56:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 67D6D1484F71;
	Thu,  8 Jan 2009 17:56:36 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JluORV9sBx7x; Thu,  8 Jan 2009 17:56:35 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3D86C1484F72;
	Thu,  8 Jan 2009 17:56:33 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231433791-9267-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104937>

This means '\' on Windows will be changed to '/'.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/transport/URIishTest.java |   10 ++++++++++
 .../src/org/spearce/jgit/transport/URIish.java     |    3 ++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
index 2e5e847..8462dfc 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
@@ -62,6 +62,16 @@ public void testWindowsFile() throws Exception {
 		assertEquals(u, new URIish(str));
 	}
 
+	public void testWindowsFile2() throws Exception {
+		final String str = "D:\\m y";
+		URIish u = new URIish(str);
+		assertNull(u.getScheme());
+		assertFalse(u.isRemote());
+		assertEquals("D:/m y", u.getPath());
+		assertEquals("D:/m y", u.toString());
+		assertEquals(u, new URIish(str));
+	}
+
 	public void testFileProtoUnix() throws Exception {
 		final String str = "file:///home/m y";
 		URIish u = new URIish(str);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
index f81a709..b86e00c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
@@ -51,7 +51,7 @@
  */
 public class URIish {
 	private static final Pattern FULL_URI = Pattern
-			.compile("^(?:([a-z0-9+-]+)://(?:([^/]+?)(?::([^/]+?))?@)?(?:([^/]+?))?(?::(\\d+))?)?((?:[A-Za-z]:)?/.+)$");
+			.compile("^(?:([a-z][a-z0-9+-]+)://(?:([^/]+?)(?::([^/]+?))?@)?(?:([^/]+?))?(?::(\\d+))?)?((?:[A-Za-z]:)?/.+)$");
 
 	private static final Pattern SCP_URI = Pattern
 			.compile("^(?:([^@]+?)@)?([^:]+?):(.+)$");
@@ -75,6 +75,7 @@
 	 * @throws URISyntaxException
 	 */
 	public URIish(String s) throws URISyntaxException {
+		s = s.replace('\\', '/');
 		Matcher matcher = FULL_URI.matcher(s);
 		if (matcher.matches()) {
 			scheme = matcher.group(1);
-- 
1.6.1.rc3.56.gd0306
