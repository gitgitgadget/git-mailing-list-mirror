From: Gilion Goudsmit <ggoudsmit@shebang.nl>
Subject: [JGIT PATCH] Fixed a bug that caused tabs in ~/.ssh/config to break parsing
Date: Sat, 20 Sep 2008 22:33:41 +0200
Message-ID: <12219428213749-git-send-email-ggoudsmit@shebang.nl>
Cc: spearce@spearce.org, Gilion Goudsmit <ggoudsmit@shebang.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 22:57:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh9W7-00069j-Gu
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 22:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYITU4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 16:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYITU4L
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 16:56:11 -0400
Received: from shebang.colocated.redunix.net ([78.41.204.188]:44763 "EHLO
	mail.shebang.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751510AbYITU4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 16:56:10 -0400
X-Greylist: delayed 1345 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Sep 2008 16:56:10 EDT
Received: by mail.shebang.nl (Postfix, from userid 500)
	id 572C6B98014; Sat, 20 Sep 2008 22:33:42 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96365>

Having only tab-characters separating a key and value in the
users ~/.ssh/config would cause the config-parser to fail with
a "String index out of range: -1" exception. Also simplified
the line parsing code my using a two argument split.

Signed-off-by: Gilion Goudsmit <ggoudsmit@shebang.nl>
---
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index df38e18..5bfcf5f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -167,17 +167,9 @@ while ((line = br.readLine()) != null) {
 			if (line.length() == 0 || line.startsWith("#"))
 				continue;
 
-			final int sp = line.indexOf(' ');
-			final int eq = line.indexOf('=');
-			final int splitAt;
-			if (sp >= 0 && eq >= 0)
-				splitAt = Math.min(sp, eq);
-			else if (sp < 0)
-				splitAt = eq;
-			else
-				splitAt = sp;
-			final String keyword = line.substring(0, splitAt).trim();
-			final String argValue = line.substring(splitAt + 1).trim();
+			final String[] parts = line.split("[ \t=]", 2);
+			final String keyword = parts[0].trim();
+			final String argValue = parts[1].trim();
 
 			if ("Host".equalsIgnoreCase(keyword)) {
 				current.clear();
-- 
1.5.3.8
