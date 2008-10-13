From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Add bundle creation support
Date: Mon, 13 Oct 2008 09:52:26 -0700
Message-ID: <1223916746-11262-2-git-send-email-spearce@spearce.org>
References: <1223916746-11262-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 18:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpQfw-0005ji-1s
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 18:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbYJMQwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 12:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbYJMQwc
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 12:52:32 -0400
Received: from george.spearce.org ([209.20.77.23]:56062 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758AbYJMQwa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 12:52:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 767A13835F; Mon, 13 Oct 2008 16:52:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 791A238360;
	Mon, 13 Oct 2008 16:52:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
In-Reply-To: <1223916746-11262-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98123>

BundleWriter offers a safe API to create new bundles.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I wrote this a while back but haven't had a chance to write unit
 tests for it.  It may be worthwhile including as it looks to be
 obviously correct and is probably necessary to create pure Java
 based unit tests for the bundle fetch transport.

 .../org/spearce/jgit/transport/BundleWriter.java   |  196 ++++++++++++++++++++
 1 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BundleWriter.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BundleWriter.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleWriter.java
new file mode 100644
index 0000000..f0fbd37
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BundleWriter.java
@@ -0,0 +1,196 @@
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
+package org.spearce.jgit.transport;
+
+import java.io.BufferedOutputStream;
+import java.io.IOException;
+import java.io.OutputStream;
+import java.io.OutputStreamWriter;
+import java.io.Writer;
+import java.util.HashSet;
+import java.util.Map;
+import java.util.Set;
+import java.util.TreeMap;
+
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackWriter;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.revwalk.RevCommit;
+
+/**
+ * Creates a Git bundle file, for sneaker-net transport to another system.
+ * <p>
+ * Bundles generated by this class can be later read in from a file URI using
+ * the bundle transport, or from an application controlled buffer by the more
+ * generic {@link TransportBundleStream}.
+ * <p>
+ * Applications creating bundles need to call one or more <code>include</code>
+ * calls to reflect which objects should be available as refs in the bundle for
+ * the other side to fetch. At least one include is required to create a valid
+ * bundle file, and duplicate names are not permitted.
+ * <p>
+ * Optional <code>assume</code> calls can be made to declare commits which the
+ * recipient must have in order to fetch from the bundle file. Objects reachable
+ * from these assumed commits can be used as delta bases in order to reduce the
+ * overall bundle size.
+ */
+public class BundleWriter {
+	private final PackWriter packWriter;
+
+	private final Map<String, ObjectId> include;
+
+	private final Set<RevCommit> assume;
+
+	/**
+	 * Create a writer for a bundle.
+	 * 
+	 * @param repo
+	 *            repository where objects are stored.
+	 * @param monitor
+	 *            operations progress monitor.
+	 */
+	public BundleWriter(final Repository repo, final ProgressMonitor monitor) {
+		packWriter = new PackWriter(repo, monitor);
+		include = new TreeMap<String, ObjectId>();
+		assume = new HashSet<RevCommit>();
+	}
+
+	/**
+	 * Include an object (and everything reachable from it) in the bundle.
+	 * 
+	 * @param name
+	 *            name the recipient can discover this object as from the
+	 *            bundle's list of advertised refs . The name must be a valid
+	 *            ref format and must not have already been included in this
+	 *            bundle writer.
+	 * @param id
+	 *            object to pack. Multiple refs may point to the same object.
+	 */
+	public void include(final String name, final AnyObjectId id) {
+		if (!Repository.isValidRefName(name))
+			throw new IllegalArgumentException("Invalid ref name: " + name);
+		if (include.containsKey(name))
+			throw new IllegalStateException("Duplicate ref: " + name);
+		include.put(name, id.toObjectId());
+	}
+
+	/**
+	 * Include a single ref (a name/object pair) in the bundle.
+	 * <p>
+	 * This is a utility function for:
+	 * <code>include(r.getName(), r.getObjectId())</code>.
+	 * 
+	 * @param r
+	 *            the ref to include.
+	 */
+	public void include(final Ref r) {
+		include(r.getName(), r.getObjectId());
+	}
+
+	/**
+	 * Assume a commit is available on the recipient's side.
+	 * <p>
+	 * In order to fetch from a bundle the recipient must have any assumed
+	 * commit. Each assumed commit is explicitly recorded in the bundle header
+	 * to permit the recipient to validate it has these objects.
+	 * 
+	 * @param c
+	 *            the commit to assume being available. This commit should be
+	 *            parsed and not disposed in order to maximize the amount of
+	 *            debugging information available in the bundle stream.
+	 */
+	public void assume(final RevCommit c) {
+		if (c != null)
+			assume.add(c);
+	}
+
+	/**
+	 * Generate and write the bundle to the output stream.
+	 * <p>
+	 * This method can only be called once per BundleWriter instance.
+	 * 
+	 * @param os
+	 *            the stream the bundle is written to. If the stream is not
+	 *            buffered it will be buffered by the writer. Caller is
+	 *            responsible for closing the stream.
+	 * @throws IOException
+	 *             an error occurred reading a local object's data to include in
+	 *             the bundle, or writing compressed object data to the output
+	 *             stream.
+	 */
+	public void writeBundle(OutputStream os) throws IOException {
+		if (!(os instanceof BufferedOutputStream))
+			os = new BufferedOutputStream(os);
+
+		final HashSet<ObjectId> inc = new HashSet<ObjectId>();
+		final HashSet<ObjectId> exc = new HashSet<ObjectId>();
+		inc.addAll(include.values());
+		for (final RevCommit r : assume)
+			exc.add(r.getId());
+		packWriter.preparePack(inc, exc, exc.size() > 0, true);
+
+		final Writer w = new OutputStreamWriter(os, Constants.CHARSET);
+		w.write(TransportBundle.V2_BUNDLE_SIGNATURE);
+		w.write('\n');
+
+		final char[] tmp = new char[Constants.OBJECT_ID_LENGTH * 2];
+		for (final RevCommit a : assume) {
+			w.write('-');
+			a.copyTo(tmp, w);
+			if (a.getRawBuffer() != null) {
+				w.write(' ');
+				w.write(a.getShortMessage());
+			}
+			w.write('\n');
+		}
+		for (final Map.Entry<String, ObjectId> e : include.entrySet()) {
+			e.getValue().copyTo(tmp, w);
+			w.write(' ');
+			w.write(e.getKey());
+			w.write('\n');
+		}
+
+		w.write('\n');
+		w.flush();
+		packWriter.writePack(os);
+	}
+}
-- 
1.6.0.2.706.g340fc
