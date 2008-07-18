From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/28] Add option handler for AbstractTreeIterator values
Date: Thu, 17 Jul 2008 21:44:02 -0400
Message-ID: <1216345461-59382-10-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
 <1216345461-59382-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:46:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2s-00060p-S9
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757950AbYGRBpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758627AbYGRBpF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:05 -0400
Received: from george.spearce.org ([209.20.77.23]:47013 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757784AbYGRBor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:47 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0A48A3851C; Fri, 18 Jul 2008 01:44:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6F42A38420;
	Fri, 18 Jul 2008 01:44:26 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88957>

Converts String to AbstractTreeIterator on demand.  A string
that can be resolved as a RevTree is read with a canonical
tree iterator, as it is a standard Git tree already stored in
the object database.  Otherwise we assume it is a local file
and scan the filesystem, as it may be a working directory.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |  121 ++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
new file mode 100644
index 0000000..31d1c84
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
@@ -0,0 +1,121 @@
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
+import java.io.File;
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
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
+import org.spearce.jgit.treewalk.CanonicalTreeParser;
+import org.spearce.jgit.treewalk.FileTreeIterator;
+
+/**
+ * Custom argument handler {@link AbstractTreeIterator} from string values.
+ * <p>
+ * Assumes the parser has been initialized with a Repository.
+ */
+public class AbstractTreeIteratorHandler extends
+		OptionHandler<AbstractTreeIterator> {
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
+	public AbstractTreeIteratorHandler(final CmdLineParser parser,
+			final OptionDef option,
+			final Setter<? super AbstractTreeIterator> setter) {
+		super(parser, option, setter);
+		clp = (org.spearce.jgit.pgm.opt.CmdLineParser) parser;
+	}
+
+	@Override
+	public int parseArguments(final Parameters params) throws CmdLineException {
+		final String name = params.getParameter(0);
+
+		if (new File(name).isDirectory()) {
+			setter.addValue(new FileTreeIterator(new File(name)));
+			return 1;
+		}
+
+		final ObjectId id;
+		try {
+			id = clp.getRepository().resolve(name);
+		} catch (IOException e) {
+			throw new CmdLineException(e.getMessage());
+		}
+		if (id == null)
+			throw new CmdLineException(name + " is not a tree");
+
+		final CanonicalTreeParser p = new CanonicalTreeParser();
+		try {
+			p.reset(clp.getRepository(), clp.getRevWalk().parseTree(id));
+		} catch (ClassCastException e) {
+			throw new CmdLineException(name + " is not a tree");
+		} catch (MissingObjectException e) {
+			throw new CmdLineException(name + " is not a tree");
+		} catch (IncorrectObjectTypeException e) {
+			throw new CmdLineException(name + " is not a tree");
+		} catch (IOException e) {
+			throw new CmdLineException("cannot read " + name + ": "
+					+ e.getMessage());
+		}
+
+		setter.addValue(p);
+		return 1;
+	}
+
+	@Override
+	public String getDefaultMetaVariable() {
+		return "tree-ish";
+	}
+}
-- 
1.5.6.3.569.ga9185
