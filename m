From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/9] Create a lightweight registration wrapper for TextBuiltin
Date: Fri, 25 Jul 2008 12:46:02 -0700
Message-ID: <1217015167-4680-5-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
 <1217015167-4680-2-git-send-email-spearce@spearce.org>
 <1217015167-4680-3-git-send-email-spearce@spearce.org>
 <1217015167-4680-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTG1-0005XG-FH
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYGYTqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbYGYTqR
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:17 -0400
Received: from george.spearce.org ([209.20.77.23]:45934 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYGYTqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:11 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A59EC3841D; Fri, 25 Jul 2008 19:46:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A4D48383A5;
	Fri, 25 Jul 2008 19:46:09 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90099>

Automatic command list generation requires knowing what commands
are available to this runtime, and what name those commands can be
called as by the end-user.  This lightweight wrappers carries the
data from the Command annotation, possibly filling in the name of
the command by generating it from the implementation class name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/CommandRef.java       |  151 ++++++++++++++++++++
 1 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java
new file mode 100644
index 0000000..40400a7
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java
@@ -0,0 +1,151 @@
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
+import java.lang.reflect.Constructor;
+import java.lang.reflect.InvocationTargetException;
+
+/**
+ * Description of a command (a {@link TextBuiltin} subclass.
+ * <p>
+ * These descriptions are lightweight compared to creating a command instance
+ * and are therefore suitable for catalogs of "known" commands without linking
+ * the command's implementation and creating a dummy instance of the command.
+ */
+public class CommandRef {
+	private final Class<? extends TextBuiltin> impl;
+
+	private final String name;
+
+	private String usage;
+
+	boolean common;
+
+	CommandRef(final Class<? extends TextBuiltin> clazz) {
+		this(clazz, guessName(clazz));
+	}
+
+	CommandRef(final Class<? extends TextBuiltin> clazz, final Command cmd) {
+		this(clazz, cmd.name().length() > 0 ? cmd.name() : guessName(clazz));
+		usage = cmd.usage();
+		common = cmd.common();
+	}
+
+	private CommandRef(final Class<? extends TextBuiltin> clazz, final String cn) {
+		impl = clazz;
+		name = cn;
+		usage = "";
+	}
+
+	private static String guessName(final Class<? extends TextBuiltin> clazz) {
+		final StringBuilder s = new StringBuilder();
+		if (clazz.getName().startsWith("org.spearce.jgit.pgm.debug."))
+			s.append("debug-");
+
+		boolean lastWasDash = true;
+		for (final char c : clazz.getSimpleName().toCharArray()) {
+			if (Character.isUpperCase(c)) {
+				if (!lastWasDash)
+					s.append('-');
+				lastWasDash = !lastWasDash;
+				s.append(Character.toLowerCase(c));
+			} else {
+				s.append(c);
+			}
+		}
+		return s.toString();
+	}
+
+	/**
+	 * @return name the command is invoked as from the command line.
+	 */
+	public String getName() {
+		return name;
+	}
+
+	/**
+	 * @return one line description of the command's feature set.
+	 */
+	public String getUsage() {
+		return usage;
+	}
+
+	/**
+	 * @return true if this command is considered to be commonly used.
+	 */
+	public boolean isCommon() {
+		return common;
+	}
+
+	/**
+	 * @return name of the Java class which implements this command.
+	 */
+	public String getImplementationClassName() {
+		return impl.getName();
+	}
+
+	/**
+	 * @return a new instance of the command implementation.
+	 */
+	public TextBuiltin create() {
+		final Constructor<? extends TextBuiltin> c;
+		try {
+			c = impl.getDeclaredConstructor();
+		} catch (SecurityException e) {
+			throw new RuntimeException("Cannot create command " + getName(), e);
+		} catch (NoSuchMethodException e) {
+			throw new RuntimeException("Cannot create command " + getName(), e);
+		}
+		c.setAccessible(true);
+
+		final TextBuiltin r;
+		try {
+			r = c.newInstance();
+		} catch (InstantiationException e) {
+			throw new RuntimeException("Cannot create command " + getName(), e);
+		} catch (IllegalAccessException e) {
+			throw new RuntimeException("Cannot create command " + getName(), e);
+		} catch (IllegalArgumentException e) {
+			throw new RuntimeException("Cannot create command " + getName(), e);
+		} catch (InvocationTargetException e) {
+			throw new RuntimeException("Cannot create command " + getName(), e);
+		}
+		r.setCommandName(getName());
+		return r;
+	}
+}
-- 
1.6.0.rc0.182.gb96c7
