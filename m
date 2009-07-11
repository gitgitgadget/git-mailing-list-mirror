From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/11] Refactor ref advertisement code from server implementations
Date: Sat, 11 Jul 2009 13:19:19 -0700
Message-ID: <1247343566-19025-5-git-send-email-spearce@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org>
 <1247343566-19025-2-git-send-email-spearce@spearce.org>
 <1247343566-19025-3-git-send-email-spearce@spearce.org>
 <1247343566-19025-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj3q-0003g9-Qn
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZGKUTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752950AbZGKUTk
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:40 -0400
Received: from george.spearce.org ([209.20.77.23]:39700 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbZGKUTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 861A038239; Sat, 11 Jul 2009 20:19:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3DDC2381FF;
	Sat, 11 Jul 2009 20:19:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
In-Reply-To: <1247343566-19025-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123125>

The RefAdvertiser implements the common logic from both UploadPack
and ReceivePack, as the code here was really very similar.  By using
a support class we can also cleanup the nasty passing of parameters
for temporary data, and instead rely on the instance members of the
support class to handle it for us.

A minor change in functionality exists in this change, we now make
a temporary RevFlag and tag all advertised objects in ReceivePack.
This is a pointless operation that currently wastes a very small
amount of CPU time during setup of the advertisement, but is so
minor that its just not worth optimizing out.  The code reuse is
much more important for maintenance.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/ReceivePack.java    |   61 ++------
 .../org/spearce/jgit/transport/RefAdvertiser.java  |  155 ++++++++++++++++++++
 .../src/org/spearce/jgit/transport/UploadPack.java |   93 ++-----------
 3 files changed, 177 insertions(+), 132 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index 16b0c57..fd8aa86 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -46,8 +46,8 @@
 import java.io.PrintWriter;
 import java.util.ArrayList;
 import java.util.Collections;
+import java.util.HashMap;
 import java.util.HashSet;
-import java.util.Iterator;
 import java.util.List;
 import java.util.Map;
 import java.util.Set;
@@ -60,12 +60,12 @@
 import org.spearce.jgit.lib.PackLock;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Ref;
-import org.spearce.jgit.lib.RefComparator;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.RepositoryConfig;
 import org.spearce.jgit.revwalk.ObjectWalk;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.transport.ReceiveCommand.Result;
@@ -503,55 +503,18 @@ private void unlockPack() {
 	}
 
 	private void sendAdvertisedRefs() throws IOException {
+		final RevFlag advertised = walk.newFlag("ADVERTISED");
+		final RefAdvertiser adv = new RefAdvertiser(pckOut, walk, advertised);
+		adv.advertiseCapability(CAPABILITY_DELETE_REFS);
+		adv.advertiseCapability(CAPABILITY_REPORT_STATUS);
+		if (allowOfsDelta)
+			adv.advertiseCapability(CAPABILITY_OFS_DELTA);
 		refs = db.getAllRefs();
-
-		final StringBuilder m = new StringBuilder(100);
-		final char[] idtmp = new char[2 * Constants.OBJECT_ID_LENGTH];
-		final Iterator<Ref> i = RefComparator.sort(refs.values()).iterator();
-		boolean first = true;
-		while (i.hasNext()) {
-			final Ref r = i.next();
-			if (r.getObjectId() == null)
-				continue;
-			format(m, idtmp, r.getObjectId(), r.getOrigName());
-			if (first) {
-				first = false;
-				advertiseCapabilities(m);
-			}
-			writeAdvertisedRef(m);
-		}
-		if (first) {
-			format(m, idtmp, ObjectId.zeroId(), "capabilities^{}");
-			advertiseCapabilities(m);
-			writeAdvertisedRef(m);
-		}
+		adv.send(refs.values());
+		if (adv.isEmpty())
+			adv.advertiseId(ObjectId.zeroId(), "capabilities^{}");
 		pckOut.end();
-	}
-
-	private void advertiseCapabilities(final StringBuilder m) {
-		m.append('\0');
-		m.append(' ');
-		m.append(CAPABILITY_DELETE_REFS);
-		m.append(' ');
-		m.append(CAPABILITY_REPORT_STATUS);
-		if (allowOfsDelta) {
-			m.append(' ');
-			m.append(CAPABILITY_OFS_DELTA);
-		}
-		m.append(' ');
-	}
-
-	private void format(final StringBuilder m, final char[] idtmp,
-			final ObjectId id, final String name) {
-		m.setLength(0);
-		id.copyTo(idtmp, m);
-		m.append(' ');
-		m.append(name);
-	}
-
-	private void writeAdvertisedRef(final StringBuilder m) throws IOException {
-		m.append('\n');
-		pckOut.writeString(m.toString());
+		walk.disposeFlag(advertised);
 	}
 
 	private void recvCommands() throws IOException {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java
new file mode 100644
index 0000000..245891d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java
@@ -0,0 +1,155 @@
+/*
+ * Copyright (C) 2008, 2009, Google Inc.
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
+package org.spearce.jgit.transport;
+
+import java.io.IOException;
+import java.util.Collection;
+import java.util.LinkedHashSet;
+import java.util.Set;
+
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.RefComparator;
+import org.spearce.jgit.revwalk.RevFlag;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevTag;
+import org.spearce.jgit.revwalk.RevWalk;
+
+/** Support for the start of {@link UploadPack} and {@link ReceivePack}. */
+class RefAdvertiser {
+	private final PacketLineOut pckOut;
+
+	private final RevWalk walk;
+
+	private final RevFlag ADVERTISED;
+
+	private final StringBuilder tmpLine = new StringBuilder(100);
+
+	private final char[] tmpId = new char[2 * Constants.OBJECT_ID_LENGTH];
+
+	private final Set<String> capablities = new LinkedHashSet<String>();
+
+	private boolean derefTags;
+
+	private boolean first = true;
+
+	RefAdvertiser(final PacketLineOut out, final RevWalk protoWalk,
+			final RevFlag advertisedFlag) {
+		pckOut = out;
+		walk = protoWalk;
+		ADVERTISED = advertisedFlag;
+	}
+
+	void setDerefTags(final boolean deref) {
+		derefTags = deref;
+	}
+
+	void advertiseCapability(String name) {
+		capablities.add(name);
+	}
+
+	void send(final Collection<Ref> refs) throws IOException {
+		for (final Ref r : RefComparator.sort(refs)) {
+			final RevObject obj = parseAnyOrNull(r.getObjectId());
+			if (obj != null) {
+				advertiseAny(obj, r.getOrigName());
+				if (derefTags && obj instanceof RevTag)
+					advertiseTag((RevTag) obj, r.getOrigName() + "^{}");
+			}
+		}
+	}
+
+	boolean isEmpty() {
+		return first;
+	}
+
+	private RevObject parseAnyOrNull(final AnyObjectId id) {
+		if (id == null)
+			return null;
+		try {
+			return walk.parseAny(id);
+		} catch (IOException e) {
+			return null;
+		}
+	}
+
+	private void advertiseAny(final RevObject obj, final String refName)
+			throws IOException {
+		obj.add(ADVERTISED);
+		advertiseId(obj, refName);
+	}
+
+	private void advertiseTag(final RevTag tag, final String refName)
+			throws IOException {
+		RevObject o = tag;
+		do {
+			// Fully unwrap here so later on we have these already parsed.
+			final RevObject target = ((RevTag) o).getObject();
+			try {
+				walk.parseHeaders(target);
+			} catch (IOException err) {
+				return;
+			}
+			target.add(ADVERTISED);
+			o = target;
+		} while (o instanceof RevTag);
+		advertiseAny(tag.getObject(), refName);
+	}
+
+	void advertiseId(final AnyObjectId id, final String refName)
+			throws IOException {
+		tmpLine.setLength(0);
+		id.copyTo(tmpId, tmpLine);
+		tmpLine.append(' ');
+		tmpLine.append(refName);
+		if (first) {
+			first = false;
+			if (!capablities.isEmpty()) {
+				tmpLine.append('\0');
+				for (final String capName : capablities) {
+					tmpLine.append(' ');
+					tmpLine.append(capName);
+				}
+				tmpLine.append(' ');
+			}
+		}
+		tmpLine.append('\n');
+		pckOut.writeString(tmpLine.toString());
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index b0fa885..179670f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -50,13 +50,11 @@
 import java.util.Set;
 
 import org.spearce.jgit.errors.PackProtocolException;
-import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.NullProgressMonitor;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PackWriter;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
-import org.spearce.jgit.lib.RefComparator;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevFlag;
@@ -249,91 +247,20 @@ private void service() throws IOException {
 	}
 
 	private void sendAdvertisedRefs() throws IOException {
+		final RefAdvertiser adv = new RefAdvertiser(pckOut, walk, ADVERTISED);
+		adv.advertiseCapability(OPTION_INCLUDE_TAG);
+		adv.advertiseCapability(OPTION_MULTI_ACK);
+		adv.advertiseCapability(OPTION_OFS_DELTA);
+		adv.advertiseCapability(OPTION_SIDE_BAND);
+		adv.advertiseCapability(OPTION_SIDE_BAND_64K);
+		adv.advertiseCapability(OPTION_THIN_PACK);
+		adv.advertiseCapability(OPTION_NO_PROGRESS);
+		adv.setDerefTags(true);
 		refs = db.getAllRefs();
-
-		final StringBuilder m = new StringBuilder(100);
-		final char[] idtmp = new char[2 * Constants.OBJECT_ID_LENGTH];
-		final Iterator<Ref> i = RefComparator.sort(refs.values()).iterator();
-		if (i.hasNext()) {
-			final Ref r = i.next();
-			final RevObject o = safeParseAny(r.getObjectId());
-			if (o != null) {
-				advertise(m, idtmp, o, r.getOrigName());
-				m.append('\0');
-				m.append(' ');
-				m.append(OPTION_INCLUDE_TAG);
-				m.append(' ');
-				m.append(OPTION_MULTI_ACK);
-				m.append(' ');
-				m.append(OPTION_OFS_DELTA);
-				m.append(' ');
-				m.append(OPTION_SIDE_BAND);
-				m.append(' ');
-				m.append(OPTION_SIDE_BAND_64K);
-				m.append(' ');
-				m.append(OPTION_THIN_PACK);
-				m.append(' ');
-				m.append(OPTION_NO_PROGRESS);
-				m.append(' ');
-				writeAdvertisedRef(m);
-				if (o instanceof RevTag)
-					writeAdvertisedTag(m, idtmp, o, r.getName());
-			}
-		}
-		while (i.hasNext()) {
-			final Ref r = i.next();
-			if (r.getObjectId() == null)
-				continue;
-			final RevObject o = safeParseAny(r.getObjectId());
-			if (o != null) {
-				advertise(m, idtmp, o, r.getOrigName());
-				writeAdvertisedRef(m);
-				if (o instanceof RevTag)
-					writeAdvertisedTag(m, idtmp, o, r.getName());
-			}
-		}
+		adv.send(refs.values());
 		pckOut.end();
 	}
 
-	private RevObject safeParseAny(final ObjectId id) {
-		try {
-			return walk.parseAny(id);
-		} catch (IOException e) {
-			return null;
-		}
-	}
-
-	private void advertise(final StringBuilder m, final char[] idtmp,
-			final RevObject o, final String name) {
-		o.add(ADVERTISED);
-		m.setLength(0);
-		o.getId().copyTo(idtmp, m);
-		m.append(' ');
-		m.append(name);
-	}
-
-	private void writeAdvertisedRef(final StringBuilder m) throws IOException {
-		m.append('\n');
-		pckOut.writeString(m.toString());
-	}
-
-	private void writeAdvertisedTag(final StringBuilder m, final char[] idtmp,
-			final RevObject tag, final String name) throws IOException {
-		RevObject o = tag;
-		while (o instanceof RevTag) {
-			// Fully unwrap here so later on we have these already parsed.
-			try {
-				walk.parseHeaders(((RevTag) o).getObject());
-			} catch (IOException err) {
-				return;
-			}
-			o = ((RevTag) o).getObject();
-			o.add(ADVERTISED);
-		}
-		advertise(m, idtmp, ((RevTag) tag).getObject(), name + "^{}");
-		writeAdvertisedRef(m);
-	}
-
 	private void recvWants() throws IOException {
 		boolean isFirst = true;
 		for (;; isFirst = false) {
-- 
1.6.4.rc0.117.g28cb
