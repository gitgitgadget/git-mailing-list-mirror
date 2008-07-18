From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 07/28] Define our own extended CmdLineParser for extra parsing support
Date: Thu, 17 Jul 2008 21:44:00 -0400
Message-ID: <1216345461-59382-8-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:46:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2r-00060p-Gc
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758383AbYGRBpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757911AbYGRBo6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:44:58 -0400
Received: from george.spearce.org ([209.20.77.23]:46959 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757696AbYGRBoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 44DA2384FB; Fri, 18 Jul 2008 01:44:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id ADCC93841D;
	Fri, 18 Jul 2008 01:44:25 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88958>

A specialized CmdLineParser subclass is used to automatically handle
`--git-dir=foo`, as args4j wants to see `--git-dir foo` instead.
We split on the first equal sign on a long option and use that to
delimit the value from the option name.

We stop this long option fixup at the first -- found on the command
line, as this is a traditional delimiter between options and only
arguments.  This is an assumption that all of our users of a command
line parser support would want to terminate option parsing at the
first -- they see on the command line, and thus it is OK to stop
our GNU long optino style cleanup.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/pgm/opt/CmdLineParser.java    |  157 ++++++++++++++++++++
 1 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java
new file mode 100644
index 0000000..257d88f
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java
@@ -0,0 +1,157 @@
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
+import java.util.ArrayList;
+
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.CmdLineException;
+import org.kohsuke.args4j.IllegalAnnotationError;
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.pgm.TextBuiltin;
+import org.spearce.jgit.revwalk.RevWalk;
+
+/**
+ * Extended command line parser which handles --foo=value arguments.
+ * <p>
+ * The args4j package does not natively handle --foo=value and instead prefers
+ * to see --foo value on the command line. Many users are used to the GNU style
+ * --foo=value long option, so we convert from the GNU style format to the
+ * args4j style format prior to invoking args4j for parsing.
+ */
+public class CmdLineParser extends org.kohsuke.args4j.CmdLineParser {
+	private final Repository db;
+
+	private RevWalk walk;
+
+	/**
+	 * Creates a new command line owner that parses arguments/options and set
+	 * them into the given object.
+	 * 
+	 * @param bean
+	 *            instance of a class annotated by {@link Option} and
+	 *            {@link Argument}. this object will receive values.
+	 * 
+	 * @throws IllegalAnnotationError
+	 *             if the option bean class is using args4j annotations
+	 *             incorrectly.
+	 */
+	public CmdLineParser(final Object bean) {
+		this(bean, null);
+	}
+
+	/**
+	 * Creates a new command line owner that parses arguments/options and set
+	 * them into the given object.
+	 * 
+	 * @param bean
+	 *            instance of a class annotated by {@link Option} and
+	 *            {@link Argument}. this object will receive values.
+	 * @param repo
+	 *            repository this parser can translate options through.
+	 * @throws IllegalAnnotationError
+	 *             if the option bean class is using args4j annotations
+	 *             incorrectly.
+	 */
+	public CmdLineParser(final Object bean, Repository repo) {
+		super(bean);
+		if (repo == null && bean instanceof TextBuiltin)
+			repo = ((TextBuiltin) bean).getRepository();
+		this.db = repo;
+	}
+
+	@Override
+	public void parseArgument(final String... args) throws CmdLineException {
+		final ArrayList<String> tmp = new ArrayList<String>(args.length);
+		for (int argi = 0; argi < args.length; argi++) {
+			final String str = args[argi];
+			if (str.equals("--")) {
+				while (argi < args.length)
+					tmp.add(args[argi++]);
+				break;
+			}
+
+			if (str.startsWith("--")) {
+				final int eq = str.indexOf('=');
+				if (eq > 0) {
+					tmp.add(str.substring(0, eq));
+					tmp.add(str.substring(eq + 1));
+					continue;
+				}
+			}
+
+			tmp.add(str);
+		}
+
+		super.parseArgument(tmp.toArray(new String[tmp.size()]));
+	}
+
+	/**
+	 * Get the repository this parser translates values through.
+	 * 
+	 * @return the repository, if specified during construction.
+	 */
+	public Repository getRepository() {
+		if (db == null)
+			throw new IllegalStateException("No Git repository configured.");
+		return db;
+	}
+
+	/**
+	 * Get the revision walker used to support option parsing.
+	 * 
+	 * @return the revision walk used by this option parser.
+	 */
+	public RevWalk getRevWalk() {
+		if (walk == null)
+			walk = new RevWalk(getRepository());
+		return walk;
+	}
+
+	/**
+	 * Get the revision walker used to support option parsing.
+	 * <p>
+	 * This method does not initialize the RevWalk and may return null.
+	 * 
+	 * @return the revision walk used by this option parser, or null.
+	 */
+	public RevWalk getRevWalkGently() {
+		return walk;
+	}
+}
-- 
1.5.6.3.569.ga9185
