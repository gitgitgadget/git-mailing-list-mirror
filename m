From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 01/19] Cleanup nonstandard references to encoding strings to bytes
Date: Sat, 25 Jul 2009 11:52:44 -0700
Message-ID: <1248547982-4003-2-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO1-0002ZF-0g
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbZGYSxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZGYSxG
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:06 -0400
Received: from george.spearce.org ([209.20.77.23]:35543 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZGYSxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:03 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DB07538215; Sat, 25 Jul 2009 18:53:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1589E381FD;
	Sat, 25 Jul 2009 18:53:03 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124038>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |    2 +-
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |    3 +--
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |    2 +-
 .../jgit/revwalk/filter/PatternMatchRevFilter.java |   10 ++--------
 .../org/spearce/jgit/util/RawSubStringPattern.java |   10 ++--------
 5 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
index fa6345e..bf155cf 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ConcurrentRepackTest.java
@@ -244,7 +244,7 @@ private File fullPackFileName(final ObjectId name, final String suffix) {
 	private RevObject writeBlob(final Repository repo, final String data)
 			throws IOException {
 		final RevWalk revWalk = new RevWalk(repo);
-		final byte[] bytes = data.getBytes(Constants.CHARACTER_ENCODING);
+		final byte[] bytes = Constants.encode(data);
 		final ObjectWriter ow = new ObjectWriter(repo);
 		final ObjectId id = ow.writeBlob(bytes);
 		try {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
index befc3d5..9d5a44c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevWalkTestCase.java
@@ -82,8 +82,7 @@ protected void tick(final int secDelta) {
 	}
 
 	protected RevBlob blob(final String content) throws Exception {
-		return rw.lookupBlob(ow.writeBlob(content
-				.getBytes(Constants.CHARACTER_ENCODING)));
+		return rw.lookupBlob(ow.writeBlob(Constants.encode(content)));
 	}
 
 	protected DirCacheEntry file(final String path, final RevBlob blob)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index 546cc68..86b5b09 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -215,7 +215,7 @@ public ObjectId writeCommit(final Commit c) throws IOException {
 		w.flush();
 		os.write('\n');
 
-		if (!encoding.equals("UTF-8")) {
+		if (!encoding.equals(Constants.CHARACTER_ENCODING)) {
 			os.write(hencoding);
 			os.write(' ');
 			os.write(Constants.encodeASCII(encoding));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/PatternMatchRevFilter.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/PatternMatchRevFilter.java
index e0bccf7..f9e7e4a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/PatternMatchRevFilter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/filter/PatternMatchRevFilter.java
@@ -38,12 +38,12 @@
 package org.spearce.jgit.revwalk.filter;
 
 import java.io.IOException;
-import java.io.UnsupportedEncodingException;
 import java.util.regex.Matcher;
 import java.util.regex.Pattern;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.util.RawCharSequence;
@@ -64,13 +64,7 @@
 	 *         character sequence {@link RawCharSequence}.
 	 */
 	protected static final String forceToRaw(final String patternText) {
-		final byte[] b;
-		try {
-			b = patternText.getBytes("UTF-8");
-		} catch (UnsupportedEncodingException e) {
-			throw new IllegalStateException("JVM lacks UTF-8 support.", e);
-		}
-
+		final byte[] b = Constants.encode(patternText);
 		final StringBuilder needle = new StringBuilder(b.length);
 		for (int i = 0; i < b.length; i++)
 			needle.append((char) (b[i] & 0xff));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawSubStringPattern.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawSubStringPattern.java
index 5ed071c..1628deb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawSubStringPattern.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawSubStringPattern.java
@@ -37,7 +37,7 @@
 
 package org.spearce.jgit.util;
 
-import java.io.UnsupportedEncodingException;
+import org.spearce.jgit.lib.Constants;
 
 /**
  * Searches text using only substring search.
@@ -63,13 +63,7 @@ public RawSubStringPattern(final String patternText) {
 			throw new IllegalArgumentException("Cannot match on empty string.");
 		needleString = patternText;
 
-		final byte[] b;
-		try {
-			b = patternText.getBytes("UTF-8");
-		} catch (UnsupportedEncodingException e) {
-			throw new IllegalStateException("JVM lacks UTF-8 support.", e);
-		}
-
+		final byte[] b = Constants.encode(patternText);
 		needle = new byte[b.length];
 		for (int i = 0; i < b.length; i++)
 			needle[i] = lc(b[i]);
-- 
1.6.4.rc2.216.g769fa
