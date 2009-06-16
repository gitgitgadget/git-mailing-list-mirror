From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Make UploadPack capability parsing more liberal
Date: Tue, 16 Jun 2009 11:59:25 -0700
Message-ID: <1245178765-7505-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 20:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGdse-0004OM-QU
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 20:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761144AbZFPS7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 14:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759698AbZFPS7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 14:59:24 -0400
Received: from george.spearce.org ([209.20.77.23]:54493 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759254AbZFPS7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 14:59:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E9D19381FF; Tue, 16 Jun 2009 18:59:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 417BE381FD;
	Tue, 16 Jun 2009 18:59:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.406.gd6a466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121703>

Prior to 220a6626c86b ("Fix BaseFetchPackConnection's output of
selected capabilities") the JGit pack client produced a capability
request header that JGit itself can't parse, but C Git can.
The parsing error was caused by a missing space after the want'd
SHA-1 and before the first capability name.

Even though JGit's pack client has been fixed in more recent
versions, we should still fix the server to be more libral in
what it accepts from clients, so that older JGit client builds
can still interoperate.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/UploadPack.java |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index fcc1ef7..159bd10 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -302,13 +302,13 @@ private void recvWants() throws IOException {
 			if (!line.startsWith("want ") || line.length() < 45)
 				throw new PackProtocolException("expected want; got " + line);
 
-			if (isFirst) {
-				final int sp = line.indexOf(' ', 45);
-				if (sp >= 0) {
-					for (String c : line.substring(sp + 1).split(" "))
-						options.add(c);
-					line = line.substring(0, sp);
-				}
+			if (isFirst && line.length() > 45) {
+				String opt = line.substring(45);
+				if (opt.startsWith(" "))
+					opt = opt.substring(1);
+				for (String c : opt.split(" "))
+					options.add(c);
+				line = line.substring(0, 45);
 			}
 
 			final ObjectId id = ObjectId.fromString(line.substring(5));
-- 
1.6.3.2.406.gd6a466
