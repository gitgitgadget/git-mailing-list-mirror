From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/28] Add option handler for PathTreeFilter values
Date: Thu, 17 Jul 2008 21:44:04 -0400
Message-ID: <1216345461-59382-12-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4B-0006LD-Kw
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758679AbYGRBpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758638AbYGRBpK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:10 -0400
Received: from george.spearce.org ([209.20.77.23]:47015 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757897AbYGRBos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4233B38569; Fri, 18 Jul 2008 01:44:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2DD0638262;
	Fri, 18 Jul 2008 01:44:27 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88961>

Converts one or more Strings, up to the end of the command line,
into a PathFilterGroup.  The filter group can be used with a
TreeWalk to limit its results.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/pgm/opt/PathTreeFilterHandler.java        |  102 ++++++++++++++++++++
 1 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java
new file mode 100644
index 0000000..8a0b5a6
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java
@@ -0,0 +1,102 @@
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
+import java.util.List;
+
+import org.kohsuke.args4j.CmdLineException;
+import org.kohsuke.args4j.CmdLineParser;
+import org.kohsuke.args4j.Option;
+import org.kohsuke.args4j.OptionDef;
+import org.kohsuke.args4j.spi.OptionHandler;
+import org.kohsuke.args4j.spi.Parameters;
+import org.kohsuke.args4j.spi.Setter;
+import org.spearce.jgit.treewalk.filter.PathFilter;
+import org.spearce.jgit.treewalk.filter.PathFilterGroup;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+
+/**
+ * Create a {@link TreeFilter} to patch math names.
+ * <p>
+ * This handler consumes all arguments to the end of the command line, and is
+ * meant to be used on an {@link Option} of name "--".
+ */
+public class PathTreeFilterHandler extends OptionHandler<TreeFilter> {
+	/**
+	 * Create a new handler for the command name.
+	 * <p>
+	 * This constructor is used only by args4j.
+	 * 
+	 * @param parser
+	 * @param option
+	 * @param setter
+	 */
+	public PathTreeFilterHandler(final CmdLineParser parser,
+			final OptionDef option, final Setter<? super TreeFilter> setter) {
+		super(parser, option, setter);
+	}
+
+	@Override
+	public int parseArguments(final Parameters params) throws CmdLineException {
+		final List<PathFilter> filters = new ArrayList<PathFilter>();
+		for (int idx = 0;; idx++) {
+			final String path;
+			try {
+				path = params.getParameter(idx);
+			} catch (CmdLineException cle) {
+				break;
+			}
+			filters.add(PathFilter.create(path));
+		}
+
+		if (filters.size() == 0)
+			return 0;
+		if (filters.size() == 1) {
+			setter.addValue(filters.get(0));
+			return 1;
+		}
+		setter.addValue(PathFilterGroup.create(filters));
+		return filters.size();
+	}
+
+	@Override
+	public String getDefaultMetaVariable() {
+		return "path ...";
+	}
+}
-- 
1.5.6.3.569.ga9185
