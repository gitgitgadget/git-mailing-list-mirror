From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 01/24] Start of an implementation of a git like command line tool.
Date: Mon, 12 May 2008 22:13:19 +0200
Message-ID: <1210623222-24908-2-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveQD-0006mx-1m
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbYELUNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:13:48 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbYELUNr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:13:47 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40116 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbYELUNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:42 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8F62ADECFD01
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:41 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveOz-00016x-00; Mon, 12 May 2008 22:13:41 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/7rR3f7KmP/olLU0mN2aI1yzeMZMxsgzIuc3dd
	a7YUoRGrmWgqgqNbkuN/x1Dggw+aHVkO5aH+EMLeeBnqdu4Tlz
	lNC7EX3PeZ4fzTyraK9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81921>

Only the "help" command is currenly supported, but it is extendable.

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/pgm/Command.java          |   44 ++++++++
 .../src/org/spearce/jgit/pgm/MainProgram.java      |  114 ++++++++++++=
++++++++
 2 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/Command.j=
ava
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgr=
am.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Command.java b/o=
rg.spearce.jgit/src/org/spearce/jgit/pgm/Command.java
new file mode 100644
index 0000000..a05f707
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Command.java
@@ -0,0 +1,44 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.pgm;
+
+import java.io.IOException;
+
+/**
+ * A command have tasks like the "git-add", "git-help" or "git-init" c=
onsole
+ * commands. Instances of ${link Command} must be immutable.
+ *=20
+ */
+public interface Command {
+	/**
+	 * Executes the specified Command.
+	 *=20
+	 * @param args
+	 *            the arguments which you would pass to the console equiv=
alent
+	 *            of the command.
+	 * @throws IOException
+	 *             for some undefined reasons.
+	 */
+	public void execute(String... args) throws IOException;
+
+	/**
+	 *=20
+	 * @return a short description about what the command does. Short mea=
ns in
+	 *         this context 5 - 10 words.
+	 */
+	public String getShortDescription();
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java=
 b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
new file mode 100644
index 0000000..c9af51c
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
@@ -0,0 +1,114 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.pgm;
+
+import java.io.IOException;
+import java.util.Collections;
+import java.util.HashMap;
+import java.util.Map;
+import java.util.SortedMap;
+import java.util.TreeMap;
+
+/**
+ * A program which works similar like the command git, except that ver=
y view
+ * arguments are supported jet.
+ *=20
+ */
+public class MainProgram {
+	private final static Map<String, Command> commandNameToObjectMap;
+
+	static {
+		final Map<String, Command> commands =3D new HashMap<String, Command>=
();
+		commands.put("help", HelpCommand.INSTANCE);
+		commandNameToObjectMap =3D Collections.unmodifiableMap(commands);
+	}
+
+	/**
+	 * Executes a command with some arguments. There are commands for cre=
ating
+	 * git repositories, tracking files, etc.
+	 *=20
+	 * @param args
+	 *            The first argument specifies the command which should b=
e
+	 *            executed. The other arguments are passed to the command=
=2E
+	 * @throws IOException
+	 *             for some reasons.
+	 */
+	public static void main(String[] args) throws IOException {
+		try {
+			if (args.length =3D=3D 0) {
+				throw new WrongCallException("Require one argument!");
+			}
+			final Command command =3D commandNameToObjectMap.get(args[0]);
+			if (command =3D=3D null) {
+				throw new WrongCallException("Require one argument!");
+			}
+
+			final String[] commandArguments =3D new String[args.length - 1];
+			System.arraycopy(args, 1, commandArguments, 0,
+					commandArguments.length);
+
+			command.execute(commandArguments);
+
+		} catch (WrongCallException e) {
+			System.err.println(e.getMessage());
+			System.err.println();
+			HelpCommand.INSTANCE.execute();
+			System.exit(1);
+		}
+	}
+
+	private static class WrongCallException extends Exception {
+		private static final long serialVersionUID =3D 3643362832429311084L;
+
+		WrongCallException(String message) {
+			super(message);
+		}
+	}
+
+	private static class HelpCommand implements Command {
+		/**
+		 * Use this instance instead of creating a new ${link HelpCommand}. =
You
+		 * don't need to create an instance of this class as it is immutable=
 and
+		 * not configurable.
+		 */
+		public static HelpCommand INSTANCE =3D new HelpCommand();
+
+		public void execute(String... args) throws IOException {
+			System.out
+					.println("Call this program with the following arguments:");
+			System.out
+					.println("commandName commandArgument0 commandArgument1 ...");
+			System.out.println();
+			System.out
+					.println("Currently the following commands are supported:");
+			final SortedMap<String, Command> sortedCommandMap =3D new TreeMap<S=
tring, Command>(
+					MainProgram.commandNameToObjectMap);
+			for (Map.Entry<String, Command> commandEntry : sortedCommandMap
+					.entrySet()) {
+				final String commandName =3D commandEntry.getKey();
+				final String commandDescription =3D commandEntry.getValue()
+						.getShortDescription();
+				System.out.printf("%#10s - %s%n", commandName,
+						commandDescription);
+			}
+		}
+
+		public String getShortDescription() {
+			return "Displays some text about how to use this program.";
+		}
+	}
+}
--=20
1.5.4.3
