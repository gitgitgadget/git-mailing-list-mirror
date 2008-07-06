From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [JGIT PATCH 1/1] jgit: create a tag command
Date: Mon, 7 Jul 2008 00:41:35 +0200
Message-ID: <200807070041.35873.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Marek Zawirski'" <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "'Shawn O. Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 00:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFd3d-000864-Qz
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 00:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbYGFWqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 18:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbYGFWqZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 18:46:25 -0400
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:57655 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbYGFWqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 18:46:24 -0400
Received: by av12-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 0D9A237EF2; Mon,  7 Jul 2008 00:46:22 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id D040B37EB6; Mon,  7 Jul 2008 00:46:21 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id B084137E43;
	Mon,  7 Jul 2008 00:46:21 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87562>

This command allows us to create simple or annotated tags using the jgit command line.
PGP signed tags are not yet supported.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

I ned this for tagging self-jgit-managed automated builds of the Eclipse plugin.
I could do with an Ant task, but this will work too.

-- robin
 org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java |   96 ++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java


diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
new file mode 100644
index 0000000..a9377f5
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.PersonIdent;
+
+class Tag extends TextBuiltin {
+	@Override
+	void execute(String[] args) throws Exception {
+		String tagName = null;
+		String message = null;
+		boolean force = false;
+		for (int i = 0; i < args.length; ++i) {
+			if (args[i].equals("-f")) {
+				force = true;
+				continue;
+			}
+			if (args[i].equals("-m")) {
+				if (i < args.length - 2)
+					message = args[i++] + "\n";
+				else
+					usage();
+				continue;
+			}
+			if (args[i].startsWith("-m")) {
+				message = args[i].substring(2) + "\n";
+				continue;
+			}
+			if (args[i].startsWith("-") && i == args.length - 1)
+				usage();
+			if (i == args.length - 1) {
+				tagName = args[i];
+				continue;
+			}
+			usage();
+		}
+		if (!tagName.startsWith(Constants.TAGS_PREFIX + "/"))
+			tagName = Constants.TAGS_PREFIX + "/" + tagName;
+		if (!force && db.resolve(tagName) != null) {
+			throw die("fatal: tag '"
+					+ tagName.substring(Constants.TAGS_PREFIX.length() + 1)
+					+ "' exists");
+		}
+		org.spearce.jgit.lib.Tag tag = new org.spearce.jgit.lib.Tag(db);
+		tag.setObjId(db.resolve(Constants.HEAD));
+		if (message != null) {
+			message = message.replaceAll("\r", "");
+			tag.setMessage(message);
+			tag.setTagger(new PersonIdent(db));
+			tag.setType("commit");
+		}
+		tag.setTag(tagName.substring(Constants.TAGS_PREFIX.length() + 1));
+		tag.tag();
+	}
+
+	private void usage() {
+		new Throwable().printStackTrace();
+		throw die("Usage: -m message tag");
+	}
+}
-- 
1.5.6.2.220.g44701
