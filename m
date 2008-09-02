From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/3] Make all files in our JAR have the same timestamp
Date: Tue,  2 Sep 2008 09:28:10 -0700
Message-ID: <1220372892-15423-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 18:29:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaYku-0006j9-5r
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 18:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbYIBQ2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 12:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbYIBQ2P
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 12:28:15 -0400
Received: from george.spearce.org ([209.20.77.23]:44740 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYIBQ2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 12:28:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C6D7D38378; Tue,  2 Sep 2008 16:28:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 55F3338359;
	Tue,  2 Sep 2008 16:28:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.207.g020e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94680>

When we link together our classes into a JAR we want to use the same
timestamp for all entries in the archive.  Using different times from
the local filesystem is fairly meaningless.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/pgm/build/JarLinkUtil.java    |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java
index 46ae0ea..929ee55 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java
@@ -93,6 +93,8 @@ public static void main(final String[] argv) throws IOException {
 
 	private final Map<String, File> chosenSources = new HashMap<String, File>();
 
+	private long creationTime;
+
 	private ZipOutputStream zos;
 
 	private JarLinkUtil() {
@@ -109,6 +111,7 @@ private void run() throws IOException {
 		for (final Map.Entry<String, String> e : files.entrySet())
 			chosenSources.put(e.getKey(), new File(e.getValue()));
 
+		creationTime = System.currentTimeMillis();
 		zos = new ZipOutputStream(System.out);
 		zos.setLevel(9);
 
@@ -180,9 +183,8 @@ else if (chosenSources.get(pfx + e.getName()) == rootDir)
 	private void appendFile(final File path, final String name)
 			throws IOException {
 		final long len = path.length();
-		final long time = path.lastModified();
 		final InputStream is = new FileInputStream(path);
-		appendEntry(name, len, time, is);
+		appendEntry(name, len, creationTime, is);
 	}
 
 	private void appendEntry(final String name, final long len,
-- 
1.6.0.1.207.g020e5
