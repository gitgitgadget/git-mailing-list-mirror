From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 2/4] Create a fnmatch-style pattern TreeFilter
Date: Tue, 24 Jun 2008 23:20:25 +0200
Message-ID: <1214342427-2077-2-git-send-email-robin.rosenberg@dewire.com>
References: <20080622233525.GJ11793@spearce.org>
 <1214342427-2077-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Florian Koeberle <florianskarten@web.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 23:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBG0z-0000NM-SR
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 23:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYFXVYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 17:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbYFXVY3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 17:24:29 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:34093 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753262AbYFXVY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 17:24:27 -0400
Received: from localhost.localdomain (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A97950028D2DB2; Tue, 24 Jun 2008 23:24:26 +0200
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1214342427-2077-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86147>

This uses Florian's pattern matcher to perform the matching.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../jgit/treewalk/filter/WildCardTreeFilter.java   |  101 ++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java
new file mode 100644
index 0000000..dc3faf9
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java
@@ -0,0 +1,101 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+package org.spearce.jgit.treewalk.filter;
+
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.InvalidPatternException;
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.fnmatch.FileNameMatcher;
+import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+
+/**
+ * This class implements a TreeeFilter that uses the wildcard style pattern
+ * matching like of Posix fnmatch function.
+ */
+public class WildCardTreeFilter extends TreeFilter {
+
+	private final FileNameMatcher matcher;
+
+	private final String pattern;
+
+	protected WildCardTreeFilter(final String pattern) {
+		try {
+			this.pattern = pattern;
+			matcher = new FileNameMatcher(pattern, null);
+		} catch (InvalidPatternException e) {
+			throw new IllegalArgumentException(e);
+		}
+	}
+
+	@Override
+	public TreeFilter clone() {
+		return new WildCardTreeFilter(pattern);
+	}
+
+	@Override
+	public boolean include(TreeWalk walker) throws MissingObjectException,
+			IncorrectObjectTypeException, IOException {
+		matcher.reset();
+		matcher.append(walker.getPathString());
+		if (matcher.isMatch())
+			return true;
+		return false;
+	}
+
+	@Override
+	public boolean shouldBeRecursive() {
+		return true;
+	}
+
+	/**
+	 * Construct a WildCardmatcher like POSIX fnmatch.
+	 *
+	 * @param pattern
+	 *            A POSIX wildcard pattern
+	 * @return a {@link TreeFilter} that matches pattern
+	 * @throws IllegalArgumentException
+	 *             if the pattern is malformed
+	 */
+	public static TreeFilter create(final String pattern) {
+		return new WildCardTreeFilter(pattern);
+	}
+
+}
-- 
1.5.5.1.178.g1f811
