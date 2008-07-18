From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 17/28] Support automatic command line parsing for TextBuiltin subclasses
Date: Thu, 17 Jul 2008 21:44:10 -0400
Message-ID: <1216345461-59382-18-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
 <1216345461-59382-9-git-send-email-spearce@spearce.org>
 <1216345461-59382-10-git-send-email-spearce@spearce.org>
 <1216345461-59382-11-git-send-email-spearce@spearce.org>
 <1216345461-59382-12-git-send-email-spearce@spearce.org>
 <1216345461-59382-13-git-send-email-spearce@spearce.org>
 <1216345461-59382-14-git-send-email-spearce@spearce.org>
 <1216345461-59382-15-git-send-email-spearce@spearce.org>
 <1216345461-59382-16-git-send-email-spearce@spearce.org>
 <1216345461-59382-17-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4E-0006LD-Vh
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758026AbYGRBpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbYGRBpa
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:30 -0400
Received: from george.spearce.org ([209.20.77.23]:47020 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441AbYGRBot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D2C3738445; Fri, 18 Jul 2008 01:44:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C62C7382A4;
	Fri, 18 Jul 2008 01:44:29 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-17-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88966>

By default the execute method will parse the supplied arguments
and then invoke run().  Newer style builtins will override the
run method, rather than the execute method, and take advantage of
the standard parsing support.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   69 +++++++++++++++++++-
 1 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index 0f39f11..c4a55f4 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -43,9 +43,13 @@ import java.io.IOException;
 import java.io.OutputStreamWriter;
 import java.io.PrintWriter;
 
+import org.kohsuke.args4j.CmdLineException;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.pgm.opt.CmdLineParser;
+import org.spearce.jgit.revwalk.RevWalk;
 
 /**
  * Abstract command which can be invoked from the command line.
@@ -67,12 +71,18 @@ public abstract class TextBuiltin {
 
 	private String commandName;
 
+	@Option(name = "--help", usage = "display this help text", aliases = { "-h" })
+	private boolean help;
+
 	/** Stream to output to, typically this is standard output. */
 	protected PrintWriter out;
 
 	/** Git repository the command was invoked within. */
 	protected Repository db;
 
+	/** RevWalk used during command line parsing, if it was required. */
+	protected RevWalk argWalk;
+
 	/**
 	 * Set the name this command can be invoked as on the command line.
 	 * 
@@ -94,7 +104,7 @@ public abstract class TextBuiltin {
 	}
 
 	/**
-	 * Perform the action(s) of this command.
+	 * Parse arguments and run this command.
 	 * 
 	 * @param args
 	 *            command line arguments passed after the command name.
@@ -103,7 +113,62 @@ public abstract class TextBuiltin {
 	 *             framework will catch the exception and print a message on
 	 *             standard error.
 	 */
-	public abstract void execute(String[] args) throws Exception;
+	public void execute(String[] args) throws Exception {
+		parseArguments(args);
+		run();
+	}
+
+	/**
+	 * Parses the command line arguments prior to running.
+	 * <p>
+	 * This method should only be invoked by {@link #execute(String[])}, prior
+	 * to calling {@link #run()}. The default implementation parses all
+	 * arguments into this object's instance fields.
+	 * 
+	 * @param args
+	 *            the arguments supplied on the command line, if any.
+	 */
+	protected void parseArguments(final String[] args) {
+		final CmdLineParser clp = new CmdLineParser(this);
+		try {
+			clp.parseArgument(args);
+		} catch (CmdLineException err) {
+			if (!help) {
+				System.err.println("fatal: " + err.getMessage());
+				System.exit(1);
+			}
+		}
+
+		if (help) {
+			System.err.print("jgit ");
+			System.err.print(commandName);
+			clp.printSingleLineUsage(System.err);
+			System.err.println();
+
+			if (help) {
+				System.err.println();
+				clp.printUsage(System.err);
+				System.err.println();
+			}
+			System.exit(1);
+		}
+
+		argWalk = clp.getRevWalkGently();
+	}
+
+	/**
+	 * Perform the actions of this command.
+	 * <p>
+	 * This method should only be invoked by {@link #execute(String[])}.
+	 * 
+	 * @throws Exception
+	 *             an error occurred while processing the command. The main
+	 *             framework will catch the exception and print a message on
+	 *             standard error.
+	 */
+	protected void run() throws Exception {
+		throw die("Override either execute (legacy) or run (new style).");
+	}
 
 	/**
 	 * @return the repository this command accesses.
-- 
1.5.6.3.569.ga9185
