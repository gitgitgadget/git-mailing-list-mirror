From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/7] Add prerequisite verification to the bundle transport
Date: Thu,  4 Sep 2008 16:42:16 -0700
Message-ID: <1220571739-4219-5-git-send-email-spearce@spearce.org>
References: <1220571739-4219-1-git-send-email-spearce@spearce.org>
 <1220571739-4219-2-git-send-email-spearce@spearce.org>
 <1220571739-4219-3-git-send-email-spearce@spearce.org>
 <1220571739-4219-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOUu-0000st-Sz
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbYIDXmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbYIDXmd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:42:33 -0400
Received: from george.spearce.org ([209.20.77.23]:33773 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYIDXmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:42:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 544D8383A8; Thu,  4 Sep 2008 23:42:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4155C38353;
	Thu,  4 Sep 2008 23:42:21 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
In-Reply-To: <1220571739-4219-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94978>

Before we can fetch the objects contained within the bundle into
the repository we need to know if we have the necessary bases in
our reachable history, thus ensuring that we have what is needed
to fill out the thin pack and access everything contained within
it.  If we are missing any of the commits named as prerequisites
in the bundle header we cannot import it.

I forgot to implement this when I initially added bundle support
to the transport implementation.  Better late then never.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../errors/MissingBundlePrerequisiteException.java |   73 ++++++++++++++++++++
 .../spearce/jgit/transport/TransportBundle.java    |   68 ++++++++++++++++++
 2 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java
new file mode 100644
index 0000000..ccd9281
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java
@@ -0,0 +1,73 @@
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
+package org.spearce.jgit.errors;
+
+import java.util.Collection;
+
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.transport.URIish;
+
+/**
+ * Indicates a base/common object was required, but is not found.
+ */
+public class MissingBundlePrerequisiteException extends TransportException {
+	private static final long serialVersionUID = 1L;
+
+	private static String format(final Collection<ObjectId> ids) {
+		final StringBuilder r = new StringBuilder();
+		r.append("missing prerequisite commits:");
+		for (final ObjectId p : ids) {
+			r.append("\n  ");
+			r.append(p.name());
+		}
+		return r.toString();
+	}
+
+	/**
+	 * Constructs a MissingBundlePrerequisiteException for a set of objects.
+	 * 
+	 * @param uri
+	 *            URI used for transport
+	 * @param ids
+	 *            the ids of the base/common object(s) we don't have.
+	 */
+	public MissingBundlePrerequisiteException(final URIish uri,
+			final Collection<ObjectId> ids) {
+		super(uri, format(ids));
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
index d8c2ba4..e502619 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundle.java
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
  *
  * All rights reserved.
  *
@@ -44,11 +45,15 @@
 import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.InputStream;
+import java.util.ArrayList;
 import java.util.Collection;
 import java.util.HashSet;
 import java.util.LinkedHashMap;
+import java.util.List;
 import java.util.Set;
 
+import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.errors.MissingBundlePrerequisiteException;
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.PackProtocolException;
 import org.spearce.jgit.errors.TransportException;
@@ -57,6 +62,10 @@
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevFlag;
+import org.spearce.jgit.revwalk.RevObject;
+import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.util.FS;
 import org.spearce.jgit.util.RawParseUtils;
 
@@ -200,6 +209,7 @@ private String readLine(final byte[] hdrbuf) throws IOException {
 		@Override
 		protected void doFetch(final ProgressMonitor monitor,
 				final Collection<Ref> want) throws TransportException {
+			verifyPrerequisites();
 			try {
 				final IndexPack ip = IndexPack.create(local, in);
 				ip.setFixThin(true);
@@ -214,6 +224,64 @@ protected void doFetch(final ProgressMonitor monitor,
 			}
 		}
 
+		private void verifyPrerequisites() throws TransportException {
+			if (prereqs.isEmpty())
+				return;
+
+			final RevWalk rw = new RevWalk(local);
+			final RevFlag PREREQ = rw.newFlag("PREREQ");
+			final RevFlag SEEN = rw.newFlag("SEEN");
+			
+			final List<ObjectId> missing = new ArrayList<ObjectId>();
+			final List<RevObject> commits = new ArrayList<RevObject>();
+			for (final ObjectId p : prereqs) {
+				try {
+					final RevCommit c = rw.parseCommit(p);
+					if (!c.has(PREREQ)) {
+						c.add(PREREQ);
+						commits.add(c);
+					}
+				} catch (MissingObjectException notFound) {
+					missing.add(p);
+				} catch (IOException err) {
+					throw new TransportException(uri, "Cannot read commit "
+							+ p.name(), err);
+				}
+			}
+			if (!missing.isEmpty())
+				throw new MissingBundlePrerequisiteException(uri, missing);
+
+			for (final Ref r : local.getAllRefs().values()) {
+				try {
+					rw.markStart(rw.parseCommit(r.getObjectId()));
+				} catch (IOException readError) {
+					// If we cannot read the value of the ref skip it.
+				}
+			}
+
+			int remaining = commits.size();
+			try {
+				RevCommit c;
+				while ((c = rw.next()) != null) {
+					if (c.has(PREREQ)) {
+						c.add(SEEN);
+						if (--remaining == 0)
+							break;
+					}
+				}
+			} catch (IOException err) {
+				throw new TransportException(uri, "Cannot read object", err);
+			}
+
+			if (remaining > 0) {
+				for (final RevObject o : commits) {
+					if (!o.has(SEEN))
+						missing.add(o);
+				}
+				throw new MissingBundlePrerequisiteException(uri, missing);
+			}
+		}
+
 		@Override
 		public void close() {
 			if (in != null) {
-- 
1.6.0.1.319.g9f32b
