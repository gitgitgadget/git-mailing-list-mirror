From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 04/26] Rely upon Constants.CHARSET over Constants.CHARACTER_ENCODING
Date: Mon, 11 Aug 2008 18:07:51 -0700
Message-ID: <1218503293-14057-5-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPO-0006OQ-Bb
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbYHLBIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbYHLBIX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:23 -0400
Received: from george.spearce.org ([209.20.77.23]:38569 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbYHLBIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:16 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 44E273838E; Tue, 12 Aug 2008 01:08:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8B41638378;
	Tue, 12 Aug 2008 01:08:14 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92039>

This avoids the UnsupportedEncodingException error which we know
must not fail on a JRE that supports jgit.  We have to have the
stock UTF-8 encoding available for basic operation.

In some cases we can also avoid an unnecessary copy.  Some code
paths in the byte[]->String utility methods in the Sun JRE seem
to copy the input byte[] prior to calling the character set for
the conversion.  This copy is unnecessary.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |    2 +-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    9 +++------
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    4 ++--
 .../org/spearce/jgit/transport/PacketLineIn.java   |    3 ++-
 .../jgit/transport/SideBandInputStream.java        |    3 ++-
 .../spearce/jgit/transport/TransportBundle.java    |    3 ++-
 .../spearce/jgit/transport/WalkPushConnection.java |    4 ++--
 .../jgit/transport/WalkRemoteObjectDatabase.java   |    5 ++---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   10 ++--------
 .../spearce/jgit/treewalk/filter/PathFilter.java   |   10 +---------
 10 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index be2e28c..6c2cd4f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -236,7 +236,7 @@ public class ObjectWriter {
 	public ObjectId writeTag(final Tag c) throws IOException {
 		final ByteArrayOutputStream os = new ByteArrayOutputStream();
 		final OutputStreamWriter w = new OutputStreamWriter(os,
-				Constants.CHARACTER_ENCODING);
+				Constants.CHARSET);
 
 		w.write("object ");
 		c.getObjId().copyTo(w);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 3e68a8d..facd3e4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -45,7 +45,6 @@ import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.InputStreamReader;
-import java.io.UnsupportedEncodingException;
 import java.util.HashMap;
 import java.util.Map;
 
@@ -54,8 +53,6 @@ import org.spearce.jgit.util.FS;
 import org.spearce.jgit.util.NB;
 
 class RefDatabase {
-	private static final String CHAR_ENC = Constants.CHARACTER_ENCODING;
-
 	private static final String REFS_SLASH = "refs/";
 
 	private static final String HEADS_SLASH = Constants.HEADS_PREFIX + "/";
@@ -157,7 +154,7 @@ class RefDatabase {
 	 * @throws IOException
 	 */
 	void link(final String name, final String target) throws IOException {
-		final byte[] content = ("ref: " + target + "\n").getBytes(CHAR_ENC);
+		final byte[] content = Constants.encode("ref: " + target + "\n");
 		final LockFile lck = new LockFile(fileForRef(name));
 		if (!lck.lock())
 			throw new ObjectWritingException("Unable to lock " + name);
@@ -438,9 +435,9 @@ class RefDatabase {
 	}
 
 	private static BufferedReader openReader(final File fileLocation)
-			throws UnsupportedEncodingException, FileNotFoundException {
+			throws FileNotFoundException {
 		return new BufferedReader(new InputStreamReader(new FileInputStream(
-				fileLocation), CHAR_ENC));
+				fileLocation), Constants.CHARSET));
 	}
 
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index d1cd5fc..048940d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -517,7 +517,7 @@ public class RepositoryConfig {
 				+ ".lock");
 		final PrintWriter r = new PrintWriter(new BufferedWriter(
 				new OutputStreamWriter(new FileOutputStream(tmp),
-						Constants.CHARACTER_ENCODING))) {
+						Constants.CHARSET))) {
 			@Override
 			public void println() {
 				print('\n');
@@ -585,7 +585,7 @@ public class RepositoryConfig {
 		clear();
 		readFile = true;
 		final BufferedReader r = new BufferedReader(new InputStreamReader(
-				new FileInputStream(configFile), Constants.CHARACTER_ENCODING));
+				new FileInputStream(configFile), Constants.CHARSET));
 		try {
 			Entry last = null;
 			Entry e = new Entry();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
index f330638..f87517d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
@@ -47,6 +47,7 @@ import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.MutableObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 class PacketLineIn {
 	private static final byte fromhex[];
@@ -107,7 +108,7 @@ class PacketLineIn {
 		final byte[] raw = new byte[len];
 		NB.readFully(in, raw, 0, len);
 		readLF();
-		return new String(raw, 0, len, Constants.CHARACTER_ENCODING);
+		return RawParseUtils.decode(Constants.CHARSET, raw, 0, len);
 	}
 
 	private void readLF() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
index 9ccf5ad..3ec9bff 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/SideBandInputStream.java
@@ -48,6 +48,7 @@ import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * Unmultiplexes the data portion of a side-band channel.
@@ -194,6 +195,6 @@ class SideBandInputStream extends InputStream {
 	private String readString(final int len) throws IOException {
 		final byte[] raw = new byte[len];
 		NB.readFully(in, raw, 0, len);
-		return new String(raw, 0, len, Constants.CHARACTER_ENCODING);
+		return RawParseUtils.decode(Constants.CHARSET, raw, 0, len);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index 24d49eb..d8c2ba4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -58,6 +58,7 @@ import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * Supports fetching from a git bundle (sneaker-net object transport).
@@ -193,7 +194,7 @@ class TransportBundle extends PackTransport {
 			bin.skip(lf);
 			if (lf < cnt && hdrbuf[lf] == '\n')
 				bin.skip(1);
-			return new String(hdrbuf, 0, lf, Constants.CHARACTER_ENCODING);
+			return RawParseUtils.decode(Constants.CHARSET, hdrbuf, 0, lf);
 		}
 
 		@Override
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index 904a699..85bbc14 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -325,7 +325,7 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 			throws TransportException {
 		try {
 			final String ref = "ref: " + pickHEAD(updates) + "\n";
-			final byte[] bytes = ref.getBytes(Constants.CHARACTER_ENCODING);
+			final byte[] bytes = Constants.encode(ref);
 			dest.writeFile("../HEAD", bytes);
 		} catch (IOException e) {
 			throw new TransportException(uri, "cannot create HEAD", e);
@@ -334,7 +334,7 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 		try {
 			final String config = "[core]\n"
 					+ "\trepositoryformatversion = 0\n";
-			final byte[] bytes = config.getBytes(Constants.CHARACTER_ENCODING);
+			final byte[] bytes = Constants.encode(config);
 			dest.writeFile("../config", bytes);
 		} catch (IOException e) {
 			throw new TransportException(uri, "cannot create config", e);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index c5a5199..ababc69 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -67,8 +67,6 @@ import org.spearce.jgit.util.NB;
  * independent {@link WalkFetchConnection}.
  */
 abstract class WalkRemoteObjectDatabase {
-	static final String CHARENC = Constants.CHARACTER_ENCODING;
-
 	static final String INFO_PACKS = "info/packs";
 
 	static final String INFO_ALTERNATES = "info/alternates";
@@ -448,7 +446,8 @@ abstract class WalkRemoteObjectDatabase {
 	 *             stream could be created.
 	 */
 	BufferedReader openReader(final String path) throws IOException {
-		return new BufferedReader(new InputStreamReader(open(path).in, CHARENC));
+		final InputStream is = open(path).in;
+		return new BufferedReader(new InputStreamReader(is, Constants.CHARSET));
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 9f373e6..d4050ec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -38,7 +38,6 @@
 package org.spearce.jgit.treewalk;
 
 import java.io.IOException;
-import java.io.UnsupportedEncodingException;
 import java.util.Collections;
 
 import org.spearce.jgit.errors.CorruptObjectException;
@@ -52,6 +51,7 @@ import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revwalk.RevTree;
 import org.spearce.jgit.treewalk.filter.PathFilterGroup;
 import org.spearce.jgit.treewalk.filter.TreeFilter;
+import org.spearce.jgit.util.RawParseUtils;
 
 /**
  * Walks one or more {@link AbstractTreeIterator}s in parallel.
@@ -685,12 +685,6 @@ public class TreeWalk {
 	}
 
 	private static String pathOf(final AbstractTreeIterator t) {
-		try {
-			return new String(t.path, 0, t.pathLen,
-					Constants.CHARACTER_ENCODING);
-		} catch (UnsupportedEncodingException uee) {
-			throw new RuntimeException("JVM doesn't support "
-					+ Constants.CHARACTER_ENCODING, uee);
-		}
+		return RawParseUtils.decode(Constants.CHARSET, t.path, 0, t.pathLen);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathFilter.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathFilter.java
index 3aff145..56773a3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathFilter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/PathFilter.java
@@ -37,8 +37,6 @@
 
 package org.spearce.jgit.treewalk.filter;
 
-import java.io.UnsupportedEncodingException;
-
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.treewalk.TreeWalk;
 
@@ -81,13 +79,7 @@ public class PathFilter extends TreeFilter {
 
 	private PathFilter(final String s) {
 		pathStr = s;
-		try {
-			pathRaw = pathStr.getBytes(Constants.CHARACTER_ENCODING);
-		} catch (UnsupportedEncodingException uee) {
-			throw new RuntimeException("JVM doesn't support "
-					+ Constants.CHARACTER_ENCODING
-					+ " which is required for path filtering.", uee);
-		}
+		pathRaw = Constants.encode(pathStr);
 	}
 
 	@Override
-- 
1.6.0.rc2.22.g71b99
