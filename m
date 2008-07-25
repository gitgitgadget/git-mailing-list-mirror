From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/9] Create a catalog of CommandRefs for lookup and enumeration
Date: Fri, 25 Jul 2008 12:46:03 -0700
Message-ID: <1217015167-4680-6-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
 <1217015167-4680-2-git-send-email-spearce@spearce.org>
 <1217015167-4680-3-git-send-email-spearce@spearce.org>
 <1217015167-4680-4-git-send-email-spearce@spearce.org>
 <1217015167-4680-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:48:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTGd-0005n2-VX
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbYGYTqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbYGYTqU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:20 -0400
Received: from george.spearce.org ([209.20.77.23]:45938 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYGYTqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3EF0D3841F; Fri, 25 Jul 2008 19:46:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 265E1383A3;
	Fri, 25 Jul 2008 19:46:10 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90105>

The command catalog supports enumerating commands registered through
a services list, converting each entry into a CommandRef and making
that available to callers on demand.  The CommandRef can be later used
to create a command instance or just to obtain documentation about it.

All current commands are listed in the service registration.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |   12 ++
 .../src/org/spearce/jgit/pgm/CommandCatalog.java   |  188 ++++++++++++++++++++
 2 files changed, 200 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandCatalog.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
new file mode 100644
index 0000000..69ef046
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -0,0 +1,12 @@
+org.spearce.jgit.pgm.DiffTree
+org.spearce.jgit.pgm.Fetch
+org.spearce.jgit.pgm.Glog
+org.spearce.jgit.pgm.IndexPack
+org.spearce.jgit.pgm.Log
+org.spearce.jgit.pgm.LsRemote
+org.spearce.jgit.pgm.LsTree
+org.spearce.jgit.pgm.MergeBase
+org.spearce.jgit.pgm.Push
+org.spearce.jgit.pgm.RevList
+org.spearce.jgit.pgm.ShowRev
+org.spearce.jgit.pgm.Tag
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandCatalog.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandCatalog.java
new file mode 100644
index 0000000..13c585c
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandCatalog.java
@@ -0,0 +1,188 @@
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
+package org.spearce.jgit.pgm;
+
+import java.io.BufferedReader;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.InputStreamReader;
+import java.net.URL;
+import java.util.ArrayList;
+import java.util.Arrays;
+import java.util.Collection;
+import java.util.Comparator;
+import java.util.Enumeration;
+import java.util.HashMap;
+import java.util.Map;
+import java.util.Vector;
+
+/**
+ * List of all commands known by jgit's command line tools.
+ * <p>
+ * Commands are implementations of {@link TextBuiltin}, with an optional
+ * {@link Command} class annotation to insert additional documentation or
+ * override the default command name (which is guessed from the class name).
+ * <p>
+ * Commands may be registered by adding them to a services file in the same JAR
+ * (or classes directory) as the command implementation. The service file name
+ * is <code>META-INF/services/org.spearce.jgit.pgm.TextBuiltin</code> and it
+ * contains one concrete implementation class name per line.
+ * <p>
+ * Command registration is identical to Java 6's services, however the catalog
+ * uses a lightweight wrapper to delay creating a command instance as much as
+ * possible. This avoids initializing the AWT or SWT GUI toolkits even if the
+ * command's constructor might require them.
+ */
+public class CommandCatalog {
+	private static final CommandCatalog INSTANCE = new CommandCatalog();
+
+	/**
+	 * Locate a single command by its user friendly name.
+	 *
+	 * @param name
+	 *            name of the command. Typically in dash-lower-case-form, which
+	 *            was derived from the DashLowerCaseForm class name.
+	 * @return the command instance; null if no command exists by that name.
+	 */
+	public static CommandRef get(final String name) {
+		return INSTANCE.commands.get(name);
+	}
+
+	/**
+	 * @return all known commands, sorted by command name.
+	 */
+	public static CommandRef[] all() {
+		return toSortedArray(INSTANCE.commands.values());
+	}
+
+	/**
+	 * @return all common commands, sorted by command name.
+	 */
+	public static CommandRef[] common() {
+		final ArrayList<CommandRef> common = new ArrayList<CommandRef>();
+		for (final CommandRef c : INSTANCE.commands.values())
+			if (c.isCommon())
+				common.add(c);
+		return toSortedArray(common);
+	}
+
+	private static CommandRef[] toSortedArray(final Collection<CommandRef> c) {
+		final CommandRef[] r = c.toArray(new CommandRef[c.size()]);
+		Arrays.sort(r, new Comparator<CommandRef>() {
+			public int compare(final CommandRef o1, final CommandRef o2) {
+				return o1.getName().compareTo(o2.getName());
+			}
+		});
+		return r;
+	}
+
+	private final ClassLoader ldr;
+
+	private final Map<String, CommandRef> commands;
+
+	private CommandCatalog() {
+		ldr = Thread.currentThread().getContextClassLoader();
+		commands = new HashMap<String, CommandRef>();
+
+		final Enumeration<URL> catalogs = catalogs();
+		while (catalogs.hasMoreElements())
+			scan(catalogs.nextElement());
+	}
+
+	private Enumeration<URL> catalogs() {
+		try {
+			final String pfx = "META-INF/services/";
+			return ldr.getResources(pfx + TextBuiltin.class.getName());
+		} catch (IOException err) {
+			return new Vector<URL>().elements();
+		}
+	}
+
+	private void scan(final URL cUrl) {
+		final BufferedReader cIn;
+		try {
+			final InputStream in = cUrl.openStream();
+			cIn = new BufferedReader(new InputStreamReader(in, "UTF-8"));
+		} catch (IOException err) {
+			// If we cannot read from the service list, go to the next.
+			//
+			return;
+		}
+
+		try {
+			String line;
+			while ((line = cIn.readLine()) != null) {
+				if (line.length() > 0 && !line.startsWith("#"))
+					load(line);
+			}
+		} catch (IOException err) {
+			// If we failed during a read, ignore the error.
+			//
+		} finally {
+			try {
+				cIn.close();
+			} catch (IOException e) {
+				// Ignore the close error; we are only reading.
+			}
+		}
+	}
+
+	private void load(final String cn) {
+		final Class<? extends TextBuiltin> clazz;
+		try {
+			clazz = Class.forName(cn, false, ldr).asSubclass(TextBuiltin.class);
+		} catch (ClassNotFoundException notBuiltin) {
+			// Doesn't exist, even though the service entry is present.
+			//
+			return;
+		} catch (ClassCastException notBuiltin) {
+			// Isn't really a builtin, even though its listed as such.
+			//
+			return;
+		}
+
+		final CommandRef cr;
+		final Command a = clazz.getAnnotation(Command.class);
+		if (a != null)
+			cr = new CommandRef(clazz, a);
+		else
+			cr = new CommandRef(clazz);
+
+		commands.put(cr.getName(), cr);
+	}
+}
-- 
1.6.0.rc0.182.gb96c7
