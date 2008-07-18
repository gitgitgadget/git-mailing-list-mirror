From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 16/28] Convert jgit's Main to use args4j for basic parsing services
Date: Thu, 17 Jul 2008 21:44:09 -0400
Message-ID: <1216345461-59382-17-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4H-0006LD-K5
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759043AbYGRBpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758316AbYGRBpl
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:41 -0400
Received: from george.spearce.org ([209.20.77.23]:47021 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758159AbYGRBot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7C95838444; Fri, 18 Jul 2008 01:44:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 00F5D38445;
	Fri, 18 Jul 2008 01:44:28 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-16-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88967>

We now use args4j for our global options parsing and for the
subcommand selection.  The remaining arguments that are left
over after the subcommand are sent to the subcommand unmodified.
An additional CmdLineParser could be created by the subcommand to
handle its own argument parsing over the remaining options.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Main.java             |  111 ++++++---------
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   19 +++
 .../spearce/jgit/pgm/opt/SubcommandHandler.java    |  149 ++++++++++++++++++++
 3 files changed, 214 insertions(+), 65 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
index 68748bf..c069989 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
@@ -39,8 +39,13 @@
 package org.spearce.jgit.pgm;
 
 import java.io.File;
-import java.util.Arrays;
+import java.util.ArrayList;
+import java.util.List;
 
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.CmdLineException;
+import org.kohsuke.args4j.ExampleMode;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.awtui.AwtAuthenticator;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;
@@ -50,7 +55,20 @@ import org.spearce.jgit.util.HttpSupport;
 
 /** Command line entry point. */
 public class Main {
-	private static boolean showStackTrace;
+	@Option(name = "--help", usage = "display this help text", aliases = { "-h" })
+	private boolean help;
+
+	@Option(name = "--show-stack-trace", usage = "display the Java stack trace on exceptions")
+	private boolean showStackTrace;
+
+	@Option(name = "--git-dir", metaVar = "GIT_DIR", usage = "set the git repository to operate on")
+	private File gitdir;
+
+	@Argument(index = 0, metaVar = "command", required = true, handler = SubcommandHandler.class)
+	private TextBuiltin subcommand;
+
+	@Argument(index = 1, metaVar = "ARG")
+	private List<String> arguments = new ArrayList<String>();
 
 	/**
 	 * Execute the command line.
@@ -59,23 +77,24 @@ public class Main {
 	 *            arguments.
 	 */
 	public static void main(final String[] argv) {
+		final Main me = new Main();
 		try {
 			AwtAuthenticator.install();
 			HttpSupport.configureHttpProxy();
-			execute(argv);
+			me.execute(argv);
 		} catch (Die err) {
 			System.err.println("fatal: " + err.getMessage());
-			if (showStackTrace)
+			if (me.showStackTrace)
 				err.printStackTrace();
 			System.exit(128);
 		} catch (Exception err) {
-			if (!showStackTrace && err.getCause() != null
+			if (!me.showStackTrace && err.getCause() != null
 					&& err instanceof TransportException)
 				System.err.println("fatal: " + err.getCause().getMessage());
 
 			if (err.getClass().getName().startsWith("org.spearce.jgit.errors.")) {
 				System.err.println("fatal: " + err.getMessage());
-				if (showStackTrace)
+				if (me.showStackTrace)
 					err.printStackTrace();
 				System.exit(128);
 			}
@@ -84,24 +103,28 @@ public class Main {
 		}
 	}
 
-	private static void execute(final String[] argv) throws Exception {
-		int argi = 0;
+	private void execute(final String[] argv) throws Exception {
+		final CmdLineParser clp = new CmdLineParser(this);
+		try {
+			clp.parseArgument(argv);
+		} catch (CmdLineException err) {
+			if (argv.length > 0 && !help) {
+				System.err.println("fatal: " + err.getMessage());
+				System.exit(1);
+			}
+		}
 
-		File gitdir = null;
-		for (; argi < argv.length; argi++) {
-			final String arg = argv[argi];
-			if (arg.startsWith("--git-dir="))
-				gitdir = new File(arg.substring("--git-dir=".length()));
-			else if (arg.equals("--show-stack-trace"))
-				showStackTrace = true;
-			else if (arg.startsWith("--"))
-				usage();
-			else
-				break;
+		if (argv.length == 0 || help) {
+			final String ex = clp.printExample(ExampleMode.ALL);
+			System.err.println("jgit" + ex + " command [ARG ...]");
+			if (help) {
+				System.err.println();
+				clp.printUsage(System.err);
+				System.err.println();
+			}
+			System.exit(1);
 		}
 
-		if (argi == argv.length)
-			usage();
 		if (gitdir == null)
 			gitdir = findGitDir();
 		if (gitdir == null || !gitdir.isDirectory()) {
@@ -109,10 +132,10 @@ public class Main {
 			System.exit(1);
 		}
 
-		final TextBuiltin cmd = createCommand(argv[argi++]);
+		final TextBuiltin cmd = subcommand;
 		cmd.init(new Repository(gitdir));
 		try {
-			cmd.execute(subarray(argv, argi));
+			cmd.execute(arguments.toArray(new String[arguments.size()]));
 		} finally {
 			if (cmd.out != null)
 				cmd.out.flush();
@@ -129,46 +152,4 @@ public class Main {
 		}
 		return null;
 	}
-
-	private static String[] subarray(final String[] argv, final int i) {
-		return Arrays.asList(argv).subList(i, argv.length).toArray(
-				new String[0]);
-	}
-
-	private static TextBuiltin createCommand(final String name) {
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
-		try {
-			return (TextBuiltin) Class.forName(s.toString()).newInstance();
-		} catch (Exception e) {
-			System.err.println("error: " + name + " is not a jgit command.");
-			System.exit(1);
-			return null;
-		}
-	}
-
-	private static String mypackage() {
-		final String p = Main.class.getName();
-		final int dot = p.lastIndexOf('.');
-		return p.substring(0, dot);
-	}
-
-	private static void usage() {
-		System.err.println("jgit [--git-dir=path] cmd ...");
-		System.exit(1);
-	}
 }
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index 05ad211..0f39f11 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -65,12 +65,24 @@ public abstract class TextBuiltin {
 
 	protected static final String REFS_TAGS = Constants.TAGS_PREFIX + "/";
 
+	private String commandName;
+
 	/** Stream to output to, typically this is standard output. */
 	protected PrintWriter out;
 
 	/** Git repository the command was invoked within. */
 	protected Repository db;
 
+	/**
+	 * Set the name this command can be invoked as on the command line.
+	 * 
+	 * @param name
+	 *            the name of the command.
+	 */
+	public void setCommandName(final String name) {
+		commandName = name;
+	}
+
 	void init(final Repository repo) {
 		try {
 			out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(
@@ -93,6 +105,13 @@ public abstract class TextBuiltin {
 	 */
 	public abstract void execute(String[] args) throws Exception;
 
+	/**
+	 * @return the repository this command accesses.
+	 */
+	public Repository getRepository() {
+		return db;
+	}
+
 	protected ObjectId resolve(final String s) throws IOException {
 		final ObjectId r = db.resolve(s);
 		if (r == null)
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java
new file mode 100644
index 0000000..2318a03
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java
@@ -0,0 +1,149 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.pgm.opt;
+
+import java.lang.reflect.Constructor;
+import java.lang.reflect.InvocationTargetException;
+import java.text.MessageFormat;
+
+import org.kohsuke.args4j.CmdLineException;
+import org.kohsuke.args4j.CmdLineParser;
+import org.kohsuke.args4j.OptionDef;
+import org.kohsuke.args4j.spi.OptionHandler;
+import org.kohsuke.args4j.spi.Parameters;
+import org.kohsuke.args4j.spi.Setter;
+import org.spearce.jgit.pgm.Main;
+import org.spearce.jgit.pgm.TextBuiltin;
+
+/**
+ * Custom Argument handler for jgit command selection.
+ * <p>
+ * Translates a single argument string to a {@link TextBuiltin} instance which
+ * we can execute at runtime with the remaining arguments of the parser.
+ */
+public class SubcommandHandler extends OptionHandler<TextBuiltin> {
+	private static String mypackage() {
+		final String p = Main.class.getName();
+		final int dot = p.lastIndexOf('.');
+		return p.substring(0, dot);
+	}
+
+	/**
+	 * Create a new handler for the command name.
+	 * <p>
+	 * This constructor is used only by args4j.
+	 * 
+	 * @param parser
+	 * @param option
+	 * @param setter
+	 */
+	public SubcommandHandler(final CmdLineParser parser,
+			final OptionDef option, final Setter<? super TextBuiltin> setter) {
+		super(parser, option, setter);
+	}
+
+	@Override
+	public int parseArguments(final Parameters params) throws CmdLineException {
+		final String name = params.getParameter(0);
+		final StringBuilder s = new StringBuilder();
+		s.append(mypackage());
+		s.append('.');
+		boolean upnext = true;
+		for (int i = 0; i < name.length(); i++) {
+			final char c = name.charAt(i);
+			if (c == '-') {
+				upnext = true;
+				continue;
+			}
+			if (upnext)
+				s.append(Character.toUpperCase(c));
+			else
+				s.append(c);
+			upnext = false;
+		}
+
+		final Class<?> clazz;
+		try {
+			clazz = Class.forName(s.toString());
+		} catch (ClassNotFoundException e) {
+			throw new CmdLineException(MessageFormat.format(
+					"{0} is not a jgit command", name));
+		}
+
+		if (!TextBuiltin.class.isAssignableFrom(clazz))
+			throw new CmdLineException(MessageFormat.format(
+					"{0} is not a jgit command", name));
+
+		final Constructor<?> cons;
+		try {
+			cons = clazz.getDeclaredConstructor();
+		} catch (SecurityException e) {
+			throw new CmdLineException("Cannot create " + name, e);
+		} catch (NoSuchMethodException e) {
+			throw new CmdLineException("Cannot create " + name, e);
+		}
+		cons.setAccessible(true);
+
+		final TextBuiltin cmd;
+		try {
+			cmd = (TextBuiltin) cons.newInstance();
+		} catch (InstantiationException e) {
+			throw new CmdLineException("Cannot create " + name, e);
+		} catch (IllegalAccessException e) {
+			throw new CmdLineException("Cannot create " + name, e);
+		} catch (InvocationTargetException e) {
+			throw new CmdLineException("Cannot create " + name, e);
+		}
+
+		cmd.setCommandName(name);
+		setter.addValue(cmd);
+
+		// Force option parsing to stop. Everything after us should
+		// be arguments known only to this command and must not be
+		// recognized by the current parser.
+		//
+		owner.stopOptionParsing();
+
+		return 1;
+	}
+
+	@Override
+	public String getDefaultMetaVariable() {
+		return "command";
+	}
+}
-- 
1.5.6.3.569.ga9185
