From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/6] Simplify RawParseUtils.nextLF invocations
Date: Wed, 10 Dec 2008 14:05:46 -0800
Message-ID: <1228946751-12708-2-git-send-email-spearce@spearce.org>
References: <1228946751-12708-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:07:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXDK-00031R-Tb
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493AbYLJWF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbYLJWFz
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:05:55 -0500
Received: from george.spearce.org ([209.20.77.23]:39009 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbYLJWFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:05:53 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0AB8138222; Wed, 10 Dec 2008 22:05:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E287838192;
	Wed, 10 Dec 2008 22:05:51 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228946751-12708-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102728>

Most of the time when we call next('\n') or nextLF('\n') we really
meant to just say nextLF(), which is logically identical to next()
but could be micro-optimized for the LF byte.

This refactoring shifts the calls to use the new nextLF wrapper for
next('\n'), so we can later chose to make this optimization, or to
leave the code as-is.  But either way the call sites are now much
clearer to read.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectChecker.java    |    4 +-
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    2 +-
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   25 ++++++++++++++++----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
index b303d6f..75e3c77 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
@@ -205,11 +205,11 @@ public void checkTag(final byte[] raw) throws CorruptObjectException {
 
 		if ((ptr = match(raw, ptr, type)) < 0)
 			throw new CorruptObjectException("no type header");
-		ptr = nextLF(raw, ptr, '\n');
+		ptr = nextLF(raw, ptr);
 
 		if ((ptr = match(raw, ptr, tag)) < 0)
 			throw new CorruptObjectException("no tag header");
-		ptr = nextLF(raw, ptr, '\n');
+		ptr = nextLF(raw, ptr);
 
 		if ((ptr = match(raw, ptr, tagger)) < 0)
 			throw new CorruptObjectException("no tagger header");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
index bbb18ee..77a55cd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevTag.java
@@ -90,7 +90,7 @@ void parseCanonical(final RevWalk walk, final byte[] rawTag)
 		object = walk.lookupAny(walk.idBuffer, oType);
 
 		int p = pos.value += 4; // "tag "
-		final int nameEnd = RawParseUtils.next(rawTag, p, '\n') - 1;
+		final int nameEnd = RawParseUtils.nextLF(rawTag, p) - 1;
 		name = RawParseUtils.decode(Constants.CHARSET, rawTag, p, nameEnd);
 		buffer = rawTag;
 		flags |= PARSED;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 4b96439..10c2239 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -230,6 +230,21 @@ public static final int next(final byte[] b, int ptr, final char chrA) {
 	}
 
 	/**
+	 * Locate the first position after the next LF.
+	 * <p>
+	 * This method stops on the first '\n' it finds.
+	 * 
+	 * @param b
+	 *            buffer to scan.
+	 * @param ptr
+	 *            position within buffer to start looking for LF at.
+	 * @return new position just after the first LF found.
+	 */
+	public static final int nextLF(final byte[] b, int ptr) {
+		return next(b, ptr, '\n');
+	}
+
+	/**
 	 * Locate the first position after either the given character or LF.
 	 * <p>
 	 * This method stops on the first match it finds from either chrA or '\n'.
@@ -296,7 +311,7 @@ public static final int committer(final byte[] b, int ptr) {
 		while (ptr < sz && b[ptr] == 'p')
 			ptr += 48; // skip this parent.
 		if (ptr < sz && b[ptr] == 'a')
-			ptr = next(b, ptr, '\n');
+			ptr = nextLF(b, ptr);
 		return match(b, ptr, committer);
 	}
 
@@ -320,7 +335,7 @@ public static final int encoding(final byte[] b, int ptr) {
 				return -1;
 			if (b[ptr] == 'e')
 				break;
-			ptr = next(b, ptr, '\n');
+			ptr = nextLF(b, ptr);
 		}
 		return match(b, ptr, encoding);
 	}
@@ -342,7 +357,7 @@ public static Charset parseEncoding(final byte[] b) {
 		final int enc = encoding(b, 0);
 		if (enc < 0)
 			return Constants.CHARSET;
-		final int lf = next(b, enc, '\n');
+		final int lf = nextLF(b, enc);
 		return Charset.forName(decode(Constants.CHARSET, b, enc, lf - 1));
 	}
 
@@ -505,7 +520,7 @@ public static final int commitMessage(final byte[] b, int ptr) {
 		// header line type is.
 		//
 		while (ptr < sz && b[ptr] != '\n')
-			ptr = next(b, ptr, '\n');
+			ptr = nextLF(b, ptr);
 		if (ptr < sz && b[ptr] == '\n')
 			return ptr + 1;
 		return -1;
@@ -529,7 +544,7 @@ public static final int endOfParagraph(final byte[] b, final int start) {
 		int ptr = start;
 		final int sz = b.length;
 		while (ptr < sz && b[ptr] != '\n')
-			ptr = next(b, ptr, '\n');
+			ptr = nextLF(b, ptr);
 		while (0 < ptr && start < ptr && b[ptr - 1] == '\n')
 			ptr--;
 		return ptr;
-- 
1.6.1.rc2.299.gead4c
