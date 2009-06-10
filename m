From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH v5 2/7] Add a ref log reader class
Date: Wed, 10 Jun 2009 23:22:20 +0200
Message-ID: <1244668945-12622-3-git-send-email-robin.rosenberg@dewire.com>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-1-git-send-email-robin.rosenberg@dewire.com>
 <1244668945-12622-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jun 10 23:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEVFu-0007hX-5s
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 23:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbZFJVWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbZFJVWe
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 17:22:34 -0400
Received: from mail.dewire.com ([83.140.172.130]:3873 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbZFJVWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 17:22:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D8559147D5A0;
	Wed, 10 Jun 2009 23:22:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TbEMq4RUHwKs; Wed, 10 Jun 2009 23:22:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id C1DCF147D5A9;
	Wed, 10 Jun 2009 23:22:27 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1244668945-12622-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121304>

This reader allows the caller to the reflog entries for a given ref.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../tst/org/spearce/jgit/lib/ReflogReaderTest.java |  166 +++++++++++++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   18 ++
 .../src/org/spearce/jgit/lib/ReflogReader.java     |  187 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   14 ++
 4 files changed, 385 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReflogReaderTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReflogReaderTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReflogReaderTest.java
new file mode 100644
index 0000000..2888da6
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReflogReaderTest.java
@@ -0,0 +1,166 @@
+/*
+ * Copyright (C) 2009, Robin Rosenberg
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
+package org.spearce.jgit.lib;
+
+import java.text.SimpleDateFormat;
+import java.util.Date;
+import java.util.List;
+
+import org.spearce.jgit.lib.ReflogReader.Entry;
+
+public class ReflogReaderTest extends RepositoryTestCase {
+
+	static byte[] oneLine = "da85355dfc525c9f6f3927b876f379f46ccf826e 3e7549db262d1e836d9bf0af7e22355468f1717c Robin Rosenberg <robin.rosenberg@dewire.com> 1243028200 +0200\tcommit: Add a toString for debugging to RemoteRefUpdate\n"
+			.getBytes();
+
+	static byte[] twoLine = ("0000000000000000000000000000000000000000 c6734895958052a9dbc396cff4459dc1a25029ab A U Thor <thor@committer.au> 1243028201 -0100\tbranch: Created from rr/renamebranchv4\n"
+			+ "c6734895958052a9dbc396cff4459dc1a25029ab 54794942a18a237c57a80719afed44bb78172b10 Same A U Thor <same.author@example.com> 1243028202 +0100\trebase finished: refs/heads/rr/renamebranch5 onto c6e3b9fe2da0293f11eae202ec35fb343191a82d\n")
+			.getBytes();
+
+	static byte[] twoLineWithAppendInProgress = ("0000000000000000000000000000000000000000 c6734895958052a9dbc396cff4459dc1a25029ab A U Thor <thor@committer.au> 1243028201 -0100\tbranch: Created from rr/renamebranchv4\n"
+			+ "c6734895958052a9dbc396cff4459dc1a25029ab 54794942a18a237c57a80719afed44bb78172b10 Same A U Thor <same.author@example.com> 1243028202 +0100\trebase finished: refs/heads/rr/renamebranch5 onto c6e3b9fe2da0293f11eae202ec35fb343191a82d\n"
+			+ "54794942a18a237c57a80719afed44bb78172b10 ")
+			.getBytes();
+
+	static byte[] aLine = "1111111111111111111111111111111111111111 3e7549db262d1e836d9bf0af7e22355468f1717c A U Thor <thor@committer.au> 1243028201 -0100\tbranch: change to a\n"
+			.getBytes();
+
+	static byte[] masterLine = "2222222222222222222222222222222222222222 3e7549db262d1e836d9bf0af7e22355468f1717c A U Thor <thor@committer.au> 1243028201 -0100\tbranch: change to master\n"
+			.getBytes();
+
+	static byte[] headLine = "3333333333333333333333333333333333333333 3e7549db262d1e836d9bf0af7e22355468f1717c A U Thor <thor@committer.au> 1243028201 -0100\tbranch: change to HEAD\n"
+			.getBytes();
+
+	public void testReadOneLine() throws Exception {
+		setupReflog("logs/refs/heads/master", oneLine);
+
+		ReflogReader reader = new ReflogReader(db, "refs/heads/master");
+		Entry e = reader.getLastEntry();
+		assertEquals(ObjectId
+				.fromString("da85355dfc525c9f6f3927b876f379f46ccf826e"), e
+				.getOldId());
+		assertEquals(ObjectId
+				.fromString("3e7549db262d1e836d9bf0af7e22355468f1717c"), e
+				.getNewId());
+		assertEquals("Robin Rosenberg", e.getWho().getName());
+		assertEquals("robin.rosenberg@dewire.com", e.getWho().getEmailAddress());
+		assertEquals(120, e.getWho().getTimeZoneOffset());
+		assertEquals("2009-05-22T23:36:40", iso(e.getWho().getWhen()));
+		assertEquals("commit: Add a toString for debugging to RemoteRefUpdate",
+				e.getComment());
+	}
+
+	private String iso(Date d) {
+		return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(d);
+	}
+
+	public void testReadTwoLine() throws Exception {
+		setupReflog("logs/refs/heads/master", twoLine);
+
+		ReflogReader reader = new ReflogReader(db, "refs/heads/master");
+		List<Entry> reverseEntries = reader.getReverseEntries();
+		assertEquals(2, reverseEntries.size());
+		Entry e = reverseEntries.get(0);
+		assertEquals(ObjectId
+				.fromString("c6734895958052a9dbc396cff4459dc1a25029ab"), e
+				.getOldId());
+		assertEquals(ObjectId
+				.fromString("54794942a18a237c57a80719afed44bb78172b10"), e
+				.getNewId());
+		assertEquals("Same A U Thor", e.getWho().getName());
+		assertEquals("same.author@example.com", e.getWho().getEmailAddress());
+		assertEquals(60, e.getWho().getTimeZoneOffset());
+		assertEquals("2009-05-22T23:36:42", iso(e.getWho().getWhen()));
+		assertEquals(
+				"rebase finished: refs/heads/rr/renamebranch5 onto c6e3b9fe2da0293f11eae202ec35fb343191a82d",
+				e.getComment());
+
+		e = reverseEntries.get(1);
+		assertEquals(ObjectId
+				.fromString("0000000000000000000000000000000000000000"), e
+				.getOldId());
+		assertEquals(ObjectId
+				.fromString("c6734895958052a9dbc396cff4459dc1a25029ab"), e
+				.getNewId());
+		assertEquals("A U Thor", e.getWho().getName());
+		assertEquals("thor@committer.au", e.getWho().getEmailAddress());
+		assertEquals(-60, e.getWho().getTimeZoneOffset());
+		assertEquals("2009-05-22T23:36:41", iso(e.getWho().getWhen()));
+		assertEquals("branch: Created from rr/renamebranchv4", e.getComment());
+	}
+
+	public void testReadWhileAppendIsInProgress() throws Exception {
+		setupReflog("logs/refs/heads/master", twoLineWithAppendInProgress);
+		ReflogReader reader = new ReflogReader(db, "refs/heads/master");
+		List<Entry> reverseEntries = reader.getReverseEntries();
+		assertEquals(2, reverseEntries.size());
+		Entry e = reverseEntries.get(0);
+		assertEquals(ObjectId
+				.fromString("c6734895958052a9dbc396cff4459dc1a25029ab"), e
+				.getOldId());
+		assertEquals(ObjectId
+				.fromString("54794942a18a237c57a80719afed44bb78172b10"), e
+				.getNewId());
+		assertEquals("Same A U Thor", e.getWho().getName());
+		assertEquals("same.author@example.com", e.getWho().getEmailAddress());
+		assertEquals(60, e.getWho().getTimeZoneOffset());
+		assertEquals("2009-05-22T23:36:42", iso(e.getWho().getWhen()));
+		assertEquals(
+				"rebase finished: refs/heads/rr/renamebranch5 onto c6e3b9fe2da0293f11eae202ec35fb343191a82d",
+				e.getComment());
+		// while similar to testReadTwoLine, we can assume that if we get the last entry
+		// right, everything else is too
+	}
+
+
+	public void testReadRightLog() throws Exception {
+		setupReflog("logs/refs/heads/a", aLine);
+		setupReflog("logs/refs/heads/master", masterLine);
+		setupReflog("logs/HEAD", headLine);
+		assertEquals("branch: change to master", db.getReflogReader("master")
+				.getLastEntry().getComment());
+		assertEquals("branch: change to a", db.getReflogReader("a")
+				.getLastEntry().getComment());
+		assertEquals("branch: change to HEAD", db.getReflogReader("HEAD")
+				.getLastEntry().getComment());
+	}
+
+	public void testNoLog() throws Exception {
+		assertEquals(0, db.getReflogReader("master").getReverseEntries().size());
+		assertNull(db.getReflogReader("master").getLastEntry());
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 3b03ac1..3837ea9 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -40,6 +40,7 @@
 
 import java.io.File;
 import java.io.FileInputStream;
+import java.io.FileNotFoundException;
 import java.io.FileOutputStream;
 import java.io.IOException;
 import java.io.InputStreamReader;
@@ -348,4 +349,21 @@ public void run() {
 		return newRepo;
 	}
 
+	protected void setupReflog(String logName, byte[] data)
+			throws FileNotFoundException, IOException {
+				File logfile = new File(db.getDirectory(), logName);
+				if (!logfile.getParentFile().mkdirs()
+						&& !logfile.getParentFile().isDirectory()) {
+					throw new IOException(
+							"oops, cannot create the directory for the test reflog file"
+									+ logfile);
+				}
+				FileOutputStream fileOutputStream = new FileOutputStream(logfile);
+				try {
+					fileOutputStream.write(data);
+				} finally {
+					fileOutputStream.close();
+				}
+			}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java
new file mode 100644
index 0000000..223347d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java
@@ -0,0 +1,187 @@
+/*
+ * Copyright (C) 2009, Robin Rosenberg
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
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.util.ArrayList;
+import java.util.Collections;
+import java.util.List;
+
+import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
+
+/**
+ * Utility for reading reflog entries
+ */
+public class ReflogReader {
+	/**
+	 * Parsed reflog entry
+	 */
+	static public class Entry {
+		private ObjectId oldId;
+
+		private ObjectId newId;
+
+		private PersonIdent who;
+
+		private String comment;
+
+		Entry(byte[] raw, int pos) {
+			oldId = ObjectId.fromString(raw, pos);
+			pos += Constants.OBJECT_ID_LENGTH * 2;
+			if (raw[pos++] != ' ')
+				throw new IllegalArgumentException(
+						"Raw log message does not parse as log entry");
+			newId = ObjectId.fromString(raw, pos);
+			pos += Constants.OBJECT_ID_LENGTH * 2;
+			if (raw[pos++] != ' ') {
+				throw new IllegalArgumentException(
+						"Raw log message does not parse as log entry");
+			}
+			who = RawParseUtils.parsePersonIdent(raw, pos);
+			int p0 = RawParseUtils.next(raw, pos, '\t'); // personident has no
+															// \t
+			if (p0 == -1) {
+				throw new IllegalArgumentException(
+						"Raw log message does not parse as log entry");
+			}
+			int p1 = RawParseUtils.nextLF(raw, p0);
+			if (p1 == -1) {
+				throw new IllegalArgumentException(
+						"Raw log message does not parse as log entry");
+			}
+			comment = RawParseUtils.decode(raw, p0, p1 - 1);
+		}
+
+		/**
+		 * @return the commit id before the change
+		 */
+		public ObjectId getOldId() {
+			return oldId;
+		}
+
+		/**
+		 * @return the commit id after the change
+		 */
+		public ObjectId getNewId() {
+			return newId;
+		}
+
+		/**
+		 * @return user performin the change
+		 */
+		public PersonIdent getWho() {
+			return who;
+		}
+
+		/**
+		 * @return textual description of the change
+		 */
+		public String getComment() {
+			return comment;
+		}
+		
+		@Override
+		public String toString() {
+			return "Entry[" + oldId.name() + ", " + newId.name() + ", " + getWho() + ", "
+					+ getComment() + "]";
+		}
+	}
+
+	private File logName;
+
+	ReflogReader(Repository db, String refname) {
+		logName = new File(db.getDirectory(), "logs/" + refname);
+	}
+
+	/**
+	 * Get the last entry in the reflog
+	 * 
+	 * @return the latest reflog entry, or null if no log
+	 * @throws IOException
+	 */
+	public Entry getLastEntry() throws IOException {
+		List<Entry> entries = getReverseEntries(1);
+		return entries.size() > 0 ? entries.get(0) : null;
+	}
+
+	/**
+	 * @return all reflog entries in reverse order
+	 * @throws IOException
+	 */
+	public List<Entry> getReverseEntries() throws IOException {
+		return getReverseEntries(Integer.MAX_VALUE);
+	}
+
+	/**
+	 * @param max
+	 *            max numer of entries to read
+	 * @return all reflog entries in reverse order
+	 * @throws IOException
+	 */
+	public List<Entry> getReverseEntries(int max) throws IOException {
+		FileInputStream fileInputStream;
+		try {
+			fileInputStream = new FileInputStream(logName);
+		} catch (FileNotFoundException e) {
+			return Collections.emptyList();
+		}
+		try {
+			long logSize = fileInputStream.getChannel().size();
+			if (logSize > Integer.MAX_VALUE) {
+				// implementation limit, will suck with smaller files too
+				throw new IOException("Cannot handle reflog larger than "
+						+ Integer.MAX_VALUE + " bytes");
+			}
+			byte[] log = new byte[(int) logSize];
+			NB.readFully(fileInputStream, log, 0, log.length);
+			int rs = RawParseUtils.prevLF(log, log.length);
+			List<Entry> ret = new ArrayList<Entry>();
+			while (rs >= 0 && max-- > 0) {
+				rs = RawParseUtils.prevLF(log, rs);
+				Entry entry = new Entry(log, rs < 0 ? 0 : rs + 2);
+				ret.add(entry);
+			}
+			return ret;
+		} finally {
+			fileInputStream.close();
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 5def5d3..971215c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -1089,4 +1089,18 @@ public String shortenRefName(String refName) {
 			return refName.substring(Constants.R_REMOTES.length());
 		return refName;
 	}
+
+	/**
+	 * @param refName
+	 * @return a {@link ReflogReader} for the refname, or null if the names ref
+	 *         does not exist.
+	 * @throws IOException 
+	 */
+	public ReflogReader getReflogReader(String refName) throws IOException {
+		Ref ref = getRef(refName);
+		if (ref != null)
+			return new ReflogReader(this, ref.getOrigName());
+		else
+			return null;
+	}
 }
-- 
1.6.3.2.199.g7340d
