From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Add support for ~/.ssh/config BatchMode
Date: Tue, 16 Sep 2008 08:44:29 -0700
Message-ID: <1221579869-27835-2-git-send-email-spearce@spearce.org>
References: <1221579869-27835-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 17:46:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfckk-0002lb-8O
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 17:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980AbYIPPoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 11:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756307AbYIPPod
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 11:44:33 -0400
Received: from george.spearce.org ([209.20.77.23]:48458 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbYIPPob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 11:44:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 949BE38360; Tue, 16 Sep 2008 15:44:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C657E3835F;
	Tue, 16 Sep 2008 15:44:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.389.g421e0
In-Reply-To: <1221579869-27835-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96010>

Connections created through batch processes (e.g. those started by
cron) don't have a terminal to interact with a user through.  A
common way to disable password prompting with OpenSSH is to setup
a Host block in ~/.ssh/config with "BatchMode yes" enabled, thus
telling the client not to prompt for passphases or passwords.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/ui/EclipseSshSessionFactory.java  |    2 +-
 .../spearce/jgit/transport/OpenSshConfigTest.java  |   21 +++++++++++++++++++
 .../jgit/transport/DefaultSshSessionFactory.java   |    2 +-
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   22 ++++++++++++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
index 67c5f16..098d234 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/EclipseSshSessionFactory.java
@@ -48,7 +48,7 @@ public Session getSession(String user, String pass, String host, int port)
 			addIdentity(hc.getIdentityFile());
 		if (pass != null)
 			session.setPassword(pass);
-		else
+		else if (!hc.isBatchMode())
 			new UserInfoPrompter(session);
 
 		final String pauth = hc.getPreferredAuthentications();
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
index 1a71d08..959b6b7 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
@@ -148,4 +148,25 @@ config("Host orcz\n" + "\tHostName repo.or.cz\n" + "\n" + "Host *\n"
 		assertNotNull(h);
 		assertEquals("publickey,hostbased", h.getPreferredAuthentications());
 	}
+
+	public void testAlias_BatchModeDefault() throws Exception {
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertEquals(false, h.isBatchMode());
+	}
+
+	public void testAlias_BatchModeYes() throws Exception {
+		config("Host orcz\n" + "\tBatchMode yes\n");
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertEquals(true, h.isBatchMode());
+	}
+
+	public void testAlias_InheritBatchMode() throws Exception {
+		config("Host orcz\n" + "\tHostName repo.or.cz\n" + "\n" + "Host *\n"
+				+ "\tBatchMode yes\n");
+		final Host h = osc.lookup("orcz");
+		assertNotNull(h);
+		assertEquals(true, h.isBatchMode());
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index b6f58f0..89beab7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -101,7 +101,7 @@ public synchronized Session getSession(String user, String pass,
 			addIdentity(hc.getIdentityFile());
 		if (pass != null)
 			session.setPassword(pass);
-		else
+		else if (!hc.isBatchMode())
 			session.setUserInfo(new AWT_UserInfo());
 
 		final String pauth = hc.getPreferredAuthentications();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index 2f41e56..df38e18 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -224,6 +224,10 @@ else if (sp < 0)
 				for (final Host c : current)
 					if (c.preferredAuthentications == null)
 						c.preferredAuthentications = nows(dequote(argValue));
+			} else if ("BatchMode".equalsIgnoreCase(keyword)) {
+				for (final Host c : current)
+					if (c.batchMode == null)
+						c.batchMode = yesno(dequote(argValue));
 			}
 		}
 
@@ -260,6 +264,12 @@ private static String nows(final String value) {
 		return b.toString();
 	}
 
+	private static Boolean yesno(final String value) {
+		if ("yes".equalsIgnoreCase(value))
+			return Boolean.TRUE;
+		return Boolean.FALSE;
+	}
+
 	private File toFile(final String path) {
 		if (path.startsWith("~/"))
 			return new File(home, path.substring(2));
@@ -293,6 +303,8 @@ private File toFile(final String path) {
 
 		String preferredAuthentications;
 
+		Boolean batchMode;
+
 		void copyFrom(final Host src) {
 			if (hostName == null)
 				hostName = src.hostName;
@@ -304,6 +316,8 @@ void copyFrom(final Host src) {
 				user = src.user;
 			if (preferredAuthentications == null)
 				preferredAuthentications = src.preferredAuthentications;
+			if (batchMode == null)
+				batchMode = src.batchMode;
 		}
 
 		/**
@@ -342,5 +356,13 @@ public String getUser() {
 		public String getPreferredAuthentications() {
 			return preferredAuthentications;
 		}
+
+		/**
+		 * @return true if batch (non-interactive) mode is preferred for this
+		 *         host connection.
+		 */
+		public boolean isBatchMode() {
+			return batchMode != null && batchMode.booleanValue();
+		}
 	}
 }
-- 
1.6.0.2.389.g421e0
