From: Charles O'Farrell <charleso@charleso.org>
Subject: [JGIT PATCH 1/3] Extract RefComparator to sort collection of Refs
Date: Mon, 18 Aug 2008 21:01:43 +1000
Message-ID: <1219057305-9284-2-git-send-email-charleso@charleso.org>
References: <1219057305-9284-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 13:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV2W7-0003yB-Pa
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 13:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbYHRLCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 07:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYHRLCD
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 07:02:03 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:60016 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYHRLCA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 07:02:00 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1218265waf.23
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=a9rp/yyw/4WAQ0QFZSOUmvIkAdq61RRJzdkgIUyXUJs=;
        b=DU/+k0we9XqXtWvkeo28yzzXu/pmV6h8YLlTyHA92YzMouE+xNXplE7ERiMF1HbjNx
         4Pj1aAG05OYmbKNoMVVVkJz7k1t4m9nOVvdPgw2+XM5LbK3+2+rojnBuirkmOJYpDu/s
         zEYAwL36V+MzP1cQoKMZ/Unr9fI/6rPtJlV7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=hATofPbo4738wIFeXHNTLvVIpNtbd4G77LqK9uX6v2Xkyh/OWwtsKkBf6qygEeMoBh
         kEA2DWkui2BwQE3ynUplwhne5oxQ1+kEznBQYmeRjQBhrPzdkA7fU8sS4BP3GFmrH970
         8Cgq2gFsnS2b56uPQNOa9jC4hhxhMU18MYcCM=
Received: by 10.115.75.14 with SMTP id c14mr4847997wal.45.1219057320289;
        Mon, 18 Aug 2008 04:02:00 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.197.247])
        by mx.google.com with ESMTPS id m28sm1842154poh.10.2008.08.18.04.01.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 04:01:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.g2ebc0
In-Reply-To: <1219057305-9284-1-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92697>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefComparator.java    |   72 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefWriter.java        |   14 +----
 2 files changed, 73 insertions(+), 13 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java
new file mode 100644
index 0000000..6d994eb
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
+	public int compare(Ref o1, Ref o2) {
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
