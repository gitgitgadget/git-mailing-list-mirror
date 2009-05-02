From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/6] Add diff.DiffFormatter to create Git style unified patch scripts
Date: Fri,  1 May 2009 19:08:47 -0700
Message-ID: <1241230127-28279-7-git-send-email-spearce@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org>
 <1241230127-28279-2-git-send-email-spearce@spearce.org>
 <1241230127-28279-3-git-send-email-spearce@spearce.org>
 <1241230127-28279-4-git-send-email-spearce@spearce.org>
 <1241230127-28279-5-git-send-email-spearce@spearce.org>
 <1241230127-28279-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org,
	"Johannes E. Schindelin" <johannes.schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 02 04:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04fP-0003rn-BH
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 04:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbZEBCJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 22:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZEBCJW
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 22:09:22 -0400
Received: from george.spearce.org ([209.20.77.23]:48670 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbZEBCJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 22:09:13 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9FB983807E; Sat,  2 May 2009 02:09:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 95AB838083;
	Sat,  2 May 2009 02:08:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
In-Reply-To: <1241230127-28279-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118122>

From: Johannes E. Schindelin <johannes.schindelin@gmx.de>

Currently the formatter can only copy an existing FileHeader, one
that has been parsed from an existing patch script.  This makes
it only useful for increasing or decreasing the number of lines
of context, assuming we already have both the old and new contet
images to match.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/diff/DiffFormatter.java   |  187 ++++++++++++++++++++
 1 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java b/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
new file mode 100644
index 0000000..aa0f4a6
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/DiffFormatter.java
@@ -0,0 +1,187 @@
+/*
+ * Copyright (C) 2008, Johannes E. Schindelin <johannes.schindelin@gmx.de>
+ * Copyright (C) 2009, Google Inc.
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
+package org.spearce.jgit.diff;
+
+import static org.spearce.jgit.lib.Constants.encodeASCII;
+
+import java.io.IOException;
+import java.io.OutputStream;
+import java.util.List;
+
+import org.spearce.jgit.patch.FileHeader;
+
+/**
+ * Format an {@link EditList} as a Git style unified patch script.
+ */
+public class DiffFormatter {
+	private int context;
+
+	/** Create a new formatter with a default level of context. */
+	public DiffFormatter() {
+		setContext(3);
+	}
+
+	/**
+	 * Change the number of lines of context to display.
+	 * 
+	 * @param lineCount
+	 *            number of lines of context to see before the first
+	 *            modification and after the last modification within a hunk of
+	 *            the modified file.
+	 */
+	public void setContext(final int lineCount) {
+		if (lineCount < 0)
+			throw new IllegalArgumentException("context must be >= 0");
+		context = lineCount;
+	}
+
+	/**
+	 * Format a patch script, reusing a previously parsed FileHeader.
+	 * <p>
+	 * This formatter is primarily useful for editing an existing patch script
+	 * to increase or reduce the number of lines of context within the script.
+	 * All header lines are reused as-is from the supplied FileHeader.
+	 * 
+	 * @param out
+	 *            stream to write the patch script out to.
+	 * @param head
+	 *            existing file header containing the header lines to copy.
+	 * @param a
+	 *            text source for the pre-image version of the content. This
+	 *            must match the content of {@link FileHeader#getOldId()}.
+	 * @param b
+	 *            text source for the post-image version of the content. This
+	 *            must match the content of {@link FileHeader#getNewId()}.
+	 * @throws IOException
+	 *             writing to the supplied stream failed.
+	 */
+	public void format(final OutputStream out, final FileHeader head,
+			final RawText a, final RawText b)
+			throws IOException {
+		// Reuse the existing FileHeader as-is by blindly copying its
+		// header lines, but avoiding its hunks. Instead we recreate
+		// the hunks from the text instances we have been supplied.
+		//
+		final int start = head.getStartOffset();
+		int end = head.getEndOffset();
+		if (!head.getHunks().isEmpty())
+			end = head.getHunks().get(0).getStartOffset();
+		out.write(head.getBuffer(), start, end - start);
+
+		formatEdits(out, a, b, head.toEditList());
+	}
+
+	private void formatEdits(final OutputStream out, final RawText a,
+			final RawText b, final EditList edits) throws IOException {
+		for (int curIdx = 0; curIdx < edits.size();) {
+			Edit curEdit = edits.get(curIdx);
+			final int endIdx = findCombinedEnd(edits, curIdx);
+			final Edit endEdit = edits.get(endIdx);
+
+			int aCur = Math.max(0, curEdit.getBeginA() - context);
+			int bCur = Math.max(0, curEdit.getBeginB() - context);
+			final int aEnd = Math.min(a.size(), endEdit.getEndA() + context);
+			final int bEnd = Math.min(b.size(), endEdit.getEndB() + context);
+
+			out.write('@');
+			out.write('@');
+			writeLineGroup(out, '-', aCur + 1, aEnd - aCur);
+			writeLineGroup(out, '+', bCur + 1, bEnd - bCur);
+			out.write(' ');
+			out.write('@');
+			out.write('@');
+			out.write('\n');
+
+			while (aCur < aEnd || bCur < bEnd) {
+				if (aCur < curEdit.getBeginA() || endIdx + 1 < curIdx) {
+					out.write(' ');
+					a.writeLine(out, aCur);
+					out.write('\n');
+					aCur++;
+					bCur++;
+
+				} else if (aCur < curEdit.getEndA()) {
+					out.write('-');
+					a.writeLine(out, aCur);
+					out.write('\n');
+					aCur++;
+
+				} else if (bCur < curEdit.getEndB()) {
+					out.write('+');
+					b.writeLine(out, bCur);
+					out.write('\n');
+					bCur++;
+				}
+
+				if (!in(curEdit, aCur, bCur) && ++curIdx < edits.size())
+					curEdit = edits.get(curIdx);
+			}
+		}
+	}
+
+	private static void writeLineGroup(final OutputStream out,
+			final char prefix, final int begin, final int end)
+			throws IOException {
+		out.write(' ');
+		out.write(prefix);
+		out.write(encodeASCII(begin));
+		out.write(',');
+		out.write(encodeASCII(end));
+	}
+
+	private int findCombinedEnd(final List<Edit> edits, final int i) {
+		int end = i + 1;
+		while (end < edits.size()
+				&& (combineA(edits, end) || combineB(edits, end)))
+			end++;
+		return end - 1;
+	}
+
+	private boolean combineA(final List<Edit> e, final int i) {
+		return e.get(i).getBeginA() - e.get(i - 1).getEndA() <= 2 * context;
+	}
+
+	private boolean combineB(final List<Edit> e, final int i) {
+		return e.get(i).getBeginB() - e.get(i - 1).getEndB() <= 2 * context;
+	}
+
+	private static boolean in(final Edit edit, final int a, final int b) {
+		return a < edit.getEndA() && b < edit.getEndB();
+	}
+}
-- 
1.6.3.rc3.212.g8c698
