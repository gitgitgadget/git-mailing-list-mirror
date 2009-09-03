From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 3/5] Add a test class for Myers' diff algorithm
Date: Thu, 3 Sep 2009 12:46:51 +0200 (CEST)
Message-ID: <6363048a79f234bce8c06356aeab07c94eac85a7.1251974493u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de> <cover.1251974493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 03 12:47:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj9qO-000888-9X
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 12:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbZICKq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 06:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbZICKq5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 06:46:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:51163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753723AbZICKq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 06:46:56 -0400
Received: (qmail invoked by alias); 03 Sep 2009 10:46:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp003) with SMTP; 03 Sep 2009 12:46:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6jhIdtIv6lmtzdO/rQpB81UTxm2lje5Y+RUqWPY
	LCHpTxLUykEUyG
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1251974493u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127647>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .../tst/org/spearce/jgit/diff/MyersDiffTest.java   |  103 ++++++++++++++++++++
 1 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/MyersDiffTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/diff/MyersDiffTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/MyersDiffTest.java
new file mode 100644
index 0000000..0d62790
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/diff/MyersDiffTest.java
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2009, Johannes E. Schindelin
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
+import junit.framework.TestCase;
+
+public class MyersDiffTest extends TestCase {
+	public void testAtEnd() {
+		assertDiff("HELLO", "HELL", " -4,1 +4,0");
+	}
+
+	public void testAtStart() {
+		assertDiff("Git", "JGit", " -0,0 +0,1");
+	}
+
+	public void testSimple() {
+		assertDiff("HELLO WORLD", "LOW",
+			" -0,3 +0,0 -5,1 +2,0 -7,4 +3,0");
+		// is ambiguous, could be this, too:
+		// " -0,2 +0,0 -3,1 +1,0 -5,1 +2,0 -7,4 +3,0"
+	}
+
+	public void assertDiff(String a, String b, String edits) {
+		MyersDiff diff = new MyersDiff(toCharArray(a), toCharArray(b));
+System.err.println("edits: " + diff.getEdits());
+		assertEquals(edits, toString(diff.getEdits()));
+	}
+
+	private static String toString(EditList list) {
+		StringBuilder builder = new StringBuilder();
+		for (Edit e : list)
+			builder.append(" -" + e.beginA
+					+ "," + (e.endA - e.beginA)
+				+ " +" + e.beginB + "," + (e.endB - e.beginB));
+		return builder.toString();
+	}
+
+	private static CharArray toCharArray(String s) {
+		return new CharArray(s);
+	}
+
+	protected static String toString(Sequence seq, int begin, int end) {
+		CharArray a = (CharArray)seq;
+		return new String(a.array, begin, end - begin);
+	}
+
+	protected static String toString(CharArray a, CharArray b,
+			int x, int k) {
+		return "(" + x + "," + (k + x)
+			+ (x < 0 ? '<' :
+					(x >= a.array.length ?
+					 '>' : a.array[x]))
+			+ (k + x < 0 ? '<' :
+					(k + x >= b.array.length ?
+					 '>' : b.array[k + x]))
+			+ ")";
+	}
+
+	private static class CharArray implements Sequence {
+		char[] array;
+		public CharArray(String s) { array = s.toCharArray(); }
+		public int size() { return array.length; }
+		public boolean equals(int i, Sequence other, int j) {
+			CharArray o = (CharArray)other;
+			return array[i] == o.array[j];
+		}
+	}
+}
-- 
1.6.4.297.gcb4cc
