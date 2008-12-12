From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 13/15] Patch parse test comparing "git log -p" output to "git log --numstat"
Date: Thu, 11 Dec 2008 18:46:19 -0800
Message-ID: <1229049981-14152-14-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
 <1229049981-14152-5-git-send-email-spearce@spearce.org>
 <1229049981-14152-6-git-send-email-spearce@spearce.org>
 <1229049981-14152-7-git-send-email-spearce@spearce.org>
 <1229049981-14152-8-git-send-email-spearce@spearce.org>
 <1229049981-14152-9-git-send-email-spearce@spearce.org>
 <1229049981-14152-10-git-send-email-spearce@spearce.org>
 <1229049981-14152-11-git-send-email-spearce@spearce.org>
 <1229049981-14152-12-git-send-email-spearce@spearce.org>
 <1229049981-14152-13-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy54-00057A-5O
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513AbYLLCrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757420AbYLLCrD
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:47:03 -0500
Received: from george.spearce.org ([209.20.77.23]:41602 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307AbYLLCqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:35 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 30F2338222; Fri, 12 Dec 2008 02:46:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4989B38211;
	Fri, 12 Dec 2008 02:46:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-13-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102871>

By comparing the output of "git log -p", once parsed by our patch
parser class, to the output of "git log --numstat" we can be quite
certain we are reading the patches from Git with a high degree of
accuracy, at least for typical add/remove sorts of changes (no
rename detection).

Unfortunately two commits in our history produce an off-by-one bug
in git log --numstat.  The bug appears to be in log --numstat and
not in JGit as git apply --numstat matches JGit's result, and is
thus also differing from log --numstat.  Since this occurs on only
2 commits out of 1,211 processed during the test I'm not worrying
about the difference on these two items.  Besides the numbers from
JGit and git apply --numstat look to be more correct.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/patch/EGitPatchHistoryTest.java   |  221 ++++++++++++++++++++
 1 files changed, 221 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java

diff --git a/org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java b/org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java
new file mode 100644
index 0000000..d0c2632
--- /dev/null
+++ b/org.spearce.jgit.test/exttst/org/spearce/jgit/patch/EGitPatchHistoryTest.java
@@ -0,0 +1,221 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.patch;
+
+import java.io.BufferedReader;
+import java.io.IOException;
+import java.io.InputStreamReader;
+import java.io.UnsupportedEncodingException;
+import java.util.HashMap;
+import java.util.HashSet;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.util.MutableInteger;
+import org.spearce.jgit.util.RawParseUtils;
+import org.spearce.jgit.util.TemporaryBuffer;
+
+public class EGitPatchHistoryTest extends TestCase {
+	public void testParseHistory() throws Exception {
+		final NumStatReader numstat = new NumStatReader();
+		numstat.read();
+
+		final HashMap<String, HashMap<String, StatInfo>> stats = numstat.stats;
+		assertEquals(1211, stats.size());
+
+		new PatchReader(stats).read();
+	}
+
+	static class StatInfo {
+		int added, deleted;
+	}
+
+	static class PatchReader extends CommitReader {
+		final HashSet<String> offBy1;
+
+		final HashMap<String, HashMap<String, StatInfo>> stats;
+
+		int errors;
+
+		PatchReader(final HashMap<String, HashMap<String, StatInfo>> s)
+				throws IOException {
+			super(new String[] { "-p" });
+			stats = s;
+
+			offBy1 = new HashSet<String>();
+			offBy1.add("9bda5ece6806cd797416eaa47c7b927cc6e9c3b2");
+		}
+
+		@Override
+		void onCommit(String cid, byte[] buf) {
+			final HashMap<String, StatInfo> files = stats.remove(cid);
+			assertNotNull("No files for " + cid, files);
+
+			final Patch p = new Patch();
+			p.parse(buf, 0, buf.length - 1);
+			assertEquals("File count " + cid, files.size(), p.getFiles().size());
+			if (!p.getErrors().isEmpty()) {
+				for (final FormatError e : p.getErrors()) {
+					System.out.println("error " + e.getMessage());
+					System.out.println("  at " + e.getLineText());
+				}
+				dump(buf);
+				fail("Unexpected error in " + cid);
+			}
+
+			for (final FileHeader fh : p.getFiles()) {
+				final String fileName;
+				if (fh.getChangeType() != FileHeader.ChangeType.DELETE)
+					fileName = fh.getNewName();
+				else
+					fileName = fh.getOldName();
+				final StatInfo s = files.remove(fileName);
+				final String nid = fileName + " in " + cid;
+				assertNotNull("No " + nid, s);
+				int added = 0, deleted = 0;
+				for (final HunkHeader h : fh.getHunks()) {
+					added += h.getLinesAdded();
+					deleted += h.getLinesDeleted();
+				}
+
+				if (s.added == added) {
+					//
+				} else if (s.added == added + 1 && offBy1.contains(cid)) {
+					//
+				} else {
+					dump(buf);
+					assertEquals("Added diff in " + nid, s.added, added);
+				}
+
+				if (s.deleted == deleted) {
+					//
+				} else if (s.deleted == deleted + 1 && offBy1.contains(cid)) {
+					//
+				} else {
+					dump(buf);
+					assertEquals("Deleted diff in " + nid, s.deleted, deleted);
+				}
+			}
+			assertTrue("Missed files in " + cid, files.isEmpty());
+		}
+
+		private static void dump(final byte[] buf) {
+			String str;
+			try {
+				str = new String(buf, 0, buf.length - 1, "ISO-8859-1");
+			} catch (UnsupportedEncodingException e) {
+				throw new RuntimeException(e);
+			}
+			System.out.println("<<" + str + ">>");
+		}
+	}
+
+	static class NumStatReader extends CommitReader {
+		final HashMap<String, HashMap<String, StatInfo>> stats = new HashMap<String, HashMap<String, StatInfo>>();
+
+		NumStatReader() throws IOException {
+			super(new String[] { "--numstat" });
+		}
+
+		@Override
+		void onCommit(String commitId, byte[] buf) {
+			final HashMap<String, StatInfo> files = new HashMap<String, StatInfo>();
+			final MutableInteger ptr = new MutableInteger();
+			while (ptr.value < buf.length) {
+				if (buf[ptr.value] == '\n')
+					break;
+				final StatInfo i = new StatInfo();
+				i.added = RawParseUtils.parseBase10(buf, ptr.value, ptr);
+				i.deleted = RawParseUtils.parseBase10(buf, ptr.value + 1, ptr);
+				final int eol = RawParseUtils.nextLF(buf, ptr.value);
+				final String name = RawParseUtils.decode(Constants.CHARSET,
+						buf, ptr.value + 1, eol - 1);
+				files.put(name, i);
+				ptr.value = eol;
+			}
+			stats.put(commitId, files);
+		}
+	}
+
+	static abstract class CommitReader {
+		private Process proc;
+
+		CommitReader(final String[] args) throws IOException {
+			final String[] realArgs = new String[3 + args.length + 1];
+			realArgs[0] = "git";
+			realArgs[1] = "log";
+			realArgs[2] = "--pretty=format:commit %H";
+			System.arraycopy(args, 0, realArgs, 3, args.length);
+			realArgs[3 + args.length] = "a4b98ed15ea5f165a7aa0f2fd2ea6fcce6710925";
+
+			proc = Runtime.getRuntime().exec(realArgs);
+			proc.getOutputStream().close();
+			proc.getErrorStream().close();
+		}
+
+		void read() throws IOException, InterruptedException {
+			final BufferedReader in = new BufferedReader(new InputStreamReader(
+					proc.getInputStream(), "ISO-8859-1"));
+			String commitId = null;
+			TemporaryBuffer buf = null;
+			for (;;) {
+				String line = in.readLine();
+				if (line == null)
+					break;
+				if (line.startsWith("commit ")) {
+					if (buf != null) {
+						buf.close();
+						onCommit(commitId, buf.toByteArray());
+						buf.destroy();
+					}
+					commitId = line.substring("commit ".length());
+					buf = new TemporaryBuffer();
+				} else if (buf != null) {
+					buf.write(line.getBytes("ISO-8859-1"));
+					buf.write('\n');
+				}
+			}
+			in.close();
+			assertEquals(0, proc.waitFor());
+			proc = null;
+		}
+
+		abstract void onCommit(String commitId, byte[] buf);
+	}
+}
-- 
1.6.1.rc2.306.ge5d5e
