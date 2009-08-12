From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT 5/5] Treat gitlink tree entries similar to symlink tree entries
Date: Wed, 12 Aug 2009 11:07:09 -0400
Message-ID: <1250089629-22547-1-git-send-email-fonseca@diku.dk>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:07:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFQG-0003D1-93
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZHLPHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 11:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbZHLPHO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:07:14 -0400
Received: from mail-yw0-f191.google.com ([209.85.211.191]:62731 "EHLO
	mail-yw0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbZHLPHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:07:12 -0400
Received: by ywh29 with SMTP id 29so94020ywh.33
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=wmDqsy1TNecb6T24Bxn8WQM9WMgJJ76rwUFwY+7Vl6c=;
        b=S4KgZa2u1aKqqsfaEcklgvu7MFPkZtLI+xhNJRYW4B4Kvf72vqDhRLwlrGE0a+FFpG
         6IkNUyX8f4GfaYzMu+Acn/4L89dfa6+XUxzifvYFhRK2CdbvDwfurcsJtJAgOtaWcWT0
         /i96V37kRb48Io9RQU4cImMJo9xNOSJz7Uesg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=TgtCaxldUexaWzZ2iDefe37UjWoKAz3W0zdIuNr+O+ZEVA+uBZ1BeZpo8ur8clFAvl
         gsyiZxqfPG/Rwa1geR5f2SrFNV5m0UzEvyU8zqNECJBAKrv0Oy6kz1SRW66KA1Rovlb4
         PmuZQFEeTOLnhdFP3erkcUsUdGs/AwqnL3YhQ=
Received: by 10.91.143.18 with SMTP id v18mr129258agn.71.1250089631832;
        Wed, 12 Aug 2009 08:07:11 -0700 (PDT)
Received: from localhost.localdomain (bas1-montreal42-1178045554.dsl.bell.ca [70.55.140.114])
        by mx.google.com with ESMTPS id 18sm2769976agb.10.2009.08.12.08.07.10
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 08:07:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc3.195.g2b05f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125707>

Adds minimal support for gitlinks, based on the existing code for
handling symlinks. The goal is to avoid exceptions when reading trees
with gitlinks.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../jgit/errors/GitlinksNotSupportedException.java |   58 +++++++++++++
 .../src/org/spearce/jgit/lib/ForceModified.java    |    4 +
 .../src/org/spearce/jgit/lib/GitlinkTreeEntry.java |   85 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/TreeVisitor.java      |    8 ++
 .../src/org/spearce/jgit/lib/WriteTree.java        |    7 ++
 5 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/GitlinksNotSupportedException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/GitlinksNotSupportedException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/GitlinksNotSupportedException.java
new file mode 100644
index 0000000..8f8883f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/GitlinksNotSupportedException.java
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2007, Shawn O. Pearce <spearce@spearce.org>
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
+import java.io.IOException;
+
+/**
+ * An exception thrown when a gitlink entry is found and cannot be
+ * handled.
+ */
+public class GitlinksNotSupportedException extends IOException {
+	private static final long serialVersionUID = 1L;
+
+	/**
+	 * Construct a GitlinksNotSupportedException for the specified link
+	 *
+	 * @param s name of link in tree or workdir
+	 */
+	public GitlinksNotSupportedException(final String s) {
+		super(s);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ForceModified.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ForceModified.java
index 6d38068..9c94e13 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ForceModified.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ForceModified.java
@@ -61,4 +61,8 @@ public void visitSymlink(final SymlinkTreeEntry s) throws IOException {
 		// Eclipse
 		// and Pure Java does not know what to do about symbolic links.
 	}
+
+	public void visitGitlink(GitlinkTreeEntry s) throws IOException {
+		// TODO: handle gitlinks.
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java
new file mode 100644
index 0000000..babbc26
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitlinkTreeEntry.java
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2007, Shawn O. Pearce <spearce@spearce.org>
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
+
+/**
+ * A tree entry representing a symbolic link.
+ *
+ * Note. Java cannot really handle these as file system objects.
+ */
+public class GitlinkTreeEntry extends TreeEntry {
+	private static final long serialVersionUID = 1L;
+
+	/**
+	 * Construct a {@link SymlinkTreeEntry} with the specified name and SHA-1 in
+	 * the specified parent
+	 *
+	 * @param parent
+	 * @param id
+	 * @param nameUTF8
+	 */
+	public GitlinkTreeEntry(final Tree parent, final ObjectId id,
+			final byte[] nameUTF8) {
+		super(parent, id, nameUTF8);
+	}
+
+	public FileMode getMode() {
+		return FileMode.GITLINK;
+	}
+
+	public void accept(final TreeVisitor tv, final int flags)
+			throws IOException {
+		if ((MODIFIED_ONLY & flags) == MODIFIED_ONLY && !isModified()) {
+			return;
+		}
+
+		tv.visitGitlink(this);
+	}
+
+	@Override
+	public String toString() {
+		final StringBuffer r = new StringBuffer();
+		r.append(ObjectId.toString(getId()));
+		r.append(" G ");
+		r.append(getFullName());
+		return r.toString();
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitor.java
index 78a6c22..8293c24 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeVisitor.java
@@ -77,4 +77,12 @@
 	 * @throws IOException
 	 */
 	public void visitSymlink(final SymlinkTreeEntry s) throws IOException;
+
+	/**
+	 * Visit to a gitlink.
+	 *
+	 * @param s Gitlink entry
+	 * @throws IOException
+	 */
+	public void visitGitlink(final GitlinkTreeEntry s) throws IOException;
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WriteTree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WriteTree.java
index 9841678..d6725a9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WriteTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WriteTree.java
@@ -41,6 +41,7 @@
 import java.io.File;
 import java.io.IOException;
 
+import org.spearce.jgit.errors.GitlinksNotSupportedException;
 import org.spearce.jgit.errors.SymlinksNotSupportedException;
 
 /**
@@ -78,4 +79,10 @@ public void endVisitTree(final Tree t) throws IOException {
 		super.endVisitTree(t);
 		t.setId(ow.writeTree(t));
 	}
+
+	public void visitGitlink(GitlinkTreeEntry s) throws IOException {
+		if (s.isModified()) {
+			throw new GitlinksNotSupportedException(s.getFullName());
+		}
+	}
 }
-- 
1.6.4.rc3.195.g2b05f
