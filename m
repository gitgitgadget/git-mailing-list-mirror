From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2] Ignore unreadable SSH private keys when autoloading identities
Date: Wed, 27 Aug 2008 16:02:05 -0700
Message-ID: <1219878126-18622-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYU2u-00085z-JF
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbYH0XCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbYH0XCI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:02:08 -0400
Received: from george.spearce.org ([209.20.77.23]:55161 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbYH0XCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:02:08 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3CFF538360; Wed, 27 Aug 2008 23:02:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D19E138360;
	Wed, 27 Aug 2008 23:02:06 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93976>

During SSH startup we read all keys in the user's ~/.ssh, even
if we may not need them for this particular transport session.

If a file is not really a key, or it contains a key that JSch
doesn't recognize we shouldn't crash the transport.  Instead
we should skip the file and move on.  Later on we just don't
have that identity available to us, or we'll crash if we try
to add that identity file explicitly from ~/.ssh/config.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/DefaultSshSessionFactory.java   |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index a2437c2..aa72357 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -165,14 +165,23 @@ private void identities() throws JSchException {
 			final File k = new File(sshdir, n.substring(0, n.length() - 4));
 			if (!k.isFile())
 				continue;
-			addIdentity(k);
+
+			try {
+				addIdentity(k);
+			} catch (JSchException e) {
+				if (e.getMessage().startsWith("invalid privatekey: "))
+					continue;
+				throw e;
+			}
 		}
 	}
 
 	private void addIdentity(final File identityFile) throws JSchException {
 		final String path = identityFile.getAbsolutePath();
-		if (loadedIdentities.add(path))
+		if (!loadedIdentities.contains(path)) {
 			userJSch.addIdentity(path);
+			loadedIdentities.add(path);
+		}
 	}
 
 	private static class AWT_UserInfo implements UserInfo,
-- 
1.6.0.174.gd789c
