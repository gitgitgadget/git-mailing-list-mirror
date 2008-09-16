From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/2 v2] Add support for ~/.ssh/config PreferredAuthentications
Date: Tue, 16 Sep 2008 08:44:28 -0700
Message-ID: <1221579869-27835-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 17:46:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfckj-0002lb-8R
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 17:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbYIPPoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 11:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755719AbYIPPoc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 11:44:32 -0400
Received: from george.spearce.org ([209.20.77.23]:48455 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbYIPPoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 11:44:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2DFF738368; Tue, 16 Sep 2008 15:44:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7DDCF3835A;
	Tue, 16 Sep 2008 15:44:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.389.g421e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96011>

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

 This replaces my earlier patch of the same title from about 14
 hours ago.  This v2 patch actually parses the data from the
 config file and includes unit tests to verify it is parsing.

 .../spearce/egit/ui/EclipseSshSessionFactory.java  |    4 +++
 .../spearce/jgit/transport/OpenSshConfigTest.java  |   22 ++++++++++++++++-
 .../jgit/transport/DefaultSshSessionFactory.java   |    4 +++
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   25 ++++++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
index 640a165..67c5f16 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
@@ -50,6 +50,10 @@ public Session getSession(String user, String pass, String host, int port)
 			session.setPassword(pass);
 		else
 			new UserInfoPrompter(session);
+
+		final String pauth = hc.getPreferredAuthentications();
+		if (pauth != null)
+			session.setConfig("PreferredAuthentications", pauth);
 		return session;
 	}
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
index a250f9d..1a71d08 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
@@ -103,7 +103,6 @@ config("Host orcz\n" + "\tHostName repo.or.cz\n" + "\tPort 2222\n"
 		assertEquals(new File(home, ".ssh/id_jex"), h.getIdentityFile());
 	}
 
-
 	public void testAlias_OptionsKeywordCaseInsensitive() throws Exception {
 		config("hOsT orcz\n" + "\thOsTnAmE repo.or.cz\n" + "\tPORT 2222\n"
 				+ "\tuser jex\n" + "\tidentityfile .ssh/id_jex\n"
@@ -128,4 +127,25 @@ config("Host orcz\n" + "\tHostName repo.or.cz\n" + "\n" + "Host *\n"
 		assertEquals(2222, h.getPort());
 		assertEquals(new File(home, ".ssh/id_jex"), h.getIdentityFile());
 	}
+
+	public void testAlias_PreferredAuthenticationsDefault() throws Exception {
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertNull(h.getPreferredAuthentications());
+	}
+
+	public void testAlias_PreferredAuthentications() throws Exception {
+		config("Host orcz\n" + "\tPreferredAuthentications publickey\n");
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertEquals("publickey", h.getPreferredAuthentications());
+	}
+
+	public void testAlias_InheritPreferredAuthentications() throws Exception {
+		config("Host orcz\n" + "\tHostName repo.or.cz\n" + "\n" + "Host *\n"
+				+ "\tPreferredAuthentications publickey, hostbased\n");
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertEquals("publickey,hostbased", h.getPreferredAuthentications());
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 74fca66..b6f58f0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -103,6 +103,10 @@ public synchronized Session getSession(String user, String pass,
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
index cf7c388..2f41e56 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -220,6 +220,10 @@ else if (sp < 0)
 				for (final Host c : current)
 					if (c.identityFile == null)
 						c.identityFile = toFile(dequote(argValue));
+			} else if ("PreferredAuthentications".equalsIgnoreCase(keyword)) {
+				for (final Host c : current)
+					if (c.preferredAuthentications == null)
+						c.preferredAuthentications = nows(dequote(argValue));
 			}
 		}
 
@@ -247,6 +251,15 @@ private static String dequote(final String value) {
 		return value;
 	}
 
+	private static String nows(final String value) {
+		final StringBuilder b = new StringBuilder();
+		for (int i = 0; i < value.length(); i++) {
+			if (!Character.isSpaceChar(value.charAt(i)))
+				b.append(value.charAt(i));
+		}
+		return b.toString();
+	}
+
 	private File toFile(final String path) {
 		if (path.startsWith("~/"))
 			return new File(home, path.substring(2));
@@ -278,6 +291,8 @@ private File toFile(final String path) {
 
 		String user;
 
+		String preferredAuthentications;
+
 		void copyFrom(final Host src) {
 			if (hostName == null)
 				hostName = src.hostName;
@@ -287,6 +302,8 @@ void copyFrom(final Host src) {
 				identityFile = src.identityFile;
 			if (user == null)
 				user = src.user;
+			if (preferredAuthentications == null)
+				preferredAuthentications = src.preferredAuthentications;
 		}
 
 		/**
@@ -317,5 +334,13 @@ public File getIdentityFile() {
 		public String getUser() {
 			return user;
 		}
+
+		/**
+		 * @return the preferred authentication methods, separated by commas if
+		 *         more than one authentication method is preferred.
+		 */
+		public String getPreferredAuthentications() {
+			return preferredAuthentications;
+		}
 	}
 }
-- 
1.6.0.2.389.g421e0
