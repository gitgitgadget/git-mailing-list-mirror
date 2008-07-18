From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 13/28] Add option handler for RevCommit values
Date: Thu, 17 Jul 2008 21:44:06 -0400
Message-ID: <1216345461-59382-14-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4C-0006LD-A8
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbYGRBpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758859AbYGRBpU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:20 -0400
Received: from george.spearce.org ([209.20.77.23]:47017 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757928AbYGRBos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 114F038572; Fri, 18 Jul 2008 01:44:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DE18A383A3;
	Fri, 18 Jul 2008 01:44:27 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-13-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88963>

Converts a String into a RevCommit, including parsing the string
with SHA-1 revision syntax and dereferencing through annotated
tags as necessary.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/pgm/opt/RevCommitHandler.java |  141 ++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java
new file mode 100644
index 0000000..266e468
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java
@@ -0,0 +1,141 @@
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
+import java.io.IOException;
+
+import org.kohsuke.args4j.CmdLineException;
+import org.kohsuke.args4j.CmdLineParser;
+import org.kohsuke.args4j.OptionDef;
+import org.kohsuke.args4j.spi.OptionHandler;
+import org.kohsuke.args4j.spi.Parameters;
+import org.kohsuke.args4j.spi.Setter;
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevFlag;
+
+/**
+ * Custom argument handler {@link RevCommit} from string values.
+ * <p>
+ * Assumes the parser has been initialized with a Repository.
+ */
+public class RevCommitHandler extends OptionHandler<RevCommit> {
+	private final org.spearce.jgit.pgm.opt.CmdLineParser clp;
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
+	public RevCommitHandler(final CmdLineParser parser, final OptionDef option,
+			final Setter<? super RevCommit> setter) {
+		super(parser, option, setter);
+		clp = (org.spearce.jgit.pgm.opt.CmdLineParser) parser;
+	}
+
+	@Override
+	public int parseArguments(final Parameters params) throws CmdLineException {
+		String name = params.getParameter(0);
+
+		boolean interesting = true;
+		if (name.startsWith("^")) {
+			name = name.substring(1);
+			interesting = false;
+		}
+
+		final int dot2 = name.indexOf("..");
+		if (dot2 != -1) {
+			if (!option.isMultiValued())
+				throw new CmdLineException("Only one " + option.metaVar()
+						+ " expected in " + name + "." + "");
+
+			final String left = name.substring(0, dot2);
+			final String right = name.substring(dot2 + 2);
+			addOne(left, false);
+			addOne(right, true);
+			return 1;
+		}
+
+		addOne(name, interesting);
+		return 1;
+	}
+
+	private void addOne(final String name, final boolean interesting)
+			throws CmdLineException {
+		final ObjectId id;
+		try {
+			id = clp.getRepository().resolve(name);
+		} catch (IOException e) {
+			throw new CmdLineException(e.getMessage());
+		}
+		if (id == null)
+			throw new CmdLineException(name + " is not a commit");
+
+		final RevCommit c;
+		try {
+			c = clp.getRevWalk().parseCommit(id);
+		} catch (ClassCastException e) {
+			throw new CmdLineException(name + " is not a commit");
+		} catch (MissingObjectException e) {
+			throw new CmdLineException(name + " is not a commit");
+		} catch (IncorrectObjectTypeException e) {
+			throw new CmdLineException(name + " is not a commit");
+		} catch (IOException e) {
+			throw new CmdLineException("cannot read " + name + ": "
+					+ e.getMessage());
+		}
+
+		if (interesting)
+			c.remove(RevFlag.UNINTERESTING);
+		else
+			c.add(RevFlag.UNINTERESTING);
+
+		setter.addValue(c);
+	}
+
+	@Override
+	public String getDefaultMetaVariable() {
+		return "commit-ish";
+	}
+}
-- 
1.5.6.3.569.ga9185
