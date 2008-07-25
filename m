From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 8/9] Refactor SubcommandHandler to use CommandCatalog instead of reflection
Date: Fri, 25 Jul 2008 12:46:06 -0700
Message-ID: <1217015167-4680-9-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
 <1217015167-4680-2-git-send-email-spearce@spearce.org>
 <1217015167-4680-3-git-send-email-spearce@spearce.org>
 <1217015167-4680-4-git-send-email-spearce@spearce.org>
 <1217015167-4680-5-git-send-email-spearce@spearce.org>
 <1217015167-4680-6-git-send-email-spearce@spearce.org>
 <1217015167-4680-7-git-send-email-spearce@spearce.org>
 <1217015167-4680-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTGf-0005n2-Kj
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbYGYTqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYGYTqX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:23 -0400
Received: from george.spearce.org ([209.20.77.23]:45947 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYGYTqN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4B1773841A; Fri, 25 Jul 2008 19:46:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6B1CC383A3;
	Fri, 25 Jul 2008 19:46:11 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90101>

Now that all commands are known to the CommandCatalog we do not need
to perform direct reflection inside of the SubcommandHandler.  Instead
we can reuse the lookup table already known to the CommandCatalog.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    8 +--
 .../spearce/jgit/pgm/opt/SubcommandHandler.java    |   65 ++------------------
 2 files changed, 6 insertions(+), 67 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index e2eef84..5c066cb 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -83,13 +83,7 @@ public abstract class TextBuiltin {
 	/** RevWalk used during command line parsing, if it was required. */
 	protected RevWalk argWalk;
 
-	/**
-	 * Set the name this command can be invoked as on the command line.
-	 *
-	 * @param name
-	 *            the name of the command.
-	 */
-	public void setCommandName(final String name) {
+	final void setCommandName(final String name) {
 		commandName = name;
 	}
 
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java
index c7e1bf6..86004bb 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java
@@ -37,8 +37,6 @@
 
 package org.spearce.jgit.pgm.opt;
 
-import java.lang.reflect.Constructor;
-import java.lang.reflect.InvocationTargetException;
 import java.text.MessageFormat;
 
 import org.kohsuke.args4j.CmdLineException;
@@ -47,7 +45,8 @@ import org.kohsuke.args4j.OptionDef;
 import org.kohsuke.args4j.spi.OptionHandler;
 import org.kohsuke.args4j.spi.Parameters;
 import org.kohsuke.args4j.spi.Setter;
-import org.spearce.jgit.pgm.Main;
+import org.spearce.jgit.pgm.CommandCatalog;
+import org.spearce.jgit.pgm.CommandRef;
 import org.spearce.jgit.pgm.TextBuiltin;
 
 /**
@@ -57,12 +56,6 @@ import org.spearce.jgit.pgm.TextBuiltin;
  * we can execute at runtime with the remaining arguments of the parser.
  */
 public class SubcommandHandler extends OptionHandler<TextBuiltin> {
-	private static String mypackage() {
-		final String p = Main.class.getName();
-		final int dot = p.lastIndexOf('.');
-		return p.substring(0, dot);
-	}
-
 	/**
 	 * Create a new handler for the command name.
 	 * <p>
@@ -80,65 +73,17 @@ public class SubcommandHandler extends OptionHandler<TextBuiltin> {
 	@Override
 	public int parseArguments(final Parameters params) throws CmdLineException {
 		final String name = params.getParameter(0);
-		final StringBuilder s = new StringBuilder();
-		s.append(mypackage());
-		s.append('.');
-		boolean upnext = true;
-		for (int i = 0; i < name.length(); i++) {
-			final char c = name.charAt(i);
-			if (c == '-') {
-				upnext = true;
-				continue;
-			}
-			if (upnext)
-				s.append(Character.toUpperCase(c));
-			else
-				s.append(c);
-			upnext = false;
-		}
-
-		final Class<?> clazz;
-		try {
-			clazz = Class.forName(s.toString());
-		} catch (ClassNotFoundException e) {
-			throw new CmdLineException(MessageFormat.format(
-					"{0} is not a jgit command", name));
-		}
-
-		if (!TextBuiltin.class.isAssignableFrom(clazz))
+		final CommandRef cr = CommandCatalog.get(name);
+		if (cr == null)
 			throw new CmdLineException(MessageFormat.format(
 					"{0} is not a jgit command", name));
 
-		final Constructor<?> cons;
-		try {
-			cons = clazz.getDeclaredConstructor();
-		} catch (SecurityException e) {
-			throw new CmdLineException("Cannot create " + name, e);
-		} catch (NoSuchMethodException e) {
-			throw new CmdLineException("Cannot create " + name, e);
-		}
-		cons.setAccessible(true);
-
-		final TextBuiltin cmd;
-		try {
-			cmd = (TextBuiltin) cons.newInstance();
-		} catch (InstantiationException e) {
-			throw new CmdLineException("Cannot create " + name, e);
-		} catch (IllegalAccessException e) {
-			throw new CmdLineException("Cannot create " + name, e);
-		} catch (InvocationTargetException e) {
-			throw new CmdLineException("Cannot create " + name, e);
-		}
-
-		cmd.setCommandName(name);
-		setter.addValue(cmd);
-
 		// Force option parsing to stop. Everything after us should
 		// be arguments known only to this command and must not be
 		// recognized by the current parser.
 		//
 		owner.stopOptionParsing();
-
+		setter.addValue(cr.create());
 		return 1;
 	}
 
-- 
1.6.0.rc0.182.gb96c7
