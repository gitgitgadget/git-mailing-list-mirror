From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Add support for ~/.ssh/config PreferredAuthentications
Date: Mon, 15 Sep 2008 22:48:17 -0700
Message-ID: <1221544097-51484-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 07:49:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfTRH-0002wC-Rs
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 07:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbYIPFsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 01:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbYIPFsU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 01:48:20 -0400
Received: from george.spearce.org ([209.20.77.23]:41236 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYIPFsT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 01:48:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 12A0C38360; Tue, 16 Sep 2008 05:48:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 548253835A;
	Tue, 16 Sep 2008 05:48:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.337.g5c7d67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95974>

Some configurations may wish to disable interactive methods of
authentication, such as when running from automated cron or batch
style jobs that have no user available.

Typically in an OpenSSH based system this would be configured on a
per-host basis in the current user's ~/.ssh/config file, by setting
PreferredAuthentications to the list of authentication methods
(e.g. just "publickey") that are reasonable.

JSch honors this configuration setting, but we need to transfer it
from our own OpenSshConfig class, otherwise it has no knowledge of
the setting.

http://code.google.com/p/egit/issues/detail?id=33

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/ui/EclipseSshSessionFactory.java  |    4 ++++
 .../jgit/transport/DefaultSshSessionFactory.java   |    4 ++++
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   12 ++++++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
index 640a165..67c5f16 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
@@ -50,6 +50,10 @@ if (pass != null)
 			session.setPassword(pass);
 		else
 			new UserInfoPrompter(session);
+
+		final String pauth = hc.getPreferredAuthentications();
+		if (pauth != null)
+			session.setConfig("PreferredAuthentications", pauth);
 		return session;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 74fca66..b6f58f0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -103,6 +103,10 @@ if (pass != null)
 			session.setPassword(pass);
 		else
 			session.setUserInfo(new AWT_UserInfo());
+
+		final String pauth = hc.getPreferredAuthentications();
+		if (pauth != null)
+			session.setConfig("PreferredAuthentications", pauth);
 		return session;
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index cf7c388..748199c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -278,6 +278,8 @@ if (ret.isAbsolute())
 
 		String user;
 
+		String preferredAuthentications;
+
 		void copyFrom(final Host src) {
 			if (hostName == null)
 				hostName = src.hostName;
@@ -287,6 +289,8 @@ if (identityFile == null)
 				identityFile = src.identityFile;
 			if (user == null)
 				user = src.user;
+			if (preferredAuthentications == null)
+				preferredAuthentications = src.preferredAuthentications;
 		}
 
 		/**
@@ -317,5 +321,13 @@ public File getIdentityFile() {
 		public String getUser() {
 			return user;
 		}
+
+		/**
+		 * @return return the preferred authentication methods, separated by
+		 *         commas if more than one authentication method is preferred.
+		 */
+		public String getPreferredAuthentications() {
+			return preferredAuthentications;
+		}
 	}
 }
-- 
1.6.0.1.337.g5c7d67
