From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 1/2] Refactor SSH key loading so we don't duplicate keys
Date: Fri, 15 Aug 2008 10:35:04 -0700
Message-ID: <1218821705-2631-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3Dg-0001EG-QW
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 19:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbYHORfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 13:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbYHORfH
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 13:35:07 -0400
Received: from george.spearce.org ([209.20.77.23]:44209 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbYHORfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 13:35:06 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E6AF338265; Fri, 15 Aug 2008 17:35:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 63F1D38265;
	Fri, 15 Aug 2008 17:35:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc3.250.g8dd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92495>

We only want to read each private key once, so we cache the
names of the keys we have processed before, adding keys which
we have not yet seen.  This allows us to alter add keys on
the fly and avoid duplication.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/transport/DefaultSshSessionFactory.java   |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index b4578d4..0484fc0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -78,6 +78,8 @@
 	/** IANA assigned port number for SSH. */
 	private static final int SSH_PORT = 22;
 
+	private Set<String> loadedIdentities;
+
 	private JSch userJSch;
 
 	@Override
@@ -106,10 +108,10 @@ public String run() {
 
 	private JSch getUserJSch() throws JSchException {
 		if (userJSch == null) {
-			final JSch sch = new JSch();
-			knownHosts(sch);
-			identities(sch);
-			userJSch = sch;
+			loadedIdentities = new HashSet<String>();
+			userJSch = new JSch();
+			knownHosts(userJSch);
+			identities();
 		}
 		return userJSch;
 	}
@@ -133,7 +135,7 @@ private void knownHosts(final JSch sch) throws JSchException {
 		}
 	}
 
-	private void identities(final JSch sch) throws JSchException {
+	private void identities() throws JSchException {
 		final File home = FS.userHome();
 		if (home == null)
 			return;
@@ -149,10 +151,16 @@ private void identities(final JSch sch) throws JSchException {
 			final File k = new File(sshdir, n.substring(0, n.length() - 4));
 			if (!k.isFile())
 				continue;
-			sch.addIdentity(k.getAbsolutePath());
+			addIdentity(k);
 		}
 	}
 
+	private void addIdentity(final File identityFile) throws JSchException {
+		final String path = identityFile.getAbsolutePath();
+		if (loadedIdentities.add(path))
+			userJSch.addIdentity(path);
+	}
+
 	private static class AWT_UserInfo implements UserInfo,
 			UIKeyboardInteractive {
 		private String passwd;
-- 
1.6.0.rc3.250.g8dd0
