From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/5] Expose the critical receive configuration options to JGit
Date: Tue, 30 Sep 2008 18:31:29 -0700
Message-ID: <1222824690-7632-5-git-send-email-spearce@spearce.org>
References: <1222824690-7632-1-git-send-email-spearce@spearce.org>
 <1222824690-7632-2-git-send-email-spearce@spearce.org>
 <1222824690-7632-3-git-send-email-spearce@spearce.org>
 <1222824690-7632-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 03:33:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkqan-0006Nd-3b
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 03:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbYJABbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 21:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbYJABbm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 21:31:42 -0400
Received: from george.spearce.org ([209.20.77.23]:51633 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbYJABbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 21:31:36 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7353F38368; Wed,  1 Oct 2008 01:31:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 216603835F;
	Wed,  1 Oct 2008 01:31:32 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.569.g798a2a
In-Reply-To: <1222824690-7632-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97182>

The TransferConfig object keeps track of basic transfer related options
from the transfer, receive and fetch groups within a git config file.

Right now we only care about receive.fsckobjects.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   10 ++++
 .../src/org/spearce/jgit/lib/TransferConfig.java   |   56 ++++++++++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index d3c29ac..d8fd2fa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -92,6 +92,8 @@ public static RepositoryConfig openUserConfig() {
 
 	private CoreConfig core;
 
+	private TransferConfig transfer;
+
 	private List<Entry> entries;
 
 	private Map<String, Object> byName;
@@ -126,6 +128,13 @@ public CoreConfig getCore() {
 	}
 
 	/**
+	 * @return transfer, fetch and receive configuration values
+	 */
+	public TransferConfig getTransfer() {
+		return transfer;
+	}
+
+	/**
 	 * Obtain an integer value from the configuration.
 	 *
 	 * @param section
@@ -667,6 +676,7 @@ public void load() throws IOException {
 		}
 
 		core = new CoreConfig(this);
+		transfer = new TransferConfig(this);
 	}
 
 	private void clear() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java
new file mode 100644
index 0000000..ff3a5eb
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TransferConfig.java
@@ -0,0 +1,56 @@
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
+package org.spearce.jgit.lib;
+
+/**
+ * The standard "transfer", "fetch" and "receive" configuration parameters.
+ */
+public class TransferConfig {
+	private final boolean fsckObjects;
+
+	TransferConfig(final RepositoryConfig rc) {
+		fsckObjects = rc.getBoolean("receive", "fsckobjects", false);
+	}
+
+	/**
+	 * @return strictly verify received objects?
+	 */
+	public boolean isFsckObjects() {
+		return fsckObjects;
+	}
+}
-- 
1.6.0.2.569.g798a2a
