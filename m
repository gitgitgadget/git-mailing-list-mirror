From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/12] Don't subclass PrintWriter when writing the Config
Date: Tue, 21 Jul 2009 13:19:26 -0700
Message-ID: <1248207570-13880-9-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
 <1248207570-13880-4-git-send-email-spearce@spearce.org>
 <1248207570-13880-5-git-send-email-spearce@spearce.org>
 <1248207570-13880-6-git-send-email-spearce@spearce.org>
 <1248207570-13880-7-git-send-email-spearce@spearce.org>
 <1248207570-13880-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLq2-0001jT-TK
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbZGUUUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756164AbZGUUUA
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:20:00 -0400
Received: from george.spearce.org ([209.20.77.23]:59245 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126AbZGUUTe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4394B38222; Tue, 21 Jul 2009 20:19:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8E6EA38200;
	Tue, 21 Jul 2009 20:19:33 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123705>

Instead of subclassing PrintWriter to override the println() method
we can replace the one println() call we do make with print('\n'),
which ensures we only produce an LF and never a CRLF file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |    4 ++--
 .../src/org/spearce/jgit/lib/FileBasedConfig.java  |    7 +------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index a2934a2..8eb2e2a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -677,7 +677,7 @@ private int findSectionEnd(final String section, final String subsection) {
 	 * Print configuration file to the PrintWriter
 	 *
 	 * @param r
-	 *             the print writer (it must use '\n' as new line separator).
+	 *             stream to write the configuration to.
 	 */
 	protected void printConfig(final PrintWriter r) {
 		final Iterator<Entry> i = entries.iterator();
@@ -714,7 +714,7 @@ protected void printConfig(final PrintWriter r) {
 			if (e.suffix != null) {
 				r.print(e.suffix);
 			}
-			r.println();
+			r.print('\n');
 		}
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
index 75e88f6..aa1dbee 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
@@ -80,12 +80,7 @@ public void save() throws IOException {
 				+ ".lock");
 		final PrintWriter r = new PrintWriter(new BufferedWriter(
 				new OutputStreamWriter(new FileOutputStream(tmp),
-						Constants.CHARSET))) {
-			@Override
-			public void println() {
-				print('\n');
-			}
-		};
+						Constants.CHARSET)));
 		boolean ok = false;
 		try {
 			printConfig(r);
-- 
1.6.4.rc1.186.g60aa0c
