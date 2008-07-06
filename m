From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Mon, 7 Jul 2008 01:16:39 +0200
Message-ID: <200807070116.39892.robin.rosenberg.lists@dewire.com>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "'Marek Zawirski'" <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "'Shawn O. Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 01:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFdYo-0007Mn-0z
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 01:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815AbYGFXV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 19:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756941AbYGFXV2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 19:21:28 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:58325 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYGFXV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 19:21:28 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 7BB5637F37; Mon,  7 Jul 2008 01:21:26 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 48F7F37EBB; Mon,  7 Jul 2008 01:21:26 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 1C46D37E44;
	Mon,  7 Jul 2008 01:21:25 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200807070041.35873.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87565>


This command allows us to create simple or annotated tags.
PGP signed tags are not yet supported.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java |  102 ++++++++++++++++++++
 1 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java

An obvious omission was not to allow the user to tag anything but HEAD.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
new file mode 100644
index 0000000..110db6b
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Tag.java
@@ -0,0 +1,102 @@
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
+		String ref = "HEAD";
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
+			if (i == args.length - 2) {
+				tagName = args[i];
+				ref = args[i+1];
+				++i;
+				continue;
+			}
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
+		tag.setObjId(db.resolve(ref));
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
+		throw die("Usage: -m message tag [head]");
+	}
+}
-- 
1.5.6.2.220.g44701
