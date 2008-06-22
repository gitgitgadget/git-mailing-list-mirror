From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [JGIT RFC PATCH] Add a stdio prompt for SSH connection information.
Date: Sun, 22 Jun 2008 23:06:25 +0200
Message-ID: <200806222306.25434.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 22 23:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAWqA-00065X-RM
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 23:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbYFVVKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 17:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755764AbYFVVKT
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 17:10:19 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:37697 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbYFVVKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 17:10:18 -0400
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id CA5FC38266; Sun, 22 Jun 2008 23:10:16 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id A5306381F2; Sun, 22 Jun 2008 23:10:16 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 5DDF737E54;
	Sun, 22 Jun 2008 23:10:16 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85802>

With Java6 there is support for echo-less input of information
like passwords from the console.

Windows users must set the system headless promperty java.awt.headless
to true (-Djava.awt.headless=true) manually. Only unix system headless
operation is detected automatically via the DISPLAY environment variable.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

Starting a command line utility like jgit and getting a graphical prompt is almost
an insult. The problem here is that Java 5, which we support, does not have a
portable way of disabling echoing of characters. Java 6 (and anythung newr)
does. There are several solutions involving non-portable tricks. Should we 
support an insecure practice of echoing passwords, or as I do here, only support
it if one is using Java 6. A downside of supporting it at all is that one needs a
JavaSE 6 compiler to build the thing.

btw, does anyone know if console() yields null when runnings as a Windows
service? I tentatively assume that it does without explicily setting the headless
property.

I'm also a little unsure about how to invoke the promptKeyboardInteractive method.

 .../jgit/transport/DefaultSshSessionFactory.java   |   86 +++++++++++++++++++-
 1 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 8a59904..c895988 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -39,6 +39,7 @@
 package org.spearce.jgit.transport;
 
 import java.awt.Container;
+import java.awt.GraphicsEnvironment;
 import java.awt.GridBagConstraints;
 import java.awt.GridBagLayout;
 import java.awt.Insets;
@@ -90,8 +91,18 @@ class DefaultSshSessionFactory extends SshSessionFactory {
 		final Session session = getUserJSch().getSession(user, host, port);
 		if (pass != null)
 			session.setPassword(pass);
-		else
-			session.setUserInfo(new AWT_UserInfo());
+		UserInfo userInfo = null;
+		try {
+			System.class.getMethod("console");
+			if (GraphicsEnvironment.isHeadless() || System.console() == null)
+				userInfo = new StdioUserInfo();
+		} catch (NoSuchMethodException e) {
+			throw new IllegalStateException(
+					"You will need JavaSE 6 for stdio based password prompts");
+		}
+		if (userInfo == null)
+			userInfo = new AWT_UserInfo();
+		session.setUserInfo(userInfo);
 		return session;
 	}
 
@@ -249,4 +260,75 @@ class DefaultSshSessionFactory extends SshSessionFactory {
 			return null; // cancel
 		}
 	}
+
+	static class StdioUserInfo implements UserInfo, UIKeyboardInteractive {
+
+		String password;
+
+		String passphrase;
+
+		public String getPassphrase() {
+			return passphrase;
+		}
+
+		public String getPassword() {
+			return password;
+		}
+
+		public boolean promptPassphrase(String msg) {
+			passphrase = null;
+			char[] readPassword = System.console().readPassword("Passphrase: ");
+			if (readPassword == null)
+				return false;
+			passphrase = new String(readPassword);
+			return true;
+		}
+
+		public boolean promptPassword(String msg) {
+			password = null;
+			char[] readPassword = System.console().readPassword("Password: ");
+			if (readPassword == null)
+				return false;
+			password = new String(readPassword);
+			return true;
+		}
+
+		public boolean promptYesNo(String msg) {
+			String readLine = System.console().readLine("%s [Y/n]: ", msg);
+			if (readLine == null)
+				return false;
+			if (readLine.indexOf("yY") > 0)
+				return true;
+			return false;
+		}
+
+		public void showMessage(String msg) {
+			System.console().format("%s\n", msg);
+		}
+
+		public String[] promptKeyboardInteractive(final String destination,
+				final String name, final String instruction,
+				final String[] prompt, final boolean[] echo) {
+			System.console().printf("%s\n", instruction);
+			System.console().printf("Information for %s@%s required.\n", name,
+					destination);
+			String[] ret = new String[prompt.length];
+			for (int i = 0; i < ret.length; ++i) {
+				String s;
+				if (echo[i])
+					s = System.console().readLine("%s :", prompt[i]);
+				else {
+					char[] cha = System.console().readPassword("%s :",
+							prompt[i]);
+					if (cha == null)
+						s = null;
+					else
+						s = new String(cha);
+				}
+				ret[i] = s;
+			}
+			return ret;
+		}
+
+	}
 }
-- 
1.5.5.1.178.g1f811
