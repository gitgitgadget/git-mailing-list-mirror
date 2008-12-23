From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Fix BaseFetchPackConnection's output of selected capabilities
Date: Tue, 23 Dec 2008 14:56:46 -0800
Message-ID: <1230073007-17337-5-git-send-email-spearce@spearce.org>
References: <1230073007-17337-1-git-send-email-spearce@spearce.org>
 <1230073007-17337-2-git-send-email-spearce@spearce.org>
 <1230073007-17337-3-git-send-email-spearce@spearce.org>
 <1230073007-17337-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 23:58:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFGD0-0004pX-0D
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 23:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYLWW44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 17:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbYLWW4z
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 17:56:55 -0500
Received: from george.spearce.org ([209.20.77.23]:51456 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbYLWW4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 17:56:51 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 354B938200; Tue, 23 Dec 2008 22:56:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F088438210;
	Tue, 23 Dec 2008 22:56:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230073007-17337-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103854>

When we output the first "have ..." line for an upload-pack server
process we need to dump "have $id $cap1 $cap2 ..", where there is
a space between the SHA-1 $id and the first capability name $cap1.
If we don't dump that space we run into errors with our own version
of upload-pack not being able to parse the SHA-1 out of the line,
as the line was split incorrectly.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BasePackConnection.java |    3 +--
 .../jgit/transport/BasePackPushConnection.java     |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index e9df30e..c9232ce 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -207,8 +207,7 @@ protected boolean isCapableOf(final String option) {
 	protected boolean wantCapability(final StringBuilder b, final String option) {
 		if (!isCapableOf(option))
 			return false;
-		if (b.length() > 0)
-			b.append(' ');
+		b.append(' ');
 		b.append(option);
 		return true;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 17f6915..a078d7e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -181,7 +181,7 @@ private String enableCapabilities() {
 		capableReport = wantCapability(line, CAPABILITY_REPORT_STATUS);
 		capableDeleteRefs = wantCapability(line, CAPABILITY_DELETE_REFS);
 		if (line.length() > 0)
-			line.insert(0, '\0');
+			line.setCharAt(0, '\0');
 		return line.toString();
 	}
 
-- 
1.6.1.rc4.301.g5497a
