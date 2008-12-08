From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Cache values of symbolic refs in RefDatabase
Date: Mon,  8 Dec 2008 22:48:56 +0100
Message-ID: <1228772936-2447-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 08 22:50:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9nzd-0002dF-0q
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 22:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbYLHVtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 16:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbYLHVtA
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 16:49:00 -0500
Received: from mail.dewire.com ([83.140.172.130]:14138 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbYLHVs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 16:48:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A8847802809;
	Mon,  8 Dec 2008 22:48:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 38AVb3wR4dif; Mon,  8 Dec 2008 22:48:56 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id B8E23800251;
	Mon,  8 Dec 2008 22:48:56 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102586>

This way we avoid reading refs if the timestamp has not changed. This
reduced the number of opens for reading symbolic refs like HEAD.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 494aecb..4cf6e08 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -69,6 +69,7 @@
 
 	private Map<String, Ref> looseRefs;
 	private Map<String, Long> looseRefsMTime;
+	private Map<String, String> looseSymRefs;
 
 	private final File packedRefsFile;
 
@@ -96,6 +97,7 @@ void clearCache() {
 		looseRefs = new HashMap<String, Ref>();
 		looseRefsMTime = new HashMap<String, Long>();
 		packedRefs = new HashMap<String, Ref>();
+		looseSymRefs = new HashMap<String, String>();
 		packedRefsLastModified = 0;
 		packedRefsLength = 0;
 	}
@@ -348,15 +350,26 @@ private Ref readRefBasic(final String origName, final String name, final int dep
 			return ref;
 		}
 
-		final String line;
+		String line = null;
 		try {
-			line = readLine(loose);
+			Long cachedlastModified = looseRefsMTime.get(name);
+			if (cachedlastModified != null && cachedlastModified == mtime) {
+				line = looseSymRefs.get(name);
+			}
+			if (line == null) {
+				line = readLine(loose);
+				looseRefsMTime.put(name, mtime);
+				looseSymRefs.put(name, line);
+			}
 		} catch (FileNotFoundException notLoose) {
 			return packedRefs.get(name);
 		}
 
-		if (line == null || line.length() == 0)
+		if (line == null || line.length() == 0) {
+			looseRefs.remove(origName);
+			looseRefsMTime.remove(origName);
 			return new Ref(Ref.Storage.LOOSE, origName, name, null);
+		}
 
 		if (line.startsWith("ref: ")) {
 			if (depth >= 5) {
-- 
1.6.0.3.640.g6331a
