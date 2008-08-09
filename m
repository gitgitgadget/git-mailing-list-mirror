From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH] jgit: create a branch command
Date: Sat,  9 Aug 2008 16:04:28 +1000
Message-ID: <1218261868-6508-1-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: charleso@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 08:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRhbF-0004P5-6q
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 08:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYHIGEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 02:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbYHIGEf
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 02:04:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:30528 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbYHIGEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 02:04:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1380169rvb.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 23:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=5LAH7xwpmw6OQN9FHRM9mXkYO8ufhnF8FiMzZpDuk6c=;
        b=fsRxQAiZAfUk6gpxpt4VXMYFaUg0IdPZIaHm53duXWGqC+MQig1klMEHOLR6mImx24
         /F7Yox8BTg0nGsCWt+kKs4AMjrRyUSbUpnNFun8gqEeVu5eH1pIDofi7SarOLcyhfaiN
         DfLHzjqxy4rI2Ad0uLKFTT2SnZ1CifM9Mfo90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=QW2ngwJFLk0Kj7HAAUhJoqE1Fh+2l/Gade5e5YJdgC3z6alsP4Siw2jq5E/WiKBxYQ
         z10c9YNwHGPZX3SkXHYvNyHLWmw1rwlaJ2pGSE4YWw+YuAQaLd8nHOmAWByxZnsS0kbH
         kbSmCcNKX/PqcoAmg2rvDHqO0N4A1wY0Dthy0=
Received: by 10.141.203.7 with SMTP id f7mr1944496rvq.7.1218261874140;
        Fri, 08 Aug 2008 23:04:34 -0700 (PDT)
Received: from localhost.localdomain ( [118.208.117.113])
        by mx.google.com with ESMTPS id g22sm3703497rvb.7.2008.08.08.23.04.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Aug 2008 23:04:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.11.g1ce47.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91742>

This command lists the existing branches, highlighting the current branch with an asterisk. Currently only the -r and -a options are supported.

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Branch.java           |   83 ++++++++++++++++++++
 2 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index 1ff5a30..734de3d 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -1,3 +1,4 @@
+org.spearce.jgit.pgm.Branch
 org.spearce.jgit.pgm.DiffTree
 org.spearce.jgit.pgm.Fetch
 org.spearce.jgit.pgm.Glog
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
new file mode 100644
index 0000000..8415fe2
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2007, Charles O'Farrell <charleso@charleso.org>
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
+package org.spearce.jgit.pgm;
+
+import java.util.Map;
+import java.util.TreeSet;
+
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.Ref;
+
+@Command(common = true, usage = "List, create, or delete branches")
+class Branch extends TextBuiltin {
+
+	@Option(name = "--remote", aliases = { "-r" }, usage = "act on remote-tracking branches")
+	boolean remote = false;
+
+	@Option(name = "--all", aliases = { "-a" }, usage = "list both remote-tracking and local branches")
+	boolean all = false;
+
+	@Override
+	protected void run() throws Exception {
+		Map<String, Ref> refs = db.getAllRefs();
+		Ref head = refs.get(Constants.HEAD);
+		// This can happen if HEAD is stillborn
+		if (head != null) {
+			String current = head.getName();
+			if (current.equals(Constants.HEAD))
+				printHead("(no branch)", true);
+			for (String ref : new TreeSet<String>(refs.keySet())) {
+				if (isHead(ref))
+					printHead(ref, current.equals(ref));
+			}
+		}
+	}
+
+	private boolean isHead(String key) {
+		return (all || !remote) && key.startsWith(Constants.HEADS_PREFIX)
+				|| (all || remote) && key.startsWith(Constants.REMOTES_PREFIX);
+	}
+
+	private void printHead(String ref, boolean isCurrent) {
+		out.print(isCurrent ? '*' : ' ');
+		out.print(' ');
+		ref = ref.substring(ref.indexOf('/', 5) + 1);
+		out.println(ref);
+	}
+}
-- 
1.5.6
