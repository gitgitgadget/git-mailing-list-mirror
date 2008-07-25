From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 9/9] Add debug-show-commands to display the command table
Date: Fri, 25 Jul 2008 12:46:07 -0700
Message-ID: <1217015167-4680-10-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
 <1217015167-4680-2-git-send-email-spearce@spearce.org>
 <1217015167-4680-3-git-send-email-spearce@spearce.org>
 <1217015167-4680-4-git-send-email-spearce@spearce.org>
 <1217015167-4680-5-git-send-email-spearce@spearce.org>
 <1217015167-4680-6-git-send-email-spearce@spearce.org>
 <1217015167-4680-7-git-send-email-spearce@spearce.org>
 <1217015167-4680-8-git-send-email-spearce@spearce.org>
 <1217015167-4680-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTGg-0005n2-Uv
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYGYTqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbYGYTq1
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:27 -0400
Received: from george.spearce.org ([209.20.77.23]:45934 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbYGYTqN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A5AD0383A5; Fri, 25 Jul 2008 19:46:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D6626383A8;
	Fri, 25 Jul 2008 19:46:11 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90103>

This can be useful to debug the command catalog.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    2 +
 .../src/org/spearce/jgit/pgm/CommandRef.java       |    7 ++
 .../org/spearce/jgit/pgm/debug/ShowCommands.java   |   78 ++++++++++++++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCommands.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 69ef046..1ff5a30 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -10,3 +10,5 @@ org.spearce.jgit.pgm.Push
 org.spearce.jgit.pgm.RevList
 org.spearce.jgit.pgm.ShowRev
 org.spearce.jgit.pgm.Tag
+
+org.spearce.jgit.pgm.debug.ShowCommands
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java
index 40400a7..8bf784b 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java
@@ -120,6 +120,13 @@ public class CommandRef {
 	}
 
 	/**
+	 * @return loader for {@link #getImplementationClassName()}.
+	 */
+	public ClassLoader getImplementationClassLoader() {
+		return impl.getClassLoader();
+	}
+
+	/**
 	 * @return a new instance of the command implementation.
 	 */
 	public TextBuiltin create() {
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCommands.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCommands.java
new file mode 100644
index 0000000..64ecf7f
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCommands.java
@@ -0,0 +1,78 @@
+package org.spearce.jgit.pgm.debug;
+
+import java.net.URL;
+
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.pgm.Command;
+import org.spearce.jgit.pgm.CommandCatalog;
+import org.spearce.jgit.pgm.CommandRef;
+import org.spearce.jgit.pgm.TextBuiltin;
+
+@Command(usage = "Display a list of all registered jgit commands")
+class ShowCommands extends TextBuiltin {
+	@Option(name = "--pretty", usage = "alter the detail shown")
+	private Format pretty = Format.USAGE;
+
+	@Override
+	protected void run() throws Exception {
+		final CommandRef[] list = CommandCatalog.all();
+
+		int width = 0;
+		for (final CommandRef c : list)
+			width = Math.max(width, c.getName().length());
+		width += 2;
+
+		for (final CommandRef c : list) {
+			System.err.print(c.isCommon() ? '*' : ' ');
+			System.err.print(' ');
+
+			System.err.print(c.getName());
+			for (int i = c.getName().length(); i < width; i++)
+				System.err.print(' ');
+
+			pretty.print(c);
+			System.err.println();
+		}
+		System.err.println();
+	}
+
+	static enum Format {
+		/** */
+		USAGE {
+			void print(final CommandRef c) {
+				System.err.print(c.getUsage());
+			}
+		},
+
+		/** */
+		CLASSES {
+			void print(final CommandRef c) {
+				System.err.print(c.getImplementationClassName());
+			}
+		},
+
+		/** */
+		URLS {
+			void print(final CommandRef c) {
+				final ClassLoader ldr = c.getImplementationClassLoader();
+
+				String cn = c.getImplementationClassName();
+				cn = cn.replace('.', '/') + ".class";
+
+				final URL url = ldr.getResource(cn);
+				if (url == null) {
+					System.err.print("!! NOT FOUND !!");
+					return;
+				}
+
+				String rn = url.toExternalForm();
+				if (rn.endsWith(cn))
+					rn = rn.substring(0, rn.length() - cn.length());
+
+				System.err.print(rn);
+			}
+		};
+
+		abstract void print(CommandRef c);
+	}
+}
-- 
1.6.0.rc0.182.gb96c7
