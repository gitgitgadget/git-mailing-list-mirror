From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH v2 1/3] Extract RefComparator to sort collection of Refs
Date: Wed, 20 Aug 2008 21:00:39 +1000
Message-ID: <1219230041-7998-2-git-send-email-charleso@charleso.org>
References: <1219230041-7998-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:02:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVlSc-0005rP-HR
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 13:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYHTLBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 07:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169AbYHTLBi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 07:01:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:1941 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYHTLBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 07:01:36 -0400
Received: by rv-out-0506.google.com with SMTP id k40so404578rvb.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=wvGjNWie5gImy/Kht3UeipjaU/xxvF31EE73h0JcYLE=;
        b=pl8VTl4qITJj71R5gjQb7egXBVzKYYGBwWq3PzqrebgjzmUhNqdZyV6SQeno/fUMAw
         GkoaKkAG1arcwX3DSo1kD3zykMrBfg7QftGKEsTjjDd481mReH2VL5uu1mOfresGTmVS
         FhgS+yMymBmdgGf13sG49l59LNoa1eqoAbhE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=JptthmsUyDFy5XK/Zq1XuaKsNCzVxRBG+AEoKLA9S76bzgR5CFrHegVeg53x8DcfHS
         EOicBwRnsPqyP8zOHircnPSK32EL/AcpZxBqFsyXCz2sPKZ/mOFemMq3zYV4VyTD5Bzl
         OXZGrHOzGagbGsQcYd6HcT0gqWUcTKMBoLJ9Q=
Received: by 10.114.53.1 with SMTP id b1mr7736551waa.53.1219230096444;
        Wed, 20 Aug 2008 04:01:36 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id n22sm2340253pof.3.2008.08.20.04.00.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 04:01:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.g2ebc0
In-Reply-To: <1219230041-7998-1-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92976>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefComparator.java    |   72 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefWriter.java        |   14 +----
 2 files changed, 73 insertions(+), 13 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java
new file mode 100644
index 0000000..95e3e0f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java
@@ -0,0 +1,72 @@
+/**
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
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.Collections;
+import java.util.Comparator;
+import java.util.List;
+
+/**
+ * Util for sorting (or comparing) Ref instances by name.
+ * <p>
+ * Useful for command line tools or writing out refs to file.
+ */
+public class RefComparator implements Comparator<Ref> {
+
+	/** Singleton instance of RefComparator */
+	public static final RefComparator INSTANCE = new RefComparator();
+
+	public int compare(final Ref o1, final Ref o2) {
+		return o1.getName().compareTo(o2.getName());
+	}
+
+	/**
+	 * Sorts the collection of refs, returning a new collection.
+	 * 
+	 * @param refs
+	 *            collection to be sorted
+	 * @return sorted collection of refs
+	 */
+	public static Collection<Ref> sort(final Collection<Ref> refs) {
+		final List<Ref> r = new ArrayList<Ref>(refs);
+		Collections.sort(r, INSTANCE);
+		return r;
+	}
+}
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
index 9c784d5..2d39713 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefWriter.java
@@ -41,8 +41,6 @@
 import java.io.IOException;
 import java.io.StringWriter;
 import java.util.Collection;
-import java.util.Comparator;
-import java.util.TreeSet;
 
 /**
  * Writes out refs to the {@link Constants#INFO_REFS} and
@@ -61,8 +59,7 @@
 	 *            by applying updates to the advertised refs already discovered.
 	 */
 	public RefWriter(Collection<Ref> refs) {
-		this.refs = new TreeSet<Ref>(RefComparator.INSTANCE);
-		this.refs.addAll(refs);
+		this.refs = RefComparator.sort(refs);
 	}
 
 	/**
@@ -163,13 +160,4 @@ public void writePackedRefs() throws IOException {
 	 */
 	protected abstract void writeFile(String file, byte[] content)
 			throws IOException;
-
-	private static class RefComparator implements Comparator<Ref> {
-
-		private static final RefComparator INSTANCE = new RefComparator();
-
-		public int compare(Ref o1, Ref o2) {
-			return o1.getName().compareTo(o2.getName());
-		}
-	}
 }
-- 
1.6.0.2.g2ebc0
