From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Add getTaggerIdent, getShortMessage, getFullMessage to RevTag
Date: Tue, 27 Jan 2009 20:35:16 -0800
Message-ID: <1233117316-3291-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:36:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS2AP-0004xZ-Ik
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZA1EfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 23:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZA1EfU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:35:20 -0500
Received: from george.spearce.org ([209.20.77.23]:33829 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZA1EfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 23:35:19 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id C35D138211; Wed, 28 Jan 2009 04:35:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F0421381D6;
	Wed, 28 Jan 2009 04:35:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.1.374.g0d9d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107474>

These methods make the RevTag API more like the RevCommit API, such
that it is more consistent for applications to access the "fields"
of a tag object in the same way that they access the fields of any
commit object.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Actually, this has also gone through Gerrit2.  If you want to see
 what the same patch looks like (just for fun):

 http://review.source.android.com/8681
   or
 http://review.source.android.com/r/633476cf478da7c9375abf5fe

 .../src/org/spearce/jgit/revwalk/RevCommit.java    |    2 +-
 .../src/org/spearce/jgit/revwalk/RevTag.java       |   74 +++++++++++++++++++-
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   47 ++++++++++++-
 3 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
index 7454d8e..de11c39 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevCommit.java
@@ -367,7 +367,7 @@ public final String getShortMessage() {
 		return str;
 	}
 
-	private static boolean hasLF(final byte[] r, int b, final int e) {
+	static boolean hasLF(final byte[] r, int b, final int e) {
 		while (b < e)
 			if (r[b++] == '\n')
 				return true;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index 77a55cd..82f0009 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.revwalk;
 
 import java.io.IOException;
+import java.nio.charset.Charset;
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
@@ -45,6 +46,7 @@
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectLoader;
+import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.util.MutableInteger;
 import org.spearce.jgit.util.RawParseUtils;
@@ -100,7 +102,77 @@ void parseCanonical(final RevWalk walk, final byte[] rawTag)
 	public int getType() {
 		return Constants.OBJ_TAG;
 	}
-	
+
+	/**
+	 * Parse the tagger identity from the raw buffer.
+	 * <p>
+	 * This method parses and returns the content of the tagger line, after
+	 * taking the tag's character set into account and decoding the tagger
+	 * name and email address. This method is fairly expensive and produces a
+	 * new PersonIdent instance on each invocation. Callers should invoke this
+	 * method only if they are certain they will be outputting the result, and
+	 * should cache the return value for as long as necessary to use all
+	 * information from it.
+	 * 
+	 * @return identity of the tagger (name, email) and the time the tag
+	 *         was made by the tagger; null if no tagger line was found.
+	 */
+	public final PersonIdent getTaggerIdent() {
+		final byte[] raw = buffer;
+		final int nameB = RawParseUtils.tagger(raw, 0);
+		if (nameB < 0)
+			return null;
+		return RawParseUtils.parsePersonIdent(raw, nameB);
+	}
+
+	/**
+	 * Parse the complete tag message and decode it to a string.
+	 * <p>
+	 * This method parses and returns the message portion of the tag buffer,
+	 * after taking the tag's character set into account and decoding the buffer
+	 * using that character set. This method is a fairly expensive operation and
+	 * produces a new string on each invocation.
+	 * 
+	 * @return decoded tag message as a string. Never null.
+	 */
+	public final String getFullMessage() {
+		final byte[] raw = buffer;
+		final int msgB = RawParseUtils.tagMessage(raw, 0);
+		if (msgB < 0)
+			return "";
+		final Charset enc = RawParseUtils.parseEncoding(raw);
+		return RawParseUtils.decode(enc, raw, msgB, raw.length);
+	}
+
+	/**
+	 * Parse the tag message and return the first "line" of it.
+	 * <p>
+	 * The first line is everything up to the first pair of LFs. This is the
+	 * "oneline" format, suitable for output in a single line display.
+	 * <p>
+	 * This method parses and returns the message portion of the tag buffer,
+	 * after taking the tag's character set into account and decoding the buffer
+	 * using that character set. This method is a fairly expensive operation and
+	 * produces a new string on each invocation.
+	 * 
+	 * @return decoded tag message as a string. Never null. The returned string
+	 *         does not contain any LFs, even if the first paragraph spanned
+	 *         multiple lines. Embedded LFs are converted to spaces.
+	 */
+	public final String getShortMessage() {
+		final byte[] raw = buffer;
+		final int msgB = RawParseUtils.tagMessage(raw, 0);
+		if (msgB < 0)
+			return "";
+
+		final Charset enc = RawParseUtils.parseEncoding(raw);
+		final int msgE = RawParseUtils.endOfParagraph(raw, msgB);
+		String str = RawParseUtils.decode(enc, raw, msgB, msgE);
+		if (RevCommit.hasLF(raw, msgB, msgE))
+			str = str.replace('\n', ' ');
+		return str;
+	}
+
 	/**
 	 * Parse this tag buffer for display.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 758e7af..646a654 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -40,6 +40,7 @@
 import static org.spearce.jgit.lib.ObjectChecker.author;
 import static org.spearce.jgit.lib.ObjectChecker.committer;
 import static org.spearce.jgit.lib.ObjectChecker.encoding;
+import static org.spearce.jgit.lib.ObjectChecker.tagger;
 
 import java.nio.ByteBuffer;
 import java.nio.charset.CharacterCodingException;
@@ -397,6 +398,32 @@ public static final int committer(final byte[] b, int ptr) {
 	}
 
 	/**
+	 * Locate the "tagger " header line data.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position in buffer to start the scan at. Most callers should
+	 *            pass 0 to ensure the scan starts from the beginning of the tag
+	 *            buffer and does not accidentally look at message body.
+	 * @return position just after the space in "tagger ", so the first
+	 *         character of the tagger's name. If no tagger header can be
+	 *         located -1 is returned.
+	 */
+	public static final int tagger(final byte[] b, int ptr) {
+		final int sz = b.length;
+		while (ptr < sz) {
+			if (b[ptr] == '\n')
+				return -1;
+			final int m = match(b, ptr, tagger);
+			if (m >= 0)
+				return m;
+			ptr = nextLF(b, ptr);
+		}
+		return -1;
+	}
+
+	/**
 	 * Locate the "encoding " header line.
 	 * 
 	 * @param b
@@ -648,9 +675,25 @@ public static final int commitMessage(final byte[] b, int ptr) {
 		while (ptr < sz && b[ptr] == 'p')
 			ptr += 48; // skip this parent.
 
-		// skip any remaining header lines, ignoring what their actual
-		// header line type is.
+		// Skip any remaining header lines, ignoring what their actual
+		// header line type is. This is identical to the logic for a tag.
 		//
+		return tagMessage(b, ptr);
+	}
+
+	/**
+	 * Locate the position of the tag message body.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position in buffer to start the scan at. Most callers should
+	 *            pass 0 to ensure the scan starts from the beginning of the tag
+	 *            buffer.
+	 * @return position of the user's message buffer.
+	 */
+	public static final int tagMessage(final byte[] b, int ptr) {
+		final int sz = b.length;
 		while (ptr < sz && b[ptr] != '\n')
 			ptr = nextLF(b, ptr);
 		if (ptr < sz && b[ptr] == '\n')
-- 
1.6.1.1.374.g0d9d7
