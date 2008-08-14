From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH 1/7] Refactor of WalkRemoteObjectDatabase ref writing into common class
Date: Thu, 14 Aug 2008 20:13:43 +1000
Message-ID: <1218708829-8175-2-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:15:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZra-00038Q-Dt
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbYHNKOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYHNKOR
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:14:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:44651 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbYHNKOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:14:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so333673rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=hKSGaw8R9IYQwfjM/HMvNJupxsMGJbHSfnvKGvPv53s=;
        b=isHeyCICVy+NXYuDTLRQPTDMkM82kkOpLiRwO5UtSumJDmHUPuDZe2ryaIGNHDQFnO
         AkMld/gLc7+LrFA1QyfMDld02zbIBrpSvHke92TPlrLy7Pfb64VFQpPWN9BF6NNGP6Zv
         M9ftdc53nm1hkBPPHkRAnCwB1bLG2mouFBtBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=GpknUfNJ3tUmWxkz3excgKa5gSrRH/UKFL5CBBOR0tDZNKpm0lq2a520GOhsObP0nx
         7luaCUuDEkHRR89mLpy3Bg6YrnlVrdPA2IulAhfr5VXXDSzILnw0L3jJU2TAZ7SD9Es7
         Efkpaxo02fubqkX+I6sGukJ5Ni9W6fdxNT68E=
Received: by 10.114.170.2 with SMTP id s2mr944703wae.170.1218708855074;
        Thu, 14 Aug 2008 03:14:15 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id a8sm2909044poa.12.2008.08.14.03.14.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 03:14:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218708829-8175-1-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92345>

In particular writeInfoRefs and writePackedRefs into common RefWriter
class for reuse with branch deletion in jgit.

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/Constants.java        |    6 +
 .../src/org/spearce/jgit/lib/RefWriter.java        |  175 ++++++++++++++++++++
 .../spearce/jgit/transport/WalkPushConnection.java |   12 +-
 .../jgit/transport/WalkRemoteObjectDatabase.java   |   94 -----------
 4 files changed, 191 insertions(+), 96 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 7c2cef9..7bbd88e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -214,6 +214,12 @@ public final class Constants {
 	/** Prefix for tag refs */
 	public static final String TAGS_PREFIX = "refs/tags";
 
+	/** Info refs folder */
+	public static final String INFO_REFS = "info/refs";
+
+	/** Packed refs file */
+	public static final String PACKED_REFS = "packed-refs";
+
 	/**
 	 * Create a new digest function for objects.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
new file mode 100644
index 0000000..9c784d5
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Charles O'Farrell <charleso@charleso.org>
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
+package org.spearce.jgit.lib;
+
+import java.io.IOException;
+import java.io.StringWriter;
+import java.util.Collection;
+import java.util.Comparator;
+import java.util.TreeSet;
+
+/**
+ * Writes out refs to the {@link Constants#INFO_REFS} and
+ * {@link Constants#PACKED_REFS} files.
+ * 
+ * This class is abstract as the writing of the files must be handled by the
+ * caller. This is because it is used by transport classes as well.
+ */
+public abstract class RefWriter {
+
+	private final Collection<Ref> refs;
+
+	/**
+	 * @param refs
+	 *            the complete set of references. This should have been computed
+	 *            by applying updates to the advertised refs already discovered.
+	 */
+	public RefWriter(Collection<Ref> refs) {
+		this.refs = new TreeSet<Ref>(RefComparator.INSTANCE);
+		this.refs.addAll(refs);
+	}
+
+	/**
+	 * Rebuild the {@link Constants#INFO_REFS}.
+	 * <p>
+	 * This method rebuilds the contents of the {@link Constants#INFO_REFS} file
+	 * to match the passed list of references.
+	 * 
+	 * 
+	 * @throws IOException
+	 *             writing is not supported, or attempting to write the file
+	 *             failed, possibly due to permissions or remote disk full, etc.
+	 */
+	public void writeInfoRefs() throws IOException {
+		final StringWriter w = new StringWriter();
+		final char[] tmp = new char[Constants.OBJECT_ID_LENGTH * 2];
+		for (final Ref r : refs) {
+			if (Constants.HEAD.equals(r.getName())) {
+				// Historically HEAD has never been published through
+				// the INFO_REFS file. This is a mistake, but its the
+				// way things are.
+				//
+				continue;
+			}
+
+			r.getObjectId().copyTo(tmp, w);
+			w.write('\t');
+			w.write(r.getName());
+			w.write('\n');
+
+			if (r.getPeeledObjectId() != null) {
+				r.getPeeledObjectId().copyTo(tmp, w);
+				w.write('\t');
+				w.write(r.getName());
+				w.write("^{}\n");
+			}
+		}
+		writeFile(Constants.INFO_REFS, Constants.encodeASCII(w.toString()));
+	}
+
+	/**
+	 * Rebuild the {@link Constants#PACKED_REFS} file.
+	 * <p>
+	 * This method rebuilds the contents of the {@link Constants#PACKED_REFS}
+	 * file to match the passed list of references, including only those refs
+	 * that have a storage type of {@link Ref.Storage#PACKED}.
+	 * 
+	 * @throws IOException
+	 *             writing is not supported, or attempting to write the file
+	 *             failed, possibly due to permissions or remote disk full, etc.
+	 */
+	public void writePackedRefs() throws IOException {
+		boolean peeled = false;
+
+		for (final Ref r : refs) {
+			if (r.getStorage() != Ref.Storage.PACKED)
+				continue;
+			if (r.getPeeledObjectId() != null)
+				peeled = true;
+		}
+
+		final StringWriter w = new StringWriter();
+		if (peeled) {
+			w.write("# pack-refs with:");
+			if (peeled)
+				w.write(" peeled");
+			w.write('\n');
+		}
+
+		final char[] tmp = new char[Constants.OBJECT_ID_LENGTH * 2];
+		for (final Ref r : refs) {
+			if (r.getStorage() != Ref.Storage.PACKED)
+				continue;
+
+			r.getObjectId().copyTo(tmp, w);
+			w.write(' ');
+			w.write(r.getName());
+			w.write('\n');
+
+			if (r.getPeeledObjectId() != null) {
+				w.write('^');
+				r.getPeeledObjectId().copyTo(tmp, w);
+				w.write('\n');
+			}
+		}
+		writeFile(Constants.PACKED_REFS, Constants.encodeASCII(w.toString()));
+	}
+
+	/**
+	 * Handles actual writing of ref files to the git repository, which may
+	 * differ slightly depending on the destination and transport.
+	 * 
+	 * @param file
+	 *            path to ref file.
+	 * @param content
+	 *            byte content of file to be written.
+	 * @throws IOException
+	 */
+	protected abstract void writeFile(String file, byte[] content)
+			throws IOException;
+
+	private static class RefComparator implements Comparator<Ref> {
+
+		private static final RefComparator INSTANCE = new RefComparator();
+
+		public int compare(Ref o1, Ref o2) {
+			return o1.getName().compareTo(o2.getName());
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index 904a699..19071d7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -53,6 +53,7 @@ import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.PackWriter;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.RefWriter;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Ref.Storage;
 import org.spearce.jgit.transport.RemoteRefUpdate.Status;
@@ -158,9 +159,16 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 		if (!updates.isEmpty() && isNewRepository())
 			createNewRepository(updates);
 
+		RefWriter refWriter = new RefWriter(newRefs.values()) {
+			@Override
+			protected void writeFile(String file, byte[] content)
+					throws IOException {
+				dest.writeFile("../" + file, content);
+			}
+		};
 		if (!packedRefUpdates.isEmpty()) {
 			try {
-				dest.writePackedRefs(newRefs.values());
+				refWriter.writePackedRefs();
 				for (final RemoteRefUpdate u : packedRefUpdates)
 					u.setStatus(Status.OK);
 			} catch (IOException err) {
@@ -173,7 +181,7 @@ class WalkPushConnection extends BaseConnection implements PushConnection {
 		}
 
 		try {
-			dest.writeInfoRefs(newRefs.values());
+			refWriter.writeInfoRefs();
 		} catch (IOException err) {
 			throw new TransportException(uri, "failed updating refs", err);
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index c5a5199..25640dc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -44,7 +44,6 @@ import java.io.IOException;
 import java.io.InputStream;
 import java.io.InputStreamReader;
 import java.io.OutputStream;
-import java.io.StringWriter;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.Map;
@@ -337,99 +336,6 @@ abstract class WalkRemoteObjectDatabase {
 	}
 
 	/**
-	 * Rebuild the {@link #INFO_REFS} for dumb transport clients.
-	 * <p>
-	 * This method rebuilds the contents of the {@link #INFO_REFS} file to match
-	 * the passed list of references.
-	 *
-	 * @param refs
-	 *            the complete set of references the remote side now has. This
-	 *            should have been computed by applying updates to the
-	 *            advertised refs already discovered.
-	 * @throws IOException
-	 *             writing is not supported, or attempting to write the file
-	 *             failed, possibly due to permissions or remote disk full, etc.
-	 */
-	void writeInfoRefs(final Collection<Ref> refs) throws IOException {
-		final StringWriter w = new StringWriter();
-		final char[] tmp = new char[Constants.OBJECT_ID_LENGTH * 2];
-		for (final Ref r : refs) {
-			if (Constants.HEAD.equals(r.getName())) {
-				// Historically HEAD has never been published through
-				// the INFO_REFS file. This is a mistake, but its the
-				// way things are.
-				//
-				continue;
-			}
-
-			r.getObjectId().copyTo(tmp, w);
-			w.write('\t');
-			w.write(r.getName());
-			w.write('\n');
-
-			if (r.getPeeledObjectId() != null) {
-				r.getPeeledObjectId().copyTo(tmp, w);
-				w.write('\t');
-				w.write(r.getName());
-				w.write("^{}\n");
-			}
-		}
-		writeFile(INFO_REFS, Constants.encodeASCII(w.toString()));
-	}
-
-	/**
-	 * Rebuild the {@link #PACKED_REFS} file.
-	 * <p>
-	 * This method rebuilds the contents of the {@link #PACKED_REFS} file to
-	 * match the passed list of references, including only those refs that have
-	 * a storage type of {@link Ref.Storage#PACKED}.
-	 *
-	 * @param refs
-	 *            the complete set of references the remote side now has. This
-	 *            should have been computed by applying updates to the
-	 *            advertised refs already discovered.
-	 * @throws IOException
-	 *             writing is not supported, or attempting to write the file
-	 *             failed, possibly due to permissions or remote disk full, etc.
-	 */
-	void writePackedRefs(final Collection<Ref> refs) throws IOException {
-		boolean peeled = false;
-
-		for (final Ref r : refs) {
-			if (r.getStorage() != Ref.Storage.PACKED)
-				continue;
-			if (r.getPeeledObjectId() != null)
-				peeled = true;
-		}
-
-		final StringWriter w = new StringWriter();
-		if (peeled) {
-			w.write("# pack-refs with:");
-			if (peeled)
-				w.write(" peeled");
-			w.write('\n');
-		}
-
-		final char[] tmp = new char[Constants.OBJECT_ID_LENGTH * 2];
-		for (final Ref r : refs) {
-			if (r.getStorage() != Ref.Storage.PACKED)
-				continue;
-
-			r.getObjectId().copyTo(tmp, w);
-			w.write(' ');
-			w.write(r.getName());
-			w.write('\n');
-
-			if (r.getPeeledObjectId() != null) {
-				w.write('^');
-				r.getPeeledObjectId().copyTo(tmp, w);
-				w.write('\n');
-			}
-		}
-		writeFile(PACKED_REFS, Constants.encodeASCII(w.toString()));
-	}
-
-	/**
 	 * Open a buffered reader around a file.
 	 * <p>
 	 * This is shorthand for calling {@link #open(String)} and then wrapping it
-- 
1.6.0.rc2.35.g04c6e
